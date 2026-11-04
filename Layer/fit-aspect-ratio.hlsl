//!MAGPIE EFFECT
//!VERSION 4
//!SORT_NAME fit-aspect-ratio

//!TEXTURE
Texture2D INPUT;

//!TEXTURE
Texture2D OUTPUT;

//!SAMPLER
//!FILTER LINEAR
//!ADDRESS CLAMP
SamplerState sLin;

//!PASS 1
//!STYLE PS
//!IN INPUT
//!OUT OUTPUT
MF4 Pass1(float2 pos)
{
    uint pw, ph;
    INPUT.GetDimensions(pw, ph);
    float2 pic = float2(pw, ph);
    
    float2 outSz = float2(GetOutputSize());
    float2 rect = pic * min(outSz.x / pic.x, outSz.y / pic.y);
    
    float2 uv = (pos * outSz - 0.5 * (outSz - rect)) / rect;
    
    if (any(uv < 0.0) || any(uv > 1.0))
    {
        return MF4(0.0, 0.0, 0.0, 1.0);
    }
        
    return INPUT.SampleLevel(sLin, uv, 0);
}
