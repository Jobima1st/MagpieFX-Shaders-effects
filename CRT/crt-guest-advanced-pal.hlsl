//!MAGPIE EFFECT
//!VERSION 4
//!USE _DYNAMIC
//!SORT_NAME crt-guest-advanced-pal

// MagpieFX port of crt-guest-advanced-pal (guest.r, slang release 2026-11-03-release1), translated directly from the .slang sources.
// INPUT is treated as the native game resolution: run the game window at 1x and let Magpie do the scaling.

//!PARAMETER
//!LABEL [AFTERGLOW SETTINGS] Afterglow Effect Source: OriginalHistory | Source
//!DEFAULT 1
//!MIN 1
//!MAX 2
//!STEP 1
float esrc;

//!PARAMETER
//!LABEL [AFTERGLOW SETTINGS] Afterglow Effect Threshold
//!DEFAULT 4
//!MIN 1
//!MAX 125
//!STEP 1
float bth;

//!PARAMETER
//!LABEL [AFTERGLOW SETTINGS] Persistence Red
//!DEFAULT 0.32
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float PR;

//!PARAMETER
//!LABEL [AFTERGLOW SETTINGS] Persistence Green
//!DEFAULT 0.32
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float PG;

//!PARAMETER
//!LABEL [AFTERGLOW SETTINGS] Persistence Blue
//!DEFAULT 0.32
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float PB;

//!PARAMETER
//!LABEL [AFTERGLOW SETTINGS] Afterglow Strength
//!DEFAULT 0.2
//!MIN 0
//!MAX 0.6
//!STEP 0.01
float AS;

//!PARAMETER
//!LABEL [AFTERGLOW SETTINGS] Afterglow saturation
//!DEFAULT 0.5
//!MIN 0
//!MAX 1
//!STEP 0.01
float agsat;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Display Gamut: sRGB, Modern, DCI, Adobe, Rec.2020, P3
//!DEFAULT 0
//!MIN 0
//!MAX 5
//!STEP 1
float CS;

//!PARAMETER
//!LABEL [COLOR TWEAKS] CRT Profile: EBU | P22 | SMPTE-C | Philips | Trin.
//!DEFAULT 0
//!MIN -1
//!MAX 5
//!STEP 1
float CP;

//!PARAMETER
//!LABEL [COLOR TWEAKS] LUT Colors: NTSC-J | Trinit. | Nec Mult. | NTSC 1953
//!DEFAULT 0
//!MIN 0
//!MAX 4
//!STEP 1
float TNTC;

//!PARAMETER
//!LABEL [COLOR TWEAKS] LUT Size
//!DEFAULT 32
//!MIN 16
//!MAX 64
//!STEP 16
float LS;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Color Temperature %
//!DEFAULT 0
//!MIN -100
//!MAX 100
//!STEP 5
float WP;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Saturation Adjustment
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.05
float wp_saturation;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Brightness Adjustment
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.01
float pre_bb;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Contrast Adjustment
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.05
float contr;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Gamma Correct Adjustment
//!DEFAULT 1
//!MIN 0.5
//!MAX 1.75
//!STEP 0.025
float pre_gc;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Sega Brightness Fix
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float sega_fix;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Sega MS Blue Lift
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float segams;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Sega MD Pallete Fix
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float segapal;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Lower Black Level
//!DEFAULT 0
//!MIN -100
//!MAX 0
//!STEP 1
float BP;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Raise Black Level
//!DEFAULT 0
//!MIN 0
//!MAX 25
//!STEP 1
float BP1;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Vignette Strength
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 0.05
float vigstr;

//!PARAMETER
//!LABEL [COLOR TWEAKS] Vignette Size
//!DEFAULT 1
//!MIN 0.5
//!MAX 3
//!STEP 0.1
float vigdef;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Interlace Trigger Resolution :
//!DEFAULT 375
//!MIN 0
//!MAX 800
//!STEP 25
float inter;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Interlace Mode: OFF, Normal 1-3,6; Interpolation 4-5
//!DEFAULT 4
//!MIN 0
//!MAX 6
//!STEP 1
float interm;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Interlacing Scanline Effect ('Laced brightness)
//!DEFAULT 0.2
//!MIN 0
//!MAX 1
//!STEP 0.05
float iscan;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] INFO --> Internal Resolution Y: 1.0 - Smart Scanline Mode
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float info02;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Internal Resolution Y: 0.5...y-dowsample divider
//!DEFAULT 0
//!MIN 0
//!MAX 10
//!STEP 0.5
float intres;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Downsampling-X (High-res content, pre-scalers)
//!DEFAULT 0
//!MIN 0
//!MAX 3
//!STEP 0.05
float downsample_levelx;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Downsampling-Y (High-res content, pre-scalers)
//!DEFAULT 0
//!MIN 0
//!MAX 3
//!STEP 0.05
float downsample_levely;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Interlacing (Scanline) Saturation
//!DEFAULT 0.25
//!MIN 0
//!MAX 1
//!STEP 0.05
float iscans;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] High Resolution Scanlines (prepend a scaler...)
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float hiscan;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Connection: RF | Composite | S-Video | SCART
//!DEFAULT 2
//!MIN 1
//!MAX 4
//!STEP 1
float PAL_FILT;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] Horizontal Filtering Resolution
//!DEFAULT 1
//!MIN 0.5
//!MAX 8
//!STEP 0.05
float filter_res;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] SNES/Amiga Hi-Res Auto Mode
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float auto_res;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Phase: Auto | Progressive | Laced (Dot Crawl)
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 1
float PHMOD;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Artifacting Value
//!DEFAULT 0.4
//!MIN 0
//!MAX 5
//!STEP 0.1
float ARTIFACTING;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Fringing Value
//!DEFAULT 0.4
//!MIN 0
//!MAX 5
//!STEP 0.1
float FRINGING;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Saturation Boost
//!DEFAULT 1.05
//!MIN 0
//!MAX 2
//!STEP 0.01
float SATURATION;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Brightness
//!DEFAULT 1
//!MIN 0
//!MAX 1.5
//!STEP 0.01
float BRIGHTNESS;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL UV Chroma Filter
//!DEFAULT 1
//!MIN 1
//!MAX 2
//!STEP 1
float CHROMAF;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Delay Line | Merge
//!DEFAULT 2
//!MIN 1
//!MAX 4
//!STEP 1
float DLINE;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Y Gamma Correct
//!DEFAULT 1.15
//!MIN 1
//!MAX 2.6
//!STEP 0.05
float GCORR;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL RF Noise Frequency
//!DEFAULT 0.3
//!MIN 0
//!MAX 1
//!STEP 0.01
float RFNOISE;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL RF Noise Luma+
//!DEFAULT 0
//!MIN 0
//!MAX 0.7
//!STEP 0.01
float RFNOISE1;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL RF Noise Chroma+
//!DEFAULT 0
//!MIN 0
//!MAX 0.7
//!STEP 0.01
float RFNOISE2;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Resolution: Connection/Core
//!DEFAULT 1
//!MIN 1
//!MAX 2
//!STEP 1
float pal_res;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Resolution: Scaling
//!DEFAULT 1
//!MIN 0.2
//!MAX 2.5
//!STEP 0.025
float pal_scale;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Resolution: Chroma Scaling/Bleed
//!DEFAULT 1
//!MIN 0.5
//!MAX 2.5
//!STEP 0.05
float pal_chroma;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Resolution: De-dithering Booster
//!DEFAULT 0
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float pal_dith;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] PAL Anti Ringing
//!DEFAULT 0.7
//!MIN 0
//!MAX 1
//!STEP 0.05
float pal_ring;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] FSharpen - Sharpen strength
//!DEFAULT 0
//!MIN 0
//!MAX 5
//!STEP 0.1
float CSHARPEN;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] FSharpen - Sharpen(+Deb) Contrast
//!DEFAULT 0.05
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float CCONTR;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] FSharpen - Details sharpened
//!DEFAULT 1
//!MIN 0
//!MAX 1
//!STEP 0.05
float CDETAILS;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] FSharpen - Deblur Strength
//!DEFAULT 1
//!MIN 1
//!MAX 8
//!STEP 0.25
float NDEBLUR;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] FSharpen - Deblur Edge Falloff
//!DEFAULT 0.9
//!MIN 0.7
//!MAX 1
//!STEP 0.01
float DEDGE;

//!PARAMETER
//!LABEL [INTERLACING OPTIONS] FSharpen - Deblur Extra Sharpen
//!DEFAULT 0
//!MIN 0
//!MAX 4
//!STEP 0.2
float DESHARP;

//!PARAMETER
//!LABEL [RASTER BLOOM OPTIONS] Raster Bloom Effect Smoothing
//!DEFAULT 0.7
//!MIN 0.5
//!MAX 0.99
//!STEP 0.01
float lsmooth;

//!PARAMETER
//!LABEL [RASTER BLOOM OPTIONS] Raster Bloom Smoothing Bright Deviation
//!DEFAULT 0
//!MIN -0.25
//!MAX 0.25
//!STEP 0.01
float lsdev;

//!PARAMETER
//!LABEL [RASTER BLOOM OPTIONS] R. Bloom Overscan Mode
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 1
float OS;

//!PARAMETER
//!LABEL [RASTER BLOOM OPTIONS] Raster bloom %
//!DEFAULT 0
//!MIN 0
//!MAX 20
//!STEP 1
float BLOOM;

//!PARAMETER
//!LABEL [GAMMA OPTIONS] Gamma Input
//!DEFAULT 2
//!MIN 1
//!MAX 5
//!STEP 0.05
float GAMMA_INPUT;

//!PARAMETER
//!LABEL [GAMMA OPTIONS] Gamma out
//!DEFAULT 1.95
//!MIN 1
//!MAX 5
//!STEP 0.05
float gamma_out;

//!PARAMETER
//!LABEL [FILTERING OPTIONS] Horizontal Filter Range
//!DEFAULT 1.6
//!MIN 1
//!MAX 8
//!STEP 0.05
float HSHARPNESS;

//!PARAMETER
//!LABEL [FILTERING OPTIONS] Horizontal Blur Sigma
//!DEFAULT 0.5
//!MIN 0.15
//!MAX 1
//!STEP 0.01
float SIGMA_HOR;

//!PARAMETER
//!LABEL [FILTERING OPTIONS] Substractive Sharpness
//!DEFAULT 1.1
//!MIN 0
//!MAX 3
//!STEP 0.05
float S_SHARP;

//!PARAMETER
//!LABEL [FILTERING OPTIONS] Maximum Sharpness
//!DEFAULT 0.21
//!MIN 0
//!MAX 0.3
//!STEP 0.01
float MAXS;

//!PARAMETER
//!LABEL [FILTERING OPTIONS] Substractive Sharpness Ringing
//!DEFAULT 0.3
//!MIN 0
//!MAX 4
//!STEP 0.05
float HARNG;

//!PARAMETER
//!LABEL [FILTERING OPTIONS] Scanline Spike Removal
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.1
float spike;

//!PARAMETER
//!LABEL [MAGIC GLOW SETTINGS] Ordinary Glow / Magic Glow
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 1
float m_glow;

//!PARAMETER
//!LABEL [MAGIC GLOW SETTINGS] Magic Glow Cutoff
//!DEFAULT 0.12
//!MIN 0
//!MAX 0.4
//!STEP 0.01
float m_glow_cutoff;

//!PARAMETER
//!LABEL [MAGIC GLOW SETTINGS] Magic Glow Low Strength
//!DEFAULT 0.35
//!MIN 0
//!MAX 7
//!STEP 0.05
float m_glow_low;

//!PARAMETER
//!LABEL [MAGIC GLOW SETTINGS] Magic Glow High Strength
//!DEFAULT 5
//!MIN 0
//!MAX 7
//!STEP 0.1
float m_glow_high;

//!PARAMETER
//!LABEL [MAGIC GLOW SETTINGS] Magic Glow Distribution
//!DEFAULT 1
//!MIN 0.2
//!MAX 4
//!STEP 0.05
float m_glow_dist;

//!PARAMETER
//!LABEL [MAGIC GLOW SETTINGS] Magic Glow Mask Strength
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.025
float m_glow_mask;

//!PARAMETER
//!LABEL [GLOW PASS SETTINGS] Fine Glow/M.Glow Sampling
//!DEFAULT 1
//!MIN -1
//!MAX 5
//!STEP 1
float FINE_GLOW;

//!PARAMETER
//!LABEL [GLOW PASS SETTINGS] Horizontal Glow Radius
//!DEFAULT 6
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEH;

//!PARAMETER
//!LABEL [GLOW PASS SETTINGS] Horizontal Glow Sigma
//!DEFAULT 1.2
//!MIN 0.2
//!MAX 3
//!STEP 0.01
float SIGMA_H;

//!PARAMETER
//!LABEL [GLOW PASS SETTINGS] Vertical Glow Radius
//!DEFAULT 6
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEV;

//!PARAMETER
//!LABEL [GLOW PASS SETTINGS] Vertical Glow Sigma
//!DEFAULT 1.2
//!MIN 0.2
//!MAX 3
//!STEP 0.01
float SIGMA_V;

//!PARAMETER
//!LABEL [BLOOM/HALATION/(GLOW) PASS SETTINGS] Fine Bloom/Halation Sampling
//!DEFAULT 1
//!MIN -1
//!MAX 5
//!STEP 1
float FINE_BLOOM;

//!PARAMETER
//!LABEL [BLOOM/HALATION/(GLOW) PASS SETTINGS] Horizontal Bloom/Halation Radius
//!DEFAULT 3
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEHB;

//!PARAMETER
//!LABEL [BLOOM/HALATION/(GLOW) PASS SETTINGS] Horizontal Bloom/Halation Sigma
//!DEFAULT 0.75
//!MIN 0.25
//!MAX 3
//!STEP 0.01
float SIGMA_HB;

//!PARAMETER
//!LABEL [BLOOM/HALATION/(GLOW) PASS SETTINGS] Vertical Bloom/Halation Radius
//!DEFAULT 3
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEVB;

