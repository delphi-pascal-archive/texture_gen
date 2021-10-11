unit PerlinNoise;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TPerlinNoiseForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    DistanceBox: TComboBox;
    Label1: TLabel;
    SeedSpin: TSpinEdit;
    Label2: TLabel;
    AmplitudeBox: TComboBox;
    Label3: TLabel;
    OctaveSpin: TSpinEdit;
    Label4: TLabel;
    PersistenceSpin: TSpinEdit;
    Persistence: TLabel;
    CheckRGB: TCheckBox;
    procedure OKBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    init_dirty_flag : boolean;
  end;

var
  PerlinNoiseForm: TPerlinNoiseForm;

implementation

uses MainU;

{$R *.DFM}

procedure TPerlinNoiseForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=strtofloat(DistanceBox.Items[DistanceBox.ItemIndex]);
  tempparam[2]:=SeedSpin.Value;
  tempparam[3]:=strtofloat(AmplitudeBox.Items[AmplitudeBox.ItemIndex]);
  tempparam[4]:=PersistenceSpin.Value;
  tempparam[5]:=OctaveSpin.Value;
  if CheckRGB.Checked then tempparam[6]:=1.0
   else tempparam[6]:=0.0;
  addOneStuff(Main.activeLayer,true,R_PERLIN_NOISE,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TPerlinNoiseForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TPerlinNoiseForm.FormActivate(Sender: TObject);
begin
  if init_dirty_flag then begin
   init_dirty_flag:=false;
   DistanceBox.ItemIndex:=3;
   AmplitudeBox.ItemIndex:=4;
  end;
end;

procedure TPerlinNoiseForm.FormCreate(Sender: TObject);
begin
  init_dirty_flag:=true;
end;

procedure TPerlinNoiseForm.RandomizeBClick(Sender: TObject);
begin
  SeedSpin.Value:=random(2147483647)+1;
  AmplitudeBox.ItemIndex:=random(2)+3;
  repeat
   DistanceBox.ItemIndex:=random(5);
  until DistanceBox.ItemIndex<AmplitudeBox.ItemIndex;
  OctaveSpin.Value:=random(6)+3;
  PersistenceSpin.Value:=random(50)+100;
end;

end.
