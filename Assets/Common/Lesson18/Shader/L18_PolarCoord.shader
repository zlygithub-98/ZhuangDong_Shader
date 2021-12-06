Shader "AP01/L18/PolarCoord"
{
    Properties
    {
        _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
        [HDR] _Color ("混合颜色", color) = (1.0, 1.0, 1.0, 1.0)
        _Opacity ("透明度", range(0, 1)) = 0.5

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
        Pass
        {
            Name "FORWARD"
            Tags
            {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcAlpha // 修改混合方式

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            // 输入参数
            uniform sampler2D _MainTex;
            uniform half _Opacity;
            uniform half3 _Color;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 顶点位置 总是必要
                float2 uv : TEXCOORD0; // UV信息 采样贴图用
                float4 color : COLOR;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 顶点位置 总是必要
                float2 uv : TEXCOORD0; // UV信息 采样贴图用
                float4 color : COLOR;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos(v.vertex); // 顶点位置 OS>CS
                o.uv = v.uv; // UV信息 支持TilingOffset
                o.color = v.color;
                return o;
            }

            // 直角坐标转极坐标方法
            float2 RectToPolar(float2 uv, float2 centerUV)
            {
                uv = uv - centerUV;
                float theta = atan2(uv.y, uv.x); // atan()值域[-π/2, π/2]一般不用; atan2()值域[-π, π] //先计算出正切值 然后获得角度
                float r = length(uv);
                return float2(theta, r);
            }

            // 输出结构>>>像素
            half4 frag(VertexOutput i) : COLOR
            {
                i.uv = i.uv - float2(0.5, 0.5); //将左下角那个点 转移到中心点 （感觉应该是+0.5 但代码只能写-0.5）也就是转化为笛卡尔坐标系
                float theta = atan2(i.uv.y, i.uv.x); //使用当前的x，y计算出 正切值，从而通过正切值获得角度 （正切算完之后是[-π, π]）                
                theta = theta / 3.1415923 * 0.5 + 0.5; // 将[-π, π】的正切值 映射到[0, 1]
                float r = length(i.uv) + frac(_Time.x * 3); //length(v)：返回一个向量的模，即 sqrt(dot(v,v))  这里加了个time 使得v轴随着时间改变
                i.uv = float2(theta, r); //使用正切函数的值当作x 使用当前点的坐标的长度当作y 构建uv 其中y随着时间改变
                half4 var_MainTex = tex2D(_MainTex, i.uv); //采样
                half3 finalRGB = (1 - var_MainTex.rgb) * _Color; // 因为是灰度图 所以乘以自定义的颜色
                half opacity = (1 - var_MainTex.r) * i.color.r; //使用定点色做渐变 保证渐变出来渐隐消失
                return half4(finalRGB * opacity, opacity);
            }
            ENDCG
        }
    }
}