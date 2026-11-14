//!MAGPIE EFFECT
//!VERSION 4
//!USE _DYNAMIC
//!SORT_NAME NTSC-Adaptive

// MagpieFX port of NTSC-Adaptive (guest.r, slang release 2026-11-08-release1), same pass structure and names as NTSC-Adaptive.fx.
// INPUT is treated as the native game resolution (run the game window at 1x). The effect outputs the 2x-width image;
// Magpie scales it to the window with its own scaling mode.

//!PARAMETER
//!LABEL SNES/Amiga Hi-Res Auto Mode
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 1.0
//!STEP 1.0
float auto_res;

//!PARAMETER
//!LABEL Horizontal Filtering Resolution
//!DEFAULT 1.0
//!MIN 0.5
//!MAX 8.0
//!STEP 0.05
float filter_res;

//!PARAMETER
//!LABEL Speedup w. higher Internal Res.
//!DEFAULT 1.0
//!MIN 1.0
//!MAX 4.0
//!STEP 1.0
float speedup;

//!PARAMETER
//!LABEL Hi-Res Sampling Behaviour: Default | Old
//!DEFAULT 1.0
//!MIN 1.0
//!MAX 2.0
//!STEP 1.0
float ntsc_samp;

//!PARAMETER
//!LABEL NTSC Custom Artifacting Value
//!DEFAULT 1.0
//!MIN 0.0
//!MAX 5.0
//!STEP 0.1
float cust_artifacting;

//!PARAMETER
//!LABEL NTSC Custom Fringing Value
//!DEFAULT 1.0
//!MIN 0.0
//!MAX 5.0
//!STEP 0.1
float cust_fringing;

//!PARAMETER
//!LABEL NTSC Merge Fields: Auto | No | Yes
//!DEFAULT -1.0
//!MIN -1.0
//!MAX 1.0
//!STEP 1.0
float ntsc_fields;

//!PARAMETER
//!LABEL NTSC Phase: Auto | 2 Phase | 3 Phase | Mixed
//!DEFAULT 1.0
//!MIN 1.0
//!MAX 5.0
//!STEP 1.0
float ntsc_phase;

//!PARAMETER
//!LABEL NTSC Resolution Scaling
//!DEFAULT 1.25
//!MIN 0.2
//!MAX 5.0
//!STEP 0.05
float nscale;

//!PARAMETER
//!LABEL NTSC De-dithering Booster: 0: OFF | 1: CB+BAR | 2: CB
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 1
float ntsc_dith;

//!PARAMETER
//!LABEL NTSC Color Saturation
//!DEFAULT 1.0
//!MIN 0.0
//!MAX 2.0
//!STEP 0.01
float ntsc_sat;

//!PARAMETER
//!LABEL NTSC Brightness
//!DEFAULT 1.0
//!MIN 0.0
//!MAX 1.5
//!STEP 0.01
float ntsc_brt;

//!PARAMETER
//!LABEL NTSC Filtering Gamma Correction
//!DEFAULT 1.0
//!MIN 0.25
//!MAX 2.5
//!STEP 0.025
float ntsc_gamma;

//!PARAMETER
//!LABEL NTSC Coloring/Rainbow Effect (2 Phase)
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 3.0
//!STEP 1.0
float ntsc_rainbow;

//!PARAMETER
//!LABEL NTSC # of Taps (Filter Width)
//!DEFAULT 32.0
//!MIN 6.0
//!MAX 32.0
//!STEP 1.0
float ntsc_taps;

//!PARAMETER
//!LABEL NTSC Preserve 'Edge' Colors (2 Phase)
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 10.0
//!STEP 0.5
float ntsc_charp1;

//!PARAMETER
//!LABEL NTSC Preserve 'Edge' Colors (3 Phase)
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 10.0
//!STEP 0.5
float ntsc_charp2;

//!PARAMETER
//!LABEL NTSC Chroma Scaling/Bleeding (2 Phase)
//!DEFAULT 1.0
//!MIN 0.2
//!MAX 5.0
//!STEP 0.05
float ntsc_cscale1;

//!PARAMETER
//!LABEL NTSC Chroma Scaling/Bleeding (3 Phase)
//!DEFAULT 1.0
//!MIN 0.2
//!MAX 2.5
//!STEP 0.05
float ntsc_cscale2;

//!PARAMETER
//!LABEL NTSC Anti-Ringing
//!DEFAULT 0.5
//!MIN 0.0
//!MAX 1.0
//!STEP 0.1
float ntsc_ring;

//!PARAMETER
//!LABEL NTSC Sharpness (Adaptive)
//!DEFAULT 0.0
//!MIN -10.0
//!MAX 10.0
//!STEP 0.5
float ntsc_shrp;

//!PARAMETER
//!LABEL NTSC Preserve Fonts (0.25 = OFF)
//!DEFAULT 0.25
//!MIN 0.25
//!MAX 0.75
//!STEP 0.05
float ntsc_fonts;

//!PARAMETER
//!LABEL NTSC Sharpness Shape
//!DEFAULT 0.8
//!MIN 0.5
//!MAX 1.0
//!STEP 0.025
float ntsc_shpe;

//!PARAMETER
//!LABEL NTSC RF Noise Frequency
//!DEFAULT 0.3
//!MIN 0.0
//!MAX 1.0
//!STEP 0.01
float RFNOISE;

//!PARAMETER
//!LABEL NTSC RF Noise Luma+
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 0.7
//!STEP 0.01
float RFNOISE1;

//!PARAMETER
//!LABEL NTSC RF Noise Chroma+
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 0.7
//!STEP 0.01
float RFNOISE2;

//!PARAMETER
//!LABEL FSharpen - Sharpen Strength
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 5.0
//!STEP 0.1
float CSHARPEN;

//!PARAMETER
//!LABEL FSharpen - Sharpen (+ Deblur) Contrast
//!DEFAULT 0.05
//!MIN 0.0
//!MAX 0.25
//!STEP 0.01
float CCONTR;

//!PARAMETER
//!LABEL FSharpen - Sharpen Details
//!DEFAULT 1.0
//!MIN 0.0
//!MAX 1.0
//!STEP 0.05
float CDETAILS;

