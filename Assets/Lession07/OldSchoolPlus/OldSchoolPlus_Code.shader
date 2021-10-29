Shader "Unlit/OldSchoolPlus_Code"
{
    Properties
    {
        _PhongPower("高光强度",range(1,90))=30.0
        _EnvLevel("环境光强度",range(0,1))=0.5

        _BaseColor("物体的颜色",color)=(1.0,1.0,1.0,1.0)
        _UpColor("顶部漫反射颜色",color)=(1.0,0.0,0.0,0.0)
        _SideColor("中间部分反射颜色",color)=(0.0,1.0,0.0,0.0)
        _DownColor("底部漫反射颜色",color)=(0.0,0.0,1.0,0.0)

        _OcculsionMask("AO遮罩贴图",2d)="white"{}

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

            uniform float _PhongPower;
            uniform float _EnvLevel;
            uniform float4 _BaseColor;
            uniform float4 _UpColor;
            uniform float4 _SideColor;
            uniform float4 _DownColor;
            uniform sampler2D _OcculsionMask;


            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float4 normal : NORMAL;
                float2 uv1:TEXCOORD0;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 posCS : SV_POSITION; // 由模型顶点信息换算而来的顶点屏幕位置
                float3 nDirWS:TEXTOORD0;
                float3 posWS:TEXCOORD1;
                float2 uv:TEXCOORD2;
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o = (VertexOutput)0; // 新建一个输出结构
                o.posCS = UnityObjectToClipPos(v.vertex); // 变换顶点信息 并将其塞给输出结构
                o.nDirWS = UnityObjectToWorldNormal(v.normal); //unity声明的方法：物体坐标变换为世界空间坐标
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.uv = v.uv1;
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                //准备阶段   lambert光照模型:ldir ndir phong光照模型：ldir vdir
                float3 nDir = o.nDirWS;
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 vdir = normalize(_WorldSpaceCameraPos - o.posWS);
                float3 vReflectDir = reflect(-vdir, nDir);
                //中间量阶段
                float phong = pow(max(0, dot(lDir, vReflectDir)), _PhongPower);
                //return phong;
                float lambert = max(0, dot(nDir, lDir));

                float3 colorLambert = lambert * _BaseColor;
                colorLambert += phong;

                float upMask = max(0, nDir.y);
                float downMask = max(0, -nDir.y);
                float sideMask = max(0, 1 - upMask - downMask);

                float3 envColor = normalize(upMask * _UpColor + downMask * _DownColor + sideMask * _SideColor);
                envColor = normalize(envColor * _BaseColor);

                float3 envMask = normalize(tex2D(_OcculsionMask, o.uv));
                float3 envLighting = normalize(envColor * envMask) * _EnvLevel;

                //最终效果
                float3 finalRGB = colorLambert + phong + envLighting;
                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}