unit ScelHSV;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TScaleHSVForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    HSpin: TSpinEdit;
    Label1: TLabel;
    SSpin: TSpinEdit;
    Label2: TLabel;
    VSpin: TSpinEdit;
    Label3: TLabel;
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ScaleHSVForm: TScaleHSVForm;

implementation

uses MainU;

{$R *.DFM}

procedure TScaleHSVForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TScaleHSVForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=HSpin.Value/100.0;
  tempparam[3]:=SSpin.Value/100.0;
  tempparam[4]:=VSpin.Value/100.0;
  addOneStuff(Main.activeLayer,true,COL_SCALE_HSV,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TScaleHSVForm.RandomizeBClick(Sender: TObject);
begin
  HSpin.Value:=random(200);
  SSpin.Value:=random(200);
  VSpin.Value:=random(200);
end;

end.
