//TODO: CORRECT TUNNEL?! (ARCTAN(Y/X) -> X=0 && (Y=0 | Y>0 | Y<0) !!!)
{
  Texture v.0.5

  (C)2K2 by CARSTEN WAECHTER aka THE TOXIC AVENGER/AINC.

  Based on an article found in the german 'PC Magazin 10/2000' by Carsten Dachsbacher

  This Unit/Prog is Public Domain..
   Feel free to use, enhance or even learn about this code..
  If you like it, please drop a message to:
   toxie@ainc.de
  To get the newest version of Texture surf to:
   http://ainc.de

  All future changes will be listed below..
}
{$IFDEF FPC}
{$ASMMODE INTEL}
{$MODE DELPHI}
{$ENDIF}
UNIT Tex;

INTERFACE

CONST MAXLAYERS = 5;
      TEMPL = MAXLAYERS;

      MAXSTUFF = 100;
      MAXPARAM = 10;

      DO_NOTHING = $FFFF;

      R_SUB_PLASMA = 0;
      R_SINE_PLASMA = 1;
      R_PERLIN_NOISE = 2;
      R_PARTICLE = 3;
      R_COLOR = 4;
      R_CBOARD = 5;
      R_BLOBS = 6;
      R_MANDEL = 7;
      R_CELLM = 8;

      C_ADD = 10;
      C_MUL = 11;
      C_RAND = 12;
      C_MIN = 13;
      C_MAX = 14;
      C_XOR = 15;
      C_OR  = 16;
      C_AND = 17;

      COL_SCALE_RGB = 20;
      COL_SCALE_HSV = 21;
      COL_ADJUST_RGB = 22;
      COL_ADJUST_HSV = 23;
      COL_SINE_RGB = 24;
      COL_EQUALIZE = 25;
      COL_STRETCH = 26;

      F_INVERT = 30;
      F_EMBOSS = 31;
      F_WOOD = 32;
      F_BLUR = 33;
      F_SHARPEN = 34;
      F_HEDGE = 35;
      F_VEDGE = 36;
      F_MOTION_BLUR = 37;
      F_MAKE_TILABLE = 38;
      F_MEDIAN = 39;
      F_ERODE = 50;
      F_DILATE = 51;

      D_SINE = 40;
      D_TWIRL = 41;
      D_MAP = 42;
      D_TILE = 43;
      D_NOISE = 44;
      D_MOVE = 45;
      D_KALEID = 46;
      D_TUNNEL = 47;
      D_SCULPTURE = 48;
      D_LOGPOL = 49;

TYPE Color = packed record
              r,g,b : byte;
             end;
     TLayer = array[0..100000000]of Color;
     PLayer = ^TLayer;

     tsingarray = array[0..MAXPARAM-1]of single;

     plongint = ^longint;
     psingle = ^single;

     TStuff = packed record
               num : longint;
               nr : array[0..MAXSTUFF-1]of longint;
               param : array[0..MAXSTUFF-1]of tsingarray;
              end;

     tcardarray = array[0..100000000]of cardinal;
     pcardarray = ^tcardarray;

VAR  Layers : array[0..MAXLAYERS]of PLayer;
     StuffOnLayers : array[0..MAXLAYERS-1]of TStuff;
     layer_sizex,layer_sizey,andlayer_sizex,andlayer_sizey : longint;
     max_numStuff : array[0..MAXLAYERS-1]of longint;

//LOAD .TEX

PROCEDURE TEX2Mem(var pic : pointer; name : string; dx,dy : longint; allocmem : boolean);
//For all who just want to get a TEX-File loaded into memory =)
//Everything else in this Unit is then TOTALLY unnecessary to work with / know about.
//The resulting "pic"-pointer will be filled with Cardinals (RGB(A))
//"dx"/"dy" chooses the resolution of the texture (normally: 256/256)
//"allocmem" lets the procedure get memory for "pic" (TRUE) or awaits a already allocated "pic" (FALSE)

//INIT/DEINIT

PROCEDURE InitLayers(x,y : longint);
PROCEDURE DeInitLayers;

//
//PROF.-USAGE =)
//

PROCEDURE AddOneStuff(l : longint; execute : boolean; nr : longint; var param : array of single; change : longint);
PROCEDURE SubOneStuff(l : longint; execute : boolean);
PROCEDURE ChangeOneStuff(l : longint; num : longint; nr : longint; var param : array of single);
PROCEDURE DoOneStuff(nr : longint; var param : array of single);

//HELPER

FUNCTION  MyRandom : longint;
FUNCTION  MySqrtInt(n : longint) : longint;
FUNCTION  MySqrtFloat(f : single) : single;
PROCEDURE hsv2rgb(h,s,v : single; var r,g,b : single);
PROCEDURE rgb2hsv(r,g,b : single; var h,s,v : single);

FUNCTION  CosineInterpolate(var o : array of color; x,y : single) : color;
FUNCTION  getBilerpPixel(l : longint; x,y : single) : color;

//RENDER

PROCEDURE SubPlasma(l,dist,seed,amplitude : longint; rgb : boolean);
PROCEDURE SinePlasma(l : longint; dx,dy,amplitude : single);
PROCEDURE PerlinNoise(l,dist,seed,amplitude,persistence,octaves : longint; rgb : boolean);
PROCEDURE Particle(l : longint; f : single);
PROCEDURE ColorLayer(l : longint; r,g,b : byte);
PROCEDURE CheckerBoardLayer(l,dx,dy : longint; r1,g1,b1,r2,g2,b2 : byte);
PROCEDURE BlobsLayer(l,seed,amount : longint; rgb : boolean);
PROCEDURE MandelBrot(l : longint; xs,dx,y,dy,sqr_betrag : single);
PROCEDURE CellMachine(l,seed,rule : longint);

//COMBINE

PROCEDURE AddLayers(src1,src2,dest : longint; perc1,perc2 : single);
PROCEDURE MulLayers(src1,src2,dest : longint; perc1,perc2 : single);
PROCEDURE XorLayers(src1,src2,dest : longint; perc1,perc2 : single);
PROCEDURE AndLayers(src1,src2,dest : longint; perc1,perc2 : single);
PROCEDURE OrLayers(src1,src2,dest : longint; perc1,perc2 : single);
PROCEDURE RandCombineLayers(src1,src2,dest : longint; perc1,perc2 : single);
PROCEDURE MaxCombineLayers(src1,src2,dest : longint; perc1,perc2 : single);
PROCEDURE MinCombineLayers(src1,src2,dest : longint; perc1,perc2 : single);

//COLOR

PROCEDURE ScaleLayerRGB(src,dest : longint; r,g,b : single);
PROCEDURE ScaleLayerHSV(src,dest : longint; h,s,v : single);
PROCEDURE AdjustLayerRGB(src,dest : longint; r,g,b : longint);
PROCEDURE AdjustLayerHSV(src,dest : longint; h,s,v : single);
PROCEDURE SineLayerRGB(src,dest : longint; r,g,b : single);
PROCEDURE EqualizeRGB(src,dest : longint);
PROCEDURE StretchRGB(src,dest : longint);

//FILTER

PROCEDURE InvertLayer(src,dest : longint);
PROCEDURE EmbossLayer(src,dest : longint);
PROCEDURE WoodLayer(src, dest, b : longint);
PROCEDURE BlurLayer(src,dest : longint);
PROCEDURE EdgeHLayer(src,dest : longint);
PROCEDURE EdgeVLayer(src,dest : longint);
PROCEDURE SharpenLayer(src,dest : longint);
PROCEDURE MotionBlur(src,dest,s : longint);
PROCEDURE MakeTilable(src,dest,s : longint);
PROCEDURE MedianLayer(src,dest : longint);
PROCEDURE ErodeLayer(src,dest : longint);
PROCEDURE DilateLayer(src,dest : longint);

//DISTORT

PROCEDURE SineDistort(src,dest : longint; dx,depthx,dy,depthy : single);
PROCEDURE TwirlLayer(src,dest : longint; rot,scale : single);
PROCEDURE MapDistort(src,dist,dest : longint; xd,yd : single);
PROCEDURE TileLayer(src,dest : longint);
PROCEDURE NoiseDistort(src,dest,seed,radius : longint);
PROCEDURE MoveDistort(src,dest,dx,dy : longint);
PROCEDURE KaleidLayer(src,dest,corner : longint);
PROCEDURE TunnelDistort(src,dest : longint; f : single);
PROCEDURE SculptureLayer(src,dest : longint);
PROCEDURE LogPolLayer(src,dest : longint);

//SOURCE OUTPUT

FUNCTION  PascalStringOneStuff(nr : longint; var param : array of single) : string;


IMPLEMENTATION

USES SysUtils;

CONST pi : single=3.1415926536;
VAR seedvalue : longint;

//

PROCEDURE AddOneStuff(l : longint; execute : boolean; nr : longint; var param : array of single; change : longint);
BEGIN
  if (change>-1) then begin
   stuffOnLayers[l].nr[change]:=nr;
   move(param,stuffOnLayers[l].param[change],sizeof(tsingarray));
   exit;
  end;

  if (nr<C_ADD) then stuffOnLayers[l].num:=0; //RENDER=RESET

  stuffOnLayers[l].nr[stuffOnLayers[l].num]:=nr;
  move(param,stuffOnLayers[l].param[stuffOnLayers[l].num],sizeof(tsingarray));
  inc(stuffOnLayers[l].num);

  max_numStuff[l]:=stuffOnLayers[l].num;

  if execute then DoOneStuff(nr,param);
END;

PROCEDURE SubOneStuff(l : longint; execute : boolean);
 Var x : longint;
BEGIN
  if (stuffOnLayers[l].num>0) then dec(stuffOnLayers[l].num);

  if execute then
   if (stuffOnLayers[l].num>0) then begin
    for x:=0 to stuffOnLayers[l].num-1 do
     doOneStuff(stuffOnLayers[l].nr[x],stuffOnLayers[l].param[x]);
   end else colorLayer(l,0,0,0);
END;

PROCEDURE ChangeOneStuff(l : longint; num : longint; nr : longint; var param : array of single);
BEGIN
  stuffOnLayers[l].nr[num]:=nr;
  move(param,stuffOnLayers[l].param[num],sizeof(tsingarray));
END;

