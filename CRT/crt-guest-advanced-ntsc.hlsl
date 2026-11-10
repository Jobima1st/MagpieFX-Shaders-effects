//!MAGPIE EFFECT
//!VERSION 4
//!USE _DYNAMIC
//!SORT_NAME crt-guest-advanced-ntsc

/*

	CRT - Guest - NTSC

	Copyright (C) 2018-2026 guest(r)

	Sega MS Blue Lift and Sega MD Pallete Fix fixes inspired by Azurfel

	contrast_sigmoid_inv function Copyright (C) 2020-2023 Dogway (Jose Linares)

	Incorporates many good ideas and suggestions from Dr. Venom.

	I would also like give thanks to many Libretro forums members for continuous feedback, suggestions and using the shader.

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
	without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
	See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along with this program; if not,
	write to the Free Software Foundation, Inc, 59 Temple Place - STE 330, Boston, MA 02111-1307, USA.

	Ported to ReShade by DevilSingh with some help from guest(r)

*/


// MagpieFX port: based on ReShade Port, done by Jobima using claude

//!PARAMETER
//!LABEL [Afterglow Settings] Afterglow Effect Threshold
//!DEFAULT 4
//!MIN 1
//!MAX 125
//!STEP 1
float bth;

//!PARAMETER
//!LABEL [Afterglow Settings] Persistence Red
//!DEFAULT 0.32
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float PR;

//!PARAMETER
//!LABEL [Afterglow Settings] Persistence Green
//!DEFAULT 0.32
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float PG;

//!PARAMETER
//!LABEL [Afterglow Settings] Persistence Blue
//!DEFAULT 0.32
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float PB;

//!PARAMETER
//!LABEL [Afterglow Settings] Afterglow Strength
//!DEFAULT 0.2
//!MIN 0
//!MAX 0.6
//!STEP 0.01
float AS;

//!PARAMETER
//!LABEL [Afterglow Settings] Afterglow saturation
//!DEFAULT 0.5
//!MIN 0
//!MAX 1
//!STEP 0.01
float ST;

//!PARAMETER
//!LABEL [Color Tweaks] Display Gamut: sRGB | Modern | DCI | Adobe | Rec. 2020 | P3
//!DEFAULT 0
//!MIN 0
//!MAX 5
//!STEP 1
float CS;

//!PARAMETER
//!LABEL [Color Tweaks] CRT Profile: EBU | P22 | SMPTE-C | Philips | Trinitron
//!DEFAULT 0
//!MIN -1
//!MAX 5
//!STEP 1
float CP;

//!PARAMETER
//!LABEL [Color Tweaks] LUT Colors: NTSC-J | Trinitron | Nec MultiSync | NTSC 1953
//!DEFAULT 0
//!MIN 0
//!MAX 4
//!STEP 1
float TNTC;

//!PARAMETER
//!LABEL [Color Tweaks] Fix LUT Dark Range
//!DEFAULT 5.0
//!MIN 0.0
//!MAX 50.0
//!STEP 1.0
float LUTLOW;

//!PARAMETER
//!LABEL [Color Tweaks] Fix LUT Brightness
//!DEFAULT 1.0
//!MIN 0.0
//!MAX 1.0
//!STEP 0.01
float LUTBR;

//!PARAMETER
//!LABEL [Color Tweaks] LUT Size
//!DEFAULT 32
//!MIN 16
//!MAX 64
//!STEP 16
float LS;

//!PARAMETER
//!LABEL [Color Tweaks] Color Temperature %
//!DEFAULT 0
//!MIN -100
//!MAX 100
//!STEP 5
float WP;

//!PARAMETER
//!LABEL [Color Tweaks] Saturation Adjustment
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.05
float wp_saturation;

//!PARAMETER
//!LABEL [Color Tweaks] Brightness Adjustment
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.01
float pre_bb;

//!PARAMETER
//!LABEL [Color Tweaks] Contrast Adjustment
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.05
float contra;

//!PARAMETER
//!LABEL [Color Tweaks] Gamma Correct Adjustment
//!DEFAULT 1
//!MIN 0.5
//!MAX 1.75
//!STEP 0.025
float pre_gc;

//!PARAMETER
//!LABEL [Color Tweaks] Sega Brightness Fix
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float sega_fix;

//!PARAMETER
//!LABEL [Color Tweaks] Sega MS Blue Lift
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float segams;

//!PARAMETER
//!LABEL [Color Tweaks] Sega MD Pallete Fix
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float segapal;

//!PARAMETER
//!LABEL [Color Tweaks] Lower Black Level
//!DEFAULT 0
//!MIN -100
//!MAX 0
//!STEP 1
float BP;

//!PARAMETER
//!LABEL [Color Tweaks] Raise Black Level
//!DEFAULT 0
//!MIN 0
//!MAX 25
//!STEP 1
float BP1;

//!PARAMETER
//!LABEL [Color Tweaks] Vignette Strength
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 0.05
float vigstr;

//!PARAMETER
//!LABEL [Color Tweaks] Vignette Size
//!DEFAULT 1
//!MIN 0.5
//!MAX 3
//!STEP 0.1
float vigdef;

//!PARAMETER
//!LABEL [Interlacing Options] Interlace Trigger Resolution
//!DEFAULT 375
//!MIN 0
//!MAX 800
//!STEP 25
float interr;

//!PARAMETER
//!LABEL [Interlacing Options] Interlace Mode: 0:OFF | 1-3,6:Normal | 4-5:Interpolation
//!DEFAULT 4
//!MIN 0
//!MAX 6
//!STEP 1
float interm;

//!PARAMETER
//!LABEL [Interlacing Options] Interlacing Scanline Effect ('Laced Brightness)
//!DEFAULT 0.2
//!MIN 0
//!MAX 1
//!STEP 0.05
float iscanb;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] Internal Resolution Y: 0.5...y-dowsample divider
//!DEFAULT 0
//!MIN 0
//!MAX 10
//!STEP 0.5
float intres;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] Downsampling-X (High-res content, pre-scalers)
//!DEFAULT 0
//!MIN 0
//!MAX 3
//!STEP 0.05
float downsample_levelx;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] Downsampling-Y (High-res content, pre-scalers)
//!DEFAULT 0
//!MIN 0
//!MAX 3
//!STEP 0.05
float downsample_levely;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] Interlacing (Scanline) Saturation
//!DEFAULT 0.25
//!MIN 0
//!MAX 1
//!STEP 0.05
float iscans;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] High Resolution Scanlines (prepend a scaler...)
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float hiscan;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] Horizontal Filtering Resolution
//!DEFAULT 1
//!MIN 0.5
//!MAX 8
//!STEP 0.05
float filter_res;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] Speedup w. higher Internal Res.
//!DEFAULT 1
//!MIN 1
//!MAX 4
//!STEP 1
float speedup;

//!PARAMETER
//!LABEL [Resolution/Scaling Options] SNES/Amiga Hi-Res Auto Mode
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float auto_res;

//!PARAMETER
//!LABEL [NTSC Settings] Hi-Res Sampling Behaviour: Default | Old
//!DEFAULT 1
//!MIN 1
//!MAX 2
//!STEP 1
float ntsc_samp;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Artifacting Value
//!DEFAULT 1
//!MIN 0
//!MAX 5
//!STEP 0.1
float cust_artifacting;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Fringing Value
//!DEFAULT 1
//!MIN 0
//!MAX 5
//!STEP 0.1
float cust_fringing;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Merge Fields: Auto | No | Yes
//!DEFAULT -1
//!MIN -1
//!MAX 1
//!STEP 1
float ntsc_fields;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Phase: Auto | 2 Phase | 3 Phase | Mixed | PCE
//!DEFAULT 1
//!MIN 1
//!MAX 5
//!STEP 1
float ntsc_phase;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Filter (Resolution) Scaling
//!DEFAULT 1.25
//!MIN 0.2
//!MAX 5
//!STEP 0.05
float nscale;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC De-dithering Booster: -0.01 : Auto | 0.0 : OFF
//!DEFAULT -0.01
//!MIN -0.01
//!MAX 2.5
//!STEP 0.01
float ntsc_dith;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Color Saturation
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.01
float ntsc_sat;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Brightness
//!DEFAULT 1
//!MIN 0
//!MAX 1.5
//!STEP 0.01
float ntsc_brt;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Filtering Gamma Correction
//!DEFAULT 1
//!MIN 0.25
//!MAX 2.5
//!STEP 0.025
float ntsc_gamma;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Coloring/Rainbow Effect (2-phase)
//!DEFAULT 0
//!MIN 0
//!MAX 3
//!STEP 1
float ntsc_rainbow;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC # of Taps (Filter Width)
//!DEFAULT 32
//!MIN 6
//!MAX 32
//!STEP 1
float ntsc_taps;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Preserve 'Edge' Colors (2-phase)
//!DEFAULT 0
//!MIN 0
//!MAX 10
//!STEP 0.5
float ntsc_charp1;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Preserve 'Edge' Colors (3-phase)
//!DEFAULT 0
//!MIN 0
//!MAX 10
//!STEP 0.5
float ntsc_charp2;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Chroma Scaling/Bleeding (2-phase)
//!DEFAULT 1
//!MIN 0.2
//!MAX 5
//!STEP 0.05
float ntsc_cscale1;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Chroma Scaling/Bleeding (3-phase)
//!DEFAULT 1
//!MIN 0.2
//!MAX 2.5
//!STEP 0.05
float ntsc_cscale2;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Anti-Ringing
//!DEFAULT 0.5
//!MIN 0
//!MAX 1
//!STEP 0.1
float ntsc_ring;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Sharpness (Adaptive)
//!DEFAULT 0
//!MIN -10
//!MAX 10
//!STEP 0.5
float ntsc_shrp;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Preserve Fonts (0.25 = OFF)
//!DEFAULT 0.25
//!MIN 0.25
//!MAX 0.75
//!STEP 0.05
float ntsc_fonts;

//!PARAMETER
//!LABEL [NTSC Settings] NTSC Sharpness Shape
//!DEFAULT 0.8
//!MIN 0.5
//!MAX 1
//!STEP 0.025
float ntsc_shpe;

//!PARAMETER
//!LABEL [RF Noise Options] NTSC RF Noise Frequency
//!DEFAULT 0.3
//!MIN 0
//!MAX 1
//!STEP 0.01
float RFNOISE;

//!PARAMETER
//!LABEL [RF Noise Options] NTSC RF Noise Luma+
//!DEFAULT 0
//!MIN 0
//!MAX 0.7
//!STEP 0.01
float RFNOISE1;

//!PARAMETER
//!LABEL [RF Noise Options] NTSC RF Noise Chroma+
//!DEFAULT 0
//!MIN 0
//!MAX 0.7
//!STEP 0.01
float RFNOISE2;

//!PARAMETER
//!LABEL [FSharpen] FSharpen - Sharpen Strength
//!DEFAULT 0
//!MIN 0
//!MAX 5
//!STEP 0.1
float CSHARPEN;

//!PARAMETER
//!LABEL [FSharpen] FSharpen - Sharpen (+ Deb) Contrast
//!DEFAULT 0.05
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float CCONTR;

//!PARAMETER
//!LABEL [FSharpen] FSharpen - Details sharpened
//!DEFAULT 1
//!MIN 0
//!MAX 1
//!STEP 0.05
float CDETAILS;

//!PARAMETER
//!LABEL [FSharpen] FSharpen - Deblur Strength
//!DEFAULT 1
//!MIN 1
//!MAX 8
//!STEP 0.25
float NDEBLUR;

//!PARAMETER
//!LABEL [FSharpen] FSharpen - Smart 'Dithering' Deblur
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float DSMART;

//!PARAMETER
//!LABEL [FSharpen] FSharpen - Deblur Edges Falloff
//!DEFAULT 0.9
//!MIN 0.7
//!MAX 1
//!STEP 0.01
float DREDGE;

//!PARAMETER
//!LABEL [FSharpen] FSharpen - Deblur Extra Sharpen
//!DEFAULT 0
//!MIN 0
//!MAX 4
//!STEP 0.2
float DSHARP;

//!PARAMETER
//!LABEL [Raster Bloom Options] Raster Bloom Effect Smoothing
//!DEFAULT 0.7
//!MIN 0.5
//!MAX 0.99
//!STEP 0.01
float lsmooth;

//!PARAMETER
//!LABEL [Raster Bloom Options] Raster Bloom Smoothing Bright Deviation
//!DEFAULT 0
//!MIN -0.25
//!MAX 0.25
//!STEP 0.01
float lsdev;

//!PARAMETER
//!LABEL [Raster Bloom Options] R. Bloom Overscan Mode
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 1
float OS;

//!PARAMETER
//!LABEL [Raster Bloom Options] Raster bloom %
//!DEFAULT 0
//!MIN 0
//!MAX 20
//!STEP 1
float blm_2;

//!PARAMETER
//!LABEL [Gamma Options] Gamma Input
//!DEFAULT 2
//!MIN 1
//!MAX 5
//!STEP 0.05
float gamma_i;

//!PARAMETER
//!LABEL [Gamma Options] Gamma out
//!DEFAULT 1.95
//!MIN 1
//!MAX 5
//!STEP 0.05
float gamma_o;

//!PARAMETER
//!LABEL [Filtering Options] Horizontal Filter Range
//!DEFAULT 1.6
//!MIN 1
//!MAX 8
//!STEP 0.05
float HSHARPNESS;

//!PARAMETER
//!LABEL [Filtering Options] Horizontal Blur Sigma
//!DEFAULT 0.5
//!MIN 0.15
//!MAX 1
//!STEP 0.01
float LIGMA_H;

//!PARAMETER
//!LABEL [Filtering Options] Substractive Sharpness
//!DEFAULT 1.1
//!MIN 0
//!MAX 3
//!STEP 0.05
float S_SHARP;

//!PARAMETER
//!LABEL [Filtering Options] Maximum Sharpness
//!DEFAULT 0.21
//!MIN 0
//!MAX 0.3
//!STEP 0.01
float MAXS;