//!PARAMETER
//!LABEL [BLOOM/HALATION/(GLOW) PASS SETTINGS] Vertical Bloom/Halation Sigma
//!DEFAULT 0.6
//!MIN 0.25
//!MAX 2
//!STEP 0.01
float SIGMA_VB;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] (Magic) Glow Strength
//!DEFAULT 0.08
//!MIN -2
//!MAX 2
//!STEP 0.01
float glow;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Bloom Strength
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.05
float bloom;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Mask Bloom
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.05
float mask_bloom;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Bloom Distribution
//!DEFAULT 0
//!MIN -2
//!MAX 3
//!STEP 0.05
float bloom_dist;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Halation Strength
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.025
float halation;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Bloom Mask Strength
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.025
float bmask1;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Halation Mask Strength
//!DEFAULT 0.35
//!MIN -1
//!MAX 1
//!STEP 0.025
float hmask1;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Gamma correct
//!DEFAULT 1
//!MIN 0.5
//!MAX 2
//!STEP 0.025
float gamma_c;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Complementary Gamma correct
//!DEFAULT 1
//!MIN 1
//!MAX 2
//!STEP 0.025
float gamma_c2;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Bright Boost Dark Pixels
//!DEFAULT 1.4
//!MIN 0.25
//!MAX 10
//!STEP 0.05
float brightboost;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Bright Boost Bright Pixels
//!DEFAULT 1.1
//!MIN 0.25
//!MAX 3
//!STEP 0.025
float brightboost1;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Clip Saturated Color Beams
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.05
float clips;

//!PARAMETER
//!LABEL [BRIGHTNESS SETTINGS] Bloom Pixel Sampling
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 1
float bloomsamp;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Type
//!DEFAULT 0
//!MIN -1
//!MAX 2
//!STEP 1
float gsl;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Beam Shape Center
//!DEFAULT 6
//!MIN -20
//!MAX 40
//!STEP 0.5
float scanline1;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Beam Shape Edges
//!DEFAULT 8
//!MIN 0
//!MAX 70
//!STEP 1
float scanline2;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Shape Dark Pixels
//!DEFAULT 1.3
//!MIN 0.25
//!MAX 10
//!STEP 0.05
float beam_min;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Shape Bright Pixels
//!DEFAULT 1
//!MIN 0.2
//!MAX 3.5
//!STEP 0.025
float beam_max;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Thinner Dark Scanlines
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float tds;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Increased Bright Scanline Beam
//!DEFAULT 0.6
//!MIN 0
//!MAX 1
//!STEP 0.05
float beam_size;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Saturation / Mask Falloff
//!DEFAULT 0.5
//!MIN 0
//!MAX 6
//!STEP 0.1
float scans;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Falloff
//!DEFAULT 1
//!MIN 0.1
//!MAX 2
//!STEP 0.025
float scan_falloff;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Smart Sharpen Scanlines
//!DEFAULT 0
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float ssharp;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Scanline Gamma
//!DEFAULT 2.4
//!MIN 0.5
//!MAX 5
//!STEP 0.05
float scangamma;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] Rolling Scanlines
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.01
float rolling_scan;

//!PARAMETER
//!LABEL [SCANLINE OPTIONS] No-scanline mode
//!DEFAULT 0
//!MIN 0
//!MAX 1.5
//!STEP 0.05
float no_scanlines;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Integer Scaling: Odd:Y, Even:'X'+Y
//!DEFAULT 0
//!MIN 0
//!MAX 4
//!STEP 1
float IOS;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] CurvatureX (default 0.03)
//!DEFAULT 0
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float warpX;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] CurvatureY (default 0.04)
//!DEFAULT 0
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float warpY;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Curvature Shape
//!DEFAULT 0.25
//!MIN 0.05
//!MAX 0.6
//!STEP 0.05
float c_shape;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Curvature 3D Effect
//!DEFAULT 0.25
//!MIN 0
//!MAX 1
//!STEP 0.05
float cbulge;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Overscan X original pixels
//!DEFAULT 0
//!MIN -200
//!MAX 200
//!STEP 1
float overscanX;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Overscan Y original pixels
//!DEFAULT 0
//!MIN -200
//!MAX 200
//!STEP 1
float overscanY;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Vertical shift Y original pixels
//!DEFAULT 0
//!MIN -200
//!MAX 200
//!STEP 1
float VShift;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Corner Size
//!DEFAULT 0
//!MIN 0
//!MAX 0.35
//!STEP 0.01
float csize;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Border Size
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 0.01
float bsize1;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Border Intensity
//!DEFAULT 0.75
//!MIN 0.25
//!MAX 2
//!STEP 0.05
float sborder;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Hum Bar Speed
//!DEFAULT 50
//!MIN 5
//!MAX 200
//!STEP 1
float barspeed;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Hum Bar Intensity
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.01
float barintensity;

//!PARAMETER
//!LABEL [SCREEN OPTIONS] Hum Bar Direction
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float bardir;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] CRT Mask: 0:CGWG, 1-4:Lottes, 5-14:'Trinitron'
//!DEFAULT 0
//!MIN -1
//!MAX 14
//!STEP 1
float shadowMask;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Mask Strength (0, 5-14)
//!DEFAULT 0.3
//!MIN -0.5
//!MAX 1
//!STEP 0.025
float maskstr;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Mask 5-14 Low Strength
//!DEFAULT 1.1
//!MIN 0
//!MAX 2
//!STEP 0.05
float mcut;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] CRT Mask Boost
//!DEFAULT 1
//!MIN 1
//!MAX 3
//!STEP 0.05
float maskboost;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] CRT Mask Size
//!DEFAULT 1
//!MIN 1
//!MAX 4
//!STEP 1
float masksize;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] CRT Mask Zoom (+ mask width)
//!DEFAULT 0
//!MIN -10
//!MAX 6
//!STEP 1
float mask_zoom;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] CRT Mask Zoom Sharpen (needs Mask Zoom)
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float mzoom_sh;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] (Transform to) Shadow Mask
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.5
float mshift;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Mask Layout Sequence: RGB or RBG (check LCD panel)
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float mask_layout;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Mask Layout Shift: GBR, RGB, BRG | GRB, RBG, BGR
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 1
float laysh;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Lottes maskDark
//!DEFAULT 0.5
//!MIN 0
//!MAX 2
//!STEP 0.05
float maskDark;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Lottes maskLight
//!DEFAULT 1.5
//!MIN 0
//!MAX 2
//!STEP 0.05
float maskLight;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Mask gamma
//!DEFAULT 2.4
//!MIN 1
//!MAX 5
//!STEP 0.05
float mask_gamma;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Slot Mask Strength Bright Pixels
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float slotmask;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Slot Mask Strength Dark Pixels
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float slotmask1;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Slot Mask Width (0:Auto)
//!DEFAULT 0
//!MIN 0
//!MAX 16
//!STEP 1
float slotwidth;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Slot Mask Height: 2x1 or 4x1...
//!DEFAULT 2
//!MIN 1
//!MAX 4
//!STEP 1
float double_slot;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Slot Mask Thickness
//!DEFAULT 1
//!MIN 1
//!MAX 4
//!STEP 1
float slotms;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Smooth Masks in bright scanlines
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 0.25
float smoothmask;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Mitigate Slotmask Interaction
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float smask_mit;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Base (black) Mask strength
//!DEFAULT 0
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float bmask;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Preserve Mask Strength
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.025
float mclip;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Preserve Scanline Properties
//!DEFAULT 0.1
//!MIN 0
//!MAX 1
//!STEP 0.025
float pr_scan;

//!PARAMETER
//!LABEL [CRT MASK OPTIONS] Mitigate Mask on Edges
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.1
float edgemask;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Deconvergence type X : 0.0 - static, other - dynamic
//!DEFAULT 0
//!MIN 0
//!MAX 0.75
//!STEP 0.05
float dctypex;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Deconvergence type Y : 0.0 - static, other - dynamic
//!DEFAULT 0
//!MIN 0
//!MAX 0.75
//!STEP 0.05
float dctypey;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Horizontal Deconvergence Red Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconrr;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Horizontal Deconvergence Green Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconrg;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Horizontal Deconvergence Blue Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconrb;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Vertical Deconvergence Red Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconrry;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Vertical Deconvergence Green Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconrgy;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Vertical Deconvergence Blue Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconrby;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Deconvergence Strength
//!DEFAULT 1
//!MIN 0
//!MAX 3
//!STEP 0.1
float decons;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Add Noise
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.02
float addnoised;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Noise Resolution
//!DEFAULT 2
//!MIN 1
//!MAX 10
//!STEP 1
float noiseresd;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Noise Type: Colored, Luma
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float noisetype;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Post Brightness
//!DEFAULT 1
//!MIN 0.25
//!MAX 5
//!STEP 0.01
float post_br;

//!PARAMETER
//!LABEL [HORIZONTAL/VERTICAL DECONVERGENCE] Show Original Image
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.25
float oimage;

//!TEXTURE
Texture2D INPUT;

//!TEXTURE
Texture2D OUTPUT;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D TAG;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D TAGH;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D TPRE;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D TLIN;

//!TEXTURE
//!WIDTH 800
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D TGH;

//!TEXTURE
//!WIDTH 800
//!HEIGHT 600
//!FORMAT R16G16B16A16_FLOAT
Texture2D TGV;

//!TEXTURE
//!WIDTH 800
//!HEIGHT 600
//!FORMAT R16G16B16A16_FLOAT
Texture2D TBH;

//!TEXTURE
//!WIDTH 800
//!HEIGHT 600
//!FORMAT R16G16B16A16_FLOAT
Texture2D TBV;

//!TEXTURE
//!WIDTH OUTPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D TP1;

//!TEXTURE
//!WIDTH OUTPUT_WIDTH
//!HEIGHT OUTPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D TCRT;

//!TEXTURE
//!WIDTH 64
//!HEIGHT 32
//!FORMAT R32G32B32A32_FLOAT
Texture2D RB1;

//!TEXTURE
//!WIDTH 5
//!HEIGHT 6
//!FORMAT R32G32B32A32_FLOAT
Texture2D AVG2;

//!TEXTURE
//!WIDTH 1
//!HEIGHT 1
//!FORMAT R32G32B32A32_FLOAT
Texture2D LUM;

//!TEXTURE
//!WIDTH 1
//!HEIGHT 1
//!FORMAT R32G32B32A32_FLOAT
Texture2D LUMH;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T0I;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 4
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T03;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T04;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T06;

//!TEXTURE
//!SOURCE CRT-LUT-1.png
Texture2D LUT1;

//!TEXTURE
//!SOURCE CRT-LUT-2.png
Texture2D LUT2;

//!TEXTURE
//!SOURCE CRT-LUT-3.png
Texture2D LUT3;

//!TEXTURE
//!SOURCE CRT-LUT-4.png
Texture2D LUT4;

//!SAMPLER
//!FILTER POINT
//!ADDRESS CLAMP
SamplerState sPt;

//!SAMPLER
//!FILTER LINEAR
//!ADDRESS CLAMP
SamplerState sLin;

//!SAMPLER
//!FILTER POINT
//!ADDRESS WRAP
SamplerState sPtW;

//!COMMON
float  mod(float x, float y)   { return x - y * floor(x / y); }
float2 mod(float2 x, float y)  { return x - y * floor(x / y); }
float2 mod(float2 x, float2 y) { return x - y * floor(x / y); }
float3 mod(float3 x, float y)  { return x - y * floor(x / y); }
float3 mod(float3 x, float3 y) { return x - y * floor(x / y); }
float4 mod(float4 x, float y)  { return x - y * floor(x / y); }
float4 mod(float4 x, float4 y) { return x - y * floor(x / y); }
#define FrameCount __frameCount     // Magpie's internal frame counter (needs //!USE _DYNAMIC); counts rendered frames

//!PASS 1
//!DESC Afterglow
//!STYLE PS
//!IN INPUT, TAGH
//!OUT TAG

#define SourceSize float4(float2(GetInputSize()),GetInputPt())
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(float2(GetInputSize()),GetInputPt())
static float2 vTexCoord;


float4 Pass1(float2 mpos)
{
	vTexCoord = mpos;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float2 dx = float2(OriginalSize.z, 0.0);
	float2 dy = float2(0.0, OriginalSize.w);
	
	float3 color0  = INPUT.SampleLevel(sLin,vTexCoord.xy,0).rgb;
	float3 color1  = INPUT.SampleLevel(sLin,vTexCoord.xy - dx,0).rgb;
	float3 color2  = INPUT.SampleLevel(sLin,vTexCoord.xy + dx,0).rgb;
	float3 color3  = INPUT.SampleLevel(sLin,vTexCoord.xy - dy,0).rgb;
	float3 color4  = INPUT.SampleLevel(sLin,vTexCoord.xy + dy,0).rgb;	

if (esrc > 1.5)
{
	color0  = INPUT.SampleLevel(sLin,vTexCoord.xy,0).rgb;
	color1  = INPUT.SampleLevel(sLin,vTexCoord.xy - dx,0).rgb;
	color2  = INPUT.SampleLevel(sLin,vTexCoord.xy + dx,0).rgb;
	color3  = INPUT.SampleLevel(sLin,vTexCoord.xy - dy,0).rgb;
	color4  = INPUT.SampleLevel(sLin,vTexCoord.xy + dy,0).rgb;	
}

	float3 color = (2.5 * color0 + color1 + color2 + color3 + color4)/6.5;
	
	float3 accumulate = TAGH.SampleLevel(sLin,vTexCoord.xy,0).rgb;

	float w = 1.0;
	float b = bth/255.0;
	float c = max(max(color0.r,color0.g),color0.b);
	w = smoothstep(b, 2.0*b, c);

	float3 result = lerp( max(lerp(color, accumulate, 0.49 + float3(PR, PG, PB))- 0.5/255.0, 0.0), color, w);

	FragColor = float4(result, w);
	return FragColor;
}

//!PASS 2
//!DESC Afterglow history
//!STYLE PS
//!IN TAG
//!OUT TAGH

float4 Pass2(float2 pos)
{
	return TAG.SampleLevel(sPt, pos, 0);
}

//!PASS 3
//!DESC PreShader (colour / LUT / afterglow mix)
//!STYLE PS
//!IN INPUT, LUT1, LUT2, LUT3, LUT4, TAG
//!OUT TPRE

