// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33374,y:32576,varname:node_3138,prsc:2|emission-478-OUT;n:type:ShaderForge.SFN_Tex2d,id:2979,x:31807,y:32627,ptovrint:False,ptlb:node_2979,ptin:_node_2979,varname:node_2979,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:f2db422f013c37b4e9d26b6605513ab8,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:732,x:32011,y:32765,varname:node_732,prsc:2,tffrom:2,tfto:0|IN-2979-RGB;n:type:ShaderForge.SFN_Fresnel,id:3693,x:32246,y:32811,varname:node_3693,prsc:2|NRM-732-XYZ,EXP-2448-OUT;n:type:ShaderForge.SFN_Slider,id:2448,x:31854,y:32986,ptovrint:False,ptlb:node_2448,ptin:_node_2448,varname:node_2448,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:8;n:type:ShaderForge.SFN_Transform,id:2867,x:32011,y:32547,varname:node_2867,prsc:2,tffrom:2,tfto:3|IN-2979-RGB;n:type:ShaderForge.SFN_ComponentMask,id:219,x:32231,y:32523,varname:node_219,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2867-XYZ;n:type:ShaderForge.SFN_Multiply,id:3264,x:32420,y:32511,varname:node_3264,prsc:2|A-219-OUT,B-1846-OUT;n:type:ShaderForge.SFN_Add,id:2533,x:32599,y:32511,varname:node_2533,prsc:2|A-3264-OUT,B-1846-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1846,x:32262,y:32698,ptovrint:False,ptlb:node_1846,ptin:_node_1846,varname:node_1846,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;n:type:ShaderForge.SFN_Tex2d,id:9906,x:32770,y:32511,ptovrint:False,ptlb:MATCAP,ptin:_MATCAP,varname:_node_2979_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:119bfe51061529d40929df43ea5b5687,ntxv:1,isnm:False|UVIN-2533-OUT;n:type:ShaderForge.SFN_Multiply,id:5555,x:33007,y:32682,varname:node_5555,prsc:2|A-9906-RGB,B-3693-OUT;n:type:ShaderForge.SFN_Slider,id:2763,x:32614,y:32903,ptovrint:False,ptlb:node_2448_copy,ptin:_node_2448_copy,varname:_node_2448_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;n:type:ShaderForge.SFN_Multiply,id:478,x:33199,y:32756,varname:node_478,prsc:2|A-5555-OUT,B-2763-OUT;proporder:2979-2448-1846-9906-2763;pass:END;sub:END;*/

Shader "Shader Forge/MatCap_SF" {
    Properties {
        _node_2979 ("node_2979", 2D) = "bump" {}
        _node_2448 ("node_2448", Range(1, 8)) = 1
        _node_1846 ("node_1846", Float ) = 0.5
        _MATCAP ("MATCAP", 2D) = "gray" {}
        _node_2448_copy ("node_2448_copy", Range(0, 5)) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_2979; uniform float4 _node_2979_ST;
            uniform sampler2D _MATCAP; uniform float4 _MATCAP_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2448)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1846)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2448_copy)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 _node_2979_var = UnpackNormal(tex2D(_node_2979,TRANSFORM_TEX(i.uv0, _node_2979)));
                float _node_1846_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1846 );
                float2 node_2533 = ((mul( UNITY_MATRIX_V, float4(mul( _node_2979_var.rgb, tangentTransform ),0) ).xyz.rgb.rg*_node_1846_var)+_node_1846_var);
                float4 _MATCAP_var = tex2D(_MATCAP,TRANSFORM_TEX(node_2533, _MATCAP));
                float _node_2448_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2448 );
                float _node_2448_copy_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2448_copy );
                float3 emissive = ((_MATCAP_var.rgb*pow(1.0-max(0,dot(mul( _node_2979_var.rgb, tangentTransform ).xyz.rgb, viewDirection)),_node_2448_var))*_node_2448_copy_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
