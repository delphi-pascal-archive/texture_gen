unit Mandel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Tex, Spin;

type
  TMandelForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandB: TButton;
    X1Spin: TSpinEdit;
    Label1: TLabel;
    Y1Spin: TSpinEdit;
    X2Spin: TSpinEdit;
    Y2Spin: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
    procedure RandBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MandelForm: TMandelForm;

implementation

uses MainU;

{$R *.DFM}

procedure TMandelForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TMandelForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=X1Spin.Value*0.000125-0.777;
  tempparam[2]:=Y1Spin.Value*0.000125;
  tempparam[3]:=X2Spin.Value*0.000125-0.777;
  tempparam[4]:=Y2Spin.Value*0.000125;
  addOneStuff(Main.activeLayer,true,R_MANDEL,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TMandelForm.RandBClick(Sender: TObject);
begin
  X1Spin.Value:=random(20000)-10000;
  Y1Spin.Value:=random(20000)-10000;
  X2Spin.Value:=random(20000)-10000;
  Y2Spin.Value:=Y1Spin.Value+X2Spin.Value-X1Spin.Value;
end;

end.
