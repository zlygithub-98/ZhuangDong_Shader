// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33411,y:32910,varname:node_3138,prsc:2|emission-563-OUT;n:type:ShaderForge.SFN_LightVector,id:389,x:31909,y:32681,varname:node_389,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:7669,x:32071,y:32998,prsc:2,pt:False;n:type:ShaderForge.SFN_Vector1,id:2716,x:31924,y:32875,varname:node_2716,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:4734,x:32106,y:32784,varname:node_4734,prsc:2|A-389-OUT,B-2716-OUT;n:type:ShaderForge.SFN_Reflect,id:4104,x:32268,y:32874,varname:node_4104,prsc:2|A-4734-OUT,B-7669-OUT;n:type:ShaderForge.SFN_Dot,id:130,x:32378,y:33014,varname:node_130,prsc:2,dt:0|A-4104-OUT,B-3755-OUT;n:type:ShaderForge.SFN_ViewVector,id:3755,x:32209,y:33151,varname:node_3755,prsc:2;n:type:ShaderForge.SFN_Power,id:563,x:33166,y:33041,varname:node_563,prsc:2|VAL-7643-OUT,EXP-412-OUT;n:type:ShaderForge.SFN_Slider,id:412,x:32800,y:33204,ptovrint:False,ptlb:node_412,ptin:_node_412,varname:node_412,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:25.34873,max:30;n:type:ShaderForge.SFN_Max,id:7643,x:32991,y:32961,varname:node_7643,prsc:2|A-5610-OUT,B-2887-OUT;n:type:ShaderForge.SFN_Vector1,id:2887,x:32672,y:33080,varname:node_2887,prsc:2,v1:0;n:type:ShaderForge.SFN_LightVector,id:1989,x:32303,y:32437,varname:node_1989,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:7918,x:32303,y:32593,varname:node_7918,prsc:2;n:type:ShaderForge.SFN_Dot,id:7845,x:32521,y:32544,varname:node_7845,prsc:2,dt:0|A-1989-OUT,B-7918-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:5610,x:32698,y:32834,ptovrint:False,ptlb:node_5610,ptin:_node_5610,varname:node_5610,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7845-OUT,B-130-OUT;proporder:412-5610;pass:END;sub:END;*/

Shader "Shader Forge/phong" {
    Properties {
        _node_412 ("node_412", Range(1, 30)) = 25.34873
        [MaterialToggle] _node_5610 ("node_5610", Float ) = 0
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
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_412)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _node_5610)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float _node_5610_var = lerp( dot(lightDirection,viewReflectDirection), dot(reflect((lightDirection*(-1.0)),i.normalDir),viewDirection), UNITY_ACCESS_INSTANCED_PROP( Props, _node_5610 ) );
                float _node_412_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_412 );
                float node_563 = pow(max(_node_5610_var,0.0),_node_412_var);
                float3 emissive = float3(node_563,node_563,node_563);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_412)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _node_5610)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
