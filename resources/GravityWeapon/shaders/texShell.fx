//
// texShell.fx
// by Ren712[AngerMAN]
//

//---------------------------------------------------------------------
// Settings
//---------------------------------------------------------------------
texture gTextureShell;
float fSize = 0.03;
float2 fSpeed = float2(6,6); 
float4 fTextureColor = float4(1,0.6,0,1);

//---------------------------------------------------------------------
// Include some common stuff
//--------------------------------------------------------------------- 
float4x4 gWorld : WORLD;
float4x4 gView : VIEW;
float4x4 gProjection : PROJECTION;
float gTime : TIME;

//---------------------------------------------------------------------
// Sampler for the main texture
//---------------------------------------------------------------------
sampler SamplerShell = sampler_state
{
    Texture = (gTextureShell);
    MinFilter       = Linear;
    MagFilter       = Linear;
    MipFilter       = Linear;
    AddressU        = Mirror;
    AddressV        = Mirror;
};

//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
  float3 Position : POSITION0;
  float4 Diffuse : COLOR0;
  float3 Normal : NORMAL;
  float2 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse : COLOR0;
  float2 TexCoord : TEXCOORD0;
};


//------------------------------------------------------------------------------------------
// VertexShaderFunction
//  1. Read from VS structure
//  2. Process
//  3. Write to PS structure
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // Calculate screen pos of vertex
    VS.Position.xyz += fSize * VS.Normal.xyz;
    float4 posWorld = mul(float4(VS.Position.xyz,1), gWorld);
    float4 posWorldView = mul(posWorld, gView);
    PS.Position = mul(posWorldView, gProjection);
	
    // Pass through tex coord
    PS.TexCoord = VS.TexCoord;

    // Pass through Diffuse
    PS.Diffuse = VS.Diffuse;

    return PS;
}

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    // Make animation
    float2 animTex = float2( fmod(( fSpeed.x * gTime)/8 ,1 ),fmod(( fSpeed.y * gTime)/8 ,1 ));

    // Get texture pixel
    float4 texShell = tex2D(SamplerShell, PS.TexCoord.xy + animTex);

    // Apply color
    float4 finalColor = texShell * fTextureColor;
    return saturate(finalColor);
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique shell
{
    pass P0
    {
        AlphaRef = 1;
        SrcBlend = SRCALPHA;
        DestBlend = ONE;
        AlphaBlendEnable = TRUE;
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}
