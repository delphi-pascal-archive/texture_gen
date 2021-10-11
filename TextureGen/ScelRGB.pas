unit ScelRGB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TScaleRGBForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    RSpin: TSpinEdit;
    Label1: TLabel;
    GSpin: TSpinEdit;
    BSpin: TSpinEdit;
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
  ScaleRGBForm: TScaleRGBForm;

implementation

uses MainU;

{$R *.DFM}

procedure TScaleRGBForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TScaleRGBForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=RSpin.Value/100.0;
  tempparam[3]:=GSpin.Value/100.0;
  tempparam[4]:=BSpin.Value/100.0;
  addOneStuff(Main.activeLayer,true,COL_SCALE_RGB,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TScaleRGBForm.RandomizeBClick(Sender: TObject);
begin
  RSpin.Value:=random(200);
  GSpin.Value:=random(200);
  BSpin.Value:=random(200);
end;

end.
