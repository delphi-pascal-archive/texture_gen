unit StackList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Tex, Mainu;

type
  TDStack = class(TForm)
    DCombo: TComboBox;
    Label1: TLabel;
    ChButton: TButton;
    DelButton: TButton;
    OKButton: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure ChButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DStack: TDStack;

implementation

uses SubPlasma, CBoard, Mandel, SinePlasma, PerlinNoise, Particle, Cell,
  Blob, ScelRGB, ScelHSV, AdjRGB, AdjHSV, Wood, MotionB, MakeTile, SineD,
  Twirl, Move, Kaleid, Tunnel, SineRGB, NoiseD;

{$R *.DFM}

procedure TDStack.OKButtonClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TDStack.ChButtonClick(Sender: TObject);
 var x : longint;
begin
  Main.Change_Flag:=DCombo.ItemIndex;
  case stuffOnLayers[Main.activeLayer].nr[DCombo.ItemIndex] of
      R_SUB_PLASMA : SubPlasmaForm.showmodal;
      R_SINE_PLASMA : SinePlasmaForm.showmodal;
      R_PERLIN_NOISE : PerlinNoiseForm.showmodal;
      R_PARTICLE : ParticleForm.showmodal;
      R_COLOR : ;
      R_CBOARD : CBoardForm.showmodal;
      R_BLOBS : BlobForm.showmodal;
      R_MANDEL : MandelForm.showmodal;
      R_CELLM : CellForm.showmodal;

      COL_SCALE_RGB : ScaleRGBForm.showmodal;
      COL_SCALE_HSV : ScaleHSVForm.showmodal;
      COL_ADJUST_RGB : AdjRGBForm.showmodal;
      COL_ADJUST_HSV : AdjHSVForm.showmodal;
      COL_SINE_RGB : SineRGBForm.showmodal;
      COL_EQUALIZE : ;
      COL_STRETCH : ;

      F_INVERT : ;
      F_EMBOSS : ;
      F_WOOD : WoodForm.showmodal;
      F_BLUR : ;
      F_SHARPEN : ;
      F_HEDGE : ;
      F_VEDGE : ;
      F_MOTION_BLUR : MotionBForm.showmodal;
      F_MAKE_TILABLE : MakeTileForm.showmodal;
      F_MEDIAN : ;
      F_DILATE : ;
      F_ERODE : ;

      D_SINE : SineDForm.showmodal;
      D_TWIRL : TwirlForm.showmodal;
      D_TILE : ;
      D_NOISE : NoiseDForm.showmodal;
      D_MOVE : MoveForm.showmodal;
      D_KALEID : KaleidForm.showmodal;
      D_TUNNEL : TunnelForm.showmodal;
      D_SCULPTURE : ;
      D_LOGPOL : ;
  end;
  Main.Change_Flag:=-1;

  for x:=0 to stuffOnLayers[Main.activeLayer].num-1 do
   doOneStuff(stuffOnLayers[Main.activeLayer].nr[x],stuffOnLayers[Main.activeLayer].param[x]);
  Main.ReLoadActive;
end;

procedure TDStack.DelButtonClick(Sender: TObject);
 var x : longint;
begin
  if (DCombo.ItemIndex<stuffOnLayers[Main.activeLayer].num) then dec(stuffOnLayers[Main.activeLayer].num);
  dec(max_numStuff[Main.activeLayer]);

  for x:=DCombo.ItemIndex to max_numStuff[Main.activeLayer]-1 do begin
   stuffOnLayers[Main.activeLayer].nr[x]:=stuffOnLayers[Main.activeLayer].nr[x+1];
   stuffOnLayers[Main.activeLayer].param[x]:=stuffOnLayers[Main.activeLayer].param[x+1];
  end;

  if (stuffOnLayers[Main.activeLayer].num=0) then begin
   DCombo.Clear;
   DCombo.Enabled:=false;
   ChButton.Enabled:=false;
   DelButton.Enabled:=false;
   colorLayer(Main.activeLayer,0,0,0);
  end else begin
   if (DCombo.ItemIndex=0) then colorLayer(Main.activeLayer,0,0,0);

   for x:=0 to stuffOnLayers[Main.activeLayer].num-1 do
    doOneStuff(stuffOnLayers[Main.activeLayer].nr[x],stuffOnLayers[Main.activeLayer].param[x]);

   DCombo.Items.Delete(DCombo.ItemIndex);
   DCombo.ItemIndex:=0;
  end;
  Main.ReLoadActive;
end;

end.
