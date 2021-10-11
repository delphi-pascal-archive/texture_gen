unit Twirl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TTwirlForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    RotSpin: TSpinEdit;
    Label1: TLabel;
    ScaleSpin: TSpinEdit;
    Label2: TLabel;
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TwirlForm: TTwirlForm;

implementation

uses MainU;

{$R *.DFM}

procedure TTwirlForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TTwirlForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=RotSpin.Value;
  tempparam[3]:=100000.0/ScaleSpin.Value;
  addOneStuff(Main.activeLayer,true,D_TWIRL,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TTwirlForm.RandomizeBClick(Sender: TObject);
begin
  RotSpin.Value:=random(300)+100;
  ScaleSpin.Value:=random(300)+100;
end;

end.
