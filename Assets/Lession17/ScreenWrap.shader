Shader "Custom/ScreenWrap"
{
    Properties
    {
        _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
        _Opacity ("透明度", range(0, 1)) = 0.5
        _WarpMidVal ("扰动中间值", range(0, 1)) = 0.5
        _WarpInt ("扰动强度", range(0, 5)) = 1
    }
    SubShader
    {
        Tags
        {
            "Queue"="Transparent" // 调整渲染顺序
            "RenderType"="Transparent" // 对应改为Cutout
            "ForceNoShadowCasting"="True" // 关闭阴影投射
            "IgnoreProjector"="True" // 不响应投射器
        }
        GrabPass
        {
            "_BGTex" // 获取背景纹理
        }
        Pass
        {
            Name "FORWARD"
            Tags
            {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcAlpha // 修改混合方式One/SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            // 输入参数
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform half _Opacity;
            uniform float _WarpMidVal;
            uniform float _WarpInt;
            uniform sampler2D _BGTex; //生成的背景纹理

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 顶点位置 总是必要
                float2 uv : TEXCOORD0; // UV信息 采样贴图用
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 grabPos : TEXCOORD1; // 背景纹理采样坐标
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos(v.vertex); // 顶点位置 OS>CS
                o.uv = v.uv;
                o.grabPos = ComputeScreenPos(o.pos); //黑盒
                return o;
            }

            // 输出结构>>>像素
            half4 frag(VertexOutput i) : COLOR
            {
                //采样基本纹理
                half4 var_MainTex = tex2D(_MainTex, i.uv); // 采样贴图 RGB颜色 A透贴

                //使uv进行扰动
                i.grabPos.xy += (var_MainTex.b - _WarpMidVal) * _WarpInt * _Opacity;
                //扰动之后的uv采样他的bg
                half4 var_BGTex = tex2D(_BGTex, i.grabPos);
                //return var_BGTex;//直接return是显示背景 并不是透明

                half3 finalRGB = lerp(1.0, var_MainTex.rgb, _Opacity) * var_BGTex.xyz;
                half opacity = var_MainTex.a;
                return half4(finalRGB.xyz * opacity, opacity); // 返回值
            }
            ENDCG
        }
    }
}