//!PARAMETER
//!LABEL FSharpen - Deblur Strength
//!DEFAULT 1.0
//!MIN 1.0
//!MAX 8.0
//!STEP 0.25
float NDEBLUR;

//!PARAMETER
//!LABEL FSharpen - Smart 'Dithering' Deblur
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 1.0
//!STEP 1.0
float DSMART;

//!PARAMETER
//!LABEL FSharpen - Deblur Edges Falloff
//!DEFAULT 0.9
//!MIN 0.7
//!MAX 1.0
//!STEP 0.01
float DREDGE;

//!PARAMETER
//!LABEL FSharpen - Deblur Extra Sharpen
//!DEFAULT 0.0
//!MIN 0.0
//!MAX 4.0
//!STEP 0.2
float DSHARP;

//!TEXTURE
Texture2D INPUT;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
Texture2D OUTPUT;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 4
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D PAAL_T02;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D PAAL_T03;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D PAAL_T04;

//!SAMPLER
//!FILTER POINT
//!ADDRESS CLAMP
SamplerState sPt;

//!SAMPLER
//!FILTER LINEAR
//!ADDRESS CLAMP
SamplerState sLin;

//!COMMON
float  mod(float x, float y)   { return x - y * floor(x / y); }
float2 mod(float2 x, float y)  { return x - y * floor(x / y); }
float3 mod(float3 x, float y)  { return x - y * floor(x / y); }
float3 rgb2yiq(float3 r)
{
	return mul(float3x3(0.2989,0.5870,0.1140,0.5959,-0.2744,-0.3216,0.2115,-0.5229,0.3114), r);
}

float3 yiq2rgb(float3 y)
{
	return mul(float3x3(1.0000,0.9560,0.6210,1.0000,-0.2720,-0.6474,1.0000,-1.1060,1.7046), y);
}

float get_luma(float3 c)
{
	return dot(c,float3(0.2989, 0.5870, 0.1140));
}

float get_luma_sharpen(float3 c)
{
	return dot(c,float3(0.299, 0.587, 0.114));
}

float swoothstep(float e0,float e1,float x)
{
	return clamp((x-e0)/(e1-e0),0.0,1.0);
}

float3 smstep(float3 e0, float3 e1, float3 x)
{
	return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
}

float2 psrnd(float2 TexCoord, float FrameCount) {
    float3 p = float3(TexCoord * 16758.5453, FrameCount);
    float x = frac(sin(dot(p, float3(12.9898, 78.233, 3.183))) * 43758.5453);
    float y = frac(sin(dot(p, float3(25.9796, 14.113, 11.271))) * 96321.9124);
    return float2(x, y);
}

float3 NoiseNP3(float2 TexCoord, float FrameCount) {
float RFNOISE0 = RFNOISE*RFNOISE + 0.00001;
    TexCoord = psrnd(TexCoord, FrameCount);
    float3 p = float3(TexCoord * 758.5453, FrameCount);
    float res1 = frac(sin(dot(p, float3(12.989835, 78.23341, 0.16453))) * 43758.54531);
    float res2 = frac(sin(dot(p, float3(39.34679, 11.13523, 83.15573))) * 39459.32423);
    float res3 = frac(sin(dot(p, float3(73.15691, 52.23504, 9.15197))) * 60493.84731);
    float lns = float(abs(res1-0.5) < 0.2*RFNOISE0);
    float cny = float(abs(res2-0.5) < 0.5*RFNOISE0);
    float cnz = float(abs(res3-0.5) < 0.5*RFNOISE0);
    lns = lns*swoothstep(0.5-0.2*RFNOISE0, 0.5+0.2*RFNOISE0, res1) * 0.66 - 0.33*lns;
    cny = cny*swoothstep(0.5-0.5*RFNOISE0, 0.5+0.5*RFNOISE0, res2)  - 0.5*cny;
    cnz = cnz*swoothstep(0.5-0.5*RFNOISE0, 0.5+0.5*RFNOISE0, res3)  - 0.5*cnz;	
    return float3(lns, cny, cnz);
}

//!PASS 1
//!DESC NTSC pass 1 (modulation)
//!STYLE PS
//!IN INPUT
//!OUT PAAL_T02

