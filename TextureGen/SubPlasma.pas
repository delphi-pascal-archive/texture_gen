unit SubPlasma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Tex, Spin;

type
  TSubPlasmaForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    Label1: TLabel;
    Label2: TLabel;
    SeedSpin: TSpinEdit;
    Label3: TLabel;
    CheckRGB: TCheckBox;
    RandomizeB: TButton;
    DistanceBox: TComboBox;
    AmplitudeBox: TComboBox;
    procedure OKBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    init_dirty_flag : boolean;
  end;

var
  SubPlasmaForm: TSubPlasmaForm;

implementation

uses MainU;

{$R *.DFM}

procedure TSubPlasmaForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=strtofloat(DistanceBox.Items[DistanceBox.ItemIndex]);
  tempparam[2]:=SeedSpin.Value;
  tempparam[3]:=strtofloat(AmplitudeBox.Items[AmplitudeBox.ItemIndex]);
  if CheckRGB.Checked then tempparam[4]:=1.0
   else tempparam[4]:=0.0;
  addOneStuff(Main.activeLayer,true,R_SUB_PLASMA,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TSubPlasmaForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TSubPlasmaForm.RandomizeBClick(Sender: TObject);
begin
  SeedSpin.Value:=random(2147483647)+1;
  AmplitudeBox.ItemIndex:=random(2)+3;
  repeat
   DistanceBox.ItemIndex:=random(5);
  until DistanceBox.ItemIndex<AmplitudeBox.ItemIndex;
end;

procedure TSubPlasmaForm.FormActivate(Sender: TObject);
begin
  if init_dirty_flag then begin
   init_dirty_flag:=false;
   DistanceBox.ItemIndex:=3;
   AmplitudeBox.ItemIndex:=4;
  end;
end;

procedure TSubPlasmaForm.FormCreate(Sender: TObject);
begin
  init_dirty_flag:=true;
end;

end.
