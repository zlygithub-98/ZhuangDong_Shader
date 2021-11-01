// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32980,y:32456,varname:node_3138,prsc:2|emission-3651-OUT;n:type:ShaderForge.SFN_NormalVector,id:535,x:31380,y:32789,prsc:2,pt:False;n:type:ShaderForge.SFN_Code,id:7491,x:31789,y:32603,varname:node_7491,prsc:2,code:ZgBsAG8AYQB0ADMAIABuAGQAaQByAFQAUwA9AFUAbgBwAGEAYwBrAE4AbwByAG0AYQBsACgAIAB0AGUAeAAyAEQAKABOAG8AcgBtAGEAbABNAGEAcAAsAFUAVgApACkAOwAKAGYAbABvAGEAdAAzAHgAMwAgAFQAQgBOAD0AZgBsAG8AYQB0ADMAeAAzACgAdABEAGkAcgAsAGIARABpAHIALABuAEQAaQByACkAOwAKAGYAbABvAGEAdAAzACAAbgBEAGkAcgBXAFMAPQBuAG8AcgBtAGEAbABpAHoAZQAoAG0AdQBsACgAbgBkAGkAcgBUAFMALABUAEIATgApACkAOwAKAHIAZQB0AHUAcgBuACAAbgBEAGkAcgBXAFMAOwA=,output:2,fname:Function_node_7491,width:860,height:148,input:2,input:2,input:2,input:1,input:12,input_1_label:tDir,input_2_label:bDir,input_3_label:nDir,input_4_label:UV,input_5_label:NormalMap|A-8211-OUT,B-3420-OUT,C-535-OUT,D-73-UVOUT,E-6659-TEX;n:type:ShaderForge.SFN_Tangent,id:8211,x:31380,y:32464,varname:node_8211,prsc:2;n:type:ShaderForge.SFN_Bitangent,id:3420,x:31380,y:32613,varname:node_3420,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:73,x:31380,y:32951,varname:node_73,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2dAsset,id:6659,x:31380,y:33112,ptovrint:False,ptlb:node_6659,ptin:_node_6659,varname:node_6659,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbab0a6f7bae9cf42bf057d8ee2755f6,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Dot,id:3651,x:32774,y:32839,varname:node_3651,prsc:2,dt:0|A-7491-OUT,B-7863-OUT;n:type:ShaderForge.SFN_LightVector,id:7863,x:32494,y:32881,varname:node_7863,prsc:2;proporder:6659;pass:END;sub:END;*/

Shader "Shader Forge/MyNormal" {
    Properties {
        _node_6659 ("node_6659", 2D) = "bump" {}
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            float3 Function_node_7491( float3 tDir , float3 bDir , float3 nDir , float2 UV , sampler2D NormalMap ){
            float3 ndirTS=UnpackNormal( tex2D(NormalMap,UV));
            float3x3 TBN=float3x3(tDir,bDir,nDir);
            float3 nDirWS=normalize(mul(ndirTS,TBN));
            return nDirWS;
            }
            
            uniform sampler2D _node_6659; uniform float4 _node_6659_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
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
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float node_3651 = dot(Function_node_7491( i.tangentDir , i.bitangentDir , i.normalDir , i.uv0 , _node_6659 ),lightDirection);
                float3 emissive = float3(node_3651,node_3651,node_3651);
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            float3 Function_node_7491( float3 tDir , float3 bDir , float3 nDir , float2 UV , sampler2D NormalMap ){
            float3 ndirTS=UnpackNormal( tex2D(NormalMap,UV));
            float3x3 TBN=float3x3(tDir,bDir,nDir);
            float3 nDirWS=normalize(mul(ndirTS,TBN));
            return nDirWS;
            }
            
            uniform sampler2D _node_6659; uniform float4 _node_6659_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
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
                i.normalDir = normalize(i.normalDir);
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
