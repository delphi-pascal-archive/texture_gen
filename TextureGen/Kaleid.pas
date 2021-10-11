unit Kaleid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TKaleidForm = class(TForm)
    Label1: TLabel;
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    CornerSpin: TSpinEdit;
    procedure RandomizeBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  KaleidForm: TKaleidForm;

implementation

uses MainU;

{$R *.DFM}

procedure TKaleidForm.RandomizeBClick(Sender: TObject);
begin
  CornerSpin.Value:=random(4)+1;
end;

procedure TKaleidForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TKaleidForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=CornerSpin.Value;
  addOneStuff(Main.activeLayer,true,D_KALEID,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

end.
