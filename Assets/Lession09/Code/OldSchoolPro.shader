Shader "Unlit/OldSchoolPro"
{
    Properties
    {
        _MainColor("漫反射",color)=(1.0,1.0,1.0,1.0)
        _NormalMap("法线贴图",2d)="bump"{}
        _CubeMap("环境球",cube)="_Skybox"{}
        _MipMap("MipMap等级",Range(0,7))=0
        _PhongPower("Phong等级",Range(1,90))=30
        _EnvSpecInt("环境反射强度",Range(0,5))=0.2
        _FrenfnelPower("Prenfnel等级",Range(1,90))=30

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

            uniform float3 _MainColor;
            uniform sampler2D _NormalMap;
            uniform samplerCUBE _CubeMap; //cubeMap在下边的类型用 samplerCUBE
            uniform int _MipMap;
            uniform float _PhongPower;
            uniform float _EnvSpecInt;
            uniform float _FrenfnelPower;

            // 输入结构
            struct VertexInput
            {
                float4 vertex : POSITION; // 将模型的顶点信息输入进来 默认就会输入进来
                float4 normal : NORMAL;
                float4 tangent:TANGENT;
                float2 uv:TEXCOORD0;
            };

            // 输出结构
            struct VertexOutput
            {
                float4 pos : SV_POSITION; // 屏幕顶点位置
                float3 nDirWS:TEXTOORD0; //世界法线方向
                float2 uv:TEXCOORD1; //uv
                float3 posWS:TEXCOORD2; //世界顶点位置
                float3 tDirWS:TEXCOORD3; //世界切线发向
                float3 bDirWS:TEXCOORD4; //世界副切线方向
            };

            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert(VertexInput v)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal); //unity声明的方法：物体坐标变换为世界空间坐标
                o.uv = v.uv; //传递uv
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0)).xyz); //固定写法，抄shaderforge即可
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w); //固定写法，抄shaderforge即可
                return o; // 将输出结构 输出
            }

            // 输出结构>>>像素
            float4 frag(VertexOutput o) : COLOR
            {
                //准备阶段
                //1获得vdir
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - o.posWS.xyz);

                //2获得ndir
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap, o.uv)).rgb;
                float3x3 TBN = float3x3(o.tDirWS, o.bDirWS, o.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));

                float3 lDir = _WorldSpaceLightPos0;
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz - o.posWS);
                float3 vrDirWS = reflect(-vDir, nDirWS);

                float lambert = max(0.0, dot(nDirWS, lDir));
                float phong = pow(max(0.0, dot(lDir, vrDirWS)), _PhongPower);
                //return phong+lambert;


                //4 采样
                float3 var_CubeMap = texCUBElod(_CubeMap, float4(vrDirWS, _MipMap)).rgb;

                float frenfnel = pow(1 - dot(vDirWS, nDirWS), _FrenfnelPower);
                //return frenfnel;

                float3 finalRGB = lambert * _MainColor + phong;
                finalRGB = finalRGB + var_CubeMap * _EnvSpecInt * frenfnel;
                return float4(finalRGB, 1.0); //得到matcap采样效果         
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}