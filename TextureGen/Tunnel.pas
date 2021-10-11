unit Tunnel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TTunnelForm = class(TForm)
    Label1: TLabel;
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    ZoomSpin: TSpinEdit;
    procedure RandomizeBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TunnelForm: TTunnelForm;

implementation

uses MainU;

{$R *.DFM}

procedure TTunnelForm.RandomizeBClick(Sender: TObject);
begin
  ZoomSpin.Value:=random(256)+1;
end;

procedure TTunnelForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TTunnelForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=Main.activeLayer;
  tempparam[2]:=ZoomSpin.Value shl 9;
  addOneStuff(Main.activeLayer,true,D_TUNNEL,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

end.
