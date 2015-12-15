{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Bokning\Bgmain.pas
}

{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14828: Bgmain.pas 
{
{   Rev 1.3    2008-06-27 13:33:44  Henry
{ Lagt till hantering av stationer
{
}
{   Rev 1.2    2005-02-14 16:15:30  pb64
{ infört visning av debuginfo
}
{
{   Rev 1.1    2005-02-08 21:13:04  pb64
{ Fixat så att inställningar sparas i tabellen initiering.
}
{
{   Rev 1.0    2004-08-18 11:00:50  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.6    2004-08-13 09:10:30  pb64
}
{
{   Rev 1.5    2004-08-10 10:45:38  pb64
}
{
{   Rev 1.4    2004-05-11 11:02:52  peter
}
{
{   Rev 1.3    2003-12-29 00:44:00  hasp
}
{
{   Rev 1.2    2003-10-14 11:35:22  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.1    2003-08-04 11:58:04  Supervisor
}
{
{   Rev 1.0    2003-03-20 14:00:22  peter
}
{
{   Rev 1.0    2003-03-17 14:41:42  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:56  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:26:20  Supervisor
{ Start av vc
}
unit bgmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Grids, ExtCtrls, StdCtrls, ComCtrls, DBTables, Db, Menus,
  Buttons, commctrl, inifiles, printers, Variants, ADODB, EQFormatEdit;

var
{färgval}
  clBooking: TColor;
  clContract: TColor;
  clReturned: TColor;
  clLateBooking: TColor;
  clLateReturn: TColor;
  clHistoric: TColor;
  clOther: TColor;

  {parametrar}
  {Startdatum: 0 = dagensdatum, -X = dagens datum - X dagar, 1 = Första dagen (måndag), eller den 1:a i månaden}
  bgDate1: integer; {vecka}
  bgDate2: integer; {14 dagar}
  bgDate3: integer; {30 dagar}
  bgDate4: integer; {3 månader}
  {Dygnsbredd: 20-120 pixlar}
  bgDayLength1: integer; {vecka}
  bgDayLength2: integer; {14 dagar}
  bgDayLength3: integer; {30 dagar}
  bgDayLength4: integer; {3 månader}
  {Objekts Höjd}
  BgOH: Integer;
  BgSN: Boolean;
  {Snapfunktion}
  bgSnapMinutes: integer;
  bgFreeZoneStart: TTime; {Starttid för bokningsfri zon ex.v. 19:00}
  bgFreeZoneEnd: TTime; {Sluttid för bokningsfri zon ex.v. 06:00}

  stChangeMinValue: word; {Tillåt förändringar på bokningar och kontrakt}

type
  TMousePos = (mpNone, mpStart, mpMid, mpEnd, mpNew);

  TObjectType = record
    ID: string;
    FName: string;
  end;

  TGridObject = record
    ID: Integer;
    TypeId: integer;
    StationId : integer;
    FName: string;
    Caption: string;
    Hint: string;
  end;

  TGridBooking = record
    ID: Integer;
    ObjectID: integer;
    From: TDateTime;
    Tom: TDateTime;
    Caption: string;
    Hint: string;
    Status: Integer;
    color: TColor;
  end;

  TChangeBooking = record
    BokNum: integer;
    BokId: integer;
    ObjectId: integer;
    From: TDateTime;
    Tom: TDateTime;
    color: TColor;
    X: Integer;
    Y: Integer;
  end;

  TfrmBokgraf = class(TForm)
    DrawGrid1: TDrawGrid;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Visalegend1: TMenuItem;
    Uppdaterafrndatabas1: TMenuItem;
    N1: TMenuItem;
    Avsluta1: TMenuItem;
    ImageList1: TImageList;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    ComboBox1: TComboBox;
    cbAcc: TCheckBox;
    ComboBox2: TComboBox;
    Button1: TButton;
    cbNameShow: TCheckBox;
    Label3: TLabel;
    TrackBar1: TTrackBar;
    Label4: TLabel;
    TrackBar2: TTrackBar;
    Rutnt1: TMenuItem;
    Timerinstllningar1: TMenuItem;
    Timer1: TTimer;
    BtnPrint: TSpeedButton;
    Skrivut1: TMenuItem;
    edtVstat: TEQFormatEdit;
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DrawGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure DrawGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DrawGrid1DblClick(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure DrawGrid1TopLeftChanged(Sender: TObject);
    procedure UpdateFromDatabase(Sender: TObject);
    procedure Avsluta1Click(Sender: TObject);
    procedure Visalegend1Click(Sender: TObject);
    procedure cbNameShowClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Rutnt1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timerinstllningar1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure Skrivut1Click(Sender: TObject);
    procedure DateTimePicker1CloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    frmclosing: boolean;
    procedure ShowHint(Sender: TObject);
    function MouseToObjectInfo(x, y: integer): integer;
    function CellXToTime(x: integer): TDateTime;
    function TimeToCellX(time: TDateTime): integer;
    function TimeToX(time: TDateTime): integer;
    function XToTime(x: integer): TDateTime;
    function DiffrentRows(Y1, Y2: integer): boolean;
    function MouseToObject(Y: integer): integer;
    procedure DrawEnd(canvas: TCanvas; x: integer; rect: TRect);
    procedure DrawStart(canvas: TCanvas; x: integer; rect: TRect);
    procedure DrawAllCells(canvas: TCanvas; Rect: TRect; acol,
      arow: integer);
    procedure DrawMid(canvas: TCanvas; rect: TRect);
    procedure DrawStartEnd(canvas: TCanvas; x, x2: integer; rect: TRect);
    procedure CalcChangePos(x, y: integer);
    procedure ShowChangePos;
    procedure ResetDummyGrid(cols, rows: integer);
    procedure SetDummyGrid(acol, arow, value: integer);
    function GetChangeRect: TRect;
    procedure UpdateObjects;
    procedure UpdateDBObjects;
    procedure UpdateDBObjTypes;
    function TypeToId(str: string): integer;
    procedure UpdateDBBookings;
    function Reg_NoToObjectId(reg: string): integer;
    procedure SetBookingColor(index: integer);
    procedure DrawName(canvas: TCanvas; bok, acol: integer; rect: TRect);
    procedure UpdateDBBooking(book: TChangeBooking);
    function GetRegNo(ObjectID: integer): string;
    procedure ClearGrayBookings;
    function GetStartDate(index, period: integer): TDateTime;
    function SwedishDayOfWeek(date: TDateTime): integer;
    procedure UpdateDateColumns(index: integer);
    procedure ReadINIFile;
    procedure WriteINIFile;
    function SnapTime(InTime: TDateTime): TDateTime;
    procedure UpdatePanelHeight;
    procedure UpdateDBStations;

    { Private declarations }
  public
    { Public declarations }
    MousePos: TMousePos;
    MouseObj: integer;
    Remember: Integer;
    RememberStation : Integer;
    ObjectOnRow: array of Integer;
    oldhint: string;
    procedure UpdateDummyGrid;
    function CheckBooking(ShowError: boolean): boolean;
  end;

var
  frmBokgraf: TfrmBokgraf;
  GridBookings: array of TGridBooking;
  GridObjects: array of TGridObject;
  TotalObjects: array of TGridObject;
  ObjectTypes: array of TObjectType;
  DummyGrid: array of array of integer;
  StartDate, StopDate: TDateTime;
  TempChangeBooking, ChangeBooking: TChangeBooking;
  ChangeType: TMousePos;
  ChangeColor: TColor;
  JustDblClicked, ChangeMouseDown, Changing: boolean;
  OldChangePos: TRect;
  ButtImage, DownX, DownY: Integer;
  LastCount: LongInt;
  Bak_Datum: Integer;
  Qtemp: TADOQuery;
  ObjKProcent: Integer;

const
  zoom: integer = 2;
  colTime: integer = 1;
  EndHeight: integer = 5;

implementation

uses Legend, Main, Kontrakt, TimerDlg, tmpdata,
  pris, Search, DateUtil;

{$R *.DFM}

function TfrmBokgraf.TimeToCellX(time: TDateTime): integer;
begin
  result := round(time * Drawgrid1.DefaultColWidth);
end;

function TfrmBokgraf.SnapTime(InTime: TDateTime): TDateTime;
var
  h, m, s, ms: word;
  totmin: integer;
begin
  result := InTime;
  try
    if bgSnapMinutes > 0 then
    begin
      DecodeTime(result, h, m, s, ms);
      totmin := m + 60 * h;
      if frac(totmin / bgSnapMinutes) > 0 then
      begin
        totmin := round(totmin / bgSnapMinutes) * bgSnapMinutes;
        h := totmin div 60;
        m := totmin - h * 60;
      end;
      result := Trunc(result) + EncodeTime(h, m, 0, 0);
    end;
  except
    result := InTime;
  end;
end;

function TfrmBokgraf.CellXToTime(x: integer): TDateTime;
begin
  result := X / Drawgrid1.DefaultColWidth;
end;

function TfrmBokgraf.TimeToX(time: TDateTime): integer;
var
  rect: TRect;
begin
  rect := Drawgrid1.CellRect(trunc(time - StartDate), 0);
  result := rect.left + TimeToCellX(frac(time));
end;

function TfrmBokgraf.XToTime(x: integer): TDateTime;
var
  col, row: integer;
  rect: TRect;
begin
  Drawgrid1.MouseToCell(x, 0, col, row);
  rect := Drawgrid1.CellRect(col, row);
  result := col + Startdate + CellXToTime(X - rect.left);
end;

function TfrmBokgraf.MouseToObjectInfo(x, y: integer): integer;
var
  i, col, row: integer;
  time: TDateTime;
  timeEnds: real;
begin
  result := 0;
  timeEnds := 10 / Drawgrid1.DefaultColWidth;
  Drawgrid1.Mousetocell(x, y, col, row);

  time := XToTime(x);
  if changing then
    time := SnapTime(time);
  if (col > 0) and (row > 0) and not changing then
  begin
    if length(gridobjects) >= row then
      Statusbar1.panels[0].text := gridobjects[row - 1].caption + ', ' + FormatDatetime('yyyy-mm-dd hh:mm:ss', time)
    else
      Statusbar1.panels[0].text := FormatDatetime('yyyy-mm-dd hh:mm', time);
  end;
(*  else
    Statusbar1.panels[0].text := '';
    *)
  mousePos := mpNone;
  mouseObj := -1;
  if (row < DrawGrid1.RowCount) and (col > 0) then
    for I := 0 to length(GridBookings) - 1 do
      if Gridbookings[I].ObjectID = GridObjects[row - 1].Id then
        if (Gridbookings[I].From <= time) and (Gridbookings[I].Tom >= time) then
        begin
//          Statusbar1.panels[0].text := Gridbookings[I].Hint;
          mouseObj := I;
          mousePos := mpMid;
          if (abs(Gridbookings[I].From - time) < timeEnds) then
            mousePos := mpStart;
          if (abs(Gridbookings[I].Tom - time) < timeEnds) then
            mousePos := mpEnd;
        end;
end;

procedure TfrmBokgraf.DrawStart(canvas: TCanvas; x: integer; rect: TRect);
var
  mid: integer;
begin
  mid := rect.top + DrawGrid1.DefaultRowHeight div 2;
  Canvas.MoveTo(x, mid - EndHeight);
  Canvas.LineTo(x, mid + EndHeight);
  Canvas.MoveTo(x, mid);
  Canvas.LineTo(x - (x - rect.right), mid);
end;

procedure TfrmBokgraf.DrawMid(canvas: TCanvas; rect: TRect);
var
  mid: integer;
begin
  mid := rect.top + DrawGrid1.DefaultRowHeight div 2;
  Canvas.MoveTo(rect.left - 1, mid);
  Canvas.LineTo(rect.right, mid);
end;

procedure TfrmBokgraf.DrawStartEnd(canvas: TCanvas; x, x2: integer; rect: TRect);
var
  mid: integer;
begin
  mid := rect.top + DrawGrid1.DefaultRowHeight div 2;
  Canvas.MoveTo(x, mid - EndHeight);
  Canvas.LineTo(x, mid + EndHeight);
  Canvas.MoveTo(x, mid);
  Canvas.LineTo(x2, mid);
  Canvas.MoveTo(x2, mid - EndHeight);
  Canvas.LineTo(x2, mid + EndHeight);
end;

procedure TfrmBokgraf.DrawEnd(canvas: TCanvas; x: integer; rect: TRect);
var
  mid: integer;
begin
  mid := rect.top + DrawGrid1.DefaultRowHeight div 2;
  Canvas.MoveTo(x, mid - EndHeight);
  Canvas.LineTo(x, mid + EndHeight);
  Canvas.MoveTo(x, mid);
  Canvas.LineTo(rect.left - 1, mid);
end;

procedure TfrmBokgraf.DrawName(canvas: TCanvas; bok, acol: integer; rect: TRect);
var
  textstart, textwidth, mid: integer;
  name: string;
begin
  mid := rect.top + DrawGrid1.DefaultRowHeight div 2;
  name := GridBookings[bok].Caption;
  textwidth := TSize(canvas.textextent(name)).cx;
  textstart := (TimeToX(GridBookings[bok].Tom) + TimeToX(GridBookings[bok].From)) div 2 - textwidth div 2;
  if TextStart < DrawGrid1.ColWidths[0] + 5 then
    TextStart := DrawGrid1.ColWidths[0] + 5;
  canvas.TextOut(textstart, Rect.Top + 4, Name);
end;

procedure TfrmBokgraf.DrawAllCells(canvas: TCanvas; Rect: TRect; acol, arow: integer);
var I: Integer;
begin
  for I := 0 to length(GridBookings) - 1 do
    if GridBookings[i].ObjectID = GridObjects[arow - 1].ID then
    begin
      canvas.Pen.color := GridBookings[i].color;
      if (Trunc(GridBookings[i].From) = acol + startdate) and (Trunc(GridBookings[i].Tom) = acol + startdate) then
        DrawStartEnd(canvas, TimeToX(GridBookings[i].From), TimeToX(GridBookings[i].Tom), rect)
      else
        if (Trunc(GridBookings[i].From) = acol + startdate) then
          DrawStart(canvas, TimeToX(GridBookings[i].From), rect)
        else
          if (Trunc(GridBookings[i].Tom) = acol + startdate) then
            DrawEnd(canvas, TimeToX(GridBookings[i].Tom), rect)
          else
            if (Trunc(GridBookings[i].From) < acol + startdate) and (Trunc(GridBookings[i].Tom) > acol + startdate) then
              DrawMid(canvas, rect);
//      canvas.Pen.color := clBlack;
      if (Trunc(GridBookings[i].From) <= acol + startdate) and (Trunc(GridBookings[i].Tom) >= acol + startdate) then
        if cbNameShow.checked then
          DrawName(canvas, i, acol, rect);
    end;
end;

procedure TfrmBokgraf.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  index: integer;
  timestring, timeformat: string;
  timeleft: integer;
  AKm: Real; //!Tillåtna km
  AKm_Proc: Real; //!Tillåtna KM minus Procent från Param
begin
  if frmClosing then
    exit;
  index := aRow * DrawGrid1.ColCount + aCol;
  with Sender as TDrawGrid do
  begin
    if (acol = 0) or (aRow = 0) then
      Canvas.Brush.Color := clBtnFace
    else
      Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clBlack;
    if DrawGrid1.DefaultColWidth < 50 then
      Canvas.Pen.Width := 1
    else
      Canvas.Pen.Width := 2;

    Canvas.FillRect(Rect);
    if (acol > 0) and (aRow > 0) then
    begin
      canvas.pen.color := clBlack;
      if (length(DummyGrid) > acol) and (length(DummyGrid[acol]) > arow - 1) then
      begin
{        if DummyGrid[acol-1,arow-1] = 1 then
          DrawMid(canvas,Rect)
        else}
        if DummyGrid[acol - 1, arow - 1] >= 0 then
          DrawAllCells(canvas, Rect, acol, arow);
      end;
      if changing then
      begin
        // Rita förflyttad
        Canvas.Pen.color := clBlue;
        if TempChangeBooking.ObjectID = GridObjects[arow - 1].Id then
          if (Trunc(TempChangeBooking.From) = acol + startdate) and (Trunc(TempChangeBooking.Tom) = acol + startdate) then
            DrawStartEnd(canvas, TimeToX(TempChangeBooking.From), TimeToX(TempChangeBooking.Tom), rect)
          else
            if (Trunc(TempChangeBooking.From) = acol + startdate) then
              DrawStart(canvas, TimeToX(TempChangeBooking.From), rect)
            else
              if (Trunc(TempChangeBooking.Tom) = acol + startdate) then
                DrawEnd(canvas, TimeToX(TempChangeBooking.Tom), rect)
              else
                if (Trunc(TempChangeBooking.From) < acol + startdate) and (Trunc(TempChangeBooking.Tom) > acol + startdate) then
                  DrawMid(canvas, rect);
//        ShowChangePos;
        Canvas.Pen.color := clBlack;
      end;
    end
    else
      if (acol = 0) and (aRow = 0) then
      begin
        Canvas.Font.style := [fsBold];
        Canvas.Font.Color := clBlue;
        Canvas.TextOut(rect.Left + 4, Rect.top + 4, 'Car2000');
        Canvas.Font.style := [];
        canvas.pen.Width := 1;
        canvas.MoveTo(rect.left, rect.bottom);
        canvas.LineTo(rect.right, rect.bottom);
        canvas.MoveTo(rect.right - 1, rect.top);
        canvas.LineTo(rect.right - 1, rect.bottom);
      end
      else
      begin
        if (acol = 0) and (length(GridObjects) >= row) then
        begin
            if Qtemp.Locate('REG_NO',GridObjects[aRow - 1].caption,[loCaseInsensitive]) then
            begin
      //!Km/Dag * Antalet dagar från Idag till Datum i ObjectsT
              AKm := Qtemp.fieldbyname('LKM').asinteger * (trunc(date) - trunc(Qtemp.fieldbyname('Ldatum').asdatetime));
              Akm := akm + Qtemp.fieldbyname('lkmstart').asinteger;
              if Qtemp.fieldbyname('Km_N').asinteger > AKm then
                Canvas.brush.color := clred;
       //!Antal Tillåtna Km - AntalTillåtna KM * procent/100
              Akm_Proc := Akm * ObjKProcent / 100;
              if (Qtemp.fieldbyname('Km_N').asinteger > AKm_Proc) and
                (Qtemp.fieldbyname('Km_N').asinteger < AKm) then
                canvas.brush.color := ClYellow;
              if Qtemp.fieldbyname('Km_N').asinteger < AKm_proc then
                Canvas.brush.color := 65408;
            end
            else
              canvas.brush.color := clbtnface;
      //!Baz
          Canvas.TextOut(rect.Left + 4, Rect.top + 4, GridObjects[aRow - 1].caption);
          canvas.pen.Width := 1;
          canvas.MoveTo(rect.right - 1, rect.top - 1);
          canvas.LineTo(rect.right - 1, rect.bottom);
        end;
        if arow = 0 then
        begin
          case DrawGrid1.DefaultColWidth of
            0..40: timeformat := 'dd';
            41..70: timeformat := 'mm-dd';
            71..100: timeformat := 'yyyy-mm-dd';
          else
            timeformat := 'ddd yyyy-mm-dd';
          end;
          timestring := FormatDateTime(timeformat, Startdate + acol);
          if Startdate + acol = date then
            Canvas.Font.style := [fsBold];
        //!if DayOfWeek(Startdate + acol) = 1 then
//!Benny Lagt till för att även Lör ska visas i rött
          if (DayOfWeek(Startdate + acol) = 1) or (DayOfWeek(Startdate + acol) = 7) then
            Canvas.Font.color := clRed
          else
            Canvas.Font.color := clBlack;
          TimeLeft := rect.left + (DrawGrid1.DefaultColWidth - TSize(canvas.textextent(timestring)).cx) div 2;
          Canvas.TextOut(TimeLeft, Rect.top + 4, timestring);
          Canvas.Font.color := clBlack;
          Canvas.Font.style := [];
          canvas.pen.Width := 1;
          canvas.MoveTo(rect.left, rect.bottom);
          canvas.LineTo(rect.right, rect.bottom);
        end;
      end;
    if gdFocused in State then
      Canvas.DrawFocusRect(Rect);
  end;

end;

function TfrmBokgraf.GetChangeRect: TRect;
var I: Integer;
begin
  for I := 0 to length(GridObjects) do
    if TempChangeBooking.ObjectId = GridObjects[I].Id then
      result := DrawGrid1.CellRect(0, I + 1);
  result.Left := TimeToX(TempChangeBooking.From) - 2;
  result.Right := TimeToX(TempChangeBooking.Tom) + 2;
end;

procedure TfrmBokgraf.DrawGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  col, row: integer;
  tmpHint: string;
begin
  if frmClosing then
    exit;
//  DrawGrid1.hint := '';
  if length(GridObjects) = 0 then
    exit;

  Mousetoobjectinfo(x, y);
  if Changing then
  begin
    CalcChangePos(x, y);
    InvalidateRect(DrawGrid1.handle, @OldChangePos, false);
    OldChangePos := GetChangeRect;
    InvalidateRect(DrawGrid1.handle, @OldChangePos, false);
  end
  else
  begin
    if MousePos in [mpStart, mpEnd] then
      DrawGrid1.cursor := crHSplit
    else
      if MousePos = mpMid then
        DrawGrid1.cursor := crHandPoint
      else
        DrawGrid1.cursor := crdefault;
    if ChangeMouseDown then
      if (abs(x - DownX) > 5) or (abs(y - DownY) > 5) then
        Changing := true;
  end;
  if drawGrid1.ShowHint then
  begin
    if Changing then
    begin
      Application.HintPause := 0;
      Application.HintShortPause := 0;
      Application.HintHidePause := 10000;

      tmpHint := (*FormatDateTime('yy-mm-dd hh:mm', ChangeBooking.From) + ' - ' +FormatDateTime('yy-mm-dd hh:mm', ChangeBooking.Tom) + #13 +*)
        FormatDateTime('yy-mm-dd hh:mm', TempChangeBooking.From) + ' - ' + FormatDateTime('yy-mm-dd hh:mm', TempChangeBooking.Tom);
    end
    else
    begin
      Application.HintPause := 50;
      Application.HintShortPause := 50;
//!BEnny testar      Application.HintHidePause := 2500;
      Application.HintHidePause := 100000;
      DrawGrid1.MouseToCell(x, y, col, row);
      if (col = 0) and (row > 0) and (length(GridObjects) >= row) then
        tmpHint := GridObjects[row - 1].hint
      else
        if (row = 0) and (col > 0) then
          tmpHint := FormatDateTime('dddd"en den" d mmmm yyyy', StartDate + col)
        else
          if mouseobj >= 0 then
            tmpHint := Gridbookings[mouseobj].Hint
          else
            tmpHint := '';
      if (mouseobj >= 0) then
      begin
        Application.HintPause := 500;
      end;
    end;
    if oldhint <> tmpHint then
    begin
      Application.CancelHint;
      DrawGrid1.Hint := tmpHint;
    end;
    oldhint := tmpHint;
  end;
end;

procedure AddGridObject(obj: TGridObject);
var I: integer;
begin
  I := Length(TotalObjects);
  SetLength(TotalObjects, i + 1);
  TotalObjects[i] := obj;
end;

procedure AddGridBooking(bok: TGridBooking);
var I: integer;
begin
  I := Length(GridBookings);
  SetLength(GridBookings, i + 1);
  GridBookings[i] := bok;
end;

procedure TfrmBokgraf.FormCreate(Sender: TObject);
begin
  qtemp := CreateDS('SELECT * FROM PARAM');
  qtemp.Open;
  ObjKProcent := Qtemp.fieldbyname('ObjKProcent').asinteger;
  Qtemp.Close;
  SetDS(Qtemp, 'SELECT * FROM OBJECTS WHERE LDATUM>''1990-01-01''');
  Qtemp.Open;


  Remember := 0; //!Benny för att komma ihåg vilken Typ
  RememberStation := 0;
  frmclosing := false;
  ReadINIFile;
  StartDate := date - 1;
  DateTime_SetFormat(DateTimePicker1.Handle, 'ddd yyyy-MM-dd');
  DateTimePicker1.dateTime := date;
//  StopDate := date + 50;

  ComboBox1Change(nil);
  Application.OnHint := ShowHint;
  UpdatePanelHeight;
  UpdateFromDatabase(nil);
//! 2 rader för språk
  frmmain.CheckLanguage;
  if frmmain.language > '!' then
    frmmain.UpdateLang(Self, frmmain.Language);
end;

procedure TfrmBokgraf.ShowHint(Sender: TObject);
begin
//! remarka 0820
  if Assigned(frmbokgraf) then //!Benny lagt till
    if not frmClosing then
      if assigned(StatusBar1.Panels[0]) then
        StatusBar1.Panels[0].text := Application.Hint;
end;

procedure TfrmBokgraf.ResetDummyGrid(cols, rows: integer);
var
  I, J: Integer;
begin
  SetLength(DummyGrid, cols);
  for I := 0 to cols - 1 do
  begin
    SetLength(DummyGrid[i], rows);
    for J := 0 to rows - 1 do
      DummyGrid[i, j] := -1;
  end;
end;

procedure TfrmBokgraf.SetDummyGrid(acol, arow, value: integer);
begin
  if (acol >= 0) and (arow >= 0) then
    if length(DummyGrid) > acol then
      if length(DummyGrid[acol]) > arow then
        DummyGrid[acol, arow] := value;
end;

procedure TfrmBokgraf.SetBookingColor(index: integer);
begin
  // 0 = not contract, 1 = contract, 2 = returned, 3 = accounted
  case GridBookings[index].Status of
    0..2:
      begin
        if Now < GridBookings[index].From then
          GridBookings[index].color := clBooking
        else
          GridBookings[index].color := clLateBooking;
      end;
    4..6:
      begin
        if Now < GridBookings[index].Tom then
          GridBookings[index].color := clContract
        else
          GridBookings[index].color := clLateReturn;
      end;
    8: GridBookings[index].color := clOther;
    9: GridBookings[index].color := clReturned;
    10..99: GridBookings[index].color := clHistoric;
  else
    GridBookings[index].color := clOther;
  end;
end;

procedure TfrmBokgraf.UpdateDummyGrid;
var
  numRows, numCols: integer;
  k, j, i: integer;
begin
  StopDate := StartDate + 100;
  numCols := trunc(StopDate - StartDate) div colTime;
  NumRows := length(GridObjects);
  ResetDummyGrid(numCols, numRows);
  for i := 0 to length(GridBookings) - 1 do
    with GridBookings[i] do
    begin
      SetBookingColor(i);
      for J := 0 to length(GridObjects) - 1 do
        if ObjectID = GridObjects[j].ID then
        begin
          SetDummyGrid(trunc(From - StartDate - 1), J, 0);
          for K := trunc(From - StartDate + 1) to trunc(Tom - StartDate - 1) do
            SetDummyGrid(K - 1, J, 1);
          SetDummyGrid(trunc(Tom - StartDate - 1), J, 2);
        end;
    end;
  if DrawGrid1.rowcount > 1 then
    DrawGrid1.FixedRows := 1;
  DrawGrid1.Invalidate;
  DrawGrid1.hint := '';
  Statusbar1.Panels[0].text := '';
  DrawGrid1.cursor := crDefault;
end;

procedure TfrmBokgraf.ClearGrayBookings;
var I: Integer;
begin
  for I := 0 to length(GridBookings) - 1 do
  begin
    if Gridbookings[I].color = clGray then
      SetBookingColor(I);
  end;
end;

procedure TfrmBokgraf.DrawGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var col, row: integer;
begin
  if frmClosing then
    exit;
  Timer1.Enabled := False; // PB Test
  if not JustDblClicked then
  begin
    if MouseObj >= 0 then
    begin
      ClearGrayBookings;
      if GridBookings[MouseObj].Status <= stChangeMinValue then
      begin
        ChangeBooking.BokNum := MouseObj;
        ChangeBooking.BokId := GridBookings[MouseObj].ID;
        ChangeBooking.From := GridBookings[MouseObj].From;
        ChangeBooking.Tom := GridBookings[MouseObj].Tom;
        ChangeBooking.ObjectId := GridBookings[MouseObj].ObjectID;
        ChangeBooking.color := GridBookings[MouseObj].color;
        GridBookings[MouseObj].color := clGray;
        ChangeBooking.X := X;
        ChangeBooking.Y := Y;
        ChangeType := MousePos;
        ChangeColor := GridBookings[MouseObj].color;
        changemousedown := true;
        DownX := X;
        DownY := Y;
        changing := false;
        TempChangeBooking := ChangeBooking;
      end;
      DrawGrid1.Invalidate;
    end
    else
    begin
      DrawGrid1.MouseToCell(X, Y, col, row);
      ChangeBooking.BokId := 0;
      ChangeBooking.From := SnapTime(XToTime(X));
      ChangeBooking.Tom := ChangeBooking.From;
      ChangeBooking.ObjectId := GridObjects[row - 1].ID;
      ChangeBooking.X := X;
      ChangeBooking.Y := Y;
      ChangeType := mpNew;
      changemousedown := true;
      DownX := X;
      DownY := Y;
      changing := false;
      TempChangeBooking := ChangeBooking;
    end;
  end
  else
    JustDblClicked := false;
end;

function TfrmBokgraf.DiffrentRows(Y1, Y2: integer): boolean;
var
  row1, row2, col: integer;
begin
  DrawGrid1.MouseToCell(0, y1, col, row1);
  DrawGrid1.MouseToCell(0, y2, col, row2);
  result := row1 <> row2;
end;

function TfrmBokgraf.MouseToObject(Y: integer): integer;
var
  row, col: integer;
begin
  DrawGrid1.MouseToCell(0, y, col, row);
  result := GridObjects[row - 1].Id;
end;

procedure TfrmBokgraf.ShowChangePos;
var
  rect: TRect;
begin
  rect := DrawGrid1.CellRect(0, TempChangeBooking.ObjectId);
  rect.left := 0;
  rect.right := 500;
  DrawStartEnd(DrawGrid1.canvas, TimeToX(TempChangeBooking.From), TimeToX(TempChangeBooking.Tom), rect);
end;

procedure TfrmBokgraf.CalcChangePos(x, y: integer);
var
  temp, TimeDif: TDateTime;

begin
  case ChangeType of
    mpMid:
      begin
        TimeDif := XToTime(X) - XToTime(ChangeBooking.X);
        if abs(TimeDif) > 1 / 24 * 2 then
        begin
          TempChangeBooking.From := ChangeBooking.From + TimeDif;
          TempChangeBooking.Tom := ChangeBooking.Tom + TimeDif;
        end
        else
        begin
          TempChangeBooking.From := ChangeBooking.From;
          TempChangeBooking.Tom := ChangeBooking.Tom;
        end;
        if DiffrentRows(Y, TempChangeBooking.Y) then
        begin
          TempChangeBooking.Y := y;
          TempChangeBooking.ObjectId := MouseToObject(Y);
        end;
      end;
    mpStart:
      begin
        TimeDif := SnapTime(XToTime(X));
        if TimeDif < TempChangeBooking.Tom then
          TempChangeBooking.From := TimeDif
        else
          TempChangeBooking.From := TempChangeBooking.Tom;
      end;
    mpEnd:
      begin
        TimeDif := SnapTime(XToTime(X));
        if TimeDif > TempChangeBooking.From then
          TempChangeBooking.Tom := TimeDif
        else
          TempChangeBooking.Tom := TempChangeBooking.From;
      end;
    mpNew:
      begin
        TimeDif := SnapTime(XToTime(X));
        if TimeDif > TempChangeBooking.From then
          TempChangeBooking.Tom := TimeDif
        else
          TempChangeBooking.Tom := TempChangeBooking.From;
      end;
  end;
end;

function TfrmBokgraf.CheckBooking(ShowError: boolean): boolean;
var
  Err: string;
  I: Integer;
  obj: boolean;
begin
  result := true;
  Err := '';
  if ChangeBooking.From > ChangeBooking.Tom then
  begin
    Err := 'Fråntid måste vara mindre än tilltid';
    result := false;
  end;
  obj := false;
  for I := 0 to length(GridObjects) - 1 do
    if ChangeBooking.ObjectId = GridObjects[i].Id then
      obj := true;
  if not obj then
  begin
    Err := 'Inget objekt valt';
    result := false;
  end;
  for I := 0 to length(GridBookings) - 1 do
    if ChangeBooking.ObjectId = GridBookings[i].ObjectID then
      if ChangeBooking.BokId <> GridBookings[i].ID then
        if (ChangeBooking.Tom >= GridBookings[i].From) and (ChangeBooking.From <= GridBookings[i].Tom) then
        begin
          Err := 'Bokningen koliderar med annan bokning';
          result := false;
        end;
  if ShowError and (result = false) then
    ShowMessage(Err);
end;

function TfrmBokgraf.GetRegNo(ObjectID: integer): string;
var I: Integer;
begin
  for I := 0 to length(TotalObjects) - 1 do
    if Totalobjects[I].ID = ObjectID then
      result := Totalobjects[I].FName;
end;

function GetTypeId(ObjektId: integer): string;
var
  I: Integer;
begin
  for I := 0 to length(TotalObjects) - 1 do
    if Totalobjects[I].ID = ObjektID then
      result := ObjectTypes[Totalobjects[I].TypeId].ID;
end;

procedure TfrmBokgraf.UpdateDBBooking(book: TChangeBooking);
var
  I: Integer;
  BKM_in: Integer;
  BRegNr: string;
  bok: TGridBooking;
  ds: TADOQuery;
begin
  if book.BokId = -1 then
  begin
    if frmMain.IsContractOpen(Booking, I) then
      ShowMessage('Det finns redan ' + frmMain.GetProperName(Booking) + ' öppen')
    else
    begin
      I := frmMain.ShowContract(Booking);
      with TfrmKontrakt(frmMain.frmKontraktLista[i]) do
      begin
        LoadObject(GetRegNo(Book.ObjectID));
        DTVFrom.DateTime := Book.From;
        DTVTo.DateTime := Book.Tom;
      end;
    end;
  end
  else
  begin
    bok := GridBookings[Book.BokNum];
    BRegNr := GetRegNo(book.ObjectID);
    ds := CreateDS('SELECT * FROM OBJECTS WHERE REG_NO=''' + BRegNr + '''');
    try
      ds.Open;
      Bkm_in := ds.fieldbyname('KM_N').AsInteger;
    except
    end;
    FreeDS(ds);
    FrmSearch.UpdateContrObj(bok.ID, GetRegNo(bok.ObjectID), GetRegNo(Book.ObjectId), GetTypeId(Book.ObjectId), Book.From, Book.Tom, Bkm_in, 0);
  end;
end;

procedure TfrmBokgraf.DrawGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TimeDif: TDateTime;
  StartTimer: Boolean;
begin
  if frmClosing then
    exit;
  StartTimer := True;
  if changing then
  begin
    case ChangeType of
      mpMid:
        begin
          TimeDif := XToTime(X) - XToTime(ChangeBooking.X);
          if abs(TimeDif) > 1 / 24 * 2 then
          begin
            ChangeBooking.From := ChangeBooking.From + TimeDif;
            ChangeBooking.Tom := ChangeBooking.Tom + TimeDif;
          end;
          if DiffrentRows(Y, ChangeBooking.Y) then
            ChangeBooking.ObjectId := MouseToObject(Y);
        end;
      mpStart:
        begin
          ChangeBooking.From := SnapTime(XToTime(X));
        end;
      mpEnd:
        begin
          ChangeBooking.Tom := SnapTime(XToTime(X));
        end;
      mpNew:
        begin
          ChangeBooking.Tom := SnapTime(XToTime(X));
          ChangeBooking.BokNum := Length(GridBookings);
          ChangeBooking.BokId := -1;
          SetLength(GridBookings, ChangeBooking.BokNum + 1);
        end;
    end;
    if CheckBooking(true) then
    begin
      if not cbAcc.checked or (MessageDlg('Vill du ändra/skapa bokningen?' + #13 +
        'BookingId : ' + inttostr(ChangeBooking.BokId) + #13 +
        'ObjectId : ' + inttostr(ChangeBooking.ObjectId) + #13 +
        'From :      ' + FormatDateTime('yyyy-mm-dd hh:mm', ChangeBooking.From) + #13 +
        'To :        ' + FormatDateTime('yyyy-mm-dd hh:mm', ChangeBooking.Tom)
        , mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        StartTimer := False;
        UpdateDBBooking(ChangeBooking);
        GridBookings[ChangeBooking.BokNum].ID := ChangeBooking.BokId;
        GridBookings[ChangeBooking.BokNum].ObjectID := ChangeBooking.ObjectId;
        GridBookings[ChangeBooking.BokNum].From := ChangeBooking.From;
        GridBookings[ChangeBooking.BokNum].Tom := ChangeBooking.Tom;
        UpdateDummyGrid;
      end;
    end;
  end;
//  GridBookings[ChangeBooking.BokNum].Color := ChangeBooking.Color;
  DrawGrid1.Invalidate;
  changemousedown := false;
  changing := false;
  if StartTimer then
    Timer1.Enabled := True; // PB Test
end;

function TfrmBokgraf.SwedishDayOfWeek(date: TDateTime): integer;
begin
  result := DayOfWeek(date);
  dec(result);
  if result = 0 then
    result := 7;
end;

function TfrmBokgraf.GetStartDate(index, period: integer): TDateTime;
var
  y, m, d: word;
begin
  result := now;
  try
    if index < 0 then
      result := date - index
    else
      if index = 0 then
        result := date
      else
        if index > 0 then
        begin
          if period = 1 then {vecka}
            result := date - ((SwedishDayOfWeek(date) - index) mod 7)
          else
            if period = 2 then {14 dagar}
              result := date - ((SwedishDayOfWeek(date) - index) mod 7)
            else
              if period = 3 then {30 dagar}
              begin
                DecodeDate(date, y, m, d);
                result := EncodeDate(y, m, index);
              end
              else
                if period = 4 then {90 dagar}
                begin
                  DecodeDate(date, y, m, d);
                  result := EncodeDate(y, m, index);
                end;
        end;
  except
    result := now;
  end;
end;

procedure TfrmBokgraf.UpdateDateColumns(index: integer);
begin
  case Index of
    0:
      begin
        Drawgrid1.Colcount := 7 + 1;
        Trackbar1.position := bgDayLength1;
        DateTimePicker1.DateTime := GetStartDate(bgDate1, 1);
        trackbar2.position := BgOH;
        DateTimePicker1Change(nil);
        if BgSN then cbnameshow.Checked := True;
      end;
    1:
      begin
        Drawgrid1.Colcount := 14 + 1;
        Trackbar1.position := bgDayLength2;
        DateTimePicker1.DateTime := GetStartDate(bgDate2, 2);
        trackbar2.position := BgOH;
        DateTimePicker1Change(nil);
        if BgSN then cbnameshow.Checked := True;
      end;
    2:
      begin
        Drawgrid1.Colcount := 30 + 1;
        Trackbar1.position := bgDayLength3;
        DateTimePicker1.DateTime := GetStartDate(bgDate3, 3);
        trackbar2.position := BgOH;
        DateTimePicker1Change(nil);
        if BgSN then cbnameshow.Checked := True;
      end;
    3:
      begin
        Drawgrid1.Colcount := 90 + 1;
        Trackbar1.position := bgDayLength4;
        DateTimePicker1.DateTime := GetStartDate(bgDate4, 4);
        trackbar2.position := BgOH;
        DateTimePicker1Change(nil);
        if BgSN then cbnameshow.Checked := True;
      end;
  end;
end;

procedure TfrmBokgraf.ComboBox1Change(Sender: TObject);
begin
  UpdateDateColumns(Combobox1.ItemIndex);
end;

procedure TfrmBokgraf.TrackBar1Change(Sender: TObject);
var
  oldobj: integer;
begin
  oldobj := Drawgrid1.ColWidths[0];
  Drawgrid1.DefaultColWidth := Trackbar1.Position;
  Drawgrid1.ColWidths[0] := oldobj;
  case ComboBox1.itemindex of
    0: bgDayLength1 := Trackbar1.Position;
    1: bgDayLength2 := Trackbar1.Position;
    2: bgDayLength3 := Trackbar1.Position;
    3: bgDayLength4 := Trackbar1.Position;
  end;
end;

procedure TfrmBokgraf.DateTimePicker1Change(Sender: TObject);
begin
  Startdate := DateTimePicker1.DateTime - 1;
  UpdateDummyGrid;
end;

procedure TfrmBokgraf.DrawGrid1DblClick(Sender: TObject);
begin
  if frmClosing then
    exit;
  JustDblClicked := true;
  if MousePos in [mpStart, mpMid, mpEnd] then
  begin
    changing := true;
//    frmBokning.Loadbooking(mouseObj);
//    DrawGrid1.Invalidate;
//    if frmBokning.ShowModal = mrOK then
//      UpdateDummyGrid;
    frmMain.LoadContract(GridBookings[MouseObj].ID);

    MouseObj := -1;
    MousePos := mpNone;
    changing := false;
    DrawGrid1.Invalidate;
  end;
end;

procedure TfrmBokgraf.UpdateObjects;
var
  I, obj: integer;
begin
  obj := 0;
  SetLength(GridObjects, length(TotalObjects));
  for I := 0 to length(TotalObjects) - 1 do
    if ((Combobox2.Itemindex = 0) or (TotalObjects[i].TypeId = Combobox2.Itemindex)) and
    ((frmMain.GetStationIndex = 0) or (TotalObjects[i].StationId = Stations[frmMain.GetStationIndex-1].ID)) then
    begin
      GridObjects[obj] := TotalObjects[i];
      inc(obj);
    end;
  SetLength(GridObjects, obj);
  DrawGrid1.RowCount := length(GridObjects) + 1;
end;

procedure TfrmBokgraf.ComboBox2Click(Sender: TObject);
begin
  UpdateObjects;
  UpdateDummyGrid;
  remember := combobox2.ItemIndex; //!Benny för att komma ihåg vilken Typ
  RememberStation := frmMain.GetStationIndex;
end;

procedure TfrmBokgraf.DrawGrid1TopLeftChanged(Sender: TObject);
begin
  if changing then
    DrawGrid1.Invalidate;
end;

function TfrmBokgraf.TypeToId(str: string): integer;
var I: Integer;
begin
  result := -1;
  for I := 0 to length(ObjectTypes) - 1 do
    if ObjectTypes[i].Id = str then
    begin
      result := I;
      exit;
    end;
end;

procedure TfrmBokgraf.UpdateDBObjTypes;
var
  num, i: integer;
  ds: TAdoQuery;
begin
  ds := CreateDS('SELECT ObjType.ID, ObjType.Type FROM ObjType');
  try
    ds.Open;
    if not ds.IsEmpty then
    begin
      SetLength(ObjectTypes, 0);
      Num := 0;
      ds.First;
      while not ds.EOF do
      begin
        SetLength(ObjectTypes, num + 1);
        ObjectTypes[num].Id := ds.FieldByName('ID').AsString;
        ObjectTypes[num].FName := ds.FieldByName('Type').AsString;
        inc(num);
        ds.Next;
      end;
      ds.Close;
      Combobox2.clear;
//!    For num := 0 to length(ObjectTypes)-1 do
//!      Combobox2.items.add(ObjectTypes[num].FName);
      for I := 0 to length(Objtypes) - 1 do
        Combobox2.Items.add(Objtypes[i].ObTyp);
      Combobox2.itemindex := 0;
    end;
  except
  end;
  freeds(ds);
end;

procedure TfrmBokgraf.UpdateDBStations;
var
  num, i: integer;
  ds: TAdoQuery;
begin
  ds := CreateDS('Select StationID, Name FROM Station');
  try
    ds.Open;
    if not ds.IsEmpty then
    begin
      SetLength(Stations, 0);
      Num := 0;
      ds.First;
      while not ds.EOF do
      begin
        SetLength(Stations, num + 1);
        Stations[num].ID := ds.FieldByName('StationID').AsInteger;
        Stations[num].FName := ds.FieldByName('Name').AsString;
        inc(num);
        ds.Next;
      end;
      ds.Close;
    end;
  except
  end;
  freeds(ds);
end;


procedure TfrmBokgraf.UpdateDBObjects;
var
  num: integer;
  hinttext: string;
  ds: TADOQuery;
  sql : string;
begin
  sql := 'SELECT Objects.Reg_No, Objects.ObjNum, Objects.Model, Objects.Type, Objects.KM_N, Objects.DType, Objects.Color, Objects.Accesories, Objects.VStat, Objects.Note, Objects.Station, Station.Name as StationName';
  sql := sql + ' FROM Objects, Station where Objects.Station = Station.StationId and Objects.VStat='+edtVstat.Text+' Order by Objects.Type, Objects.Model, Objects.Reg_No';
  ds := CreateDS(sql);
  try
    ds.Open;
    SetLength(TotalObjects, 0);
    Num := 0;
    if not ds.IsEmpty then
    begin
      ds.First;
      while not ds.EOF do
      begin
        SetLength(TotalObjects, num + 1);
        TotalObjects[num].ID := ds.FieldByName('ObjNum').AsInteger;
        TotalObjects[num].TypeId := TypeToId(ds.FieldByName('Type').AsString);
        TotalObjects[num].StationId := ds.FieldByName('Station').AsInteger;
        TotalObjects[num].FName := ds.FieldByName('Reg_No').AsString;
        TotalObjects[num].Caption := ds.FieldByName('Reg_No').AsString;
        Hinttext := ' ObjektID : ' + ds.FieldByName('ObjNum').AsString + #13;
        Hinttext := Hinttext + ' RegNo : ' + ds.FieldByName('Reg_No').AsString + #13;
        Hinttext := Hinttext + ' Storlek :  ' + ds.FieldByName('Type').AsString + #13;
        Hinttext := Hinttext + ' Modell : ' + ds.FieldByName('Model').AsString + #13;
        Hinttext := Hinttext + ' Färg : ' + ds.FieldByName('Color').AsString + #13;
        Hinttext := Hinttext + ' Tillbehör : ' + ds.FieldByName('Accesories').AsString + #13;
        Hinttext := Hinttext + ' Drivmedel : ' + ds.FieldByName('DType').AsString + #13;
        Hinttext := Hinttext + ' Mätarställning : ' + ds.FieldByName('KM_N').AsString + #13;
        Hinttext := Hinttext + ' Station : ' + ds.FieldByName('StationName').AsString;
        if ds.FieldByName('Note').AsString > '' then
          Hinttext := Hinttext + #13 + #13 + ds.FieldByName('Note').AsString;
        TotalObjects[num].Hint := HintText;
        inc(num);
        ds.Next;
      end;
    end;
    ds.Close;
  except
  end;
  UpdateObjects;
  FreeDS(ds);
end;

function TfrmBokgraf.Reg_NoToObjectId(reg: string): integer;
var I: Integer;
begin
  result := -1;
  for I := 0 to length(TotalObjects) - 1 do
    if Trim(TotalObjects[I].FName) = trim(reg) then
    begin
      result := TotalObjects[I].Id;
      exit;
    end;
end;

procedure TfrmBokgraf.UpdateDBBookings;
var
  num: integer;
  ds: TADOQuery;
begin
  ds := CreateDS('SELECT Contr_Base.ContrId, Contr_Base.CustID, Contr_Base.Sign, Customer.Name, Contr_ObjT.OId, Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_Base.Status, Contr_Base.Referens' +
    ' FROM Contr_Base LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId LEFT JOIN Customer ON Contr_Base.CustID = Customer.Cust_Id WHERE Contr_ObjT.To_Time>''' + internaldatetostr(datetimepicker1.Date - Bak_Datum) + ''' ');
  try
    ds.Open;

    if not ds.IsEmpty then
    begin
      SetLength(GridBookings, 0);
      Num := 0;
      ds.First;
      while not ds.EOF do
      begin
        SetLength(GridBookings, num + 1);
        GridBookings[num].ID := ds.FieldByName('ContrId').AsInteger;
        GridBookings[num].ObjectID := Reg_NoToObjectId(ds.FieldByName('OId').AsString);
        GridBookings[num].From := ds.FieldByName('Frm_Time').AsDateTime;
        GridBookings[num].Tom := ds.FieldByName('To_Time').AsDateTime;
        GridBookings[num].Caption := ds.FieldByName('Name').AsString;
        GridBookings[num].Hint :=
          ds.FieldByName('Frm_Time').AsString + ' - ' +
          ds.FieldByName('OId').AsString + ', ' +
          ds.FieldByName('Name').AsString + ', (' +
          ds.FieldByName('Sign').AsString + ') - ' +
          ds.FieldByName('To_Time').AsString;
        if ds.FieldByName('Referens').AsString > '' then
          GridBookings[num].Hint := GridBookings[num].Hint + #13 + ds.FieldByName('Referens').AsString;
        GridBookings[num].Status := ds.FieldByName('Status').AsInteger;
        inc(num);
        ds.Next;
      end;
    end;
  except
  end;
  FreeDS(ds);
end;

procedure TfrmBokgraf.UpdateFromDatabase(Sender: TObject);
begin
  if not frmMain.OkToUpdateGraph then
    exit;
  screen.cursor := crHourGlass;
  try
    UpdateDBObjTypes;
    UpdateDBStations;
    UpdateDBObjects;
    UpdateDBBookings;
    UpdateDummyGrid;
  finally
    screen.cursor := crDefault;
  end;
end;

procedure TfrmBokgraf.Avsluta1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmBokgraf.Visalegend1Click(Sender: TObject);
begin
  dlgLegend := TdlgLegend.create(self);
  try
    dlgLegend.Showmodal;
  finally
    dlgLegend.free;
  end;
end;

procedure TfrmBokgraf.cbNameShowClick(Sender: TObject);
begin
  DrawGrid1.Invalidate;
  if cbnameshow.Checked then
    BgSN := true
  else
    BgSN := False;
end;

procedure TfrmBokgraf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmmain.SpeedButton4.flat := False;
  frmclosing := True;
  WriteINIFile;
  action := caFree;
  frmBokgraf := nil;
  if (not frmmain.SpeedButton1.Flat) and (not frmmain.SpeedButton2.Flat) and
     (not frmmain.SpeedButton3.Flat) and (not frmmain.SpeedButton4.Flat) then
    frmMain.panel1.visible := True;

end;

procedure TfrmBokgraf.ReadINIFile;
begin
    DebugInfo('+++ TfrmBokgraf.ReadINIFile +++');
   try
    clBooking := TColor(StrToInt(GetValueFromInit('Graf', frmmain.sign, 'clBooking', IntToStr(clBlue))));
    clContract := TColor(StrToInt(GetValueFromInit('Graf', frmmain.sign, 'clContract', IntToStr(clBlack))));
    clReturned := TColor(StrToInt(GetValueFromInit('Graf', frmmain.sign, 'clReturned', IntToStr(clGreen))));
    clLateBooking := TColor(StrToInt(GetValueFromInit('Graf', frmmain.sign, 'clLateBooking', IntToStr($000080FF))));
    clLateReturn := TColor(StrToInt(GetValueFromInit('Graf', frmmain.sign, 'clLateReturn', IntToStr(clRed))));
    clHistoric := TColor(StrToInt(GetValueFromInit('Graf', frmmain.sign, 'clHistoric', IntToStr(clGray))));
    clOther := TColor(StrToInt(GetValueFromInit('Graf', frmmain.sign, 'clOther', IntToStr(clOlive))));
    bgDate1 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDate1', IntToStr(0)));
    bgDate2 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDate2', IntToStr(0)));
    bgDate3 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDate3', IntToStr(0)));
    bgDate4 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDate4', IntToStr(0)));
    bak_datum := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'back_date', IntToStr(7)));

    BgOH := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'BgOH', IntToStr(24)));
    BgSN := StrToBool(GetValueFromInit('Graf', frmmain.sign, 'BgSN', 'False'));
    bgDayLength1 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDayLength1', IntToStr(60)));
    bgDayLength2 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDayLength2', IntToStr(60)));
    bgDayLength3 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDayLength3', IntToStr(60)));
    bgDayLength4 := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgDayLength4', IntToStr(60)));
    bgSnapMinutes := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'bgSnapMinutes', IntToStr(15)));
    bgFreeZoneStart := StrToTime(GetValueFromInit('Graf', frmmain.sign, 'bgFreeZoneStart', IntToStr(0)));
    bgFreeZoneEnd := StrToTime(GetValueFromInit('Graf', frmmain.sign, 'bgFreeZoneEnd', IntToStr(0)));
    ButtImage := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'ButtImage', IntToStr(1)));
    ComboBox1.Itemindex := StrToInt(GetValueFromInit('Graf', frmmain.sign, 'LastCalenderW', IntToStr(0)));
   except
   end;
    DebugInfo('--- TfrmBokgraf.ReadINIFile ---');
end;


procedure TfrmBokgraf.WriteINIFile;
begin
    DebugInfo('+++ TfrmBokgraf.WriteINIFile +++');
try
  SetValueToInit('Graf',frmmain.sign, 'clBooking', IntToStr(clBooking));
  SetValueToInit('Graf',frmmain.sign, 'clContract', IntToStr(clContract));
  SetValueToInit('Graf',frmmain.sign, 'clReturned', IntToStr(clReturned));
  SetValueToInit('Graf',frmmain.sign, 'clLateBooking', IntToStr(clLateBooking));
  SetValueToInit('Graf',frmmain.sign, 'clLateReturn', IntToStr(clLateReturn));
  SetValueToInit('Graf',frmmain.sign, 'clHistoric', IntToStr(clHistoric));
  SetValueToInit('Graf',frmmain.sign, 'clOther', IntToStr(clOther));
  SetValueToInit('Graf',frmmain.sign, 'Back_Date', IntToStr(Bak_Datum));
  SetValueToInit('Graf',frmmain.sign, 'bgDate1', IntToStr(bgDate1));
  SetValueToInit('Graf',frmmain.sign, 'bgDate2', IntToStr(bgDate2));
  SetValueToInit('Graf',frmmain.sign, 'bgDate3', IntToStr(bgDate3));
  SetValueToInit('Graf',frmmain.sign, 'bgDate4', IntToStr(bgDate4));
  SetValueToInit('Graf',frmmain.sign, 'BgOH', IntToStr(BgOH));
  SetValueToInit('Graf',frmmain.sign, 'BgSN', BoolToStr(BgSN,True));
  SetValueToInit('Graf',frmmain.sign, 'bgDayLength1', IntToStr(bgDayLength1));
  SetValueToInit('Graf',frmmain.sign, 'bgDayLength2', IntToStr(bgDayLength2));
  SetValueToInit('Graf',frmmain.sign, 'bgDayLength3', IntToStr(bgDayLength3));
  SetValueToInit('Graf',frmmain.sign, 'bgDayLength4', IntToStr(bgDayLength4));
  SetValueToInit('Graf',frmmain.sign, 'bgSnapMinutes', IntToStr(bgSnapMinutes));
  SetValueToInit('Graf',frmmain.sign, 'bgFreeZoneStart', TimeToStr(bgFreeZoneStart));
  SetValueToInit('Graf',frmmain.sign, 'bgFreeZoneEnd', TimeToStr(bgFreeZoneEnd));
  SetValueToInit('Graf',frmmain.sign, 'ButtImage', IntToStr(ButtImage));
  SetValueToInit('Graf',frmmain.sign, 'LastCalenderW', IntToStr(ComboBox1.ItemIndex));
except
end;
    DebugInfo('--- TfrmBokgraf.WriteINIFile ---');
end;

procedure TfrmBokgraf.UpdatePanelHeight;
begin
  if ButtImage = 0 then {}
  begin
    Panel1.Height := 33;
  end
  else
  begin
    Panel1.Height := 97;
  end;
  SpeedButton1.Glyph := nil;
  ImageList1.GetBitmap(Buttimage, SpeedButton1.Glyph);
end;

procedure TfrmBokgraf.SpeedButton1Click(Sender: TObject);
begin
  ButtImage := (ButtImage + 1) mod 2;
  UpdatePanelHeight;
end;

procedure TfrmBokgraf.TrackBar2Change(Sender: TObject);
var x: integer;
begin
  x := Drawgrid1.RowHeights[0];
  Drawgrid1.DefaultRowHeight := Trackbar2.Position;
  Drawgrid1.RowHeights[0] := x;
  BgOH := Trackbar2.position;

end;

procedure TfrmBokgraf.FormActivate(Sender: TObject);
begin
  Timer1.Enabled := True;
  timer1.Interval := FrmMain.ObKTimer * 1000;
//! allt har Benny Lagt till
  screen.cursor := crHourGlass;
  try
    UpdateDBObjTypes;
    UpdateDBStations;
    UpdateDBObjects;
    UpdateDBBookings;
    UpdateDummyGrid;
  finally
    screen.cursor := crDefault;
    FrmMain.Speedbutton4.Flat := True;
  end;
  //! Ända hit här.. För att updatera från databasen varje gång man går in...
  combobox2.ItemIndex := remember; //!Benny för att komma ihåg vilken Typ
  UpdateObjects; //!Benny för att komma ihåg vilken Typ
  UpdateDummyGrid; //!Benny för att komma ihåg vilken Typ
end;

procedure TfrmBokgraf.Rutnt1Click(Sender: TObject);
begin
  speedbutton1.click;
end;

procedure TfrmBokgraf.Timer1Timer(Sender: TObject);
begin
  if not frmMain.OkToUpdateGraph then
    exit;
  screen.cursor := crHourGlass;
  try
    UpdateDBObjTypes;
    UpdateDBStations;
    UpdateDBObjects;
    UpdateDBBookings;
    UpdateDummyGrid;
  finally
    screen.cursor := crDefault;
  end;
  combobox2.ItemIndex := remember; //!Benny för att komma ihåg vilken Typ
  UpdateObjects; //!Benny för att komma ihåg vilken Typ
  UpdateDummyGrid; //!Benny för att komma ihåg vilken Typ
end;

procedure TfrmBokgraf.Timerinstllningar1Click(Sender: TObject);
begin
  dlgtimer := Tdlgtimer.create(self);
  Dlgtimer.showmodal;
  if dlgtimer.ModalResult = mrok then
    frmmain.ObKTimer := Strtoint(Dlgtimer.edttimer.text);
  timer1.interval := FrmMain.ObKTimer * 1000;
  freeandNil(dlgtimer);
end;

procedure TfrmBokgraf.FormDeactivate(Sender: TObject);
begin
  Timer1.enabled := False;
end;

procedure TfrmBokgraf.BtnPrintClick(Sender: TObject);
//var Printer: TPrinter;
begin
  printer.orientation := poLandscape;
  frmbokgraf.PrintScale := poprinttofit;
  frmbokgraf.print;
//!  printer.Orientation:=poPortrait;
end;

procedure TfrmBokgraf.Skrivut1Click(Sender: TObject);
begin
  BtnPrint.Click;
end;

procedure TfrmBokgraf.DateTimePicker1CloseUp(Sender: TObject);
begin
//!
end;

procedure TfrmBokgraf.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TfrmBokgraf.FormHide(Sender: TObject);
begin
  Timer1.Enabled := False;
end;

procedure TfrmBokgraf.FormDestroy(Sender: TObject);
begin
   FreeDS(Qtemp);
end;

initialization
  clBooking := clBlue;
  clContract := clBlack;
  clReturned := clGreen;
  clLateBooking := $000080FF;
  clLateReturn := clRed;
  clHistoric := clGray;
  clOther := clOlive;

  bgDate1 := 1; {vecka}
  bgDate2 := -3; {14 dagar}
  bgDate3 := 1; {30 dagar}
  bgDate4 := 0; {3 månader}
  {Dygnsbredd: 20-120 pixlar}
  bgDayLength1 := 60; {vecka}
  bgDayLength2 := 60; {14 dagar}
  bgDayLength3 := 60; {30 dagar}
  bgDayLength4 := 60; {3 månader}
  {Objekts Höjd}
  BgOH := 24;
  BgSN := False;
  {Snapfunktion}
  bgSnapMinutes := 15;
  bgFreeZoneStart := 0.0; {Starttid för bokningsfri zon ex.v. 19:00}
  bgFreeZoneEnd := 0.0; {Sluttid för bokningsfri zon ex.v. 06:00}

  stChangeMinValue := 7; {Tillåt förändringar på bokningar och kontrakt}


end.

