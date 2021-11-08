// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33461,y:32814,varname:node_3138,prsc:2|emission-5900-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32224,y:32484,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_NormalVector,id:3028,x:31871,y:32575,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:3358,x:32088,y:32671,varname:node_3358,prsc:2,dt:0|A-3028-OUT,B-6109-OUT;n:type:ShaderForge.SFN_LightVector,id:6109,x:31871,y:32748,varname:node_6109,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:4771,x:32263,y:32671,varname:node_4771,prsc:2|IN-3358-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:8832,x:32499,y:32482,varname:node_8832,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5935,x:32499,y:32671,varname:node_5935,prsc:2|A-7241-RGB,B-4771-OUT;n:type:ShaderForge.SFN_Multiply,id:9732,x:32694,y:32618,varname:node_9732,prsc:2|A-8832-OUT,B-5935-OUT;n:type:ShaderForge.SFN_Dot,id:227,x:32088,y:32862,varname:node_227,prsc:2,dt:0|A-6109-OUT,B-6425-OUT;n:type:ShaderForge.SFN_ViewReflectionVector,id:6425,x:31871,y:32926,varname:node_6425,prsc:2;n:type:ShaderForge.SFN_Power,id:7223,x:32499,y:32893,varname:node_7223,prsc:2|VAL-8328-OUT,EXP-5835-OUT;n:type:ShaderForge.SFN_Slider,id:5835,x:32009,y:33086,ptovrint:False,ptlb:node_5835,ptin:_node_5835,varname:node_5835,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:90,max:90;n:type:ShaderForge.SFN_Add,id:964,x:32865,y:32731,varname:node_964,prsc:2|A-9732-OUT,B-7223-OUT;n:type:ShaderForge.SFN_Clamp01,id:8328,x:32277,y:32862,varname:node_8328,prsc:2|IN-227-OUT;n:type:ShaderForge.SFN_Tex2d,id:5377,x:31865,y:33423,ptovrint:False,ptlb:node_5377,ptin:_node_5377,varname:node_5377,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:5978,x:32037,y:33398,varname:node_5978,prsc:2,tffrom:2,tfto:0|IN-5377-RGB;n:type:ShaderForge.SFN_Reflect,id:4298,x:32245,y:33331,varname:node_4298,prsc:2|A-6123-OUT,B-5978-XYZ;n:type:ShaderForge.SFN_ViewVector,id:3617,x:31865,y:33181,varname:node_3617,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6123,x:32037,y:33243,varname:node_6123,prsc:2|A-3617-OUT,B-8392-OUT;n:type:ShaderForge.SFN_Vector1,id:8392,x:31865,y:33327,varname:node_8392,prsc:2,v1:-1;n:type:ShaderForge.SFN_Cubemap,id:6221,x:32504,y:33332,ptovrint:False,ptlb:node_6221,ptin:_node_6221,varname:node_6221,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,cube:d51cd34544212c54fad1d1ed41ff1d59,pvfc:0|DIR-4298-OUT,MIP-4788-OUT;n:type:ShaderForge.SFN_Slider,id:4788,x:32187,y:33495,ptovrint:False,ptlb:node_4788,ptin:_node_4788,varname:node_4788,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:7;n:type:ShaderForge.SFN_Fresnel,id:9909,x:32698,y:33169,varname:node_9909,prsc:2|EXP-9834-OUT;n:type:ShaderForge.SFN_Slider,id:9834,x:32362,y:33185,ptovrint:False,ptlb:frebsnel,ptin:_frebsnel,varname:_node_5835_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:7;n:type:ShaderForge.SFN_Multiply,id:300,x:32870,y:33304,varname:node_300,prsc:2|A-9909-OUT,B-6221-RGB;n:type:ShaderForge.SFN_Add,id:5900,x:33153,y:32934,varname:node_5900,prsc:2|A-964-OUT,B-300-OUT;proporder:7241-5835-5377-6221-4788-9834;pass:END;sub:END;*/

Shader "Shader Forge/OldSchoolPro_SF" {
    Properties {
        _Color ("Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _node_5835 ("node_5835", Range(1, 90)) = 90
        _node_5377 ("node_5377", 2D) = "bump" {}
        _node_6221 ("node_6221", Cube) = "_Skybox" {}
        _node_4788 ("node_4788", Range(0, 7)) = 0
        _frebsnel ("frebsnel", Range(0, 7)) = 0
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
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_5377; uniform float4 _node_5377_ST;
            uniform samplerCUBE _node_6221;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_5835)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_4788)
                UNITY_DEFINE_INSTANCED_PROP( float, _frebsnel)
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
                LIGHTING_COORDS(5,6)
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
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
////// Emissive:
                float4 _Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color );
                float _node_5835_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5835 );
                float _frebsnel_var = UNITY_ACCESS_INSTANCED_PROP( Props, _frebsnel );
                float3 _node_5377_var = UnpackNormal(tex2D(_node_5377,TRANSFORM_TEX(i.uv0, _node_5377)));
                float _node_4788_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_4788 );
                float3 emissive = (((attenuation*(_Color_var.rgb*saturate(dot(i.normalDir,lightDirection))))+pow(saturate(dot(lightDirection,viewReflectDirection)),_node_5835_var))+(pow(1.0-max(0,dot(normalDirection, viewDirection)),_frebsnel_var)*texCUBElod(_node_6221,float4(reflect((viewDirection*(-1.0)),mul( _node_5377_var.rgb, tangentTransform ).xyz.rgb),_node_4788_var)).rgb));
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
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_5377; uniform float4 _node_5377_ST;
            uniform samplerCUBE _node_6221;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_5835)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_4788)
                UNITY_DEFINE_INSTANCED_PROP( float, _frebsnel)
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
                LIGHTING_COORDS(5,6)
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
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
