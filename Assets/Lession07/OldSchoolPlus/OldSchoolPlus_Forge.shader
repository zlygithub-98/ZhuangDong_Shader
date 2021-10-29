// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:35051,y:32954,varname:node_3138,prsc:2|emission-135-OUT;n:type:ShaderForge.SFN_NormalVector,id:3515,x:32450,y:32545,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:6985,x:32450,y:32730,varname:node_6985,prsc:2;n:type:ShaderForge.SFN_Dot,id:8434,x:32654,y:32622,varname:node_8434,prsc:2,dt:0|A-3515-OUT,B-6985-OUT;n:type:ShaderForge.SFN_Clamp01,id:2780,x:32826,y:32622,varname:node_2780,prsc:2|IN-8434-OUT;n:type:ShaderForge.SFN_ViewReflectionVector,id:6650,x:32450,y:32872,varname:node_6650,prsc:2;n:type:ShaderForge.SFN_Dot,id:5016,x:32677,y:32826,varname:node_5016,prsc:2,dt:0|A-6985-OUT,B-6650-OUT;n:type:ShaderForge.SFN_Clamp01,id:7641,x:32840,y:32826,varname:node_7641,prsc:2|IN-5016-OUT;n:type:ShaderForge.SFN_Slider,id:252,x:32683,y:33003,ptovrint:False,ptlb:power,ptin:_power,varname:node_252,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:38.92174,max:90;n:type:ShaderForge.SFN_Power,id:2631,x:33055,y:32801,varname:node_2631,prsc:2|VAL-7641-OUT,EXP-252-OUT;n:type:ShaderForge.SFN_Add,id:7372,x:33401,y:32829,varname:node_7372,prsc:2|A-9757-OUT,B-2631-OUT;n:type:ShaderForge.SFN_Color,id:7239,x:33898,y:32075,ptovrint:False,ptlb:lightColor,ptin:_lightColor,varname:node_7239,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:9757,x:33213,y:32596,varname:node_9757,prsc:2|A-7237-RGB,B-2780-OUT;n:type:ShaderForge.SFN_Color,id:7237,x:33192,y:32411,ptovrint:False,ptlb:baseColor,ptin:_baseColor,varname:_lightColor_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.8712505,c3:0.1556604,c4:1;n:type:ShaderForge.SFN_Multiply,id:9523,x:33871,y:32834,varname:node_9523,prsc:2|A-2485-OUT,B-7372-OUT;n:type:ShaderForge.SFN_NormalVector,id:9167,x:32394,y:33154,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:4283,x:32577,y:33154,varname:node_4283,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-9167-OUT;n:type:ShaderForge.SFN_Vector1,id:6342,x:32412,y:33513,varname:node_6342,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:2673,x:32740,y:33446,varname:node_2673,prsc:2|A-4283-OUT,B-6342-OUT;n:type:ShaderForge.SFN_Multiply,id:5945,x:32740,y:33251,varname:node_5945,prsc:2|A-9109-OUT,B-4283-OUT;n:type:ShaderForge.SFN_Vector1,id:9109,x:32412,y:33361,varname:node_9109,prsc:2,v1:1;n:type:ShaderForge.SFN_Clamp01,id:7275,x:32927,y:33251,varname:node_7275,prsc:2|IN-5945-OUT;n:type:ShaderForge.SFN_Clamp01,id:2704,x:32927,y:33446,varname:node_2704,prsc:2|IN-2673-OUT;n:type:ShaderForge.SFN_Subtract,id:8782,x:33148,y:33597,varname:node_8782,prsc:2|A-9109-OUT,B-7275-OUT;n:type:ShaderForge.SFN_Subtract,id:9686,x:33348,y:33672,varname:node_9686,prsc:2|A-8782-OUT,B-2704-OUT;n:type:ShaderForge.SFN_Multiply,id:2642,x:33197,y:33183,varname:node_2642,prsc:2|A-8095-RGB,B-7275-OUT;n:type:ShaderForge.SFN_Multiply,id:679,x:33257,y:33372,varname:node_679,prsc:2|A-2704-OUT,B-2115-RGB;n:type:ShaderForge.SFN_Multiply,id:7316,x:33542,y:33531,varname:node_7316,prsc:2|A-3203-RGB,B-9686-OUT;n:type:ShaderForge.SFN_Color,id:8095,x:32963,y:33069,ptovrint:False,ptlb:upColor,ptin:_upColor,varname:node_8095,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:2115,x:32960,y:33691,ptovrint:False,ptlb:downColor,ptin:_downColor,varname:_upColor_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2735849,c2:0.2735849,c3:0.2735849,c4:1;n:type:ShaderForge.SFN_Color,id:3203,x:33083,y:33871,ptovrint:False,ptlb:MiddleColor,ptin:_MiddleColor,varname:_upColor_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5283019,c2:0.5283019,c3:0.5283019,c4:1;n:type:ShaderForge.SFN_Add,id:8832,x:33461,y:33230,varname:node_8832,prsc:2|A-2642-OUT,B-679-OUT;n:type:ShaderForge.SFN_Add,id:9663,x:33659,y:33314,varname:node_9663,prsc:2|A-8832-OUT,B-7316-OUT;n:type:ShaderForge.SFN_Multiply,id:4725,x:33874,y:33250,varname:node_4725,prsc:2|A-7237-RGB,B-9663-OUT;n:type:ShaderForge.SFN_Multiply,id:1051,x:34106,y:33263,varname:node_1051,prsc:2|A-4725-OUT,B-1863-OUT;n:type:ShaderForge.SFN_Slider,id:1863,x:33783,y:33537,ptovrint:False,ptlb:EnvColorLevel,ptin:_EnvColorLevel,varname:node_1863,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Add,id:135,x:34436,y:33073,varname:node_135,prsc:2|A-9523-OUT,B-7736-OUT;n:type:ShaderForge.SFN_Multiply,id:2485,x:34006,y:32317,varname:node_2485,prsc:2|A-7239-RGB,B-7848-OUT;n:type:ShaderForge.SFN_Slider,id:7848,x:33622,y:32288,ptovrint:False,ptlb:lightPower,ptin:_lightPower,varname:_EnvColorLevel_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.7919173,max:1;n:type:ShaderForge.SFN_LightAttenuation,id:6665,x:34389,y:32373,varname:node_6665,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5968,x:34555,y:32537,varname:node_5968,prsc:2|A-6665-OUT,B-9523-OUT;n:type:ShaderForge.SFN_Tex2d,id:3275,x:34175,y:33472,ptovrint:False,ptlb:occoluision,ptin:_occoluision,varname:node_3275,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7736,x:34324,y:33277,varname:node_7736,prsc:2|A-1051-OUT,B-3275-RGB;proporder:252-7237-7239-8095-2115-3203-1863-7848-3275;pass:END;sub:END;*/

