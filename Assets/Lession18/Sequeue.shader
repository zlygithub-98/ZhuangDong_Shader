Shader "Unlit/Sequeue"
{
    Properties
    {
        _MainTex("",2d)="white"{}
        _Sequeue("序列帧",2d)="white"{}
        _RowCount("行数",int)=3
        _ColCount("列数",int)=4

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
            Name "FORWARD_AB"
            Tags
            {
                "LightMode"="ForwardBase"//buildin不用管 urp可能改 延迟渲染什么的东西
            }
            Blend One OneMinusSrcAlpha

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
        //第二个pass删除的话 会删除ad只剩下ab 会变暗
        Pass
        {
            Name "FORWARD_AD"
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
            uniform sampler2D _Sequeue;
            uniform float4 _Sequeue_ST;
            uniform half _RowCount;
            uniform half _ColCount;


            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float3 normal:NORMAL;
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
                v.vertex.xyz += v.normal * 0.1; //定点沿着法线方向外扩0.1的效果 外边大一圈
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv0 = TRANSFORM_TEX(v.uv0, _Sequeue);
                float _SeqId = floor(_Time.z * 10);
                float idv = floor(_SeqId / _ColCount); //向下取整
                float idu = _SeqId - idv * _ColCount;
                float stepU = 1.0 / _ColCount;
                float stepV = 1.0 / _RowCount;
                float2 initUV = o.uv0 * float2(stepU, stepV) + float2(0, stepU * _RowCount - 1);
                o.uv0 = initUV + float2(-idu * stepU, idu * stepV);

                return o;
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                half4 var_MainTex = tex2D(_Sequeue, o.uv0);
                return half4(var_MainTex.rgb * var_MainTex.a, var_MainTex.a);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}