float4 Pass1(float2 texcoord)
{
	float2 vtexcoord=texcoord*float2(speedup, 1.0);
	float NOrgSize = (float4(float2(GetInputSize()),GetInputPt()).x < 450.0) ? float4(float2(GetInputSize()),GetInputPt()).x : float4(float2(GetInputSize()),GetInputPt()).x / max(round(float4(float2(GetInputSize()),GetInputPt()).x / 300.0), 1.0);
	float phase = (ntsc_phase < 1.5) ? ((NOrgSize > 300.0 || (float4(float2(GetInputSize()),GetInputPt()).x > 400.0 && float4(float2(GetInputSize()),GetInputPt()).y > 250.0)) ? 2.0 : 3.0) : ((ntsc_phase > 2.5) ? 3.0 : 2.0);
	if(ntsc_phase==4.0)phase=3.0; else if (ntsc_phase == 5.0) phase = 2.0;
	float ntsc_sizex = (float4(float2(GetInputSize()),GetInputPt()).x < 400.0) ? float4(float2(GetInputSize()),GetInputPt()).x : (phase == 2.0) ? 320.0 : 256.0;
	ntsc_sizex = (ntsc_samp < 1.5) ? ntsc_sizex : float4(float2(GetInputSize()),GetInputPt()).x;
	float ntsc_sizey = float4(float2(GetInputSize()),GetInputPt()).y / max(round(float4(float2(GetInputSize()),GetInputPt()).y / 220.0), 1.0);
	float2 pix_no = vtexcoord * float2(ntsc_sizex,ntsc_sizey) * float2(4.0, 1.0);
	pix_no.y = round(pix_no.y);
	float CHROMA_MOD_FREQ=(phase == 2.0 && ntsc_phase != 5.0) ? (4.0 * 3.14159265 / 15.0) : ((NOrgSize <= 300.0 || phase == 3.0) ? (3.14159265 / 3.0) : (3.14159265/2.0));
	float ARTIFACT=cust_artifacting;
	float FRINGING=cust_fringing;
	float BRIGHTNESS=ntsc_brt;
	float SATURATION=ntsc_sat;
	float MERGE=0.0;
	if(ntsc_fields== -1.0&&phase==3.0) MERGE=1.0;else
	if(ntsc_fields== 0.0) MERGE=0.0;else
	if(ntsc_fields== 1.0) MERGE=1.0;
	float MIT = ntsc_taps;
	MIT = swoothstep(16.0, 8.0, MIT) * 0.325;
	float3x3 mix_m = float3x3(BRIGHTNESS,FRINGING,FRINGING,ARTIFACT,2.0*SATURATION,0.0,ARTIFACT,0.0,2.0*SATURATION);
	if (vtexcoord.x > 1.0) return 0.0.xxxx; else
	{
	float3 col0=INPUT.SampleLevel(sPt,vtexcoord,0).rgb;
	float3 yiq1=rgb2yiq(col0);
	yiq1.x=pow(yiq1.x,ntsc_gamma);
	float lum=yiq1.x;
	float3 temp=yiq1;
	float3 yiq2=yiq1;
	float3 yiqs=yiq1;
	float3 yiqz=yiq1;

	float res = nscale;

	if (ntsc_dith > 0.5 && float4(float2(GetInputSize()),GetInputPt()).y < 300.0 && (phase == 2.0 || ntsc_phase > 3.5))
	{
	float2 TexD = (floor(vtexcoord * float4(float2(GetInputSize()),GetInputPt()).xy) + 0.5)*float4(float2(GetInputSize()),GetInputPt()).zw;
	float2 xx = float2(float4(float2(GetInputSize()),GetInputPt()).z, 0.0);

	float2 yy = float2(0.0, float4(float2(GetInputSize()),GetInputPt()).w);
	float3 ca = float3(get_luma(INPUT.SampleLevel(sPt,TexD - xx - xx - yy,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD - xx - xx,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD - xx - xx + yy,0).rgb));
	float3 c0 = float3(get_luma(INPUT.SampleLevel(sPt,TexD - xx - yy,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD - xx,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD - xx + yy,0).rgb));
	float3 c1 = float3(get_luma(INPUT.SampleLevel(sPt,TexD - yy,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD + yy,0).rgb));
	float3 c2 = float3(get_luma(INPUT.SampleLevel(sPt,TexD + xx - yy,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD + xx,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD + xx + yy,0).rgb));
	float3 cb = float3(get_luma(INPUT.SampleLevel(sPt,TexD + xx + xx - yy,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD + xx + xx,0).rgb), get_luma(INPUT.SampleLevel(sPt,TexD + xx + xx + yy,0).rgb));
	float3 line0  = step(min(abs(c1-c0),abs(c2-c1)), 0.01.xxx);
	float3 line1  = max(step(min(abs(ca-c0),abs(c2-cb)), 0.01.xxx), line0);
	float3 line2  = max(step(min(abs(ca-c2),abs(c0-cb)), 0.01.xxx), line1);
	float3 line3  = max(step(max(abs(ca-c0),abs(c2-cb)), 0.15.xxx), line2);
	float3 line4  = max(smstep(0.075.xxx, 0.35*max(c1,1.0-c1), max(min(abs(c1-cb),abs(c0-c2)),min(abs(c1-ca),abs(c0-c2)))), line3);
	float3 line5  = step(min(max(abs(c0-c2),abs(c1-ca)),max(abs(c0-c2),abs(c1-cb))), 0.025.xxx);
	line4 = (ntsc_dith < 1.5) ? line3 : line4;
	line2 = lerp(line4, line0, line5);
	float lmode = (ntsc_dith < 1.5) ? 0.0 : 1.0;
	float line6 = 0.0;
	if (ntsc_dith > 1.5) line6 = min(step(min(abs(c1.y-c1.x),abs(c1.y-c1.z)),0.03), max(step(max(abs(c0.y-c0.x),abs(c0.y-c0.z)),0.03), step(max(abs(c2.y-c2.x),abs(c2.y-c2.z)),0.03)));
	line2.y = ((abs(c1.y-c1.x)+min(abs(c0.y-c0.x),abs(c2.y-c2.x))) < lmode*0.025) ? max(line2.y,line2.x) : line2.y;
	line2.y = ((abs(c1.y-c1.z)+min(abs(c0.y-c0.z),abs(c2.y-c2.z))) < lmode*0.025) ? max(line2.y,line2.z) : line2.y;
	float lin2 = max(min(line2.y, max(line2.x,line2.z)), line6);
	float nd = max(res-1.0, 0.0);
	res /= 1.0 + (1.0-lin2) * nd;
	}

	if(MERGE>0.5)
	{
	float chroma_phase2=(phase<2.5)?3.14159265*(mod(pix_no.y,2.0)+mod(float(int(__frameCount))+1,2.)):0.6667*3.14159265*(mod(pix_no.y,3.0)+mod(float(int(__frameCount))+1,2.));
	float mod_phase2=chroma_phase2+pix_no.x*CHROMA_MOD_FREQ;
	float i_mod2=cos( mod_phase2 );
	float q_mod2=sin( mod_phase2 );
	yiq2.yz*=float2(i_mod2,q_mod2);
	yiq2=mul(mix_m, yiq2);
	yiq2.yz*=float2(i_mod2,q_mod2);
	yiq2.yz =lerp(yiq2.yz,temp.yz,MIT);
	if(res>1.025)
	{
	mod_phase2=chroma_phase2 + pix_no.x * CHROMA_MOD_FREQ * res;
	i_mod2=cos(mod_phase2);
	q_mod2=sin(mod_phase2);
	yiqs.yz*=float2(i_mod2,q_mod2);
	yiq2.x=dot(yiqs,mix_m[0]);
	}
	}
	float chroma_phase1=(phase<2.5)?3.14159265*(mod(pix_no.y,2.0)+mod(float(int(__frameCount))  ,2.)):0.6667*3.14159265*(mod(pix_no.y,3.0)+mod(float(int(__frameCount))  ,2.));
	float mod_phase1=chroma_phase1+pix_no.x*CHROMA_MOD_FREQ;
	float i_mod1=cos( mod_phase1 );
	float q_mod1=sin( mod_phase1 );
	yiq1.yz*=float2(i_mod1,q_mod1);
	yiq1=mul(mix_m, yiq1);
	yiq1.yz*=float2(i_mod1,q_mod1);
	yiq1.yz =lerp(yiq1.yz,temp.yz,MIT);
	if(res>1.025)
	{
	mod_phase1=chroma_phase1 + pix_no.x*CHROMA_MOD_FREQ * res;
	i_mod1=cos(mod_phase1);
	q_mod1=sin(mod_phase1);
	yiqz.yz*=float2(i_mod1,q_mod1);
	yiq1.x=dot(yiqz,mix_m[0]);
	}
	if(ntsc_phase==4.0){yiq1.x=lum;yiq2.x=lum;}
	if(MERGE>0.5){if(ntsc_rainbow<0.5||phase>2.5)yiq1=0.5*(yiq1+yiq2); else yiq1.x=0.5*(yiq1.x+yiq2.x);}
	return float4(yiq1,lum);
	}
}

