unit MainU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Tex,
  StdCtrls, ExtCtrls, Spin, Menus;

type
  TMain = class(TForm)
    RenderGroup: TGroupBox;
    SubPlasmaButton: TButton;
    SinePlasmaButton: TButton;
    PerlinNoiseButton: TButton;
    ParticleButton: TButton;
    ColorButton: TButton;
    LayerOptionsGroup: TGroupBox;
    Layer0_1Combine: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Layer1_2Combine: TComboBox;
    Layer2_3Combine: TComboBox;
    Label3: TLabel;
    Perc0_01: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    Perc1_01: TSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    Perc0_12: TSpinEdit;
    Perc1_12: TSpinEdit;
    Perc0_23: TSpinEdit;
    Perc1_23: TSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    ColorGroup: TGroupBox;
    ScaleRGBButton: TButton;
    ScaleHSVButton: TButton;
    AdjustRGBButton: TButton;
    AdjustHSVButton: TButton;
    SineRGB: TButton;
    ColorDialog: TColorDialog;
    Filter: TGroupBox;
    EmbossButton: TButton;
    WoodButton: TButton;
    BlurButton: TButton;
    Distort: TGroupBox;
    SineDButton: TButton;
    TwirlButton: TButton;
    TileButton: TButton;
    Menu: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    About1: TMenuItem;
    SaveAsINC1: TMenuItem;
    SaveDialog: TSaveDialog;
    SaveAsBMP1: TMenuItem;
    SaveDialog2: TSaveDialog;
    ActiveLayerGroup: TGroupBox;
    ActiveLayerDD: TComboBox;
    SaveAsTEX1: TMenuItem;
    SaveDialog3: TSaveDialog;
    OpenDialog: TOpenDialog;
    OpenTEX1: TMenuItem;
    SharpenButton: TButton;
    HEdgeButton: TButton;
    VEdgeButton: TButton;
    RedoButton: TButton;
    ClearButton: TButton;
    NoiseDistButton: TButton;
    CBoardButton: TButton;
    MoveButton: TButton;
    EqualButton: TButton;
    StretchButton: TButton;
    KaleidButton: TButton;
    BlobButton: TButton;
    TunnelButton: TButton;
    MotionBButton: TButton;
    MakeTileButton: TButton;
    MedianButton: TButton;
    DilateButton: TButton;
    ErodeButton: TButton;
    UndoButton: TButton;
    SizeDD: TComboBox;
    Bevel1: TBevel;
    InvertButton: TButton;
    SculptureButton: TButton;
    LogPolButton: TButton;
    MandelButton: TButton;
    CellButton: TButton;
    StackButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SubPlasmaButtonClick(Sender: TObject);
    procedure SinePlasmaButtonClick(Sender: TObject);
    procedure PerlinNoiseButtonClick(Sender: TObject);
    procedure ParticleButtonClick(Sender: TObject);
    procedure ColorButtonClick(Sender: TObject);
    procedure Layer0_1CombineChange(Sender: TObject);
    procedure Layer1_2CombineChange(Sender: TObject);
    procedure Layer2_3CombineChange(Sender: TObject);
    procedure Perc0_01Change(Sender: TObject);
    procedure Perc1_01Change(Sender: TObject);
    procedure Perc0_12Change(Sender: TObject);
    procedure Perc1_12Change(Sender: TObject);
    procedure Perc0_23Change(Sender: TObject);
    procedure Perc1_23Change(Sender: TObject);
    procedure InvertButtonClick(Sender: TObject);
    procedure EmbossButtonClick(Sender: TObject);
    procedure WoodButtonClick(Sender: TObject);
    procedure BlurButtonClick(Sender: TObject);
    procedure SharpenButtonClick(Sender: TObject);
    procedure MedianButtonClick(Sender: TObject);
    procedure DilateButtonClick(Sender: TObject);
    procedure ErodeButtonClick(Sender: TObject);
    procedure HEdgeButtonClick(Sender: TObject);
    procedure VEdgeButtonClick(Sender: TObject);
    procedure TileButtonClick(Sender: TObject);
    procedure SineDButtonClick(Sender: TObject);
    procedure TwirlButtonClick(Sender: TObject);
    procedure ScaleRGBButtonClick(Sender: TObject);
    procedure ScaleHSVButtonClick(Sender: TObject);
    procedure SineRGBClick(Sender: TObject);
    procedure AdjustRGBButtonClick(Sender: TObject);
    procedure AdjustHSVButtonClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure SaveAsINC1Click(Sender: TObject);
    procedure SaveAsBMP1Click(Sender: TObject);
    procedure ActiveLayerDDChange(Sender: TObject);
    procedure SizeDDChange(Sender: TObject);
    procedure SaveAsTEX1Click(Sender: TObject);
    procedure OpenTEX1Click(Sender: TObject);
    procedure UndoButtonClick(Sender: TObject);
    procedure RedoButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure NoiseDistButtonClick(Sender: TObject);
    procedure CBoardButtonClick(Sender: TObject);
    procedure MoveButtonClick(Sender: TObject);
    procedure EqualButtonClick(Sender: TObject);
    procedure StretchButtonClick(Sender: TObject);
    procedure KaleidButtonClick(Sender: TObject);
    procedure BlobButtonClick(Sender: TObject);
    procedure MandelButtonClick(Sender: TObject);
    procedure CellButtonClick(Sender: TObject);
    procedure TunnelButtonClick(Sender: TObject);
    procedure MotionBButtonClick(Sender: TObject);
    procedure MakeTileButtonClick(Sender: TObject);
    procedure SculptureButtonClick(Sender: TObject);
    procedure LogPolButtonClick(Sender: TObject);
    procedure DStackButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    pic_sizex,pic_sizey : cardinal;
    activeLayer : cardinal;
    init_dirty_flag : boolean;
    change_flag : longint;
    procedure ReLoadActive;
  end;

