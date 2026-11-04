//!MAGPIE EFFECT
//!VERSION 4
//!SORT_NAME Layer

// Layer (version 0.2) by CeeJay.dk (MIT), scale/position by seri14 & Marot Satil.
// MagpieFX port: blends the image Layer.png (placed next to this file) over the picture.

//!PARAMETER
//!LABEL Layer Position X
//!DEFAULT 0.5
//!MIN 0
//!MAX 1
//!STEP 0.005
float Layer_PosX;

//!PARAMETER
//!LABEL Layer Position Y
//!DEFAULT 0.5
//!MIN 0
//!MAX 1
//!STEP 0.005
float Layer_PosY;

//!PARAMETER
//!LABEL Layer Scale
//!DEFAULT 1
//!MIN 0.01
//!MAX 4
//!STEP 0.004
float Layer_Scale;

//!PARAMETER
//!LABEL Layer Blend
//!DEFAULT 1
//!MIN 0
//!MAX 1
//!STEP 0.00392157
float Layer_Blend;

//!TEXTURE
Texture2D INPUT;

//!TEXTURE
Texture2D OUTPUT;

//!TEXTURE
//!SOURCE Layer.png
Texture2D Layer_Tex;

//!SAMPLER
//!FILTER LINEAR
//!ADDRESS CLAMP
SamplerState sam;

//!PASS 1
//!DESC Layer
//!STYLE PS
//!IN INPUT, Layer_Tex
//!OUT OUTPUT

float4 Pass1(float2 pos)
{
	float4 backColor = INPUT.SampleLevel(sam, pos, 0);

	uint lw, lh;
	Layer_Tex.GetDimensions(lw, lh);

	// layer size relative to the output, like LAYER_SIZE / BUFFER_SCREEN_SIZE in the ReShade version
	float2 pixelSize = 1.0 / (float2(lw, lh) * Layer_Scale / float2(GetOutputSize()));
	float2 uv = pos * pixelSize + float2(Layer_PosX, Layer_PosY) * (1.0 - pixelSize);

	float4 layer = Layer_Tex.SampleLevel(sam, uv, 0);
	// MagpieFX has no BORDER address mode: outside the image the layer is transparent
	if (any(uv < 0.0) || any(uv > 1.0))
		layer = 0.0;

	float4 result = lerp(backColor, layer, layer.a * Layer_Blend);
	result.a = backColor.a;
	return result;
}