#define SourceSize float4(float2(GetInputSize()),GetInputPt())
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(float2(GetInputSize()),GetInputPt())
static float2 vTexCoord;
static const float3x3 Profile0 = 
float3x3(
 0.412391,  0.212639,  0.019331,
 0.357584,  0.715169,  0.119195,
 0.180481,  0.072192,  0.950532
);
static const float3x3 Profile1 = 
float3x3(
 0.430554,  0.222004,  0.020182,
 0.341550,  0.706655,  0.129553,
 0.178352,  0.071341,  0.939322
);
static const float3x3 Profile2 = 
float3x3(
 0.396686,  0.210299,  0.006131,
 0.372504,  0.713766,  0.115356,
 0.181266,  0.075936,  0.967571
);
static const float3x3 Profile3 = 
float3x3(
 0.393521,  0.212376,  0.018739,
 0.365258,  0.701060,  0.111934,
 0.191677,  0.086564,  0.958385
);
static const float3x3 Profile4 = 
float3x3(
 0.392258,  0.209410,  0.016061,
 0.351135,  0.725680,  0.093636,
 0.166603,  0.064910,  0.850324
);
static const float3x3 Profile5 = 
float3x3(
 0.377923,  0.195679,  0.010514,
 0.317366,  0.722319,  0.097826,
 0.207738,  0.082002,  1.076960
);
static const float3x3 ToSRGB = 
float3x3(
 3.240970, -0.969244,  0.055630,
-1.537383,  1.875968, -0.203977,
-0.498611,  0.041555,  1.056972
);
static const float3x3 ToModern = 
float3x3(
 2.791723, -0.894766,  0.041678,
-1.173165,  1.815586, -0.130886,
-0.440973,  0.032000,  1.002034
);
static const float3x3 ToDCI = 
float3x3(
 2.973422, -0.867605,  0.045031,
-1.110433,  1.843757, -0.095697,
-0.480247,  0.024743,  1.201215
);
static const float3x3 ToAdobe = 
float3x3(
 2.041588, -0.969244,  0.013444,
-0.565007,  1.875968, -0.11836,
-0.344731,  0.041555,  1.015175
);
static const float3x3 ToREC = 
float3x3(
 1.716651, -0.666684,  0.017640,
-0.355671,  1.616481, -0.042771,
-0.253366,  0.015769,  0.942103
);
static const float3x3 ToP3 = 
float3x3(
 2.493509, -0.829473,  0.0358512,
-0.931388,  1.762630, -0.0761839,
-0.402712,  0.023624,  0.9570296
);
static const float3x3 D65_to_D55 = float3x3 (
           0.4850339153,  0.2500956126,  0.0227359648,
           0.3488957224,  0.6977914447,  0.1162985741,
           0.1302823568,  0.0521129427,  0.6861537456);
static const float3x3 D65_to_D93 = float3x3 (
           0.3412754080,  0.1759701322,  0.0159972847,
           0.3646170520,  0.7292341040,  0.1215390173,
           0.2369894093,  0.0947957637,  1.2481442225);

float3 fix_lut(float3 lutcolor, float3 ref)
{
	float r = length(ref);
	float l = length(lutcolor);
	float m = max(max(ref.r,ref.g),ref.b);
	ref = normalize(lutcolor + 0.0000001) * lerp(r, l, pow(m,1.25));
	return lerp(lutcolor, ref, 1.0);
}

float vignette(float2 pos) {
	float b = vigdef * 0.125;
	pos = abs(2.0*(pos - 0.5)); pos*=pos*pos;
	float dist = pow(dot(pos,pos),0.05);
	float res = lerp(0.0, 1.0, smoothstep(1.0, 1.0-b, dist));
	return max(lerp(1.0, res, vigstr), 0.0);
}

float3 plant (float3 tar, float r)
{
	float t = max(max(tar.r,tar.g),tar.b) + 0.00001;
	return tar * r / t;
}

float contrast(float x)
{
	return max(lerp(x, smoothstep(0.0, 1.0, x), contr),0.0);
}

float3 pgc(float3 c)
{
	float mc = max(max(c.r,c.g),c.b);
	float mg = pow(mc, 1.0/pre_gc);
	return c * mg/(mc + 1e-8);  
}

float contrast_sigmoid_inv(float imgColor, float cont, float pivot)
{
	cont = cont - 1.0; cont = cont*cont*cont;
	float knee  = 1.0 / (1.0 + exp (cont *  pivot));
	float shldr = 1.0 / (1.0 + exp (cont * (pivot - 1.0)));
	imgColor = pivot - log(1.0 / (imgColor * (shldr - knee) + knee) - 1.0) / cont;
	return imgColor;
}

float4 Pass3(float2 mpos)
{
	vTexCoord = mpos;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float4 imgColor = INPUT.SampleLevel(sLin,vTexCoord.xy,0);
   float4 aftglow = TAG.SampleLevel(sLin,vTexCoord.xy,0);
   
   float w = 1.0-aftglow.w;

   float l = length(aftglow.rgb);
   aftglow.rgb = AS*w*normalize(pow(aftglow.rgb + 0.01, ((float3)(agsat))))*l;
   float bp = w * BP1/255.0;
   
   if (sega_fix > 0.5) imgColor.rgb = imgColor.rgb * (255.0 / 239.0);
   
   if (segams > 0.5) { imgColor.b = (abs(imgColor.b - 0.375) < 0.125) ? 0.4078431372549019607843137254902 : imgColor.b; }

   imgColor.rgb = min(imgColor.rgb, 1.0);
   
   if (segapal > 0.5) {
   imgColor.r = contrast_sigmoid_inv(imgColor.r,2.578419881,0.520674); 
   imgColor.g = contrast_sigmoid_inv(imgColor.g,2.578419881,0.520674); 
   imgColor.b = contrast_sigmoid_inv(imgColor.b,2.578419881,0.520674); }
   
   imgColor.rgb = min(imgColor.rgb, 1.0);

   float3 color = imgColor.rgb;
 
   if (int(TNTC) == 0)
   {
      color.rgb = imgColor.rgb;
   }
   else
   {
	  float lutlow = 5.0/255.0; float invLS = 1.0/LS;
	  float3 lut_ref = imgColor.rgb + lutlow*(1.0 - pow(imgColor.rgb, 0.333.xxx));
	  float lutb = lut_ref.b * (1.0-0.5*invLS);	  
	  lut_ref.rg    = lut_ref.rg * (1.0-invLS) + 0.5*invLS; 
	  float tile1 = ceil (lutb * (LS-1.0));
	  float tile0 = max(tile1 - 1.0, 0.0);
	  float f = frac(lutb * (LS-1.0)); if (f == 0.0) f = 1.0;
	  float2 coord0 = float2(tile0 + lut_ref.r, lut_ref.g)*float2(invLS, 1.0);
	  float2 coord1 = float2(tile1 + lut_ref.r, lut_ref.g)*float2(invLS, 1.0);
	  float4 color1, color2, res;
	  
      if (int(TNTC) == 1)
      {
         color1 = LUT1.SampleLevel(sLin,coord0,0);
         color2 = LUT1.SampleLevel(sLin,coord1,0);
         res = lerp(color1, color2, f);
      }
      else if (int(TNTC) == 2)
      {
         color1 = LUT2.SampleLevel(sLin,coord0,0);
         color2 = LUT2.SampleLevel(sLin,coord1,0);
         res = lerp(color1, color2, f);
      }	
      else if (int(TNTC) == 3)
      {
         color1 = LUT3.SampleLevel(sLin,coord0,0);
         color2 = LUT3.SampleLevel(sLin,coord1,0);
         res = lerp(color1, color2, f);
      }	
      else if (int(TNTC) == 4)
      {
         color1 = LUT4.SampleLevel(sLin,coord0,0);
         color2 = LUT4.SampleLevel(sLin,coord1,0);
         res = lerp(color1, color2, f);
      }	

      res.rgb = fix_lut (res.rgb, imgColor.rgb);
	  
      color = lerp(imgColor.rgb, res.rgb, min(TNTC,1.0));
   }

	float3 c = clamp(color, 0.0, 1.0);
	
	float p;
	float3x3 m_out;
	
	if (CS == 0.0) { p = 2.2; m_out =  ToSRGB;   } else
	if (CS == 1.0) { p = 2.2; m_out =  ToModern; } else	
	if (CS == 2.0) { p = 2.6; m_out =  ToDCI;    } else
	if (CS == 3.0) { p = 2.2; m_out =  ToAdobe;  } else
	if (CS == 4.0) { p = 2.4; m_out =  ToREC;    } else
	if (CS == 5.0) { p = 2.2; m_out =  ToP3;     }
	
	color = pow(c, ((float3)(p)));
	
	float3x3 m_in = Profile0;

	if (CP == 0.0) { m_in = Profile0; } else	
	if (CP == 1.0) { m_in = Profile1; } else
	if (CP == 2.0) { m_in = Profile2; } else
	if (CP == 3.0) { m_in = Profile3; } else
	if (CP == 4.0) { m_in = Profile4; } else
	if (CP == 5.0) { m_in = Profile5; }
	
	color = mul(color, m_in);
	color = mul(color, m_out);

	color = clamp(color, 0.0, 1.0);

	color = pow(color, ((float3)(1.0/p)));	
	
	if (CP == -1.0) color = c;
	
	float3 scolor1 = plant(pow(color, ((float3)(wp_saturation))), max(max(color.r,color.g),color.b));
	float luma = dot(color, float3(0.299, 0.587, 0.114));
	float3 scolor2 = lerp(((float3)(luma)), color, wp_saturation);
	color = (wp_saturation > 1.0) ? scolor1 : scolor2;

	color = plant(color, contrast(max(max(color.r,color.g),color.b)));

	p = 2.2;
	color = clamp(color, 0.0, 1.0);	
	color = pow(color, ((float3)(p))); 
	
	float3 warmer = mul(color, D65_to_D55);
	warmer = mul(warmer, ToSRGB);
	
	float3 cooler = mul(color, D65_to_D93);
	cooler = mul(cooler, ToSRGB);
	
	float m = abs(WP)/100.0;
	
	float3 comp = (WP < 0.0) ? cooler : warmer;
	
	color = lerp(color, comp, m);
	color = pow(max(color, 0.0), ((float3)(1.0/p)));
	color = pgc(color);

	float bp1 = min(BP, 0.0);
	color = max(color + bp1/255.0, 0.0) / (1.0 + bp1/255.0*step(-bp1/255.0, max(max(color.r,color.g),color.b)));
	color = color + aftglow.rgb + bp;
	
	color = min(color * pre_bb, 1.0);
	
	FragColor = float4(color, vignette(vTexCoord.xy));
	return FragColor;
}

//!PASS 4
//!DESC Interlace
//!STYLE PS
//!IN TPRE
//!OUT T0I

#define SourceSize float4(float2(GetInputSize()),GetInputPt())
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(float2(GetInputSize()),GetInputPt())
static float2 vTexCoord;
float3 plant (float3 tar, float r)
{
	float t = max(max(tar.r,tar.g),tar.b) + 0.00001;
	return tar * r / t;
}

float4 Pass4(float2 mpos)
{
	vTexCoord = mpos * 1.00001;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float3 c1 = TPRE.SampleLevel(sLin,vTexCoord,0).rgb;
	float3 c2 = TPRE.SampleLevel(sLin,vTexCoord + float2(0.0, OriginalSize.w),0).rgb;
	
	float3  c  = c1;

	float intera = 1.0;

	float m1 = max(max(c1.r,c1.g),c1.b);
	float m2 = max(max(c2.r,c2.g),c2.b);
	float3 df = abs(c1-c2);
		
	float d = max(max(df.r,df.g),df.b);
	if (interm == 2.0) d = lerp(0.1*d,10.0*d, step(m1/(m2+0.0001),m2/(m1+0.0001)));

	float r = m1;

	float yres_div = 1.0; if (intres > 1.25) yres_div = intres;

	bool hscan = (hiscan > 0.5);
		
	if (inter <= OriginalSize.y/yres_div && interm > 0.5 && intres != 1.0 && intres != 0.5 || hscan) 
	{
		intera = 0.25;
		float line_no  = floor(mod(OriginalSize.y*vTexCoord.y, 2.0));
		float frame_no = floor(mod(float(FrameCount),2.0));
		float ii = abs(line_no-frame_no);
		
		if (interm < 3.5 || interm > 5.5)
		{
			if (interm == 6.0) c = lerp(c2, c1, ii); else
			{
			c2 = plant(lerp(c2, c2*c2, iscans), max(max(c2.r,c2.g),c2.b));
			r = max(m1*ii, (1.0-iscan)*min(m1,m2));
			c = plant( lerp(lerp(c1,c2, min(lerp(m1, 1.0-m2, min(m1,1.0-m1))/(d+0.00001),1.0)), c1, ii), r);
			if (interm == 3.0) c = (1.0-0.5*iscan)*lerp(c2, c1, ii);
			}
		}
		if (interm == 4.0) { c = plant(lerp(c, c*c, 0.5*iscans), max(max(c.r,c.g),c.b)) * (1.0-0.5*iscan); }
		if (interm == 5.0) { c = lerp(c2, c1, 0.5); c = plant(lerp(c, c*c, 0.5*iscans), max(max(c.r,c.g),c.b)) * (1.0-0.5*iscan); }
		
		if (hscan) c = c1;		
	}

	FragColor = float4(c, intera);
	return FragColor;
}

//!PASS 5
//!DESC PAL pass 1 (modulation)
//!STYLE PS
//!IN T0I
//!OUT T03

#define SourceSize float4(float2(GetInputSize()),GetInputPt())
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(4.0*float(GetInputSize().x),float(GetInputSize().y),0.25*GetInputPt().x,GetInputPt().y)
static float2 vTexCoord;
static const float CYCLES_PER_LINE = 4.43361875e6 / 15625.0;
static const float PI = 3.14159265358979323846;
static const float3x3 rgb_yuv = float3x3(
     0.29900,   0.58700,   0.11400,
    -0.14713,  -0.28886,   0.43600,
     0.61500,  -0.51499,  -0.10001);

float3 rgb2yuv(float3 rgb)
{
	return mul(rgb_yuv, rgb);
}

float edge_cycles(int line_x, uint frameCount)
{
	float cycles = float(line_x) * (-0.25);
	if (PHMOD == 2.0 || (PHMOD == 0.0 && OriginalSize.y > 375.0)) cycles += float(frameCount & 7) * (-0.125);
	return cycles;
}

