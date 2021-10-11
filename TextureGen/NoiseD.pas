unit NoiseD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TNoiseDForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    SeedSpin: TSpinEdit;
    RadiusSpin: TSpinEdit;
    procedure RandomizeBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  NoiseDForm: TNoiseDForm;

implementation

uses MainU;

{$R *.DFM}

procedure TNoiseDForm.RandomizeBClick(Sender: TObject);
begin
  RadiusSpin.Value:=random(8)+1;
  SeedSpin.Value:=random(1000000000)+1;
end;

procedure TNoiseDForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=SeedSpin.Value;
  tempparam[3]:=RadiusSpin.Value;
  addOneStuff(Main.activeLayer,true,D_NOISE,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TNoiseDForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

end.
