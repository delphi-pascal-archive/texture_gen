unit Particle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TParticleForm = class(TForm)
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    SizeSpin: TSpinEdit;
    Label1: TLabel;
    procedure OKBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure RandomizeBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ParticleForm: TParticleForm;

implementation

uses MainU;

{$R *.DFM}

procedure TParticleForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=100.0/SizeSpin.Value;
  addOneStuff(Main.activeLayer,true,R_PARTICLE,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

procedure TParticleForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TParticleForm.RandomizeBClick(Sender: TObject);
begin
  SizeSpin.Value:=random(200);
end;

end.