//!PARAMETER
//!LABEL [Filtering Options] Substractive Sharpness Ringing
//!DEFAULT 0.3
//!MIN 0
//!MAX 4
//!STEP 0.05
float SSRNG;

//!PARAMETER
//!LABEL [Filtering Options] Scanline Spike Removal
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.1
float spike;

//!PARAMETER
//!LABEL [Magic Glow Settings] Ordinary Glow | Magic Glow
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 1
float m_glow;

//!PARAMETER
//!LABEL [Magic Glow Settings] Magic Glow Cutoff
//!DEFAULT 0.12
//!MIN 0
//!MAX 0.4
//!STEP 0.01
float m_glow_cutoff;

//!PARAMETER
//!LABEL [Magic Glow Settings] Magic Glow Low Strength
//!DEFAULT 0.35
//!MIN 0
//!MAX 7
//!STEP 0.05
float m_glow_low;

//!PARAMETER
//!LABEL [Magic Glow Settings] Magic Glow High Strength
//!DEFAULT 5
//!MIN 0
//!MAX 7
//!STEP 0.1
float m_glow_high;

//!PARAMETER
//!LABEL [Magic Glow Settings] Magic Glow Distribution
//!DEFAULT 1
//!MIN 0.2
//!MAX 4
//!STEP 0.05
float m_glow_dist;

//!PARAMETER
//!LABEL [Magic Glow Settings] Magic Glow Mask Strength
//!DEFAULT 1
//!MIN 0
//!MAX 2
//!STEP 0.025
float m_glow_mask;

//!PARAMETER
//!LABEL [Magic Glow Settings] Fine Glow/M.Glow Sampling
//!DEFAULT 1
//!MIN -1
//!MAX 5
//!STEP 1
float FINE_GAUSS;

//!PARAMETER
//!LABEL [Glow Pass Settings] Horizontal Glow Radius
//!DEFAULT 6
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEH;

//!PARAMETER
//!LABEL [Glow Pass Settings] Horizontal Glow Sigma
//!DEFAULT 1.2
//!MIN 0.2
//!MAX 3
//!STEP 0.01
float SIGMA_H;

//!PARAMETER
//!LABEL [Glow Pass Settings] Vertical Glow Radius
//!DEFAULT 6
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEV;

//!PARAMETER
//!LABEL [Glow Pass Settings] Vertical Glow Sigma
//!DEFAULT 1.2
//!MIN 0.2
//!MAX 3
//!STEP 0.01
float SIGMA_V;

//!PARAMETER
//!LABEL [Bloom/Halation (Glow) Pass Settings] Fine Bloom/Halation Sampling
//!DEFAULT 1
//!MIN -1
//!MAX 5
//!STEP 1
float FINE_BLOOM;

//!PARAMETER
//!LABEL [Bloom/Halation (Glow) Pass Settings] Horizontal Bloom/Halation Radius
//!DEFAULT 3
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEX;

//!PARAMETER
//!LABEL [Bloom/Halation (Glow) Pass Settings] Horizontal Bloom/Halation Sigma
//!DEFAULT 0.75
//!MIN 0.25
//!MAX 3
//!STEP 0.01
float SIGMA_X;

//!PARAMETER
//!LABEL [Bloom/Halation (Glow) Pass Settings] Vertical Bloom/Halation Radius
//!DEFAULT 3
//!MIN 1
//!MAX 50
//!STEP 1
float SIZEY;

//!PARAMETER
//!LABEL [Bloom/Halation (Glow) Pass Settings] Vertical Bloom/Halation Sigma
//!DEFAULT 0.6
//!MIN 0.25
//!MAX 2
//!STEP 0.01
float SIGMA_Y;

//!PARAMETER
//!LABEL [Brightness Settings] (Magic) Glow Strength
//!DEFAULT 0.08
//!MIN -2
//!MAX 2
//!STEP 0.01
float glow;

//!PARAMETER
//!LABEL [Brightness Settings] Bloom Strength
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.05
float blm_1;

//!PARAMETER
//!LABEL [Brightness Settings] Mask Bloom
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.05
float mask_bloom;

//!PARAMETER
//!LABEL [Brightness Settings] Bloom Distribution
//!DEFAULT 0
//!MIN -2
//!MAX 3
//!STEP 0.05
float bloom_dist;

//!PARAMETER
//!LABEL [Brightness Settings] Halation Strength
//!DEFAULT 0
//!MIN -2
//!MAX 2
//!STEP 0.025
float halation;

//!PARAMETER
//!LABEL [Brightness Settings] Bloom Mask Strength
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.025
float b_mask;

//!PARAMETER
//!LABEL [Brightness Settings] Halation Mask Strength
//!DEFAULT 0.35
//!MIN -1
//!MAX 1
//!STEP 0.025
float h_mask;

//!PARAMETER
//!LABEL [Brightness Settings] Gamma correct
//!DEFAULT 1
//!MIN 0.5
//!MAX 2
//!STEP 0.025
float gamma_c;

//!PARAMETER
//!LABEL [Brightness Settings] Complementary Gamma Correct
//!DEFAULT 1
//!MIN 1
//!MAX 2
//!STEP 0.025
float gamma_d;

//!PARAMETER
//!LABEL [Brightness Settings] Bright Boost Dark Pixels
//!DEFAULT 1.4
//!MIN 0.25
//!MAX 10
//!STEP 0.05
float brightboost1;

//!PARAMETER
//!LABEL [Brightness Settings] Bright Boost Bright Pixels
//!DEFAULT 1.1
//!MIN 0.25
//!MAX 3
//!STEP 0.025
float brightboost2;

//!PARAMETER
//!LABEL [Brightness Settings] Clip Saturated Color Beams
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.05
float clp;

//!PARAMETER
//!LABEL [Brightness Settings] Bloom Pixel Sampling
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 1
float bloomsamp;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Type
//!DEFAULT 0
//!MIN -1
//!MAX 2
//!STEP 1
float gsl;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Beam Shape Center
//!DEFAULT 6
//!MIN -20
//!MAX 40
//!STEP 0.5
float scanline1;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Beam Shape Edges
//!DEFAULT 8
//!MIN 0
//!MAX 70
//!STEP 1
float scanline2;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Shape Dark Pixels
//!DEFAULT 1.3
//!MIN 0.25
//!MAX 10
//!STEP 0.05
float beam_min;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Shape Bright Pixels
//!DEFAULT 1
//!MIN 0.2
//!MAX 3.5
//!STEP 0.025
float beam_max;

//!PARAMETER
//!LABEL [Scanline Options] Thinner Dark Scanlines
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float tds;

//!PARAMETER
//!LABEL [Scanline Options] Increased Bright Scanline Beam
//!DEFAULT 0.6
//!MIN 0
//!MAX 1
//!STEP 0.05
float beam_size;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Saturation / Mask Falloff
//!DEFAULT 0.5
//!MIN 0
//!MAX 6
//!STEP 0.1
float scans;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Falloff
//!DEFAULT 1
//!MIN 0.1
//!MAX 2
//!STEP 0.025
float scan_falloff;

//!PARAMETER
//!LABEL [Scanline Options] Smart Sharpen Scanlines
//!DEFAULT 0
//!MIN 0
//!MAX 0.5
//!STEP 0.01
float ssharp;

//!PARAMETER
//!LABEL [Scanline Options] Scanline Gamma
//!DEFAULT 2.4
//!MIN 0.5
//!MAX 5
//!STEP 0.05
float scangamma;

//!PARAMETER
//!LABEL [Scanline Options] Rolling Scanlines
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.01
float rolling_scan;

//!PARAMETER
//!LABEL [Scanline Options] No-scanline Mode
//!DEFAULT 0
//!MIN 0
//!MAX 1.5
//!STEP 0.05
float no_scanlines;

//!PARAMETER
//!LABEL [Screen Options] Integer Scaling: Odd:Y | Even:'X'+Y
//!DEFAULT 0
//!MIN 0
//!MAX 4
//!STEP 1
float IOS;

//!PARAMETER
//!LABEL [Screen Options] Curvature X (Default 0.03)
//!DEFAULT 0
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float warpx;

//!PARAMETER
//!LABEL [Screen Options] Curvature Y (Default 0.04)
//!DEFAULT 0
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float warpy;

//!PARAMETER
//!LABEL [Screen Options] Curvature Shape
//!DEFAULT 0.25
//!MIN 0.05
//!MAX 0.6
//!STEP 0.05
float c_shape;

//!PARAMETER
//!LABEL [Screen Options] Curvature 3D Effect
//!DEFAULT 0.25
//!MIN 0
//!MAX 1
//!STEP 0.05
float cbulge;

//!PARAMETER
//!LABEL [Screen Options] Overscan X original Pixels
//!DEFAULT 0
//!MIN -200
//!MAX 200
//!STEP 1
float overscanx;

//!PARAMETER
//!LABEL [Screen Options] Overscan Y original Pixels
//!DEFAULT 0
//!MIN -200
//!MAX 200
//!STEP 1
float overscany;

//!PARAMETER
//!LABEL [Screen Options] Vertical shift Y original pixels
//!DEFAULT 0
//!MIN -200
//!MAX 200
//!STEP 1
float VShift;

//!PARAMETER
//!LABEL [Screen Options] Corner Size
//!DEFAULT 0
//!MIN 0
//!MAX 0.35
//!STEP 0.01
float csize;

//!PARAMETER
//!LABEL [Screen Options] Border Size
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 0.01
float bsize;

//!PARAMETER
//!LABEL [Screen Options] Border Intensity
//!DEFAULT 0.75
//!MIN 0.25
//!MAX 2
//!STEP 0.05
float sborder;

//!PARAMETER
//!LABEL [Screen Options] Hum Bar Speed
//!DEFAULT 50
//!MIN 5
//!MAX 200
//!STEP 1
float barspeed;

//!PARAMETER
//!LABEL [Screen Options] Hum Bar Intensity
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.01
float barintensity;

//!PARAMETER
//!LABEL [Screen Options] Hum Bar Direction
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float bardir;

//!PARAMETER
//!LABEL [CRT Mask Options] CRT Mask: 0:CGWG | 1-4:Lottes | 5-14:'Trinitron'
//!DEFAULT 0
//!MIN -1
//!MAX 14
//!STEP 1
float shadow_msk;

//!PARAMETER
//!LABEL [CRT Mask Options] Mask Strength (0, 5-14)
//!DEFAULT 0.3
//!MIN -0.5
//!MAX 1
//!STEP 0.025
float maskstr;

//!PARAMETER
//!LABEL [CRT Mask Options] Mask 5-14 Low Strength
//!DEFAULT 1.1
//!MIN 0
//!MAX 2
//!STEP 0.05
float mcut;

//!PARAMETER
//!LABEL [CRT Mask Options] CRT Mask Boost
//!DEFAULT 1
//!MIN 1
//!MAX 3
//!STEP 0.05
float maskboost;

//!PARAMETER
//!LABEL [CRT Mask Options] CRT Mask Size
//!DEFAULT 1
//!MIN 1
//!MAX 4
//!STEP 1
float masksize;

//!PARAMETER
//!LABEL [CRT Mask Options] CRT Mask Zoom (+ mask width)
//!DEFAULT 0
//!MIN -10
//!MAX 6
//!STEP 1
float mask_zoom;

//!PARAMETER
//!LABEL [CRT Mask Options] CRT Mask Zoom Sharpen (needs Mask Zoom)
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float zoom_mask;

//!PARAMETER
//!LABEL [CRT Mask Options] (Transform to) Shadow Mask
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.5
float mshift;

//!PARAMETER
//!LABEL [CRT Mask Options] Mask Layout Sequence: RGB or BGR (check LCD panel)
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float mask_layout;

//!PARAMETER
//!LABEL [CRT Mask Options] Mask Layout Shift: GBR, RGB, BRG | GRB, RBG, BGR
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 1
float laysh;

//!PARAMETER
//!LABEL [CRT Mask Options] Lottes maskDark
//!DEFAULT 0.5
//!MIN 0
//!MAX 2
//!STEP 0.05
float mask_drk;

//!PARAMETER
//!LABEL [CRT Mask Options] Lottes maskBright
//!DEFAULT 1.5
//!MIN 0
//!MAX 2
//!STEP 0.05
float mask_lgt;

//!PARAMETER
//!LABEL [CRT Mask Options] Mask gamma
//!DEFAULT 2.4
//!MIN 1
//!MAX 5
//!STEP 0.05
float mask_gamma;

//!PARAMETER
//!LABEL [CRT Mask Options] Slot Mask Strength Bright Pixels
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float slotmask1;

//!PARAMETER
//!LABEL [CRT Mask Options] Slot Mask Strength Dark Pixels
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float slotmask2;

//!PARAMETER
//!LABEL [CRT Mask Options] Slot Mask Width (0:Auto)
//!DEFAULT 0
//!MIN 0
//!MAX 16
//!STEP 1
float slotwidth;

//!PARAMETER
//!LABEL [CRT Mask Options] Slot Mask Height: 2x1 or 4x1...
//!DEFAULT 2
//!MIN 1
//!MAX 4
//!STEP 1
float double_slot;

//!PARAMETER
//!LABEL [CRT Mask Options] Slot Mask Thickness
//!DEFAULT 1
//!MIN 1
//!MAX 4
//!STEP 1
float slotms;

//!PARAMETER
//!LABEL [CRT Mask Options] Smooth Masks in bright scanlines
//!DEFAULT 0
//!MIN 0
//!MAX 2
//!STEP 0.25
float smoothmask;

//!PARAMETER
//!LABEL [CRT Mask Options] Mitigate Slot Mask Interaction
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.05
float smask_mit;

//!PARAMETER
//!LABEL [CRT Mask Options] Base (black) Mask Strength
//!DEFAULT 0
//!MIN 0
//!MAX 0.25
//!STEP 0.01
float bmask;

//!PARAMETER
//!LABEL [CRT Mask Options] Preserve Mask Strength
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.025
float mclip;