PROCEDURE DoOneStuff(nr : longint; var param : array of single);
BEGIN
  case nr of
      R_SUB_PLASMA : subPlasma(trunc(param[0]),trunc(param[1]),trunc(param[2]),trunc(param[3]),param[4]=1.0);
      R_SINE_PLASMA : sinePlasma(trunc(param[0]),param[1],param[2],param[3]);
      R_PERLIN_NOISE : perlinNoise(trunc(param[0]),trunc(param[1]),trunc(param[2]),trunc(param[3]),trunc(param[4]),trunc(param[5]),param[6]=1.0);
      R_PARTICLE : particle(trunc(param[0]),param[1]);
      R_COLOR : colorLayer(trunc(param[0]),trunc(param[1]),trunc(param[2]),trunc(param[3]));
      R_CBOARD : checkerBoardLayer(trunc(param[0]),trunc(param[1]),trunc(param[2]),trunc(param[3]),trunc(param[4]),trunc(param[5]),trunc(param[6]),trunc(param[7]),trunc(param[8]));
      R_BLOBS : blobsLayer(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3]=1.0);
      R_MANDEL : mandelBrot(trunc(param[0]),param[1],param[3]-param[1],param[2],param[4]-param[2],16.0);
      R_CELLM : cellMachine(trunc(param[0]),trunc(param[1]),trunc(param[2]));

      C_ADD : addLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      C_MUL : mulLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      C_RAND : randCombineLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      C_MAX : maxCombineLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      C_MIN : minCombineLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      C_XOR : xorLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      C_OR : orLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      C_AND : andLayers(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);

      COL_SCALE_RGB : scaleLayerRGB(trunc(param[0]),trunc(param[1]),param[2],param[3],param[4]);
      COL_SCALE_HSV : scaleLayerHSV(trunc(param[0]),trunc(param[1]),param[2],param[3],param[4]);
      COL_ADJUST_RGB : adjustLayerRGB(trunc(param[0]),trunc(param[1]),trunc(param[2]),trunc(param[3]),trunc(param[4]));
      COL_ADJUST_HSV : adjustLayerHSV(trunc(param[0]),trunc(param[1]),param[2],param[3],param[4]);
      COL_SINE_RGB : sineLayerRGB(trunc(param[0]),trunc(param[1]),param[2],param[3],param[4]);
      COL_EQUALIZE : equalizeRGB(trunc(param[0]),trunc(param[1]));
      COL_STRETCH : stretchRGB(trunc(param[0]),trunc(param[1]));

      F_INVERT : invertLayer(trunc(param[0]),trunc(param[1]));
      F_EMBOSS : embossLayer(trunc(param[0]),trunc(param[1]));
      F_WOOD : woodLayer(trunc(param[0]),trunc(param[1]),trunc(param[2]));
      F_BLUR : blurLayer(trunc(param[0]),trunc(param[1]));
      F_SHARPEN : sharpenLayer(trunc(param[0]),trunc(param[1]));
      F_HEDGE : edgeHLayer(trunc(param[0]),trunc(param[1]));
      F_VEDGE : edgeVLayer(trunc(param[0]),trunc(param[1]));
      F_MOTION_BLUR : motionBlur(trunc(param[0]),trunc(param[1]),trunc(param[2]));
      F_MAKE_TILABLE : makeTilable(trunc(param[0]),trunc(param[1]),trunc(param[2]));
      F_MEDIAN : medianLayer(trunc(param[0]),trunc(param[1]));
      F_DILATE : dilateLayer(trunc(param[0]),trunc(param[1]));
      F_ERODE : erodeLayer(trunc(param[0]),trunc(param[1]));

      D_SINE : sineDistort(trunc(param[0]),trunc(param[1]),param[2],param[3],param[4],param[5]);
      D_TWIRL : twirlLayer(trunc(param[0]),trunc(param[1]),param[2],param[3]);
      D_MAP : mapDistort(trunc(param[0]),trunc(param[1]),trunc(param[2]),param[3],param[4]);
      D_TILE : tileLayer(trunc(param[0]),trunc(param[1]));
      D_NOISE : noiseDistort(trunc(param[0]),trunc(param[1]),trunc(param[2]),trunc(param[3]));
      D_MOVE : moveDistort(trunc(param[0]),trunc(param[1]),trunc(param[2]),trunc(param[3]));
      D_KALEID : kaleidLayer(trunc(param[0]),trunc(param[1]),trunc(param[2]));
      D_TUNNEL : tunnelDistort(trunc(param[0]),trunc(param[1]),param[2]);
      D_SCULPTURE : sculptureLayer(trunc(param[0]),trunc(param[1]));
      D_LOGPOL : logPolLayer(trunc(param[0]),trunc(param[1]));
  end;
END;


FUNCTION  PascalStringOneStuff(nr : longint; var param : array of single) : string;
 Var s : string;
BEGIN
  DecimalSeparator:='.';
  //ThousandSeparator:='';

  s:=' ';

  case nr of
      R_SUB_PLASMA : begin
                      s:='subPlasma('
                         +inttostr(trunc(param[0]))+','
                         +inttostr(trunc(param[1]))+','
                         +inttostr(trunc(param[2]))+','
                         +inttostr(trunc(param[3]))+',';
                      if param[4]=1.0 then s:=s+'true);'
                       else s:=s+'false);'
                     end;
      R_SINE_PLASMA : begin
                       s:='sinePlasma('
                          +inttostr(trunc(param[0]))+','
                          +floattostr(param[1])+','
                          +floattostr(param[2])+','
                          +floattostr(param[3])+');';
                      end;
      R_PERLIN_NOISE : begin
                        s:='perlinNoise('
                           +inttostr(trunc(param[0]))+','
                           +inttostr(trunc(param[1]))+','
                           +inttostr(trunc(param[2]))+','
                           +inttostr(trunc(param[3]))+','
                           +inttostr(trunc(param[4]))+','
                           +inttostr(trunc(param[5]))+',';
                        if param[6]=1.0 then s:=s+'true);'
                         else s:=s+'false);'
                       end;
      R_PARTICLE : begin
                    s:='particle('
                       +inttostr(trunc(param[0]))+','
                       +floattostr(param[1])+');';
                   end;
      R_COLOR : begin
                 s:='colorLayer('
                    +inttostr(trunc(param[0]))+','
                    +inttostr(trunc(param[1]))+','
                    +inttostr(trunc(param[2]))+','
                    +inttostr(trunc(param[3]))+');';
                end;
      R_CBOARD : begin
                 s:='checkerBoardLayer('
                    +inttostr(trunc(param[0]))+','
                    +inttostr(trunc(param[1]))+','
                    +inttostr(trunc(param[2]))+','
                    +inttostr(trunc(param[3]))+','
                    +inttostr(trunc(param[4]))+','
                    +inttostr(trunc(param[5]))+','
                    +inttostr(trunc(param[6]))+','
                    +inttostr(trunc(param[7]))+','
                    +inttostr(trunc(param[8]))+');';
                end;
      R_BLOBS : begin
                 s:='blobsLayer('
                    +inttostr(trunc(param[0]))+','
                    +inttostr(trunc(param[1]))+','
                    +inttostr(trunc(param[2]))+',';
                 if param[3]=1.0 then s:=s+'true);'
                  else s:=s+'false);'
                end;
      R_CELLM : begin
                 s:='cellMachine('
                    +inttostr(trunc(param[0]))+','
                    +inttostr(trunc(param[1]))+','
                    +inttostr(trunc(param[2]))+');';
                end;
      R_MANDEL : begin
                 s:='mandelBrot('
                    +inttostr(trunc(param[0]))+','
                    +floattostr(param[1])+','
                    +floattostr(param[3]-param[1])+','
                    +floattostr(param[2])+','
                    +floattostr(param[4]-param[2])+','
                    +floattostr(16.0)+');';
                end;

      C_ADD : begin
               s:='addLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      C_MUL : begin
               s:='mulLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      C_RAND : begin
               s:='randCombineLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      C_MAX : begin
               s:='maxCombineLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      C_MIN : begin
               s:='minCombineLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      C_XOR : begin
               s:='xorLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      C_OR  : begin
               s:='orLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      C_AND : begin
               s:='andLayers('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;

      COL_SCALE_RGB : begin
                       s:='scaleLayerRGB('
                          +inttostr(trunc(param[0]))+','
                          +inttostr(trunc(param[1]))+','
                          +floattostr(param[2])+','
                          +floattostr(param[3])+','
                          +floattostr(param[4])+');';
                      end;
      COL_SCALE_HSV : begin
                       s:='scaleLayerHSV('
                          +inttostr(trunc(param[0]))+','
                          +inttostr(trunc(param[1]))+','
                          +floattostr(param[2])+','
                          +floattostr(param[3])+','
                          +floattostr(param[4])+');';
                      end;
      COL_ADJUST_RGB : begin
                        s:='adjustLayerRGB('
                           +inttostr(trunc(param[0]))+','
                           +inttostr(trunc(param[1]))+','
                           +inttostr(trunc(param[2]))+','
                           +inttostr(trunc(param[3]))+','
                           +inttostr(trunc(param[4]))+');';
                       end;
      COL_ADJUST_HSV : begin
                        s:='adjustLayerHSV('
                           +inttostr(trunc(param[0]))+','
                           +inttostr(trunc(param[1]))+','
                           +floattostr(param[2])+','
                           +floattostr(param[3])+','
                           +floattostr(param[4])+');';
                       end;
      COL_SINE_RGB : begin
                      s:='sineLayerRGB('
                         +inttostr(trunc(param[0]))+','
                         +inttostr(trunc(param[1]))+','
                         +floattostr(param[2])+','
                         +floattostr(param[3])+','
                         +floattostr(param[4])+');';
                     end;
      COL_EQUALIZE : begin
                      s:='equalizeRGB('
                         +inttostr(trunc(param[0]))+','
                         +inttostr(trunc(param[1]))+');';
                     end;
      COL_STRETCH : begin
                      s:='stretchRGB('
                         +inttostr(trunc(param[0]))+','
                         +inttostr(trunc(param[1]))+');';
                     end;

      F_INVERT : begin
                  s:='invertLayer('
                     +inttostr(trunc(param[0]))+','
                     +inttostr(trunc(param[1]))+');';
                 end;
      F_EMBOSS : begin
                  s:='embossLayer('
                     +inttostr(trunc(param[0]))+','
                     +inttostr(trunc(param[1]))+');';
                 end;
      F_WOOD : begin
                s:='woodLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +inttostr(trunc(param[2]))+');';
               end;
      F_BLUR : begin
                s:='blurLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      F_SHARPEN : begin
                s:='sharpenLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      F_HEDGE : begin
                s:='edgeHLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      F_VEDGE : begin
                s:='edgeVLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      F_MOTION_BLUR : begin
                s:='motionBlur('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +inttostr(trunc(param[2]))+');';
               end;
      F_MAKE_TILABLE : begin
                s:='makeTilable('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +inttostr(trunc(param[2]))+');';
               end;
      F_MEDIAN : begin
                s:='medianLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      F_ERODE : begin
                s:='erodeLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      F_DILATE : begin
                s:='dilateLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;

      D_SINE : begin
                s:='sineDistort('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +floattostr(param[2])+','
                   +floattostr(param[3])+','
                   +floattostr(param[4])+','
                   +floattostr(param[5])+');';
               end;
      D_TWIRL : begin
                 s:='twirlLayer('
                    +inttostr(trunc(param[0]))+','
                    +inttostr(trunc(param[1]))+','
                    +floattostr(param[2])+','
                    +floattostr(param[3])+');';
                end;
      D_MAP : begin
               s:='mapDistort('
                  +inttostr(trunc(param[0]))+','
                  +inttostr(trunc(param[1]))+','
                  +inttostr(trunc(param[2]))+','
                  +floattostr(param[3])+','
                  +floattostr(param[4])+');';
              end;
      D_TILE : begin
                s:='tileLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      D_NOISE : begin
                s:='noiseDistort('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +inttostr(trunc(param[2]))+','
                   +inttostr(trunc(param[3]))+');';
               end;
      D_MOVE : begin
                s:='moveDistort('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +inttostr(trunc(param[2]))+','
                   +inttostr(trunc(param[3]))+');';
               end;
      D_KALEID : begin
                s:='kaleidLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +inttostr(trunc(param[2]))+');';
               end;
      D_TUNNEL : begin
                s:='tunnelDistort('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+','
                   +floattostr(param[2])+');';
               end;
      D_SCULPTURE : begin
                s:='sculptureLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
      D_LOGPOL : begin
                s:='logPolLayer('
                   +inttostr(trunc(param[0]))+','
                   +inttostr(trunc(param[1]))+');';
               end;
  end;
  PascalStringOneStuff:=s;
END;


PROCEDURE InitLayers(x,y : longint);
 Var v : longint;
