unit MakeTile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TMakeTileForm = class(TForm)
    Label1: TLabel;
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    StrengthSpin: TSpinEdit;
    procedure RandomizeBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MakeTileForm: TMakeTileForm;

implementation

uses MainU;

{$R *.DFM}

procedure TMakeTileForm.RandomizeBClick(Sender: TObject);
begin
  StrengthSpin.Value:=random(75)+1;
end;

procedure TMakeTileForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TMakeTileForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=StrengthSpin.Value;
  addOneStuff(Main.activeLayer,true,F_MAKE_TILABLE,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

end.