//!PARAMETER
//!LABEL [CRT Mask Options] Preserve Scanline Properties
//!DEFAULT 0.1
//!MIN 0
//!MAX 1
//!STEP 0.025
float pr_scan;

//!PARAMETER
//!LABEL [CRT Mask Options] Mitigate Mask on Edges
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 0.1
float edgemask;

//!PARAMETER
//!LABEL [Deconvergence Options] Deconvergence Type X: 0:static | Other:dynamic
//!DEFAULT 0
//!MIN 0
//!MAX 0.75
//!STEP 0.05
float dctypex;

//!PARAMETER
//!LABEL [Deconvergence Options] Deconvergence Type Y: 0:Static | Other:Dynamic
//!DEFAULT 0
//!MIN 0
//!MAX 0.75
//!STEP 0.05
float dctypey;

//!PARAMETER
//!LABEL [Deconvergence Options] Horizontal Deconvergence Red Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconrx;

//!PARAMETER
//!LABEL [Deconvergence Options] Horizontal Deconvergence Green Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float decongx;

//!PARAMETER
//!LABEL [Deconvergence Options] Horizontal Deconvergence Blue Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconbx;

//!PARAMETER
//!LABEL [Deconvergence Options] Vertical Deconvergence Red Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconry;

//!PARAMETER
//!LABEL [Deconvergence Options] Vertical Deconvergence Green Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float decongy;

//!PARAMETER
//!LABEL [Deconvergence Options] Vertical Deconvergence Blue Range
//!DEFAULT 0
//!MIN -15
//!MAX 15
//!STEP 0.25
float deconby;

//!PARAMETER
//!LABEL [Deconvergence Options] Deconvergence Strength
//!DEFAULT 1
//!MIN 0
//!MAX 3
//!STEP 0.1
float decons;

//!PARAMETER
//!LABEL [Noise Options] Add Noise
//!DEFAULT 0
//!MIN -1
//!MAX 1
//!STEP 0.02
float addnoised;

//!PARAMETER
//!LABEL [Noise Options] Noise Resolution
//!DEFAULT 2
//!MIN 1
//!MAX 10
//!STEP 1
float noiseresd;

//!PARAMETER
//!LABEL [Noise Options] Noise Type: Colored | Luma
//!DEFAULT 0
//!MIN 0
//!MAX 1
//!STEP 1
float noisetype;

//!PARAMETER
//!LABEL [Post Effects] Post Brightness
//!DEFAULT 1
//!MIN 0.25
//!MAX 5
//!STEP 0.01
float post_br;

//!PARAMETER
//!LABEL [Post Effects] Show Original Image
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
Texture2D T01;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T01H;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T02;

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
Texture2D T05;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T06;

//!TEXTURE
//!WIDTH INPUT_WIDTH * 2
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T08;

//!TEXTURE
//!WIDTH OUTPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T09;

//!TEXTURE
//!WIDTH 800
//!HEIGHT INPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T10;

//!TEXTURE
//!WIDTH 800
//!HEIGHT 600
//!FORMAT R16G16B16A16_FLOAT
Texture2D T11;

//!TEXTURE
//!WIDTH 800
//!HEIGHT 600
//!FORMAT R16G16B16A16_FLOAT
Texture2D T12;

//!TEXTURE
//!WIDTH 800
//!HEIGHT 600
//!FORMAT R16G16B16A16_FLOAT
Texture2D T13;

//!TEXTURE
//!WIDTH OUTPUT_WIDTH
//!HEIGHT OUTPUT_HEIGHT
//!FORMAT R16G16B16A16_FLOAT
Texture2D T14;

//!TEXTURE
//!WIDTH 64
//!HEIGHT 32
//!FORMAT R32G32B32A32_FLOAT
Texture2D RB1;

//!TEXTURE
//!WIDTH 5
//!HEIGHT 1
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
// ---- constants that mirror the ReShade preprocessor defines ------------------------------
// NOTE: the texture sizes above are written as literals (MagpieFX cannot read #defines there).
//       If you change these, regenerate the file with reshade_to_magpiefx.py --res WxH.
// native resolution = size of INPUT (run the game window at 1x, no scaling)

#define TexSize float2(GetInputSize())
#define IptSize float2(800.0,600.0)
#define OrgSize float4(TexSize,1.0/TexSize)
#define SrcSize float4(IptSize,1.0/IptSize)
// the CRT is drawn at the full OUTPUT size (Magpie already letter-boxes the picture)
#define NewSize float4(float2(GetOutputSize()),GetOutputPt())
#define fuxcoord (texcoord*1.00001)
#define eps 1e-8
#define wts float((bloomsamp < 0.5) ? -10.0 : -12.5)
#define pii 3.14159265
#define fracoord (fuxcoord*NewSize.xy)
#define LumSize float4(2.0*TexSize.x,1.0*TexSize.y,1.0/(2.0*TexSize.x),1.0/(1.0*TexSize.y))
#define rgb_m float3x3(0.2989,0.5870,0.1140,0.5959,-0.2744,-0.3216,0.2115,-0.5229,0.3114)
#define yiq_m float3x3(1.0000,0.9560,0.6210,1.0000,-0.2720,-0.6474,1.0000,-1.1060,1.7046)
#define fetch_offset(dx) float3(T03.SampleLevel(sPt,tex_c+dx.xz,0).x+T03.SampleLevel(sPt,tex_c-dx.xz,0).x,T03.SampleLevel(sPt,tex_c+dx.yz,0).yz+T03.SampleLevel(sPt,tex_c-dx.yz,0).yz)
// Magpie's internal frame counter (needs //!USE _DYNAMIC); counts rendered frames
#define framecount int(__frameCount)

float3 fix_lut(float3 lut,float3 ref)
{
	float r=length(ref);
	float l=length(lut);
	float m=max(max(ref.r,ref.g),ref.b);
	ref=normalize(lut+0.0000001)*lerp(r,l,pow(m,1.25));
	return lerp(lut,ref,LUTBR);
}

float vignette(float2 pos)
{
	float b = vigdef * 0.125;
	pos = abs(2.0*(pos - 0.5)); pos*=pos*pos;
	float dist = pow(dot(pos,pos),0.05);
	float res = lerp(0.0, 1.0, smoothstep(1.0, 1.0-b, dist));
	return max(lerp(1.0, res, vigstr), 0.0);
}

float contrast(float x)
{
	return max(lerp(x,smoothstep(0,1.0,x),contra),0.0);
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

float dist(float3 A,float3 B)
{
	float r=0.5*(A.r+B.r);
	float3 d=A-B;
	float3 c=float3(2.+r,4.,3.-r);
	return sqrt(dot(c*d,d))/3.;
}

float3 plant(float3 tar,float r)
{
	float t=max(max(tar.r,tar.g),tar.b)+0.00001;
	return tar*r/t;
}



float gauss_h(float x)
{
	float sigma=1.0/(2.0*SIGMA_H*SIGMA_H);
	return exp(-x*x*sigma);
}

float gauss_v(float x)
{
	float sigma=1.0/(2.0*SIGMA_V*SIGMA_V);
	return exp(-x*x*sigma);
}

float bloom_h(float x)
{
	float SIGMA_X2 = SIGMA_X * SIZEX / 3.0;
	float sigma=1.0/(2.0*SIGMA_X2*SIGMA_X2);
	return exp(-x*x*sigma);
}

float bloom_v(float x)
{
	float SIGMA_Y2 = SIGMA_Y * SIZEY / 3.0;
	float sigma=1.0/(2.0*SIGMA_Y2*SIGMA_Y2);
	return exp(-x*x*sigma);
}

float crthd_h(float x,float y)
{
	return exp(-x*x*y);
}

float mod(float x,float y)
{
	return x-y* floor(x/y);
}

float st0(float x)
{
	return exp2(wts*x*x);
}

float3 sw0(float x,float color,float scanline,float3 c)
{
	float3 xe=lerp(1.0.xxx+1.5*scans,1.0.xxx,c);
	float tmp=lerp(beam_min,beam_max,color);
	float ex=x*tmp;
	ex=(gsl>-0.5)?ex*ex:lerp(ex*ex,ex*ex*ex,0.4);
	return exp2(-scanline*ex*xe);
}

float3 sw1(float x,float color,float scanline,float3 c)
{
	float3 xe=lerp(1.0.xxx+1.5*scans,1.0.xxx,c);
	x=lerp(x,beam_min*x,max(x-0.4*color,0.0));
	float tmp=lerp(1.2*beam_min,beam_max,color);
	float ex=x*tmp;
	return exp2(-scanline*ex*ex*xe);
}

float3 sw2(float x,float color,float scanline,float3 c)
{
	float3 xe=lerp(1.0.xxx+1.5*scans,1.0.xxx,c);
	float tmp=lerp((2.5-0.5*color)*beam_min,beam_max,color);
	tmp=lerp(beam_max,tmp,pow(x,color+0.3));
	float ex=x*tmp;
	return exp2(-scanline*ex*ex*xe);
}

float2 overscan(float2 pos,float dx,float dy)
{
	pos=pos*2.0-1.0;
	pos*=float2(dx,dy);
	return pos*0.5+0.5;
}

float2 warp(float2 pos)
{
	pos=pos*2.0-1.0;
	pos=lerp(pos,sign(pos)*pow(abs(pos),1.0+min(15.0*float2(warpy,warpx)*cbulge.xx,cbulge.xx)),0.075+0.125*(abs(pos)+pos*pos));
	pos=lerp(pos,float2(pos.x*rsqrt(1.0-c_shape*pos.y*pos.y),pos.y*rsqrt(1.0-c_shape*pos.x*pos.x)),float2(warpx,warpy)/c_shape);
	return pos*0.5+0.5;
}

float3 gc1(float3 c)
{
	float mc=max(max(c.r,c.g),c.b);
	float mg=pow(mc,1.0/gamma_c);
	return c*mg/(mc+eps);
}

float3 rgb2yiq(float3 r)
{
	return mul(rgb_m, r);
}

float3 yiq2rgb(float3 y)
{
	return mul(yiq_m, y);
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

float3 crt_mask(float2 pos,float mx,float mb)
{
	float3 mask=mask_drk;
	float3 one=1.0;
	if(shadow_msk== 0.0)
	{
	float mc=1.0-max(maskstr,0.0);
	pos.x=frac(pos.x*0.5);
	if(pos.x<0.49)
	{
	mask.r=1.0;mask.g= mc;mask.b=1.0;
	}else
	{
	mask.r= mc;mask.g=1.0;mask.b= mc;
	}
	}else
	if(shadow_msk== 1.0)
	{
	float lane=mask_lgt;
	float odd=0.0;
	if(frac(pos.x/6.0)<0.49)odd=1.0;
	if(frac((pos.y+odd)/2.0)<0.49)lane=mask_drk;
	pos.x=floor(mod(pos.x,3.0));
	if(pos.x<0.5)mask.r=mask_lgt;else
	if(pos.x<1.5)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	mask*=lane;
	}else
	if(shadow_msk== 2.0)
	{
	pos.x=floor(mod(pos.x,3.0));
	if(pos.x<0.5)mask.r=mask_lgt;else
	if(pos.x<1.5)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	}else
	if(shadow_msk== 3.0)
	{
	pos.x+=pos.y*3.0;
	pos.x=frac(pos.x/6.0);
	if(pos.x<0.3)mask.r=mask_lgt;else
	if(pos.x<0.6)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	}else
	if(shadow_msk== 4.0)
	{
	pos.xy=floor(pos.xy*float2(1.0,0.5));
	pos.x+=pos.y*3.0;
	pos.x=frac(pos.x/6.0);
	if(pos.x<0.3)mask.r=mask_lgt;else
	if(pos.x<0.6)mask.g=mask_lgt;else
	mask.b= mask_lgt;
	}else
	if(shadow_msk== 5.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/2.0);
	if(pos.x<0.49)
	{
	mask.r=1.0;
	mask.b=1.0;
	}else
	mask.g=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk== 6.0)
	{
	mask=0.0;
	pos.x=floor(mod(pos.x,3.0));
	if(pos.x<0.5)mask.r=1.0;else
	if(pos.x<1.5)mask.g=1.0;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk== 7.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/2.0);
	if(pos.x<0.49)
	{
	mask=0.0.xxx;
	}else
	mask=1.0.xxx;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk== 8.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/3.0);
	if(pos.x<0.3)mask=0.0.xxx;else
	if(pos.x<0.6)mask=1.0.xxx;else
	mask=1.0.xxx;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk== 9.0)
	{
	mask=0.0;
	pos.x=frac(pos.x/3.0);
	if(pos.x<0.3)mask   =0.0.xxx;else
	if(pos.x<0.6)mask.rb=1.0.xx ;else
	mask.g=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==10.0)
	{
	mask=0.0;
	pos.x=frac(pos.x*0.25);
	if(pos.x<0.2)mask  =0.0.xxx;else
	if(pos.x<0.4)mask.r=1.0    ;else
	if(pos.x<0.7)mask.g=1.0    ;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==11.0)
	{
	mask=0.0;
	pos.x=frac(pos.x*0.25);
	if(pos.x<0.2)mask.r =1.0   ;else
	if(pos.x<0.4)mask.rg=1.0.xx;else
	if(pos.x<0.7)mask.gb=1.0.xx;else
	mask.b=1.0;mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==12.0)
	{
	mask=0.0;
	pos.x=floor(mod(pos.x,7.0));
	if(pos.x<0.5)mask  =0.0.xxx;else
	if(pos.x<2.5)mask.r=1.0    ;else
	if(pos.x<4.5)mask.g=1.0    ;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	if(shadow_msk==13.0)
	{
	mask=0.0;
	pos.x=floor(mod(pos.x,6.0));
	if(pos.x<0.5)mask    =0.0.xxx;else
	if(pos.x<1.5)mask.r  =1.0    ;else
	if(pos.x<2.5)mask.rg =1.0.xx ;else
	if(pos.x<3.5)mask.rgb=1.0.xxx;else
	if(pos.x<4.5)mask.gb =1.0.xx ;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}else
	{
	mask=0.0;
	pos.x=floor(mod(pos.x,5.0));
	if(pos.x<0.5)mask    =0.0.xxx;else
	if(pos.x<1.5)mask.r  =1.0    ;else
	if(pos.x<2.5)mask.rg =1.0.xx ;else
	if(pos.x<3.5)mask.gb =1.0.xx ;else
	mask.b=1.0;
	mask=clamp(lerp(lerp(one,mask,mcut),lerp(one,mask,maskstr),mx),0.0,1.0);
	}
	if(mask_layout>0.5)mask=mask.rbg;
	float maskmin=min(min(mask.r,mask.g),mask.b);
	return (mask-maskmin)*(1.0+(maskboost-1.0)*mb)+maskmin;
}

