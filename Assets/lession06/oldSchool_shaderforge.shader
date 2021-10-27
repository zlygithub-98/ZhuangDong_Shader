// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32965,y:32683,varname:node_3138,prsc:2|emission-7522-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32319,y:33110,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4245283,c2:0.2653302,c3:0,c4:1;n:type:ShaderForge.SFN_NormalVector,id:623,x:31708,y:32751,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:6393,x:31888,y:33022,varname:node_6393,prsc:2;n:type:ShaderForge.SFN_Dot,id:5158,x:32133,y:32904,varname:node_5158,prsc:2,dt:0|A-623-OUT,B-6393-OUT;n:type:ShaderForge.SFN_Clamp01,id:1400,x:32319,y:32934,varname:node_1400,prsc:2|IN-5158-OUT;n:type:ShaderForge.SFN_Multiply,id:394,x:32543,y:32960,varname:node_394,prsc:2|A-1400-OUT,B-7241-RGB;n:type:ShaderForge.SFN_Dot,id:5189,x:31946,y:32665,cmnt:blinPhone,varname:node_5189,prsc:2,dt:0|A-285-OUT,B-623-OUT;n:type:ShaderForge.SFN_ViewReflectionVector,id:5025,x:31708,y:32417,varname:node_5025,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:1250,x:32322,y:32614,varname:node_1250,prsc:2|IN-5014-OUT;n:type:ShaderForge.SFN_Power,id:6507,x:32528,y:32684,varname:node_6507,prsc:2|VAL-1250-OUT,EXP-535-OUT;n:type:ShaderForge.SFN_Slider,id:535,x:32165,y:32813,ptovrint:False,ptlb:node_535,ptin:_node_535,varname:node_535,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:51.13044,max:90;n:type:ShaderForge.SFN_HalfVector,id:285,x:31708,y:32602,varname:node_285,prsc:2;n:type:ShaderForge.SFN_Add,id:7522,x:32697,y:32827,varname:node_7522,prsc:2|A-6507-OUT,B-394-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:5014,x:32133,y:32505,ptovrint:False,ptlb:node_5014,ptin:_node_5014,cmnt:isBlinPhone?,varname:node_5014,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-2696-OUT,B-5189-OUT;n:type:ShaderForge.SFN_LightVector,id:4437,x:31708,y:32258,varname:node_4437,prsc:2;n:type:ShaderForge.SFN_Dot,id:2696,x:31926,y:32336,cmnt:phone,varname:node_2696,prsc:2,dt:0|A-4437-OUT,B-5025-OUT;proporder:7241-535-5014;pass:END;sub:END;*/

Shader "Shader Forge/oldSchool_shaderforge" {
    Properties {
        _Color ("Color", Color) = (0.4245283,0.2653302,0,1)
        _node_535 ("node_535", Range(0, 90)) = 51.13044
        [MaterialToggle] _node_5014 ("node_5014", Float ) = 0
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
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_535)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _node_5014)
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
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
////// Emissive:
                float _node_5014_var = lerp( dot(lightDirection,viewReflectDirection), dot(halfDirection,i.normalDir), UNITY_ACCESS_INSTANCED_PROP( Props, _node_5014 ) ); // isBlinPhone?
                float _node_535_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_535 );
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float3 emissive = (pow(saturate(_node_5014_var),_node_535_var)+(saturate(dot(i.normalDir,lightDirection))*_Color_var.rgb));
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
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_535)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _node_5014)
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
                float3 halfDirection = normalize(viewDirection+lightDirection);
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