//!PASS 2
//!DESC NTSC pass 2 (filtering)
//!STYLE PS
//!IN PAAL_T02, INPUT
//!OUT PAAL_T03

float4 Pass2(float2 texcoord)
{
	float2 tex_c=texcoord+float2(0.5/speedup*float4(float2(GetInputSize()),GetInputPt()).z/4.0,0.0);
	float NOrgSize = (float4(float2(GetInputSize()),GetInputPt()).x < 450.0) ? float4(float2(GetInputSize()),GetInputPt()).x : float4(float2(GetInputSize()),GetInputPt()).x / max(round(float4(float2(GetInputSize()),GetInputPt()).x / 300.0), 1.0);
	float phase = (ntsc_phase < 1.5) ? ((NOrgSize > 300.0 || (float4(float2(GetInputSize()),GetInputPt()).x > 400.0 && float4(float2(GetInputSize()),GetInputPt()).y > 250.0)) ? 2.0 : 3.0) : ((ntsc_phase > 2.5) ? 3.0 : 2.0);
	if (ntsc_phase == 4.0) phase = 3.0; else if (ntsc_phase == 5.0) phase = 2.0;
	const int TAPS_2_phase=32;
	const int TAPS_3_phase=24;
	float luma_filter_2_phase[33]={
   -0.000174844,-0.000205844,-0.000149453,-0.000051693, 0.000000000,-0.000066171,-0.000245058,-0.000432928,-0.000472644,-0.000252236, 0.000198929,
    0.000687058, 0.000944112, 0.000803467, 0.000363199, 0.000013422, 0.000253402, 0.001339461, 0.002932972, 0.003983485, 0.003026683,-0.001102056,
   -0.008373026,-0.016897700,-0.022914480,-0.021642347,-0.028863273, 0.027271957, 0.054921920, 0.098342579, 0.139044281, 0.168055832, 0.178571429};
	float chroma_filter_2_phase[33]={
   1.00000, 2.00000, 3.00000, 4.00000, 5.00000, 6.00000, 7.00000, 8.00000, 9.00000, 10.00000, 11.00000, 12.00000, 13.00000, 14.00000, 15.00000,
   16.00000, 17.00000, 18.00000, 19.00000, 20.00000, 21.00000, 22.00000, 23.00000, 24.00000, 25.00000, 26.00000, 27.00000, 28.00000, 29.00000,
   30.00000, 31.00000, 32.00000, 33.00000};
	float chroma_filter_3_phase[33]={
    0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000,
    0.000000000, 0.000000000, 0.000000000,
   -0.000118847,-0.000271306,-0.000502642,-0.000930833,-0.001451013,
   -0.002064744,-0.002700432,-0.003241276,-0.003524948,-0.003350284,
   -0.002491729,-0.000721149, 0.002164659, 0.006313635, 0.011789103,
    0.018545660, 0.026414396, 0.035100710, 0.044196567, 0.053207202,
    0.061590275, 0.068803602, 0.074356193, 0.077856564, 0.079052396};
	if (tex_c.x * speedup > (1.00325)) return float4(0.0,0.0,0.0,0.0);
	float luma_filter_3_phase[33]={
    0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000,
    0.000000000, 0.000000000, 0.000000000,
   -0.000012020,-0.000022146,-0.000013155,-0.000012020,-0.000049979,
   -0.000113940,-0.000122150,-0.000005612, 0.000170516, 0.000237199,
    0.000169640, 0.000285688, 0.000984574, 0.002018683, 0.002002275,
   -0.005909882,-0.012049081,-0.018222860,-0.022606931, 0.002460860,
    0.035868225, 0.084016453, 0.135563500, 0.175261268, 0.220176552};

	float res = nscale;
   
	if (ntsc_dith > 0.5 && float4(float2(GetInputSize()),GetInputPt()).y < 300.0 && (phase == 2.0 || ntsc_phase > 3.5))
	{
	float2 TexD = (floor(tex_c * float4(float2(GetInputSize()),GetInputPt()).xy) + 0.5)*float4(float2(GetInputSize()),GetInputPt()).zw;
	float2 xx = float2(float4(float2(GetInputSize()),GetInputPt()).z, 0.0);

	float2 yy = float2(0.0, float4(float2(GetInputSize()),GetInputPt()).w);
	float3 ca = float3(PAAL_T02.SampleLevel(sLin,TexD - xx - xx - yy,0).a, PAAL_T02.SampleLevel(sLin,TexD - xx - xx,0).a, PAAL_T02.SampleLevel(sLin,TexD - xx - xx + yy,0).a);
	float3 c0 = float3(PAAL_T02.SampleLevel(sLin,TexD - xx - yy,0).a, PAAL_T02.SampleLevel(sLin,TexD - xx,0).a, PAAL_T02.SampleLevel(sLin,TexD - xx + yy,0).a);
	float3 c1 = float3(PAAL_T02.SampleLevel(sLin,TexD - yy,0).a, PAAL_T02.SampleLevel(sLin,TexD,0).a, PAAL_T02.SampleLevel(sLin,TexD + yy,0).a);
	float3 c2 = float3(PAAL_T02.SampleLevel(sLin,TexD + xx - yy,0).a, PAAL_T02.SampleLevel(sLin,TexD + xx,0).a, PAAL_T02.SampleLevel(sLin,TexD + xx + yy,0).a);
	float3 cb = float3(PAAL_T02.SampleLevel(sLin,TexD + xx + xx - yy,0).a, PAAL_T02.SampleLevel(sLin,TexD + xx + xx,0).a, PAAL_T02.SampleLevel(sLin,TexD + xx + xx + yy,0).a);
	float3 line0  = step(min(abs(c1-c0),abs(c2-c1)), 0.01.xxx);
	float3 line1  = max(step(min(abs(ca-c0),abs(c2-cb)), 0.01.xxx), line0);
	float3 line2  = max(step(min(abs(ca-c2),abs(c0-cb)), 0.01.xxx), line1);
	float3 line3  = max(step(max(abs(ca-c0),abs(c2-cb)), 0.15.xxx), line2);
	float3 line4  = max(smstep(0.075.xxx, 0.35*max(c1,1.0-c1), max(min(abs(c1-cb),abs(c0-c2)),min(abs(c1-ca),abs(c0-c2)))), line3);
	float3 line5  = step(min(max(abs(c0-c2),abs(c1-ca)),max(abs(c0-c2),abs(c1-cb))), 0.025.xxx);
	line4 = (ntsc_dith < 1.5) ? line3 : line4;
	line2 = lerp(line4, line0, line5);
	float lmode = (ntsc_dith < 1.5) ? 0.0 : 1.0;
	float line6 = 0.0;
	if (ntsc_dith > 1.5) line6 = min(step(min(abs(c1.y-c1.x),abs(c1.y-c1.z)),0.03), max(step(max(abs(c0.y-c0.x),abs(c0.y-c0.z)),0.03), step(max(abs(c2.y-c2.x),abs(c2.y-c2.z)),0.03)));
	line2.y = ((abs(c1.y-c1.x)+min(abs(c0.y-c0.x),abs(c2.y-c2.x))) < lmode*0.025) ? max(line2.y,line2.x) : line2.y;
	line2.y = ((abs(c1.y-c1.z)+min(abs(c0.y-c0.z),abs(c2.y-c2.z))) < lmode*0.025) ? max(line2.y,line2.z) : line2.y;
	float lin2 = max(min(line2.y, max(line2.x,line2.z)), line6);
	float nd = max(res-1.0, 0.0);
	res /= 1.0 + (1.0-lin2) * nd;
	}

	float ntsc_sizex = (ntsc_samp > 1.5) ? float4(float2(GetInputSize()),GetInputPt()).x : ((float4(float2(GetInputSize()),GetInputPt()).x < 400.0) ? float4(float2(GetInputSize()),GetInputPt()).x : (phase == 2.0) ? 320.0 : 256.0);
	float2 one_x = 0.25 / ntsc_sizex.xx;
	one_x.x = one_x.x / res / speedup;
	one_x.y = one_x.y / speedup;
   
	float3 signal = float3(0.0, 0.0, 0.0);
	if(ntsc_phase>3.5){luma_filter_3_phase=luma_filter_2_phase;}
	float offset=0.0;int i=0; float j =0.0;
	float3 wsum =0.0.xxx;
	float3 sums=wsum;
	float3 tmps=wsum;
	if(phase<2.5)
	{
	one_x.y = one_x.y/ntsc_cscale1;
	float3 dx = float3(one_x.x, one_x.y, 0.0);
	float mit = 1.0;
	float loob = ntsc_taps;
	loob = max(loob, 8.0); mit = 1.0 + 0.04*pow(swoothstep(16.0, 8.0, loob), 0.5);
	float3 xd = dx; dx.x*=mit;
	int loopstart = int(32.0 - loob);
	int j = loopstart;
	for(i=loopstart;i<32;i++)
	{
	offset = float(i-loopstart); xd.xy = (offset - loob)*dx.xy;
	j = i - loopstart;
	sums = float3(PAAL_T02.SampleLevel(sLin,tex_c+(xd).xz,0).x+PAAL_T02.SampleLevel(sLin,tex_c-(xd).xz,0).x,PAAL_T02.SampleLevel(sLin,tex_c+(xd).yz,0).yz+PAAL_T02.SampleLevel(sLin,tex_c-(xd).yz,0).yz);
	tmps = float3(luma_filter_2_phase[i], chroma_filter_2_phase[j].xx);
	wsum=wsum+tmps;
	signal+=sums*tmps;
	}
	j = int(loob);
	tmps=float3(luma_filter_2_phase[TAPS_2_phase], chroma_filter_2_phase[j], chroma_filter_2_phase[j]);
	wsum=wsum+wsum+tmps;
	signal+=PAAL_T02.SampleLevel(sLin,tex_c,0).xyz*tmps;
	signal =signal/wsum;
	}else
	{
	one_x.y=one_x.y/ntsc_cscale2;
	float3 dx=float3(one_x.x,one_x.y,0.0);
	float mit=1.0;
	float loob=min(ntsc_taps,TAPS_3_phase); 
	if(ntsc_phase>3.5){loob=max(loob,8.0); mit=1.0+0.04*pow(swoothstep(16.0,8.0,loob),0.5);}
	float3 xd=dx; dx.x*=mit;
	int loopstart=int(32.0-loob);
	for(i=loopstart;i<32;i++)
	{
	offset=float(i-loopstart); xd.xy=(offset-loob)*dx.xy;
	sums=float3(PAAL_T02.SampleLevel(sLin,tex_c+(xd).xz,0).x+PAAL_T02.SampleLevel(sLin,tex_c-(xd).xz,0).x,PAAL_T02.SampleLevel(sLin,tex_c+(xd).yz,0).yz+PAAL_T02.SampleLevel(sLin,tex_c-(xd).yz,0).yz);
	tmps=float3(luma_filter_3_phase[i], chroma_filter_3_phase[i].xx);
	wsum=wsum+tmps;
	signal+=sums*tmps;
	}
	tmps=float3(luma_filter_3_phase[TAPS_2_phase], chroma_filter_3_phase[TAPS_2_phase], chroma_filter_3_phase[TAPS_2_phase]);
	wsum=wsum+wsum+tmps;
	signal+=PAAL_T02.SampleLevel(sLin,tex_c,0).xyz*tmps;
	signal =signal/wsum;
	}
	signal.x=clamp( signal.x,0.0,1.0);
	if(ntsc_ring>0.05)
	{
	float2 dx=float2(float4(float2(GetInputSize()),GetInputPt()).z/min(res,1.0)/speedup,0.0);
	float a=PAAL_T02.SampleLevel(sLin,tex_c-2.0*dx,0).a;
	float b=PAAL_T02.SampleLevel(sLin,tex_c-    dx,0).a;
	float c=PAAL_T02.SampleLevel(sLin,tex_c+2.0*dx,0).a;
	float d=PAAL_T02.SampleLevel(sLin,tex_c+    dx,0).a;
	float e=PAAL_T02.SampleLevel(sLin,tex_c,0).a;
	signal.x=lerp(signal.x,clamp(signal.x,min(min(min(a,b),min(c,d)),e),max(max(max(a,b),max(c,d)),e)),ntsc_ring);
	}
	float x=get_luma(INPUT.SampleLevel(sPt,tex_c*float2(speedup, 1.0),0).rgb);
	return float4(signal,x);
}

