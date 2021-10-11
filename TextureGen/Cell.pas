unit Cell;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TCellForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandB: TButton;
    RandSpin: TSpinEdit;
    RuleSpin: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
    procedure RandBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  CellForm: TCellForm;

implementation

uses MainU;

{$R *.DFM}

procedure TCellForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TCellForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=RandSpin.Value;
  tempparam[2]:=RuleSpin.Value;
  addOneStuff(Main.activeLayer,true,R_CELLM,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TCellForm.RandBClick(Sender: TObject);
begin
  RuleSpin.Value:=random(256);
  RandSpin.Value:=random(1000000000)+1;
end;

end.
