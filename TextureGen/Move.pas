unit Move;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TMoveForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    XSpin: TSpinEdit;
    YSpin: TSpinEdit;
    procedure RandomizeBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MoveForm: TMoveForm;

implementation

uses MainU;

{$R *.DFM}

procedure TMoveForm.RandomizeBClick(Sender: TObject);
begin
  XSpin.Value:=random(255)+1;
  YSpin.Value:=random(255)+1;
end;

procedure TMoveForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TMoveForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=XSpin.Value;
  tempparam[3]:=YSpin.Value;
  addOneStuff(Main.activeLayer,true,D_MOVE,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

end.
