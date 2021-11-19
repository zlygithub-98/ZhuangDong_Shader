Shader "Unlit/ADEffect"
{
    Properties
    {
        _MainTex("",2d)="white"{}
    }
    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "RenderType"="TransparentCutout" // 对应改为Cutout
            "ForceNoShadowCasting"="True" // 关闭阴影投射
            "IgnoreProjector"="True" // 不响应投射器
        }
        Pass
        {
            Name "FORWARD"
            Tags
            {
                "LightMode"="ForwardBase"
            }
            Blend One One//AD写法 （提亮）

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float2 uv0:TEXCOORD0;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 由模型顶点信息换算而来的顶点屏幕位置
                float2 uv0:TEXTOORD0;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex);
                return o;
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                half4 var_MainTex = tex2D(_MainTex, o.uv0);
                return var_MainTex;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}