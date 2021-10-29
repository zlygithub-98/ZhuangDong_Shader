Shader "Unlit/3ColorAmbient"
{
    Properties
    {
        _UpColor ("顶部颜色" ,color) = (1.0,0.0,0.0,1.0)
        _MiddleColor("中间颜色" ,color) = (0.0,1.0,0.0,1.0)
        _DownColor ("底部颜色" ,color) = (0.0,0.0,1.0,1.0)

        //2d纹理在Properties中声明 类型是 【2d】 默认值为 【"white"{}】
        _AOTexture ("AO贴图",2d) = "white"{}
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform float3 _UpColor;
            uniform float3 _MiddleColor;
            uniform float3 _DownColor;
            //2d纹理的类型在代码中使用 sampler2D 
            uniform sampler2D _AOTexture;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv0:TEXCOORD0;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION;
                float3 nDirWS:TEXTOORD0;
                float2 uv1:TEXCOORD1;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput vertex_output = (VertexOutput)0;
                vertex_output.pos = UnityObjectToClipPos(v.vertex);
                vertex_output.nDirWS = UnityObjectToWorldNormal(v.normal);
                vertex_output.uv1 = v.uv0;
                return vertex_output;
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                float3 nDirWS = o.nDirWS;
                float UpMask = max(0, nDirWS.g);
                float downMask = max(0, -nDirWS.g);
                float sideMask = 1 - UpMask - downMask;
                float3 envColor = UpMask * _UpColor + downMask * _DownColor + sideMask * _MiddleColor;

                //采样AO纹理 使用tex2D方法 传递采样纹理当作第一个参数，uv当作第二个参数
                float occlusion = tex2D(_AOTexture, o.uv1);
                float3 envLighting = occlusion * envColor;

                return float4(envLighting, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}