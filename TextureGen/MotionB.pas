unit MotionB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TMotionBForm = class(TForm)
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
  MotionBForm: TMotionBForm;

implementation

uses MainU;

{$R *.DFM}

procedure TMotionBForm.RandomizeBClick(Sender: TObject);
begin
  StrengthSpin.Value:=random(75)+1;
end;

procedure TMotionBForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TMotionBForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=StrengthSpin.Value;
  addOneStuff(Main.activeLayer,true,F_MOTION_BLUR,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

end.