float4 Pass5(float2 mpos)
{
	vTexCoord = mpos * 1.00001;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float3 rgb  = T0I.SampleLevel(sPt,vTexCoord,0).rgb;	
	float3 yuv = rgb2yuv(rgb);
	yuv.x = pow(max(yuv.x, 0.0), GCORR);
	float3 res4 = yuv;
	
	float lum = yuv.x;
	float3 yuvd = rgb2yuv(T0I.SampleLevel(sPt,vTexCoord - float2(0.0, OriginalSize.w),0).rgb); yuvd.x = lum;
	if (DLINE > 3.5) yuvd = yuv;
	int line_x = int(floor(vTexCoord.y * OriginalSize.y));

	float xN = vTexCoord.x * CYCLES_PER_LINE;
	float cycles = xN + edge_cycles(line_x, FrameCount);
	float phase = 2.0 * PI * cycles;
	float linesign = (line_x%2 == 0) ? 1.0 : -1.0;

	float2 uvmod = float2(cos(phase), sin(phase*linesign));
	yuv.yz = yuv.yz * uvmod;
	yuv = mul((float3x3(BRIGHTNESS, FRINGING, FRINGING, ARTIFACTING, 2.0*SATURATION, 0.0, ARTIFACTING, 0.0, 2.0*SATURATION)), yuv);
	yuv.yz = yuv.yz * uvmod;

if (DLINE > 1.5) 
{
	if (DLINE > 2.5) { uvmod = float2(-uvmod.x, -uvmod.y); } else uvmod = float2(uvmod.x, -uvmod.y);	
	yuvd.yz = yuvd.yz * uvmod;
	yuvd = mul((float3x3(BRIGHTNESS, FRINGING, FRINGING, ARTIFACTING, 2.0*SATURATION, 0.0, ARTIFACTING, 0.0, 2.0*SATURATION)), yuvd);
	yuvd.yz = yuvd.yz * uvmod;
	yuv = lerp(yuv, yuvd, 0.5);
}

	if (PAL_FILT == 4.0) yuv = res4;

	FragColor = float4(yuv, lum);
	return FragColor;
}

//!PASS 6
//!DESC PAL pass 2 (decoding)
//!STYLE PS
//!IN T03
//!OUT T04

#define SourceSize float4(4.0*float(GetInputSize().x),float(GetInputSize().y),0.25*GetInputPt().x,GetInputPt().y)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y)
static float2 vTexCoord;
static const float3x3 yuv_rgb =

float3x3 (1.00000,   0.00000,   1.13983,
      1.00000,  -0.39465,  -0.58060,
      1.00000,   2.03211,   0.00000);

float3 yuv2rgb(float3 yuv)
{
	return mul(yuv_rgb, yuv);
}

float smothstep (float e0, float e1, float x)
{
   return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
}

float2 psrnd(float2 TexCoord, float FrameCount_l) {
    float3 p = float3(TexCoord * 16758.5453, FrameCount_l);
    float x = frac(sin(dot(p, float3(12.9898, 78.233, 3.183))) * 43758.5453);
    float y = frac(sin(dot(p, float3(25.9796, 14.113, 11.271))) * 96321.9124);
    return float2(x, y);
}

float3 Noise(float2 TexCoord, float FrameCount_l) {
    TexCoord = psrnd(TexCoord, FrameCount_l);
    float3 p = float3(TexCoord * 758.5453, FrameCount_l);
    float res1 = frac(sin(dot(p, float3(12.989835, 78.23341, 0.16453))) * 43758.54531);
    float res2 = frac(sin(dot(p, float3(39.34679, 11.13523, 83.15573))) * 39459.32423);
    float res3 = frac(sin(dot(p, float3(73.15691, 52.23504, 09.15197))) * 60493.84731);
    float lns = float(abs(res1-0.5) < 0.2*(RFNOISE*RFNOISE + 0.00001));
    float cny = float(abs(res2-0.5) < 0.5*(RFNOISE*RFNOISE + 0.00001));
    float cnz = float(abs(res3-0.5) < 0.5*(RFNOISE*RFNOISE + 0.00001));
    lns = lns*smothstep(0.5-0.2*(RFNOISE*RFNOISE + 0.00001), 0.5+0.2*(RFNOISE*RFNOISE + 0.00001), res1) * 0.66 - 0.33*lns;
    cny = cny*smothstep(0.5-0.5*(RFNOISE*RFNOISE + 0.00001), 0.5+0.5*(RFNOISE*RFNOISE + 0.00001), res2)  - 0.5*cny;
    cnz = cnz*smothstep(0.5-0.5*(RFNOISE*RFNOISE + 0.00001), 0.5+0.5*(RFNOISE*RFNOISE + 0.00001), res3)  - 0.5*cnz;	
    return float3(lns, cny, cnz);
} 

float3 sample_yuv(float3 dx)
{
   return float3(T03.SampleLevel(sLin,vTexCoord + dx.xz,0).x + T03.SampleLevel(sLin,vTexCoord - dx.xz,0).x, T03.SampleLevel(sLin,vTexCoord + dx.yz,0).yz + T03.SampleLevel(sLin,vTexCoord - dx.yz,0).yz);
}static float CON_TYPE[4] = {288.0, 320.0, 410.0, 512.0};
static const int TAPS_PAL = 24;
static float luma_weight_pal_25[25] = {
 -0.002029,
 -0.005153,
 -0.011795,
 -0.018519,
 -0.049249,
 -0.085003,
 -0.121754,
 -0.155098,
 -0.180556,
 -0.193873,
 -0.191327,
 -0.170006,
 -0.128046,
 -0.064815,
  0.018974,
  0.121221,
  0.238487,
  0.366121,
  0.498457,
  0.629093,
  0.751215,
  0.857963,
  0.942821,
  0.995341,
  1.000000
};
static const float chroma_weight_pal_251[25] = {
  -0.001100,
  -0.001650,
  -0.002500,
  -0.003700,
  -0.005200,
  -0.006900,
  -0.008300,
  -0.009000,
  -0.008100,
  -0.005600,
  -0.002200,
   0.000300,
   0.002300,
   0.005200,
   0.009000,
   0.023600,
   0.049000,
   0.075200,
   0.152100,
   0.339700,
   0.447800,
   0.676000,
   0.892000,
   0.984000,
   1.000000
};
static const float chroma_weight_pal_252[25] = {
  -0.00100,
  -0.00200,
  -0.00300,
  -0.00400,
  -0.00550,
  -0.00900,
  -0.00550,
  -0.00200,
   0.00430,
   0.00721,   
   0.01167,
   0.02333,
   0.06512,
   0.09667,
   0.19333,
   0.30000,
   0.37667,
   0.48333,
   0.56000,
   0.66327,
   0.72333,
   0.86000,
   0.91667,
   0.97333,
   1.00000};

float4 Pass6(float2 mpos)
{
	vTexCoord = mpos + float2(0.125 * OriginalSize.z, 0.0);
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float chroma_weight_pal_25[25] = chroma_weight_pal_251;
   if (CHROMAF > 1.5) chroma_weight_pal_25 = chroma_weight_pal_252;
   
   float yres = CON_TYPE[int(PAL_FILT)-1];
   float hres = (pal_res < 1.5) ? yres : OriginalSize.x;


   float df = 1.0;
   
   if (pal_dith > 0.005 && PAL_FILT < 3.5)
   {
      float2 TexD = (floor(vTexCoord * OriginalSize.xy) + 0.5)*OriginalSize.zw;
      float2 xx = float2(OriginalSize.z, 0.0);

      float ca = T03.SampleLevel(sLin,TexD - xx - xx,0).a;
      float c0 = T03.SampleLevel(sLin,TexD - xx,0).a;
      float c1 = T03.SampleLevel(sLin,TexD,0).a;
      float c2 = T03.SampleLevel(sLin,TexD + xx,0).a;
      float cb = T03.SampleLevel(sLin,TexD + xx + xx,0).a;
      float line0  = smothstep(0.01, 0.0, min(abs(c1-c0),abs(c2-c1)));
      float line1  = max(smothstep(0.01, 0.0, min(abs(ca-c0),abs(c2-cb))), line0);
      float line2  = max(smothstep(0.01, 0.0, min(abs(ca-c2),abs(c0-cb))), line1);
      float line3  = smothstep(0.01, 0.0, min(max(abs(c0-c2),abs(c1-ca)),max(abs(c0-c2),abs(c1-cb))));
	  line2 = lerp(line2, line0, line3);
      df = 1.0 + (1.0-line2) * pal_dith;
   }
   
   float res = pal_scale;
   float one_x = 0.125 / hres / res * df;
   float one_y = 0.250 / hres / res / pal_chroma;
   
   float3 signal = ((float3)(0.0));

   float offset = 0.0; int i = 0;
   float3 wsum = 0.0.xxx;
   float3 sums = wsum;
   float3 tmp  = wsum;  

   float3 dx = float3(one_x, one_y, 0.0);
   float iloop = 24.0;
   float3 dx1 = dx;
	
   for (i = 0; i < 24; i++)
   {
      offset = float(i); dx1.xy = (offset - iloop)*dx.xy;
      sums = sample_yuv(dx1);
      tmp = float3(luma_weight_pal_25[i], chroma_weight_pal_25[i].xx);
      wsum = wsum + tmp;
      signal += sums * tmp;
   }
   tmp = float3(luma_weight_pal_25[TAPS_PAL], chroma_weight_pal_25[TAPS_PAL], chroma_weight_pal_25[TAPS_PAL]);
   wsum = wsum + wsum + tmp;
   signal += T03.SampleLevel(sLin,vTexCoord,0).xyz * tmp;
   signal = signal / wsum;

   if (pal_ring > 0.05)
   {
      float2 dx = float2(4.0 * one_x / res, 0.0);
      float x1 = T03.SampleLevel(sLin,vTexCoord - 4.0*dx,0).a;	  
      float x2 = T03.SampleLevel(sLin,vTexCoord - 3.0*dx,0).a;
      float a  = T03.SampleLevel(sLin,vTexCoord - 2.0*dx,0).a;
      float b  = T03.SampleLevel(sLin,vTexCoord -     dx,0).a;
      float c  = T03.SampleLevel(sLin,vTexCoord + 2.0*dx,0).a;
      float y1 = T03.SampleLevel(sLin,vTexCoord + 3.0*dx,0).a;
      float y2 = T03.SampleLevel(sLin,vTexCoord + 4.0*dx,0).a;	  
      float d  = T03.SampleLevel(sLin,vTexCoord +     dx,0).a;
      float e  = T03.SampleLevel(sLin,vTexCoord,0).a;	  
      float a0 = min(min(a,x1),x2); float a1 = max(max(a,x1),x2);
      float c0 = min(min(c,y1),y2); float c1 = max(max(c,y1),y2);
      signal.x = lerp(signal.x, clamp(signal.x, min(min(min(a0,b),min(c0,d)),e), max(max(max(a1,b),max(c1,d)),e)), pal_ring);
   }

   signal.x = pow(max(signal.x, 0.0), 1.0/GCORR);

   
   if ((RFNOISE1+ RFNOISE2) > 0.005) {
      float3 ns = Noise(vTexCoord, float(FrameCount));
      float Y = lerp(0.375, 1.0, pow(signal.x, 0.2));
      signal.x = clamp(signal.x +   RFNOISE1*ns.x,  0.00, 1.00);  
      signal.y = clamp(signal.y + Y*RFNOISE2*(0.325 + 1.325*abs(signal.y))*ns.y, -0.45, 0.45);
      signal.z = clamp(signal.z + Y*RFNOISE2*(0.325 + 1.325*abs(signal.z))*ns.z, -0.62, 0.62);
   }
   
   FragColor = float4(clamp(yuv2rgb(signal), 0.0, 1.0), 1.0);
	return FragColor;
}

//!PASS 7
//!DESC FSharpen (PAL)
//!STYLE PS
//!IN T04, TPRE
//!OUT T06

#define SourceSize float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y)
static float2 vTexCoord;
static const float3x3 yuv_rgb =

float3x3 (1.00000,   0.00000,   1.13983,
      1.00000,  -0.39465,  -0.58060,
      1.00000,   2.03211,   0.00000);

float3 yuv2rgb(float3 yuv)
{
	return mul(yuv_rgb, yuv);
}static const float3x3 rgb_yuv = float3x3(
     0.29900,   0.58700,   0.11400,
    -0.14713,  -0.28886,   0.43600,
     0.61500,  -0.51499,  -0.10001);

float3 rgb2yuv(float3 rgb)
{
	return mul(rgb_yuv, rgb);
}

float get_luma(float3 c)
{
	return dot(c, float3(0.299, 0.587, 0.114));
}

float4 Pass7(float2 mpos)
{
	vTexCoord = mpos;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float2 g01 = float2(-1.0/640.0, 0.0);
	float2 g21 = float2( 1.0/640.0, 0.0); 

	float3 c01 = T04.SampleLevel(sLin,vTexCoord + g01,0).rgb;
	float3 c21 = T04.SampleLevel(sLin,vTexCoord + g21,0).rgb;
	float3 c11 = T04.SampleLevel(sLin,vTexCoord,0).rgb;
	
	float3 b11 = 0.5*(c01+c21); 
	
	float contrast = max(max(c11.r,c11.g),c11.b);
	contrast = lerp(2.0*CCONTR, CCONTR, contrast);
	
	float3 mn = min(min(c01,c21),c11); float3 mn1 = min(mn,c11*(1.0-contrast));
	float3 mx = max(max(c01,c21),c11); float3 mx1 = max(mx,c11*(1.0+contrast));
	
	float3 dif = pow(mx1-mn1+0.00001, float3(0.75,0.75,0.75));
	float3 sharpen = lerp(((float3)(CSHARPEN*CDETAILS)), ((float3)(CSHARPEN)), dif);
	
	float3 res = clamp(lerp(c11,b11,-sharpen), mn1,mx1);
	
if (NDEBLUR > 1.125) 
{
	float2 tex0 = (floor(OriginalSize.xy*vTexCoord)+0.5)*OriginalSize.zw;
	
	float l01 = get_luma(TPRE.SampleLevel(sLin,vTexCoord + 2.0*g01,0).rgb);
	float l21 = get_luma(TPRE.SampleLevel(sLin,vTexCoord + 2.0*g21,0).rgb);
	float l11 = get_luma(TPRE.SampleLevel(sLin,tex0,0).rgb);
	float dth = T04.SampleLevel(sLin,vTexCoord,0).a;

	float DEB = NDEBLUR;
	
	float v11 = min(min(l01,l21), l11);
	      l11 = max(max(l01,l21), l11);

	float lmin = min(min(get_luma(c01),get_luma(c21)),get_luma(c11));
	float lmax = max(max(get_luma(c01),get_luma(c21)),get_luma(c11));
	
	float ln1 = min(lerp(v11, lmin, lmin), lmin);
	float lx1 = max(lerp(lmax, l11, lmax), lmax);
	float r11 = get_luma(res);

	float dif1 = max(r11-ln1, 0.0) + 0.00001; dif1 = pow(dif1, DEB);
	float dif2 = max(lx1-r11, 0.0) + 0.00001; dif2 = pow(dif2, DEB);
	
	float ratio = dif1/(dif1+dif2);
	float lsharpen = lerp(ln1, lx1, ratio);

	lsharpen = min(lsharpen, max(DEDGE*lsharpen, r11));
	
	res = rgb2yuv(res);
	v11 = res.x;
	res.x = lsharpen;
	res.x = clamp((1.0+DESHARP)*res.x - DESHARP*v11, ln1*(1.0-contrast),lx1*(1.0+contrast));	
	res = max(yuv2rgb(res),0.0);
}
	
	FragColor = float4(res,1.0);
	return FragColor;
}

