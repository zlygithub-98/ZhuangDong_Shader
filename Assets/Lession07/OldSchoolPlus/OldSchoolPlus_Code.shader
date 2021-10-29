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
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform float _PhongPower;
            uniform float _EnvLevel;
            uniform float4 _BaseColor;
            uniform float4 _UpColor;
            uniform float4 _SideColor;
            uniform float4 _DownColor;
            uniform sampler2D _OcculsionMask;

            struct VertexInput
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv1:TEXCOORD0;
            };

            struct VertexOutput
            {
                float4 pos : SV_POSITION;
                float3 nDirWS:TEXTOORD0;
                float3 posWS:TEXCOORD1;
                float2 uv:TEXCOORD2;
                LIGHTING_COORDS(3, 4)
            };

            VertexOutput vert(VertexInput v)
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.uv = v.uv1;
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }

            float4 frag(VertexOutput o) : COLOR
            {
                //准备阶段                
                float shadow = LIGHT_ATTENUATION(o);
                
                float3 nDir = o.nDirWS;
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 vdir = normalize(_WorldSpaceCameraPos - o.posWS);//视角向量
                float3 vReflectDir = reflect(-vdir, nDir);//视角沿着法线反射的方向
                                
                //计算漫反射
                float lambert = max(0, dot(nDir, lDir));                
                lambert *= shadow;//加上阴影
                float3 colorLambert= lambert * _BaseColor;//加上固有色 注意变成3维
                //计算高光
                float phong = pow(max(0, dot(lDir, vReflectDir)), _PhongPower);
                //漫反射加上高光
                colorLambert += phong;
                
                //计算遮罩
                float upMask = max(0, nDir.y);
                float downMask = max(0, -nDir.y);
                float sideMask = max(0, 1 - upMask - downMask);

                //计算环境光
                float3 envColor = normalize(upMask * _UpColor + downMask * _DownColor + sideMask * _SideColor);
                envColor = normalize(envColor * _BaseColor);//环境光需要乘以固有色
                
                //计算AO遮罩 注意传递的参数为AO贴图和模型UV
                float3 envMask = normalize(tex2D(_OcculsionMask, o.uv));
                float3 envLighting = normalize(envColor * envMask) * _EnvLevel;

                //最终效果
                float3 finalRGB = colorLambert + envLighting;
                return float4(finalRGB, 1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}