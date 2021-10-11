unit CBoard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TCBoardForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    WidthSpin: TSpinEdit;
    HeightSpin: TSpinEdit;
    procedure RandomizeBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  CBoardForm: TCBoardForm;

implementation

uses MainU;

{$R *.DFM}

procedure TCBoardForm.RandomizeBClick(Sender: TObject);
begin
  WidthSpin.Value:=random(128)+1;
  HeightSpin.Value:=random(128)+1;
end;

procedure TCBoardForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TCBoardForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  if Main.ColorDialog.Execute then begin
   tempparam[3]:=Main.ColorDialog.Color and $FF;
   tempparam[4]:=(Main.ColorDialog.Color shr 8) and $FF;
   tempparam[5]:=(Main.ColorDialog.Color shr 16) and $FF;
  end else begin tempparam[3]:=0; tempparam[4]:=0; tempparam[5]:=0; end;
  if Main.ColorDialog.Execute then begin
   tempparam[6]:=Main.ColorDialog.Color and $FF;
   tempparam[7]:=(Main.ColorDialog.Color shr 8) and $FF;
   tempparam[8]:=(Main.ColorDialog.Color shr 16) and $FF;
  end else begin tempparam[6]:=255-tempparam[3]; tempparam[7]:=255-tempparam[4]; tempparam[8]:=255-tempparam[5]; end;

  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=WidthSpin.Value;
  tempparam[2]:=HeightSpin.Value;
  addOneStuff(Main.activeLayer,true,R_CBOARD,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

end.