//!PASS 8
//!DESC Average luma: reduce 1
//!STYLE PS
//!IN T06
//!OUT RB1

float4 Pass8(float2 pos)
{
	float2 sz = float2(64.0, 32.0);
	float2 o = floor(pos * sz) / sz;
	float3 sum = 0.0;
	for (int j = 0; j < 8; j++)
	for (int i = 0; i < 8; i++)
		sum += T06.SampleLevel(sLin, o + (float2(i, j) + 0.5) / 8.0 / sz, 0).rgb;
	return float4(sum / 64.0, 1.0);
}

//!PASS 9
//!DESC Average luma: reduce 2
//!STYLE PS
//!IN RB1
//!OUT AVG2

float4 Pass9(float2 pos)
{
	float cx = floor(pos.x * 5.0);
	float cy = floor(pos.y * 6.0);
	float nx = (cx < 1.5) ? 2.0 : 3.0;
	float kx = (cx < 1.5) ? cx : cx - 2.0;
	float ny = (cy < 0.5) ? 1.0 : ((cy < 2.5) ? 2.0 : 3.0);
	float ky = (cy < 0.5) ? 0.0 : ((cy < 2.5) ? cy - 1.0 : cy - 3.0);
	float3 sum = 0.0;
	for (int j = 0; j < 8; j++)
	for (int i = 0; i < 16; i++)
		sum += RB1.SampleLevel(sLin, float2((kx + (float(i) + 0.5) / 16.0) / nx, (ky + (float(j) + 0.5) / 8.0) / ny), 0).rgb;
	return float4(sum / 128.0, 1.0);
}

//!PASS 10
//!DESC Average luma: smoothing
//!STYLE PS
//!IN AVG2, LUMH
//!OUT LUM

#define SourceSize float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y)
float3 grid_cell(float nx, float ny, float ix, float iy)
{
	float col = (nx < 2.5) ? ix : 2.0 + ix;
	float row = (ny < 1.5) ? 0.0 : ((ny < 2.5) ? 1.0 + iy : 3.0 + iy);
	return AVG2.SampleLevel(sPt, float2((col + 0.5) / 5.0, (row + 0.5) / 6.0), 0).rgb;
}

// emulates textureLod(Source, uv, m) on the tiny mip level (2-3 texels per axis) with bilinear filtering
float3 mip_fetch(float nx, float ny, float2 uv)
{
	float2 n = float2(nx, ny);
	float2 t = uv * n - 0.5;
	float2 i0 = floor(t);
	float2 f = t - i0;
	float2 a = clamp(i0, 0.0, n - 1.0);
	float2 b = clamp(i0 + 1.0, 0.0, n - 1.0);
	float3 c00 = grid_cell(nx, ny, a.x, a.y);
	float3 c10 = grid_cell(nx, ny, b.x, a.y);
	float3 c01 = grid_cell(nx, ny, a.x, b.y);
	float3 c11 = grid_cell(nx, ny, b.x, b.y);
	return lerp(lerp(c00, c10, f.x), lerp(c01, c11, f.x), f.y);
}

float4 Pass10(float2 pos)
{
	float W = SourceSize.x;
	float H = SourceSize.y;
	float m = floor(max(max(log2(W), log2(H)), 1.0)) - 1.0;
	float nx = clamp(floor(W / exp2(m)), 2.0, 3.0);
	float ny = clamp(floor(H / exp2(m)), 1.0, 3.0);
	float ltotal = 0.0;
	ltotal += length(mip_fetch(nx, ny, float2(0.3, 0.3)));
	ltotal += length(mip_fetch(nx, ny, float2(0.3, 0.7)));
	ltotal += length(mip_fetch(nx, ny, float2(0.7, 0.3)));
	ltotal += length(mip_fetch(nx, ny, float2(0.7, 0.7)));
	ltotal *= 0.25;
	ltotal = pow(0.577350269 * ltotal, 0.70);
	float lhistory = LUMH.SampleLevel(sPt, float2(0.5, 0.5), 0).x;
	ltotal = lerp(ltotal, lhistory, min(lerp(lsmooth, lsmooth + lsdev, ltotal), 0.99));
	return float4(ltotal, ltotal, ltotal, ltotal);
}

//!PASS 11
//!DESC Average luma: history
//!STYLE PS
//!IN LUM
//!OUT LUMH

float4 Pass11(float2 pos)
{
	return LUM.SampleLevel(sPt, pos, 0);
}

//!PASS 12
//!DESC Linearize
//!STYLE PS
//!IN T06, T0I
//!OUT TLIN

#define SourceSize float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y)
static float2 vTexCoord;
float3 fetch_pixel(float2 coord)
{
	float2 dx = float2(SourceSize.z, 0.0) * downsample_levelx;
	float2 dy = float2(0.0, SourceSize.w) * downsample_levely;	
	float2 d1 = dx + dy;
	float2 d2 = dx - dy;
	
	float sum = 15.0;
	float3 result = 3.0*T06.SampleLevel(sLin,coord,0).rgb + 
	              2.0*T06.SampleLevel(sLin,coord + dx,0).rgb +
	              2.0*T06.SampleLevel(sLin,coord - dx,0).rgb +
	              2.0*T06.SampleLevel(sLin,coord + dy,0).rgb +
	              2.0*T06.SampleLevel(sLin,coord - dy,0).rgb +
	              T06.SampleLevel(sLin,coord + d1,0).rgb +
	              T06.SampleLevel(sLin,coord - d1,0).rgb +
	              T06.SampleLevel(sLin,coord + d2,0).rgb +
	              T06.SampleLevel(sLin,coord - d2,0).rgb;  
				  
	return result/sum;
}

float4 Pass12(float2 mpos)
{
	vTexCoord = mpos * 1.00001;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float3 c = T06.SampleLevel(sLin,vTexCoord,0).rgb;
	
	if ((downsample_levelx + downsample_levely) > 0.025)
	{
		c = fetch_pixel(vTexCoord);
	}

	float intera = T0I.SampleLevel(sLin,float2(0.75, 0.75),0).a;
	float gamma_in = GAMMA_INPUT;

	c = pow(c, ((float3)(gamma_in)));
	
	if (vTexCoord.x > 0.5) gamma_in = intera; else gamma_in = 1.0/gamma_in;
	
	FragColor = float4(c, gamma_in);
	return FragColor;
}

//!PASS 13
//!DESC CRT pass 1 (horizontal filter)
//!STYLE PS
//!IN TLIN
//!OUT TP1

#define SourceSize float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(float(GetOutputSize().x),float(GetInputSize().y),GetOutputPt().x,GetInputPt().y)
#define TEXSIZE_TLIN int2(float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y).xy)
static float2 vTexCoord;
float gaussian(float x, float xscale)
{
	return exp(-x*x*xscale);
}

float4 Pass13(float2 mpos)
{
	vTexCoord = mpos * 1.00001;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float2 prescalex = ((float2)(TEXSIZE_TLIN)) / OriginalSize.xy;

	float4 SourceSize_l = OriginalSize * float4(prescalex.x, prescalex.y, 1.0/prescalex.x, 1.0/prescalex.y);

	float f = frac(SourceSize_l.x * vTexCoord.x);
	f = 0.5 - f;
	float2 tex = floor(SourceSize_l.xy * vTexCoord)*SourceSize_l.zw + 0.5*SourceSize_l.zw;
	float3 color = 0.0.xxx;
	float scolor = 0.0;
	float2 dx  = float2(SourceSize_l.z, 0.0);

	float w = 0.0;
	float swsum = 0.0;
	float wsum = 0.0;
	float3 pixel;
	float3 cmax = 0.0.xxx;
	float3 cmin = 1.0.xxx;
	
	float xscale = max(prescalex.x * 0.4, 1.0);
	float hsharpness = (HSHARPNESS * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)) * xscale * filter_res;
	
	xscale = 1.0/(2.0*(SIGMA_HOR * (HSHARPNESS * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)))*(SIGMA_HOR * (HSHARPNESS * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)))*xscale*xscale*filter_res*filter_res);	
	float sharp = gaussian(hsharpness, xscale) * S_SHARP;
	float ksharp = -2.0*hsharpness*xscale*sharp;	
	float maxsharp = MAXS;
	float FPR = hsharpness;
	float FPRi = 1.0/hsharpness;	
	float fpx = 0.0;
	float sp = 0.0;
	float sw = 0.0;

	float ts = 0.025;
	float3 luma = float3(0.2126, 0.7152, 0.0722); 
	
	float LOOPSIZE = ceil(2.0*FPR);
	
	float n = -LOOPSIZE;
	
	do
	{
		pixel  = TLIN.SampleLevel(sLin,tex + n*dx,0).rgb;
		
		w = gaussian(n+f,xscale) - sharp;
		fpx = clamp((abs(n+f)-FPR)*FPRi, 0.0, 1.0);
		if (w < 0.0) w = max(ksharp*fpx, maxsharp * ksharp * (1.0-fpx*fpx));
		else
		{
			cmax = max(cmax, pixel); cmin = min(cmin, pixel);
			sw = w * (dot(pixel,luma) + ts);
			sp = max(max(pixel.r,pixel.g),pixel.b);			
			scolor = scolor + sw * sp;
			swsum = swsum + sw;			
		}
		color = color + w * pixel;
		wsum  = wsum + w;

		n = n + 1.0;
			
	} while (n <= LOOPSIZE);

	color = color / wsum;
	scolor = scolor / swsum;
	
	color = clamp(lerp(clamp(color, cmin, cmax), color, HARNG), 0.0, 1.0); 
	
	scolor = clamp(lerp(max(max(color.r, color.g),color.b), scolor, spike), 0.0, 1.0);
	
	FragColor = float4(color, scolor);
	return FragColor;
}

//!PASS 14
//!DESC Glow horizontal
//!STYLE PS
//!IN TLIN
//!OUT TGH

#define SourceSize float4(float(GetOutputSize().x),float(GetInputSize().y),GetOutputPt().x,GetInputPt().y)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(800.0,float(GetInputSize().y),1.0/800.0,GetInputPt().y)
static float2 vTexCoord;
float gaussian(float x)
{
	return exp(-x*x*(1.0/(2.0*(SIGMA_H * (SIZEH * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)) / 6.0)*(SIGMA_H * (SIZEH * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)) / 6.0))));
}

float3 plant (float3 tar, float r)
{
	float t = max(max(tar.r,tar.g),tar.b) + 0.00001;
	return tar * r / t;
}

float4 Pass14(float2 mpos)
{
	vTexCoord = mpos;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float4 SourceSize1 = OriginalSize*float4(((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)), ((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)), 1.0/((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)), 1.0/((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)));
	float f = frac(SourceSize1.x * vTexCoord.x);
	f = 0.5 - f;
	float2 tex = floor(SourceSize1.xy * vTexCoord)*SourceSize1.zw + 0.5*SourceSize1.zw;
	float3 color = ((float3)(0.0));
	float2 dx  = float2(SourceSize1.z, 0.0);

	float w;
	float wsum = 0.0;
	float3 pixel;
	float n = -(SIZEH * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0));

	do
	{
		pixel  = TLIN.SampleLevel(sLin,tex + n*dx,0).rgb;
		if (m_glow > 0.5)
		{
			pixel = max(pixel-m_glow_cutoff, 0.0);
			pixel = plant(pixel, max(max(max(pixel.r,pixel.g),pixel.b)-m_glow_cutoff,0.0));
		}
		w      = gaussian(n+f);
		color  = color + w * pixel;
		wsum   = wsum + w;
		n = n + 1.0;
		
	} while (n <= (SIZEH * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)));

	color = color / wsum;
	
	FragColor = float4(color, 1.0);
	return FragColor;
}

//!PASS 15
//!DESC Glow vertical
//!STYLE PS
//!IN TGH
//!OUT TGV

#define SourceSize float4(800.0,float(GetInputSize().y),1.0/800.0,GetInputPt().y)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(800.0,600.0,1.0/800.0,1.0/600.0)
static float2 vTexCoord;
float gaussian(float x)
{
	return exp(-x*x*(1.0/(2.0*(SIGMA_V * SIZEV / 6.0)*(SIGMA_V * SIZEV / 6.0))));
}

float3 plant (float3 tar, float r)
{
	float t = max(max(tar.r,tar.g),tar.b) + 0.00001;
	return tar * r / t;
}

float4 Pass15(float2 mpos)
{
	vTexCoord = mpos;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float4 SourceSize1 = float4(SourceSize.x, OriginalSize.y, SourceSize.z, OriginalSize.w)*float4(((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)), ((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)), 1.0/((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)), 1.0/((FINE_GLOW > 0.5) ? FINE_GLOW : lerp(0.75, 0.5, -FINE_GLOW)));
	float f = frac(SourceSize1.y * vTexCoord.y);
	f = 0.5 - f;
	float2 tex = floor(SourceSize1.xy * vTexCoord)*SourceSize1.zw + 0.5*SourceSize1.zw;
	float3 color = ((float3)(0.0));
	float2 dy  = float2(0.0, SourceSize1.w);

	float w;
	float wsum = 0.0;
	float3 pixel;
	float n = -SIZEV;

	do
	{
		pixel  = TGH.SampleLevel(sLin,tex + n*dy,0).rgb;
		w      = gaussian(n+f);
		color  = color + w * pixel;
		wsum   = wsum + w;
		n = n + 1.0;
		
	} while (n <= SIZEV);

	color = color / wsum;
	
	FragColor = float4(color, 1.0);
	return FragColor;
}

//!PASS 16
//!DESC Bloom horizontal
//!STYLE PS
//!IN TLIN
//!OUT TBH

