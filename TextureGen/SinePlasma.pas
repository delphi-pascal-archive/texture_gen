unit SinePlasma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TSinePlasmaForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    XSpin: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    YSpin: TSpinEdit;
    Label3: TLabel;
    RandomizeB: TButton;
    AmplitudeSpin: TSpinEdit;
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  SinePlasmaForm: TSinePlasmaForm;

implementation

uses MainU;

{$R *.DFM}

procedure TSinePlasmaForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TSinePlasmaForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=XSpin.Value/1000.0;
  tempparam[2]:=YSpin.Value/1000.0;
  tempparam[3]:=AmplitudeSpin.Value;
  addOneStuff(Main.activeLayer,true,R_SINE_PLASMA,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TSinePlasmaForm.RandomizeBClick(Sender: TObject);
begin
  XSpin.Value:=random(Main.pic_sizex)+1;
  YSpin.Value:=random(Main.pic_sizey)+1;
  AmplitudeSpin.Value:=random(129)+128;
end;

end.
