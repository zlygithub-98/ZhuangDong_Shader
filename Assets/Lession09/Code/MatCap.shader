Shader "Unlit/MatCap"
{
    Properties
    {
        _NormalMap("法线贴图",2d)="bump"{}
        _MatCapTexture("MatCap贴图",2d)="white"{}

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
            uniform sampler2D _MatCapTexture;

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
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal); //unity声明的方法：物体坐标变换为世界空间坐标
                o.uv = v.uv; //传递uv
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0)).xyz); //固定写法，抄shaderforge即可
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w); //固定写法，抄shaderforge即可
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                //准备：解压法线并且获得世界空间下的法线方向
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap, o.uv)).rgb;
                float3x3 TBN = float3x3(o.tDirWS, o.bDirWS, o.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));

                float3 nDirVS = mul(UNITY_MATRIX_V, nDirWS); //观察空间下的法线
                float2 uv = nDirVS.xy * 0.5 + 0.5;
                float3 matCap = tex2D(_MatCapTexture, uv);
                return float4(matCap, 1.0); //得到matcap采样效果         
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}