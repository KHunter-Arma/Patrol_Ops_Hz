/*
	Copyright © 2010,International Development & Integration Systems, LLC
	All rights reserved.
	http://www.idi-systems.com/

	For personal use only. Military or commercial use is STRICTLY
	prohibited. Redistribution or modification of source code is 
	STRICTLY prohibited.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
	FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
	COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES INCLUDING,
	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
	ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
	POSSIBILITY OF SUCH DAMAGE.
*/

#define RADIO_WEAPON_LIST_STR(CLASSNAME) 	QUOTE(CLASSNAME),					\
											QUOTE(DOUBLES(CLASSNAME,ID_1)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_2)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_3)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_4)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_5)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_6)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_7)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_8)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_9)),		\
											QUOTE(DOUBLES(CLASSNAME,ID_10)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_11)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_12)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_13)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_14)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_15)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_16)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_17)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_18)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_19)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_20)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_21)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_22)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_23)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_24)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_25)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_26)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_27)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_28)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_29)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_30)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_31)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_32)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_33)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_34)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_35)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_36)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_37)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_38)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_39)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_40)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_41)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_42)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_43)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_44)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_45)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_46)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_47)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_48)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_49)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_50)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_51)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_52)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_53)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_54)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_55)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_56)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_57)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_58)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_59)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_60)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_61)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_62)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_63)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_64)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_65)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_66)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_67)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_68)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_69)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_70)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_71)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_72)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_73)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_74)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_75)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_76)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_77)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_78)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_79)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_80)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_81)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_82)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_83)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_84)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_85)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_86)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_87)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_88)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_89)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_90)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_91)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_92)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_93)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_94)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_95)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_96)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_97)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_98)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_99)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_100)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_101)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_102)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_103)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_104)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_105)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_106)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_107)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_108)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_109)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_110)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_111)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_112)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_113)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_114)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_115)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_116)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_117)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_118)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_119)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_120)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_121)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_122)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_123)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_124)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_125)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_126)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_127)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_128)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_129)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_130)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_131)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_132)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_133)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_134)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_135)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_136)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_137)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_138)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_139)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_140)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_141)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_142)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_143)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_144)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_145)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_146)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_147)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_148)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_149)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_150)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_151)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_152)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_153)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_154)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_155)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_156)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_157)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_158)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_159)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_160)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_161)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_162)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_163)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_164)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_165)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_166)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_167)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_168)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_169)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_170)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_171)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_172)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_173)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_174)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_175)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_176)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_177)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_178)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_179)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_180)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_181)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_182)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_183)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_184)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_185)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_186)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_187)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_188)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_189)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_190)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_191)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_192)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_193)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_194)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_195)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_196)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_197)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_198)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_199)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_200)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_201)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_202)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_203)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_204)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_205)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_206)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_207)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_208)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_209)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_210)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_211)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_212)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_213)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_214)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_215)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_216)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_217)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_218)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_219)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_220)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_221)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_222)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_223)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_224)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_225)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_226)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_227)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_228)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_229)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_230)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_231)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_232)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_233)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_234)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_235)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_236)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_237)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_238)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_239)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_240)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_241)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_242)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_243)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_244)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_245)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_246)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_247)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_248)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_249)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_250)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_251)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_252)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_253)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_254)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_255)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_256)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_257)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_258)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_259)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_260)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_261)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_262)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_263)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_264)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_265)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_266)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_267)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_268)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_269)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_270)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_271)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_272)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_273)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_274)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_275)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_276)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_277)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_278)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_279)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_280)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_281)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_282)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_283)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_284)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_285)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_286)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_287)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_288)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_289)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_290)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_291)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_292)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_293)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_294)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_295)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_296)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_297)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_298)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_299)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_300)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_301)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_302)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_303)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_304)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_305)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_306)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_307)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_308)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_309)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_310)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_311)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_312)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_313)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_314)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_315)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_316)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_317)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_318)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_319)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_320)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_321)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_322)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_323)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_324)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_325)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_326)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_327)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_328)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_329)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_330)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_331)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_332)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_333)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_334)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_335)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_336)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_337)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_338)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_339)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_340)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_341)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_342)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_343)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_344)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_345)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_346)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_347)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_348)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_349)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_350)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_351)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_352)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_353)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_354)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_355)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_356)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_357)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_358)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_359)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_360)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_361)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_362)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_363)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_364)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_365)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_366)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_367)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_368)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_369)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_370)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_371)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_372)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_373)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_374)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_375)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_376)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_377)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_378)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_379)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_380)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_381)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_382)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_383)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_384)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_385)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_386)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_387)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_388)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_389)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_390)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_391)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_392)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_393)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_394)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_395)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_396)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_397)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_398)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_399)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_400)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_401)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_402)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_403)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_404)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_405)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_406)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_407)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_408)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_409)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_410)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_411)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_412)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_413)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_414)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_415)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_416)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_417)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_418)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_419)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_420)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_421)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_422)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_423)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_424)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_425)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_426)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_427)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_428)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_429)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_430)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_431)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_432)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_433)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_434)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_435)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_436)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_437)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_438)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_439)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_440)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_441)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_442)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_443)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_444)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_445)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_446)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_447)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_448)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_449)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_450)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_451)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_452)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_453)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_454)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_455)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_456)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_457)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_458)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_459)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_460)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_461)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_462)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_463)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_464)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_465)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_466)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_467)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_468)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_469)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_470)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_471)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_472)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_473)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_474)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_475)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_476)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_477)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_478)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_479)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_480)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_481)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_482)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_483)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_484)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_485)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_486)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_487)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_488)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_489)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_490)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_491)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_492)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_493)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_494)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_495)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_496)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_497)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_498)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_499)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_500)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_501)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_502)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_503)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_504)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_505)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_506)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_507)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_508)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_509)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_510)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_511)),	\
											QUOTE(DOUBLES(CLASSNAME,ID_512))