float slt_mask(float2 pos,float m,float swidth)
{
	if  ((slotmask1+slotmask2)==0.0)return 1.0;else
	{
	pos.y=floor(pos.y/slotms);
	float mlen=swidth*2.0;
	float px=floor( mod(pos.x, 0.99999*mlen));
	float py=floor(frac(pos.y/(2.0*double_slot))*2.0*double_slot);
	float slot_dark=lerp(1.0-slotmask2,1.0-slotmask1,m);
	float slot=1.0;
	if(py==0.0&&px<swidth) slot=slot_dark;else
	if(py==double_slot&&px>=swidth) slot=slot_dark;
	return slot;
	}
}





float3 declip(float3 c,float b)
{
	float m=max(max(c.r,c.g),c.b);
	if(m>b)c=c*b/m;
	return c;
}

float igc(float mc)
{
	return pow(mc,gamma_c);
}

float3 gc2(float3 c,float w3)
{
	float mc=max(max(c.r,c.g),c.b);
	float p=1.0/(1.0+(gamma_d-1.0)* lerp(0.375,1.0,w3));
	float mg=pow(mc, p );
	return c*mg/(mc+eps);
}

float3 jnoise(float3 v)
{
	if(addnoised<0.0)v.z=-addnoised;else v.z= mod(v.z,6001.0)/1753.0;
	v =frac(v)+frac(v*1e4)+frac(v*1e-4);
	v+=float3(0.12345,0.6789,0.314159);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	v =frac(v*dot(v,v)*123.456);
	return v;
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



float3 scale_to_range(float3 x, float dmin, float dmax)
{
    return ( (dmax - dmin) * x ) + dmin; //Scales 0..1 range to a..b range
}


//!PASS 1
//!DESC Afterglow
//!STYLE PS
//!IN INPUT, T01H
//!OUT T01

float4 Pass1(float2 texcoord)
{
	float2 dx=float2(OrgSize.z,0.0);
	float2 dy=float2(0.0,OrgSize.w);
	float w=1.0;
	float3 color0=INPUT.SampleLevel(sPt,texcoord   ,0).rgb;
	float3 color1=INPUT.SampleLevel(sPt,texcoord-dx,0).rgb;
	float3 color2=INPUT.SampleLevel(sPt,texcoord+dx,0).rgb;
	float3 color3=INPUT.SampleLevel(sPt,texcoord-dy,0).rgb;
	float3 color4=INPUT.SampleLevel(sPt,texcoord+dy,0).rgb;
	float3 cr=(2.5*color0+color1+color2+color3+color4)/6.5;
	float3 a=T01H.SampleLevel(sLin,texcoord,0).rgb;
	float b = bth/255.0;
	float c = max(max(color0.r,color0.g),color0.b);
	w = smoothstep(b, 2.0*b, c);
	float3 result=lerp(max(lerp(cr,a,0.49+float3(PR,PG,PB))-0.5/255.0,0.0),cr,w);
	return float4(result,w);
}

//!PASS 2
//!DESC Afterglow history
//!STYLE PS
//!IN T01
//!OUT T01H

float4 Pass2(float2 texcoord)
{
	return T01.SampleLevel(sPt,texcoord,0);
}

//!PASS 3
//!DESC PreShader (color / LUT / afterglow mix)
//!STYLE PS
//!IN INPUT, T01, LUT1, LUT2, LUT3, LUT4
//!OUT T02

float4 Pass3(float2 texcoord)
{
	const float3x3 File0=float3x3(0.412391, 0.212639,0.019331, 0.357584,0.715169, 0.119195, 0.180481,0.072192,0.950532);
	const float3x3 File1=float3x3(0.430554, 0.222004,0.020182, 0.341550,0.706655, 0.129553, 0.178352,0.071341,0.939322);
	const float3x3 File2=float3x3(0.396686, 0.210299,0.006131, 0.372504,0.713766, 0.115356, 0.181266,0.075936,0.967571);
	const float3x3 File3=float3x3(0.393521, 0.212376,0.018739, 0.365258,0.701060, 0.111934, 0.191677,0.086564,0.958385);
	const float3x3 File4=float3x3(0.392258, 0.209410,0.016061, 0.351135,0.725680, 0.093636, 0.166603,0.064910,0.850324);
	const float3x3 File5=float3x3(0.377923, 0.195679,0.010514, 0.317366,0.722319, 0.097826, 0.207738,0.082002,1.076960);
	const float3x3 ToRGB=float3x3(3.240970,-0.969244,0.055630,-1.537383,1.875968,-0.203977,-0.498611,0.041555,1.056972);
	const float3x3 ToMDN=float3x3(2.791723,-0.894766,0.041678,-1.173165,1.815586,-0.130886,-0.440973,0.032000,1.002034);
	const float3x3 ToDCI=float3x3(2.973422,-0.867605,0.045031,-1.110433,1.843757,-0.095697,-0.480247,0.024743,1.201215);
	const float3x3 ToADB=float3x3(2.041588,-0.969244,0.013444,-0.565007,1.875968,-0.118360,-0.344731,0.041555,1.015175);
	const float3x3 ToREC=float3x3(1.716651,-0.666684,0.017640,-0.355671,1.616481,-0.042771,-0.253366,0.015769,0.942103);
	const float3x3 ToP3=float3x3(2.493509,-0.829473,0.0358512,-0.931388,1.762630,-0.0761839,-0.402712,0.023624,0.9570296);
	const float3x3 D65_to_D55=float3x3(0.4850339153,0.2500956126,0.0227359648,0.3488957224,0.6977914447,0.1162985741,0.1302823568,0.0521129427,0.6861537456);
	const float3x3 D65_to_D93=float3x3(0.3412754080,0.1759701322,0.0159972847,0.3646170520,0.7292341040,0.1215390173,0.2369894093,0.0947957637,1.2481442225);
	float4 imgColor=INPUT.SampleLevel(sPt,texcoord,0);
	float4 aftrglow=T01.SampleLevel(sLin,texcoord,0);
	float w=1.0-aftrglow.w;
	float l=length(aftrglow.rgb);
	aftrglow.rgb=AS*w*normalize(pow(aftrglow.rgb+0.01,ST))*l;
	float bp=w*BP1/255.0;
	if(sega_fix>0.5) imgColor.rgb=imgColor.rgb*(255.0/239.0);
	if(segams>0.5) { imgColor.b=(abs(imgColor.b - 0.375) < 0.125) ? 0.4078431372549019607843137254902 : imgColor.b; }
	imgColor.rgb=min(imgColor.rgb,1.0);
	if (segapal > 0.5) {
	imgColor.r = contrast_sigmoid_inv(imgColor.r,2.578419881,0.520674); 
	imgColor.g = contrast_sigmoid_inv(imgColor.g,2.578419881,0.520674); 
	imgColor.b = contrast_sigmoid_inv(imgColor.b,2.578419881,0.520674); }
   
	imgColor.rgb = min(imgColor.rgb, 1.0);
	float3 color=imgColor.rgb;
	if(int(TNTC)==0) {color.rgb=imgColor.rgb;}else
	{
	float lutlow=LUTLOW/255.0;float invs=1.0/LS;
	float3 lut_ref=imgColor.rgb+lutlow*(1.0-pow(imgColor.rgb,0.333.xxx));
	float lutb=lut_ref.b*(1.0-0.5*invs);
	lut_ref.rg=lut_ref.rg*(1.0-invs)+0.5*invs;
	float tile1=ceil(lutb*(LS-1.0));
	float tile0=max(tile1-1.0,0.0);
	float f=frac(lutb*(LS-1.0));if(f==0.0)f=1.0;
	float2 coord1=float2(tile0+lut_ref.r,lut_ref.g)*float2(invs,1.0);
	float2 coord2=float2(tile1+lut_ref.r,lut_ref.g)*float2(invs,1.0);
	float4 color1,color2,res;
	if(int(TNTC)==1)
	{
	color1=LUT1.SampleLevel(sLin,coord1,0);
	color2=LUT1.SampleLevel(sLin,coord2,0);
	res=lerp(color1,color2,f);
	}else
	if(int(TNTC)==2)
	{
	color1=LUT2.SampleLevel(sLin,coord1,0);
	color2=LUT2.SampleLevel(sLin,coord2,0);
	res=lerp(color1,color2,f);
	}else
	if(int(TNTC)==3)
	{
	color1=LUT3.SampleLevel(sLin,coord1,0);
	color2=LUT3.SampleLevel(sLin,coord2,0);
	res=lerp(color1,color2,f);
	}else
	if(int(TNTC)==4)
	{
	color1=LUT4.SampleLevel(sLin,coord1,0);
	color2=LUT4.SampleLevel(sLin,coord2,0);
	res=lerp(color1,color2,f);
	}
	res.rgb=fix_lut(res.rgb,imgColor.rgb);
	color=lerp(imgColor.rgb,res.rgb,min(TNTC,1.0));
	}
	float3 c=clamp(color,0.0,1.0);
	float3x3 m_o;
	float p;
	if(CS==0.0){p=2.2;m_o=ToRGB;}else
	if(CS==1.0){p=2.2;m_o=ToMDN;}else
	if(CS==2.0){p=2.6;m_o=ToDCI;}else
	if(CS==3.0){p=2.2;m_o=ToADB;}else
	if(CS==4.0){p=2.4;m_o=ToREC;}
	if(CS==5.0){p=2.2;m_o=ToP3; }
	color=pow(c,p);
	float3x3 m_i;
	if(CP==0.0){m_i=File0;}else
	if(CP==1.0){m_i=File1;}else
	if(CP==2.0){m_i=File2;}else
	if(CP==3.0){m_i=File3;}else
	if(CP==4.0){m_i=File4;}else
	if(CP==5.0){m_i=File5;}
	color=mul(color,m_i);
	color=mul(color,m_o);
	color=clamp(color,0.0,1.0);
	color=pow(color,1.0/p);
	if(CP==-1.0)color=c;
	float3 solor1=plant(pow(color,wp_saturation),max(max(color.r,color.g),color.b));
	float luma=dot(color,float3(0.299,0.587,0.114));
	float3 solor2=lerp(luma,color,wp_saturation);
	color=(wp_saturation>1.0)?solor1:solor2;
	color=plant(color,contrast(max(max(color.r,color.g),color.b)));
	p=2.2;
	color=clamp(color,0.0,1.0);
	color=pow(color,p);
	float3 warmer=mul(color,D65_to_D55);
	warmer=mul(warmer,ToRGB);
	float3 cooler=mul(color,D65_to_D93);
	cooler=mul(cooler,ToRGB);
	float m=abs(WP)/100.0;
	float3 comp=(WP<0.0)?cooler:warmer;
	color=lerp(color,comp,m);
	color=pow(max(color,0.0),1.0/p);
	color=pgc(color);
	float bp1 = min(BP, 0.0);
	color = max(color + bp1/255.0, 0.0) / (1.0 + bp1/255.0*step(-bp1/255.0, max(max(color.r,color.g),color.b)));
	color = color + aftrglow.rgb + bp;
	color=min(color*pre_bb,1.0);
	return float4(color,vignette(texcoord));
}

//!PASS 4
//!DESC Interlace
//!STYLE PS
//!IN T02
//!OUT T0I

float4 Pass4(float2 texcoord)
{
    float3 c1=T02.SampleLevel(sLin,fuxcoord,0).rgb;
    float3 c2=T02.SampleLevel(sLin,fuxcoord+float2(0.0,OrgSize.w),0).rgb;
    float3 c=c1;
    float intera=1.0;
    float m1=max(max(c1.r,c1.g),c1.b);
    float m2=max(max(c2.r,c2.g),c2.b);
    float3 df=abs(c1-c2);
    float d=max(max(df.r,df.g),df.b);
    if(interm==2.0) d=lerp(0.1*d,10.0*d,step(m1/(m2+0.0001),m2/(m1+0.0001)));
    float r=m1;
    float yres_div=1.0;if(intres>1.25)yres_div=intres;
    bool hscans=(hiscan>0.5);
    if(interr<=OrgSize.y/yres_div&&interm>0.5&&intres!=1.0&&intres!=0.5||hscans)
    {
    intera=0.25;
    float liine_no=floor( mod(OrgSize.y*fuxcoord.y,2.0));
    float frame_no=floor( mod(float(framecount),2.0));
    float ii=abs(liine_no-frame_no);
    if(interm< 3.5 || interm > 5.5)
    {
    if (interm == 6.0) c = lerp(c2, c1, ii); else
    {
    c2=plant(lerp(c2,c2*c2,iscans),max(max(c2.r,c2.g),c2.b));
    r=max(m1*ii,(1.0-iscanb)*min(m1,m2));
    c=plant(lerp(lerp(c1,c2,min(lerp(m1,1.0-m2,min(m1,1.0-m1))/(d+0.00001),1.0)),c1,ii),r);
    if(interm==3.0) c=(1.0-0.5*iscanb)*lerp(c2,c1,ii);
    }
    }
    if(interm==4.0){c=plant(lerp(c,c*c,0.5*iscans),max(max(c.r,c.g),c.b))*(1.0-0.5*iscanb);
    }
    if(interm==5.0){c=lerp(c2,c1,0.5);c=plant(lerp(c,c*c,0.5*iscans),max(max(c.r,c.g),c.b))*(1.0-0.5*iscanb);
    }
    if(hscans)c=c1;
    }
    return float4(c,intera);
}

//!PASS 5
//!DESC NTSC pass 1 (modulation)
//!STYLE PS
//!IN T0I
//!OUT T03

float4 Pass5(float2 texcoord)
{
	float2 vtexcoord=texcoord*float2(speedup, 1.0);
	float NOrgSize = (OrgSize.x < 450.0) ? OrgSize.x : OrgSize.x / max(round(OrgSize.x / 300.0), 1.0);
	float phase = (ntsc_phase < 1.5) ? ((NOrgSize > 300.0 || (OrgSize.x > 400.0 && OrgSize.y > 250.0)) ? 2.0 : 3.0) : ((ntsc_phase > 2.5) ? 3.0 : 2.0);
	if(ntsc_phase==4.0)phase=3.0; else if (ntsc_phase == 5.0) phase = 2.0;
	float ntsc_sizex = (OrgSize.x < 400.0) ? OrgSize.x : (phase == 2.0) ? 320.0 : 256.0;
	ntsc_sizex = (ntsc_samp < 1.5) ? ntsc_sizex : OrgSize.x;
	float ntsc_sizey = OrgSize.y / max(round(OrgSize.y / 220.0), 1.0);
	float2 pix_no = vtexcoord * float2(ntsc_sizex,ntsc_sizey) * float2(4.0, 1.0);
	pix_no.y = round(pix_no.y);
	float CHROMA_MOD_FREQ=(phase == 2.0 && ntsc_phase != 5.0) ? (4.0 * pii / 15.0) : ((NOrgSize <= 300.0 || phase == 3.0) ? (pii / 3.0) : (pii/2.0));
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
	float3 col0=T0I.SampleLevel(sLin, vtexcoord,0).rgb;
	float3 yiq1=rgb2yiq(col0);
	yiq1.x=pow(yiq1.x,ntsc_gamma);
	float lum=yiq1.x;
	float3 temp=yiq1;
	float3 yiq2=yiq1;
	float3 yiqs=yiq1;
	float3 yiqz=yiq1;

	float res = nscale;

	if (abs(ntsc_dith) > 0.005 && OrgSize.y < 300.0 && (phase == 2.0 || ntsc_phase > 3.5))
	{
	float2 TexD = (floor(vtexcoord * OrgSize.xy) + 0.5)*OrgSize.zw;
	float2 xx = float2(OrgSize.z, 0.0);

	float ca = get_luma(T0I.SampleLevel(sLin, TexD - xx - xx,0).rgb);
	float c0 = get_luma(T0I.SampleLevel(sLin, TexD - xx,0).rgb);
	float c1 = get_luma(T0I.SampleLevel(sLin, TexD     ,0).rgb);
	float c2 = get_luma(T0I.SampleLevel(sLin, TexD + xx,0).rgb);
	float cb = get_luma(T0I.SampleLevel(sLin, TexD + xx + xx,0).rgb);

	float line0  = swoothstep(0.01, 0.0, min(abs(c1-c0),abs(c2-c1)));
	float line1  = max(swoothstep(0.01, 0.0, min(abs(ca-c0),abs(c2-cb))), line0);
	float line2  = max(swoothstep(0.20, 0.0, max(abs(ca-c0),abs(c2-cb))), line1);
	float line3  = max(swoothstep(0.01, 0.0, min(abs(ca-c2),abs(c0-cb))), line2);
	float line4  = swoothstep(0.01, 0.0, min(max(abs(c0-c2),abs(c1-ca)),max(abs(c0-c2),abs(c1-cb))));
	line2 = lerp(line3, line0, line4);
	float nd = (ntsc_dith > 0.005) ? ntsc_dith : max(res-1.0, 0.0);
	res /= 1.0 + (1.0-line2) * nd;
	}

	if(MERGE>0.5)
	{
	float chroma_phase2=(phase<2.5)?pii*(mod(pix_no.y,2.0)+mod(float(framecount)+1,2.)):0.6667*pii*(mod(pix_no.y,3.0)+mod(float(framecount)+1,2.));
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
	float chroma_phase1=(phase<2.5)?pii*(mod(pix_no.y,2.0)+mod(float(framecount)  ,2.)):0.6667*pii*(mod(pix_no.y,3.0)+mod(float(framecount)  ,2.));
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

//!PASS 6
//!DESC NTSC pass 2 (filtering)
//!STYLE PS
//!IN T03, T02
//!OUT T04

float4 Pass6(float2 texcoord)
{
	float2 tex_c=texcoord+float2(0.5/speedup*OrgSize.z/4.0,0.0);
	float NOrgSize = (OrgSize.x < 450.0) ? OrgSize.x : OrgSize.x / max(round(OrgSize.x / 300.0), 1.0);
	float phase = (ntsc_phase < 1.5) ? ((NOrgSize > 300.0 || (OrgSize.x > 400.0 && OrgSize.y > 250.0)) ? 2.0 : 3.0) : ((ntsc_phase > 2.5) ? 3.0 : 2.0);
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
   
	if (abs(ntsc_dith) > 0.005 && OrgSize.y < 300.0 && (phase == 2.0 || ntsc_phase > 3.5))
	{
	float2 TexD = (floor(tex_c * OrgSize.xy) + 0.5)*OrgSize.zw;
	float2 xx = float2(OrgSize.z, 0.0);

	float ca = T03.SampleLevel(sPt, TexD - xx - xx,0).a;
	float c0 = T03.SampleLevel(sPt, TexD - xx,0).a;
	float c1 = T03.SampleLevel(sPt, TexD     ,0).a;
	float c2 = T03.SampleLevel(sPt, TexD + xx,0).a;
	float cb = T03.SampleLevel(sPt, TexD + xx + xx,0).a;

	float line0  = swoothstep(0.01, 0.0, min(abs(c1-c0),abs(c2-c1)));
	float line1  = max(swoothstep(0.01, 0.0, min(abs(ca-c0),abs(c2-cb))), line0);
	float line2  = max(swoothstep(0.20, 0.0, max(abs(ca-c0),abs(c2-cb))), line1);
	float line3  = max(swoothstep(0.01, 0.0, min(abs(ca-c2),abs(c0-cb))), line2);
	float line4  = swoothstep(0.01, 0.0, min(max(abs(c0-c2),abs(c1-ca)),max(abs(c0-c2),abs(c1-cb))));
	line2 = lerp(line3, line0, line4);
	float nd = (ntsc_dith > 0.005) ? ntsc_dith : max(res-1.0, 0.0);
	res /= 1.0 + (1.0-line2) * nd;
	}

	float ntsc_sizex = (ntsc_samp > 1.5) ? OrgSize.x : ((OrgSize.x < 400.0) ? OrgSize.x : (phase == 2.0) ? 320.0 : 256.0);
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
	sums = fetch_offset(xd);
	tmps = float3(luma_filter_2_phase[i], chroma_filter_2_phase[j].xx);
	wsum=wsum+tmps;
	signal+=sums*tmps;
	}
	j = int(loob);
	tmps=float3(luma_filter_2_phase[TAPS_2_phase], chroma_filter_2_phase[j], chroma_filter_2_phase[j]);
	wsum=wsum+wsum+tmps;
	signal+=T03.SampleLevel(sPt,tex_c,0).xyz*tmps;
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
	sums=fetch_offset(xd);
	tmps=float3(luma_filter_3_phase[i], chroma_filter_3_phase[i].xx);
	wsum=wsum+tmps;
	signal+=sums*tmps;
	}
	tmps=float3(luma_filter_3_phase[TAPS_2_phase], chroma_filter_3_phase[TAPS_2_phase], chroma_filter_3_phase[TAPS_2_phase]);
	wsum=wsum+wsum+tmps;
	signal+=T03.SampleLevel(sPt,tex_c,0).xyz*tmps;
	signal =signal/wsum;
	}
	signal.x=clamp( signal.x,0.0,1.0);
	if(ntsc_ring>0.05)
	{
	float2 dx=float2(OrgSize.z/min(res,1.0)/speedup,0.0);
	float a=T03.SampleLevel(sPt,tex_c-2.0*dx,0).a;
	float b=T03.SampleLevel(sPt,tex_c-    dx,0).a;
	float c=T03.SampleLevel(sPt,tex_c+2.0*dx,0).a;
	float d=T03.SampleLevel(sPt,tex_c+    dx,0).a;
	float e=T03.SampleLevel(sPt,tex_c       ,0).a;
	signal.x=lerp(signal.x,clamp(signal.x,min(min(min(a,b),min(c,d)),e),max(max(max(a,b),max(c,d)),e)),ntsc_ring);
	}
	float x=get_luma(T02.SampleLevel(sLin, tex_c*float2(speedup, 1.0),0).rgb);
	return float4(signal,x);
}

