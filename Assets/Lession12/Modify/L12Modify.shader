Shader "Unlit/L12Modify"
{
    Properties
    {
         [Header(Texture)]
        _MainTex        ("RGB:颜色 A:透贴", 2d) = "white"{}
        _MaskTex        ("Mask贴图。R:高光强度mask G:边缘光强度mask B:高光染色mask A:高光次幂mask", 2d) = "black"{}
        _NormTex        ("法线贴图", 2d) = "bump"{}
        _MatelnessMask  ("金属度遮罩", 2d) = "black"{}
        _EmissionMask   ("自发光遮罩", 2d) = "black"{}
        _DiffWarpTex    ("颜色Warp图", 2d) = "gray"{}
        _FresWarpTex    ("菲涅尔Warp图", 2d) = "gray"{}
        _Cubemap        ("环境球", cube) = "_Skybox"{}
        [Header(DirDiff)]
        _LightCol       ("光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(DirSpec)]
        _SpecPow        ("高光次幂", range(0.0, 99.0)) = 5
        _SpecInt        ("高光强度", range(0.0, 10.0)) = 5
        [Header(EnvDiff)]
        _EnvCol         ("环境光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(EnvSpec)]
        _EnvSpecInt     ("环境镜面反射强度", range(0.0, 30.0)) = 0.5
        [Header(RimLight)]
        [HDR]_RimCol    ("轮廓光颜色", color) = (1.0, 1.0, 1.0, 1.0)
        [Header(Emission)]
        _EmitInt        ("自发光强度", range(0.0, 10.0)) = 1.0
        [HideInInspector]
        _Cutoff         ("Alpha cutoff", Range(0,1)) = 0.5
        [HideInInspector]
        _Color          ("Main Color", Color) = (1.0, 1.0, 1.0, 1.0)
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
            // 输入结构
            struct VertexInput
            {
             
            };

            // 输出结构
            struct VertexOutput
            {
              
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput i)
            {
             
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                return float4(1,1,1,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}