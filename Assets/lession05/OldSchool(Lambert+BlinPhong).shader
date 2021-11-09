Shader "Unlit/OldSchool"
{
    Properties
    {
        //暴露在外边的可以调节的属性名字 一定要按照这个格式进行书写
        //{属性名字}({"暴露在材质球的名字"},{属性的类型}) = {这个类型的属性的默认值}

        //属性名字 _MainColor（必须下划线起手）
        //属性在外边的名字 "漫反射的颜色"
        //属性种类 color 
        //数值初始值 (1.0,1.0,1.0,1.0)
        _MainColor("漫反射的颜色",color) = (1.0,1.0,1.0,1.0)

        //range:暴露在Inspector中的形式是slider
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

            //变量格式： 修饰符（可以省略）+ 变量类型 + 变量名称
            //c#:           private Vector3 mainColor;
            //shaderlab:    uniform float3 _MainColor;

            //修饰符：写不写无所谓
            //uniform attribute varying            

            //变量在代码里的类型
            //float float2 float3 half 类型只有这几种

            //上边定义的属性在下边声明 一般写在  #pragma target 3.0 之后 保证变量名字上下一致！

            /// 漫反射颜色
            uniform float3 _LightColor;

            ///phong强度
            uniform float _SpecularPower;

            /*  https://gameinstitute.qq.com/community/detail/128000
                模型→顶点着色器常用语义
                POSITION ：顶点位置
                NORMAL：顶点法线
                TANGENT：顶点切线
                TEXCOORD0-TEXCOORDn（Unity内置结构好像支持到6）：顶点纹理坐标
                COLOR：顶点颜色
             */
            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入到输入结构体中
                float4 normal : NORMAL; //将模型的法线信息获取到输入结构体中
            };

            /*
                顶点着色器→片段着色器
                SV_POSITION：裁剪空间中的顶点坐标  
                COLOR0：顶点颜色  
                COLOR1：顶点颜色  
                TEXCOORDn：纹理坐标 
            */
            // 输出结构
            struct VertexOutput
            {
                float4 posCS : SV_POSITION; // posCS （其次裁剪空间的位置） 输出到 SV_POSITION这个语义中
                float4 posWS : TEXTCOORD0; //输出到物体的纹理坐标0上
                float3 nDirWS: TEXTOORD1; //输出到物体的纹理坐标1上
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                // 新建一个输出结构的结构体 C#:VertexOutput vertex_output = new VertexOutput();
                VertexOutput vertex_output = (VertexOutput)0;
                // 变换顶点信息 OS=>CS 输出其次裁剪空间下的坐标（参数：物体空间下的坐标点）
                vertex_output.posCS = UnityObjectToClipPos(v.vertex);
                //变换定点位置 OS=>WS 将定点由模型空间变换到世界空间
                vertex_output.posWS = mul(unity_ObjectToWorld, v.vertex);
                //变换法线信息 OS=>WS 将物体空间下的法线值变换到世界空间
                vertex_output.nDirWS = UnityObjectToWorldNormal(v.normal);

                return vertex_output; // return 输出结构
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput vertex_output) : COLOR
            {
                //准备向量：因为我们要做的是lambert和phong
                //[LAMBERT] 需要的是lightDir,normalDir,
                //[PHONG] 需要的 viewDir，hdir(半角方向：ldir和vdir的中间角方向)

                //直接在顶点的输入结构中取到 法线向量
                float3 nDir = vertex_output.nDirWS;
                //光照方向 固定这么取得值
                float3 lDir = _WorldSpaceLightPos0;
                //vdir:使用摄像机的位置减去世界坐标下的pos 的归一化
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - vertex_output.posWS);
                //hdir ldir和vdir加起来的归一化
                float3 hDir = normalize(vDir + lDir);

                //准备点乘结果
                float nDotl = dot(nDir, lDir);//lambert需要的点乘
                float nDoth = dot(nDir, hDir);//phong需要的点乘

                //光照模型
                float lambert = max(0, nDotl);
                float blinPhong = pow(max(0, nDoth), _SpecularPower);

                //最终效果
                float3 finalRGB = _LightColor * lambert + blinPhong;
                return float4(finalRGB, 1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}