//!PASS 3
//!DESC NTSC pass 3 (demodulation)
//!STYLE PS
//!IN PAAL_T03, PAAL_T02, INPUT
//!OUT PAAL_T04

float4 Pass3(float2 texcoord)
{
    float auto_rez = lerp(1.0, 0.5, clamp(auto_res * round(float4(float2(GetInputSize()),GetInputPt()).x/300.0)-1.0, 0.0, 1.0));
    float2 vtex_c0=texcoord / float2(speedup, 1.0);
    float2 vtex_c1=(floor(vtex_c0*float4(float2(GetInputSize()),GetInputPt()).xy)+0.5)*float4(float2(GetInputSize()),GetInputPt()).zw;
    float2 vtex_c=texcoord+float2(0.5*(float4(float2(GetInputSize()),GetInputPt()).z/auto_rez)/4.0,0.0);
    float NOrgSize = (float4(float2(GetInputSize()),GetInputPt()).x < 450.0) ? float4(float2(GetInputSize()),GetInputPt()).x : float4(float2(GetInputSize()),GetInputPt()).x / max(round(float4(float2(GetInputSize()),GetInputPt()).x / 300.0), 1.0);
    float phase = (ntsc_phase < 1.5) ? ((NOrgSize > 300.0 || (float4(float2(GetInputSize()),GetInputPt()).x > 400.0 && float4(float2(GetInputSize()),GetInputPt()).y > 250.0)) ? 2.0 : 3.0) : ((ntsc_phase > 2.5) ? 3.0 : 2.0);
    if (ntsc_phase == 4.0) phase = 3.0; else if (ntsc_phase == 5.0) phase = 2.0;

    float4 AdvSize= float4(2.0*float2(GetInputSize()).x,1.0*float2(GetInputSize()).y,1.0/(2.0*float2(GetInputSize()).x),1.0/(1.0*float2(GetInputSize()).y));

    if(speedup > 1.25 && ((float4(float2(GetInputSize()),GetInputPt()).y > 500.0 && AdvSize.y > 820.0) || AdvSize.y > 820.0))
    {
        float3 signal = PAAL_T03.SampleLevel(sLin,vtex_c0,0).xyz;
        signal.x = pow(signal.x, 1.0/ntsc_gamma);
        return float4(clamp(yiq2rgb(signal), 0.0, 1.0), 1.0);
    }
    else
    {

	float2 xx=float2(0.5000*float4(float2(GetInputSize()),GetInputPt()).z/auto_rez/speedup,0.0);
	float2 dx=float2(0.0625*float4(float2(GetInputSize()),GetInputPt()).z/auto_rez/speedup,0.0);

	float2 tcoorb=(floor(float4(float2(GetInputSize()),GetInputPt()).xy*vtex_c)+0.5)*float4(float2(GetInputSize()),GetInputPt()).zw;
	float2 tcoord=vtex_c-2.0*dx;
	float2 vTex=vtex_c;
	if (speedup > 1.25) { tcoorb = vtex_c1; tcoord = vtex_c0; vTex = vtex_c0; }
	float3 ll1=PAAL_T03.SampleLevel(sLin,tcoord+ xx,0).xyz;
	float3 ll2=PAAL_T03.SampleLevel(sLin,tcoord- xx,0).xyz;
	float dy=0.0;
	float2 yy = float2(0.0, float4(float2(GetInputSize()),GetInputPt()).w);
	xx=float2(float4(float2(GetInputSize()),GetInputPt()).z/auto_rez/speedup,0.0);
	float th=(phase<2.5)?0.025:0.0075;;
	float ca=PAAL_T02.SampleLevel(sLin,tcoorb-xx-xx,0).a;
	float c0=PAAL_T02.SampleLevel(sLin,tcoorb-xx,0).a;
	float c1=PAAL_T02.SampleLevel(sLin,tcoorb,0).a;
	float c2=PAAL_T02.SampleLevel(sLin,tcoorb+xx,0).a;
	float cb=PAAL_T02.SampleLevel(sLin,tcoorb+xx+xx,0).a;
	float line0=    swoothstep(th,0.0,min(abs(c1-c0),abs(c2-c1)));
	float line1=max(swoothstep(th,0.0,min(abs(ca-c0),abs(c2-cb))), line0 );
	float line2=max(swoothstep(th,0.0,min(abs(ca-c2),abs(c0-cb))), line1 );

    float diffboost = 0.0;

    if (ntsc_fonts > 0.255)
    {
        float m1 = max(max(c0,c1),c2);
        float m2 = min(min(c0,c1),c2);
        float cont = m1+m2;

        float b1  = PAAL_T02.SampleLevel(sLin,tcoorb - yy,0).a;
        float d1  = PAAL_T02.SampleLevel(sLin,tcoorb + yy,0).a;
        float d2  = PAAL_T02.SampleLevel(sLin,tcoorb + xx + yy,0).a;

        float maxdif = float(0.5 * (abs(c0-c1) + abs(c1-c2)) > (cont - ntsc_fonts)) * float(abs(c2-c0) < 0.05);
        float linecb = swoothstep(0.1, 0.0, max(abs(c1-b1), abs(c1-d1)));
        linecb = linecb * float(abs(c1-b1) < 0.05 || abs(c2-d2) < 0.05);

        b1 = PAAL_T03.SampleLevel(sLin,tcoord,0).x;

        for (float i = 3.0; i <= 12.0; i = i + 3.0)
        {
            d1 = PAAL_T03.SampleLevel(sLin,tcoord - i*yy,0).x;
            d2 = PAAL_T03.SampleLevel(sLin,tcoord + i*yy,0).x;
            maxdif = max(maxdif, maxdif * float((abs(d1-b1) > 0.25 || abs(d2-b1) > 0.25)));
        }

        float xdif1 = 0.0;
        float xdif2 = 0.0;
        float th   = 0.215;

        for (float i = 0.5; i < 10.5; i++)
        {
            float j = i + 1.0;
            ca  = PAAL_T03.SampleLevel(sLin,tcoord -  i*xx,0).x;
            c0  = PAAL_T03.SampleLevel(sLin,tcoord -  j*xx,0).x;
            c2 = PAAL_T03.SampleLevel(sLin,tcoord +  i*xx,0).x;
            cb = PAAL_T03.SampleLevel(sLin,tcoord +  j*xx,0).x;
            xdif1 = max(abs(ca - c0) - th, xdif1);
            xdif2 = max(abs(cb - c2) - th, xdif2);
            ca = PAAL_T03.SampleLevel(sLin,tcoord -  i*xx - yy,0).x;
            c0 = PAAL_T03.SampleLevel(sLin,tcoord -  j*xx - yy,0).x;
            c2 = PAAL_T03.SampleLevel(sLin,tcoord +  i*xx - yy,0).x;
            cb = PAAL_T03.SampleLevel(sLin,tcoord +  j*xx - yy,0).x;  
            xdif1 = max(abs(ca-c0)-th, xdif1);
            xdif2 = max(abs(cb-c2)-th, xdif2);   
      
            ca = PAAL_T03.SampleLevel(sLin,tcoord -  i*xx + yy,0).x;
            c0 = PAAL_T03.SampleLevel(sLin,tcoord -  j*xx + yy,0).x;
            c2 = PAAL_T03.SampleLevel(sLin,tcoord +  i*xx + yy,0).x;
            cb = PAAL_T03.SampleLevel(sLin,tcoord +  j*xx + yy,0).x;  
            xdif1 = max(abs(ca-c0)-th, xdif1);
            xdif2 = max(abs(cb-c2)-th, xdif2);
        }

        float linex   = swoothstep(0.0, 0.125, min(xdif1, xdif2));
        diffboost     = min(linex * linecb * maxdif, 0.75);
    }

    float3 ref = PAAL_T03.SampleLevel(sLin,tcoord,0).xyz;
    float2 org = ref.yz;
	if( ntsc_rainbow>0.5&&(phase<2.5 || ntsc_phase == 5.0))
	{
	float ybool1=1.0;
	if((ntsc_rainbow<1.5)&&bool(line0))ybool1=0.0;else
	if((ntsc_rainbow<2.5)&&bool(line2))ybool1=0.0;

	float liine_no=floor( mod(float4(float2(GetInputSize()),GetInputPt()).y*vtex_c.y,2.0));
	float frame_no=floor( mod(float(int(__frameCount)),2.0));
	float ii=abs(liine_no-frame_no);
	dy=ii*float4(float2(GetInputSize()),GetInputPt()).w*ybool1;
	float2 ref1 = PAAL_T03.SampleLevel(sLin,tcoord + float2(0.0, -dy),0).yz;
				   
	float2 ref2 = PAAL_T03.SampleLevel(sLin,tcoord + float2(0.0,  dy),0).yz;
	float2 rdf1 = abs(org - ref1);
	float2 rdf2 = abs(org - ref2);
	rdf1        = rdf1 / max(rdf1 + rdf2, 0.0000001);

	ref.yz = lerp(ref1, ref2, rdf1);
	}
	float lum1=min(PAAL_T02.SampleLevel(sLin,vTex-dx,0).a, PAAL_T02.SampleLevel(sLin,vTex+dx,0).a);
	float lum2=ref.x ;
	float3 ll3=abs(ll1-ll2);
	float di=max(max(max(ll3.x,ll3.y),max(ll3.z,abs(ll1.x*ll1.x-ll2.x*ll2.x))),diffboost);
	float df=pow(di,0.125);
	float lc=swoothstep(0.20,0.10,abs(lum2-lum1))*df;
	float tmp1=swoothstep(0.05-0.03*lc,0.425-0.375*lc,di);
	float tmp2=pow((tmp1+0.1)/1.1,0.25);
	float sweight=lerp(tmp1,tmp2,line0);
	float zweight=lerp(tmp1,tmp2,line2);
	float3 signal=ref;
	float ntzc_shrp= abs(ntsc_shrp);
	if(ntzc_shrp>0.25 || ntsc_fonts > 0.255)
	{
	float mixer=zweight;
	if(ntsc_shrp < -0.25)mixer=sweight; mixer*=max(0.1*ntzc_shrp, diffboost*1.25);
	float lumix=lerp(lum2,lum1,mixer);
	float lm1=lerp(lum2*lum2 ,lum1*lum1 ,mixer);lm1=sqrt(lm1);
	float lm2=lerp(sqrt(lum2),sqrt(lum1),mixer);lm2=lm2* lm2 ;
	float k1=abs(lumix-lm1)+0.00001;
	float k2=abs(lumix-lm2)+0.00001;
	signal.x=min((k2*lm1+k1*lm2)/(k1+k2),1.0);
	signal.x=min(signal.x,max(ntsc_shpe*signal.x,lum2));
	}
	if((ntsc_charp1+ntsc_charp2)>0.25)
	{
	dx.x = 0.0625 * float4(float2(GetInputSize()),GetInputPt()).z/auto_rez;
	float lcoord=float4(float2(GetInputSize()),GetInputPt()).x*(vtex_c.x+dx.x )-0.5;
	float fpx=frac(lcoord);
	lcoord =(floor(lcoord)+0.5)*float4(float2(GetInputSize()),GetInputPt()).z;
	float mixer=sweight;
	if(ntsc_shrp>0.25)mixer=zweight;
	mixer =lerp(swoothstep(0.075,0.125,max(ll3.y,ll3.z)),swoothstep(0.015,0.0275,di),line2)*mixer;
	mixer*=0.1*((phase<2.5)? ntsc_charp1:ntsc_charp2);
	tcoord=float2(lcoord,tcoord.y);
	float3 origin=rgb2yiq(lerp(INPUT.SampleLevel(sPt,tcoord,0).rgb,INPUT.SampleLevel(sPt,tcoord+16.0*dx,0).rgb,clamp(1.5*fpx-0.25,0.0,1.0)));
	signal.yz=lerp(signal.yz,origin.yz,mixer);
	}

    if ((RFNOISE1 + RFNOISE2) > 0.005)
    {
        float3 ns = NoiseNP3(vtex_c, float(int(__frameCount)));
        float Y   = lerp(0.375, 1.0, pow(signal.x, 0.2));

        signal.x = clamp(signal.x + RFNOISE1 * ns.x,  0.00, 1.00);
        signal.y = clamp(signal.y + Y * RFNOISE2 * (0.325 + 1.325 * abs(signal.y)) * ns.y, -0.60, 0.60);
        signal.z = clamp(signal.z + Y * RFNOISE2 * (0.325 + 1.325 * abs(signal.z)) * ns.z, -0.53, 0.53);
    }
	signal.x=pow(signal.x,1.0/ntsc_gamma);
	signal=clamp(yiq2rgb(signal),0.0,1.0);
    zweight = (phase == 2.0 || ntsc_phase > 3.5) ? zweight : 1.0;
	return float4(signal,zweight);
    }
}