BEGIN
  for v:=0 to maxlayers do
   reallocmem(layers[v],x*y*sizeof(color));

  for v:=0 to maxlayers-1 do begin
   stuffOnLayers[v].num:=0;
   fillchar(layers[v]^,x*y*sizeof(color),0);
  end;

  layer_sizex:=x;
  layer_sizey:=y;
  andlayer_sizex:=x-1;
  andlayer_sizey:=y-1;
END;

PROCEDURE DeInitLayers;
 Var v : longint;
BEGIN
  for v:=0 to maxlayers do
   freemem(layers[v]);
END;


FUNCTION  MyRandom : longint;
BEGIN
  seedvalue:=seedvalue * $15A4E35;
  myrandom:=seedvalue shr 16;
END;


FUNCTION MySqrtInt(n : longint) : longint;{$IFDEF FPC}assembler;
{$ELSE}
BEGIN
{$ENDIF}
  ASM
   mov eax,n
   or  eax,eax
   je  @@fertig2
   {$IFNDEF FPC}
   push ebx
   push esi
   {$ENDIF}
   xor edx,edx
   mov ebx,eax
   mov ecx,eax
   xor esi,esi
  @@iterat:
   div ebx
   add eax,ebx
   shr eax,1
   sub esi,eax
   cmp esi,1
   jbe @@fertig
   mov esi,eax
   mov ebx,eax
   xor edx,edx
   mov eax,ecx
   jmp @@iterat
  @@fertig:
{$IFNDEF FPC}
   pop esi
   pop ebx
   mov n,eax
  @@fertig2:
  END;
  mysqrtint:=n;
{$ELSE}
  @@fertig2:
{$ENDIF}
END;


FUNCTION  MySqrtFloat(f : single) : single;
//Can approximate VERY kewl, but also VERY rough in some floating-number areas, TEST!!!
BEGIN
  ASM
   mov eax,f
   sub eax,$3F800000
   sar eax,1
   add eax,$3F800000
   mov f,eax
  END;
  mysqrtfloat:=f;
END;


FUNCTION CosineInterpolate(var o : array of color; x,y : single) : color;
 Var f1,f2,mf1,mf2 : single;
     g0,g1,g2,g3 : single;
BEGIN
  mf1 := (1.0 - cos(x * pi)) * 0.5;
  mf2 := (1.0 - cos(y * pi)) * 0.5;
  f1 := 1.0-mf1;
  f2 := 1.0-mf2;

  g0 := f1*f2;
  g1 := mf1*f2;
  g2 := f1*mf2;
  g3 := mf1*mf2;

  cosineinterpolate.r := trunc(o[0].r*g0 + o[1].r*g1 + o[2].r*g2 + o[3].r*g3);
  cosineinterpolate.g := trunc(o[0].g*g0 + o[1].g*g1 + o[2].g*g2 + o[3].g*g3);
  cosineinterpolate.b := trunc(o[0].b*g0 + o[1].b*g1 + o[2].b*g2 + o[3].b*g3);
END;


FUNCTION  getBilerpPixel(l : longint; x,y : single) : color;
 Var corner : array[0..3]of color;
     xi,yi,yip,xip1,yip1 : longint;
BEGIN
  xi:=trunc(x);
  yi:=trunc(y);

  xip1:=(xi+1) and andlayer_sizex;
  yip1:=((yi+1) and andlayer_sizey)*layer_sizex;
  yip:=(yi and andlayer_sizey)*layer_sizex;

  corner[0] := layers[l]^[xi and andlayer_sizex + yip];
  corner[1] := layers[l]^[xip1 + yip];
  corner[2] := layers[l]^[xi and andlayer_sizex + yip1];
  corner[3] := layers[l]^[xip1 + yip1];

  getBilerpPixel:=cosineinterpolate(corner, x-xi, y-yi);
END;


PROCEDURE SubPlasma(l,dist,seed,amplitude : longint; rgb : boolean);
 Var x, y, a, b, offset, offset2, offsetb : longint;
     corner : array[0..3]of color;
     oodist,bdist : single;
BEGIN
  fillchar(layers[l]^,layer_sizex*layer_sizey*sizeof(color),0);

  if (seed<>0) then seedvalue:=seed; //Init "Randomizer"

  y:=0;
  while y<layer_sizey do begin
   x:=0;
   offset2:=y*layer_sizex;
   while x<layer_sizex do begin
    offset:=x + offset2;

    layers[l]^[offset].r := myrandom and (amplitude-1);
    if rgb then begin
     layers[l]^[offset].g := myrandom and (amplitude-1);
     layers[l]^[offset].b := myrandom and (amplitude-1);
    end else begin
     layers[l]^[offset].g := layers[l]^[offset].r;
     layers[l]^[offset].b := layers[l]^[offset].r;
    end;

    inc(x,dist);
   end;
   inc(y,dist);
  end;

  if (dist<=1) then exit;

  oodist:=1.0/dist;

  y:=0;
  while y<layer_sizey do begin
   x:=0;
   offset:=y*layer_sizex;
   offset2:=((y+dist) and andlayer_sizey)*layer_sizex;
   while x<layer_sizex do begin
    corner[0] := layers[l]^[x + offset];
    corner[1] := layers[l]^[((x+dist) and andlayer_sizex) + offset];
    corner[2] := layers[l]^[x + offset2];
    corner[3] := layers[l]^[((x+dist) and andlayer_sizex) + offset2];
    for b:=0 to dist-1 do begin
     offsetb:=((y+b) and andlayer_sizey)*layer_sizex;
     bdist:=b*oodist;
     for a:=0 to dist-1 do
      layers[l]^[((x+a) and andlayer_sizex) + offsetb]:=cosineinterpolate(corner, a*oodist, bdist);
    end;
    inc(x,dist);
   end;
   inc(y,dist);
  end;

END;


PROCEDURE SinePlasma(l : longint; dx,dy,amplitude : single);
 Var x,y,offset : longint;
     f : single;
BEGIN
  amplitude:=amplitude*0.00390625; //1.0/256.0

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   f:=127.0+63.5*sin(y*dy);
   for x:=0 to layer_sizex-1 do begin
    layers[l]^[x+offset].r := trunc((63.5*sin(x*dx) + f)*amplitude);
    layers[l]^[x+offset].g := layers[l]^[x+offset].r;
    layers[l]^[x+offset].b := layers[l]^[x+offset].r;
   end;
  end;
END;


PROCEDURE AddLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var v : longint;
     r,g,b : single;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   r:=layers[src1]^[v].r*perc1 + layers[src2]^[v].r*perc2;
   g:=layers[src1]^[v].g*perc1 + layers[src2]^[v].g*perc2;
   b:=layers[src1]^[v].b*perc1 + layers[src2]^[v].b*perc2;

   if r>=255.0 then layers[dest]^[v].r:=255
    else if r<=0.0 then layers[dest]^[v].r:=0
     else layers[dest]^[v].r:=trunc(r);
   if g>=255.0 then layers[dest]^[v].g:=255
    else if g<=0.0 then layers[dest]^[v].g:=0
     else layers[dest]^[v].g:=trunc(g);
   if b>=255.0 then layers[dest]^[v].b:=255
    else if b<=0.0 then layers[dest]^[v].b:=0
     else layers[dest]^[v].b:=trunc(b);
  end;
END;


PROCEDURE MulLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var v : longint;
     r,g,b,perc : single;
BEGIN
  perc:=perc1*perc2*0.00392156862745; //1.0/255.0
  
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   r:=layers[src1]^[v].r*layers[src2]^[v].r*perc;
   g:=layers[src1]^[v].g*layers[src2]^[v].g*perc;
   b:=layers[src1]^[v].b*layers[src2]^[v].b*perc;

   if r>=255.0 then layers[dest]^[v].r:=255
    else if r<=0.0 then layers[dest]^[v].r:=0
     else layers[dest]^[v].r:=trunc(r);
   if g>=255.0 then layers[dest]^[v].g:=255
    else if g<=0.0 then layers[dest]^[v].g:=0
     else layers[dest]^[v].g:=trunc(g);
   if b>=255.0 then layers[dest]^[v].b:=255
    else if b<=0.0 then layers[dest]^[v].b:=0
     else layers[dest]^[v].b:=trunc(b);
  end;
END;


PROCEDURE InvertLayer(src,dest : longint);
 Var v : longint;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[v].r:=255 - layers[src]^[v].r;
   layers[dest]^[v].g:=255 - layers[src]^[v].g;
   layers[dest]^[v].b:=255 - layers[src]^[v].b;
  end;
END;


PROCEDURE EmbossLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r1,g1,b1,r2,g2,b2 : longint;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);
    r1:= 128
         -layers[templ]^[offsetxm1 + offsetym1].r
         -layers[templ]^[offsetxm1 + offset].r
         -layers[templ]^[offsetxm1 + offsetyp1].r
         +layers[templ]^[offsetxp1 + offsetym1].r
         +layers[templ]^[offsetxp1 + offset].r
         +layers[templ]^[offsetxp1 + offsetyp1].r;
    g1:= 128
         -layers[templ]^[offsetxm1 + offsetym1].g
         -layers[templ]^[offsetxm1 + offset].g
         -layers[templ]^[offsetxm1 + offsetyp1].g
         +layers[templ]^[offsetxp1 + offsetym1].g
         +layers[templ]^[offsetxp1 + offset].g
         +layers[templ]^[offsetxp1 + offsetyp1].g;
    b1:= 128
         -layers[templ]^[offsetxm1 + offsetym1].b
         -layers[templ]^[offsetxm1 + offset].b
         -layers[templ]^[offsetxm1 + offsetyp1].b
         +layers[templ]^[offsetxp1 + offsetym1].b
         +layers[templ]^[offsetxp1 + offset].b
         +layers[templ]^[offsetxp1 + offsetyp1].b;
    r2:= 128
         -layers[templ]^[offsetym1 + offsetxm1].r
         -layers[templ]^[offsetym1 + x].r
         -layers[templ]^[offsetym1 + offsetxp1].r
         +layers[templ]^[offsetyp1 + offsetxm1].r
         +layers[templ]^[offsetyp1 + x].r
         +layers[templ]^[offsetyp1 + offsetxp1].r;
    g2:= 128
         -layers[templ]^[offsetym1 + offsetxm1].g
         -layers[templ]^[offsetym1 + x].g
         -layers[templ]^[offsetym1 + offsetxp1].g
         +layers[templ]^[offsetyp1 + offsetxm1].g
         +layers[templ]^[offsetyp1 + x].g
         +layers[templ]^[offsetyp1 + offsetxp1].g;
    b2:= 128
         -layers[templ]^[offsetym1 + offsetxm1].b
         -layers[templ]^[offsetym1 + x].b
         -layers[templ]^[offsetym1 + offsetxp1].b
         +layers[templ]^[offsetyp1 + offsetxm1].b
         +layers[templ]^[offsetyp1 + x].b
         +layers[templ]^[offsetyp1 + offsetxp1].b;

    r1 := mysqrtint(r1*r1+r2*r2);
    g1 := mysqrtint(g1*g1+g2*g2);
    b1 := mysqrtint(b1*b1+b2*b2);

    if r1>255 then layers[dest]^[x + offset].r:=255
     else if r1<0 then layers[dest]^[x + offset].r:=0
      else layers[dest]^[x + offset].r:=r1;
    if g1>255 then layers[dest]^[x + offset].g:=255
     else if g1<0 then layers[dest]^[x + offset].g:=0
      else layers[dest]^[x + offset].g:=g1;
    if b1>255 then layers[dest]^[x + offset].b:=255
     else if b1<0 then layers[dest]^[x + offset].b:=0
      else layers[dest]^[x + offset].b:=b1;
   end;
  end;
