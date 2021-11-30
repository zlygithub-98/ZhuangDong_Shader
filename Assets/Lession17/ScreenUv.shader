Shader "Unlit/ScreenUv"
{
    Properties
    {
        _MainTex("颜色贴图",2d)="white"{}
        _Opacity("整体透明度",range(0,1))=0.5
        _ScreenTex("屏幕纹理",2d)="white"{}
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
            Blend One OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTex;
            uniform half _Opacity;
            uniform sampler2D _ScreenTex;
            uniform float4 _ScreenTex_ST;

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
                float2 screenUV:TEXTOORD1;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0;
                float3 posVS = UnityObjectToViewPos(v.vertex).xyz;
                o.screenUV = posVS.xy / posVS.z;
                float originDist = UnityObjectToViewPos(float3(0, 0, 0)).z;
                o.screenUV *= originDist;
                o.screenUV = o.screenUV * _ScreenTex_ST.xy - frac(_Time.x * _ScreenTex_ST.zw);
                return o;
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                half4 var_MainTex = tex2D(_MainTex, o.uv0);
                half var_ScreenTex = tex2D(_ScreenTex, o.screenUV).r;

                half3 finalRGB = var_MainTex.xyz;
                half opcaity = var_MainTex.a * _Opacity * var_ScreenTex;
                return half4(finalRGB, opcaity); //返回的屏幕坐标采样获得的纹理
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}