#define SourceSize float4(800.0,600.0,1.0/800.0,1.0/600.0)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(800.0,600.0,1.0/800.0,1.0/600.0)
static float2 vTexCoord;
float gaussian(float x)
{
	return exp(-x*x*(1.0/(2.0*(SIGMA_HB * (SIZEHB * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)) / 3.0)*(SIGMA_HB * (SIZEHB * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)) / 3.0))));
}

float4 Pass16(float2 mpos)
{
	vTexCoord = mpos;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float4 SourceSize1 = OriginalSize * float4(((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)), ((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)), 1.0/((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)), 1.0/((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)));
	float f = frac(SourceSize1.x * vTexCoord.x);
	f = 0.5 - f;
	float2 tex = floor(SourceSize1.xy * vTexCoord)*SourceSize1.zw + 0.5*SourceSize1.zw;
	float4 color = ((float4)(0.0));
	float2 dx  = float2(SourceSize1.z, 0.0);

	float w;
	float wsum = 0.0;
	float4 pixel;
	float n = -(SIZEHB * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0));

	do
	{
		pixel  = TLIN.SampleLevel(sLin,tex + n*dx,0);
		w = gaussian(n+f);
		pixel.a = max(max(pixel.r, pixel.g),pixel.b);
		pixel.a*=pixel.a*pixel.a;
		color  = color + w * pixel;
		wsum   = wsum + w;
		n = n + 1.0;
		
	} while (n <= (SIZEHB * ((OriginalSize.y < 375.0) ? lerp(1.0, 2.0, clamp(auto_res * round(OriginalSize.x/300.0)-1.0, 0.0,1.0)) : 1.0)));

	color = color / wsum;
	
	FragColor = float4(color.rgb, pow(color.a, 0.333333));
	return FragColor;
}

//!PASS 17
//!DESC Bloom vertical
//!STYLE PS
//!IN TBH
//!OUT TBV

#define SourceSize float4(800.0,600.0,1.0/800.0,1.0/600.0)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(800.0,600.0,1.0/800.0,1.0/600.0)
static float2 vTexCoord;
float gaussian(float x)
{
	return exp(-x*x*(1.0/(2.0*(SIGMA_VB * SIZEVB / 3.0)*(SIGMA_VB * SIZEVB / 3.0))));
}

float4 Pass17(float2 mpos)
{
	vTexCoord = mpos;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float4 SourceSize1 = SourceSize;
	SourceSize1.yw = OriginalSize.yw;
	SourceSize1 = SourceSize1 * float4(((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)), ((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)), 1.0/((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)), 1.0/((FINE_BLOOM > 0.5) ? FINE_BLOOM : lerp(0.75, 0.5, -FINE_BLOOM)));
	
	float f = frac(SourceSize1.y * vTexCoord.y);
	f = 0.5 - f;
	float2 tex = floor(SourceSize1.xy * vTexCoord)*SourceSize1.zw + 0.5*SourceSize1.zw;
	float4 color = ((float4)(0.0));
	float2 dy  = float2(0.0, SourceSize1.w);

	float w;
	float wsum = 0.0;
	float4 pixel;
	float n = -SIZEVB;

	do
	{
		pixel  = TBH.SampleLevel(sLin,tex + n*dy,0);
		w = gaussian(n+f);
		pixel.a*=pixel.a*pixel.a;
		color  = color + w * pixel;
		wsum   = wsum + w;
		n = n + 1.0;
		
	} while (n <= SIZEVB);

	color = color / wsum;
	
	FragColor = float4(color.rgb, pow(color.a, 0.175));
	return FragColor;
}

//!PASS 18
//!DESC CRT pass 2 (scanlines / mask / bloom)
//!STYLE PS
//!IN LUM, TBV, TLIN, TP1
//!OUT TCRT

#define SourceSize float4(800.0,600.0,1.0/800.0,1.0/600.0)
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(float2(GetOutputSize()),GetOutputPt())
#define TEXSIZE_TLIN int2(float4(2.0*float(GetInputSize().x),float(GetInputSize().y),0.5*GetInputPt().x,GetInputPt().y).xy)
static float2 vTexCoord;
float st(float x)
{
	return exp2(((bloomsamp < 0.5) ? -10.0 : -12.5)*x*x);
} 
   
float3 sw0(float x, float color, float scanline, float3 c)
{
	float tmp = lerp(beam_min, beam_max, color);
	float3 sat = lerp(1.0.xxx + (1.5*scans), 1.0.xxx, c);
	float ex = x*tmp;
	ex = (gsl > -0.5) ? ex*ex : lerp(ex*ex, ex*ex*ex, 0.4);
	return exp2(-scanline*ex*sat);
} 

float3 sw1(float x, float color, float scanline, float3 c)
{	
	x = lerp (x, beam_min*x, max(x-0.4*color,0.0));
	float3 sat = lerp(1.0.xxx + (1.5*scans), 1.0.xxx, c);	
	float tmp = lerp(1.2*beam_min, beam_max, color);
	float ex = x*tmp;
	return exp2(-scanline*ex*ex*sat);
}    

float3 sw2(float x, float color, float scanline, float3 c)
{
	float tmp = lerp((2.5-0.5*color)*beam_min, beam_max, color);
	float3 sat = lerp(1.0.xxx + (1.5*scans), 1.0.xxx, c);	
	tmp = lerp(beam_max, tmp, pow(x, color+0.3));
	float ex = x*tmp;
	return exp2(-scanline*ex*ex*sat);
}   

 
float2 Warp(float2 pos)
{
	pos  = pos*2.0-1.0;
	pos = lerp(pos, sign(pos)*pow(abs(pos), 1.0 + min(15.0*float2(warpY,warpX)*cbulge.xx, cbulge.xx)), 0.075 + 0.125*(abs(pos)+pos*pos));
	pos = lerp(pos, float2(pos.x*rsqrt(1.0-c_shape*pos.y*pos.y), pos.y*rsqrt(1.0-c_shape*pos.x*pos.x)), float2(warpX, warpY)/c_shape);
	return pos*0.5 + 0.5;
}

float2 Overscan(float2 pos, float dx, float dy){
	pos=pos*2.0-1.0;    
	pos*=float2(dx,dy);
	return pos*0.5+0.5;
} 

float3 gc(float3 c)
{
	float mc = max(max(c.r,c.g),c.b);
	float mg = pow(mc, 1.0/gamma_c);
	return c * mg/(mc + (1e-8));  
}

float3 plant (float3 tar, float r)
{
	float t = max(max(tar.r,tar.g),tar.b) + 0.00001;
	return tar * r / t;
}

float4 Pass18(float2 mpos)
{
	vTexCoord = mpos * 1.00001;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float prescalex = float(TEXSIZE_TLIN.x) / (2.0*OriginalSize.x);
	
	float4 SourceSize_l = OriginalSize * float4(prescalex, 1.0, 1.0/prescalex, 1.0);
	
	SourceSize_l*= float4(2.0, 1.0, 0.5, 1.0);
	
	float lum = LUM.SampleLevel(sPt,float2(0.5,0.5),0).a;
	
	float gamma_in = 1.0/TLIN.SampleLevel(sLin,float2(0.25,0.25),0).a;
	float intera = TLIN.SampleLevel(sLin,float2(0.75,0.25),0).a;
	bool hscan = (hiscan > 0.5);
	bool inter6 = (intera < 0.35 && interm == 6.0);
	bool interb  = (((intera < 0.35 && !inter6) || (no_scanlines > 0.025)) && !hscan);

	float SourceY = SourceSize_l.y;	
	float sy = 1.0;
	if (intres == 1.0) sy = max(round(SourceY/224.0),1.0);
	if (intres > 0.25 && intres != 1.0) sy = intres;
	if (inter6) sy*=2.0;
	
	SourceSize_l*=float4(1.0, 1.0/sy, 1.0, sy);
	
	
   
	float2 texcoord = vTexCoord.xy;
	if (IOS > 0.0 && !interb){
		float2 ofactor = OutputSize.xy/OriginalSize.xy;
		float2 intfactor = (IOS < 2.5) ? floor(ofactor) : ceil(ofactor);
		float2 diff = ofactor/intfactor;
		float scan = diff.y;
		texcoord = Overscan(texcoord, scan, scan);
		if (IOS == 1.0 || IOS == 3.0) texcoord = float2(vTexCoord.x, texcoord.y);
	}
   
	float factor  = 1.00 + (1.0-0.5*OS)*BLOOM/100.0 - lum*BLOOM/100.0;
	texcoord  = Overscan(texcoord, factor, factor);

	texcoord.y = texcoord.y - VShift*OriginalSize.w;
	texcoord = Overscan(texcoord, (OriginalSize.x - overscanX)/OriginalSize.x, (OriginalSize.y - overscanY)/OriginalSize.y);

	float2 pos  = Warp(texcoord);
	float2 pos0 = Warp(vTexCoord.xy);

	

	float ii = float(inter6)*(floor(mod(float(FrameCount), 2.0)));

	float2 coffset = float2(0.5, 0.5 + 0.5*ii);
	
	float2 ps = SourceSize_l.zw;
	float2 OGL2Pos = pos * SourceSize_l.xy - coffset;
	float2 fp = frac(OGL2Pos);
	
	float2 dx = float2(ps.x,0.0);
	float2 dy = float2(0.0, ps.y);
   
	

	float  f = fp.y;
	
	float2 pC4 = floor(OGL2Pos) * ps + 0.5*ps; pC4.y = pC4.y + float(inter6)*0.25*dy.y;
	pC4.x = pos.x;

	if (intres == 0.5 && prescalex < 1.5) pC4.y = floor(pC4.y * OriginalSize.y)*OriginalSize.w + 0.5*OriginalSize.w;
	
	if (interb && no_scanlines < 0.025 || hscan)  pC4.y = pos.y; else if (interb) pC4.y = pC4.y + smoothstep(0.40-0.5*no_scanlines, 0.60 + 0.5*no_scanlines, f)*SourceSize_l.w;	
	
	float3 color1 = TP1.SampleLevel(sLin,pC4,0).rgb;
	float3 scolor1 = 	TP1.SampleLevel(sLin,pC4,0).aaa;

	if(!interb) color1 = pow(color1, ((float3)(scangamma/gamma_in)));
  
	pC4+=dy;

	if (intres == 0.5 && prescalex < 1.5) pC4.y = floor((pos.y + 0.33*dy.y) * OriginalSize.y)*OriginalSize.w + 0.5*OriginalSize.w;
	
	float3 color2 = TP1.SampleLevel(sLin,pC4,0).rgb;
	float3 scolor2 = 	TP1.SampleLevel(sLin,pC4,0).aaa;

	if(!interb) color2 = pow(color2, ((float3)(scangamma/gamma_in))); 

	float3 ctmp = color1; float w3 = 1.0; float3 color = color1;
	float3 one = ((float3)(1.0));
	
	if (hscan) { color2 = color1; scolor2 = scolor1; }

if (!interb || hscan)
{	
	

	float ssub = ssharp*abs(scolor1.x-scolor2.x);

	float shape1 = lerp(scanline1, scanline2 + ssub * scolor1.x * 35.0, f);
	float shape2 = lerp(scanline1, scanline2 + ssub * scolor2.x * 35.0, 1.0-f);
	
	float wt1 = st(f);
	float wt2 = st(1.0-f);

	float3 color00 = color1*wt1 + color2*wt2;
	float3 scolor0 = scolor1*wt1 + scolor2*wt2;
	
	ctmp = color00/(wt1+wt2);
	float3 sctmp = scolor0/(wt1+wt2);

	if (abs(rolling_scan) > 0.005) 
	{ 
		color1 = ctmp; color2 = ctmp;
		scolor1 = sctmp; scolor2 = sctmp;
	}
	
	float3 w1, w2;
	
	float3 cref1 = lerp(sctmp, scolor1, beam_size); float creff1 = pow(max(max(cref1.r,cref1.g),cref1.b), scan_falloff);
	float3 cref2 = lerp(sctmp, scolor2, beam_size); float creff2 = pow(max(max(cref2.r,cref2.g),cref2.b), scan_falloff);

	if (tds > 0.5) { shape1 = lerp(scanline2, shape1, creff1); shape2 = lerp(scanline2, shape2, creff2); }

	float scanpix = OriginalSize.y/OutputSize.y;
	float f1 = frac(f - rolling_scan*float(FrameCount)*scanpix);
	float f2 = 1.0 - f1;

	float mc1 = max(max(color1.r,color1.g),color1.b) + (1e-8);
	float mc2 = max(max(color2.r,color2.g),color2.b) + (1e-8);
	
	cref1 = color1 / mc1;
	cref2 = color2 / mc2;

	if (gsl <  0.5) { w1 = sw0(f1,creff1,shape1,cref1); w2 = sw0(f2,creff2,shape2,cref2);} else
	if (gsl == 1.0) { w1 = sw1(f1,creff1,shape1,cref1); w2 = sw1(f2,creff2,shape2,cref2);} else
	                { w1 = sw2(f1,creff1,shape1,cref1); w2 = sw2(f2,creff2,shape2,cref2);}

	float3 w3 = w1+w2;
	float wf1 = max(max(w3.r,w3.g),w3.b);
	if (wf1 > 1.0) {wf1 = 1.0/wf1; w1*=wf1, w2*=wf1;}

	if (abs(clips) > 0.005)
	{
		sy = mc1; one = (clips > 0.0) ? w1 : 1.0.xxx;
		float sat = 1.0001-min(min(cref1.r,cref1.g),cref1.b);
		color1 = lerp(color1, plant(pow(color1, 0.70.xxx-0.325*sat),sy), pow(sat,0.3333)*one*abs(clips));
		sy = mc2; one = (clips > 0.0) ? w2 : 1.0.xxx;
		sat =       1.0001-min(min(cref2.r,cref2.g),cref2.b);
		color2 = lerp(color2, plant(pow(color2, 0.70.xxx-0.325*sat),sy), pow(sat,0.3333)*one*abs(clips));
	}	
	
	color = (gc(color1)*w1 + gc(color2)*w2);

	if (bloomsamp > 0.5) {	
		float3 Bloom = TBV.SampleLevel(sLin,pos,0).rgb;
		Bloom = pow(Bloom, ((float3)(scangamma/gamma_in)));
		float cm = max(max(ctmp.r,ctmp.g),ctmp.b);
		float bm = max(max(Bloom.r,Bloom.g),Bloom.b);
		float bmix = clamp(max((cm-bm), (bm-cm)/(cm+0.25)-cm), 0.0, 1.0);
		if (abs(clips) > 0.005)
		{
			sy = cm + (1e-8); one = (clips > 0.0) ? min(w1+w2,1.0) : 1.0.xxx;
			cref1 = plant(Bloom,1.0);
			float sat = 1.0001-min(min(cref1.r,cref1.g),cref1.b);
			Bloom = lerp(Bloom, plant(pow(Bloom, 0.70.xxx-0.325*sat),sy), pow(sat,0.3333)*one*abs(clips));
		}
		float3 Bloom1 = (color1*wt1 + color2*wt2)/(wt1+wt2);
		Bloom = lerp(Bloom, Bloom1, min(3.0*abs(plant(sqrt(Bloom1),1.0) - plant(sqrt(Bloom),1.0)), 1.0));
		bm = max(max(Bloom.r,Bloom.g),Bloom.b);
		Bloom = plant(lerp(Bloom,Bloom1,bloomsamp-1.0), lerp(bm, 1.125*cm, bmix));	
		Bloom = gc(Bloom)*(w1+w2);
		color = min(lerp(color, Bloom, pow(cm, lerp(0.4, 0.2, pow(cm,0.375)))), max(Bloom,color));
	}

	color = min(color, 1.0);
}
	
	if (interb)
	{
		color = gc(color1);
	}

	float colmx = max(max(ctmp.r,ctmp.g),ctmp.b);

	if(!interb) { color = pow(color, ((float3)(gamma_in/scangamma))); colmx = pow(colmx, gamma_in/scangamma); }
  
	FragColor = float4(color, colmx);
	return FragColor;
}

