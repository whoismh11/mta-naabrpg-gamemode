//
// texRepTra.fx
// by Ren712[AngerMAN]
//

//------------------------------------------------------------------------------------------
// Include some common stuff
//------------------------------------------------------------------------------------------
float gTime : TIME;
static const float pi = 3.141592653589793f;
texture gTexture0 < string textureState="0,Texture"; >;
//------------------------------------------------------------------------------------------
// Shader settings
//------------------------------------------------------------------------------------------
float4 texColor = float4(0.9,0.9,0.9,1);
float wobbleSpeed = 0.125;
float wobbleSize = 0.3;
float wobbleDensity = 100;

float gDayTime = 1;
float gBrightness = 1;

//------------------------------------------------------------------------------------------
// Sampler
//------------------------------------------------------------------------------------------
sampler SamplerTex = sampler_state
{
    Texture = (gTexture0);
};

//------------------------------------------------------------------------------------------
// Pixel Shader
//------------------------------------------------------------------------------------------
float4 PSFunction(float4 TexCoord : TEXCOORD0, float4 Position : POSITION, float4 Diffuse : COLOR0) : COLOR0
{

    float diffGray = saturate(0.1 + (( Diffuse.r +Diffuse.g+Diffuse.b)/3 ) * gDayTime);
    Diffuse = lerp( float4(diffGray, diffGray, diffGray, Diffuse.a ), Diffuse, saturate( gDayTime)); 
    Diffuse.rgb *= gBrightness;

    float2 textureCoordinate = TexCoord.xy;
    float wobbulumTimer = fmod(gTime * wobbleSpeed ,1);
	
    float4 Tex = tex2D(SamplerTex, TexCoord.xy);
    float TexAp = saturate(sin((TexCoord.x + wobbulumTimer) * wobbleDensity) * wobbleSize);
    TexAp = saturate(TexAp + 0.4);
    Tex *= texColor;
    Tex.rgb = lerp (Tex.rgb * (1 - Tex.a) * Diffuse.rgb, Tex.rgb , TexAp * Tex.a); 
    Tex.a = 1;
	Tex.a *= Diffuse.a;
    return saturate( Tex );
}

//------------------------------------------------------------------------------------------
// Technique
//------------------------------------------------------------------------------------------
technique Techinque0
{
    pass p0
    {
        AlphaRef = 1;
        AlphaBlendEnable = TRUE;
        PixelShader = compile ps_2_0 PSFunction();
    }
}

technique fallback
{
    pass P0
    {

    }
}