END;


PROCEDURE BlurLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r,g,b : longint;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);
    r := (layers[templ]^[offsetxm1 + offsetym1].r
         +2*layers[templ]^[offsetxm1 + offset].r
         +layers[templ]^[offsetxm1 + offsetyp1].r
         +layers[templ]^[offsetxp1 + offsetym1].r
         +2*layers[templ]^[offsetxp1 + offset].r
         +layers[templ]^[offsetxp1 + offsetyp1].r
         +2*layers[templ]^[x + offsetym1].r
         +4*layers[templ]^[x + offset].r
         +2*layers[templ]^[x + offsetyp1].r) shr 4;
    g := (layers[templ]^[offsetxm1 + offsetym1].g
         +2*layers[templ]^[offsetxm1 + offset].g
         +layers[templ]^[offsetxm1 + offsetyp1].g
         +layers[templ]^[offsetxp1 + offsetym1].g
         +2*layers[templ]^[offsetxp1 + offset].g
         +layers[templ]^[offsetxp1 + offsetyp1].g
         +2*layers[templ]^[x + offsetym1].g
         +4*layers[templ]^[x + offset].g
         +2*layers[templ]^[x + offsetyp1].g) shr 4;
    b := (layers[templ]^[offsetxm1 + offsetym1].b
         +2*layers[templ]^[offsetxm1 + offset].b
         +layers[templ]^[offsetxm1 + offsetyp1].b
         +layers[templ]^[offsetxp1 + offsetym1].b
         +2*layers[templ]^[offsetxp1 + offset].b
         +layers[templ]^[offsetxp1 + offsetyp1].b
         +2*layers[templ]^[x + offsetym1].b
         +4*layers[templ]^[x + offset].b
         +2*layers[templ]^[x + offsetyp1].b) shr 4;

    layers[dest]^[x + offset].r := r;
    layers[dest]^[x + offset].g := g;
    layers[dest]^[x + offset].b := b;
   end;
  end;
END;


PROCEDURE SharpenLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r,g,b : longint;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);
    r := (5*layers[templ]^[x + offset].r shr 1)
         -((layers[templ]^[offsetxm1 + offsetym1].r
           +layers[templ]^[offsetxm1 + offsetyp1].r
           +layers[templ]^[offsetxp1 + offsetym1].r
           +layers[templ]^[offsetxp1 + offsetyp1].r) shr 3)
         -((layers[templ]^[offsetxm1 + offset].r
           +layers[templ]^[offsetxp1 + offset].r
           +layers[templ]^[x + offsetym1].r
           +layers[templ]^[x + offsetyp1].r) shr 2);
    g := (5*layers[templ]^[x + offset].g shr 1)
         -((layers[templ]^[offsetxm1 + offsetym1].g
           +layers[templ]^[offsetxm1 + offsetyp1].g
           +layers[templ]^[offsetxp1 + offsetym1].g
           +layers[templ]^[offsetxp1 + offsetyp1].g) shr 3)
         -((layers[templ]^[offsetxm1 + offset].g
           +layers[templ]^[offsetxp1 + offset].g
           +layers[templ]^[x + offsetym1].g
           +layers[templ]^[x + offsetyp1].g) shr 2);
    b := (5*layers[templ]^[x + offset].b shr 1)
         -((layers[templ]^[offsetxm1 + offsetym1].b
           +layers[templ]^[offsetxm1 + offsetyp1].b
           +layers[templ]^[offsetxp1 + offsetym1].b
           +layers[templ]^[offsetxp1 + offsetyp1].b) shr 3)
         -((layers[templ]^[offsetxm1 + offset].b
           +layers[templ]^[offsetxp1 + offset].b
           +layers[templ]^[x + offsetym1].b
           +layers[templ]^[x + offsetyp1].b) shr 2);

    if r>255 then layers[dest]^[x + offset].r:=255
     else if r<0 then layers[dest]^[x + offset].r:=0
      else layers[dest]^[x + offset].r:=r;
    if g>255 then layers[dest]^[x + offset].g:=255
     else if g<0 then layers[dest]^[x + offset].g:=0
      else layers[dest]^[x + offset].g:=g;
    if b>255 then layers[dest]^[x + offset].b:=255
     else if b<0 then layers[dest]^[x + offset].b:=0
      else layers[dest]^[x + offset].b:=b;
   end;
  end;
END;


PROCEDURE EdgeVLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r,g,b : longint;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);
    r := abs(layers[templ]^[offsetxm1 + offsetym1].r
         +2*layers[templ]^[offsetxm1 + offset].r
         +layers[templ]^[offsetxm1 + offsetyp1].r
         -layers[templ]^[offsetxp1 + offsetym1].r
         -2*layers[templ]^[offsetxp1 + offset].r
         -layers[templ]^[offsetxp1 + offsetyp1].r)*2;
    g := abs(layers[templ]^[offsetxm1 + offsetym1].g
         +2*layers[templ]^[offsetxm1 + offset].g
         +layers[templ]^[offsetxm1 + offsetyp1].g
         -layers[templ]^[offsetxp1 + offsetym1].g
         -2*layers[templ]^[offsetxp1 + offset].g
         -layers[templ]^[offsetxp1 + offsetyp1].g)*2;
    b := abs(layers[templ]^[offsetxm1 + offsetym1].b
         +2*layers[templ]^[offsetxm1 + offset].b
         +layers[templ]^[offsetxm1 + offsetyp1].b
         -layers[templ]^[offsetxp1 + offsetym1].b
         -2*layers[templ]^[offsetxp1 + offset].b
         -layers[templ]^[offsetxp1 + offsetyp1].b)*2;

    if r>255 then layers[dest]^[x + offset].r:=255
     else {if r<0 then layers[dest]^[x + offset].r:=0
      else} layers[dest]^[x + offset].r:=r;
    if g>255 then layers[dest]^[x + offset].g:=255
     else {if g<0 then layers[dest]^[x + offset].g:=0
      else} layers[dest]^[x + offset].g:=g;
    if b>255 then layers[dest]^[x + offset].b:=255
     else {if b<0 then layers[dest]^[x + offset].b:=0
      else} layers[dest]^[x + offset].b:=b;
   end;
  end;
END;


PROCEDURE EdgeHLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r,g,b : longint;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);
    r := abs(layers[templ]^[offsetym1 + offsetxm1].r
         +2*layers[templ]^[offsetym1 + x].r
         +layers[templ]^[offsetym1 + offsetxp1].r
         -layers[templ]^[offsetyp1 + offsetxm1].r
         -2*layers[templ]^[offsetyp1 + x].r
         -layers[templ]^[offsetyp1 + offsetxp1].r)*2;
    g := abs(layers[templ]^[offsetym1 + offsetxm1].g
         +2*layers[templ]^[offsetym1 + x].g
         +layers[templ]^[offsetym1 + offsetxp1].g
         -layers[templ]^[offsetyp1 + offsetxm1].g
         -2*layers[templ]^[offsetyp1 + x].g
         -layers[templ]^[offsetyp1 + offsetxp1].g)*2;
    b := abs(layers[templ]^[offsetym1 + offsetxm1].b
         +2*layers[templ]^[offsetym1 + x].b
         +layers[templ]^[offsetym1 + offsetxp1].b
         -layers[templ]^[offsetyp1 + offsetxm1].b
         -2*layers[templ]^[offsetyp1 + x].b
         -layers[templ]^[offsetyp1 + offsetxp1].b)*2;

    if r>255 then layers[dest]^[x + offset].r:=255
     else {if r<0 then layers[dest]^[x + offset].r:=0
      else} layers[dest]^[x + offset].r:=r;
    if g>255 then layers[dest]^[x + offset].g:=255
     else {if g<0 then layers[dest]^[x + offset].g:=0
      else} layers[dest]^[x + offset].g:=g;
    if b>255 then layers[dest]^[x + offset].b:=255
     else {if b<0 then layers[dest]^[x + offset].b:=0
      else} layers[dest]^[x + offset].b:=b;
   end;
  end;
END;


PROCEDURE ColorLayer(l : longint; r,g,b : byte);
 Var v : longint;
     col : color;
BEGIN
  col.r:=r; col.g:=g; col.b:=b;
  for v:=0 to layer_sizex*layer_sizey-1 do
   layers[l]^[v]:=col;
END;


PROCEDURE ScaleLayerRGB(src,dest : longint; r,g,b : single);
 Var v : longint;
     tr,tg,tb : single;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   tr:=layers[src]^[v].r*r;
   tg:=layers[src]^[v].g*g;
   tb:=layers[src]^[v].b*b;

   if tr>=255.0 then layers[dest]^[v].r:=255
    else if tr<=0.0 then layers[dest]^[v].r:=0
     else layers[dest]^[v].r:=trunc(tr);
   if tg>=255.0 then layers[dest]^[v].g:=255
    else if tg<=0.0 then layers[dest]^[v].g:=0
     else layers[dest]^[v].g:=trunc(tg);
   if tb>=255.0 then layers[dest]^[v].b:=255
    else if tb<=0.0 then layers[dest]^[v].b:=0
     else layers[dest]^[v].b:=trunc(tb);
  end;
END;


PROCEDURE ScaleLayerHSV(src,dest : longint; h,s,v : single);
 Var k : longint;
     th,ts,tv,tr,tg,tb : single;
BEGIN
  for k:=0 to layer_sizex*layer_sizey-1 do begin
   rgb2hsv(layers[src]^[k].r,layers[src]^[k].g,layers[src]^[k].b,th,ts,tv);

   th:=th*h;
   ts:=ts*s;
   tv:=tv*v;

   if ts>1.0 then ts:=1.0
    else if ts<0.0 then ts:=0.0;
   if tv>255.0 then tv:=255.0
    else if tv<0.0 then tv:=0.0;

   hsv2rgb(th,ts,tv,tr,tg,tb);

   layers[dest]^[k].r:=trunc(tr);
   layers[dest]^[k].g:=trunc(tg);
   layers[dest]^[k].b:=trunc(tb);
  end;
END;


PROCEDURE AdjustLayerRGB(src,dest : longint; r,g,b : longint);
 Var v : longint;
     tr,tg,tb : longint;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   tr:=layers[src]^[v].r+r;
   tg:=layers[src]^[v].g+g;
   tb:=layers[src]^[v].b+b;

   if tr>255 then layers[dest]^[v].r:=255
    else if tr<0 then layers[dest]^[v].r:=0
     else layers[dest]^[v].r:=tr;
   if tg>255 then layers[dest]^[v].g:=255
    else if tg<0 then layers[dest]^[v].g:=0
     else layers[dest]^[v].g:=tg;
   if tb>255 then layers[dest]^[v].b:=255
    else if tb<0 then layers[dest]^[v].b:=0
     else layers[dest]^[v].b:=tb;
  end;
END;


PROCEDURE AdjustLayerHSV(src,dest : longint; h,s,v : single);
 Var k : longint;
     th,ts,tv,tr,tg,tb : single;
BEGIN
  for k:=0 to layer_sizex*layer_sizey-1 do begin
   rgb2hsv(layers[src]^[k].r,layers[src]^[k].g,layers[src]^[k].b,th,ts,tv);

   th:=th+h;
   ts:=ts+s;
   tv:=tv+v;

   if ts>1.0 then ts:=1.0
    else if ts<0.0 then ts:=0.0;
   if tv>255.0 then tv:=255.0
    else if tv<0.0 then tv:=0.0;

   hsv2rgb(th,ts,tv,tr,tg,tb);

   layers[dest]^[k].r:=trunc(tr);
   layers[dest]^[k].g:=trunc(tg);
   layers[dest]^[k].b:=trunc(tb);
  end;
