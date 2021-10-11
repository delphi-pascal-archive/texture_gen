unit Layer1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Tex;

type
  TLayer1Form = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    bitmap : TBitmap;
    active : boolean;
    init_dirty_flag : boolean;
    procedure ReLoad;
  end;

var
  Layer1Form: TLayer1Form;

implementation

uses MainU;

{$R *.DFM}

procedure TLayer1Form.ReLoad; //ReSize/Draw Window
 Var x,y : longint;
     offset : cardinal;
     p : pcardarray;
begin
  if active then begin
   Caption:='Layer 1 (Active Layer)';
   Color:=clActiveCaption;
   BringToFront;
  end else begin
   Caption:='Layer 1';
   Color:=clInactiveCaption;
  end;

  bitmap.HandleType:=bmDIB;        //device independent
  bitmap.PixelFormat:=pf32bit;     //32Bit
  bitmap.width:=layer_sizex;             //new BMP/Window-Dimensions
  bitmap.height:=layer_sizey;

    for y:=0 to layer_sizey-1 do begin
     p:=bitmap.Scanline[y];
     offset:=y*layer_sizex;
     for x:=0 to layer_sizex-1 do
      p^[x]:=layers[1][x+offset].b + layers[1][x+offset].g shl 8 + layers[1][x+offset].r shl 16;
    end;

  height := layer_sizey + GetSystemMetrics(SM_CYDLGFRAME) + GetSystemMetrics(SM_CYCAPTION) +9;
  width  := layer_sizex  + GetSystemMetrics(SM_CXDLGFRAME) +9;
  FormPaint(nil);
end;


procedure TLayer1Form.FormPaint(Sender: TObject);
begin
  Canvas.Draw(3,3,bitmap)
end;

procedure TLayer1Form.FormCreate(Sender: TObject);
begin
  bitmap := TBitmap.Create;
  init_dirty_flag:=false;
end;

procedure TLayer1Form.FormClick(Sender: TObject);
begin
  Main.ActiveLayerDD.ItemIndex:=1;
  Main.ActiveLayerDDChange(nil);
end;

procedure TLayer1Form.FormActivate(Sender: TObject);
begin
  if init_dirty_flag then begin
   Main.ActiveLayerDD.ItemIndex:=1;
   Main.ActiveLayerDDChange(nil);
  end else init_dirty_flag:=true;
end;

end.