var
  Main: TMain;

implementation

uses Layer0, Layer1, Layer2, Layer3, FLayer, SubPlasma, SinePlasma,
  PerlinNoise, Particle, Wood, SineD, Twirl, ScelRGB, ScelHSV, SineRGB,
  AdjRGB, AdjHSV, About, NoiseD, CBoard, Move, Kaleid, Blob, Tunnel,
  MotionB, MakeTile, Mandel, Cell, StackList;

{$R *.DFM}

procedure TMain.FormCreate(Sender: TObject);
begin
  pic_sizex := 256;
  pic_sizey := 256;

  init_dirty_flag:=true;
  change_flag:=-1;
end;

procedure TMain.FormActivate(Sender: TObject);
 Var tempparam : tsingarray;
begin
  if init_dirty_flag then begin
   init_dirty_flag:=false;

   randomize;

   Layer0_1Combine.ItemIndex:=0;
   Layer1_2Combine.ItemIndex:=0;
   Layer2_3Combine.ItemIndex:=0;

   initLayers(pic_sizex,pic_sizey);
   SizeDD.ItemIndex:=2;

   //
   tempparam[0]:=MAXLAYERS-1;
   tempparam[1]:=0;
   tempparam[2]:=0;
   tempparam[3]:=0;
   addOneStuff(MAXLAYERS-1,false,R_COLOR,tempparam,Change_Flag);

   tempparam[0]:=0;
   tempparam[1]:=1;
   tempparam[2]:=MAXLAYERS-1;
   tempparam[3]:=100.0/100.0;
   tempparam[4]:=100.0/100.0;
   addOneStuff(MAXLAYERS-1,false,C_ADD,tempparam,Change_Flag);

   tempparam[0]:=MAXLAYERS-1;
   tempparam[1]:=2;
   tempparam[2]:=MAXLAYERS-1;
   tempparam[3]:=100.0/100.0;
   tempparam[4]:=100.0/100.0;
   addOneStuff(MAXLAYERS-1,false,C_ADD,tempparam,Change_Flag);

   tempparam[0]:=MAXLAYERS-1;
   tempparam[1]:=3;
   tempparam[2]:=MAXLAYERS-1;
   tempparam[3]:=100.0/100.0;
   tempparam[4]:=100.0/100.0;
   addOneStuff(MAXLAYERS-1,false,C_ADD,tempparam,Change_Flag);
   //

   activeLayer:=0;
   ActiveLayerDD.ItemIndex:=0;
   Layer0Form.active:=true;
   Layer0Form.ReLoad;
   Layer1Form.active:=false;
   Layer1Form.ReLoad;
   Layer2Form.active:=false;
   Layer2Form.ReLoad;
   Layer3Form.active:=false;
   Layer3Form.ReLoad;

   FLayerForm.ReLoad;
  end;
