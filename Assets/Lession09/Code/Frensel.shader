Shader "Unlit/Frensel"
{
    Properties
    {
        _FrensnelPower("FrenselPower",Range(0,7))=1
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

            uniform float _FrensnelPower;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float4 normal : NORMAL;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION;
                float3 nDirWS:TEXTOORD0;
                float3 posWorld:TEXCOORD2;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal); //unity声明的方法：物体坐标变换为世界空间坐标
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                float3 nDirWS = normalize(o.nDirWS);
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - o.posWorld.xyz);
                float nDotV = dot(nDirWS, vDir);
                float frensnel = 1.0 - nDotV;
                float finalRGB = frensnel = pow(frensnel, _FrensnelPower);
                return finalRGB;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}