END;


PROCEDURE hsv2rgb(h,s,v : single; var r,g,b : single);
 Var f, p, q, t, i : single;
BEGIN
   while (h < 0.0) do h:=h+360.0;
   while (h >= 360.0) do h:=h-360.0;

   if (s=0.0) then begin
    r := v;
    g := v;
    b := v;
   end else begin
    h := h*0.016666667; //1.0/60.0
    i := trunc(h); //floor(h);
    f := h - i;
    p := v * (1.0 - s);
    q := v * (1.0 - (s*f));
    t := v * (1.0 - (s*(1.0 - f)));

    case round(i) of
     0: begin r := v; g := t; b := p; end;
     1: begin r := q; g := v; b := p; end;
     2: begin r := p; g := v; b := t; end;
     3: begin r := p; g := q; b := v; end;
     4: begin r := t; g := p; b := v; end;
     5: begin r := v; g := p; b := q; end;
    end;
   end;
END;

PROCEDURE rgb2hsv(r,g,b : single; var h,s,v : single);
 Var max, min, delta, maxr, maxg, maxb : single;
BEGIN
  if (r > g) then max := r
   else max := g;

  if (b > max) then max := b;

  if (r < g) then min := r
   else min := g;

  if (b < min) then min := b;

  v := max;
  s := 0.0;

  if (max <> 0.0) then
   s :=((max - min)/max);

  if (s = 0.0) then h := -1.0
   else begin
    delta := max - min;
    maxr := max - r;
    maxg := max - g;
    maxb := max - b;

    if (r = max) then h := (maxb - maxg)/delta
     else if (g = max) then h := 2.0 + ((maxr - maxb)/delta)
      else if (b = max) then h := 4.0 + ((maxg - maxr)/delta);

    h := h*60.0;
    while (h < 0.0) do h := h+360.0;
    while (h >= 360.0) do h := h-360.0;
   end;
END;


PROCEDURE PerlinNoise(l,dist,seed,amplitude,persistence,octaves : longint; rgb : boolean);
 Var i,v,r,g,b : longint;
BEGIN
  subPlasma(l, dist, seed, 1, rgb);

  for i:=0 to octaves-2 do begin
   amplitude := (amplitude*persistence) shr 8;
   if (amplitude <= 0) then exit;
   dist := dist shr 1;
   if (dist <= 0) then exit;
   subPlasma(templ, dist, 0, amplitude, rgb);
   for v:=0 to layer_sizex*layer_sizey-1 do begin //addLayers(l, templ, l, 1.0, 1.0);
    r:=layers[l]^[v].r+layers[templ]^[v].r;
    if (r>255) then layers[l]^[v].r:=255
     else layers[l]^[v].r:=r;
    g:=layers[l]^[v].g+layers[templ]^[v].g;
    if (g>255) then layers[l]^[v].g:=255
     else layers[l]^[v].g:=g;
    b:=layers[l]^[v].b+layers[templ]^[v].b;
    if (b>255) then layers[l]^[v].b:=255
     else layers[l]^[v].b:=b;
   end;
  end;
END;


PROCEDURE WoodLayer(src, dest, b : longint);
 Var i : longint;
     bm8 : longint;
BEGIN
  bm8:=8-b;

  for i:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[i].r := (layers[src]^[i].r shl b) or (layers[src]^[i].r shr bm8);
   layers[dest]^[i].g := (layers[src]^[i].g shl b) or (layers[src]^[i].g shr bm8);
   layers[dest]^[i].b := (layers[src]^[i].b shl b) or (layers[src]^[i].b shr bm8);
  end;
END;


PROCEDURE SineDistort(src,dest : longint; dx,depthx,dy,depthy : single);
 Var x,y,offset : longint;
     nx,ny,sx : single;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   sx:=sin(y*dx)*depthx;
   for x:=0 to layer_sizex-1 do begin
    nx := x + sx;
    ny := y + sin(x*dy)*depthy;

    layers[dest]^[x+offset] := getBilerpPixel(templ, nx, ny);
   end;
  end;
END;


PROCEDURE TwirlLayer(src,dest : longint; rot,scale : single);
 Var x,y, ina,inb,inbp,inap1,inbp1 : longint;
     offset : longint;
     a,b,d,winkel,cw,sw,na,nb : single;
     corner : array[0..3]of color;
     ooscale : single;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  ooscale:=1.0/(scale*sqrt(layer_sizex*layer_sizey*2));

  for y:=0 to layer_sizey-1 do begin
   b := y - layer_sizey div 2;
   offset:=y*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    a := x - layer_sizex div 2;
    d := layer_sizex div 2 - mysqrtfloat(a*a + b*b);

    if (d<=0.0) then begin
     na:=x;  nb:=y;
     ina:=x; inb:=y;
    end else begin
     winkel := rot*d*d*ooscale;
     cw := cos(winkel);
     sw := sin(winkel);
     na := a*cw - b*sw + layer_sizex div 2;
     nb := a*sw + b*cw + layer_sizey div 2;
     ina := trunc(na);
     inb := trunc(nb);
    end;

    inbp := (inb and andlayer_sizey)*layer_sizex;
    inbp1 := ((inb+1) and andlayer_sizey)*layer_sizex;
    inap1 := (ina+1) and andlayer_sizex;
    corner[0] := layers[templ]^[(ina and andlayer_sizex) + inbp];
    corner[1] := layers[templ]^[inap1 + inbp];
    corner[2] := layers[templ]^[(ina  and andlayer_sizex) + inbp1];
    corner[3] := layers[templ]^[inap1 + inbp1];

    layers[dest]^[x + offset]:=cosineinterpolate(corner, na-ina, nb-inb);
   end;
  end;
END;


PROCEDURE MapDistort(src,dist,dest : longint; xd,yd : single);
 Var x,y,offset : longint;
     x_move,y_move,h,s,v : single;
BEGIN
  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    rgb2hsv(layers[dist]^[x+offset].r,layers[dist]^[x+offset].g,layers[dist]^[x+offset].b,h,s,v);
    x_move:=v*xd;
    y_move:=v*yd;
    layers[templ]^[x+offset] := getBilerpPixel(src, x+x_move, y+y_move);
   end;
  end;

  move(layers[templ]^,layers[dest]^,layer_sizex*layer_sizey*sizeof(color));
END;


PROCEDURE TileLayer(src,dest : longint);
 Var x,y,offset,offset2,offset3 : longint;
