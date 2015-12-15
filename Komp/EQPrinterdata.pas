{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13149: EQPrinterdata.pas
{
{   Rev 1.2    2004-11-03 09:19:48  pb64
{ Fixat så att inget skrivs ut på raderna om det inte finns data i SQL satsen
}
{
{   Rev 1.1    2003-03-21 21:27:56  peter
{ Fixat så att " tecken konverteras till '
}
{
{   Rev 1.0    2003-03-20 14:03:28  peter
}
{
{   Rev 1.0    2003-03-17 10:14:22  Supervisor
}
unit EQPrinterData;

{ EQPrinterData2 }
{*
 * Copyright © 2000 by EQ-Soft AB; all rights reserved
 *
 * Programmer(s):
 *   PBJ (peter.bjorling@eq-soft.se) - 99.5%
 *   p3 (peter.thornqvist@eq-soft.se) - små ändringar
 *
 * Web:
 *   http://www.eq-soft.se
 * Description:
 *   unit som skriver ut rapporter med metadata hämtade från textfil
 *   formatet ännu ej formellt beskrivet
 * TODO:
 * ändra för att använda mer generiska datasets (???)
 * $History: EQPrinterData.pas $
 *
 * *****************  Version 21  *****************
 * User: Peter        Date: 01-07-12   Time: 16:00
 * Updated in $/Components/Utility files
 *
 * *****************  Version 20  *****************
 * User: Peter        Date: 01-07-11   Time: 15:23
 * Updated in $/Components/Utility files
 * Fixat så att datafiler och bitmappar kan ligga i samma katalog som
 * rapportfilerna
 *
 * *****************  Version 19  *****************
 * User: Mikael       Date: 01-04-19   Time: 13:46
 * Updated in $/Components/Utility files
 *
 * *****************  Version 18  *****************
 * User: Peter3       Date: 01-02-07   Time: 13:13
 * Updated in $/Components/Utility files
 * La till DisplayNulls i General. Om värdet är 1, visas även 0 värden upp
 *
 * *****************  Version 17  *****************
 * User: Peter3       Date: 01-01-25   Time: 16:01
 * Updated in $/Components/Utility files
 *
 * *****************  Version 15  *****************
 * User: Peter        Date: 00-10-23   Time: 14:22
 * Updated in $/Components/Utility files
 * Lagt till funktionen "FontText"
 *
 * *****************  Version 14  *****************
 * User: Peter3       Date: 00-10-17   Time: 10:34
 * Updated in $/Components/Utility files
 *
 * *****************  Version 13  *****************
 * User: Peter3       Date: 00-08-25   Time: 16:29
 * Updated in $/Components/Utility files
 * Fixade lite med LOGO taggen
 *
 * *****************  Version 12  *****************
 * User: Peter3       Date: 00-08-25   Time: 14:51
 * Updated in $/Components/Utility files
 * La till hantering av datum och tid i printCurDate resp.
 * printCurDateTime
 *
 * *****************  Version 11  *****************
 * User: Peter3       Date: 00-08-21   Time: 15:36
 * Updated in $/Components/Utility files
 *
 * *****************  Version 10  *****************
 * User: Peter3       Date: 00-08-16   Time: 8:50
 * Updated in $/Components/Utility files
 * Ändrade alla 999 till MaxInt
 * *****************  Version 9  *****************
 * User: Peter3       Date: 00-08-08   Time: 11:44
 * Updated in $/Components/Utility files
 * Tog bort UpperCase i CheckForParams
 *
 * *****************  Version 8  *****************
 * User: Peter3       Date: 00-07-08   Time: 14:57
 * Updated in $/Components/Utility files
 * Tog bort para1..para3
 * La till TParamIndex
 * Tog bort Para1..para3 eftersom de bara skapar förvirring: använd Parametrar istället
 * La till en ny typ, TParamIndex som anger giltigt intervall för Parametrar (1 till 10)
 * *****************  Version 7  *****************
 * User: Peter3       Date: 00-07-06   Time: 10:45
 * Updated in $/Components/Utility files
 * Ny version med Print Preview (Filerna för detta finns i Utilty files,
 * PrevPrinter.pas, PrevForm.pas,
 * PrevForm.dfm,PageSetupDlg.pas,PageSetupDlg.dfm,FormSettings.pas
 * La till PrevPrinter uniten, ändrade lite för att anpassa till hur vi använder den etc
 * OBS! att den här funktionen kräver ett antal extra units (som finns i VSS):
 * PrevPrinter.pas
 * PrevForm.pas/dfm
 * PrinterSetupDlg.pas/dfm
 * FormSettings.pas
 * *****************  Version 6  *****************
 * User: Peter3       Date: 00-05-24   Time: 11:31
 * Updated in $/Components/Utility files
 * Ändrade lite kod för att förbereda för förhandsgranskning:
    * Tog bort hänvisningar till TPrinter som inte behövdes ( t ex fprn.Canvas har ersatts med endast Canvas)
    * La till Canvas property
    * La till if Assigned(fprn) på vissa ställen
 *}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers, db, ADODb, PrevPrinter, utilsMath, Variants,
  EQIniStrings, utilsString;

type
  TParamIndex = 1..10;
  TOnSetQueryEvent = procedure(Sender: TObject; Query: TDataSet; const QueryText: string) of object;
  TOnSetupQueryEvent = procedure(Sender: TObject; var Query: TDataSet) of object;
  TGetNewStream = function(ident: string): TStream;
  TEQPrinterData = class(TObject)
  private
    fReportFileName: string;
    pp: TPreviewPrinter;
    FCanvas: TCanvas;
    fVersion: Integer;
    fLandScape: Integer;
    fLocalQuery: TADOQuery;
    fLocalRowQuery: TADOQuery;
    fRow2Query: TADOQuery;
    fRow3Query: TADOQuery;
    fRow4Query: TADOQuery;
    fRow5Query: TADOQuery;
//    fCommonQuery : TQuery;
    fTextFile: TStringList; // Innehåller filinfo
    fprn: Tprinter;
    fTitle: string;
    fSectionInt: Integer;
    FResolutionY: double;
    FResolutionX: double;
    fStartRow: Integer;
    fMaxRow: Integer;
    fRowHeight: Integer;
    CurrentRow: Integer;
    NoOfRows: Integer;
    FDisplayNulls: boolean;
    FLanguage_List: TStringList;
    FRow_List: TStringList;
    FMall_list: TStringList;
    FNewpage_List: TStringList;
    FHeader_List: TStringList;
    FTotal_List: TStringList;
    FSystemData_List: TStringList;
    FRow2List: TStringList;
    FRow3List: TStringList;
    FRow4List: TStringList;
    FRow5List: TStringList;
    FTotal2List: TStringList;
    FTotal3List: TStringList;
    FTotal4List: TStringList;
    FTotal5List: TStringList;
    FParametrar: Variant;
    FPrinterOrientation: TPrinterOrientation;
    FPreview: Boolean;
    FFont: TFont;
    FCopies: integer;
    FZeroRow, fZeroCol: Integer;
    FList: TList;
    function ReturnSQL(q: TADOQuery; SQL: string): string;
    procedure ReadMultipleSections(ini: TEQIniStrings; SectionName: string; S: TStringList; list: TList);
    procedure SetCanvas(const Value: TCanvas);
    procedure SetResolutionX(const Value: double);
    procedure SetResolutionY(const Value: double);
    procedure SetHeader_List(const Value: TStringList);
    procedure SetLanguage_List(const Value: TStringList);
    procedure SetMall_list(const Value: TStringList);
    procedure SetNewpage_List(const Value: TStringList);
    procedure SetRow_List(const Value: TStringList);
    procedure SetSystemData_List(const Value: TStringList);
    procedure SetTotal_List(const Value: TStringList);
    procedure SplitLine(Str, SubStr: string; var LeftStr, RightString: string);
    procedure DoStartprint;
    procedure DoStartprint2;
    procedure DoStartprint3;
    procedure DoRowprint;
    procedure DoRowprint2;
    procedure DoRowprint3;
    procedure DoTotalprint;
    procedure DoTotalprint3;
//    procedure Setpara1(const Value: String);
//    procedure Setpara2(const Value: String);
//    procedure Setpara3(const Value: String);
    function CheckForparams2(s: string; Q: TADOQuery): string;
    function CheckForparams(s: string): string;
    procedure SetupTQuery(var Q: TADOQuery);
    procedure FreeTQuery(var Q: TADOQuery);
//    function GetPara1: String;
//    function GetPara2: String;
//    function GetPara3: String;
    function GetParametrar(index: TParamIndex): Variant;
    procedure SetParametrar(index: TParamIndex; const Value: Variant);
    function LoadRemoteSection(S: TStringlist): Boolean;
    procedure LoadFile2(const FileName: string);
    procedure SetFont(const Value: TFont);
  public
    Reportpath: string;
    StreamFunc: TGetNewStream;
    constructor Create(prn: TPrinter; Q1, Q2: TDataSet);
    destructor Destroy; override;
    procedure Refresh;
    procedure Print;
    property Copies: integer read FCopies write FCopies default 1;
    property Font: TFont read FFont write SetFont;
    property Preview: Boolean read FPreview write FPreview default true;
    property Canvas: TCanvas read FCanvas write SetCanvas;
    property ResolutionY: double read FResolutionY write SetResolutionY;
    property ResolutionX: double read FResolutionX write SetResolutionX;
    function mm2pixelY(mm: integer): Integer;
    function mm2pixelX(mm: integer): Integer;
    procedure RoundArea(x1, y1, x2, y2, Lines, Tjocklek: Integer);
    procedure TextOut(x1, y1, Size: integer; str: string; Align: Integer);
    procedure WrapTextOut(x1, y1, Size: integer; str: string; Align: Integer);
    procedure BitmapAt(x1, y1, x2, y2: integer; fname: string);
    procedure StraighLine(x1, y1, x2, y2, Lines: Integer);
    property Mall_list: TStringList read FMall_list write SetMall_list;
    property Newpage_List: TStringList read FNewpage_List write SetNewpage_List;
    property Language_List: TStringList read FLanguage_List write
      SetLanguage_List;
    property SystemData_List: TStringList read FSystemData_List write
      SetSystemData_List;
    property Header_List: TStringList read FHeader_List write SetHeader_List;
    property Row_List: TStringList read FRow_List write SetRow_List;
    property Total_List: TStringList read FTotal_List write SetTotal_List;
    procedure LoadFile(fName: string);
    procedure ClearList;
    procedure printSection(l: tStringList);
    procedure printRows(l: Integer; oldQuery: TADOQuery);
    procedure printRowSection(l: tStringList);
    procedure printRowSection1(l: tStringList);
    procedure printLogo(s: string);
    procedure printLine(s: string);
    procedure SetZeroRow(s: string);
    procedure SetZeroCol(s: string);
    procedure SetStartRow(s: string);
    procedure printText(s, dbText: string);
    procedure printWrapText(s, dbText: string);
    procedure printFmtText(s, dbText: string);
    procedure printFontText(s, dbText: string);
    procedure printTextDecimal(s, dbText: string; dec: Integer);
    procedure printRoundArea(s: string);
    procedure printpageCount(s: string);
    procedure printCurdate(s: string; dbText: string = '');
    procedure printCurdateTime(s: string; dbText: string = '');
//    property  para1 : String read GetPara1 write Setpara1;
//    property  para2 : String read GetPara2 write Setpara2;
//    property  para3 : String read GetPara3 write Setpara3;
    property Parametrar[Index: TParamIndex]: Variant read GetParametrar write
    SetParametrar;
    property PrinterOrientation: TPrinterOrientation read FPrinterOrientation
      write FPrinterOrientation;
     // read FParametrar write SetParametrar;
//    procedure DoMall;
//    procedure SetupMall;
//    procedure SetupGenerell;

  end;

implementation

function StrToFloatDef(const S: string; Default: Extended): Extended;
begin
  try
    Result := StrToFloat(S);
  except
    Result := Default;
  end;
end;
{ TEQprinterData }

procedure TEQprinterData.SetupTQuery(var Q: TADOQuery);
begin
  if Q = nil then
  begin
    try
      Q := TADOQuery.Create(nil);
      try
        Q.Connection := fLocalQuery.Connection;
      except
        Q.Free;
        Q := nil;
        {
         SaveErrorLog(Format('TQuery.DataBaseName kan inte sättas   Unit : %s : %s',[uName,'GenericEQSetupTQuery']));
        }
      end;
    except
      Q := nil;
      {
       SaveErrorLog(Format('Fel i vid skapande av TQuery   Unit : %s : %s',[uName,'GenericEQSetupTQuery']));
      }
    end;
  end;
end;

procedure TEQprinterData.FreeTQuery(var Q: TADOQuery);
begin
  if Assigned(Q) then
  begin
    Q.Close;
    Q.Free;
    Q := nil;
  end;
end;


procedure TEQprinterData.BitmapAt(x1, y1, x2, y2: integer; fname: string);
var
  gr: TBitmap;
  R: TRect;
begin
  if FZeroCol <> 0 then
    x1 := x1 + FZeroCol;
  if FZeroRow <> 0 then
    y1 := y1 + FZeroRow;
  try
    if FileExists(ExpandUNCFileName(trim(fName))) then
    begin
      fName := ExpandUNCFileName(trim(fName));
    end
    else
    begin
      if FileExists(ExtractFilePath(fReportFileName) + trim(fname)) then
        FName := ExtractFilePath(fReportFileName) + trim(fname)
      else
        Exit;
    end;
  except
    exit;
  end;

  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  x2 := mm2pixelX(x2);
  y2 := mm2pixelY(y2);

  gr := TBitmap.Create;
  try
    gr.LoadFromFile(fname);
    pp.Canvas.CopyMode := cmSrcCopy;
    if x2 > 0 then
    begin
      R := Rect(X1, Y1, X1 + X2, Y1 + Y2);
      pp.Canvas.StretchDraw(R, gr);
    end
    else
    begin
      x2 := round(gr.Width * 7.2);
      y2 := round(gr.Height * 7.2);
      R := Rect(x1, Y1, x1 + x2, y1 + y2);
      pp.Canvas.StretchDraw(R, gr);
    end;
  finally
    gr.Free;
  end;
end;

function TEQPrinterData.CheckForparams2(s: string; Q: TADOQuery): string;
var i, j, l: Integer;
begin
  if Q <> nil then
    for i := Q.FieldCount - 1 downto 0 do
    begin
      j := Pos(Format(':DATA%d', [i]), AnsiUpperCase(S));
      while j > 0 do
      begin
        l := Length(Format(':DATA%d', [i]));
        S := Copy(S, 1, j - 1) +
          Q.Fields[i].AsString + Copy(S, j + l, MaxInt);
        j := Pos(Format(':DATA%d', [i]), AnsiUpperCase(S));
      end;
    end;

{  if Q <> nil then
    for i := Q.FieldCount - 1 downto 0 do
      while pos(':DATA' + IntToStr(i), uppercase(s)) <> 0 do
        s := Copy(s, 1, pos(':DATA' + IntToStr(i), uppercase(s)) - 1) +
          Q.Fields[i].AsString + Copy(s, pos(':DATA' + IntToStr(i), uppercase(s))
          + length(':DATA' + IntToStr(i)), MaxInt);
}
  Result := CheckForParams(S);
end;

function TEQprinterData.CheckForparams(S: string): string;
var
  i, j, l: Integer;
begin
  if 'MYSQL' = 'DB' then
  begin
    S := StringReplace(S, 'GETDATE()', 'CURRENT_TIMESTAMP', [rfReplaceAll, rfIgnoreCase]);
    S := StringReplace(S, ' TOP 1 ', '', [rfReplaceAll, rfIgnoreCase]);
  end;
  Result := S;
  Result := strReplaceAll(Result, '"', ''''); // AdoFix
  for i := 1 to 9 do
  begin
    j := Pos(Format(':PARA%d', [i]), AnsiUpperCase(Result));
    while j > 0 do
    begin
      l := Length(Format(':PARA%d', [i]));
      Result := Copy(Result, 1, j - 1) + FParametrar[i] + Copy(Result, j + l, MaxInt);
      j := Pos(Format(':PARA%d', [i]), AnsiUpperCase(Result));
    end;
  end;

{    while pos(':PARA' + IntToStr(i), uppercase(s)) <> 0 do
      s := Copy(s, 1, pos(':PARA' + IntToStr(i), uppercase(s)) - 1) +
        FParametrar[i] + Copy(s, pos(':PARA' + IntToStr(i), uppercase(s)) + 6,
        MaxInt); }
{
  while pos(':PARA1',uppercase(s))<>0 do
    s := Copy(s,1,pos(':PARA1',uppercase(s))-1)+fpara1+Copy(s,pos(':PARA1',uppercase(s))+6,MaxInt);
  while pos(':PARA2',uppercase(s))<>0 do
    s := Copy(s,1,pos(':PARA2',uppercase(s))-1)+fpara2+Copy(s,pos(':PARA2',uppercase(s))+6,MaxInt);
  while pos(':PARA3',uppercase(s))<>0 do
    s := Copy(s,1,pos(':PARA3',uppercase(s))-1)+fpara3+Copy(s,pos(':PARA3',uppercase(s))+6,MaxInt);

  Result := s;
}
end;

procedure TEQprinterData.ClearList;
begin
  FLanguage_List.Clear;
  FRow_List.Clear;
  FMall_list.Clear;
  FNewpage_List.Clear;
  FHeader_List.Clear;
  FTotal_List.Clear;
  FSystemData_List.Clear;
  FRow2List.Clear;
  FRow3List.Clear;
  FRow4List.Clear;
  FRow5List.Clear;
  FTotal2List.Clear;
  FTotal3List.Clear;
  FTotal4List.Clear;
  FTotal5List.Clear;
  fSectionInt := -1;
end;

constructor TEQprinterData.Create(prn: Tprinter; q1, q2: TDataSet);
begin
  inherited Create;
  pp := TPreviewPrinter.Create(Application.MainForm);
  pp.Copies := 1;
  FFont := TFont.Create;
  FPreview := true;
  fprn := prn;
  FZeroRow := 0;
  fZeroCol := 0;
{  if Assigned(fprn) then
  begin
    fprn.Refresh;
    Canvas := fprn.Canvas;
    PrinterOrientation := fPrn.Orientation;
  end; }
  fLocalQuery := (q1 as TADOQuery);
  fLocalRowQuery := (q2 as TADOQuery);
  fTextFile := TStringList.Create;
  FLanguage_List := TStringList.Create;
  FRow_List := TStringList.Create;
  FMall_list := TStringList.Create;
  FNewpage_List := TStringList.Create;
  FHeader_List := TStringList.Create;
  FTotal_List := TStringList.Create;
  FSystemData_List := TStringList.Create;
  fVersion := 0;
  fLandScape := 0;
  FRow2List := TStringList.Create;
  FRow3List := TStringList.Create;
  FRow4List := TStringList.Create;
  FRow5List := TStringList.Create;
  FTotal2List := TStringList.Create;
  FTotal3List := TStringList.Create;
  FTotal4List := TStringList.Create;
  FTotal5List := TStringList.Create;
  SetupTQuery(fRow2Query);
  SetupTQuery(fRow3Query);
  SetupTQuery(fRow4Query);
  SetupTQuery(fRow5Query);
  FParametrar := VarArrayCreate([1, 10], varVariant);
  Refresh;
  FList := TList.Create;
  FList.Add(TList.Create); // Languagelist
  FList.Add(TList.Create); // Systemdatalist
  FList.Add(TList.Create); // Headerdatalist
  FList.Add(TList.Create); // Rowdata
  FList.Add(TList.Create); // Totaldata
end;

destructor TEQprinterData.Destroy;
var
  tmpLista1, tmpLista2: TList;
  tmpSl: TStringlist;
begin
  while FList.Count > 0 do // Kolla antal Huvudsectioner
  begin
    tmpLista1 := Flist[0];
    while tmpLista1.Count > 0 do // Kolla antal undersectionen till huvudsectionen
    begin
      tmpLista2 := tmpLista1[0];
      while tmpLista2.Count > 0 do // Kolla antal Strinlist i undersectionen
      begin
        tmpSl := tmpLista2[0];
        tmpSl.Clear;
        tmpSl.Free;
        tmpLista2.Delete(0);
      end;
      tmpLista2.Free;
      tmpLista1.Delete(0);
    end;
    tmpLista1.Free;
    FList.Delete(0);
  end;
  FFont.Free;
  FreeTQuery(fRow2Query);
  FreeTQuery(fRow3Query);
  FreeTQuery(fRow4Query);
  FreeTQuery(fRow5Query);
  fTextFile.Free;
  FRow2List.Free;
  FRow3List.Free;
  FRow4List.Free;
  FRow5List.Free;
  FTotal2List.Free;
  FTotal3List.Free;
  FTotal4List.Free;
  FTotal5List.Free;
  FLanguage_List.Free;
  FRow_List.Free;
  FMall_list.Free;
  FNewpage_List.Free;
  FHeader_List.Free;
  FTotal_List.Free;
  FSystemData_List.Free;
  pp.Free;
  inherited Destroy;
end;

procedure TEQprinterData.DoRowprint;
var
  ls: TPrinterOrientation;
begin
  if FLandscape = 0 then
    PrinterOrientation := poPortrait
  else
    PrinterOrientation := poLandscape;
  ls := pp.Orientation;
  pp.Orientation := PrinterOrientation;
  pp.Title := AnsiUpperCase(CheckForparams(fTitle));
  pp.Units := unCentimeters;
  pp.Copies := Copies;

  pp.BeginDoc;
  try
    self.Canvas := pp.Canvas;
    self.Canvas.Font.Name := self.Font.Name;
    self.Canvas.Font.Size := self.Font.Size;
    CurrentRow := fStartRow;
    DoStartprint;
    printRowSection(FRow_List);
    DoTotalprint;
  finally
    pp.EndDoc;
    if Preview then
      pp.Preview
    else
      pp.Print;
    pp.Orientation := ls;
  end;
//  end;
end;

procedure TEQprinterData.DoRowprint2;
var
  ls: TPrinterOrientation;
begin
  if FLandscape = 0 then
    PrinterOrientation := poPortrait
  else
    PrinterOrientation := poLandscape;
  ls := pp.Orientation;
  try
    pp.Orientation := PrinterOrientation;
    pp.Title := AnsiUpperCase(CheckForparams(fTitle));
    pp.Units := unCentimeters;
    pp.Copies := Copies;
    pp.BeginDoc;
    self.Canvas := pp.Canvas;
    self.Canvas.Font.Name := self.Font.Name;
    self.Canvas.Font.Size := self.Font.Size;


    CurrentRow := fStartRow;
    DoStartprint2;
    printRows(1, nil);
  finally
    pp.EndDoc;
    if Preview then
      pp.Preview
    else
      pp.Print;
    pp.Orientation := ls;
  end;
{
  if Assigned(fprn) then
  begin
    ls := fPrn.Orientation;
    fPrn.Orientation := PrinterOrientation;
    fprn.Title := Uppercase(CheckForparams(fTitle));
    fprn.BeginDoc;
    try
      CurrentRow := fStartRow;
      DoStartprint2;
      printRows(1, nil);
    finally
      fprn.EndDoc;
      fPrn.Orientation := ls;
    end;

  end;
  }
  // else if Assigned(Canvas) then
end;

procedure TEQprinterData.DoRowprint3;
var
  ls: TPrinterOrientation;
  i: Integer;
begin
  if FLandscape = 0 then
    PrinterOrientation := poPortrait
  else
    PrinterOrientation := poLandscape;
  ls := pp.Orientation;
  pp.Orientation := PrinterOrientation;
  pp.Title := AnsiUpperCase(CheckForparams(fTitle));
  pp.Units := unCentimeters;
  pp.Copies := Copies;

  pp.BeginDoc;
  try
    self.Canvas := pp.Canvas;
    self.Canvas.Font.Name := self.Font.Name;
    self.Canvas.Font.Size := self.Font.Size;
    CurrentRow := fStartRow;
    DoStartprint3;
    // Rowdata section
    for i := 0 to TList(Flist[3]).Count - 1 do
      printRowSection(TStringList(TList(Flist[3]).Items[i]));
    DoTotalprint3;
  finally
    pp.EndDoc;
    if Preview then
      pp.Preview
    else
      pp.Print;
    pp.Orientation := ls;
  end;
//  end;
end;



procedure TEQprinterData.DoStartprint;
begin
  printSection(FMall_list);
  printSection(FLanguage_List);
  printSection(FSystemData_List);
  printSection(FHeader_List);
  printSection(Newpage_List);
end;

procedure TEQprinterData.DoStartprint3;
var
  i: Integer;
begin
  printSection(FMall_list);
// Language section
  for i := 0 to TList(Flist[0]).Count - 1 do
    printSection(TStringList(TList(Flist[0]).Items[i]));
// Systemdata section
  for i := 0 to TList(Flist[1]).Count - 1 do
    printSection(TStringList(TList(Flist[1]).Items[i]));
// Headerdata section
  for i := 0 to TList(Flist[2]).Count - 1 do
    printSection(TStringList(TList(Flist[2]).Items[i]));
  printSection(Newpage_List);
end;


procedure TEQprinterData.DoStartprint2;
begin
  printSection(FMall_list);
  printSection(Newpage_List);
end;

procedure TEQprinterData.DoTotalprint;
begin
  printRowSection1(FTotal_List);
end;

procedure TEQprinterData.DoTotalprint3;
var
  i: Integer;
begin
// Totaldata section
  for i := 0 to TList(Flist[4]).Count - 1 do
    printRowSection1(TStringList(TList(Flist[4]).Items[i]));
end;


{ searches through S for every DATAFILE=<filename> match and replaces the found line
  with the content of <filename> }

function TEQprinterData.LoadRemoteSection(S: TStringlist): Boolean;
var i, j: integer; F: TStringList;
  st: TStream;
begin
  Result := False;
  F := TStringList.Create;
  try
    while true do
    begin
      // find first occurence
      i := S.IndexOfName('DATAFILE');
      if i > -1 then
      begin
        // automaticall expand filenames, exception if file not found
        try
          if FileExists(ReportPath + S.Values['DATAFILE']) then
          begin
            F.LoadFromFile(ReportPath + S.Values['DATAFILE']);
          end
          else
          begin
            // Försök hitta filen i samma katalog som rapporterna
            if FileExists(ExpandUNCFileName(ExtractFilePath(fReportFileName) + S.Values['DATAFILE'])) then
            begin
              F.LoadFromFile(ExpandUNCFileName(ExtractFilePath(fReportFileName) + S.Values['DATAFILE']));
            end
            else
            begin
              st := StreamFunc(S.Values['DATAFILE']);
              F.LoadFromStream(st);
              st.Free;
            end;
          end;
        except
        end;
        S.Delete(i);
        // insert backwards, so we don't have to Inc(i)
        for j := F.Count - 1 downto 0 do
          S.Insert(i, F[j]);
      end
      else
        Break; // no more, so done
    end
  finally
    F.Free;
  end;
end;

procedure StripComments(S: TStrings);
var i, j: integer;
begin
  // trim comments
  for i := S.Count - 1 downto 0 do
  begin
    j := Pos('//', S[i]);
    if j > 0 then
    begin
      S[i] := Copy(S[i], j + 2, MaxInt);
      if Length(trim(S[i])) = 0 then
        S.Delete(i);
    end;
    j := Pos(';', S[i]);
    if j = 1 then
      S.Delete(i);
  end;
end;

function TEQprinterData.ReturnSQL(q: TADOQuery; SQL: string): string;
begin
  if sql = '' then exit;
  Result := '';
  Q.Close;
  try
    SQL := CheckForparams(SQL);
    Q.SQL.Add(SQL);
    Q.Open;
    if not Q.IsEmpty then
      if not Q.Fields[0].IsNull then
        Result := Q.Fields[0].AsString;
  except
  end;
  Q.Close;
end;

procedure TEQprinterData.ReadMultipleSections(ini: TEQIniStrings; SectionName: string; S: TStringList; list: TList);
var
  i: Integer;
  tmpS: TStringList;
begin
  for i := 0 to 9 do
  begin
    s.Text := '';
    if i = 0 then
      Ini.ReadSection(SectionName, S)
    else
      Ini.ReadSection(SectionName + IntToStr(i), S);
    LoadRemoteSection(S);
    if S.Count > 0 then
    begin
      tmpS := TStringList.Create;
      tmpS.Text := S.Text;
      List.Add(tmpS);
    end;
  end;
end;

{
  loads a report file into the component. Calls LoadRemoteSection to
  load and replace all DATAFILE name / values in each list.
}

procedure TEQprinterData.LoadFile2(const FileName: string);
var S: TStringList;
  ini: TEQIniStrings;
  st: TStream;
begin
{   Format is:
  VERSION=0
  0:General
  1:mall
  2:newpage
  3:language
  4:systemdata
  5:headerdata
  6:rowdata
  7:totaldata

  VERSION=1
  0: General
  1: mall
  2: newpage
  3: row1
  4: rowtotal1
  5: row2
  6: rowtotal2
  7: row3
  8: rowtotal3
  9: row4
  10: rowtotal4

  VERSION=2
  0:General
  1:mall
  2:newpage
  3:language + language 1..9
  4:systemdata + Systemdata 1..9
  5:headerdata + Headerdata 1..9
  6:rowdata + rowdata 1..9
  7:totaldata + totaldata 1..9

  each of these sections can have a DATAFILE field that specifies an external file that whose
  content should be inserted at the point where the DATAFILE occurs, like this:


}
  S := TStringList.Create;
  try
    ClearList;

    // Kolla om rapportfilen finns i rapportkatalogen
    try
      ini := TEQIniStrings.Create(ExpandUNCFileName(ReportPath + FileName));
    except
    end;
    // Kolla om rapportfilen finns i exe filens katalog
    if Ini.Strings.Count < 1 then
    begin
      try
        Ini.LoadFromFile(ExpandUNCFileName(ExtractFilePath(Application.ExeName) + FileName));
      except
      end;
    end;
    // Försök hitta filen i databasen
    if Ini.Strings.Count < 1 then
    begin
      st := StreamFunc(FileName);
      Ini.LoadFromStream(st);
      st.Free;
    end;
    with ini do
    try
      EQPrinterData.StripComments(Strings);
      PreFixSectionString := '';
      ReadSection('General', S);
      FTitle := S.Values['TITEL'];
      FRowHeight := StrToIntDef(S.Values['ROWHEIGHT'], 5);
      FStartRow := StrToIntDef(S.Values['STARTROW'], 0);
      FMaxRow := StrToIntDef(S.Values['MAXROW'], 0);
      FVersion := StrToIntDef(S.Values['VERSION'], 0);
      FLandscape := StrToIntDef(S.Values['LANDSCAPE'], 0);
      FDisplayNulls := S.Values['DISPLAYNULLS'] = '1';

      PreFixSectionString := ReturnSQL(fLocalQuery, S.Values['SetupSQL']);

      ReadSection('mall', FMall_List);
      LoadRemoteSection(FMall_List);
      ReadSection('newpage', FNewpage_List);
      LoadRemoteSection(FNewpage_List);

      case FVersion of
        0: begin
            ReadSection('Language', FLanguage_List);
            LoadRemoteSection(FLanguage_List);
            ReadSection('Systemdata', FSystemData_List);
            LoadRemoteSection(FSystemData_List);
            ReadSection('HeaderData', FHeader_List);
            LoadRemoteSection(FHeader_List);
            ReadSection('RowData', FRow_List);
            LoadRemoteSection(FRow_List);
            ReadSection('totaldata', FTotal_List);
            LoadRemoteSection(FTotal_List);
          end;
        1: begin
            ReadSection('row1', FRow2List);
            LoadRemoteSection(FRow2List);
            ReadSection('rowtotal1', FTotal2List);
            LoadRemoteSection(FTotal2List);
            ReadSection('row2', FRow3List);
            LoadRemoteSection(FRow3List);
            ReadSection('rowtotal2', FTotal3List);
            LoadRemoteSection(FTotal3List);
            ReadSection('row3', FRow4List);
            LoadRemoteSection(FRow4List);
            ReadSection('rowtotal3', FTotal4List);
            LoadRemoteSection(FTotal4List);
          end;
        2: begin
            ReadMultipleSections(ini, 'Language', S, TList(FList[0]));
            ReadMultipleSections(ini, 'Systemdata', S, FList[1]);
            ReadMultipleSections(ini, 'Headerdata', S, FList[2]);
            ReadMultipleSections(ini, 'Rowdata', S, FList[3]);
            ReadMultipleSections(ini, 'Totaldata', S, FList[4]);
          end;
      end;
    finally
      Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TEQprinterData.LoadFile(fName: string);
//var
//  i:Integer;
begin
  fReportFileName := FName;
  LoadFile2(FName);
end;

function TEQprinterData.mm2pixelX(mm: integer): Integer;
begin
//  Result := pp.UnitToX(mm);
  Result := round(mm * FresolutionX / 25.4);
end;

function TEQprinterData.mm2pixelY(mm: integer): Integer;
begin
//  Result := pp.UnitToY(mm);
  Result := round(mm * FResolutionY / 25.4);
end;

procedure TEQPrinterData.Print;
begin
  case FVersion of
    0: DoRowPrint;
    1: DoRowprint2;
    2: DoRowprint3;
  end;
end;


procedure TEQprinterData.printLine(s: string);
var i1, i2, i3, i4, i5: Integer;
  s1: string;
begin
// Line,2,180,#StartRow#,200,#StartRow#
  SplitLine(s, ',', S1, s);
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i4 := StrToInt(Trim(s1));
  i5 := StrToInt(Trim(s));
  StraighLine(i2, i3, i4, i5, i1);
end;

procedure TEQprinterData.SetZeroRow(s: string);
var i1: Integer;
  s1: string;
begin
// ZEROROW,10
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s));
  fZeroRow := i1
end;


procedure TEQprinterData.SetStartRow(s: string);
var i1: Integer;
  s1: string;
begin
// SetStartRow,10
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s));
  FStartrow := i1;
  CurrentRow := fStartRow;
end;


procedure TEQprinterData.SetZeroCol(s: string);
var i1: Integer;
  s1: string;
begin
// ZEROCOL,10
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s));
  fZeroCol := i1
end;


procedure TEQprinterData.printLogo(s: string);
var i1, i2, i3, i4: Integer;
  s1: string;
begin
// logo,20, 150, 80, 210, 'd:\projekt\m7\images\eqlogo232.bmp'
  SplitLine(s, ',', S1, s); // LOGO
  SplitLine(s, ',', S1, s); // X
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // Y
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // X2
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // Y2
  i4 := StrToInt(Trim(s1));
  S1 := s; // FILENAME
  BitmapAt(i1, i2, i3, i4, s1);
end;

procedure TEQprinterData.printpageCount(s: string);
var i1, i2, i3, i4: Integer;
  s1: string;
begin
// pageCount,180,16,10,20

  SplitLine(s, ',', S1, s);
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1));
  i4 := StrToInt(Trim(s));
  TextOut(i1, i2, i3, 'Sid: ' + IntToStr(pp.pageNumber), i4);

//   if Assigned(fprn) then
//     TextOut(i1,i2,i3,'Sid: '+IntToStr(fprn.pageNumber),i4);
end;

procedure TEQprinterData.printCurdate(s: string; dbText: string = '');
var i1, i2, i3, i4: Integer;
  s1: string;
begin
// Date,180,16,10,20

  SplitLine(s, ',', S1, s); // DATE
  SplitLine(s, ',', S1, s); // X
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // Y
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // H
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // A
  i4 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // DEFAULT
  if dbText <> '' then
    S1 := DateToStr(trunc(StrToDate(dbText)))
  else if S1 = '' then
    S1 := DateToStr(Trunc(Date));
  TextOut(i1, i2, i3, S1, i4);
end;

procedure TEQprinterData.printCurdateTime(s: string; dbText: string = '');
var i1, i2, i3, i4: Integer;
  s1: string;
begin
// DateTime,180,16,10,20,'DEFAULT'

  SplitLine(s, ',', S1, s); // DATETIME
  SplitLine(s, ',', S1, s); // X
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // Y
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // H
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s); // A
  i4 := StrToInt(Trim(S1));
  SplitLine(s, ',', S1, s); // DEFAULT
  if dbText <> '' then
    S1 := dbText
  else if S1 = '' then
    S1 := DateTimeToStr(Now);
  TextOut(i1, i2, i3, S1, i4);
end;

procedure TEQprinterData.printRoundArea(s: string);
var i1, i2, i3, i4, i5, i6: Integer;
  s1: string;
begin
// RoundArea,105,1,200,10,0,2

  SplitLine(s, ',', S1, s);
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i4 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i5 := StrToInt(Trim(s1));
  i6 := StrToInt(Trim(s));
  RoundArea(i1, i2, i3, i4, i5, i6);
end;

procedure TEQprinterData.printRows(l: Integer; oldQuery: TADOQuery);
var
  i, j: Integer;
  tmpStr, tmpStr2: string;
  tmpQ: TADOQuery;
  l1: TStringList;
  l2: TStringList;
  v: Variant;
begin
  tmpQ := nil;
  l1 := nil;
  l2 := nil;
  case l of
    1:
      begin
        tmpQ := fRow2Query;
        l1 := FRow2List;
        l2 := FTotal2List;
      end;
    2:
      begin
        tmpQ := fRow3Query;
        l1 := FRow3List;
        l2 := FTotal3List;
      end;
    3:
      begin
        tmpQ := fRow4Query;
        l1 := FRow4List;
        l2 := FTotal4List;
      end;
    4:
      begin
        tmpQ := fRow5Query;
        l1 := FRow5List;
        l2 := FTotal5List;
      end;
  end;
  if l1.Count < 1 then
    exit;
  tmpQ.close;
  tmpQ.sql.Clear;
  tmpQ.sql.Add(l1.Strings[0]);
  tmpQ.sql[0] := CheckForparams2(tmpQ.sql[0], oldQuery);
  tmpQ.Open;
  tmpQ.last;
  tmpQ.First;
  if tmpQ.RecordCount = 0 then
  begin
    tmpQ.Close;
    exit;
  end;
  for j := 1 to tmpQ.RecordCount do
  begin
    NoOfRows := 0;
    for i := 1 to l1.Count - 1 do
    begin
      if uppercase(copy(l1.Strings[i], 1, 6)) = 'SELECT' then
      else
      begin
        tmpStr := uppercase(copy(l1.Strings[i], 1, pos(',', l1.Strings[i]) -
          1));
        tmpStr2 := l1.Strings[i];
        if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
        begin
          tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) - 1)
            + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
            uppercase(tmpStr2)) + 10, MaxInt);
          if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
            tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) -
              1) + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
              uppercase(tmpStr2)) + 10, MaxInt);
          if NoOfRows = 0 then
            NoOfRows := 1;
        end;
        if pos('''', uppercase(tmpStr2)) > 0 then
        begin
          tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
            Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
          if pos('''', uppercase(tmpStr2)) > 0 then
            tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
              Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
        end;
        if tmpStr = 'LOGO' then printLogo(tmpStr2);
        if tmpStr = 'TEXT' then printText(tmpStr2, tmpQ.Fields[i - 1].AsString);
        if tmpStr = 'WRAPTEXT' then printWrapText(tmpStr2, tmpQ.Fields[i - 1].AsString);
        if tmpStr = 'FMTTEXT' then printFmtText(tmpStr2, tmpQ.Fields[i - 1].AsString);

        if tmpStr = 'FONTTEXT' then printFontText(tmpStr2, tmpQ.Fields[i - 1].AsString);
        if tmpStr = 'DECIMAL' then
          printTextDecimal(tmpStr2, tmpQ.Fields[i - 1].AsString, 0);
        if tmpStr = 'DECIMAL2' then
          printTextDecimal(tmpStr2, tmpQ.Fields[i - 1].AsString, 2);
        if tmpStr = 'DECIMAL4' then
          printTextDecimal(tmpStr2, tmpQ.Fields[i - 1].AsString, 4);
        if tmpStr = 'LINE' then printLine(tmpStr2);
        if tmpStr = 'ROUNDAREA' then printRoundArea(tmpStr2);
        if tmpStr = 'HALVSTEG' then
          CurrentRow := CurrentRow + round(fRowHeight / 2);
        if tmpStr = 'DATE' then printCurDate(tmpStr2, tmpQ.Fields[i - 1].AsString);
        if tmpStr = 'DATETIME' then printCurDateTime(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString);
        if tmpStr = 'ZEROROW' then SetZeroRow(tmpStr2);
        if tmpStr = 'ZEROCOL' then SetZeroCol(tmpStr2);
      end;
    end;
    CurrentRow := CurrentRow + (NoOfRows * fRowHeight);
    if CurrentRow >= fMaxRow then
    begin
//      if Assigned(fprn) then
//        fprn.Newpage;
      pp.NewPage;
      CurrentRow := fStartRow;
      DoStartprint2;
    end;
    if l < 4 then
      PrintRows(l + 1, tmpQ);
    tmpQ.Next;
  end;
  tmpQ.close;

  if l2.Count < 1 then
    exit;

  tmpQ.sql.Clear;
  tmpQ.sql.Add(l2.Strings[0]);
  tmpQ.sql[0] := CheckForparams2(tmpQ.sql[0], oldQuery);
  tmpQ.Open;
  tmpQ.last;
  tmpQ.First;
  if tmpQ.RecordCount = 0 then
  begin
    tmpQ.Close;
    exit;
  end;
  v := VarArrayCreate([0, TmpQ.FieldCount - 1], varVariant);
  for i := 0 to TmpQ.FieldCount - 1 do
  begin
    if tmpQ.Fields[i].DataType <> ftString then
      v[i] := 0.0
    else
      v[i] := '';
  end;
  for j := 1 to tmpQ.RecordCount do
  begin
    for i := 0 to TmpQ.FieldCount - 1 do
    begin
      if tmpQ.Fields[i].DataType <> ftString then
        v[i] := tmpQ.Fields[i].AsFloat + v[i]
      else
        v[i] := tmpQ.Fields[i].AsString;
    end;
    tmpQ.Next;
  end;
  tmpQ.close;
  NoOfRows := 0;
  for i := 1 to l2.Count - 1 do
  begin
    if uppercase(copy(l2.Strings[i], 1, 6)) = 'SELECT' then
    else
    begin
      tmpStr := uppercase(copy(l2.Strings[i], 1, pos(',', l2.Strings[i]) - 1));
      tmpStr2 := l2.Strings[i];
      if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
      begin
        tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) - 1) +
          IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
          uppercase(tmpStr2)) + 10, MaxInt);
        if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
          tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) - 1)
            + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
            uppercase(tmpStr2)) + 10, MaxInt);
        if NoOfRows = 0 then
          NoOfRows := 1;
      end;
      if pos('''', uppercase(tmpStr2)) > 0 then
      begin
        tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
          Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
        if pos('''', uppercase(tmpStr2)) > 0 then
          tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
            Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
      end;
      if tmpStr = 'LOGO' then printLogo(tmpStr2);
      if tmpStr = 'TEXT' then printText(tmpStr2, v[i - 1]);
      if tmpStr = 'WRAPTEXT' then printWrapText(tmpStr2, v[i - 1]);
      if tmpStr = 'FMTTEXT' then printFmtText(tmpStr2, v[i - 1]);
      if tmpStr = 'FONTTEXT' then printFontText(tmpStr2, v[i - 1]);
      if tmpStr = 'DECIMAL' then printTextDecimal(tmpStr2, v[i - 1], 0);
      if tmpStr = 'DECIMAL2' then printTextDecimal(tmpStr2, v[i - 1], 2);
      if tmpStr = 'DECIMAL4' then printTextDecimal(tmpStr2, v[i - 1], 4);
      if tmpStr = 'LINE' then printLine(tmpStr2);
      if tmpStr = 'ROUNDAREA' then printRoundArea(tmpStr2);
      if tmpStr = 'DATE' then printCurDate(tmpStr2, v[i - 1]);
      if tmpStr = 'DATETIME' then printCurDateTime(tmpStr2, v[i - 1]);
    end;
  end;
  CurrentRow := CurrentRow + (NoOfRows * fRowHeight);
  if CurrentRow >= fMaxRow then
  begin
//     if Assigned(fprn) then
//       fprn.Newpage;
    pp.NewPage;
    CurrentRow := fStartRow;
    DoStartprint2;
  end;
end;

procedure TEQprinterData.printRowSection(l: tStringList);
var
  i, j: Integer;
  tmpStr, tmpStr2: string;
begin
  if l.Count = 0 then
    exit;
  fLocalRowQuery.close;
  fLocalRowQuery.sql.Clear;
  fLocalRowQuery.sql.Add(l.Strings[0]);
  fLocalRowQuery.sql[0] := CheckForparams(fLocalRowQuery.sql[0]);
  fLocalRowQuery.Open;
  fLocalRowQuery.last;
  fLocalRowQuery.First;
  if fLocalRowQuery.RecordCount = 0 then
  begin
    fLocalRowQuery.Close;
    exit;
  end;
  for j := 1 to fLocalRowQuery.RecordCount do
  begin
    NoOfRows := 0;
    for i := 1 to l.Count - 1 do
    begin
      if uppercase(copy(l.Strings[i], 1, 6)) = 'SELECT' then
      else
      begin
        tmpStr := uppercase(copy(l.Strings[i], 1, pos(',', l.Strings[i]) - 1));
        tmpStr2 := l.Strings[i];
        if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
        begin
          tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) - 1)
            + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
            uppercase(tmpStr2)) + 10, MaxInt);
          if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
            tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) -
              1) + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
              uppercase(tmpStr2)) + 10, MaxInt);
          if NoOfRows = 0 then
            NoOfRows := 1;
        end;
        if pos('''', uppercase(tmpStr2)) > 0 then
        begin
          tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
            Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
          if pos('''', uppercase(tmpStr2)) > 0 then
            tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
              Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
        end;
        if tmpStr = 'LOGO' then printLogo(tmpStr2);
        if tmpStr = 'TEXT' then
          printText(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString);
        if tmpStr = 'WRAPTEXT' then
          printWrapText(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString);
        if tmpStr = 'FMTTEXT' then
          printFmtText(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString);
        if tmpStr = 'FONTTEXT' then
          printFontText(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString);
        if tmpStr = 'DECIMAL' then
          printTextDecimal(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString, 0);
        if tmpStr = 'DECIMAL2' then
          printTextDecimal(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString, 2);
        if tmpStr = 'DECIMAL4' then
          printTextDecimal(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString, 4);
        if tmpStr = 'LINE' then printLine(tmpStr2);
        if tmpStr = 'ROUNDAREA' then printRoundArea(tmpStr2);
        if tmpStr = 'DATE' then printCurDate(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString);
        if tmpStr = 'DATETIME' then printCurDateTime(tmpStr2, fLocalRowQuery.Fields[i - 1].AsString);
      end;
    end;
    CurrentRow := CurrentRow + (NoOfRows * fRowHeight);
    if CurrentRow >= fMaxRow then
    begin
//      if Assigned(fprn) then
//        fprn.Newpage;
      pp.NewPage;
      CurrentRow := fStartRow;
      DoStartprint;
    end;
    fLocalRowQuery.Next;
  end;
  fLocalRowQuery.close;
end;

procedure TEQprinterData.printRowSection1(l: tStringList);
var
  i: Integer;
  tmpStr, tmpStr2: string;
begin
  if l.Count = 0 then
    exit;
  fLocalQuery.Close;
  fLocalQuery.sql.Clear;
  fLocalQuery.sql.Add(l.Strings[0]);
  fLocalQuery.sql[0] := CheckForparams(fLocalQuery.sql[0]);
  fLocalQuery.Open;
  if fLocalQuery.RecordCount = 0 then
  begin
    fLocalQuery.Close;
    exit;
  end;
  for i := 0 to l.Count - 1 do
  begin
    if uppercase(copy(l.Strings[i], 1, 6)) = 'SELECT' then
    else
    begin
      tmpStr := uppercase(copy(l.Strings[i], 1, pos(',', l.Strings[i]) - 1));
      tmpStr2 := l.Strings[i];

      if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
      begin
        tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) - 1) +
          IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
          uppercase(tmpStr2)) + 10, MaxInt);
        if pos('#STARTROW#', uppercase(tmpStr2)) > 0 then
          tmpStr2 := Copy(tmpStr2, 1, pos('#STARTROW#', uppercase(tmpStr2)) - 1)
            + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#STARTROW#',
            uppercase(tmpStr2)) + 10, MaxInt);
        CurrentRow := CurrentRow + fRowHeight;
      end;
      if pos('#CURRENTROW#', uppercase(tmpStr2)) > 0 then
      begin
        tmpStr2 := Copy(tmpStr2, 1, pos('#CURRENTROW#', uppercase(tmpStr2)) - 1)
          + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#CURRENTROW#',
          uppercase(tmpStr2)) + 12, MaxInt);
        if pos('#CURRENTROW#', uppercase(tmpStr2)) > 0 then
          tmpStr2 := Copy(tmpStr2, 1, pos('#CURRENTROW#', uppercase(tmpStr2)) -
            1) + IntToStr(CurrentRow) + Copy(tmpStr2, pos('#CURRENTROW#',
            uppercase(tmpStr2)) + 12, MaxInt);
      end;
      if pos('''', uppercase(tmpStr2)) > 0 then
      begin
        tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
          Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
        if pos('''', uppercase(tmpStr2)) > 0 then
          tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
            Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
      end;
      if tmpStr = 'LOGO' then printLogo(tmpStr2);
      if tmpStr = 'TEXT' then
        printText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'WRAPTEXT' then
        printWrapText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'FMTTEXT' then
        printFmtText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'FONTTEXT' then
        printFontText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'DECIMAL' then
        printTextDecimal(tmpStr2, fLocalQuery.Fields[i - 1].AsString, 0);
      if tmpStr = 'DECIMAL2' then
        printTextDecimal(tmpStr2, fLocalQuery.Fields[i - 1].AsString, 2);
      if tmpStr = 'DECIMAL4' then
        printTextDecimal(tmpStr2, fLocalQuery.Fields[i - 1].AsString, 4);
      if tmpStr = 'LINE' then printLine(tmpStr2);
      if tmpStr = 'ROUNDAREA' then printRoundArea(tmpStr2);
      if tmpStr = 'HALVSTEG' then
        CurrentRow := CurrentRow + round(fRowHeight / 2);
      if tmpStr = 'DATE' then printCurDate(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'DATETIME' then printCurDateTime(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'ZEROROW' then SetZeroRow(tmpStr2);
      if tmpStr = 'ZEROCOL' then SetZeroCol(tmpStr2);
    end;
  end;
  fLocalQuery.Close;
end;

procedure TEQprinterData.printSection(l: tStringList);
var
  i: Integer;
  tmpStr, tmpStr2: string;
begin
  if l.Count = 0 then
    exit;
  fLocalQuery.Close;
  fLocalQuery.sql.Clear;
  fLocalQuery.sql.Add(l.Strings[0]);
  if l.Strings[0] = '' then
  begin
    tmpStr := 'Select '''',';
    for i := 1 to l.Count do
      tmpStr := tmpStr + ''''',';
//    tmpStr := tmpStr + ''''' from customer';
    tmpStr := tmpStr + '''''';
    fLocalQuery.sql[0] := tmpStr;
  end;
  fLocalQuery.sql[0] := CheckForparams(fLocalQuery.sql[0]);
  fLocalQuery.Open;
  if fLocalQuery.eof then
  begin
    fLocalQuery.Close;
    Exit;
  end;
  for i := 0 to l.Count - 1 do
  begin
    if uppercase(copy(l.Strings[i], 1, 6)) = 'SELECT' then
    else
    begin
      tmpStr := uppercase(copy(l.Strings[i], 1, pos(',', l.Strings[i]) - 1));
      tmpStr2 := l.Strings[i];
      if pos('''', uppercase(tmpStr2)) > 0 then
      begin
        tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
          Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
        if pos('''', uppercase(tmpStr2)) > 0 then
          tmpStr2 := Copy(tmpStr2, 1, pos('''', uppercase(tmpStr2)) - 1) +
            Copy(tmpStr2, pos('''', uppercase(tmpStr2)) + 1, MaxInt);
      end;
      if tmpStr = 'LOGO' then printLogo(tmpStr2);
      if tmpStr = 'TEXT' then
        printText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'WRAPTEXT' then
        printWrapText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'FMTTEXT' then
        printFmtText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'FONTTEXT' then
        printFontText(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'LINE' then printLine(tmpStr2);
      if tmpStr = 'PAGECOUNT' then PrintPageCount(tmpStr2);
      if tmpStr = 'ROUNDAREA' then printRoundArea(tmpStr2);
      if tmpStr = 'HALVSTEG' then
        CurrentRow := CurrentRow + round(fRowHeight / 2);
      if tmpStr = 'DATE' then printCurdate(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'DATETIME' then printCurdateTime(tmpStr2, fLocalQuery.Fields[i - 1].AsString);
      if tmpStr = 'ZEROROW' then SetZeroRow(tmpStr2);
      if tmpStr = 'ZEROCOL' then SetZeroCol(tmpStr2);
      if tmpStr = 'SETSTARTROW' then SetStartRow(tmpStr2);
    end;
  end;
  fLocalQuery.Close;
end;

procedure TEQprinterData.printText(s, dbText: string);
var i1, i2, i3, i4: Integer;
  s1: string;
begin
// Text,110,11,10,'Kundnummer',0,

  SplitLine(s, ',', S1, s);
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i4 := StrToInt(Trim(s));
  if dbText <> '' then
    s1 := dbText;
  TextOut(i1, i2, i3, s1, i4);
end;

procedure TEQprinterData.printWrapText(s, dbText: string);
var i1, i2, i3, i4: Integer;
  s1: string;
begin
// WrapText,110,11,10,'Kundnummer',0,

  SplitLine(s, ',', S1, s);
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i4 := StrToInt(Trim(s));
  if dbText <> '' then
    s1 := dbText;
  WrapTextOut(i1, i2, i3, s1, i4);
end;


procedure TEQprinterData.printFontText(s, dbText: string);
var i1, i2, i3, i4: Integer;
  s1, s2: string;
begin
// FontText,110,11,10,'Arial',0

  SplitLine(s, ',', S1, s);
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i4 := StrToInt(Trim(s));
  if dbText <> '' then
  begin
    s2 := pp.Canvas.Font.Name;
    pp.Canvas.Font.Name := s1;
    TextOut(i1, i2, i3, dbText, i4);
    pp.Canvas.Font.Name := s2;
  end;
end;

procedure TEQPrinterData.printFmtText(s, dbText: string);
var S1, tmp1, tmp2: string; tmpStyle: TFontStyles;
  i1, i2, i3, i4: Integer;
begin
// FMTTEXT,X,Y,SIZE,'TEXT',ALIGN,'FONTNAME',BOLD,ITALIC,UNDERLINE,STRIKEOUT
// FmtText,110,11,10,'Text',0,'Arial',0,0,1,0
  SplitLine(s, ',', S1, s); // FmtText bort

  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1)); // X
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1)); // Y
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1)); // FontSize
  SplitLine(s, ',', S1, s);
  tmp1 := S1; // 'Text'
  SplitLine(s, ',', S1, s);
  i4 := StrToInt(Trim(S1)); // Align

  SplitLine(s, ',', S1, s);
  tmp2 := S1; // 'FontName'
  if tmp2 <> '' then
  begin
    tmp2 := pp.Canvas.Font.Name;
    pp.Canvas.Font.Name := S1;
  end;

  tmpStyle := [];
  SplitLine(s, ',', S1, s);
  if trim(S1) = '1' then
    Include(tmpStyle, fsBold);
  SplitLine(s, ',', S1, s);
  if trim(S1) = '1' then
    Include(tmpStyle, fsItalic);
  SplitLine(s, ',', S1, s);
  if trim(S1) = '1' then
    Include(tmpStyle, fsUnderLine);
  SplitLine(s, ',', S1, s);
  if trim(S1) = '1' then
    Include(tmpStyle, fsStrikeout);
  pp.Canvas.Font.Style := tmpStyle;
  if dbText <> '' then
    tmp1 := dbText;
  TextOut(i1, i2, i3, tmp1, i4);
  if tmp2 <> '' then
    pp.Canvas.Font.Name := tmp2;
  pp.Canvas.Font.Style := [];
end;

procedure TEQprinterData.printTextDecimal(s, dbText: string; dec: Integer);
var i1, i2, i3, i4: Integer;
  s1: string;
begin
// Decimal2,110,11,10,'1000',0   = '1000.00'

  SplitLine(s, ',', S1, s);
  SplitLine(s, ',', S1, s);
  i1 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i2 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i3 := StrToInt(Trim(s1));
  SplitLine(s, ',', S1, s);
  i4 := StrToInt(Trim(s));
  if dbText <> '' then
    s1 := dbText;
  if (s1 = '0') and not FDisplayNulls then
    Exit;
  try
    s1 := Format('%0.*f', [dec, StrToFloatDef(s1, 0)]);
  except
    exit;
  end;
  TextOut(i1, i2, i3, s1, i4);
end;

procedure TEQprinterData.Refresh;
begin
  if Assigned(fprn) then
  begin
    ResolutionY := GetDeviceCaps(fprn.Handle, LOGPIXELSY);
    ResolutionX := GetDeviceCaps(fprn.Handle, LOGPIXELSX);
  end
  else
  begin
    ResolutionY := pp.PixelsPerInchY;
    ResolutionX := pp.PixelsPerInchX;
  end;
//     tmp := GetDeviceCaps(fprn.Handle,HORZRES);
end;

procedure TEQprinterData.RoundArea(x1, y1, x2, y2, Lines, Tjocklek: Integer);
var
  s2: TBrushStyle;
  s1: TColor;
  s3: Integer;
begin
  if FZeroCol <> 0 then
    x1 := x1 + FZeroCol;
  if FZeroRow <> 0 then
    y1 := y1 + FZeroRow;
  if FZeroRow <> 0 then
    y2 := y2 + FZeroRow;
  if FZeroCol <> 0 then
    x2 := x2 + FZeroCol;

  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  x2 := mm2pixelX(x2);
  y2 := mm2pixelY(y2);
  with pp.Canvas do
  begin
    s3 := pen.Width;
    pen.Width := Tjocklek;
    RoundRect(x1, y1, x2, y2, 10, 10);
    pen.Width := s3;
    if Lines > 0 then
    begin
      s3 := y1 + (Lines * (TextHeight('|') + 2));
      MoveTo(x1, s3);
      LineTo(x2, s3);
      s2 := Brush.Style;
      s1 := Brush.Color;
      Brush.Style := bsSolid;
      Brush.Color := clLtGray;
      FloodFill(x1 + 1, s3 - 1, clBlack, fsBorder);
      Brush.Style := s2;
      Brush.Color := s1;
    end;
  end;
end;

procedure TEQprinterData.SetCanvas(const Value: TCanvas);
begin
  FCanvas := Value;
end;

procedure TEQprinterData.SetHeader_List(const Value: TStringList);
begin
  FHeader_List.Assign(Value);
end;

procedure TEQprinterData.SetLanguage_List(const Value: TStringList);
begin
  FLanguage_List.Assign(Value);
end;

procedure TEQprinterData.SetMall_list(const Value: TStringList);
begin
  FMall_list.Assign(Value);
end;

procedure TEQprinterData.SetNewpage_List(const Value: TStringList);
begin
  FNewpage_List.Assign(Value);
end;

{
procedure TEQprinterData.Setpara1(const Value: String);
begin
  FParametrar[1] := Value;
end;

procedure TEQprinterData.Setpara2(const Value: String);
begin
  FParametrar[2] := Value;
end;

procedure TEQprinterData.Setpara3(const Value: String);
begin
  FParametrar[3] := Value;
end;
}

procedure TEQprinterData.SetResolutionX(const Value: double);
begin
  FResolutionX := Value;
end;

procedure TEQprinterData.SetResolutionY(const Value: double);
begin
  FResolutionY := Value;
end;

procedure TEQprinterData.SetRow_List(const Value: TStringList);
begin
  FRow_List.Assign(Value);
end;

procedure TEQprinterData.SetSystemData_List(const Value: TStringList);
begin
  FSystemData_List.Assign(Value);
end;

procedure TEQprinterData.SetTotal_List(const Value: TStringList);
begin
  FTotal_List.Assign(Value);
end;

procedure TEQprinterData.SplitLine(Str, SubStr: string; var LeftStr,
  RightString: string);
begin
  if pos(SubStr, Str) > 0 then
  begin
    LeftStr := Copy(Str, 1, pos(SubStr, Str) - 1);
    RightString := Copy(Str, pos(SubStr, Str) + length(Substr), MaxInt);
  end
  else
  begin
    LeftStr := Str;
    RightString := '';
  end;
end;

procedure TEQprinterData.StraighLine(x1, y1, x2, y2, Lines: Integer);
var
  s1: Integer;
begin
  if FZeroRow <> 0 then
    y1 := y1 + FZeroRow;
  if FZeroCol <> 0 then
    x1 := x1 + FZeroCol;
  if FZeroRow <> 0 then
    y2 := y2 + FZeroRow;
  if FZeroCol <> 0 then
    x2 := x2 + FZeroCol;
  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  x2 := mm2pixelX(x2);
  y2 := mm2pixelY(y2);
  s1 := pp.Canvas.pen.Width;
  pp.Canvas.pen.Width := Lines;
  pp.Canvas.MoveTo(x1, y1);
  pp.Canvas.LineTo(x2, y2);
  pp.Canvas.pen.Width := s1;
end;

procedure TEQprinterData.TextOut(x1, y1, Size: integer; str: string;
  Align: Integer);
var
  sl: TStringList;
  i: Integer;
  s1: string;
begin
  if FZeroRow <> 0 then
    y1 := y1 + FZeroRow;
  if FZeroCol <> 0 then
    x1 := x1 + FZeroCol;
  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  Align := mm2pixelX(Align);
  pp.Canvas.Font.Size := Size;
  sl := TStringList.Create;
  sl.Text := '';
  repeat
    SplitLine(Str, '#13', s1, Str);
    sl.Text := sl.Text + s1;
  until Str = '';
  if sl.Count > NoOfRows then
    NoOfRows := sl.Count;
  if Align <> 0 then
  begin
    for i := 1 to sl.Count do
    begin
      if Align > 0 then
        pp.Canvas.TextOut(x1 + Align - pp.Canvas.Textwidth(sl.Strings[i - 1]),
          y1, StringReplace(sl.Strings[i - 1], '¤', ',', [rfReplaceAll]))
      else
        pp.Canvas.TextOut(x1 - Round(pp.Canvas.Textwidth(sl.Strings[i - 1]) /
          2), y1, StringReplace(sl.Strings[i - 1], '¤', ',', [rfReplaceAll]));
      y1 := y1 + mm2pixelY(fRowHeight);
    end;
  end
  else
  begin
    for i := 1 to sl.Count do
    begin
      pp.Canvas.TextOut(x1, y1, StringReplace(sl.Strings[i - 1], '¤', ',', [rfReplaceAll]));
      y1 := y1 + mm2pixelY(fRowHeight);
    end;
  end;
  sl.free;
end;

function checkIt(L, ML: Integer; c: Char): Boolean;
begin
  Result := L > ML;
  if not Result then
    if not (C in [' ', ',', '.', '-']) then Result := True;
end;


procedure TEQprinterData.WrapTextOut(x1, y1, Size: integer; str: string;
  Align: Integer);
var
  sl: TStringList;
  i, j: Integer;
  s1: string;
  s2: string;
begin
  if FZeroRow <> 0 then
    y1 := y1 + FZeroRow;
  if FZeroCol <> 0 then
    x1 := x1 + FZeroCol;
  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  Align := mm2pixelX(Align);
  pp.Canvas.Font.Size := Size;
  sl := TStringList.Create;
  sl.Text := '';
  repeat
    SplitLine(Str, '#13', s1, Str);
    sl.Text := sl.Text + s1;
  until Str = '';
  for i := 0 to sl.count - 1 do
  begin
    s1 := sl[i];
    sl[i] := '';
    repeat
      if pp.Canvas.Textwidth(s1) > Align then
      begin
        s2 := s1;
        j := Length(S1);
        while (j > 1) and CheckIt(pp.Canvas.Textwidth(s2), Align, s2[j]) do
        begin
          dec(j);
          SetLength(s2, j)
        end;
        if sl[i] <> '' then
          sl[i] := sl[i] + #13#10 + s2
        else
          sl[i] := s2;
        s1 := trim(copy(s1, j + 1, 9999));
      end
      else
      begin
        if sl[i] <> '' then
          sl[i] := sl[i] + #13#10 + s1
        else
          sl[i] := s1;
        s1 := '';
      end;
    until s1 = '';
  end;
  sl.Text := sl.Text;
  if sl.Count > NoOfRows then
    NoOfRows := sl.Count;
  for i := 1 to sl.Count do
  begin
    pp.Canvas.TextOut(x1, y1, StringReplace(sl.Strings[i - 1], '¤', ',', [rfReplaceAll]));
    y1 := y1 + mm2pixelY(fRowHeight);
    if y1 >= mm2pixelY(fMaxRow) then
    begin
      NoOfRows := Sl.Count - i;
      pp.NewPage;
      CurrentRow := fStartRow;
      DoStartprint2;
      y1 := mm2pixelY(fStartRow);
    end;
  end;
  sl.free;
end;



{
function TEQPrinterData.GetPara1: String;
begin
  Result := FParametrar[1];
end;

function TEQPrinterData.GetPara2: String;
begin
  Result := FParametrar[2];
end;

function TEQPrinterData.GetPara3: String;
begin
  Result := FParametrar[3];
end;

}

function TEQPrinterData.GetParametrar(index: TParamIndex): Variant;
begin
  Result := FParametrar[Index];
end;

procedure TEQPrinterData.SetParametrar(index: TParamIndex;
  const Value: Variant);
begin
  FParametrar[Index] := Value;
end;

procedure TEQPrinterData.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;


end.