end;


procedure TMain.ReLoadActive;
BEGIN
  case activeLayer of
   0 : Layer0Form.ReLoad;
   1 : Layer1Form.ReLoad;
   2 : Layer2Form.ReLoad;
   3 : Layer3Form.ReLoad;
  end;
  FLayerForm.ReLoad;
END;


procedure TMain.SubPlasmaButtonClick(Sender: TObject);
begin
  SubPlasmaForm.showmodal;
end;

procedure TMain.SinePlasmaButtonClick(Sender: TObject);
begin
  SinePlasmaForm.showmodal;
end;

procedure TMain.PerlinNoiseButtonClick(Sender: TObject);
begin
  PerlinNoiseForm.showmodal;
end;

procedure TMain.ParticleButtonClick(Sender: TObject);
begin
  ParticleForm.showmodal;
end;

procedure TMain.ColorButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  if ColorDialog.Execute then begin
   tempparam[0]:=activeLayer;
   tempparam[1]:=ColorDialog.Color and $FF;
   tempparam[2]:=(ColorDialog.Color shr 8) and $FF;
   tempparam[3]:=(ColorDialog.Color shr 16) and $FF;
   addOneStuff(activeLayer,true,R_COLOR,tempparam,Change_Flag);
   ReLoadActive;
  end;
end;