#define RADIO_ID_LIST(CLASSNAME) 	class DOUBLES(CLASSNAME,ID_1) : CLASSNAME {\
										class Armory { disabled = 1; }; \
									};\
									class DOUBLES(CLASSNAME,ID_2) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_3) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_4) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_5) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_6) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_7) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_8) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_9) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_10) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_11) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_12) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_13) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_14) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_15) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_16) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_17) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_18) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_19) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_20) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_21) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_22) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_23) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_24) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_25) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_26) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_27) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_28) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_29) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_30) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_31) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_32) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_33) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_34) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_35) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_36) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_37) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_38) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_39) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_40) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_41) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_42) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_43) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_44) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_45) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_46) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_47) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_48) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_49) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_50) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_51) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_52) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_53) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_54) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_55) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_56) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_57) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_58) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_59) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_60) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_61) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_62) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_63) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_64) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_65) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_66) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_67) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_68) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_69) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_70) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_71) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_72) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_73) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_74) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_75) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_76) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_77) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_78) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_79) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_80) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_81) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_82) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_83) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_84) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_85) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_86) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_87) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_88) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_89) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_90) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_91) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_92) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_93) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_94) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_95) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_96) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_97) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_98) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_99) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_100) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_101) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_102) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_103) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_104) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_105) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_106) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_107) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_108) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_109) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_110) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_111) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_112) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_113) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_114) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_115) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_116) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_117) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_118) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_119) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_120) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_121) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_122) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_123) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_124) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_125) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_126) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_127) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_128) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_129) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_130) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_131) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_132) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_133) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_134) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_135) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_136) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_137) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_138) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_139) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_140) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_141) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_142) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_143) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_144) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_145) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_146) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_147) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_148) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_149) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_150) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_151) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_152) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_153) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_154) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_155) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_156) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_157) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_158) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_159) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_160) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_161) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_162) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_163) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_164) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_165) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_166) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_167) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_168) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_169) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_170) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_171) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_172) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_173) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_174) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_175) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_176) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_177) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_178) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_179) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_180) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_181) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_182) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_183) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_184) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_185) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_186) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_187) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_188) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_189) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_190) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_191) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_192) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_193) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_194) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_195) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_196) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_197) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_198) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_199) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_200) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_201) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_202) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_203) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_204) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_205) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_206) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_207) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_208) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_209) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_210) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_211) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_212) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_213) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_214) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_215) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_216) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_217) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_218) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_219) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_220) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_221) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_222) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_223) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_224) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_225) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_226) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_227) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_228) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_229) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_230) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_231) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_232) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_233) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_234) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_235) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_236) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_237) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_238) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_239) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_240) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_241) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_242) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_243) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_244) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_245) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_246) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_247) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_248) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_249) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_250) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_251) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_252) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_253) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_254) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_255) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_256) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_257) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_258) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_259) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_260) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_261) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_262) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_263) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_264) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_265) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_266) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_267) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_268) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_269) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_270) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_271) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_272) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_273) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_274) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_275) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_276) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_277) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_278) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_279) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_280) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_281) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_282) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_283) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_284) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_285) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_286) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_287) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_288) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_289) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_290) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_291) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_292) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_293) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_294) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_295) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_296) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_297) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_298) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_299) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_300) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_301) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_302) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_303) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_304) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_305) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_306) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_307) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_308) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_309) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_310) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_311) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_312) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_313) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_314) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_315) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_316) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_317) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_318) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_319) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_320) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_321) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_322) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_323) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_324) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_325) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_326) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_327) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_328) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_329) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_330) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_331) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_332) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_333) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_334) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_335) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_336) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_337) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_338) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_339) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_340) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_341) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_342) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_343) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_344) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_345) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_346) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_347) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_348) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_349) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_350) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_351) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_352) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_353) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_354) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_355) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_356) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_357) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_358) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_359) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_360) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_361) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_362) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_363) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_364) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_365) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_366) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_367) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_368) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_369) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_370) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_371) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_372) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_373) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_374) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_375) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_376) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_377) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_378) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_379) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_380) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_381) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_382) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_383) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_384) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_385) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_386) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_387) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_388) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_389) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_390) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_391) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_392) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_393) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_394) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_395) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_396) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_397) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_398) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_399) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_400) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_401) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_402) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_403) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_404) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_405) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_406) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_407) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_408) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_409) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_410) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_411) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_412) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_413) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_414) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_415) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_416) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_417) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_418) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_419) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_420) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_421) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_422) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_423) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_424) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_425) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_426) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_427) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_428) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_429) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_430) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_431) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_432) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_433) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_434) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_435) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_436) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_437) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_438) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_439) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_440) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_441) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_442) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_443) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_444) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_445) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_446) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_447) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_448) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_449) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_450) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_451) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_452) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_453) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_454) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_455) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_456) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_457) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_458) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_459) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_460) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_461) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_462) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_463) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_464) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_465) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_466) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_467) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_468) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_469) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_470) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_471) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_472) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_473) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_474) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_475) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_476) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_477) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_478) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_479) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_480) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_481) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_482) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_483) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_484) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_485) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_486) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_487) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_488) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_489) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_490) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_491) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_492) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_493) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_494) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_495) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_496) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_497) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_498) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_499) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_500) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_501) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_502) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_503) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_504) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_505) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_506) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_507) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_508) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_509) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_510) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_511) : CLASSNAME {\
										class Armory { disabled = 1; };\
									};\
									class DOUBLES(CLASSNAME,ID_512) : CLASSNAME {\
									};