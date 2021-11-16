Shader "Unlit/Lession12_BodyShader"
{
    Properties
    {
        [Header(Textures)]
        _Diffuse("漫反射颜色", 2D) = "white" {}
        _NormalMap("法线贴图",2d)="bump"{}
        _SpecTex("高光贴图",2d)="white"{}
        _CubeMap("cubemap",cube)="_Skybox"{}
        [Header(Diffuse)]
        _EnvDiffInt("环境反射强度",Range(0,1))=0.2
        _EnvUpCol ("环境天顶颜色", Color) = (1.0, 1.0, 1.0, 1.0)
        _EnvSideCol ("环境水平颜色", Color) = (0.5, 0.5, 0.5, 1.0)
        _EnvDownCol ("环境地表颜色", Color) = (0.0, 0.0, 0.0, 1.0)
        [Header(Specular)]
        _SpecPower("高光次幂",Range(1,90))=30
        _EnvSpecInt("镜面反射强度",Range(0,5))=0.2
        _FresnelPower("菲尼尔次幂",Range(0,5))=1
        _CubeMapMip("MipMap",Range(0,6))=1
        [Header(Emission)]
        _EmissionTex("自发光贴图",2d)="white"{}
        _EmitInt("自发光等级",Range(1,10))=1
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
            #pragma target 3.0
            //属性：
            //贴图

            uniform sampler2D _Diffuse; //漫反射贴图
            uniform sampler2D _NormalMap; //法线贴图
            uniform sampler2D _SpecTex; //镜面反射贴图
            uniform samplerCUBE _CubeMap;
            //漫反射相关
            uniform float _EnvDiffInt; //环境光强度
            uniform half3 _EnvUpCol;
            uniform half3 _EnvSideCol;
            uniform half3 _EnvDownCol;

            //镜面反射
            uniform float _SpecPower; //高光次幂
            uniform half _EnvSpecInt; //镜面反射强度
            uniform half _FresnelPower; //菲尼尔强度
            uniform half _CubeMapMip; //mipmap等级
            //自发光
            uniform sampler2D _EmissionTex; //自发光贴图
            uniform float _EmitInt; //自发光强度

            struct VertexInput
            {
                float4 vertex : POSITION; //POSITION：模型的顶点位置 支持类型：float3 flaot4
                float2 uv0: TEXCOORD0; //TEXCOORD0：UV通道1 支持类型 float2 float3 float4
                float3 normal: NORMAL; //NORMAL：法线方向 float3
                float4 tangent: TANGENT; //TANGENT：切线方向 float4
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; //其次裁剪空间的屏幕顶点位置
                float2 uv0: TEXCOORD0; //一般纹理UV
                float4 posWS: TEXCOORD2; //世界空间的顶点位置
                float3 nDirWS: TEXCOORD3; //世界空间的法线方向
                float3 tDirWS: TEXCOORD4; //世界空间的切线方向
                float3 bDirWS: TEXCOORD5; //世界空间的副切线方向
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0; //o.uv0 = v.uv0 * unity_LightmapST.xy + unity_LightmapST.zw;//uv如果使用titling/offset的话这样写
                o.posWS = mul(unity_ObjectToWorld, v.vertex); //得到世界空间位置
                o.nDirWS = UnityObjectToWorldNormal(v.normal); //得到世界空间法线方向
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); //得到世界空间切线方向 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w); //得到世界空间副切线方向
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput i) : COLOR
            {
                //准备向量
                //光
                float3 lDirWS = normalize(_WorldSpaceLightPos0.xyz);
                //法线
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap, i.uv0)).rgb;
                float3x3 TBN = float3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));
                //菲尼尔冯都需要的vrdir
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 vrDirWS = reflect(-vDirWS, nDirWS);

                //点击结果
                float nDotl = dot(nDirWS, lDirWS); //lambert
                float vrDotl = dot(vrDirWS, lDirWS); //phong
                float vDotn = dot(vrDirWS, nDirWS); //fresnel

                //采样纹理

                float4 var_MainTex = tex2D(_Diffuse, i.uv0);
                float4 var_SpecTex = tex2D(_SpecTex, i.uv0);
                float3 var_EmitTex = tex2D(_EmissionTex, i.uv0);
                float3 var_CubeMap = texCUBE(_CubeMap, float4(vrDirWS, lerp(_CubeMapMip, 0.0, var_SpecTex.a)));

                //光照模型(漫反射部分)
                float lambert = max(0, nDotl) * 0.5 + 0.5;
                float3 baseColor = var_MainTex * lambert;

                float phong = pow(max(0, vrDotl), _SpecPower);
                float3 specColor = phong * var_SpecTex * _EnvSpecInt;
                float3 dirLighting = (baseColor + specColor);

                //环境光部分

                float upMask = max(0.0, nDirWS.g); // 获取朝上部分遮罩
                float downMask = max(0.0, -nDirWS.g); // 获取朝下部分遮罩
                float sideMask = 1.0 - upMask - downMask; // 获取侧面部分遮罩
                float3 envCol = _EnvUpCol * upMask +
                    _EnvSideCol * sideMask +
                    _EnvDownCol * downMask; // 混合环境色


                float fresnel = pow(max(0, 1 - vDotn), _FresnelPower);
                float3 envLighting = (baseColor * envCol * _EnvDiffInt + var_CubeMap * fresnel * _EnvSpecInt *
                    var_SpecTex.a);

                //自发光部分
                float3 emisscolor = var_EmitTex * var_MainTex * _EmitInt;
                float3 finalRGB = dirLighting + envLighting + emisscolor;


                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}