procedure TMain.Layer0_1CombineChange(Sender: TObject);
begin
  if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Add' then
   changeOneStuff(MAXLAYERS-1,1,C_ADD,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Mul' then
   changeOneStuff(MAXLAYERS-1,1,C_MUL,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Noise' then
   changeOneStuff(MAXLAYERS-1,1,C_RAND,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Max' then
   changeOneStuff(MAXLAYERS-1,1,C_MAX,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Min' then
   changeOneStuff(MAXLAYERS-1,1,C_MIN,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Xor' then
   changeOneStuff(MAXLAYERS-1,1,C_XOR,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Or' then
   changeOneStuff(MAXLAYERS-1,1,C_OR,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='And' then
   changeOneStuff(MAXLAYERS-1,1,C_AND,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Nothing' then
   changeOneStuff(MAXLAYERS-1,1,DO_NOTHING,stuffOnLayers[MAXLAYERS-1].param[1])
  else if Layer0_1Combine.Items[Layer0_1Combine.ItemIndex]='Distort' then
   changeOneStuff(MAXLAYERS-1,1,D_MAP,stuffOnLayers[MAXLAYERS-1].param[1]);

  FLayerForm.ReLoad;
end;

procedure TMain.Layer1_2CombineChange(Sender: TObject);
begin
  if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Add' then
   changeOneStuff(MAXLAYERS-1,2,C_ADD,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Mul' then
   changeOneStuff(MAXLAYERS-1,2,C_MUL,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Noise' then
   changeOneStuff(MAXLAYERS-1,2,C_RAND,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Max' then
   changeOneStuff(MAXLAYERS-1,2,C_MAX,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Min' then
   changeOneStuff(MAXLAYERS-1,2,C_MIN,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Xor' then
   changeOneStuff(MAXLAYERS-1,2,C_XOR,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='And' then
   changeOneStuff(MAXLAYERS-1,2,C_AND,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Or' then
   changeOneStuff(MAXLAYERS-1,2,C_OR,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Nothing' then
   changeOneStuff(MAXLAYERS-1,2,DO_NOTHING,stuffOnLayers[MAXLAYERS-1].param[2])
  else if Layer1_2Combine.Items[Layer1_2Combine.ItemIndex]='Distort' then
   changeOneStuff(MAXLAYERS-1,2,D_MAP,stuffOnLayers[MAXLAYERS-1].param[2]);

  FLayerForm.ReLoad;
end;

procedure TMain.Layer2_3CombineChange(Sender: TObject);
begin
  if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Add' then
   changeOneStuff(MAXLAYERS-1,3,C_ADD,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Mul' then
   changeOneStuff(MAXLAYERS-1,3,C_MUL,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Noise' then
   changeOneStuff(MAXLAYERS-1,3,C_RAND,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Max' then
   changeOneStuff(MAXLAYERS-1,3,C_MAX,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Min' then
   changeOneStuff(MAXLAYERS-1,3,C_MIN,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Xor' then
   changeOneStuff(MAXLAYERS-1,3,C_XOR,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='And' then
   changeOneStuff(MAXLAYERS-1,3,C_AND,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Or' then
   changeOneStuff(MAXLAYERS-1,3,C_OR,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Nothing' then
   changeOneStuff(MAXLAYERS-1,3,DO_NOTHING,stuffOnLayers[MAXLAYERS-1].param[3])
  else if Layer2_3Combine.Items[Layer2_3Combine.ItemIndex]='Distort' then
   changeOneStuff(MAXLAYERS-1,3,D_MAP,stuffOnLayers[MAXLAYERS-1].param[3]);

  FLayerForm.ReLoad;
end;

procedure TMain.Perc0_01Change(Sender: TObject);
begin
  stuffOnLayers[MAXLAYERS-1].param[1][3]:=Perc0_01.value/100.0;
  changeOneStuff(MAXLAYERS-1,1,stuffOnLayers[MAXLAYERS-1].nr[1],stuffOnLayers[MAXLAYERS-1].param[1]);

  FLayerForm.ReLoad;
end;

procedure TMain.Perc1_01Change(Sender: TObject);
begin
  stuffOnLayers[MAXLAYERS-1].param[1][4]:=Perc1_01.value/100.0;
  changeOneStuff(MAXLAYERS-1,1,stuffOnLayers[MAXLAYERS-1].nr[1],stuffOnLayers[MAXLAYERS-1].param[1]);

  FLayerForm.ReLoad;
end;

procedure TMain.Perc0_12Change(Sender: TObject);
begin
  stuffOnLayers[MAXLAYERS-1].param[2][3]:=Perc0_12.value/100.0;
  changeOneStuff(MAXLAYERS-1,2,stuffOnLayers[MAXLAYERS-1].nr[2],stuffOnLayers[MAXLAYERS-1].param[2]);

  FLayerForm.ReLoad;
end;

procedure TMain.Perc1_12Change(Sender: TObject);
begin
  stuffOnLayers[MAXLAYERS-1].param[2][4]:=Perc1_12.value/100.0;
  changeOneStuff(MAXLAYERS-1,2,stuffOnLayers[MAXLAYERS-1].nr[2],stuffOnLayers[MAXLAYERS-1].param[2]);

  FLayerForm.ReLoad;
end;

procedure TMain.Perc0_23Change(Sender: TObject);
begin
  stuffOnLayers[MAXLAYERS-1].param[3][3]:=Perc0_23.value/100.0;
  changeOneStuff(MAXLAYERS-1,3,stuffOnLayers[MAXLAYERS-1].nr[3],stuffOnLayers[MAXLAYERS-1].param[3]);

  FLayerForm.ReLoad;
end;

procedure TMain.Perc1_23Change(Sender: TObject);
begin
  stuffOnLayers[MAXLAYERS-1].param[3][4]:=Perc1_23.value/100.0;
  changeOneStuff(MAXLAYERS-1,3,stuffOnLayers[MAXLAYERS-1].nr[3],stuffOnLayers[MAXLAYERS-1].param[3]);

  FLayerForm.ReLoad;
end;

procedure TMain.InvertButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_INVERT,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.EmbossButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_EMBOSS,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.SculptureButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,D_SCULPTURE,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.MedianButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_MEDIAN,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.ErodeButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_ERODE,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.DilateButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_DILATE,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.WoodButtonClick(Sender: TObject);
begin
  WoodForm.showmodal;
end;

procedure TMain.MotionBButtonClick(Sender: TObject);
begin
  MotionBForm.showmodal;
end;

procedure TMain.MakeTileButtonClick(Sender: TObject);
begin
  MakeTileForm.showmodal;
end;

procedure TMain.KaleidButtonClick(Sender: TObject);
begin
  KaleidForm.showmodal;
end;

procedure TMain.BlobButtonClick(Sender: TObject);
begin
  BlobForm.showmodal;
end;

procedure TMain.MandelButtonClick(Sender: TObject);
begin
  MandelForm.showmodal;
end;

procedure TMain.CellButtonClick(Sender: TObject);
begin
  CellForm.showmodal;
end;

procedure TMain.BlurButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_BLUR,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.TunnelButtonClick(Sender: TObject);
begin
  TunnelForm.showmodal;
end;

procedure TMain.SharpenButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_SHARPEN,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.HEdgeButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_HEDGE,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.VEdgeButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,F_VEDGE,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.TileButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,D_TILE,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.EqualButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,COL_EQUALIZE,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.StretchButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,COL_STRETCH,tempparam,Change_Flag);
  ReLoadActive;
end;

procedure TMain.SineDButtonClick(Sender: TObject);
begin
  SineDForm.showmodal;
end;

procedure TMain.TwirlButtonClick(Sender: TObject);
begin
  TwirlForm.showmodal;
end;

procedure TMain.ScaleRGBButtonClick(Sender: TObject);
begin
  ScaleRGBForm.showmodal;
end;

procedure TMain.ScaleHSVButtonClick(Sender: TObject);
begin
  ScaleHSVForm.Showmodal;
end;

procedure TMain.SineRGBClick(Sender: TObject);
begin
  SineRGBForm.showmodal;
end;

procedure TMain.AdjustRGBButtonClick(Sender: TObject);
begin
  AdjRGBForm.showmodal;
end;

procedure TMain.AdjustHSVButtonClick(Sender: TObject);
begin
  AdjHSVForm.showmodal;
end;

procedure TMain.Exit1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TMain.About1Click(Sender: TObject);
begin
  AboutForm.showmodal;
end;

procedure TMain.SaveAsINC1Click(Sender: TObject);
 Var f : Textfile;
     v,x : cardinal;
begin
 if SaveDialog.Execute then begin
  assignfile(f,SaveDialog.FileName);
  rewrite(f);

  writeln(f,'//Texture include file');
  writeln(f,'initlayers('+inttostr(pic_sizex)+','+inttostr(pic_sizey)+');');

  for v:=0 to MAXLAYERS-1 do
   if stuffOnLayers[v].num>0 then
     for x:=0 to stuffOnLayers[v].num-1 do
      writeln(f,PascalStringOneStuff(stuffOnLayers[v].nr[x],stuffOnLayers[v].param[x]));

  closefile(f);
 end;
end;

procedure TMain.SaveAsBMP1Click(Sender: TObject);
begin
  if SaveDialog2.Execute then
   FLayerForm.bitmap.saveToFile(SaveDialog2.FileName);
end;

procedure TMain.ActiveLayerDDChange(Sender: TObject);
begin
  case ActiveLayerDD.ItemIndex of
   0 : if activeLayer<>0 then begin
        Layer0Form.active:=true;
        Layer1Form.active:=false;
        Layer2Form.active:=false;
        Layer3Form.active:=false;
        Layer0Form.ReLoad;
        if activeLayer=1 then Layer1Form.ReLoad;
        if activeLayer=2 then Layer2Form.ReLoad;
        if activeLayer=3 then Layer3Form.ReLoad;
       end;
   1 : if activeLayer<>1 then begin
        Layer1Form.active:=true;
        Layer0Form.active:=false;
        Layer2Form.active:=false;
        Layer3Form.active:=false;
        Layer1Form.ReLoad;
        if activeLayer=0 then Layer0Form.ReLoad;
        if activeLayer=2 then Layer2Form.ReLoad;
        if activeLayer=3 then Layer3Form.ReLoad;
       end;
   2 : if activeLayer<>2 then begin
        Layer2Form.active:=true;
        Layer1Form.active:=false;
        Layer0Form.active:=false;
        Layer3Form.active:=false;
        Layer2Form.ReLoad;
        if activeLayer=1 then Layer1Form.ReLoad;
        if activeLayer=0 then Layer0Form.ReLoad;
        if activeLayer=3 then Layer3Form.ReLoad;
       end;
   3 : if activeLayer<>3 then begin
        Layer3Form.active:=true;
        Layer1Form.active:=false;
        Layer2Form.active:=false;
        Layer0Form.active:=false;
        Layer3Form.ReLoad;
        if activeLayer=1 then Layer1Form.ReLoad;
        if activeLayer=2 then Layer2Form.ReLoad;
        if activeLayer=0 then Layer0Form.ReLoad;
       end;
  end;
  case ActiveLayerDD.ItemIndex of
   0 : if Layer0Form.Visible=false then Layer0Form.Show;
   1 : if Layer1Form.Visible=false then Layer1Form.Show;
   2 : if Layer2Form.Visible=false then Layer2Form.Show;
   3 : if Layer3Form.Visible=false then Layer3Form.Show;
  end;
  activeLayer:=ActiveLayerDD.ItemIndex;
end;

procedure TMain.SizeDDChange(Sender: TObject);
 var v,x : longint;
begin
  case SizeDD.ItemIndex of
   0: begin pic_sizex:=64; pic_sizey:=64; end;
   1: begin pic_sizex:=128; pic_sizey:=128; end;
   2: begin pic_sizex:=256; pic_sizey:=256; end;
   3: begin pic_sizex:=512; pic_sizey:=512; end;
  end;

  if (pic_sizex<>layer_sizex) and (pic_sizey<>layer_sizey) then begin
   for v:=0 to maxlayers do
    reallocmem(layers[v],pic_sizex*pic_sizey*sizeof(color));

   layer_sizex:=pic_sizex;
   layer_sizey:=pic_sizey;
   andlayer_sizex:=pic_sizex-1;
   andlayer_sizey:=pic_sizey-1;

   for v:=0 to MAXLAYERS-1 do
    if stuffOnLayers[v].num>0 then begin
     for x:=0 to stuffOnLayers[v].num-1 do
      doOneStuff(stuffOnLayers[v].nr[x],stuffOnLayers[v].param[x]);
    end else colorLayer(v,0,0,0);

   Layer0Form.ReLoad;
   Layer1Form.ReLoad;
   Layer2Form.ReLoad;
   Layer3Form.ReLoad;
   FLayerForm.ReLoad;
  end;
end;

procedure TMain.SaveAsTEX1Click(Sender: TObject);
 Var f : File;
begin
 if SaveDialog3.Execute then begin
  assignfile(f,SaveDialog3.FileName);
  rewrite(f,1);
  blockwrite(f,stuffOnLayers,sizeof(stuffOnLayers));
  closefile(f);
 end;
end;

procedure TMain.OpenTEX1Click(Sender: TObject);
 Var f : file;
     v,x : cardinal;
begin
 if OpenDialog.Execute then begin
  assignfile(f,OpenDialog.FileName);
  reset(f,1);
  blockread(f,stuffOnLayers,sizeof(stuffOnLayers));
  closefile(f);

  for v:=0 to MAXLAYERS-1 do begin
   max_numStuff[v]:=stuffOnLayers[v].num;
   if stuffOnLayers[v].num>0 then begin
    for x:=0 to stuffOnLayers[v].num-1 do
     doOneStuff(stuffOnLayers[v].nr[x],stuffOnLayers[v].param[x]);
   end else colorLayer(v,0,0,0);
  end;

  Layer0Form.ReLoad;
  Layer1Form.ReLoad;
  Layer2Form.ReLoad;
  Layer3Form.ReLoad;
  FLayerForm.ReLoad;

  Perc0_01.value:=trunc(stuffOnLayers[MAXLAYERS-1].param[1][3]*100.0);
  Perc1_01.value:=trunc(stuffOnLayers[MAXLAYERS-1].param[1][4]*100.0);

  Perc0_12.value:=trunc(stuffOnLayers[MAXLAYERS-1].param[2][3]*100.0);
  Perc1_12.value:=trunc(stuffOnLayers[MAXLAYERS-1].param[2][4]*100.0);

  Perc0_23.value:=trunc(stuffOnLayers[MAXLAYERS-1].param[3][3]*100.0);
  Perc1_23.value:=trunc(stuffOnLayers[MAXLAYERS-1].param[3][4]*100.0);

  case stuffOnLayers[MAXLAYERS-1].nr[1] of
   C_ADD : Layer0_1Combine.ItemIndex:=0;
   C_MUL : Layer0_1Combine.ItemIndex:=5;
   DO_NOTHING : Layer0_1Combine.ItemIndex:=7;
   D_MAP : Layer0_1Combine.ItemIndex:=2;
   C_RAND : Layer0_1Combine.ItemIndex:=6;
   C_MAX : Layer0_1Combine.ItemIndex:=3;
   C_MIN : Layer0_1Combine.ItemIndex:=4;
   C_XOR : Layer0_1Combine.ItemIndex:=9;
   C_AND : Layer0_1Combine.ItemIndex:=1;
   C_OR : Layer0_1Combine.ItemIndex:=8;
  end;

  case stuffOnLayers[MAXLAYERS-1].nr[2] of
   C_ADD : Layer1_2Combine.ItemIndex:=0;
   C_MUL : Layer1_2Combine.ItemIndex:=5;
   DO_NOTHING : Layer1_2Combine.ItemIndex:=7;
   D_MAP : Layer1_2Combine.ItemIndex:=2;
   C_RAND : Layer1_2Combine.ItemIndex:=6;
   C_MAX : Layer1_2Combine.ItemIndex:=3;
   C_MIN : Layer1_2Combine.ItemIndex:=4;
   C_XOR : Layer1_2Combine.ItemIndex:=9;
   C_AND : Layer1_2Combine.ItemIndex:=1;
   C_OR : Layer1_2Combine.ItemIndex:=8;
  end;

  case stuffOnLayers[MAXLAYERS-1].nr[3] of
   C_ADD : Layer2_3Combine.ItemIndex:=0;
   C_MUL : Layer2_3Combine.ItemIndex:=5;
   DO_NOTHING : Layer2_3Combine.ItemIndex:=7;
   D_MAP : Layer2_3Combine.ItemIndex:=2;
   C_RAND : Layer2_3Combine.ItemIndex:=6;
   C_MAX : Layer2_3Combine.ItemIndex:=3;
   C_MIN : Layer2_3Combine.ItemIndex:=4;
   C_XOR : Layer2_3Combine.ItemIndex:=9;
   C_AND : Layer2_3Combine.ItemIndex:=1;
   C_OR : Layer2_3Combine.ItemIndex:=8;
  end;
 end;
end;

procedure TMain.UndoButtonClick(Sender: TObject);
begin
  SubOneStuff(activeLayer,true);
  ReLoadActive;
end;

procedure TMain.RedoButtonClick(Sender: TObject);
begin
  if (stuffOnLayers[activeLayer].num<max_numStuff[activeLayer]) then begin
   DoOneStuff(stuffOnLayers[activeLayer].nr[stuffOnLayers[activeLayer].num],stuffOnLayers[activeLayer].param[stuffOnLayers[activeLayer].num]);
   inc(stuffOnLayers[activeLayer].num); //HACK! It uses the (undeleted!) Info that was left by Undo inside the array!
   ReLoadActive;
  end;
end;

procedure TMain.ClearButtonClick(Sender: TObject);
begin
  stuffOnLayers[activeLayer].num:=0;
  colorLayer(activeLayer,0,0,0);
  ReLoadActive;
end;


procedure TMain.DStackButtonClick(Sender: TObject);
 var v : longint;
     s : string;
begin
 DStack.DCombo.Style:=csDropDownList;
 DStack.DCombo.Clear;

 if (max_numStuff[activeLayer]=0) then begin
  DStack.DCombo.Enabled:=false;
  DStack.ChButton.Enabled:=false;
  DStack.DelButton.Enabled:=false;
 end else begin
  DStack.DCombo.Enabled:=true;
  DStack.ChButton.Enabled:=true;
  DStack.DelButton.Enabled:=true;
  for v:=0 to max_numStuff[activeLayer]-1 do begin
   case stuffOnLayers[activeLayer].nr[v] of
      R_SUB_PLASMA : s:='Sub Plasma';
      R_SINE_PLASMA : s:='Sine Plasma';
      R_PERLIN_NOISE : s:='Perlin Noise';
      R_PARTICLE : s:='Particle/Corona';
      R_COLOR : s:='Solid Color';
      R_CBOARD : s:='CheckerBoard';
      R_BLOBS : s:='Blobs';
      R_MANDEL : s:='Mandelbrot';
      R_CELLM : s:='Cell-Machine';

      COL_SCALE_RGB : s:='Scale RGB';
      COL_SCALE_HSV : s:='Scale HSV';
      COL_ADJUST_RGB : s:='Adjust RGB';
      COL_ADJUST_HSV : s:='Adjust HSV';
      COL_SINE_RGB : s:='Sine RGB';
      COL_EQUALIZE : s:='Equalize Full';
      COL_STRETCH : s:='Equalize Stretch';

      F_INVERT : s:='Invert';
      F_EMBOSS : s:='Emboss';
      F_WOOD : s:='Wood';
      F_BLUR : s:='Blur';
      F_SHARPEN : s:='Sharpen';
      F_HEDGE : s:='Horizontal Edge';
      F_VEDGE : s:='Vertical Edge';
      F_MOTION_BLUR : s:='Motion Blur';
      F_MAKE_TILABLE : s:='Make Tilable';
      F_MEDIAN : s:='Median Cut';
      F_DILATE : s:='Dilate';
      F_ERODE : s:='Erode';

      D_SINE : s:='Sine Distort';
      D_TWIRL : s:='Twirl';
      D_TILE : s:='Tile';
      D_NOISE : s:='Noise Distort';
      D_MOVE : s:='Move X/Y';
      D_KALEID : s:='Kaleidoscope';
      D_TUNNEL : s:='Tunnel';
      D_SCULPTURE : s:='Sculpture';
      D_LOGPOL : s:='Log Polar Distort';
   end;
   if (v>stuffOnLayers[Main.activeLayer].num-1) then s:=s+' (Redo=Not Visible!)';
   DStack.DCombo.Items.Add(s);
  end;
 end;

 DStack.DCombo.ItemIndex:=0;
 DStack.showmodal;
end;

procedure TMain.NoiseDistButtonClick(Sender: TObject);
begin
  NoiseDForm.showmodal;
end;

procedure TMain.CBoardButtonClick(Sender: TObject);
begin
  CBoardForm.showmodal;
end;

procedure TMain.MoveButtonClick(Sender: TObject);
begin
  MoveForm.showmodal;
end;

procedure TMain.LogPolButtonClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=activeLayer;
  tempparam[1]:=activeLayer;
  addOneStuff(activeLayer,true,D_LOGPOL,tempparam,Change_Flag);
  ReLoadActive;
end;

end.
