unit Wood;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TWoodForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    ShiftSpin: TSpinEdit;
    Label1: TLabel;
    procedure OKBClick(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  WoodForm: TWoodForm;

implementation

uses MainU;

{$R *.DFM}

procedure TWoodForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=ShiftSpin.Value;
  addOneStuff(Main.activeLayer,true,F_WOOD,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TWoodForm.RandomizeBClick(Sender: TObject);
begin
  ShiftSpin.Value:=random(7)+1;
end;

procedure TWoodForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

end.
