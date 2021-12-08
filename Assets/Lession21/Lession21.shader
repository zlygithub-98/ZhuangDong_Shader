Shader "Unlit/Lession21"
{

    Properties
    {
        [Header(Texture)]
        _MainTex ("RGB:基础颜色 A:环境遮罩", 2D) = "white" {}
        [Normal] _NormTex ("RGB:法线贴图", 2D) = "bump" {}
        _SpecTex ("RGB:高光颜色 A:高光次幂", 2D) = "gray" {}
        _EmitTex ("RGB:环境贴图", 2d) = "black" {}
        _Cubemap ("RGB:环境贴图", cube) = "_Skybox" {}
        [Header(Diffuse)]
        _MainCol ("基本色", Color) = (0.5, 0.5, 0.5, 1.0)
        _EnvDiffInt ("环境漫反射强度", Range(0, 1)) = 0.2
        _EnvUpCol ("环境天顶颜色", Color) = (1.0, 1.0, 1.0, 1.0)
        _EnvSideCol ("环境水平颜色", Color) = (0.5, 0.5, 0.5, 1.0)
        _EnvDownCol ("环境地表颜色", Color) = (0.0, 0.0, 0.0, 0.0)
        [Header(Specular)]
        [PowerSlider(2)] _SpecPow ("高光次幂", Range(1, 90)) = 30
        _EnvSpecInt ("环境镜面反射强度", Range(0, 5)) = 0.2
        _FresnelPow ("菲涅尔次幂", Range(0, 5)) = 1
        _CubemapMip ("环境球Mip", Range(0, 7)) = 0
        [Header(Emission)]
        [HideInInspect] _EmitInt ("自发光强度", range(1, 10)) = 1
        [Header(Effect)]
        _EffMap01 ("特效纹理1", 2D) = "gray" {}
        _EffMap02 ("特效纹理2", 2D) = "gray" {}
        [HDR] _EffCol ("光效颜色", color) = (0.0, 0.0, 0.0, 0.0)
        _EffParams ("X:波密度 Y:波速度 Z:混乱度 W:消散强度", vector) = (0.03, 3.0, 0.3, 2.5)

    }
    SubShader
    {
        Tags
        {
            //2 修改 RenderType Queue
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass
        {
            Name "FORWARD"
            Tags
            {
                "LightMode"="ForwardBase"
            }
            //3 给混合模式 给透明度话就得给混合模式 不然他不知道是什么
            Blend One OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            // 追加投影相关包含文件
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTex; //漫反射颜色
            uniform sampler2D _NormTex; //法线贴图
            uniform sampler2D _SpecTex; //高光颜色贴图
            uniform sampler2D _EmitTex; //自发光贴图
            uniform samplerCUBE _Cubemap; //镜面反射cubemap

            uniform float3 _MainCol; //漫反射颜色（光照颜色）
            uniform float _EnvDiffInt; //漫反射强度
            uniform float3 _EnvUpCol; //漫反射 上方颜色
            uniform float3 _EnvSideCol; //漫反射 中间颜色
            uniform float3 _EnvDownCol; //漫反射 下边颜色

            uniform float _SpecPow; //镜面反射（冯）高光次幂
            uniform float _EnvSpecInt; //镜面反射强度
            uniform float _FresnelPow; //菲尼尔强度
            uniform float _CubemapMip; //cubemap的mipmap等级

            uniform float _EmitInt; //自发光强度


            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float2 uv:TEXCOORD0;
                float3 normal:NORMAL; //物体空间的法线信息
                float4 tangent:TANGENT;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 屏幕顶点位置
                float2 uv:TEXCOORD0;
                float4 posWS:TEXCOORD1;
                float3 nDirWS:TEXCOORD2; //世界空间的法线信息
                float3 tDirWS:TEXCOORD3;
                float3 bDirWS:TEXCOORD4;
                LIGHTING_COORDS(5, 6)
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w); // 副切线方向
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                //1准备向量
                float3 lDirWS = _WorldSpaceLightPos0.xyz;

                //为了准备法线 先构造tbn矩阵
                float3 nDirTS = UnpackNormal(tex2D(_NormTex, o.uv)).rgb;
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

                float4 var_MainTex = tex2D(_MainTex, o.uv);
                float4 var_SpecTex = tex2D(_SpecTex, o.uv);
                float3 var_EmissTex = tex2D(_EmitTex, o.uv).rgb;
                float lerpValue = lerp(_CubemapMip, 0.0, var_SpecTex.a); //我们把mipmap存储到了高光贴图的a通道中
                float3 var_CubeMap = texCUBElod(_Cubemap, float4(vrDirWS, lerpValue)).rgb;

                //4光照模型
                float3 baseCol = var_MainTex.rgb * _MainCol;
                float lambert = max(0, nDotl);

                float specColor = var_SpecTex.rgb;
                float specPow = lerp(1, _SpecPow, var_SpecTex.a);
                float phong = pow(max(0, vDotLr), specPow);

                float shadowMask = LIGHT_ATTENUATION(o);

                float3 dirLighting = (baseCol * lambert + specColor * phong) * _LightColor0 * shadowMask;

                //4.1环境光部分
                float upMask = max(0, nDirWS.g);
                float downMask = max(0, -nDirWS.g);
                float middleMask = 1 - upMask - downMask;
                float3 envColor = _EnvUpCol * upMask + _EnvDownCol * downMask + _EnvSideCol * middleMask;

                float fresnel = pow(max(0, 1 - vDotn), _FresnelPow);
                float ao = var_MainTex.a;

                //环境光中漫反射部分
                float3 envDiff = baseCol * envColor * _EnvDiffInt;
                //环境光的镜面反射部分
                float3 envMirror = var_CubeMap * fresnel * _EnvSpecInt * var_SpecTex.a;
                float3 envLighting = (envDiff + envMirror) * ao;

                //4.2自发光部分
                float emitIntensity = _EmitInt * (sin(frac(_Time.z)) * 0.5 + 0.5);
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