Shader "Shader Forge/OldSchoolPlus_Forge" {
    Properties {
        _power ("power", Range(1, 90)) = 38.92174
        _baseColor ("baseColor", Color) = (1,0.8712505,0.1556604,1)
        _lightColor ("lightColor", Color) = (0.5,0.5,0.5,1)
        _upColor ("upColor", Color) = (1,1,1,1)
        _downColor ("downColor", Color) = (0.2735849,0.2735849,0.2735849,1)
        _MiddleColor ("MiddleColor", Color) = (0.5283019,0.5283019,0.5283019,1)
        _EnvColorLevel ("EnvColorLevel", Range(0, 1)) = 0
        _lightPower ("lightPower", Range(0, 1)) = 0.7919173
        _occoluision ("occoluision", 2D) = "white" {}
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
            uniform sampler2D _occoluision; uniform float4 _occoluision_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _power)
                UNITY_DEFINE_INSTANCED_PROP( float4, _lightColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _baseColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _upColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _downColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MiddleColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvColorLevel)
                UNITY_DEFINE_INSTANCED_PROP( float, _lightPower)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
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
                float4 _lightColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _lightColor );
                float _lightPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _lightPower );
                float4 _baseColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _baseColor );
                float _power_var = UNITY_ACCESS_INSTANCED_PROP( Props, _power );
                float3 node_9523 = ((_lightColor_var.rgb*_lightPower_var)*((_baseColor_var.rgb*saturate(dot(i.normalDir,lightDirection)))+pow(saturate(dot(lightDirection,viewReflectDirection)),_power_var)));
                float4 _upColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _upColor );
                float node_9109 = 1.0;
                float node_4283 = i.normalDir.g;
                float node_7275 = saturate((node_9109*node_4283));
                float node_2704 = saturate((node_4283*(-1.0)));
                float4 _downColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _downColor );
                float4 _MiddleColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MiddleColor );
                float _EnvColorLevel_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvColorLevel );
                float4 _occoluision_var = tex2D(_occoluision,TRANSFORM_TEX(i.uv0, _occoluision));
                float3 emissive = (node_9523+(((_baseColor_var.rgb*(((_upColor_var.rgb*node_7275)+(node_2704*_downColor_var.rgb))+(_MiddleColor_var.rgb*((node_9109-node_7275)-node_2704))))*_EnvColorLevel_var)*_occoluision_var.rgb));
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
            uniform sampler2D _occoluision; uniform float4 _occoluision_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _power)
                UNITY_DEFINE_INSTANCED_PROP( float4, _lightColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _baseColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _upColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _downColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MiddleColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvColorLevel)
                UNITY_DEFINE_INSTANCED_PROP( float, _lightPower)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
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
