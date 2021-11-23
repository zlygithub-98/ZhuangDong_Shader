Shader "Custom/GhostFlow"
{
    Properties
    {
        _MainTex("rbg颜色 a 透贴",2d)="white"{}
        _Opacity("整体透明度",range(0,1))=0.5
        _NoiseTex("噪声图",2d)="gray"{}
        _NoiseInt("噪声强度",range(0,5))=0.5//特效来说 不必拘束与0-1的范围 他可以叠爆
        _FlowSpeed("流动强度",range(0,10))=5
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
            Blend One OneMinusSrcAlpha//传统写法
            //Blend SrcAlpha OneMinusSrcAlpha //预乘写法

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D _MainTex;
            uniform half _Opacity;
            uniform sampler2D _NoiseTex;
            uniform float4 _NoiseTex_ST; //使用到了他的方法 声明这个变量
            uniform half _NoiseInt;
            uniform half _FlowSpeed;

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
                float2 uv0:TEXTOORD0; //采样maintex
                float2 uv1:TEXTOORD1; //采样noisetex
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv0;
                o.uv1 = TRANSFORM_TEX(v.uv0, _NoiseTex);
                o.uv1.y = o.uv1.y + frac(_Time.x * _FlowSpeed); //为了避免时间的全局参数计算浮点数导致错误 这里取余
                return o;
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                half4 var_MainTex = tex2D(_MainTex, o.uv0);
                half var_NoiseTex = tex2D(_NoiseTex, o.uv1);

                half noise = lerp(1.0, var_NoiseTex * 2, _NoiseInt);
                noise=max(0.0,noise);//负数会出现各种颜色的bug
                half opacity = var_MainTex.a * _Opacity * noise;
                //return noise;
                return half4(var_MainTex.rgb * opacity, opacity);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}