Shader "Unlit/oldSchool_Alter"
{
    Properties
    {
        _MainColor("漫反射颜色",color)=(1.0,1.0,1.0,1.0)
        _PhonePower("高光等级",range(0,90))=30
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

            uniform float3 _LightColor;
            uniform float _PhonePower;

            // 输入结构 lambert: normal light phong:view reflect dir light
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float4 normal : NORMAL;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 由模型顶点信息换算而来的顶点屏幕位置
                float3 nDirWS:TEXCOORD0;
                float4 posWS:TEXCOORD1;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput vertex_output = (VertexOutput)0; // 新建一个输出结构
                vertex_output.pos = UnityObjectToClipPos(v.vertex);
                vertex_output.nDirWS = UnityObjectToWorldNormal(v.normal);
                vertex_output.posWS = mul(unity_ObjectToWorld, v.vertex);
                return vertex_output;
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput vertex_output) : COLOR
            {
                //准备阶段
                float3 nDir = vertex_output.nDirWS;
                float3 lDir = _WorldSpaceLightPos0.xyz;
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - vertex_output.posWS.xyz);
                float3 vReflectDir = reflect(-vDir, nDir);

                //光照模型
                float lambert = max(0, dot(nDir, lDir));
                float phong = pow(max(0, dot(lDir, vReflectDir)), _PhonePower);
                //最终输出
                float3 finalColor = _LightColor * lambert + phong;
                return float4(finalColor, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}