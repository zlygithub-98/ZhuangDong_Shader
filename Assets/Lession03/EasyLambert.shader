Shader "Shader Forge/EasyLambert"
{
    Properties
    {
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
            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float4 normal : NORMAL;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 由模型顶点信息换算而来的顶点屏幕位置
                float3 nDirWS:TEXTOORD0;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput vertex_output = (VertexOutput)0; // 新建一个输出结构
                vertex_output.pos = UnityObjectToClipPos(v.vertex); // 变换顶点信息 并将其塞给输出结构
                vertex_output.nDirWS = UnityObjectToWorldNormal(v.normal); //unity声明的方法：物体坐标变换为世界空间坐标
                return vertex_output; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput vertex_output) : COLOR
            {
                //lambert光照模型
                float3 nDir = vertex_output.nDirWS;
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float nDotl = dot(nDir, lDir);
                float lambert = max(0.0, nDotl);
                //return float4(lambert,lambert,lambert,lambert);
                float3 color = float3(1, 1, 0);
                lambert = lambert * color;
                float4 l4=float4(lambert,lambert,lambert,lambert);
                return mul(l4,color);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}