BEGIN
  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offset2:=(y*2 and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offset3:=(x*2 and andlayer_sizex)+offset2;
    layers[templ]^[x+offset].r := (layers[src]^[offset3].r+layers[src]^[offset3+1].r+layers[src]^[offset3+layer_sizex].r+layers[src]^[offset3+layer_sizex+1].r) shr 2;
    layers[templ]^[x+offset].g := (layers[src]^[offset3].g+layers[src]^[offset3+1].g+layers[src]^[offset3+layer_sizex].g+layers[src]^[offset3+layer_sizex+1].g) shr 2;
    layers[templ]^[x+offset].b := (layers[src]^[offset3].b+layers[src]^[offset3+1].b+layers[src]^[offset3+layer_sizex].b+layers[src]^[offset3+layer_sizex+1].b) shr 2;
   end;
  end;

  move(layers[templ]^,layers[dest]^,layer_sizex*layer_sizey*sizeof(color));
END;


PROCEDURE Particle(l : longint; f : single);
 Var x,y,offset : longint;
     nx,ny,r : single;
     oolsxd2,oolsyd2 : single;
BEGIN
  oolsxd2:=1.0/(layer_sizex div 2);
  oolsyd2:=1.0/(layer_sizey div 2);
  f:=f*180.0;

  for y:=0 to layer_sizey-1 do begin
   ny:=(y-layer_sizey div 2)*oolsyd2;
   offset:=y*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    nx:=(x-layer_sizex div 2)*oolsxd2;
    r := 255.0 - f*mysqrtfloat(nx*nx+ny*ny); //"stunning gradient effect" plus approximation errors  =) 

    if r<0.0 then layers[l]^[x+offset].r:=0
     else if r>255.0 then layers[l]^[x+offset].r:=255
      else layers[l]^[x+offset].r:=trunc(r);

    layers[l]^[x+offset].g := layers[l]^[x+offset].r;
    layers[l]^[x+offset].b := layers[l]^[x+offset].r;
   end;
  end;
END;


PROCEDURE SineLayerRGB(src,dest : longint; r,g,b : single);
 Var i : longint;
BEGIN
  r:=r*pi; g:=g*pi; b:=b*pi;

  for i:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[i].r := trunc(127.5*(sin(layers[src]^[i].r*r)+1.0));
   layers[dest]^[i].g := trunc(127.5*(sin(layers[src]^[i].g*g)+1.0));
   layers[dest]^[i].b := trunc(127.5*(sin(layers[src]^[i].b*b)+1.0));
  end;
END;


PROCEDURE NoiseDistort(src,dest,seed,radius : longint);
 Var x,y,dx,dy,offset : longint;
BEGIN
  seedvalue:=seed;
  radius:=16-radius;

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    dx:=(myrandom-32767) shr radius;
    dy:=(myrandom-32767) shr radius;
    layers[templ]^[x+offset]:=layers[src]^[((x+dx) and andlayer_sizex) + ((y+dy) and andlayer_sizey)*layer_sizex];
   end;
  end;

  move(layers[templ]^,layers[dest]^,layer_sizex*layer_sizey*sizeof(color));
END;


PROCEDURE CheckerBoardLayer(l,dx,dy : longint; r1,g1,b1,r2,g2,b2 : byte);
 Var col1,col2,scol : Color;
     x,y,offset : longint;
     flipcol : boolean;
BEGIN
  col1.r:=r1; col1.g:=g1; col1.b:=b1;
  col2.r:=r2; col2.g:=g2; col2.b:=b2;

  flipcol:=((layer_sizex div dx) and 1=0) and (layer_sizex mod dx<>0);

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   if (y mod dy=0) then begin scol:=col1; col1:=col2; col2:=scol; end; //OPTIMIZE?!
   for x:=0 to layer_sizex-1 do begin
    if (x mod dx=0) then begin scol:=col1; col1:=col2; col2:=scol; end; //OPTIMIZE?!
    layers[l]^[x+offset] := scol;
   end;
   if flipcol then begin scol:=col1; col1:=col2; col2:=scol; end;
  end;
END;


PROCEDURE MoveDistort(src,dest,dx,dy : longint);
 Var x,y,offset,offset2 : longint;
BEGIN
  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offset2:=((y+dy) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do
    layers[templ]^[x+offset] := layers[src]^[((x+dx) and andlayer_sizex)+offset2];
  end;

  move(layers[templ]^,layers[dest]^,layer_sizex*layer_sizey*sizeof(color));
END;


PROCEDURE EqualizeRGB(src,dest : longint);
 Var histogramr,histogramg,histogramb : array[0..255]of longint;
     i : longint;
     sum_r,sum_g,sum_b,pdiv : single;
BEGIN
  fillchar(histogramr,sizeof(histogramr),0);
  fillchar(histogramg,sizeof(histogramg),0);
  fillchar(histogramb,sizeof(histogramb),0);

  for i:=0 to layer_sizex*layer_sizey-1 do begin
   inc(histogramr[layers[src]^[i].r]);
   inc(histogramg[layers[src]^[i].g]);
   inc(histogramb[layers[src]^[i].b]);
  end;

  sum_r:=0.0; sum_g:=0.0; sum_b:=0.0;
  pdiv:=255.0/(layer_sizex*layer_sizey);

  for i:=0 to 255 do begin
   sum_r:=sum_r+histogramr[i]*pdiv;
   histogramr[i]:=round(sum_r);
   sum_g:=sum_g+histogramg[i]*pdiv;
   histogramg[i]:=round(sum_g);
   sum_b:=sum_b+histogramb[i]*pdiv;
   histogramb[i]:=round(sum_b);
  end;

  for i:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[i].r:=histogramr[layers[src]^[i].r];
   layers[dest]^[i].g:=histogramg[layers[src]^[i].g];
   layers[dest]^[i].b:=histogramb[layers[src]^[i].b];
  end;
END;


PROCEDURE StretchRGB(src,dest : longint);
 Var histogramr,histogramg,histogramb : array[0..255]of longint;
     i,minr,maxr,ming,maxg,minb,maxb : longint;
     sum_r,sum_g,sum_b,pdivr,pdivg,pdivb : single;
BEGIN
  fillchar(histogramr,sizeof(histogramr),0);
  fillchar(histogramg,sizeof(histogramg),0);
  fillchar(histogramb,sizeof(histogramb),0);

  for i:=0 to layer_sizex*layer_sizey-1 do begin
   inc(histogramr[layers[src]^[i].r]);
   inc(histogramg[layers[src]^[i].g]);
   inc(histogramb[layers[src]^[i].b]);
  end;

  i:=-1; repeat inc(i); until (histogramr[i]>0) or (i=255); minr:=i;
  i:=-1; repeat inc(i); until (histogramg[i]>0) or (i=255); ming:=i;
  i:=-1; repeat inc(i); until (histogramb[i]>0) or (i=255); minb:=i;
  i:=256; repeat dec(i); until (histogramr[i]>0) or (i=0); maxr:=i;
  i:=256; repeat dec(i); until (histogramg[i]>0) or (i=0); maxg:=i;
  i:=256; repeat dec(i); until (histogramb[i]>0) or (i=0); maxb:=i;

  sum_r:=minr; sum_g:=ming; sum_b:=minb;
  pdivr:=(maxr-minr)/(layer_sizex*layer_sizey);
  pdivg:=(maxg-ming)/(layer_sizex*layer_sizey);
  pdivb:=(maxb-minb)/(layer_sizex*layer_sizey);

  for i:=0 to 255 do begin
   sum_r:=sum_r+histogramr[i]*pdivr;
   histogramr[i]:=round(sum_r);
   sum_g:=sum_g+histogramg[i]*pdivg;
   histogramg[i]:=round(sum_g);
   sum_b:=sum_b+histogramb[i]*pdivb;
   histogramb[i]:=round(sum_b);
  end;

  for i:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[i].r:=histogramr[layers[src]^[i].r];
   layers[dest]^[i].g:=histogramg[layers[src]^[i].g];
   layers[dest]^[i].b:=histogramb[layers[src]^[i].b];
  end;
END;


PROCEDURE TEX2Mem(var pic : pointer; name : string; dx,dy : longint; allocmem : boolean);
 Var v,x : longint;
     f : file;
     picc : pcardarray;
BEGIN
  if allocmem then reallocmem(pic,dx*dy*4);
  
  initLayers(dx,dy);

  assignfile(f,name);
  reset(f,1);
  blockread(f,stuffOnLayers,sizeof(stuffOnLayers));
  closefile(f);

  for v:=0 to MAXLAYERS-1 do begin
   max_numStuff[v]:=stuffOnLayers[v].num;
   if stuffOnLayers[v].num>0 then
    for x:=0 to stuffOnLayers[v].num-1 do
     doOneStuff(stuffOnLayers[v].nr[x],stuffOnLayers[v].param[x]);
  end;

  picc:=pic;
  for v:=0 to dx*dy-1 do
   picc^[v]:=layers[MAXLAYERS-1]^[v].b or (layers[MAXLAYERS-1]^[v].g shl 8) or (layers[MAXLAYERS-1]^[v].r shl 16);

  deInitLayers;
END;


PROCEDURE KaleidLayer(src,dest,corner : longint);
 Var y : longint;

 PROCEDURE MirrorCorner(c0 : longint);
  Var xc,yc,offset : longint;
 BEGIN
   case c0 of
    0: for yc:=0 to (layer_sizey div 2)-1 do begin
        offset:=yc*layer_sizex;
        for xc:=0 to (layer_sizex div 2)-1 do
         layers[dest]^[offset+(layer_sizex-1-xc)]:=layers[dest]^[offset+xc];
       end;
    1: for yc:=0 to (layer_sizey div 2)-1 do
        move(layers[dest]^[yc*layer_sizex+(layer_sizex div 2)],layers[dest]^[(layer_sizey-1-yc)*layer_sizex+(layer_sizex div 2)],(layer_sizex div 2)*sizeof(Color));
    2: for yc:=0 to (layer_sizey div 2)-1 do begin
        offset:=(yc+(layer_sizey div 2))*layer_sizex;
        for xc:=0 to (layer_sizex div 2)-1 do
         layers[dest]^[offset+xc]:=layers[dest]^[offset+(layer_sizex-1-xc)];
       end;
    3: for yc:=0 to (layer_sizey div 2)-1 do
        move(layers[dest]^[(layer_sizey-1-yc)*layer_sizex],layers[dest]^[yc*layer_sizex],(layer_sizex div 2)*sizeof(Color));
   end;
 END;

BEGIN
  dec(corner);

  for y:=0 to (layer_sizey div 2)-1 do
   move(layers[src]^[(y+(corner div 2)*(layer_sizey div 2))*layer_sizex+(corner mod 2)*(layer_sizex div 2)],layers[dest]^[(y+(corner div 2)*(layer_sizey div 2))*layer_sizex+(corner mod 2)*(layer_sizex div 2)],(layer_sizex div 2)*sizeof(Color));

  mirrorcorner(corner);
  mirrorcorner((corner+1) mod 4);
  mirrorcorner((corner+2) mod 4);
END;


PROCEDURE BlobsLayer(l,seed,amount : longint; rgb : boolean);
 Var blobx,bloby : array[0..15]of longint;
     blobr,blobg,blobb : array[0..15]of single;
     v,x,y,offset,rx,ry : longint;
     r,g,b,d,sd,oosize : single;
BEGIN
  seedvalue:=seed;

  for v:=0 to amount-1 do begin
   blobx[v]:=((myrandom*layer_sizex) shr 8) and andlayer_sizex;
   bloby[v]:=((myrandom*layer_sizey) shr 8) and andlayer_sizey;
   blobr[v]:=((myrandom and 255)*0.00392156862745+0.1)*150.0; //1.0/255.0
   if rgb then begin
    blobg[v]:=((myrandom and 255)*0.00392156862745+0.1)*150.0;
    blobb[v]:=((myrandom and 255)*0.00392156862745+0.1)*150.0; //EXTRA-PARAMS?!
   end;
  end;

  oosize:=1.0/(layer_sizex*layer_sizey*0.333333); //EXTRA-PARAM?!

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    r:=0.0; g:=0.0; b:=0.0;

    for v:=0 to amount-1 do begin
     rx:=blobx[v]-x; ry:=bloby[v]-y;
     d:=(rx*rx+ry*ry)*oosize;
     sd:=d*d;
     d:=-0.444444*sd*d + 1.888888*sd - 2.444444*d + 1.0;
     r:=r+d*blobr[v];
     if rgb then begin
      g:=g+d*blobg[v];
      b:=b+d*blobb[v];
     end;
    end;

    if r<=0.0 then layers[l]^[x+offset].r:=0
     else if r>=255.0 then layers[l]^[x+offset].r:=255
      else layers[l]^[x+offset].r:=trunc(r);

    if rgb then begin
     if g<=0.0 then layers[l]^[x+offset].g:=0
      else if g>=255.0 then layers[l]^[x+offset].g:=255
       else layers[l]^[x+offset].g:=trunc(g);
     if b<=0.0 then layers[l]^[x+offset].b:=0
      else if b>=255.0 then layers[l]^[x+offset].b:=255
       else layers[l]^[x+offset].b:=trunc(b);
    end else begin
     layers[l]^[x+offset].g:=layers[l]^[x+offset].r;
     layers[l]^[x+offset].b:=layers[l]^[x+offset].r;
    end;

   end;
  end;
END;


PROCEDURE TunnelDistort(src,dest : longint; f : single);
 Var x,y, ina,inb,inap1,inbp,inbp1 : longint;
     offset : longint;
     a,b,na,nb : single;
     corner : array[0..3]of color;
     arct,lsd2p : single;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  lsd2p:=layer_sizex/(2.0*pi);

  for y:=0 to layer_sizey-1 do begin
   b := y - layer_sizey div 2;
   offset:=y*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    a := x - layer_sizex div 2;

    if (a<>0.0) then begin
     a:=1.0/a;
     arct:=arctan(b*a);

     if (a>0.0) then na:=lsd2p*arct +(layer_sizex div 2)
      else na:=lsd2p*arct;

     nb:=abs(cos(arct)*f*a);

     ina:=trunc(na);
     inb:=trunc(nb);
     inap1:=(ina+1) and andlayer_sizex;
     inbp:=(inb and andlayer_sizey)*layer_sizex;
     inbp1:=((inb+1) and andlayer_sizey)*layer_sizex;
     corner[0] := layers[templ]^[(ina and andlayer_sizex) + inbp];
     corner[1] := layers[templ]^[inap1 + inbp];
     corner[2] := layers[templ]^[(ina  and andlayer_sizex) + inbp1];
     corner[3] := layers[templ]^[inap1 + inbp1];
    end;

    layers[dest]^[x + offset]:=cosineinterpolate(corner, na-ina, nb-inb);
   end;
  end;
END;


PROCEDURE MotionBlur(src,dest,s : longint);
 Var x,y,offset,offset2,t,r,g,b,sq,ts : longint;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));
  sq:=(s+1)*(s+1);

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    r:=0; g:=0; b:=0;
    for t:=-s to s do begin
     offset2:=offset+(x+t) and andlayer_sizex;
     ts:=(s+1-abs(t));
     inc(r,layers[templ]^[offset2].r*ts);
     inc(g,layers[templ]^[offset2].g*ts);
     inc(b,layers[templ]^[offset2].b*ts);
    end;
    layers[dest]^[offset+x].r:=r div sq;
    layers[dest]^[offset+x].g:=g div sq;
    layers[dest]^[offset+x].b:=b div sq;
   end;
  end;
END;