//!PASS 19
//!DESC Deconvergence / output
//!STYLE PS
//!IN INPUT, LUM, TBV, TCRT, TGV, TLIN, TPRE
//!OUT OUTPUT

#define SourceSize float4(float2(GetOutputSize()),GetOutputPt())
#define OriginalSize float4(float2(GetInputSize()),GetInputPt())
#define OutputSize float4(float2(GetOutputSize()),GetOutputPt())
static float2 vTexCoord;
float3 Mask(float2 pos, float mx, float mb)
{
	float3 mask = float3(maskDark, maskDark, maskDark);
	float3 one = ((float3)(1.0));
	
	if (shadowMask == 0.0)
	{
		float mc = 1.0 - max(maskstr, 0.0);	
		pos.x = frac(pos.x*0.5);
		if (pos.x < 0.49) { mask.r = 1.0; mask.g = mc; mask.b = 1.0; }
		else { mask.r = mc; mask.g = 1.0; mask.b = mc; }
	}    
   
	
	else if (shadowMask == 1.0)
	{
		float line_x = maskLight;
		float odd  = 0.0;

		if (frac(pos.x/6.0) < 0.49)
			odd = 1.0;
		if (frac((pos.y + odd)/2.0) < 0.49)
			line_x = maskDark;

		pos.x = floor(mod(pos.x,3.0));
    
		if      (pos.x < 0.5) mask.r = maskLight;
		else if (pos.x < 1.5) mask.g = maskLight;
		else                  mask.b = maskLight;
		
		mask*=line_x;
	} 

	
	else if (shadowMask == 2.0)
	{
		pos.x = floor(mod(pos.x,3.0));

		if      (pos.x < 0.5) mask.r = maskLight;
		else if (pos.x < 1.5) mask.g = maskLight;
		else                  mask.b = maskLight;
	} 

	
	else if (shadowMask == 3.0)
	{
		pos.x += pos.y*3.0;
		pos.x  = frac(pos.x/6.0);

		if      (pos.x < 0.3) mask.r = maskLight;
		else if (pos.x < 0.6) mask.g = maskLight;
		else                  mask.b = maskLight;
	}

	
	else if (shadowMask == 4.0)
	{
		pos.xy = floor(pos.xy*float2(1.0, 0.5));
		pos.x += pos.y*3.0;
		pos.x  = frac(pos.x/6.0);

		if      (pos.x < 0.3) mask.r = maskLight;
		else if (pos.x < 0.6) mask.g = maskLight;
		else                  mask.b = maskLight;
	}
	
	
	else if (shadowMask == 5.0)
	{
		mask = ((float3)(0.0));		
		pos.x = frac(pos.x/2.0);
		if  (pos.x < 0.49)
		{	mask.r  = 1.0;
			mask.b  = 1.0;
		}
		else     mask.g = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}    

	
	else if (shadowMask == 6.0)
	{
		mask = ((float3)(0.0));
		pos.x = floor(mod(pos.x,3.0));
		if      (pos.x < 0.5) mask.r = 1.0;
		else if (pos.x < 1.5) mask.g = 1.0;
		else                    mask.b = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}
	
	
	else if (shadowMask == 7.0)
	{
		mask = ((float3)(0.0));		
		pos.x = frac(pos.x/2.0);
		if  (pos.x < 0.49)
		{	mask  = 0.0.xxx;
		}
		else     mask = 1.0.xxx;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}    

	
	else if (shadowMask == 8.0)
	{
		mask = ((float3)(0.0));
		pos.x = frac(pos.x/3.0);
		if      (pos.x < 0.3) mask = 0.0.xxx;
		else if (pos.x < 0.6) mask = 1.0.xxx;
		else                  mask = 1.0.xxx;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}    

	
	else if (shadowMask == 9.0)
	{
		mask = ((float3)(0.0));
		pos.x = frac(pos.x/3.0);
		if      (pos.x < 0.3) mask    = 0.0.xxx;
		else if (pos.x < 0.6) mask.rb = 1.0.xx;
		else                  mask.g  = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);	
	}  
	
	
	else if (shadowMask == 10.0)
	{
		mask = ((float3)(0.0));
		pos.x = frac(pos.x * 0.25);
		if      (pos.x < 0.2)  mask  = 0.0.xxx;
		else if (pos.x < 0.4)  mask.r = 1.0;
		else if (pos.x < 0.7)  mask.g = 1.0;	
		else                   mask.b = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}  

	
	else if (shadowMask == 11.0)
	{
		mask = ((float3)(0.0));
		pos.x = frac(pos.x * 0.25);
		if      (pos.x < 0.2)  mask.r  = 1.0;
		else if (pos.x < 0.4)  mask.rg = 1.0.xx;
		else if (pos.x < 0.7)  mask.gb = 1.0.xx;	
		else                   mask.b  = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}     

	
	else if (shadowMask == 12.0)
	{
		mask = ((float3)(0.0));
		pos.x = floor(mod(pos.x,7.0));
		if      (pos.x < 0.5)  mask   = 0.0.xxx;
		else if (pos.x < 2.5)  mask.r = 1.0;
		else if (pos.x < 4.5)  mask.g = 1.0;	
		else                   mask.b = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}

	
	else if (shadowMask == 13.0)
	{
		mask = ((float3)(0.0));
		pos.x = floor(mod(pos.x,6.0));
		if      (pos.x < 0.5)  mask   = 0.0.xxx;
		else if (pos.x < 1.5)  mask.r = 1.0;
		else if (pos.x < 2.5)  mask.rg = 1.0.xx;
		else if (pos.x < 3.5)  mask.rgb = 1.0.xxx;
		else if (pos.x < 4.5)  mask.gb = 1.0.xx;		
		else                   mask.b = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	}

	
	else
	{
		mask = ((float3)(0.0));
		pos.x = floor(mod(pos.x, 5.0));
		if      (pos.x < 0.5)  mask    = 0.0.xxx;
		else if (pos.x < 1.5)  mask.r  = 1.0;
		else if (pos.x < 2.5)  mask.rg = 1.0.xx;
		else if (pos.x < 3.5)  mask.gb = 1.0.xx;	
		else                   mask.b  = 1.0;
		mask = clamp(lerp( lerp(one, mask, mcut), lerp(one, mask, maskstr), mx), 0.0, 1.0);
	} 
	
	if (mask_layout > 0.5) mask = mask.rbg;
	float maskmin = min(min(mask.r,mask.g),mask.b);
	return (mask - maskmin) * (1.0 + (maskboost-1.0)*mb) + maskmin;
}

float SlotMask(float2 pos, float m, float swidth)
{
	if ((slotmask + slotmask1) == 0.0) return 1.0;
	else
	{
	pos.y = floor(pos.y/slotms);
	float mlen = swidth*2.0;
	float px = floor(mod(pos.x, 0.99999*mlen));
	float py = floor(frac(pos.y/(2.0*double_slot))*2.0*double_slot);
	float slot_dark = lerp(1.0-slotmask1, 1.0-slotmask, m);
	float slot = 1.0;
	if (py == 0.0 && px < swidth) slot = slot_dark; else
	if (py == double_slot && px >= swidth) slot = slot_dark;		
	
	return slot;
	}
}
 
float2 Warp(float2 pos)
{
	pos  = pos*2.0-1.0;
	pos = lerp(pos, sign(pos)*pow(abs(pos), 1.0 + min(15.0*float2(warpY,warpX)*cbulge.xx, cbulge.xx)), 0.075 + 0.125*(abs(pos)+pos*pos));
	pos = lerp(pos, float2(pos.x*rsqrt(1.0-c_shape*pos.y*pos.y), pos.y*rsqrt(1.0-c_shape*pos.x*pos.x)), float2(warpX, warpY)/c_shape);
	return pos*0.5 + 0.5;
}

float2 Overscan(float2 pos, float dx, float dy){
	pos=pos*2.0-1.0;    
	pos*=float2(dx,dy);
	return pos*0.5+0.5;
} 

float humbar(float pos)
{
	if (barintensity == 0.0) return 1.0; else
	{
		pos = (barintensity >= 0.0) ? pos : (1.0-pos);
		pos = frac(pos + mod(float(FrameCount),barspeed)/(barspeed-1.0));
		pos = (barintensity <  0.0) ? pos : (1.0-pos);	
		return (1.0-barintensity) + barintensity*pos;
	}	
}

float corner(float2 pos) {
	pos = abs(2.0*(pos - 0.5));
	float2 aspect = float2(1.0, OutputSize.x/OutputSize.y);	
	float b = bsize1 * 0.05 + 0.0005; pos.y = pos.y + b*(aspect.y - 1.0);	
	float2 crn = max(csize.xx,2.0*b+0.0015);
	float2 cp = max(pos-(1.0-crn*aspect),0.0)/aspect; float cd = sqrt(dot(cp,cp));
	pos = max(pos, 1.0-crn+cd);
	float res = lerp(1.0, 0.0, smoothstep(1.0-b, 1.0, sqrt(max(pos.x,pos.y))));
	return pow(res, sborder);	
}

float3 plant (float3 tar, float r)
{
	float t = max(max(tar.r,tar.g),tar.b) + 0.00001;
	return tar * r / t;
}

float3 declip(float3 c, float b)
{
	float m = max(max(c.r,c.g),c.b);
	if (m > b) c = c*b/m;
	return c;
}

float igc(float mc)
{
	return pow(mc, gamma_c);
}

float3 gc2(float3 c, float w3)
{
	float mc = max(max(c.r,c.g),c.b);
	float gp = 1.0/(1.0 + (gamma_c2 - 1.0)*lerp(0.375, 1.0, w3));
	float mg = pow(mc, gp);
	return c * mg/(mc + (1e-10));  
}

float3 noise_x(float3 v){
    if (addnoised < 0.0) v.z = -addnoised; else v.z = mod(v.z,6001.0)/1753.0;
	
    v = frac(v) + frac(v*1e4) + frac(v*1e-4);
    
    v += float3(0.12345, 0.6789, 0.314159);
    
    v = frac(v*dot(v, v)*123.456);
    v = frac(v*dot(v, v)*123.456);
	v = frac(v*dot(v, v)*123.456);
	v = frac(v*dot(v, v)*123.456);	
    return v;
} 

void fetch_pixel (inout float3 c, inout float3 b, inout float3 g, float2 coord, float2 bcoord)
{
		float stepx = OutputSize.z;
		float stepy = OutputSize.w;
		
		float ds = decons;
				
		float2 dx = float2(stepx, 0.0);
		float2 dy = float2(0.0, stepy);		
		
		float posx = 2.0*coord.x - 1.0;
		float posy = 2.0*coord.y - 1.0;
		
		if (dctypex > 0.025)
		{
			posx = sign(posx)*pow(abs(posx), 1.05-dctypex);
			dx = posx * dx;
		}

		if (dctypey > 0.025)
		{

			posy = sign(posy)*pow(abs(posy), 1.05-dctypey);
			dy = posy * dy;
		}

		float2 rc = deconrr * dx + deconrry*dy;
		float2 gc = deconrg * dx + deconrgy*dy;
		float2 bc = deconrb * dx + deconrby*dy;		

		float r1 = TCRT.SampleLevel(sLin,coord + rc,0).r;
		float g1 = TCRT.SampleLevel(sLin,coord + gc,0).g;
		float b1 = TCRT.SampleLevel(sLin,coord + bc,0).b;

		float3 d = float3(r1, g1, b1);
		c = clamp(lerp(c, d, ds), 0.0, 1.0);
		
		r1 = TBV.SampleLevel(sLin,bcoord + rc,0).r;
		g1 = TBV.SampleLevel(sLin,bcoord + gc,0).g;
		b1 = TBV.SampleLevel(sLin,bcoord + bc,0).b;

		d = float3(r1, g1, b1);
		b = g = lerp(b, d, min(ds,1.0));
		
		r1 = TGV.SampleLevel(sLin,bcoord + rc,0).r;
		g1 = TGV.SampleLevel(sLin,bcoord + gc,0).g;
		b1 = TGV.SampleLevel(sLin,bcoord + bc,0).b;

		d = float3(r1, g1, b1);
		g = lerp(g, d, min(ds,1.0));
}

