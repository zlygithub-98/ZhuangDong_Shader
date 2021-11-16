Shader "Unlit/L12Modify"
{
    Properties
    {
        [Header(Texture)]
        _MainTex ("RGB:颜色 A:透贴", 2d) = "white"{}
        _MaskTex ("Mask贴图。R:高光强度mask G:边缘光强度mask B:高光染色mask A:高光次幂mask", 2d) = "black"{}
        _NormTex ("法线贴图", 2d) = "bump"{}
        _MatelnessMask ("金属度遮罩", 2d) = "black"{}
        _EmissionMask ("自发光遮罩", 2d) = "black"{}
        _DiffWarpTex ("颜色Warp图", 2d) = "gray"{}
        _FresWarpTex ("菲涅尔Warp图", 2d) = "gray"{}
        _Cubemap ("环境球", cube) = "_Skybox"{}
        [Header(DirDiff)]
        _LightCol ("光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(DirSpec)]
        _SpecPow ("高光次幂", range(0.0, 99.0)) = 5
        _SpecInt ("高光强度", range(0.0, 10.0)) = 5
        [Header(EnvDiff)]
        _EnvCol ("环境光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(EnvSpec)]
        _EnvSpecInt ("环境镜面反射强度", range(0.0, 30.0)) = 0.5
        [Header(RimLight)]
        [HDR]_RimCol ("轮廓光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(Emission)]
        _EmitInt ("自发光强度", range(0.0, 10.0)) = 1.0
        [HideInInspector]
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        [HideInInspector]
        _Color ("Main Color", Color) = (1.0, 1.0, 1.0, 1.0)
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
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            // 输入参数
            uniform sampler2D _MainTex;
            uniform sampler2D _MaskTex;
            uniform sampler2D _NormTex;
            uniform sampler2D _MatelnessMask;
            uniform sampler2D _EmissionMask;
            uniform sampler2D _DiffWarpTex;
            uniform sampler2D _FresWarpTex;
            uniform samplerCUBE _Cubemap;
            // DirDiff
            uniform half3 _LightCol;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; //POSITION：模型的顶点位置 支持类型：float3 flaot4
                float2 uv0: TEXCOORD0; //TEXCOORD0：UV通道1 支持类型 float2 float3 float4
                float2 uv1: TEXCOORD1; //TEXCOORD1：UV通道2 支持类型 float2 float3 float4
                float3 normal: NORMAL; //NORMAL：法线方向 float3
                float4 tangent: TANGENT; //TANGENT：切线方向 float4
                float4 color: COLOR; //COLOR：顶点色 float4
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; //其次裁剪空间的屏幕顶点位置
                float2 uv0: TEXCOORD0; //一般纹理UV
                float2 uv1: TEXCOORD1; //LighmapUV
                float4 posWS: TEXCOORD2; //世界空间的顶点位置
                float3 nDirWS: TEXCOORD3; //世界空间的法线方向
                float3 tDirWS: TEXCOORD4; //世界空间的切线方向
                float3 bDirWS: TEXCOORD5; //世界空间的副切线方向
                fixed4 color: TEXCOORD6; //顶点色
                LIGHTING_COORDS(7, 8) //投影
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0; //o.uv0 = v.uv0 * unity_LightmapST.xy + unity_LightmapST.zw;//uv如果使用titling/offset的话这样写
                o.uv1 = v.uv1; //o.uv1 = v.uv1 * unity_LightmapST.xy + unity_LightmapST.zw;//uv1同理
                o.posWS = mul(unity_ObjectToWorld, v.vertex); //得到世界空间位置
                o.nDirWS = UnityObjectToWorldNormal(v.normal); //得到世界空间法线方向
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); //得到世界空间切线方向 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w); //得到世界空间副切线方向
                o.color = v.color;
                TRANSFER_VERTEX_TO_FRAGMENT(o) //投影
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput i) : COLOR
            {
                //准备ndirws
                half3 nDirTS = UnpackNormal(tex2D(_NormTex, i.uv0));
                half3x3 TBN = half3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                half3 nDirWS = normalize(mul(nDirTS, TBN));

                half3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS);
                half3 vrDirWS = reflect(-vDirWS, nDirWS);

                half3 lDirWS = _WorldSpaceLightPos0.xyz;
                half3 lrDirWS = reflect(-lDirWS, nDirWS);

                //中间量准备
                half nDotl = dot(nDirWS, lDirWS); //兰伯特
                half nDotv = dot(nDirWS, vDirWS); //菲涅尔
                half vDotlr = dot(vDirWS, lrDirWS); //冯

                //纹理采样
                half4 var_MainTex = tex2D(_MainTex, i.uv0);
                half4 var_MaskTex = tex2D(_MaskTex, i.uv0);
                half var_MatelnessMask = tex2D(_MatelnessMask, i.uv0).r;
                half var_EmissionMask = tex2D(_EmissionMask, i.uv0).r;
                half3 var_FresWarpTex = tex2D(_FresWarpTex, nDotv).rgb;
                half3 var_Cubemap = texCUBElod(_Cubemap, float4(vDirWS, lerp(8.0, 0.0, var_MaskTex.a))).rgb;

                //提取信息
                half3 baseColor = var_MainTex.rgb; //颜色贴图
                half opacity = var_MainTex.a; //透明贴图
                half specInt = var_MaskTex.r; //镜面反射强度图
                half rimInt = var_MaskTex.g; //轮廓光强度图
                half specTint = var_MaskTex.b; //镜面反射颜色插值图
                half specPow = var_MaskTex.a; //镜面反射 高光次幂
                half matellic = var_MatelnessMask; //金属程度（在插值里用）
                half emitInt = var_EmissionMask; //自发光强度
                half3 envCube = var_Cubemap; //cubemap
                half shadow = LIGHT_ATTENUATION(i); //阴影

                //漫反射颜色：金属度当作参数 对漫反射和白色做插值 这样金属度越高的地方越白（灰）
                half3 diffCol = lerp(baseColor, half3(0.0, 0.0, 0.0), matellic);
                //镜面反射颜色：使用这个图做插值，选择到底是自带颜色还是经验值(0.3)
                half3 specCol = lerp(baseColor, half3(0.3, 0.3, 0.3), specTint) * specInt;

                //使用金属度对菲尼尔贴图做插值
                half3 fresnel = lerp(var_FresWarpTex, 0.0, matellic);
                half fresnelColor = fresnel.r; //官方说罕见使用 这里先不用了
                half fresnelRim = fresnel.g; //轮廓光的菲尼尔
                half fresnelSpec = fresnel.b; //镜面反射的菲尼尔

                //光源漫反射
                half halfLambert = nDotl * 0.5 + 0.5;
                //对漫反射做一次ramptex采样 从原本的半兰伯特光照模型 转换成贴图的颜色映射（0.2是随便给的值）
                half3 var_DiffWarpTex = tex2D(_DiffWarpTex, half2(halfLambert, 0.2));
                half3 dirDiff = diffCol * var_DiffWarpTex * _LightCol;
                //return fresnelColor;
                return float4(dirDiff, 1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}