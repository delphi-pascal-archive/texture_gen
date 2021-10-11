unit AdjHSV;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TAdjHSVForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    HSpin: TSpinEdit;
    Label1: TLabel;
    SSpin: TSpinEdit;
    VSpin: TSpinEdit;
    Label2: TLabel;
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
  AdjHSVForm: TAdjHSVForm;

implementation

uses MainU;

{$R *.DFM}

procedure TAdjHSVForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TAdjHSVForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=HSpin.Value*360.0/255.0;
  tempparam[3]:=SSpin.Value/255.0;
  tempparam[4]:=VSpin.Value;
  addOneStuff(Main.activeLayer,true,COL_ADJUST_HSV,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TAdjHSVForm.RandomizeBClick(Sender: TObject);
begin
  HSpin.Value:=random(201)-100;
  SSpin.Value:=random(201)-100;
  VSpin.Value:=random(201)-100;
end;

end.
