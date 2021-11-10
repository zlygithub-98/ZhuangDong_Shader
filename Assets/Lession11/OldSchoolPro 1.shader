Shader "Unlit/OldSchoolPro3"
{
    Properties
    {
        [Header(Textures)]
        [HDR]
        _MainTexture("RGB 基础颜色贴图，A:AOmask",2d)="white"{}
        [Normal]
        _NormalTexture("法线贴图",2d)="bump"{}
        [NoScaleOffset]
        _SpecTexture("高光颜色 夹带 高光次幂mask",2d)="gray"{}
        _EmitTexture("自发光颜色贴图",2d)="white"{}
        _Cubemap("镜面反射的球的cubemap",cube)="_Skybox"{}

        [Header(Diffuse)]

        _LightColor("光的颜色",color)=(0.5,0.5,0.5,1.0)
        _EnvDiffIntensity("环境反射强度",Range(0,1))=0.2
        _EnvUpColor("上方颜色",cOLOR)=(1.0,1.0,1.0,1.0)
        _EnvMiddleColor("上方颜色",cOLOR)=(0.5,0.5,0.5,1.0)
        _EnvDownColor("上方颜色",cOLOR)=(0.0,0.0,0.0,0.0)

        [Header(Specular)]

        _SpecularPower("Phong的高光次幂",Range(1,90))=30
        _EnvSpecIntensity("环境镜面反射强度",RANGE(0,5))=0.2
        _FresnelPower("Fresnel次幂",Range(0,7))=1
        _CubeMapMip("cubemap的mipmap等级",Range(0,7))=0

        [Header(Emission)]

        _EmissionIntensity("自发光强度",Range(1,10))=1

    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        Pass
        {
            Name "FORWARD"
            Tags
            {
                "LightMode"="ForwardBase"
            }


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            // 追加投影相关包含文件
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTexture; //漫反射颜色
            uniform sampler2D _NormalTexture; //法线贴图
            uniform sampler2D _SpecTexture; //高光颜色贴图
            uniform sampler2D _EmitTexture; //自发光贴图
            uniform samplerCUBE _Cubemap; //镜面反射cubemap

            uniform float3 _LightColor; //漫反射颜色（光照颜色）
            uniform float _EnvDiffIntensity; //漫反射强度
            uniform float3 _EnvUpColor; //漫反射 上方颜色
            uniform float3 _EnvMiddleColor; //漫反射 中间颜色
            uniform float3 _EnvDownColor; //漫反射 下边颜色

            uniform float _SpecularPower; //镜面反射（冯）高光次幂
            uniform float _EnvSpecIntensity; //镜面反射强度
            uniform float _FresnelPower; //菲尼尔强度
            uniform float _CubeMapMip; //cubemap的mipmap等级

            uniform float _EmissionIntensity; //自发光强度


            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; //POSITION语义：模型的定点位置 支持类型：float3 flaot4
                float2 uv0:TEXCOORD0; //TEXCOORD0：UV通道1 支持类型 float2 float3 float4
                float2 uv1:TEXCOORD1;
                float3 normal:NORMAL; //法线方向 float3
                float4 tangent:TANGENT; //切线方向 float4
                float4 color:COLOR; //定点色 float4
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 其次裁剪空间的屏幕顶点位置
                float2 uv0:TEXCOORD0; //一般纹理UV
                float2 uv1:TEXCOORD1; //LighmapUV
                float4 posWS:TEXCOORD2; //世界空间的定点位置
                float3 nDirWS:TEXCOORD3; //世界空间的法线方向
                float3 tDirWS:TEXCOORD4; //世界空间的切线方向
                float3 bDirWS:TEXCOORD5; //世界空间的副切线方向
                fixed4 color:TEXCOORD6; //顶点色
                LIGHTING_COORDS(5, 6)
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0; //o.uv0 = v.uv0 * unity_LightmapST.xy + unity_LightmapST.zw;
                o.uv1 = v.uv1; //o.uv1 = v.uv1 * unity_LightmapST.xy + unity_LightmapST.zw;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w); // 副切线方向
                o.color=v.color;
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                //1准备向量
                float3 lDirWS = _WorldSpaceLightPos0.xyz;

                //为了准备法线 先构造tbn矩阵
                float3 nDirTS = UnpackNormal(tex2D(_NormalTexture, o.uv0)).rgb;
                float3x3 TBN = float3x3(o.tDirWS, o.bDirWS, o.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));

                //准备phong的vrdir
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - o.posWS);

                //cubemap采样用到的观察方向的反向子在法线上的反射
                float3 vrDirWS = reflect(-vDirWS, nDirWS);

                //光的反方向沿着法线反射 菲尼尔用到
                float3 lrDirWS = reflect(-lDirWS, nDirWS);

                //2准备dot结果

                float nDotl = dot(nDirWS, lDirWS); //lambert
                float vDotLr = dot(vDirWS, lrDirWS); //fresnel
                float vDotn = dot(vDirWS, nDirWS); //phong

                //3采样纹理

                float4 var_MainTex = tex2D(_MainTexture, o.uv0);
                float4 var_SpecTex = tex2D(_SpecTexture, o.uv0);
                float3 var_EmissTex = tex2D(_EmitTexture, o.uv0).rgb;
                float lerpValue = lerp(_CubeMapMip, 0.0, var_SpecTex.a); //我们把mipmap存储到了高光贴图的a通道中
                float3 var_CubeMap = texCUBElod(_Cubemap, float4(vrDirWS, lerpValue)).rgb;

                //4光照模型
                float3 baseCol = var_MainTex.rgb * _LightColor;
                float lambert = max(0, nDotl);

                float specColor = var_SpecTex.rgb;
                float specPow = lerp(1, _SpecularPower, var_SpecTex.a);
                float phong = pow(max(0, vDotLr), specPow);

                float shadowMask = LIGHT_ATTENUATION(o);

                float3 dirLighting = (baseCol * lambert + specColor * phong) * _LightColor0 * shadowMask;

                //4.1环境光部分
                float upMask = max(0, nDirWS.g);
                float downMask = max(0, -nDirWS.g);
                float middleMask = 1 - upMask - downMask;
                float3 envColor = _EnvUpColor * upMask + _EnvDownColor * downMask + _EnvMiddleColor * middleMask;

                float fresnel = pow(max(0, 1 - vDotn), _FresnelPower);
                float ao = var_MainTex.a;

                //环境光中漫反射部分
                float3 envDiff = baseCol * envColor * _EnvDiffIntensity;
                //环境光的镜面反射部分
                float3 envMirror = var_CubeMap * fresnel * _EnvSpecIntensity * var_SpecTex.a;
                float3 envLighting = (envDiff + envMirror) * ao;

                //4.2自发光部分
                float emitIntensity = _EmissionIntensity * (sin(frac(_Time.z)) * 0.5 + 0.5);
                float3 emission = var_EmissTex * emitIntensity;

                //5 最终结果
                float3 finalRGB = dirLighting + envLighting + emission;
                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}