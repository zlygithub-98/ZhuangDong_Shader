Shader "Custom/Normal_Code"
{
    Properties
    {
        _NormalMap("法线贴图",2d)="white"{}
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

            uniform sampler2D _NormalMap;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float4 normal : NORMAL;
                float4 tangent:TANGENT;
                float2 uv:TEXCOORD0;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 由模型顶点信息换算而来的顶点屏幕位置
                float3 nDirWS:TEXTOORD0;
                float2 uv:TEXCOORD1;
                float3 tDirWS:TEXCOORD3;
                float3 bDirWS:TEXCOORD4;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o; //= (VertexOutput)0; // 新建一个输出结构
                o.pos = UnityObjectToClipPos(v.vertex); // 变换顶点信息 并将其塞给输出结构
                o.nDirWS = UnityObjectToWorldNormal(v.normal); //unity声明的方法：物体坐标变换为世界空间坐标
                o.uv = v.uv;
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0)).xyz);
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                //lambert光照模型
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap,o.uv)).rgb;
                float3x3 TBN=float3x3 (o.tDirWS,o.bDirWS,o.nDirWS);
                float3 nDirWS=normalize(mul(nDirTS,TBN));
                
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                 // 一般Lambert
                float nDotl = dot(nDirWS, lDir);                  // nDir点积lDir
                float lambert = max(0.0, nDotl);                // 截断负值
                return float4(lambert, lambert, lambert, 1.0);  // 输出最终颜色              
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}