PROCEDURE MakeTilable(src,dest,s : longint);
 Var x,y,offset,offset2 : longint;
     sy,sx : longint;
     sq,sr,sd,srm : single;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));
  s:=layer_sizex div 2 -s;
  sq:=s*s;
  sd:=(layer_sizex div 2)*(layer_sizey div 2)-sq;
  if (sd<>0.0) then sd:=0.75/sd
   else sd:=0.75/0.00001;

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offset2:=(layer_sizey-1-y)*layer_sizex;
   sy:=y-layer_sizey div 2;
   sy:=sy*sy;
   for x:=0 to layer_sizex-1 do begin
    sx:=x-layer_sizex div 2;
    sr:=sx*sx+sy -sq;
    if (sr>0.0) then begin
     sr:=sr*sd;
     if (sr>0.75) then begin sr:=0.25; srm:=0.25; end
      else begin srm:=1.0-sr; sr:=sr*0.333333; end;
     layers[dest]^[offset+x].r:=trunc(layers[templ]^[offset+x].r*srm+(layers[templ]^[offset+layer_sizex-1-x].r+layers[templ]^[offset2+layer_sizex-1-x].r+layers[templ]^[offset2+x].r)*sr);
     layers[dest]^[offset+x].g:=trunc(layers[templ]^[offset+x].g*srm+(layers[templ]^[offset+layer_sizex-1-x].g+layers[templ]^[offset2+layer_sizex-1-x].g+layers[templ]^[offset2+x].g)*sr);
     layers[dest]^[offset+x].b:=trunc(layers[templ]^[offset+x].b*srm+(layers[templ]^[offset+layer_sizex-1-x].b+layers[templ]^[offset2+layer_sizex-1-x].b+layers[templ]^[offset2+x].b)*sr);
    end;
   end;
  end;
END;


PROCEDURE DilateLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r,g,b : byte;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);

    r:=layers[templ]^[offsetym1 + offsetxm1].r;
    if (layers[templ]^[offsetym1 + x].r>r) then r:=layers[templ]^[offsetym1 + x].r;
    if (layers[templ]^[offsetym1 + offsetxp1].r>r) then r:=layers[templ]^[offsetym1 + offsetxp1].r;
    if (layers[templ]^[offset + offsetxm1].r>r) then r:=layers[templ]^[offset + offsetxm1].r;
    if (layers[templ]^[offset + x].r>r) then r:=layers[templ]^[offset + x].r;
    if (layers[templ]^[offset + offsetxp1].r>r) then r:=layers[templ]^[offset + offsetxp1].r;
    if (layers[templ]^[offsetyp1 + offsetxm1].r>r) then r:=layers[templ]^[offsetyp1 + offsetxm1].r;
    if (layers[templ]^[offsetyp1 + x].r>r) then r:=layers[templ]^[offsetyp1 + x].r;
    if (layers[templ]^[offsetyp1 + offsetxp1].r>r) then r:=layers[templ]^[offsetyp1 + offsetxp1].r;

    g:=layers[templ]^[offsetym1 + offsetxm1].g;
    if (layers[templ]^[offsetym1 + x].g>g) then g:=layers[templ]^[offsetym1 + x].g;
    if (layers[templ]^[offsetym1 + offsetxp1].g>g) then g:=layers[templ]^[offsetym1 + offsetxp1].g;
    if (layers[templ]^[offset + offsetxm1].g>g) then g:=layers[templ]^[offset + offsetxm1].g;
    if (layers[templ]^[offset + x].g>g) then g:=layers[templ]^[offset + x].g;
    if (layers[templ]^[offset + offsetxp1].g>g) then g:=layers[templ]^[offset + offsetxp1].g;
    if (layers[templ]^[offsetyp1 + offsetxm1].g>g) then g:=layers[templ]^[offsetyp1 + offsetxm1].g;
    if (layers[templ]^[offsetyp1 + x].g>g) then g:=layers[templ]^[offsetyp1 + x].g;
    if (layers[templ]^[offsetyp1 + offsetxp1].g>g) then g:=layers[templ]^[offsetyp1 + offsetxp1].g;

    b:=layers[templ]^[offsetym1 + offsetxm1].b;
    if (layers[templ]^[offsetym1 + x].b>b) then b:=layers[templ]^[offsetym1 + x].b;
    if (layers[templ]^[offsetym1 + offsetxp1].b>b) then b:=layers[templ]^[offsetym1 + offsetxp1].b;
    if (layers[templ]^[offset + offsetxm1].b>b) then b:=layers[templ]^[offset + offsetxm1].b;
    if (layers[templ]^[offset + x].b>b) then b:=layers[templ]^[offset + x].b;
    if (layers[templ]^[offset + offsetxp1].b>b) then b:=layers[templ]^[offset + offsetxp1].b;
    if (layers[templ]^[offsetyp1 + offsetxm1].b>b) then b:=layers[templ]^[offsetyp1 + offsetxm1].b;
    if (layers[templ]^[offsetyp1 + x].b>b) then b:=layers[templ]^[offsetyp1 + x].b;
    if (layers[templ]^[offsetyp1 + offsetxp1].b>b) then b:=layers[templ]^[offsetyp1 + offsetxp1].b;

    layers[dest]^[x + offset].r:=r;
    layers[dest]^[x + offset].g:=g;
    layers[dest]^[x + offset].b:=b;
   end;
  end;
END;


PROCEDURE ErodeLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r,g,b : byte;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);

    r:=layers[templ]^[offsetym1 + offsetxm1].r;
    if (layers[templ]^[offsetym1 + x].r<r) then r:=layers[templ]^[offsetym1 + x].r;
    if (layers[templ]^[offsetym1 + offsetxp1].r<r) then r:=layers[templ]^[offsetym1 + offsetxp1].r;
    if (layers[templ]^[offset + offsetxm1].r<r) then r:=layers[templ]^[offset + offsetxm1].r;
    if (layers[templ]^[offset + x].r<r) then r:=layers[templ]^[offset + x].r;
    if (layers[templ]^[offset + offsetxp1].r<r) then r:=layers[templ]^[offset + offsetxp1].r;
    if (layers[templ]^[offsetyp1 + offsetxm1].r<r) then r:=layers[templ]^[offsetyp1 + offsetxm1].r;
    if (layers[templ]^[offsetyp1 + x].r<r) then r:=layers[templ]^[offsetyp1 + x].r;
    if (layers[templ]^[offsetyp1 + offsetxp1].r<r) then r:=layers[templ]^[offsetyp1 + offsetxp1].r;

    g:=layers[templ]^[offsetym1 + offsetxm1].g;
    if (layers[templ]^[offsetym1 + x].g<g) then g:=layers[templ]^[offsetym1 + x].g;
    if (layers[templ]^[offsetym1 + offsetxp1].g<g) then g:=layers[templ]^[offsetym1 + offsetxp1].g;
    if (layers[templ]^[offset + offsetxm1].g<g) then g:=layers[templ]^[offset + offsetxm1].g;
    if (layers[templ]^[offset + x].g<g) then g:=layers[templ]^[offset + x].g;
    if (layers[templ]^[offset + offsetxp1].g<g) then g:=layers[templ]^[offset + offsetxp1].g;
    if (layers[templ]^[offsetyp1 + offsetxm1].g<g) then g:=layers[templ]^[offsetyp1 + offsetxm1].g;
    if (layers[templ]^[offsetyp1 + x].g<g) then g:=layers[templ]^[offsetyp1 + x].g;
    if (layers[templ]^[offsetyp1 + offsetxp1].g<g) then g:=layers[templ]^[offsetyp1 + offsetxp1].g;

    b:=layers[templ]^[offsetym1 + offsetxm1].b;
    if (layers[templ]^[offsetym1 + x].b<b) then b:=layers[templ]^[offsetym1 + x].b;
    if (layers[templ]^[offsetym1 + offsetxp1].b<b) then b:=layers[templ]^[offsetym1 + offsetxp1].b;
    if (layers[templ]^[offset + offsetxm1].b<b) then b:=layers[templ]^[offset + offsetxm1].b;
    if (layers[templ]^[offset + x].b<b) then b:=layers[templ]^[offset + x].b;
    if (layers[templ]^[offset + offsetxp1].b<b) then b:=layers[templ]^[offset + offsetxp1].b;
    if (layers[templ]^[offsetyp1 + offsetxm1].b<b) then b:=layers[templ]^[offsetyp1 + offsetxm1].b;
    if (layers[templ]^[offsetyp1 + x].b<b) then b:=layers[templ]^[offsetyp1 + x].b;
    if (layers[templ]^[offsetyp1 + offsetxp1].b<b) then b:=layers[templ]^[offsetyp1 + offsetxp1].b;

    layers[dest]^[x + offset].r:=r;
    layers[dest]^[x + offset].g:=g;
    layers[dest]^[x + offset].b:=b;
   end;
  end;
END;


PROCEDURE MedianLayer(src,dest : longint);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     v : array[0..4]of byte;

 PROCEDURE Insert_Sort(a : byte);
  Var i,t : longint;
 BEGIN
  if (a<=v[4]) then exit;
  if (a<=v[3]) then begin v[4]:=a; exit; end;

  for t:=0 to 2 do
   if (a>v[t]) then begin
    for i:=3 downto t do v[i+1]:=v[i];
    v[t]:=a;
    exit;
   end;

  v[4]:=v[3];
  v[3]:=a;
 END;

BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);

    fillchar(v[1],sizeof(v)-1,0);
    v[0]:=layers[templ]^[offsetym1 + offsetxm1].r;
    insert_sort(layers[templ]^[offsetym1 + x].r);
    insert_sort(layers[templ]^[offsetym1 + offsetxp1].r);
    insert_sort(layers[templ]^[offset + offsetxm1].r);
    insert_sort(layers[templ]^[offset + x].r);
    insert_sort(layers[templ]^[offset + offsetxp1].r);
    insert_sort(layers[templ]^[offsetyp1 + offsetxm1].r);
    insert_sort(layers[templ]^[offsetyp1 + x].r);
    insert_sort(layers[templ]^[offsetyp1 + offsetxp1].r);
    layers[dest]^[x + offset].r:=v[4];

    fillchar(v[1],sizeof(v)-1,0);
    v[0]:=layers[templ]^[offsetym1 + offsetxm1].g;
    insert_sort(layers[templ]^[offsetym1 + x].g);
    insert_sort(layers[templ]^[offsetym1 + offsetxp1].g);
    insert_sort(layers[templ]^[offset + offsetxm1].g);
    insert_sort(layers[templ]^[offset + x].g);
    insert_sort(layers[templ]^[offset + offsetxp1].g);
    insert_sort(layers[templ]^[offsetyp1 + offsetxm1].g);
    insert_sort(layers[templ]^[offsetyp1 + x].g);
    insert_sort(layers[templ]^[offsetyp1 + offsetxp1].g);
    layers[dest]^[x + offset].g:=v[4];

    fillchar(v[1],sizeof(v)-1,0);
    v[0]:=layers[templ]^[offsetym1 + offsetxm1].b;
    insert_sort(layers[templ]^[offsetym1 + x].b);
    insert_sort(layers[templ]^[offsetym1 + offsetxp1].b);
    insert_sort(layers[templ]^[offset + offsetxm1].b);
    insert_sort(layers[templ]^[offset + x].b);
    insert_sort(layers[templ]^[offset + offsetxp1].b);
    insert_sort(layers[templ]^[offsetyp1 + offsetxm1].b);
    insert_sort(layers[templ]^[offsetyp1 + x].b);
    insert_sort(layers[templ]^[offsetyp1 + offsetxp1].b);
    layers[dest]^[x + offset].b:=v[4];
   end;
  end;
END;


PROCEDURE SculptureLayer(src,dest : longint);
 Const ipi : single=255.0/(2.0*3.1415926536);
 Var x,y,offset,offsetym1,offsetyp1,offsetxm1,offsetxp1 : longint;
     r1,r2,g1,g2,b1,b2 : longint;
     a : single;
