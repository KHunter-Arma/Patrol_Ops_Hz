#define ACE_OPTICS_DEFAULT opticsZoomMin = 0.25; opticsZoomMax = 1.1; opticsZoomInit = 0.5
#define ACE_OPTICS_REMOVE ACE_OPTICS_DEFAULT; optics = 1; modelOptics = "-"

#define ACE_SCOPE_BLUR1 opticsPPEffects[] = {"OpticsCHAbera1", "OpticsBlur1"}
#define ACE_SCOPE_BLUR2 opticsPPEffects[] = {"OpticsCHAbera2", "OpticsBlur2"}
#define ACE_SCOPE_BLUR3 opticsPPEffects[] = {"OpticsCHAbera3", "OpticsBlur3"}
#define ACE_NO_SCOPE_BLUR opticsPPEffects[] = {}

#define ACE_OpticsZoom_4x	opticsZoomMin = 0.071945; opticsZoomMax = 0.071945; opticsZoomInit = 0.071945
#define ACE_OpticsZoom_3x	opticsZoomMin = 0.095903; opticsZoomMax = 0.095903; opticsZoomInit = 0.095903
#define ACE_OpticsZoom_3p4x	opticsZoomMin = 0.085333; opticsZoomMax = 0.085333; opticsZoomInit = 0.085333
#define ACE_OpticsZoom_3p5x	opticsZoomMin = 0.085333; opticsZoomMax = 0.085333; opticsZoomInit = 0.085333
#define ACE_OpticsZoom_cqb4x opticsZoomMin = 0.071945; opticsZoomMax = 0.22; opticsZoomInit = 0.22
#define ACE_OpticsZoom_10x opticsZoomMin = 0.029624; opticsZoomMax = 0.029624; opticsZoomInit = 0.029624
#define ACE_OpticsZoom_8pt5x opticsZoomMin = 0.033574; opticsZoomMax = 0.033574; opticsZoomInit = 0.033574
#define ACE_OpticsZoom_3_12x opticsZoomMin = 0.0256; opticsZoomMax = 0.082; opticsZoomInit = 0.082
#define ACE_OpticsZoom_Mk12 opticsZoomMin = 0.029624; opticsZoomMax = 0.085714; opticsZoomInit = 0.085714
#define ACE_OpticsZoom_TMR opticsZoomMin = 0.033574; opticsZoomMax = 0.087666; opticsZoomInit = 0.087666

#define ACE_modelOptics_ACOGTA31 modelOptics = "\x\ace\addons\m_wep_optics\ACE_acog_ta31rco"
#define ACE_modelOptics_ACOGTA01 modelOptics = "\x\ace\addons\m_wep_optics\NWD_acog_ta01nsn"
#define ACE_modelOptics_ACOGTA31DOC modelOptics = "\x\ace\addons\m_wep_optics\ACE_acog_ta31doc"
#define ACE_modelOptics_ACOGTA31ECOS modelOptics = "\x\ace\addons\m_wep_optics\ACE_acog_ta31ecos"
#define ACE_modelOptics_ShortDot modelOptics = "\x\ace\addons\m_wep_optics\SB_CQB_optic_4x"
#define ACE_modelOptics_COLT4X modelOptics = "\x\ace\addons\m_wep_optics\ACE_optics_colt4X"
#define ACE_modelOptics_M145 modelOptics = "\x\ace\addons\m_wep_optics\ace_optics_m145"
#define ACE_modelOptics_G36 modelOptics = "\x\ace\addons\m_wep_optics\NWD_G36_optics_wide"
#define ACE_modelOptics_SB312X modelOptics = "\x\ace\addons\m_wep_optics\NWD_12x_gen2_mildot"
#define ACE_modelOptics_SpecterDR modelOptics = "\Ca\weapons_E\SCAR\SpecterDR_556_optic_4x"
#define ACE_modelOptics_PSO1AK modelOptics = "\x\ace\addons\m_wep_optics\NWD_PSO_1_1_AK74"
#define ACE_modelOptics_1P29 modelOptics = "\x\ace\addons\m_wep_optics\ACE_optics_1P29"
#define ACE_modelOptics_1P78 modelOptics = "\x\ace\addons\m_wep_optics\ACE_1P78"
#define ACE_modelOptics_1PN100 modelOptics = "\x\ace\addons\m_wep_optics\ACE_1pn100"
#define ACE_modelOptics_Goshawk modelOptics = "\Ca\weapons_E\TI_goshawk_optic"
#define ACE_modelOptics_NSPU modelOptics = "\Ca\weapons_E\NV_nspu_optic"
#define ACE_modelOptics_SUSAT modelOptics = "\x\ace\addons\m_wep_optics\ukf_susat3"
#define ACE_modelOptics_Leu10X modelOptics = "\x\ace\addons\m_wep_optics\NWD_10x_round_mildot"
#define ACE_modelOptics_Leu14X modelOptics = "\x\ace\addons\m_wep_optics\NWD_14x_oval_mildot"

