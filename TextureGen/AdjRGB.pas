unit AdjRGB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TAdjRGBForm = class(TForm)
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
  AdjRGBForm: TAdjRGBForm;

implementation

uses MainU;

{$R *.DFM}

procedure TAdjRGBForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TAdjRGBForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=RSpin.Value;
  tempparam[3]:=GSpin.Value;
  tempparam[4]:=BSpin.Value;
  addOneStuff(Main.activeLayer,true,COL_ADJUST_RGB,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TAdjRGBForm.RandomizeBClick(Sender: TObject);
begin
  RSpin.Value:=random(201)-100;
  GSpin.Value:=random(201)-100;
  BSpin.Value:=random(201)-100;
end;

end.
