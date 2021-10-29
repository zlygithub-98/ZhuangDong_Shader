// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33616,y:33349,varname:node_3138,prsc:2|emission-3909-OUT;n:type:ShaderForge.SFN_NormalVector,id:502,x:31937,y:32961,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:6513,x:32114,y:32961,varname:node_6513,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-502-OUT;n:type:ShaderForge.SFN_Multiply,id:5382,x:32354,y:33085,cmnt:向下的遮罩,varname:node_5382,prsc:2|A-6513-OUT,B-1195-OUT;n:type:ShaderForge.SFN_Vector1,id:1195,x:32114,y:33173,varname:node_1195,prsc:2,v1:-1;n:type:ShaderForge.SFN_Clamp01,id:8054,x:32557,y:33085,varname:node_8054,prsc:2|IN-5382-OUT;n:type:ShaderForge.SFN_Clamp01,id:2311,x:32557,y:32901,varname:node_2311,prsc:2|IN-3080-OUT;n:type:ShaderForge.SFN_Vector1,id:1316,x:32644,y:32747,varname:node_1316,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:6096,x:32916,y:32945,varname:node_6096,prsc:2|A-1316-OUT,B-8054-OUT;n:type:ShaderForge.SFN_Clamp01,id:2734,x:33324,y:33082,varname:node_2734,prsc:2|IN-5518-OUT;n:type:ShaderForge.SFN_Subtract,id:5518,x:33099,y:33054,cmnt:中间部分的遮罩,varname:node_5518,prsc:2|A-6096-OUT,B-2311-OUT;n:type:ShaderForge.SFN_Vector1,id:8772,x:32167,y:32848,varname:node_8772,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:3080,x:32354,y:32901,cmnt:向上的遮罩,varname:node_3080,prsc:2|A-8772-OUT,B-6513-OUT;n:type:ShaderForge.SFN_Color,id:3298,x:32685,y:33241,ptovrint:False,ptlb:colorDown,ptin:_colorDown,varname:node_3298,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:1,c3:0.1544721,c4:1;n:type:ShaderForge.SFN_Color,id:549,x:32685,y:33428,ptovrint:False,ptlb:colorUp,ptin:_colorUp,varname:_colorUp_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.03301889,c3:0.03301889,c4:1;n:type:ShaderForge.SFN_Color,id:2591,x:32685,y:33621,ptovrint:False,ptlb:colorMiddle,ptin:_colorMiddle,varname:_colorDown_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.9987322,c2:1,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:3859,x:32885,y:33241,varname:node_3859,prsc:2|A-8054-OUT,B-3298-RGB;n:type:ShaderForge.SFN_Multiply,id:7229,x:32883,y:33606,varname:node_7229,prsc:2|A-2734-OUT,B-2591-RGB;n:type:ShaderForge.SFN_Multiply,id:6192,x:32883,y:33409,varname:node_6192,prsc:2|A-2311-OUT,B-549-RGB;n:type:ShaderForge.SFN_Add,id:498,x:33097,y:33423,varname:node_498,prsc:2|A-3859-OUT,B-6192-OUT;n:type:ShaderForge.SFN_Add,id:3909,x:33289,y:33570,varname:node_3909,prsc:2|A-498-OUT,B-7229-OUT;proporder:3298-549-2591;pass:END;sub:END;*/

Shader "Shader Forge/Occulision" {
    Properties {
        _colorDown ("colorDown", Color) = (0,1,0.1544721,1)
        _colorUp ("colorUp", Color) = (1,0.03301889,0.03301889,1)
        _colorMiddle ("colorMiddle", Color) = (0.9987322,1,0,1)
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _colorDown)
                UNITY_DEFINE_INSTANCED_PROP( float4, _colorUp)
                UNITY_DEFINE_INSTANCED_PROP( float4, _colorMiddle)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float3 normalDir : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float node_6513 = i.normalDir.g;
                float node_5382 = (node_6513*(-1.0)); // 向下的遮罩
                float node_8054 = saturate(node_5382);
                float4 _colorDown_var = UNITY_ACCESS_INSTANCED_PROP( Props, _colorDown );
                float node_2311 = saturate((1.0*node_6513));
                float4 _colorUp_var = UNITY_ACCESS_INSTANCED_PROP( Props, _colorUp );
                float node_1316 = 1.0;
                float node_2734 = saturate(((node_1316-node_8054)-node_2311));
                float4 _colorMiddle_var = UNITY_ACCESS_INSTANCED_PROP( Props, _colorMiddle );
                float3 emissive = (((node_8054*_colorDown_var.rgb)+(node_2311*_colorUp_var.rgb))+(node_2734*_colorMiddle_var.rgb));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
