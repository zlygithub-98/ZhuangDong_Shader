Shader "Custom/BlendNoise"
{
    Properties
    {
        _Noise1 ("图1", 2d) = "blue"{}
        _Noise2 ("图2", 2d) = "gray"{}
        _Noise1Params ("噪声1 X:大小 Y:流速 Z:强度 W:暂时没意义", vector) = (1.0, 0.2, 0.2, 1.0)
        _Noise2Params ("噪声2 X:大小 Y:流速 Z:强度 W:暂时没意义", vector) = (1.0, 0.2, 0.2, 1.0)
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
            uniform sampler2D _Mask;
            uniform float4 _Mask_ST;
            uniform sampler2D _Noise1;
            uniform sampler2D _Noise2;
            uniform half3 _Noise1Params; //第四个分量没用 所以只要half3就行了
            uniform half3 _Noise2Params;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float2 uv:TEXCOORD0;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 由模型顶点信息换算而来的顶点屏幕位置
                float2 uv0:TEXTOORD0; //uv信息 采样mask
                float2 uv1:TEXTOORD1; //采样 noise1
                float2 uv2:TEXTOORD2; //采样noise2
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv;
                o.uv1 = v.uv * _Noise1Params.x - float2(0, frac(_Time.x * _Noise1Params.y));
                o.uv2 = v.uv * _Noise2Params.x - float2(0, frac(_Time.x * _Noise2Params.y));
                return o;
            }

            //输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                half var_Noise1 = tex2D(_Noise1, o.uv1);
                half var_Noise2 = tex2D(_Noise2, o.uv2);
                half noise = var_Noise1 * _Noise1Params.z + var_Noise2 * _Noise2Params.z;
                return noise;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}