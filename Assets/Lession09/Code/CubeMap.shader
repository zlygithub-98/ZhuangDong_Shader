Shader "Unlit/CubeMap"
{
    Properties
    {
        _NormalMap("法线贴图",2d)="bump"{}
        _CubeMap("环境球",cube)="_Skybox"{}//cubeMap格式用 cube 默认值 _Skybox
        _MipMap("MipMap等级",Range(0,7))=0
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

            uniform sampler2D _NormalMap;
            uniform samplerCUBE _CubeMap; //cubeMap在下边的类型用 samplerCUBE
            uniform int _MipMap;

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
                //1获得vdir
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - o.posWS.xyz);

                //2获得ndir
                float3 nDirTS = UnpackNormal(tex2D(_NormalMap, o.uv)).rgb;
                float3x3 TBN = float3x3(o.tDirWS, o.bDirWS, o.nDirWS);
                float3 nDirWS = normalize(mul(nDirTS, TBN));

                //3 反射vdir
                float3 vrDirWS = reflect(-vDirWS, nDirWS);
                //4 采样
                float3 var_CubeMap = texCUBElod(_CubeMap, float4(vrDirWS, _MipMap)).rgb;
                return float4(var_CubeMap, 1.0); //得到matcap采样效果         
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}