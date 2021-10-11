unit Blob;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Tex;

type
  TBlobForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    OKB: TButton;
    CancelB: TButton;
    RandomizeB: TButton;
    SeedSpin: TSpinEdit;
    AmountSpin: TSpinEdit;
    CheckRGB: TCheckBox;
    procedure RandomizeBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OKBClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  BlobForm: TBlobForm;

implementation

uses MainU;

{$R *.DFM}

procedure TBlobForm.RandomizeBClick(Sender: TObject);
begin
  AmountSpin.Value:=random(16)+1;
  SeedSpin.Value:=random(1000000000)+1;
end;

procedure TBlobForm.CancelBClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TBlobForm.OKBClick(Sender: TObject);
 Var tempparam : tsingarray;
begin
  tempparam[0]:=Main.activeLayer;
  tempparam[1]:=SeedSpin.Value;
  tempparam[2]:=AmountSpin.Value;
  if CheckRGB.Checked then tempparam[3]:=1.0
   else tempparam[3]:=0.0;
  addOneStuff(Main.activeLayer,true,R_BLOBS,tempparam,Main.Change_Flag);
  Main.ReLoadActive;

  Self.Close;
end;

end.
