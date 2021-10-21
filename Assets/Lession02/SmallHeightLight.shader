// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33051,y:32806,varname:node_3138,prsc:2|emission-9072-OUT;n:type:ShaderForge.SFN_NormalVector,id:4763,x:31807,y:32691,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:8413,x:31807,y:32871,varname:node_8413,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:8075,x:32138,y:32774,varname:node_8075,prsc:2|IN-185-OUT;n:type:ShaderForge.SFN_Dot,id:185,x:31980,y:32774,varname:node_185,prsc:2,dt:0|A-4763-OUT,B-8413-OUT;n:type:ShaderForge.SFN_If,id:6356,x:32350,y:32882,varname:node_6356,prsc:2|A-8075-OUT,B-4603-OUT,GT-3698-OUT,EQ-3698-OUT,LT-8190-OUT;n:type:ShaderForge.SFN_Vector1,id:4603,x:32150,y:32975,varname:node_4603,prsc:2,v1:0.99;n:type:ShaderForge.SFN_Vector1,id:3698,x:32150,y:33042,varname:node_3698,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:8190,x:32150,y:33118,varname:node_8190,prsc:2,v1:0;n:type:ShaderForge.SFN_Append,id:8521,x:32284,y:32723,varname:node_8521,prsc:2|A-8075-OUT,B-4603-OUT;n:type:ShaderForge.SFN_Tex2d,id:2421,x:32427,y:32559,ptovrint:False,ptlb:node_2421,ptin:_node_2421,varname:node_2421,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6b04ffff198f644de848c53b42c154a8,ntxv:0,isnm:False|UVIN-8521-OUT;n:type:ShaderForge.SFN_Lerp,id:6276,x:32607,y:32864,varname:node_6276,prsc:2|A-2421-RGB,B-611-RGB,T-6356-OUT;n:type:ShaderForge.SFN_Color,id:611,x:32388,y:33090,ptovrint:False,ptlb:node_611,ptin:_node_611,varname:node_611,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.04245281,c2:1,c3:0.8917701,c4:1;n:type:ShaderForge.SFN_Fresnel,id:4163,x:32357,y:33294,varname:node_4163,prsc:2|EXP-7028-OUT;n:type:ShaderForge.SFN_Blend,id:9072,x:32730,y:33119,cmnt:颜色混合 类似于正片叠底等等效果,varname:node_9072,prsc:2,blmd:6,clmp:True|SRC-6276-OUT,DST-6336-OUT;n:type:ShaderForge.SFN_Multiply,id:6336,x:32613,y:33433,varname:node_6336,prsc:2|A-4163-OUT,B-9880-RGB;n:type:ShaderForge.SFN_Color,id:9880,x:32357,y:33498,ptovrint:False,ptlb:菲涅尔颜色,ptin:_,varname:node_9880,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.7917643,c3:0.1556604,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:7028,x:32000,y:33454,ptovrint:False,ptlb:level,ptin:_level,varname:node_7028,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:2421-611-9880-7028;pass:END;sub:END;*/

Shader "Shader Forge/SmallHeightLight" {
    Properties {
        _node_2421 ("node_2421", 2D) = "white" {}
        _node_611 ("node_611", Color) = (0.04245281,1,0.8917701,1)
        _ ("菲涅尔颜色", Color) = (1,0.7917643,0.1556604,1)
        _level ("level", Float ) = 1
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
            uniform sampler2D _node_2421; uniform float4 _node_2421_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_611)
                UNITY_DEFINE_INSTANCED_PROP( float4, _)
                UNITY_DEFINE_INSTANCED_PROP( float, _level)
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
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float node_8075 = saturate(dot(i.normalDir,lightDirection));
                float node_4603 = 0.99;
                float2 node_8521 = float2(node_8075,node_4603);
                float4 _node_2421_var = tex2D(_node_2421,TRANSFORM_TEX(node_8521, _node_2421));
                float4 _node_611_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_611 );
                float node_6356_if_leA = step(node_8075,node_4603);
                float node_6356_if_leB = step(node_4603,node_8075);
                float node_3698 = 1.0;
                float _level_var = UNITY_ACCESS_INSTANCED_PROP( Props, _level );
                float4 __var = UNITY_ACCESS_INSTANCED_PROP( Props, _ );
                float3 emissive = saturate((1.0-(1.0-lerp(_node_2421_var.rgb,_node_611_var.rgb,lerp((node_6356_if_leA*0.0)+(node_6356_if_leB*node_3698),node_3698,node_6356_if_leA*node_6356_if_leB)))*(1.0-(pow(1.0-max(0,dot(normalDirection, viewDirection)),_level_var)*__var.rgb))));
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
            uniform sampler2D _node_2421; uniform float4 _node_2421_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_611)
                UNITY_DEFINE_INSTANCED_PROP( float4, _)
                UNITY_DEFINE_INSTANCED_PROP( float, _level)
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
