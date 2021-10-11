unit SineRGB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TSineRGBForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    RSpin: TSpinEdit;
    Label1: TLabel;
    GSpin: TSpinEdit;
    Label2: TLabel;
    BSpin: TSpinEdit;
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
  SineRGBForm: TSineRGBForm;

implementation

uses MainU;

{$R *.DFM}

procedure TSineRGBForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TSineRGBForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=RSpin.Value/500.0;
  tempparam[3]:=GSpin.Value/500.0;
  tempparam[4]:=BSpin.Value/500.0;
  addOneStuff(Main.activeLayer,true,COL_SINE_RGB,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TSineRGBForm.RandomizeBClick(Sender: TObject);
begin
  RSpin.Value:=random(100);
  GSpin.Value:=random(100);
  BSpin.Value:=random(100);
end;

end.
