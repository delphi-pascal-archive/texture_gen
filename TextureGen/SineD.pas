unit SineD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TSineDForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    XSpin: TSpinEdit;
    Label1: TLabel;
    YSpin: TSpinEdit;
    Label2: TLabel;
    DepthXSpin: TSpinEdit;
    DepthYSpin: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    RandomizeB: TButton;
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  SineDForm: TSineDForm;

implementation

uses MainU;

{$R *.DFM}

procedure TSineDForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TSineDForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=XSpin.Value/1000.0;
  tempparam[3]:=DepthXSpin.Value;
  tempparam[4]:=YSpin.Value/1000.0;
  tempparam[5]:=DepthYSpin.Value;
  addOneStuff(Main.activeLayer,true,D_SINE,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TSineDForm.RandomizeBClick(Sender: TObject);
begin
  XSpin.Value:=random(501)-250;
  YSpin.Value:=random(501)-250;
  DepthXSpin.Value:=random(501)-250;
  DepthYSpin.Value:=random(501)-250;
end;

end.
