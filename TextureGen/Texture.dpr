program Texture;

uses
  Forms,
  MainU in 'MainU.pas' {Main},
  Tex in 'Tex.pas',
  Layer0 in 'Layer0.pas' {Layer0Form},
  Layer1 in 'Layer1.pas' {Layer1Form},
  Layer2 in 'Layer2.pas' {Layer2Form},
  Layer3 in 'Layer3.pas' {Layer3Form},
  FLayer in 'FLayer.pas' {FLayerForm},
  SubPlasma in 'SubPlasma.pas' {SubPlasmaForm},
  SinePlasma in 'SinePlasma.pas' {SinePlasmaForm},
  PerlinNoise in 'PerlinNoise.pas' {PerlinNoiseForm},
  Particle in 'Particle.pas' {ParticleForm},
  Wood in 'Wood.pas' {WoodForm},
  SineD in 'SineD.pas' {SineDForm},
  Twirl in 'Twirl.pas' {TwirlForm},
  ScelRGB in 'ScelRGB.pas' {ScaleRGBForm},
  ScelHSV in 'ScelHSV.pas' {ScaleHSVForm},
  SineRGB in 'SineRGB.pas' {SineRGBForm},
  AdjRGB in 'AdjRGB.pas' {AdjRGBForm},
  AdjHSV in 'AdjHSV.pas' {AdjHSVForm},
  About in 'About.pas' {AboutForm},
  NoiseD in 'NoiseD.pas' {NoiseDForm},
  CBoard in 'CBoard.pas' {CBoardForm},
  Move in 'Move.pas' {MoveForm},
  Kaleid in 'Kaleid.pas' {KaleidForm},
  Blob in 'Blob.pas' {BlobForm},
  Tunnel in 'Tunnel.pas' {TunnelForm},
  MotionB in 'MotionB.pas' {MotionBForm},
  MakeTile in 'MakeTile.pas' {MakeTileForm},
  Mandel in 'Mandel.pas' {MandelForm},
  Cell in 'Cell.pas' {CellForm},
  StackList in 'StackList.pas' {DStack};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TLayer0Form, Layer0Form);
  Application.CreateForm(TLayer1Form, Layer1Form);
  Application.CreateForm(TLayer2Form, Layer2Form);
  Application.CreateForm(TLayer3Form, Layer3Form);
  Application.CreateForm(TFLayerForm, FLayerForm);
  Application.CreateForm(TSubPlasmaForm, SubPlasmaForm);
  Application.CreateForm(TSinePlasmaForm, SinePlasmaForm);
  Application.CreateForm(TPerlinNoiseForm, PerlinNoiseForm);
  Application.CreateForm(TParticleForm, ParticleForm);
  Application.CreateForm(TWoodForm, WoodForm);
  Application.CreateForm(TSineDForm, SineDForm);
  Application.CreateForm(TTwirlForm, TwirlForm);
  Application.CreateForm(TScaleRGBForm, ScaleRGBForm);
  Application.CreateForm(TScaleHSVForm, ScaleHSVForm);
  Application.CreateForm(TSineRGBForm, SineRGBForm);
  Application.CreateForm(TAdjRGBForm, AdjRGBForm);
  Application.CreateForm(TAdjHSVForm, AdjHSVForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TNoiseDForm, NoiseDForm);
  Application.CreateForm(TCBoardForm, CBoardForm);
  Application.CreateForm(TMoveForm, MoveForm);
  Application.CreateForm(TKaleidForm, KaleidForm);
  Application.CreateForm(TBlobForm, BlobForm);
  Application.CreateForm(TTunnelForm, TunnelForm);
  Application.CreateForm(TMotionBForm, MotionBForm);
  Application.CreateForm(TMakeTileForm, MakeTileForm);
  Application.CreateForm(TMandelForm, MandelForm);
  Application.CreateForm(TCellForm, CellForm);
  Application.CreateForm(TDStack, DStack);
  Application.Run;
end.
