Shader "Unlit/OldSchool"
{
    Properties
    {
        //属性名字（必须下划线起手） 属性在外边的名字 属性种类 数值初始值
        _MainColor("漫反射的颜色",color) = (1.0,1.0,1.0,1.0)
        //range:对应shaderforge里边的slider
        _SpecularPower("高光次幂",range(1,90)) = 30
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

            //修饰符：写不写无所谓了
            //uniform  attribute varying            

            //变量在代码里的类型
            //float float2 float3 half 类型只有这几种

            //上边定义的属性在下边声明
            uniform float3 _MainColor;
            uniform float _SpecularPower;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float4 normal : NORMAL;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 posCS : SV_POSITION; // 由模型顶点信息换算而来的顶点屏幕位置
                float4 posWS : TEXTCOORD0;
                float3 nDirWS:TEXTOORD1;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput vertex_output = (VertexOutput)0; // 新建一个输出结构
                vertex_output.posCS = UnityObjectToClipPos(v.vertex); // 变换顶点信息 OS>CS
                vertex_output.posWS = mul(unity_ObjectToWorld, v.vertex); //变换定点位置 OS>WS
                vertex_output.nDirWS = UnityObjectToWorldNormal(v.normal); //OS>WS
                return vertex_output; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput vertex_output) : COLOR
            {
                //准备向量
                float3 nDir = vertex_output.nDirWS; //直接在顶点的输入结构中取到 法线向量
                float3 lDir = _WorldSpaceLightPos0.xyz; //光照方向 固定这么取值
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - vertex_output.posWS);
                float3 hDir = normalize(vDir + lDir);

                //准备点乘结果
                float nDotl = dot(nDir, lDir);
                float nDoth = dot(nDir, hDir);

                //光照模型
                float lambert = max(0, nDotl);
                float blinPhong = pow(max(0, nDoth), _SpecularPower);

                //最终效果
                float3 finalRGB = _MainColor * lambert + blinPhong;
                return float4(finalRGB, 1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}