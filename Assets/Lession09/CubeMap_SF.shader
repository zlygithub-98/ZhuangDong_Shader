// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32990,y:32458,varname:node_3138,prsc:2|emission-3543-RGB;n:type:ShaderForge.SFN_Tex2d,id:610,x:31764,y:32653,ptovrint:False,ptlb:node_610,ptin:_node_610,varname:node_610,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbab0a6f7bae9cf42bf057d8ee2755f6,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:529,x:31950,y:32653,varname:node_529,prsc:2,tffrom:2,tfto:0|IN-610-RGB;n:type:ShaderForge.SFN_ViewVector,id:15,x:31753,y:32447,varname:node_15,prsc:2;n:type:ShaderForge.SFN_Vector1,id:3371,x:31753,y:32371,varname:node_3371,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:4852,x:31930,y:32423,varname:node_4852,prsc:2|A-3371-OUT,B-15-OUT;n:type:ShaderForge.SFN_Reflect,id:5261,x:32154,y:32508,varname:node_5261,prsc:2|A-4852-OUT,B-529-XYZ;n:type:ShaderForge.SFN_Cubemap,id:3543,x:32432,y:32368,ptovrint:False,ptlb:node_3543,ptin:_node_3543,varname:node_3543,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,cube:d51cd34544212c54fad1d1ed41ff1d59,pvfc:0|DIR-5261-OUT,MIP-9684-OUT;n:type:ShaderForge.SFN_Slider,id:9684,x:32171,y:32684,ptovrint:False,ptlb:node_9684,ptin:_node_9684,varname:node_9684,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:7;n:type:ShaderForge.SFN_Multiply,id:3613,x:32622,y:32683,varname:node_3613,prsc:2|A-3543-RGB,B-3093-OUT;n:type:ShaderForge.SFN_Fresnel,id:3093,x:32250,y:32846,varname:node_3093,prsc:2|NRM-529-XYZ,EXP-7060-OUT;n:type:ShaderForge.SFN_Slider,id:7060,x:31825,y:32990,ptovrint:False,ptlb:node_7060,ptin:_node_7060,varname:node_7060,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:10;n:type:ShaderForge.SFN_NormalVector,id:2813,x:31549,y:32804,prsc:2,pt:False;proporder:610-3543-9684-7060;pass:END;sub:END;*/

Shader "Shader Forge/CubeMap" {
    Properties {
        _node_610 ("node_610", 2D) = "bump" {}
        _node_3543 ("node_3543", Cube) = "_Skybox" {}
        _node_9684 ("node_9684", Range(0, 7)) = 0
        _node_7060 ("node_7060", Range(0, 10)) = 0
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
            uniform sampler2D _node_610; uniform float4 _node_610_ST;
            uniform samplerCUBE _node_3543;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_9684)
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
                float3 _node_610_var = UnpackNormal(tex2D(_node_610,TRANSFORM_TEX(i.uv0, _node_610)));
                float3 node_529 = mul( _node_610_var.rgb, tangentTransform ).xyz;
                float _node_9684_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_9684 );
                float4 _node_3543_var = texCUBElod(_node_3543,float4(reflect(((-1.0)*viewDirection),node_529.rgb),_node_9684_var));
                float3 emissive = _node_3543_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