BEGIN
  move(layers[src]^,layers[templ]^,layer_sizex*layer_sizey*sizeof(color));

  for y:=0 to layer_sizey-1 do begin
   offset:=y*layer_sizex;
   offsetym1:=((y-1) and andlayer_sizey)*layer_sizex;
   offsetyp1:=((y+1) and andlayer_sizey)*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    offsetxm1:=((x-1) and andlayer_sizex);
    offsetxp1:=((x+1) and andlayer_sizex);

    r1:= layers[templ]^[offsetxm1 + offsetym1].r
         +2*layers[templ]^[offsetxm1 + offset].r
         +layers[templ]^[offsetxm1 + offsetyp1].r
         -layers[templ]^[offsetxp1 + offsetym1].r
         -2*layers[templ]^[offsetxp1 + offset].r
         -layers[templ]^[offsetxp1 + offsetyp1].r;
    r2:= layers[templ]^[offsetym1 + offsetxm1].r
         +2*layers[templ]^[offsetym1 + x].r
         +layers[templ]^[offsetym1 + offsetxp1].r
         -layers[templ]^[offsetyp1 + offsetxm1].r
         -2*layers[templ]^[offsetyp1 + x].r
         -layers[templ]^[offsetyp1 + offsetxp1].r;

    g1:= layers[templ]^[offsetxm1 + offsetym1].g
         +2*layers[templ]^[offsetxm1 + offset].g
         +layers[templ]^[offsetxm1 + offsetyp1].g
         -layers[templ]^[offsetxp1 + offsetym1].g
         -2*layers[templ]^[offsetxp1 + offset].g
         -layers[templ]^[offsetxp1 + offsetyp1].g;
    g2:= layers[templ]^[offsetym1 + offsetxm1].g
         +2*layers[templ]^[offsetym1 + x].g
         +layers[templ]^[offsetym1 + offsetxp1].g
         -layers[templ]^[offsetyp1 + offsetxm1].g
         -2*layers[templ]^[offsetyp1 + x].g
         -layers[templ]^[offsetyp1 + offsetxp1].g;

    b1:= layers[templ]^[offsetxm1 + offsetym1].b
         +2*layers[templ]^[offsetxm1 + offset].b
         +layers[templ]^[offsetxm1 + offsetyp1].b
         -layers[templ]^[offsetxp1 + offsetym1].b
         -2*layers[templ]^[offsetxp1 + offset].b
         -layers[templ]^[offsetxp1 + offsetyp1].b;
    b2:= layers[templ]^[offsetym1 + offsetxm1].b
         +2*layers[templ]^[offsetym1 + x].b
         +layers[templ]^[offsetym1 + offsetxp1].b
         -layers[templ]^[offsetyp1 + offsetxm1].b
         -2*layers[templ]^[offsetyp1 + x].b
         -layers[templ]^[offsetyp1 + offsetxp1].b;

    if (r1=0) then begin
     if r2>0 then layers[dest]^[x + offset].r:=196
      else if r2=0 then layers[dest]^[x + offset].r:=128
       else layers[dest]^[x + offset].r:=64;
    end
    else begin
     a:=arctan(r2/r1);
     if r1>0 then layers[dest]^[x + offset].r:=trunc(a*ipi+127.5)
      else layers[dest]^[x + offset].r:=trunc(a*ipi);
    end;

    if (g1=0) then begin
     if g2>0 then layers[dest]^[x + offset].g:=196
      else if g2=0 then layers[dest]^[x + offset].g:=128
       else layers[dest]^[x + offset].g:=64;
    end
    else begin
     a:=arctan(g2/g1);
     if g1>0 then layers[dest]^[x + offset].g:=trunc(a*ipi+127.5)
      else layers[dest]^[x + offset].g:=trunc(a*ipi);
    end;

    if (b1=0) then begin
     if b2>0 then layers[dest]^[x + offset].b:=196
      else if b2=0 then layers[dest]^[x + offset].b:=128
       else layers[dest]^[x + offset].b:=64;
    end
    else begin
     a:=arctan(b2/b1);
     if b1>0 then layers[dest]^[x + offset].b:=trunc(a*ipi+127.5)
      else layers[dest]^[x + offset].b:=trunc(a*ipi);
    end;
   end;
  end;
END;


PROCEDURE RandCombineLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var x : longint;
     v,v2,mv,mv2 : longint;
BEGIN
  fillchar(layers[templ]^,layer_sizex*layer_sizey*sizeof(color),127);
  perc1:=perc1*1.5;
  perc2:=perc2*1.5;

  seedvalue:=$15A4E35*2;
  v:=0; v2:=0;
  mv:=round(layer_sizex*layer_sizey*perc1);
  mv2:=round(layer_sizex*layer_sizey*perc2);
  while (v<mv) or (v2<mv2) do begin
   if (v<mv) then begin
    x:=((myrandom shr 1) and andlayer_sizex) + ((myrandom and andlayer_sizey)*layer_sizex);
    layers[templ]^[x]:=layers[src1]^[x];
    x:=(myrandom and andlayer_sizex) + (((myrandom shr 2) and andlayer_sizey)*layer_sizex);
    layers[templ]^[x]:=layers[src1]^[x];
    inc(v);
   end;
   if (v2<mv2) then begin
    x:=(((myrandom shr 1) and andlayer_sizey)*layer_sizex) + (myrandom and andlayer_sizex);
    layers[templ]^[x]:=layers[src2]^[x];
    x:=((myrandom and andlayer_sizey)*layer_sizex) + ((myrandom shr 2) and andlayer_sizex);
    layers[templ]^[x]:=layers[src2]^[x];
    inc(v2);
   end;
  end;

  move(layers[templ]^,layers[dest]^,layer_sizex*layer_sizey*sizeof(color));
END;


PROCEDURE MaxCombineLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var v : longint;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   if layers[src1]^[v].r*perc1>layers[src2]^[v].r*perc2 then layers[dest]^[v].r:=layers[src1]^[v].r
    else layers[dest]^[v].r:=layers[src2]^[v].r;
   if layers[src1]^[v].g*perc1>layers[src2]^[v].g*perc2 then layers[dest]^[v].g:=layers[src1]^[v].g
    else layers[dest]^[v].g:=layers[src2]^[v].g;
   if layers[src1]^[v].b*perc1>layers[src2]^[v].b*perc2 then layers[dest]^[v].b:=layers[src1]^[v].b
    else layers[dest]^[v].b:=layers[src2]^[v].b;
  end;
END;


PROCEDURE MinCombineLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var v : longint;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   if layers[src1]^[v].r*perc1<layers[src2]^[v].r*perc2 then layers[dest]^[v].r:=layers[src1]^[v].r
    else layers[dest]^[v].r:=layers[src2]^[v].r;
   if layers[src1]^[v].g*perc1<layers[src2]^[v].g*perc2 then layers[dest]^[v].g:=layers[src1]^[v].g
    else layers[dest]^[v].g:=layers[src2]^[v].g;
   if layers[src1]^[v].b*perc1<layers[src2]^[v].b*perc2 then layers[dest]^[v].b:=layers[src1]^[v].b
    else layers[dest]^[v].b:=layers[src2]^[v].b;
  end;
END;


PROCEDURE XorLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var v : longint;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[v].r:=trunc(layers[src1]^[v].r*perc1) xor trunc(layers[src2]^[v].r*perc2);
   layers[dest]^[v].g:=trunc(layers[src1]^[v].g*perc1) xor trunc(layers[src2]^[v].g*perc2);
   layers[dest]^[v].b:=trunc(layers[src1]^[v].b*perc1) xor trunc(layers[src2]^[v].b*perc2);
  end;
END;


PROCEDURE AndLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var v : longint;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[v].r:=trunc(layers[src1]^[v].r*perc1) and trunc(layers[src2]^[v].r*perc2);
   layers[dest]^[v].g:=trunc(layers[src1]^[v].g*perc1) and trunc(layers[src2]^[v].g*perc2);
   layers[dest]^[v].b:=trunc(layers[src1]^[v].b*perc1) and trunc(layers[src2]^[v].b*perc2);
  end;
END;


PROCEDURE OrLayers(src1,src2,dest : longint; perc1,perc2 : single);
 Var v : longint;
BEGIN
  for v:=0 to layer_sizex*layer_sizey-1 do begin
   layers[dest]^[v].r:=trunc(layers[src1]^[v].r*perc1) or trunc(layers[src2]^[v].r*perc2);
   layers[dest]^[v].g:=trunc(layers[src1]^[v].g*perc1) or trunc(layers[src2]^[v].g*perc2);
   layers[dest]^[v].b:=trunc(layers[src1]^[v].b*perc1) or trunc(layers[src2]^[v].b*perc2);
  end;
END;


PROCEDURE LogPolLayer(src,dest : longint);
 Var e,x,offset : cardinal;
     ef,xf : single;
     piy,xd2,yd2 : single;
BEGIN
  piy:=2.0*pi/layer_sizey;
  xd2:=layer_sizex div 2;
  yd2:=layer_sizey div 2;

  for e:=0 to layer_sizey-1 do begin
   offset:=e*layer_sizex;
   for x:=0 to layer_sizex-1 do begin
    ef:=exp(e*piy);
    xf:=x*piy;
    layers[templ]^[offset+x]:=getBilerpPixel(src, ef*cos(xf)+xd2, ef*sin(xf)+yd2);
   end;
  end;

  move(layers[templ]^,layers[dest]^,layer_sizex*layer_sizey*sizeof(color));
END;


PROCEDURE MandelBrot(l : longint; xs,dx,y,dy,sqr_betrag : single);
 //
 FUNCTION Iter_MB(xx,yy : single) : longint;
  Var zx,zy,szx,szy : single;
      i : longint;
 BEGIN
   zx:=xx;
   zy:=yy;
   //
   for i:=0 to 255 do begin
    szx:=zx*zx;
    szy:=zy*zy;
    if (szx+szy>sqr_betrag) then begin result:=i; exit; end;
    //
    zy:=2.0*zx*zy +yy;
    zx:=szx-szy +xx;
   end;
   //
   result:=255;
 END;
 //
 Var x,ux,uy : single;
     ty,v,base_off : longint;
     c : byte;
BEGIN
  ux:=dx/layer_sizex;
  uy:=dy/layer_sizey;

  base_off:=0;
  for ty:=0 to layer_sizey-1 do begin
   x:=xs;
   for v:=base_off to base_off+layer_sizex-1 do begin
    //
    c:=iter_mb(x,y);
    layers[l]^[v].r:=c;
    layers[l]^[v].g:=not c;
    layers[l]^[v].b:=255-c;
    //
    x:=x+ux;
   end;
   //
   inc(base_off,layer_sizex);
   //
   y:=y+uy;
  end;
END;


PROCEDURE CellMachine(l,seed,rule : longint);
 Var x,y,base_off,m : longint;
     c : color;
BEGIN
  seedvalue:=seed;

  fillchar(layers[l]^,layer_sizex*layer_sizey*sizeof(color),0);
  c.r:=255; c.g:=255; c.b:=255;

  for x:=0 to layer_sizex-1 do
   if (myrandom shr 10=0) then layers[l]^[x]:=c;

  base_off:=0;
  for y:=1 to layer_sizey-1 do begin
   for x:=0 to layer_sizex-1 do begin
    if (layers[l]^[((x-1) and andlayer_sizex) +base_off].r<>0) then m:=1
     else m:=0;
    if (layers[l]^[x+base_off].r<>0) then m:=m or 2;
    if (layers[l]^[((x+1) and andlayer_sizex) +base_off].r<>0) then m:=m or 4;

    if (((1 shl m) and rule)<>0) then layers[l]^[x+base_off+layer_sizex]:=c;
   end;
   //
   inc(base_off,layer_sizex);
  end;
END;

END.