//!PASS 4
//!DESC FSharpen
//!STYLE PS
//!IN PAAL_T04, INPUT
//!OUT OUTPUT

float4 Pass4(float2 texcoord)
{
	float resmult = round(float4(float2(GetInputSize()),GetInputPt()).x / 300.0);
	float2 g01=float2(-0.5*resmult*float4(float2(GetInputSize()),GetInputPt()).z,0.0);
	float2 g21=float2( 0.5*resmult*float4(float2(GetInputSize()),GetInputPt()).z,0.0);
	float3 c01=PAAL_T04.SampleLevel(sPt,texcoord+g01,0).rgb;
	float3 c21=PAAL_T04.SampleLevel(sPt,texcoord+g21,0).rgb;
	float3 c11=PAAL_T04.SampleLevel(sPt,texcoord,0).rgb;
	float3 b11=0.5*(c01+c21);
	float contrazt=max(max(c11.r,c11.g),c11.b);
	contrazt=lerp(2.0*CCONTR,CCONTR,contrazt);
	float3 nim=min(min(c01,c21),c11);float3 mn1=min(nim,c11*(1.0-contrazt));
	float3 xam=max(max(c01,c21),c11);float3 mx1=max(xam,c11*(1.0+contrazt));
	float3 di0=pow(mx1-mn1+0.00001,0.75);
	float3 sharpen=lerp(CSHARPEN*CDETAILS,CSHARPEN,di0);
	float3 res=clamp(lerp(c11,b11,-sharpen),mn1,mx1);
	if(NDEBLUR>1.125)
	{
	float2 toxcoord=(floor(float4(float2(GetInputSize()),GetInputPt()).xy*texcoord)+0.5)*float4(float2(GetInputSize()),GetInputPt()).zw;
	float l01=get_luma_sharpen(INPUT.SampleLevel(sPt,texcoord+2.0*g01,0).rgb);
	float l21=get_luma_sharpen(INPUT.SampleLevel(sPt,texcoord+2.0*g21,0).rgb);
	float l11=get_luma_sharpen(INPUT.SampleLevel(sPt,toxcoord,0).rgb);
	float dth = PAAL_T04.SampleLevel(sPt,texcoord,0).a;
	float DEB = max(lerp(0.375*NDEBLUR, NDEBLUR, max(1.0-DSMART, dth)), 1.0);
	float d11=min(min(l01,l21),l11);
	l11=max(max(l01,l21),l11);
	float lmn=min(min(get_luma_sharpen(c01),get_luma_sharpen(c21)),get_luma_sharpen(c11));float ln1=min(lerp(d11,lmn,lmn),lmn);
	float lmx=max(max(get_luma_sharpen(c01),get_luma_sharpen(c21)),get_luma_sharpen(c11));float lx1=max(lerp(lmx,l11,lmx),lmx);
	float r11=get_luma_sharpen(res);
	float di1=max((r11-ln1),0.0)+0.00001;di1=pow(di1,DEB);
	float di2=max((lx1-r11),0.0)+0.00001;di2=pow(di2,DEB);
	float ratio=di1/(di1+di2);
	float zharpen=lerp(ln1,lx1,ratio);
	zharpen=min(zharpen,max(DREDGE*zharpen,r11));
	res=rgb2yiq(res);
	d11=res.x;
	res.x=zharpen;
	res.x=clamp((1.0+ DSHARP)* res.x-DSHARP*d11,ln1*(1.0-contrazt),lx1*(1.0+contrazt));
	res=max(yiq2rgb(res),0.0);
	}
	return float4(res,1.0);
}