//!PASS 7
//!DESC NTSC pass 3 (demodulation)
//!STYLE PS
//!IN T04, T03, T02
//!OUT T05

float4 Pass7(float2 texcoord)
{
    float auto_rez = lerp(1.0, 0.5, clamp(auto_res * round(OrgSize.x/300.0)-1.0, 0.0, 1.0));
    float2 vtex_c0=texcoord / float2(speedup, 1.0);
    float2 vtex_c1=(floor(vtex_c0*OrgSize.xy)+0.5)*OrgSize.zw;
    float2 vtex_c=texcoord+float2(0.5*(OrgSize.z/auto_rez)/4.0,0.0);
    float NOrgSize = (OrgSize.x < 450.0) ? OrgSize.x : OrgSize.x / max(round(OrgSize.x / 300.0), 1.0);
    float phase = (ntsc_phase < 1.5) ? ((NOrgSize > 300.0 || (OrgSize.x > 400.0 && OrgSize.y > 250.0)) ? 2.0 : 3.0) : ((ntsc_phase > 2.5) ? 3.0 : 2.0);
    if (ntsc_phase == 4.0) phase = 3.0; else if (ntsc_phase == 5.0) phase = 2.0;

    float4 AdvSize= LumSize;

    if(speedup > 1.25 && ((OrgSize.y > 500.0 && AdvSize.y > 820.0) || AdvSize.y > 820.0))
    {
        float3 signal = T04.SampleLevel(sLin, vtex_c0,0).xyz;
        signal.x = pow(signal.x, 1.0/ntsc_gamma);
        return float4(clamp(yiq2rgb(signal), 0.0, 1.0), 1.0);
    }
    else
    {

	float2 xx=float2(0.5000*OrgSize.z/auto_rez/speedup,0.0);
	float2 dx=float2(0.0625*OrgSize.z/auto_rez/speedup,0.0);

	float2 tcoorb=(floor(OrgSize.xy*vtex_c)+0.5)*OrgSize.zw;
	float2 tcoord=vtex_c-2.0*dx;
	float2 vTex=vtex_c;
	if (speedup > 1.25) { tcoorb = vtex_c1; tcoord = vtex_c0; vTex = vtex_c0; }
	float3 ll1=T04.SampleLevel(sLin,tcoord+ xx,0).xyz;
	float3 ll2=T04.SampleLevel(sLin,tcoord- xx,0).xyz;
	float dy=0.0;
	float2 yy = float2(0.0, OrgSize.w);
	xx=float2(OrgSize.z/auto_rez/speedup,0.0);
	float th=(phase<2.5)?0.025:0.0075;;
	float ca=T03.SampleLevel(sPt,tcoorb-xx-xx,0).a;
	float c0=T03.SampleLevel(sPt,tcoorb-xx   ,0).a;
	float c1=T03.SampleLevel(sPt,tcoorb      ,0).a;
	float c2=T03.SampleLevel(sPt,tcoorb+xx   ,0).a;
	float cb=T03.SampleLevel(sPt,tcoorb+xx+xx,0).a;
	float line0=    swoothstep(th,0.0,min(abs(c1-c0),abs(c2-c1)));
	float line1=max(swoothstep(th,0.0,min(abs(ca-c0),abs(c2-cb))), line0 );
	float line2=max(swoothstep(th,0.0,min(abs(ca-c2),abs(c0-cb))), line1 );

    float diffboost = 0.0;

    if (ntsc_fonts > 0.255)
    {
        float m1 = max(max(c0,c1),c2);
        float m2 = min(min(c0,c1),c2);
        float cont = m1+m2;

        float b1  = T03.SampleLevel(sPt, tcoorb - yy,0).a;
        float d1  = T03.SampleLevel(sPt, tcoorb + yy,0).a;
        float d2  = T03.SampleLevel(sPt, tcoorb + xx + yy,0).a;

        float maxdif = float(0.5 * (abs(c0-c1) + abs(c1-c2)) > (cont - ntsc_fonts)) * float(abs(c2-c0) < 0.05);
        float linecb = swoothstep(0.1, 0.0, max(abs(c1-b1), abs(c1-d1)));
        linecb = linecb * float(abs(c1-b1) < 0.05 || abs(c2-d2) < 0.05);

        b1 = T04.SampleLevel(sLin, tcoord         ,0).x;
        d1 = T04.SampleLevel(sLin, tcoord - 9.0*yy,0).x;
        d2 = T04.SampleLevel(sLin, tcoord + 9.0*yy,0).x;
   
        maxdif = maxdif * float((abs(d1-b1) > 0.2 || abs(d2-b1) > 0.2));

        b1 = T04.SampleLevel(sLin, tcoord         ,0).x;
        d1 = T04.SampleLevel(sLin, tcoord - 7.0*yy,0).x;
        d2 = T04.SampleLevel(sLin, tcoord + 7.0*yy,0).x;

        maxdif = max(maxdif, maxdif * float((abs(d1-b1) > 0.2 || abs(d2-b1) > 0.2)));


        float xdif1 = 0.0;
        float xdif2 = 0.0;
        float th   = 0.215;

        for (float i = 0.5; i < 10.5; i++)
        {
            float j = i + 1.0;
            ca  = T04.SampleLevel(sLin, tcoord -  i*xx,0).x;
            c0  = T04.SampleLevel(sLin, tcoord -  j*xx,0).x;
            c2 = T04.SampleLevel(sLin, tcoord +  i*xx,0).x;
            cb = T04.SampleLevel(sLin, tcoord +  j*xx,0).x;
            xdif1 = max(abs(ca - c0) - th, xdif1);
            xdif2 = max(abs(cb - c2) - th, xdif2);
            ca = T04.SampleLevel(sLin, tcoord -  i*xx - yy,0).x;
            c0 = T04.SampleLevel(sLin, tcoord -  j*xx - yy,0).x;
            c2 = T04.SampleLevel(sLin, tcoord +  i*xx - yy,0).x;
            cb = T04.SampleLevel(sLin, tcoord +  j*xx - yy,0).x;  
            xdif1 = max(abs(ca-c0)-th, xdif1);
            xdif2 = max(abs(cb-c2)-th, xdif2);   
      
            ca = T04.SampleLevel(sLin, tcoord -  i*xx + yy,0).x;
            c0 = T04.SampleLevel(sLin, tcoord -  j*xx + yy,0).x;
            c2 = T04.SampleLevel(sLin, tcoord +  i*xx + yy,0).x;
            cb = T04.SampleLevel(sLin, tcoord +  j*xx + yy,0).x;  
            xdif1 = max(abs(ca-c0)-th, xdif1);
            xdif2 = max(abs(cb-c2)-th, xdif2);
        }

        float linex   = swoothstep(0.0, 0.125, min(xdif1, xdif2));
        diffboost     = min(linex * linecb * maxdif, 0.75);
    }

    float3 ref = T04.SampleLevel(sLin, tcoord,0).xyz;
    float2 org = ref.yz;
	if( ntsc_rainbow>0.5&&(phase<2.5 || ntsc_phase == 5.0))
	{
	float ybool1=1.0;
	if((ntsc_rainbow<1.5)&&bool(line0))ybool1=0.0;else
	if((ntsc_rainbow<2.5)&&bool(line2))ybool1=0.0;

	float liine_no=floor( mod(OrgSize.y*vtex_c.y,2.0));
	float frame_no=floor( mod(float(framecount),2.0));
	float ii=abs(liine_no-frame_no);
	dy=ii*OrgSize.w*ybool1;
	float2 ref1 = T04.SampleLevel(sLin, tcoord + float2(0.0, -dy),0).yz;
				   
	float2 ref2 = T04.SampleLevel(sLin, tcoord + float2(0.0,  dy),0).yz;
	float2 rdf1 = abs(org - ref1);
	float2 rdf2 = abs(org - ref2);
	rdf1        = rdf1 / max(rdf1 + rdf2, 0.0000001);

	ref.yz = lerp(ref1, ref2, rdf1);
	}
	float lum1=min(T03.SampleLevel(sPt,vTex-dx,0).a, T03.SampleLevel(sPt,vTex+dx,0).a);
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
	dx.x = 0.0625 * OrgSize.z/auto_rez;
	float lcoord=OrgSize.x*(vtex_c.x+dx.x )-0.5;
	float fpx=frac(lcoord);
	lcoord =(floor(lcoord)+0.5)*OrgSize.z;
	float mixer=sweight;
	if(ntsc_shrp>0.25)mixer=zweight;
	mixer =lerp(swoothstep(0.075,0.125,max(ll3.y,ll3.z)),swoothstep(0.015,0.0275,di),line2)*mixer;
	mixer*=0.1*((phase<2.5)? ntsc_charp1:ntsc_charp2);
	tcoord=float2(lcoord,tcoord.y);
	float3 origin=rgb2yiq(lerp(T02.SampleLevel(sLin,tcoord,0).rgb,T02.SampleLevel(sLin,tcoord+16.0*dx,0).rgb,clamp(1.5*fpx-0.25,0.0,1.0)));
	signal.yz=lerp(signal.yz,origin.yz,mixer);
	}

    if ((RFNOISE1 + RFNOISE2) > 0.005)
    {
        float3 ns = NoiseNP3(vtex_c, float(framecount));
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

//!PASS 8
//!DESC FSharpen
//!STYLE PS
//!IN T05, T02
//!OUT T06

float4 Pass8(float2 texcoord)
{
	float resmult = round(OrgSize.x / 300.0);
	float2 g01=float2(-0.5*resmult*OrgSize.z,0.0);
	float2 g21=float2( 0.5*resmult*OrgSize.z,0.0);
	float3 c01=T05.SampleLevel(sLin,texcoord+g01,0).rgb;
	float3 c21=T05.SampleLevel(sLin,texcoord+g21,0).rgb;
	float3 c11=T05.SampleLevel(sLin,texcoord    ,0).rgb;
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
	float2 toxcoord=(floor(OrgSize.xy*texcoord)+0.5)*OrgSize.zw;
	float l01=get_luma_sharpen(T02.SampleLevel(sLin,texcoord+2.0*g01,0).rgb);
	float l21=get_luma_sharpen(T02.SampleLevel(sLin,texcoord+2.0*g21,0).rgb);
	float l11=get_luma_sharpen(T02.SampleLevel(sLin,toxcoord        ,0).rgb);
	float dth = T05.SampleLevel(sLin,texcoord,0).a;
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

//!PASS 9
//!DESC Reduce 1 (average colour)
//!STYLE PS
//!IN T06
//!OUT RB1

float4 Pass9(float2 texcoord)
{
	float2 sz=float2(64.0,32.0);
	float2 o=floor(texcoord*sz)/sz;
	float3 sum=0.0;
	for(int j=0;j<8;j++)
	for(int i=0;i<8;i++)
		sum+=T06.SampleLevel(sLin,o+(float2(i,j)+0.5)/8.0/sz,0).rgb;
	return float4(sum/64.0,1.0);
}

//!PASS 10
//!DESC Reduce 2 (regional averages)
//!STYLE PS
//!IN RB1
//!OUT AVG2

float4 Pass10(float2 texcoord)
{
	float px=floor(texcoord.x*5.0);
	float n=(px<1.5)?2.0:3.0;
	float k=(px<1.5)?px:px-2.0;
	float3 sum=0.0;
	for(int j=0;j<16;j++)
	for(int i=0;i<16;i++)
		sum+=RB1.SampleLevel(sLin,float2((k+(float(i)+0.5)/16.0)/n,(float(j)+0.5)/16.0),0).rgb;
	return float4(sum/256.0,1.0);
}

//!PASS 11
//!DESC Luminance (raster bloom)
//!STYLE PS
//!IN AVG2, LUMH
//!OUT LUM

float4 Pass11(float2 texcoord)
{
	float W=LumSize.x;
	float H=LumSize.y;
	float m=floor(max(max(log2(W),log2(H)),1.0))-1.0;
	float n=clamp(floor(W/exp2(m)),2.0,3.0);      // texels of the emulated mip level (x axis)
	float off=(n<2.5)?0.0:2.0;
	float3 c[2];
	[unroll] for(int q=0;q<2;q++)
	{
		float u=((q==0)?0.3:0.7)*n-0.5;
		float i0=floor(u);
		float f=u-i0;
		float a=clamp(i0,0.0,n-1.0);
		float b=clamp(i0+1.0,0.0,n-1.0);
		c[q]=lerp(AVG2.SampleLevel(sPt,float2((off+a+0.5)/5.0,0.5),0).rgb,AVG2.SampleLevel(sPt,float2((off+b+0.5)/5.0,0.5),0).rgb,f);
	}
	float ltotal=0.5*(length(c[0])+length(c[1]));
	ltotal=pow(0.577350269*ltotal,0.7);
	float lhistory=LUMH.SampleLevel(sPt,float2(0.5,0.5),0).x;
	ltotal=lerp(ltotal,lhistory,min(lerp(lsmooth,lsmooth+lsdev,ltotal),0.99));
	return float4(ltotal,ltotal,ltotal,ltotal);
}

//!PASS 12
//!DESC Luminance history
//!STYLE PS
//!IN LUM
//!OUT LUMH

float4 Pass12(float2 texcoord)
{
	return LUM.SampleLevel(sPt,float2(0.5,0.5),0);
}

//!PASS 13
//!DESC Linearize
//!STYLE PS
//!IN T06, T0I
//!OUT T08

float3 fetch_pixel(float2 coord)
{
	float2 dx=float2(LumSize.z,0.0)*downsample_levelx;
	float2 dy=float2(0.0,LumSize.w)*downsample_levely;
	float2 d1=dx+dy;
	float2 d2=dx-dy;
	float sum=15.0;
	float3 result=
	3.0*T06.SampleLevel(sLin,coord   ,0).rgb+2.0*T06.SampleLevel(sLin,coord+dx,0).rgb+2.0*T06.SampleLevel(sLin,coord-dx,0).rgb+
	2.0*T06.SampleLevel(sLin,coord+dy,0).rgb+2.0*T06.SampleLevel(sLin,coord-dy,0).rgb+    T06.SampleLevel(sLin,coord+d1,0).rgb+
		T06.SampleLevel(sLin,coord-d1,0).rgb+    T06.SampleLevel(sLin,coord+d2,0).rgb+    T06.SampleLevel(sLin,coord-d2,0).rgb;
	return result/sum;
}
float4 Pass13(float2 texcoord)
{
    float3 c = T06.SampleLevel(sLin,fuxcoord,0).rgb;
    if((downsample_levelx+downsample_levely)>0.025)
    {
    c=fetch_pixel(fuxcoord);
    }
    float intera = T0I.SampleLevel(sLin,float2(0.75,0.75),0).a;
    float gamma_in=gamma_i;
    c=pow(c,gamma_in);
    if(fuxcoord.x>0.5)gamma_in=intera;else gamma_in=1.0/gamma_in;
    return float4(c,gamma_in);
}

//!PASS 14
//!DESC Glow horizontal
//!STYLE PS
//!IN T08
//!OUT T10

float4 Pass14(float2 texcoord)
{
	float FG_=(FINE_GAUSS>0.5)?FINE_GAUSS:lerp(0.75,0.50,-FINE_GAUSS);
	float4 AdvSize=float4(OrgSize.x,OrgSize.y,OrgSize.z,OrgSize.w)*float4(FG_,FG_,1.0/FG_,1.0/FG_);
	float f=frac(AdvSize.x*texcoord.x);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float3 color=0.0;
	float2 dx=float2(AdvSize.z ,0.0);
	float3 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEH;
	do
	{
	pixel=T08.SampleLevel(sLin,tex+n*dx,0).rgb;
	if(m_glow>0.5)
	{
	pixel=max(pixel-m_glow_cutoff,0.0);
	pixel=plant(pixel,max(max(max(pixel.r,pixel.g),pixel.b)-m_glow_cutoff,0.0));
	}
	w=gauss_h(n+f);
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEH);
	color=color/wsum;
	return float4(color,1.0);
}

//!PASS 15
//!DESC Glow vertical
//!STYLE PS
//!IN T10
//!OUT T11

float4 Pass15(float2 texcoord)
{
	float FG_=(FINE_GAUSS>0.5)?FINE_GAUSS:lerp(0.75,0.50,-FINE_GAUSS);
	float4 AdvSize=float4(SrcSize.x,OrgSize.y,SrcSize.z,OrgSize.w)*float4(FG_,FG_,1.0/FG_,1.0/FG_);
	float f=frac(AdvSize.y*texcoord.y);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float3 color=0.0;
	float2 dy=float2(0.0,AdvSize.w );
	float3 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEV;
	do
	{
	pixel=T10.SampleLevel(sLin,tex+n*dy,0).rgb;
	w=gauss_v(n+f);
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEV);
	color=color/wsum;
	return float4(color,1.0);
}

//!PASS 16
//!DESC Bloom horizontal
//!STYLE PS
//!IN T08
//!OUT T12

float4 Pass16(float2 texcoord)
{
	float FB_=(FINE_BLOOM>0.5)?FINE_BLOOM:lerp(0.75,0.50,-FINE_BLOOM);
	float4 AdvSize=float4(OrgSize.x,OrgSize.y,OrgSize.z,OrgSize.w)*float4(FB_,FB_,1.0/FB_,1.0/FB_);
	float f=frac(AdvSize.x*texcoord.x);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float4 color=0.0;
	float2 dx=float2(AdvSize.z ,0.0);
	float4 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEX;
	do
	{
	pixel=T08.SampleLevel(sLin,tex+n*dx,0);
	w=bloom_h(n+f);
	pixel.a =max(max(pixel.r,pixel.g),pixel.b);
	pixel.a*=pixel.a*pixel.a;
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEX);
	color=color/wsum;
	return float4(color.rgb,pow(color.a,0.333333));
}

//!PASS 17
//!DESC Bloom vertical
//!STYLE PS
//!IN T12
//!OUT T13

float4 Pass17(float2 texcoord)
{
	float FB_=(FINE_BLOOM>0.5)?FINE_BLOOM:lerp(0.75,0.50,-FINE_BLOOM);
	float4 AdvSize=float4(SrcSize.x,OrgSize.y,SrcSize.z,OrgSize.w)*float4(FB_,FB_,1.0/FB_,1.0/FB_);
	float f=frac(AdvSize.y*texcoord.y);
	f=0.5-f;
	float2 tex=floor(AdvSize.xy*texcoord)*AdvSize.zw+0.5*AdvSize.zw;
	float4 color=0.0;
	float2 dy=float2(0.0,AdvSize.w );
	float4 pixel;
	float w;
	float wsum=0.0;
	float n=-SIZEY;
	do
	{
	pixel=T12.SampleLevel(sLin,tex+n*dy,0);
	w=bloom_v(n+f);
	pixel.a*=pixel.a*pixel.a;
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=SIZEY);
	color=color/wsum;
	return float4(color.rgb,pow(color.a,0.175000));
}

//!PASS 18
//!DESC CRT pass 1 (horizontal filter)
//!STYLE PS
//!IN T08
//!OUT T09

float4 Pass18(float2 texcoord)
{
	float f=frac(LumSize.x*fuxcoord.x);
	f=0.5-f;
	float2 tex=floor(LumSize.xy*fuxcoord)*LumSize.zw+0.5*LumSize.zw;
	float3 color=0.0.xxx;
	float solor=0.0;
	float2 dx=float2(LumSize.z ,0.0);
	float3 pixel;
	float w=0.0;
	float swum=0.0;
	float wsum=0.0;
	float3 cmax=0.0.xxx;
	float3 cmin=1.0.xxx;
	float xs=max(2.0*0.4, 1.0);
	float hsharpness=HSHARPNESS*xs*filter_res;
	float LIGMA_H2 = LIGMA_H * HSHARPNESS;
	xs=1.0/(2.0*LIGMA_H2*LIGMA_H2*xs*xs*filter_res*filter_res);
	float sharp=crthd_h(hsharpness,xs) *S_SHARP;
	float ksharp = -2.0*hsharpness*xs*sharp;	
	float maxsharp=MAXS;
	float FPR=hsharpness;
	float FPRi=1.0/hsharpness;
	float fpx=0.0;
	float sp=0.0;
	float sw=0.0;
	float ts=0.025;
	float3 luma=float3(0.2126,0.7152,0.0722);
	float LOOPSIZE=ceil(2.0*FPR);
	float n=-LOOPSIZE;
	do
	{
	pixel=T08.SampleLevel(sLin,tex+n*dx,0).rgb;
	w=crthd_h(n+f,xs)-sharp;
	fpx=clamp((abs(n+f)-FPR)*FPRi, 0.0, 1.0);
	if(w<0.0)w=max(ksharp*fpx, maxsharp * ksharp * (1.0-fpx*fpx)); else
	{
	cmax=max(cmax,pixel);cmin=min(cmin,pixel);sw=w*(dot(pixel,luma)+ts);
	sp=max(max(pixel.r,pixel.g),pixel.b);
	solor=solor+sw*sp;
	swum=swum+sw;
	}
	color=color+w*pixel;
	wsum=wsum+w;
	n=n+1.0;
	}
	while(n<=LOOPSIZE);
	color=color/wsum;
	solor=solor/swum;
	color=clamp(lerp( clamp (color,cmin,cmax),color,SSRNG),0.0,1.0);
	solor=clamp(lerp(max(max(color.r,color.g),color.b),solor,spike),0.0,1.0);
	return float4(color,solor);
}

//!PASS 19
//!DESC CRT pass 2 (scanlines / bloom)
//!STYLE PS
//!IN T09, T08, LUM, T13
//!OUT T14

float4 Pass19(float2 texcoord)
{
	float gamma_in=1.0/T08.SampleLevel(sLin,float2(0.25,0.25),0).a;
	float lum=LUM.SampleLevel(sPt,float2(0.5,0.5),0).a;
	float intera=T08.SampleLevel(sLin,float2(0.75,0.25),0).a;
	bool hscans=(hiscan>0.5);
	bool inter6=(intera<0.35&&interm==6.0);
	bool interb=(((intera<0.35&&!inter6)||(no_scanlines>0.025))&&!hscans);
	float4 AdvSize= LumSize;
	float SourceY=AdvSize.y;
	float sy=1.0;
	if( intres==1.0)sy=max(round(SourceY/224.0),1.0);
	if( intres>0.25&&intres!=1.0)sy=intres;
	if (inter6) sy*=2.0;
	AdvSize*=float4(1.0,1.0/sy,1.0,sy);
	float2 lexcoord=fuxcoord.xy;
	if(IOS> 0.0&& !interb)
	{
	float2 ofactor= NewSize.xy/OrgSize.xy;
	float2 ifactor=(IOS<2.5)? floor(ofactor):ceil(ofactor);
	float2 diff=ofactor/ifactor;
	float scan=diff.y;
	lexcoord=overscan(lexcoord,scan,scan);
	if(IOS==1.0||IOS==3.0) lexcoord=float2(fuxcoord.x,lexcoord.y);
	}
	float factor=1.0+(1.0-0.5*OS)*blm_2/100.0-lum*blm_2/100.0;
	lexcoord=overscan(lexcoord,factor,factor);
	lexcoord.y = lexcoord.y - VShift*OrgSize.w;
	lexcoord=overscan(lexcoord,(OrgSize.x-overscanx)/OrgSize.x,(OrgSize.y-overscany)/OrgSize.y);
	float2 pos = warp(lexcoord);
	float ii = float(inter6)*(floor(mod(float(framecount), 2.0)));
	float2 coffset = float2(0.5, 0.5 + 0.5*ii);
	float2 ps=AdvSize.zw;
	float2 OGL2Pos=pos*AdvSize.xy-coffset;
	float2 fp=frac(OGL2Pos);
	float2 dx=float2(ps.x,0.0);
	float2 dy=float2(0.0,ps.y);
	float f=fp.y;
	float2 pC4=floor(OGL2Pos)*ps+0.5*ps; pC4.y = pC4.y + float(inter6)*0.25*dy.y;
	pC4.x=pos.x;
	if( intres==0.5<1.5)pC4.y=floor(pC4.y*OrgSize.y)*OrgSize.w+0.5*OrgSize.w;
	if( interb&&no_scanlines<0.025|| hscans) pC4.y=pos.y;else
	if( interb) pC4.y=pC4.y+smoothstep(0.40-0.5*no_scanlines,0.60+0.5*no_scanlines,f)*AdvSize.w;
	float3 color1=T09.SampleLevel(sLin,pC4,0).rgb;
	float3 solor1=T09.SampleLevel(sLin,pC4,0).aaa;
	if(!interb)color1=pow(color1,scangamma/gamma_in);
	pC4+=dy;
	if( intres==0.5<1.5)pC4.y=floor((pos.y+0.33*dy.y)*OrgSize.y)*OrgSize.w+0.5*OrgSize.w;
	float3 color2=T09.SampleLevel(sLin,pC4,0).rgb;
	float3 solor2=T09.SampleLevel(sLin,pC4,0).aaa;
	if(!interb)color2=pow(color2,scangamma/gamma_in);
	float3 ctmp=color1;float w3=1.0;float3 color=color1;
	float3 one=1.0;
	if( hscans){color2=color1;solor2=solor1;}
	if(!interb|| hscans)
	{
	float ssub = ssharp*abs(solor1.x-solor2.x);
	float shape1=lerp(scanline1,scanline2 + ssub * solor1.x * 35.0,    f);
	float shape2=lerp(scanline1,scanline2 + ssub * solor2.x * 35.0,1.0-f);
	float wt1=st0(    f);
	float wt2=st0(1.0-f);
	float3 color0=color1*wt1+color2*wt2;
	float3 solor0=solor1*wt1+solor2*wt2;
	ctmp = color0/(wt1+wt2);
	float3 stmp=solor0/(wt1+wt2);
	if(abs(rolling_scan)>0.005){color1=ctmp;color2=ctmp;solor1=stmp;solor2=stmp;}
	float3 w1,w2;
	float3 cref1=lerp(stmp,solor1,beam_size);float creff1=pow(max(max(cref1.r,cref1.g),cref1.b),scan_falloff);
	float3 cref2=lerp(stmp,solor2,beam_size);float creff2=pow(max(max(cref2.r,cref2.g),cref2.b),scan_falloff);
	if(tds>0.5){shape1=lerp(scanline2,shape1,creff1);shape2=lerp(scanline2,shape2,creff2);}
	float scanpix=OrgSize.y/NewSize.y;
	float f1=frac(f-rolling_scan*float(framecount)*scanpix);
	float f2=1.0-f1;
	float m1=max(max(color1.r,color1.g),color1.b)+eps;
	float m2=max(max(color2.r,color2.g),color2.b)+eps;
	cref1=color1/m1;
	cref2=color2/m2;
	if(gsl< 0.5)
	{w1=sw0(f1,creff1,shape1,cref1);w2=sw0(f2,creff2,shape2,cref2);}else
	if(gsl==1.0)
	{w1=sw1(f1,creff1,shape1,cref1);w2=sw1(f2,creff2,shape2,cref2);}else
	{w1=sw2(f1,creff1,shape1,cref1);w2=sw2(f2,creff2,shape2,cref2);}
	float3 w3=w1+w2;
	float wf1=max(max(w3.r,w3.g),w3.b);
	if(wf1>1.0){wf1=1.0/wf1;w1*=wf1,w2*=wf1;}
	if(abs(clp)>0.005)
	{
	sy=m1; one=(clp>0.0)?w1:1.0.xxx;
	float sat=1.0001-min(min(cref1.r,cref1.g),cref1.b);
	color1=lerp(color1,plant(pow(color1,0.70.xxx-0.325*sat),sy),pow(sat,0.3333)*one*abs(clp));
	sy=m2; one=(clp>0.0)?w2:1.0.xxx;
	sat=1.0001-min(min(cref2.r,cref2.g),cref2.b);
	color2=lerp(color2,plant(pow(color2,0.70.xxx-0.325*sat),sy),pow(sat,0.3333)*one*abs(clp));
	}
	color=gc1(color1)*w1+gc1(color2)*w2;
	if (bloomsamp > 0.5) {	
		float3 BloomS = T13.SampleLevel(sLin, pos,0).rgb;
		BloomS = pow(BloomS, scangamma/gamma_in);
		float cm = max(max(ctmp.r,ctmp.g),ctmp.b);
		float bm = max(max(BloomS.r,BloomS.g),BloomS.b);
		float bmix = clamp(max((cm-bm), (bm-cm)/(cm+0.25)-cm), 0.0, 1.0);
		if (abs(clp) > 0.005)
		{
			sy = cm + eps; one = (clp > 0.0) ? min(w1+w2,1.0) : 1.0.xxx;
			cref1 = plant(BloomS,1.0);
			float sat = 1.0001-min(min(cref1.r,cref1.g),cref1.b);
			BloomS = lerp(BloomS, plant(pow(BloomS, 0.70.xxx-0.325*sat),sy), pow(sat,0.3333)*one*abs(clp));
		}
		float3 Bloom1 = (color1*wt1 + color2*wt2)/(wt1+wt2);
		BloomS = lerp(BloomS, Bloom1, min(3.0*abs(plant(sqrt(Bloom1),1.0) - plant(sqrt(BloomS),1.0)), 1.0));
		bm = max(max(BloomS.r,BloomS.g),BloomS.b);
		BloomS = plant(lerp(BloomS,Bloom1,bloomsamp-1.0), lerp(bm, 1.125*cm, bmix));
		BloomS = gc1(BloomS)*(w1+w2);
		color = min(lerp(color, BloomS, pow(cm, lerp(0.4, 0.2, pow(cm,0.375)))), max(BloomS,color));
	}
	color=min(color,1.0);
	}
	if( interb)
	{
	color=gc1(color1);
	}
	float colmx=max( max(ctmp.r,ctmp.g),ctmp.b);
	if(!interb){color=pow(color,gamma_in/scangamma); colmx = pow(colmx, gamma_in/scangamma); }
	return float4(color,colmx);
}

//!PASS 20
//!DESC CRT pass 3 (mask / glow / output)
//!STYLE PS
//!IN T14, T13, T11, T08, LUM, T02, INPUT
//!OUT OUTPUT

void bring_pixel(inout float3 c,inout float3 b,inout float3 g,float2 coord,float2 boord)
{
	float stepx=NewSize.z;
	float stepy=NewSize.w;
	float2 dx=float2(stepx,0.0);
	float2 dy=float2(0.0,stepy);
	float posx= 2.0*coord.x-1.0;
	float posy= 2.0*coord.y-1.0;
	if(dctypex>0.025)
	{
	posx= sign(posx)*pow(abs(posx),1.05-dctypex);
	dx=posx*dx;
	}
	if(dctypey>0.025)
	{
	posy= sign(posy)*pow(abs(posy),1.05-dctypey);
	dy=posy*dy;
	}
	float2 rc=deconrx*dx+deconry*dy;
	float2 gc=decongx*dx+decongy*dy;
	float2 bc=deconbx*dx+deconby*dy;
	float r1=T14.SampleLevel(sLin,coord+rc,0).r;
	float g1=T14.SampleLevel(sLin,coord+gc,0).g;
	float b1=T14.SampleLevel(sLin,coord+bc,0).b;
	float ds=decons;
	float3 d=float3(r1,g1,b1);
	c=clamp(lerp(c,d,ds),0.0,1.0);
	r1=T13.SampleLevel(sLin,boord+rc,0).r;
	g1=T13.SampleLevel(sLin,boord+gc,0).g;
	b1=T13.SampleLevel(sLin,boord+bc,0).b;
	d=float3(r1,g1,b1);
	b=g=lerp(b,d,min(ds,1.0));
	r1=T11.SampleLevel(sLin,boord+rc,0).r;
	g1=T11.SampleLevel(sLin,boord+gc,0).g;
	b1=T11.SampleLevel(sLin,boord+bc,0).b;
	d=float3(r1,g1,b1);
	g=lerp(g,d,min(ds,1.0));
}
float humbars(float pos)
{
	if  (barintensity==0.0)return 1.0;else
	{
	pos=(barintensity>=0.0)?pos:(1.0-pos);
	pos=frac(pos+ mod(float(framecount),barspeed)/(barspeed-1.0));
	pos=(barintensity< 0.0)?pos:(1.0-pos);
	return (1.0-barintensity)+barintensity*pos;
	}
}
float corner(float2 pos)
{
	pos=abs(2.0*(pos-0.50));
	float2 aspect=float2(1.0,NewSize.x/NewSize.y);
	float b=bsize*0.05+0.0005;pos.y=pos.y+b*(aspect.y-1.0);
	float2 crn=max(csize.xx,2.0*b+0.0015);
	float2 crp=max(pos-(1.0-crn*aspect),0.0)/aspect;float cd=sqrt(dot(crp,crp));
	pos=max(pos,1.0-crn+cd);
	float res=lerp(1.0,0.0,smoothstep(1.0-b,1.0,sqrt(max(pos.x,pos.y))));
	return pow(res,sborder);
}
float4 Pass20(float2 texcoord)
{
	float gamma_in=1.0/T08.SampleLevel(sLin,float2(0.25,0.25),0).a;
	float lum=LUM.SampleLevel(sPt,float2(0.5,0.5),0).a;
	float intera=T08.SampleLevel(sLin,float2(0.75,0.25),0).a;
	bool inter6=(intera<0.35&&interm==6.0);
	bool interb=(((intera<0.35&&!inter6)||(no_scanlines>0.025))&&!hiscan);
	float2 lexcoord=fuxcoord.xy;
	if(IOS> 0.0&& !interb)
	{
	float2 ofactor= NewSize.xy/OrgSize.xy;
	float2 ifactor=(IOS<2.5)? floor(ofactor):ceil(ofactor);
	float2 diff=ofactor/ifactor;
	float scan=diff.y;
	lexcoord=overscan(lexcoord,scan,scan);
	if(IOS==1.0||IOS==3.0) lexcoord=float2(fuxcoord.x,lexcoord.y);
	}
	float factor=1.0+(1.0-0.5*OS)*blm_2/100.0-lum*blm_2/100.0;
	lexcoord=overscan(lexcoord,factor,factor);
	lexcoord.y=lexcoord.y - VShift*OrgSize.w;
	lexcoord=overscan(lexcoord,(OrgSize.x-overscanx)/OrgSize.x,(OrgSize.y-overscany)/OrgSize.y);
	float2 pos0= warp(fuxcoord);
	float2 pos1= fuxcoord;
	float2 pos = warp(lexcoord);
	float2 posb = 2.0*(pos0-0.5);
	if (blm_2 < 0.5) posb = max(abs(posb), abs(2.0*(pos-0.5)))*sign(posb);
	posb = 0.5*posb + 0.5;
	float3 color=T14.SampleLevel(sLin,pos1,0).rgb;
	float3 Bloom=T13.SampleLevel(sLin,pos ,0).rgb;
	float3 Glow =T11.SampleLevel(sLin,pos ,0).rgb;
	if((abs(deconrx)+abs(deconry)+abs(decongx)+abs(decongy)+abs(deconbx)+abs(deconby))>0.2) bring_pixel(color,Bloom,Glow,pos1,pos);
	float cm=igc(max(max(color.r,color.g),color.b));
	float mx1=T14.SampleLevel(sLin,pos1   ,0).a;
	float colmx=max(mx1,cm);
	float w3=min((max((cm-0.0005)*1.0005,0.0)+0.0001)/(colmx+0.0005),1.0);if(interb)w3=1.0;
	float2 dx=float2(0.001,0.0);
	float mx0=T14.SampleLevel(sLin,pos1-dx,0).a;
	float mx2=T14.SampleLevel(sLin,pos1+dx,0).a;
	float mxg=max(max(mx0,mx1),max(mx2,cm));
	float mx=pow(mxg,1.40/gamma_in);
	float cx=pow(colmx,1.40/gamma_in);
	dx=float2(OrgSize.z,0.0)*0.25;
	mx0=T14.SampleLevel(sLin,pos1-dx,0).a;
	mx2=T14.SampleLevel(sLin,pos1+dx,0).a;
	float mb=(1.0-min(abs(mx0-mx2)/(0.5+mx1),1.0));
	float3 orig1=color;
	float3 one=1.0;
	float3 cmask=one;
	float3 dmask=one;
	float3 emask=one;
	float mwidths[15]={2.0,3.0,3.0,6.0,6.0,2.4,3.4,2.4,3.25,3.4,4.4,4.25,7.4,6.25,5.25};
	float mwidth=mwidths[int(shadow_msk)];
	float mask_compensate=frac(mwidth);
	float mwidth0 = mwidth;
	if(shadow_msk> -0.5)
	{
	float2 maskcoord= fracoord.xy+float2(laysh*masksize,0.0);
	float2 scoord=maskcoord;
	mwidth=floor(mwidth)*masksize;
	float swidth=mwidth;
	bool zoomed=(abs(mask_zoom)>0.75);
	float mscale=1.0;
	float2 maskcoord0=maskcoord;
	maskcoord.y=floor(maskcoord.y/masksize);
	mwidth0=max(mwidth+mask_zoom,2.0);
	if( mshift> 0.25)
	{
	float stagg_lvl=1.0; if(frac(mshift)>0.25)stagg_lvl=2.0;
	float next_line=float(floor(mod(maskcoord.y,2.0*stagg_lvl))<stagg_lvl);
	maskcoord0.x=maskcoord0.x+next_line*0.5*mwidth0;
	}
	maskcoord=maskcoord0/masksize;
	if(!zoomed)cmask=crt_mask(floor(maskcoord),mx,mb);else
	{
	mscale=mwidth0/mwidth;
	float clerp= frac(maskcoord.x/mscale); if( zoom_mask>0.025 )clerp=clamp((1.0+zoom_mask)*clerp-0.5*zoom_mask,0.0,1.0);

	float coord = floor(maskcoord.x/mscale);
	if (shadow_msk == 12.0 && mask_zoom == -2.0) coord = ceil(maskcoord.x/mscale);
	cmask = lerp(crt_mask(float2(coord,maskcoord.y), mx, mb), crt_mask(float2(coord + 1.0, maskcoord.y), mx, mb), clerp);
	}
	float sm_offset=0.0;bool bsm_offset=(shadow_msk==0.0||shadow_msk==2.0||shadow_msk==5.0||shadow_msk==6.0||shadow_msk==8.0||shadow_msk==11.0);
	if( zoomed)
	{
	if(mask_layout<0.5&&bsm_offset)sm_offset=1.0;else
	if(bsm_offset)sm_offset=-1.0;
	}
	swidth=round(mwidth0); if (slotwidth > 0.5) swidth = slotwidth; float smask = 1.0;
	smask =slt_mask(scoord+float2(sm_offset,0.0),mx,swidth);
	smask =clamp(smask+lerp(smask_mit,0.0,w3*pow(colmx,0.3)),0.0,1.0);
	emask =cmask;
	cmask*=smask;
	dmask =cmask;
	if(abs(mask_bloom)>0.025)
	{
	float maxbl=max( max(max(Bloom.r,Bloom.g),Bloom.b),mxg);
	maxbl=maxbl*max(lerp(1.0,2-colmx,bloom_dist),0.0);
	if(mask_bloom>0.025) cmask= max(min(cmask +maxbl*mask_bloom,1),cmask); else
	cmask=max(lerp(cmask,cmask*(1.0-0.5*maxbl)+plant(pow( Bloom,0.35.xxx),maxbl),-mask_bloom),cmask);
	}
	color=pow(color,mask_gamma/gamma_in);
	color=color*cmask;
	color=min(color,1.0);
	color=pow(color,gamma_in/mask_gamma);
	cmask=min(cmask,1.0);
	dmask=min(dmask,1.0);
	}
	float dark_compensate=lerp(max(clamp(lerp(mcut,maskstr,mx),0.0,1.0)-1.0+ mask_compensate,0.0)+1.0,1.0,mx); if(shadow_msk< -0.5) dark_compensate=1.0;
	float bb=lerp(brightboost1,brightboost2,mx)* dark_compensate; color*=bb;
	float3 Ref=T08.SampleLevel(sLin,pos,0).rgb;
	float maxb=T13.SampleLevel(sLin,pos,0).a;
	float vig =T02.SampleLevel(sLin,clamp(pos,0.0+0.5*OrgSize.zw,1.0-0.5*OrgSize.zw),0).a;
	if(pr_scan > 0.025)
	{
		float mbl = max(max(Bloom.r,Bloom.g),Bloom.b);
		Bloom = lerp(Bloom, lerp(Bloom, plant(orig1,mbl), min(2.5*(1.0-w3),1.0)), min(2.0*pr_scan, 1.0));
	}	
	float3 bcmask=lerp(one,dmask,b_mask);
	float3 hcmask=lerp(one,dmask,h_mask);
	float3 Bloomy=Bloom;
	if(abs(blm_1)>0.025)
	{
	if(blm_1<-0.01)Bloomy=plant(Bloom,maxb);
	Bloomy= min(Bloomy*(orig1+color),max(0.5*(colmx+orig1-color),0.001*Bloomy));
	Bloomy=0.5*(Bloomy+lerp(Bloomy,lerp(colmx*orig1,Bloomy,0.5),1.0-color));
	Bloomy= bcmask*Bloomy*max(lerp(1.0,2.0-colmx,bloom_dist),0);
	color=pow(pow(color,mask_gamma/gamma_in)+abs(blm_1)*pow( Bloomy,mask_gamma/gamma_in),gamma_in/mask_gamma);
	}
	if(halation> 0.01)
	{
	Bloom= 0.5*(Bloom+Bloom*Bloom);float mbl=max(max(Bloom.r,Bloom.g),Bloom.b);float mxh=0.5*(colmx+colmx*colmx);
	mbl=lerp(lerp(mxh,lerp( mxh,mbl,mbl),colmx),mbl,mb);
	Bloom=plant(Bloom,lerp(sqrt(mbl*mxh),max((mbl-0.15*(1.0-colmx)),0.4*mxh),pow(colmx,0.25)))*lerp(0.425,1.0,colmx);
	Bloom=(3.0-colmx-color)*plant(0.325+orig1/w3,0.5*(1.0+w3))*hcmask*Bloom;
	color=pow(pow(color,mask_gamma/gamma_in)+ halation *pow( Bloom ,mask_gamma/gamma_in),gamma_in/mask_gamma);
	}else
	if(halation<-0.01)
	{
	float mbl=max(max(Bloom.r,Bloom.g),Bloom.b);
	Bloom=plant(Bloom+Ref+orig1+Bloom*Bloom*Bloom,min(mbl*mbl,0.75));
	Bloom = 2.0*lerp(1.0,w3,0.5*colmx)*hcmask*Bloom;
	color = color -halation*Bloom;
	}
	color=min(color,1.0);
	color=gc2(color,w3 );
	if(smoothmask>0.125){float w4=pow(w3,0.425+0.3*smoothmask);w4=max(w4-0.175*colmx*smoothmask,0.2);color=lerp(min(color/w4,plant(orig1,1.0+0.175*colmx*smoothmask))*w4,color,w4);}
	if(m_glow<0.5)Glow=lerp(Glow,0.25*color,colmx);else
	{
	float3 orig2=plant(orig1+0.001*Ref,1.0); maxb=max(max(Glow.r,Glow.g),Glow.b);
	Bloom=plant(Glow,1.0);Ref=abs(orig2-Bloom);
	mx0=max(max(orig2.r,orig2.g),orig2.b)-min(min(orig2.r,orig2.g),orig2.b);
	mx2=max(max(Bloom.r,Bloom.g),Bloom.b)-min(min(Bloom.r,Bloom.g),Bloom.b);
	Bloom=lerp(maxb*min(Bloom,orig2),lerp(lerp(Glow,max(max(Ref.r,Ref.g),Ref.b)*Glow,max(mx,mx0)),lerp(color,Glow,mx2),max(mx0,mx2)*Ref),min(sqrt((1.10-mx0)*(0.10+mx2)),1.0));
	if(m_glow>1.5)Glow=lerp(0.5*Glow*Glow,Bloom,Bloom);
	Glow=lerp(m_glow_low*Glow,m_glow_high*Bloom,pow(colmx,m_glow_dist/gamma_in));
	}
	if(m_glow<0.5)
	{
	if(glow >=0.0)color=color+0.5*Glow*glow;else color=color+abs(glow)*min(emask*emask,1.0)*Glow;}else
	{
	float3 fmask=clamp(lerp(one,dmask,m_glow_mask),0.0,1.0);
	color=color+abs(glow)*fmask*Glow;
	}
	color=min(color,1.0);
	if(edgemask>0.05)
	{
	mx0=T14.SampleLevel(sLin,pos1-dx,0).a;mx0=T14.SampleLevel(sLin,pos1-dx*(1.0-0.75*sqrt(mx0)),0).a;
	mx2=T14.SampleLevel(sLin,pos1+dx,0).a;mx2=T14.SampleLevel(sLin,pos1+dx*(1.0-0.75*sqrt(mx2)),0).a;
	float mx3=T14.SampleLevel(sLin,pos1-4.0*dx,0).a;
	float mx4=T14.SampleLevel(sLin,pos1+4.0*dx,0).a;
	mx4=max(pow(abs(mx3-mx4),0.55-0.40*cx),min(max(mx3,mx4)/min(0.1+cx,1.0),1.0));
	mb=(1.0-abs(pow(mx0,1.0-0.65*mx2)-pow(mx2,1.0-0.65*mx0)));
	mb=mx4*edgemask*(1.0001-mb*mb);float3 temp=lerp(color,orig1,mb);
	color=max(temp+lerp(3.5*mb*lerp(1.625*temp,temp,cx),0.0.xxx,pow(color,0.75.xxx -0.5*colmx)),color);
	}
	color=color* lerp(1.0,lerp(0.5*(1.0+w3),w3,mx),pr_scan);
	color=min(color,max(orig1,color)*lerp(one,dmask,mclip));
	color=pow(color,1.0/gamma_o);
	float q=0.6*sqrt(max(max(color.r,color.g),color.b))+0.4;
	if(abs(addnoised)>0.01)
	{
	float3 noise0=jnoise(float3(floor(NewSize.xy*fuxcoord/noiseresd),float(framecount)));
	if(noisetype<0.5)color=lerp(color,noise0,0.25*abs(addnoised)*q);else
	color=min(color* lerp(1.0,1.5*noise0.x,0.5*abs(addnoised)),1.0);
	}
	colmx=max(max(orig1.r,orig1.g),orig1.b);
	color=color+bmask*lerp(emask,0.125*(1.0-colmx)*color,min(20.0*colmx,1.0));
	return lerp(float4(color*vig*humbars(lerp(pos.y, pos.x, bardir))*post_br*corner(posb), 1.0), 
	            INPUT.SampleLevel(sPt, (floor(pos1*OrgSize.xy)+0.5)*OrgSize.zw,0), step(pos1.x,oimage-0.00025));
}