#define ACE_ZEROING_PSO discreteDistance[] = {100,200,300,400,500,600,700,800,900,1000}; discreteDistanceInitIndex = 2
#define ACE_ZEROING_1P29 discreteDistance[] = {400,500,600,700,800,900,1000}; discreteDistanceInitIndex = 0
#define ACE_ZEROING_SUSAT discreteDistance[] = {300,400,500,600,700,800}; discreteDistanceInitIndex = 0

#define ACE_SCOPE_COMMON_VALUES(scope,dscope,zscope,blur,mpcam) \
				opticsID = 1; \
				distanceZoomMin = ##dscope; \
				distanceZoomMax = ##dscope; \
				##zscope; \
				opticsPPEffects[] = {QUOTE(OpticsCHAbera##blur), QUOTE(OpticsBlur##blur)}; \
				useModelOptics = 1; \
				memoryPointCamera = QUOTE(##mpcam); \
				visionMode[] = {QUOTE(Normal)}; \
				opticsFlare = 1; \
				opticsDisablePeripherialVision = 1; \
				cameraDir = ""

#define ACE_NOZEROING_SCOPE_OPTICSMODE(scope,dscope,zscope,blur,mpcam) \
			class ##scope { \
				ACE_SCOPE_COMMON_VALUES(scope,dscope,zscope,blur,mpcam); \
				ACE_NOZEROING; \
			};

#define ACE_NOZEROING_CQB_OPTICSMODE(cqb,scope,dcqb,mpcam) \
			class ##cqb : ##scope { \
				opticsID = 2; \
				distanceZoomMin = ##dcqb; \
				distanceZoomMax = ##dcqb; \
				ACE_OPTICS_DEFAULT; \
				ACE_NO_SCOPE_BLUR; \
				useModelOptics = 0; \
				memoryPointCamera = QUOTE(##mpcam); \
				visionMode[] = {}; \
				opticsFlare = 0; \
				opticsDisablePeripherialVision = 0; \
				ACE_NOZEROING; \
			}

#define ACE_NOZEROING_NOCQB_OPTICSMODES(scope,dscope,zscope,blur,mpcam) \
		class OpticsModes { \
			ACE_NOZEROING_SCOPE_OPTICSMODE(scope,dscope,zscope,blur,mpcam); \
		}

#define ACE_PSO_NOCQB_OPTICSMODES(scope,dscope,zscope,blur,mpcam) \
		class OpticsModes { \
			class ##scope { \
				ACE_SCOPE_COMMON_VALUES(scope,dscope,zscope,blur,mpcam); \
				ACE_ZEROING_PSO; \
			}; \
		}

#define ACE_PSO_OPTICSMODES(scope,cqb,dscope,dcqb,zscope,blur,mpcam) \
		class OpticsModes { \
			class ##scope { \
				ACE_SCOPE_COMMON_VALUES(scope,dscope,zscope,blur,mpcam); \
				ACE_ZEROING_PSO; \
			}; \
			ACE_NOZEROING_CQB_OPTICSMODE(cqb,scope,dcqb,eye); \
		}

#define ACE_1P29_OPTICSMODES(scope,cqb,dscope,dcqb,zscope,blur,mpcam) \
		class OpticsModes { \
			class ##scope { \
				ACE_SCOPE_COMMON_VALUES(scope,dscope,zscope,blur,mpcam); \
				ACE_ZEROING_1P29; \
			}; \
			ACE_NOZEROING_CQB_OPTICSMODE(cqb,scope,dcqb,eye); \
		}

#define ACE_SUSAT_OPTICSMODES(scope,cqb,dscope,dcqb,zscope,blur,mpcam) \
		class OpticsModes { \
			class ##scope { \
				ACE_SCOPE_COMMON_VALUES(scope,dscope,zscope,blur,mpcam); \
				ACE_ZEROING_SUSAT; \
			}; \
			ACE_NOZEROING_CQB_OPTICSMODE(cqb,scope,dcqb,eye); \
		}

#define ACE_NOZEROING_OPTICSMODES(scope,cqb,dscope,dcqb,zscope,blur,mpcam) \
		class OpticsModes { \
			ACE_NOZEROING_SCOPE_OPTICSMODE(scope,dscope,zscope,blur,mpcam); \
			ACE_NOZEROING_CQB_OPTICSMODE(cqb,scope,dcqb,eye); \
		}

#define ACE_OPTICSMODES(scope,cqb,dscope,dcqb,zscope,blur) ACE_NOZEROING_OPTICSMODES(scope,cqb,dscope,dcqb,zscope,blur,opticView)