float4 Pass19(float2 mpos)
{
	vTexCoord = mpos * 1.00001;
	float4 FragColor = float4(0.0, 0.0, 0.0, 0.0);
	float4 SourceSize_l = OriginalSize;
	
	float lum = LUM.SampleLevel(sPt,float2(0.5,0.5),0).a;
	
	float gamma_in = 1.0/TLIN.SampleLevel(sLin,float2(0.25,0.25),0).a;
	float intera = TLIN.SampleLevel(sLin,float2(0.75,0.25),0).a;
	bool inter6 = (intera < 0.35 && interm == 6.0);
	bool interb  = (((intera < 0.35 && !inter6) || no_scanlines > 0.025) && hiscan < 0.5);
	
	
   
	float2 texcoord = vTexCoord.xy;
	if (IOS > 0.0 && !interb){
		float2 ofactor = OutputSize.xy/OriginalSize.xy;
		float2 intfactor = (IOS < 2.5) ? floor(ofactor) : ceil(ofactor);
		float2 diff = ofactor/intfactor;
		float scan = diff.y;
		texcoord = Overscan(texcoord, scan, scan);
		if (IOS == 1.0 || IOS == 3.0) texcoord = float2(vTexCoord.x, texcoord.y);
	}
   
	float factor  = 1.00 + (1.0-0.5*OS)*BLOOM/100.0 - lum*BLOOM/100.0;
	texcoord  = Overscan(texcoord, factor, factor);

	texcoord.y = texcoord.y - VShift*OriginalSize.w;
	texcoord = Overscan(texcoord, (OriginalSize.x - overscanX)/OriginalSize.x, (OriginalSize.y - overscanY)/OriginalSize.y);

	float2 pos1 = vTexCoord.xy;
	float2 pos  = Warp(texcoord);
	float2 pos0 = Warp(vTexCoord.xy);
	float2 posb = 2.0*(pos0-0.5);
	if (BLOOM < 0.5) posb = max(abs(posb), abs(2.0*(pos-0.5)))*sign(posb);
	posb = 0.5*posb + 0.5;

	
	float3 color = TCRT.SampleLevel(sLin,pos1,0).rgb;
	float3  Bloom = TBV.SampleLevel(sLin,pos,0).rgb;
	float3  Glow = TGV.SampleLevel(sLin,pos,0).rgb;

if ((abs(deconrr) + abs(deconrry) + abs(deconrg) + abs(deconrgy) + abs(deconrb) + abs(deconrby)) > 0.2)
	fetch_pixel(color, Bloom, Glow, pos1, pos); 
	
	float cm = igc(max(max(color.r,color.g),color.b));
	float mx1 = TCRT.SampleLevel(sLin,pos1,0).a;
	float colmx = max(mx1, cm);
	float w3 = min((max((cm - 0.0005)*1.0005 ,0.0) + 0.0001) / (colmx + 0.0005), 1.0); if(interb) w3 = 1.0;
	
	float2 dx = float2(0.001, 0.0);
	float mx0 = TCRT.SampleLevel(sLin,pos1 - dx,0).a;
	float mx2 = TCRT.SampleLevel(sLin,pos1 + dx,0).a;
	float mxg = max(max(mx0,mx1),max(mx2,cm));
	float mx = pow(mxg, 1.40/gamma_in);
	float cx = pow(colmx, 1.4/gamma_in);
	
	
	
	dx = float2(OriginalSize.z, 0.0)*0.25;
	mx0 = TCRT.SampleLevel(sLin,pos1 - dx,0).a;
	mx2 = TCRT.SampleLevel(sLin,pos1 + dx,0).a;
	float mb = (1.0 - min(abs(mx0-mx2)/(0.5+mx1), 1.0));
	
	float3 one = ((float3)(1.0));
	
	
	
	float3 orig1 = color;
	float3 cmask = one;
	float3 cmask1 = one;
	float3 cmask2 = one;	

	
	float mwidths[15] = {2.0, 3.0, 3.0, 6.0, 6.0, 2.4, 3.4, 2.4, 3.25, 3.4, 4.4, 4.25, 7.4, 6.25, 5.25}; 
	
	float mwidth = mwidths[int(shadowMask)];
	float mask_compensate = frac(mwidth);
	float mwidth1 = mwidth;
	
if (shadowMask > -0.5)
{	
	float2 maskcoord = (vTexCoord * OutputSize.xy).xy + float2(laysh*masksize, 0.0);
	float2 scoord = maskcoord;
	
	mwidth = floor(mwidth) * masksize;
	float swidth = mwidth;
	bool zoomed = (abs(mask_zoom) > 0.75);
	float mscale = 1.0;
	float2 maskcoord0 = maskcoord;
	maskcoord.y = floor(maskcoord.y/masksize);
	mwidth1 = max(mwidth + mask_zoom, 2.0);

if ( mshift > 0.25 )
{	
	float stagg_lvl = 1.0; if (frac(mshift) > 0.25) stagg_lvl = 2.0;
	float next_line = float(floor(mod(maskcoord.y, 2.0*stagg_lvl)) < stagg_lvl);
	maskcoord0.x = maskcoord0.x + next_line * 0.5 * mwidth1;
}		
	maskcoord = maskcoord0/masksize;

if ( !zoomed )	
	cmask = Mask(floor(maskcoord), mx, mb);
else{
	mscale  = mwidth1/mwidth;
	float mlerp = frac(maskcoord.x/mscale); if (mzoom_sh > 0.025) mlerp = clamp((1.0 + mzoom_sh)*mlerp - 0.5*mzoom_sh, 0.0, 1.0);
	float mcoord = floor(maskcoord.x/mscale);
	if (shadowMask == 12.0 && mask_zoom == -2.0) mcoord = ceil(maskcoord.x/mscale);
	cmask = lerp(Mask(float2(mcoord,maskcoord.y), mx, mb), Mask(float2(mcoord + 1.0, maskcoord.y), mx, mb), mlerp);
}

	float sm_offset = 0.0; bool bsm_offset = (shadowMask == 0.0 || shadowMask == 2.0 || shadowMask == 5.0 || shadowMask == 6.0 || shadowMask == 8.0 || shadowMask == 11.0);
	if( zoomed ) { if (mask_layout < 0.5 && bsm_offset) sm_offset = 1.0; else if (bsm_offset) sm_offset = -1.0; }
	
	swidth = round(mwidth1); if (slotwidth > 0.5) swidth = slotwidth; float smask = 1.0;
	smask = SlotMask(scoord + float2(sm_offset,0.0), mx, swidth);

	smask = clamp(smask + lerp(smask_mit, 0.0, w3*pow(colmx, 0.3)), 0.0, 1.0);
	
	cmask2 = cmask;
	cmask*=smask;
	cmask1 = cmask;

	if (abs(mask_bloom) > 0.025)
	{
		float maxbl = max(max(max(Bloom.r,Bloom.g),Bloom.b), mxg);
		maxbl = maxbl * max(lerp(1.0, 2.0-colmx, bloom_dist), 0.0);
		if (mask_bloom > 0.025) cmask = max(min(cmask + maxbl*mask_bloom, 1.0), cmask); else cmask = max(lerp(cmask, cmask*(1.0-0.5*maxbl) + plant(pow(Bloom,0.35.xxx),maxbl), -mask_bloom),cmask);
	}
	
	color = pow(color, ((float3)(mask_gamma/gamma_in)));
	color = color*cmask;
	color = min(color,1.0);
	color = pow(color, ((float3)(gamma_in/mask_gamma)));

	cmask  = min(cmask, 1.0);
	cmask1 = min(cmask1, 1.0);
}

	float dark_compensate  = lerp(max( clamp( lerp (mcut, maskstr, mx),0.0, 1.0) - 1.0 + mask_compensate, 0.0) + 1.0, 1.0, mx); if(shadowMask < -0.5) dark_compensate = 1.0;
	float bb = lerp(brightboost, brightboost1, mx) * dark_compensate;
	color*=bb;

	float3  Ref = TLIN.SampleLevel(sLin,pos,0).rgb;	
	float maxb = TBV.SampleLevel(sLin,pos,0).a;
	float vig  = TPRE.SampleLevel(sLin,clamp(pos, 0.0+0.5*OriginalSize.zw, 1.0-0.5*OriginalSize.zw),0).a;

	if(pr_scan > 0.025)
	{
		float mbl = max(max(Bloom.r,Bloom.g),Bloom.b);
		Bloom = lerp(Bloom, lerp(Bloom, plant(orig1,mbl), min(2.5*(1.0-w3),1.0)), min(2.0*pr_scan, 1.0));
	}	

	float3 Bloom1 = Bloom;
	float3 bcmask = lerp(one, cmask1, bmask1);
	float3 hcmask = lerp(one, cmask1, hmask1);

	if (abs(bloom) > 0.025)
	{
		if (bloom < -0.01) Bloom1 = plant(Bloom, maxb);
		Bloom1 = min(Bloom1*(orig1+color), max(0.5*(colmx + orig1 - color),0.001*Bloom1));
		Bloom1 = 0.5*(Bloom1 + lerp(Bloom1, lerp(colmx*orig1, Bloom1, 0.5), 1.0-color));
		Bloom1 = bcmask*Bloom1 * max(lerp(1.0, 2.0-colmx, bloom_dist), 0.0);
		color = pow(pow(color, ((float3)(mask_gamma/gamma_in))) + abs(bloom) * pow(Bloom1, ((float3)(mask_gamma/gamma_in))), ((float3)(gamma_in/mask_gamma)));
	}

	if (halation > 0.01) {
		Bloom = 0.5*(Bloom + Bloom*Bloom);
		float mbl = max(max(Bloom.r,Bloom.g),Bloom.b); float cmxh = 0.5*(colmx + colmx*colmx);
		mbl = lerp(lerp(cmxh,lerp(cmxh,mbl,mbl),colmx), mbl, mb);
		Bloom = plant(Bloom, lerp(sqrt(mbl*cmxh), max((mbl - 0.15*(1.0-colmx)), 0.4*cmxh), pow(colmx, 0.25))) * lerp(0.425, 1.0, colmx);
		Bloom = (3.0 - colmx - color)*plant(0.325+orig1/w3, 0.5*(1.0+w3))*hcmask*Bloom;
		color = pow(pow(color, ((float3)(mask_gamma/gamma_in))) + halation * pow(Bloom, ((float3)(mask_gamma/gamma_in))), ((float3)(gamma_in/mask_gamma)));
	}
	else
	if (halation < -0.01) {
		float mbl = max(max(Bloom.r,Bloom.g),Bloom.b);
		Bloom = plant(Bloom + Ref + orig1 + Bloom*Bloom*Bloom, min(mbl*mbl,0.75));
		Bloom = 2.0*lerp(1.0,w3,0.5*colmx)*hcmask*Bloom;
		color = color -halation*Bloom;
	}

	color = min(color,1.0);
	color = gc2(color,w3);
	
	if (smoothmask > 0.125) { float w4 = pow(w3, 0.425 + 0.3*smoothmask); w4 = max(w4 - 0.175*colmx*smoothmask, 0.2); color = lerp(min(color/w4, plant(orig1,1.0 + 0.175*colmx*smoothmask))*w4, color, w4); }

	if (m_glow < 0.5) Glow = lerp(Glow, 0.25*color, colmx);
	else
	{ 
		maxb = max(max(Glow.r,Glow.g),Glow.b);
		float3 orig2 = plant(orig1 + 0.001*Ref, 1.0);
		Bloom = plant(Glow, 1.0);
		Ref = abs(orig2-Bloom);
		mx0 = max(max(orig2.r,orig2.g),orig2.b)-min(min(orig2.r,orig2.g),orig2.b);
		mx2 = max(max(Bloom.r,Bloom.g),Bloom.b)-min(min(Bloom.r,Bloom.g),Bloom.b);		
		Bloom = lerp(maxb*min(Bloom,orig2), lerp(lerp(Glow, max(max(Ref.r,Ref.g),Ref.b)*Glow, max(mx,mx0)), lerp(color, Glow, mx2), max(mx0,mx2)*Ref), min(sqrt((1.10-mx0)*(0.10+mx2)),1.0));
		if (m_glow > 1.5) Glow = lerp(0.5*Glow*Glow,Bloom,Bloom);
		Glow = lerp(m_glow_low*Glow, m_glow_high*Bloom, pow(colmx, m_glow_dist/gamma_in));
	}
	
	if (m_glow < 0.5) {
		if (glow >= 0.0) color = color + 0.5*Glow*glow; else color = color + abs(glow)*min(cmask2*cmask2,1.0)*Glow; }
	else { float3 cmaskg = clamp(lerp(one, cmask1, m_glow_mask),0.0, 1.0); color = color + abs(glow)*cmaskg*Glow; }

	color = min(color, 1.0);

	if (edgemask > 0.05) {
		mx0 = TCRT.SampleLevel(sLin,pos1 - dx,0).a; mx0 = TCRT.SampleLevel(sLin,pos1 - dx*(1.0-0.75*sqrt(mx0)),0).a; 
		mx2 = TCRT.SampleLevel(sLin,pos1 + dx,0).a; mx2 = TCRT.SampleLevel(sLin,pos1 + dx*(1.0-0.75*sqrt(mx2)),0).a; 
		float mx3 = TCRT.SampleLevel(sLin,pos1 - 4.0*dx,0).a;
		float mx4 = TCRT.SampleLevel(sLin,pos1 + 4.0*dx,0).a;
		mx4 = max(pow(abs(mx3-mx4),0.55-0.40*cx),min(max(mx3,mx4)/min(0.1+cx,1.0),1.0));
		mb = (1.0 - abs(pow(mx0,1.0-0.65*mx2)-pow(mx2,1.0-0.65*mx0)));
		mb = mx4*edgemask*(1.0001-mb*mb);
		float3 temp = lerp(color, orig1, mb);
		color = max(temp + lerp(3.5*mb*lerp(1.625*temp,temp,cx), 0.0.xxx, pow(color, 0.75.xxx-0.5*colmx)),color); }

	color = color * lerp(1.0, lerp(0.5*(1.0+w3), w3, mx), pr_scan);  
	
	color = min(color, max(orig1,color)*lerp(one, cmask1, mclip));  
	
	color = pow(color, ((float3)(1.0/gamma_out)));

	float rc = 0.6*sqrt(max(max(color.r, color.g), color.b))+0.4;
	
	if (abs(addnoised) > 0.01) 
	{
		float3 noise0 = noise_x(float3(floor(OutputSize.xy * vTexCoord / noiseresd), float(FrameCount)));
		if (noisetype < 0.5) color = lerp(color, noise0, 0.25*abs(addnoised) * rc); 
		else color = min(color * lerp(1.0, 1.5*noise0.x, 0.5*abs(addnoised)), 1.0);
	}

	colmx = max(max(orig1.r,orig1.g),orig1.b);
	color = color + bmask*lerp(cmask2, 0.125*(1.0-colmx)*color, min(20.0*colmx, 1.0));
	
	FragColor = lerp(float4(color*vig*humbar(lerp(pos.y, pos.x, bardir))*post_br*corner(posb), 1.0), 
	            INPUT.SampleLevel(sLin,(floor(pos1*OriginalSize.xy)+0.5)*OriginalSize.zw,0), step(pos1.x,oimage-0.00025));
	return FragColor;
}
