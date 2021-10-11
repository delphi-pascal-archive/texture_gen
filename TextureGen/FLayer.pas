unit FLayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Tex;

type
  TFLayerForm = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    bitmap : TBitmap;
    procedure ReLoad;
  end;

var
  FLayerForm: TFLayerForm;

implementation

uses MainU;

{$R *.DFM}

procedure TFLayerForm.ReLoad; //ReSize/Draw Window
 Var x,y : longint;
     offset : cardinal;
     p : pcardarray;
begin
  bitmap.HandleType:=bmDIB;        //device independent
  bitmap.PixelFormat:=pf32bit;     //32Bit
  bitmap.width:=layer_sizex;             //new BMP/Window-Dimensions
  bitmap.height:=layer_sizey;

    if stuffOnLayers[MAXLAYERS-1].num>0 then
     for x:=0 to stuffOnLayers[MAXLAYERS-1].num-1 do
      doOneStuff(stuffOnLayers[MAXLAYERS-1].nr[x],stuffOnLayers[MAXLAYERS-1].param[x]);

    for y:=0 to layer_sizey-1 do begin
     p:=bitmap.Scanline[y];
     offset:=y*layer_sizex;
     for x:=0 to layer_sizex-1 do
      p^[x]:=layers[MAXLAYERS-1][x+offset].b + layers[MAXLAYERS-1][x+offset].g shl 8 + layers[MAXLAYERS-1][x+offset].r shl 16;
    end;

  height := layer_sizey + GetSystemMetrics(SM_CYDLGFRAME) + GetSystemMetrics(SM_CYCAPTION) +3;
  width  := layer_sizex  + GetSystemMetrics(SM_CXDLGFRAME) +3;
  FormPaint(nil);
end;

procedure TFLayerForm.FormPaint(Sender: TObject);
begin
  Canvas.Draw(0,0,bitmap)
end;

procedure TFLayerForm.FormCreate(Sender: TObject);
begin
  bitmap := TBitmap.Create;
end;

procedure TFLayerForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=false;
end;

end.
