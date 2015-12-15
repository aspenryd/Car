{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Stat\Statistik.pas
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
{ $Log:  13033: STATISTIK.pas
{
{   Rev 1.0    2003-03-20 13:59:34  peter
}
{
{   Rev 1.0    2003-03-17 14:39:46  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:08  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:10  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Statistik;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, LookOut, ImgList, Db, ADODB, Grids, DBGrids, DBCGrids, StdCtrls,
  TeeProcs, TeEngine, Chart, Series, Buttons, Math, EQDateEdit;

type
  TStatType = (stAll, stInvoice, stReturned, stContract, stBooked);

  TCar = record
    ObjNum : integer;
    RegNr : string;
    StationId : integer;
  end;

  TCarList = class(TComponent)
  private
    FObjectList : array of TCar;
  public
    function Count : integer;
    procedure Clear;
    function GetCar(RegNr : string) : TCar;
    function GetCarByNum(ObjNum : integer) : TCar;
    function GetCarId(RegNr : string) : integer;
    function AddCar(RegNr : string; StationId : integer) : integer;
  end;

  TCarStationMatrix = class(TComponent)
  private
    FCarList : TCarList;
    // Matrix consists of DateId * CarId
    FStationIDMatrix : array of array of integer;
    FStartDate: TDateTime;
    FEndDate: TDateTime;
    procedure SetEndDate(const Value: TDateTime);
    procedure SetStartDate(const Value: TDateTime);
    function HasCarId(RegNr: string): integer;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy;
    property StartDate : TDateTime read FStartDate write SetStartDate;
    property EndDate : TDateTime read FEndDate write SetEndDate;
    function GetCarId(RegNr : string; AllowAdd : boolean = false) : integer;
    function GetDateId(Date : TDateTime) : integer;
    function GetStationId(CarId : integer; DateId : Integer) : integer;
    function GetStationIdSlow(RegNr : string; Date : TDateTime) : integer;
    procedure AddStationId(CarId : integer; DateId : Integer; StationId : integer);
    procedure AddStationIdSlow(RegNr : string; Date : TDateTime; StationId : integer);
    procedure AddStationIdRangeSlow(RegNr : string; StationId : integer; DateFrom, DateTo : TDateTime);
    procedure GetObjCount(StationId : integer; DateFrom, DateTo : TDateTime; var ObjCount, ObjDayCount : integer);
    procedure Clear;
  end;

  TFrmStat = class(TForm)
    ImageList1: TImageList;
    QStatS: TDataSource;
    QStat: TADOQuery;
    Kstat: TADOQuery;
    KstatS: TDataSource;
    KundPanel: TPanel;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    GBPris: TGroupBox;
    LB: TListBox;
    PStat: TPanel;
    Label16: TLabel;
    Label7: TLabel;
    Label17: TLabel;
    Label8: TLabel;
    Label18: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    Label12: TLabel;
    Label19: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    Label14: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label24: TLabel;
    Label15: TLabel;
    Label22: TLabel;
    Label13: TLabel;
    Label21: TLabel;
    Label9: TLabel;
    Label25: TLabel;
    PKund: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    GBObj: TGroupBox;
    LBO: TListBox;
    StatQ: TADOQuery;
    GB2: TGroupBox;
    LBTill: TListBox;
    PAObjST: TPanel;
    Panel2: TPanel;
    Od1: TOpenDialog;
    GroupBox4: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ScrollBox1: TScrollBox;
    qrfrom: TEQDateEdit;
    qrto: TEQDateEdit;
    qrfrom2: TEQDateEdit;
    qrto2: TEQDateEdit;
    qrfrom3: TEQDateEdit;
    qrto3: TEQDateEdit;
    qrfrom4: TEQDateEdit;
    qrto4: TEQDateEdit;
    edSql: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    BitBtn8: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure qrfromKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Label31Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    { Private declarations }
  private
    FCarStationMatrix : TCarStationMatrix;
    procedure FillObjStationMatrix(DateFrom, DateTo: TDateTime);
  public

    { Public declarations }
    Typ: string;
  end;

var
  FrmStat: TFrmStat;
  Lista: TList;
  RowSpace: Integer;
  ResolutionX, ResolutionY: Integer;
  DefaultWhereStr: string;

const
  SQL_1 = ' ((fakthead.faktdat>=''%0:s'') and (fakthead.faktdat<=''%1:s'')) ';
  SQL_2 = ' ((fakthead.to_time>=''%0:s'') and (fakthead.to_time<=''%1:s 23:59:00'')) ';
  SQL_3 = ' ((fakthead.frm_time>=''%0:s'') and (fakthead.frm_time<=''%1:s 23:59:00'')) ';
  SQL_4 = ' (((fakthead.frm_time>=''%0:s'') and (fakthead.frm_time<=''%1:s 23:59:00'')) or ((fakthead.to_time>=''%0:s'') and (fakthead.to_time<=''%1:s 23:59:00'')) or  ((fakthead.frm_time<''%0:s'') and (fakthead.to_time>''%1:s 23:59:00'')))';
  SQL_5 = ' ((o.To_Time>=''%0:s'') and (o.Frm_Time<=''%1:s'')) ';

implementation

uses Faktuts, Main, Printers, DateUtil;

{$R *.DFM}



function GetData(sql: string): Real;
var
  ds: TADOQuery;
begin
  ds := CreateDS(Sql);
  ds.Open;
  if ds.IsEmpty then
    Result := 0
  else
    Result := ds.Fields[0].AsFloat;
  FreeDS(ds);
end;

procedure AddTextAndData(o: TWinControl; Data1, Data2: string; Data3: string = ''; wherestr: string = '');
var
  lab1, lab2: TLabel;
  NextLeft: Integer;
begin
  NextLeft := 10;

  if data1 <> '' then
  begin
    NextLeft := 20;
    lab1 := TLabel.Create(o);
    lab1.Parent := o;
    lab1.Left := NextLeft;
    lab1.Top := o.Tag;
    lab1.Caption := Data1;
//    Lista.Add(lab1);
    NextLeft := NextLeft + 100;
  end;

  if Data2 <> '' then
  begin
    lab1 := TLabel.Create(o);
    lab1.Parent := o;
    lab1.Alignment := taRightJustify;
    lab1.Left := NextLeft;
    lab1.Top := o.Tag;
    lab1.Caption := data2;
//    Lista.Add(lab1);
  end;

  if Data3 <> '' then
  begin
    lab1 := TLabel.Create(o);
    lab1.Parent := o;
    lab1.Left := NextLeft + lab1.Width + 2;
    lab1.Top := o.Tag;
    lab1.Caption := data3;
//    Lista.Add(lab1);
  end;

  o.tag := o.tag + RowSpace;
  if o.Tag > o.Height then
    o.Height := o.Tag + RowSpace;

end;

function DiffDate(fd, td: TDateTime): Integer;
begin
  Result := 0;
  while (fd + 0.125) < td do
  begin
    inc(Result);
    fd := fd + 1;
  end;
  if Result < 1 then
    Result := 1;

end;

procedure BuildStationIdMatrix(FromDate, ToDate : TDateTime; var Matrix : TCarStationMatrix);
var
  ds: TAdoQuery;
  i : integer;
begin
  Matrix.StartDate := FromDate;
  Matrix.EndDate := ToDate;


  //Fill object list
  ds := CreateDS('select reg_no, station from objects');
  try
    try
      Matrix.AddStationId(Matrix.GetCarId(ds.Fields[0].asString), Matrix.GetDateId(date), ds.Fields[1].asInteger);
    except
    end;
  finally
    FreeDS(ds);
  end;

  ds := CreateDS('select * from stationchange where changedate >= FromDate order by changedate desc, id desc');
  try
    try
      Matrix.AddStationId(Matrix.GetCarId(ds.Fields[0].asString), Matrix.GetDateId(ToDate), ds.Fields[1].asInteger);
    except
    end;
  finally
    FreeDS(ds);
  end;

end;

function GetObjectDays(StationId : integer; wherestr : string; DateFrom, DateTo : TDateTime) : integer;
var
  ds: TAdoQuery;
  i : integer;
begin
  result := 0;
  if StationId = -1 then
  begin
    ds := CreateDS('select count(*) from objects');
    try
//      result := ds.Fields[0].AsInteger * (DateTo + 1 - DateFrom);
    finally
      FreeDS(ds);
    end;

  end else
  begin
    //Hämta alla objekt
    //Gå igenom StationChange bakifrån
    //För varje dag kontrollera vad bilarna har för stationsnummer
    ds := CreateDS('select objnum, station from objects');
    try
      while not ds.Eof do
      begin

        ds.Next;
      end;
    finally
      FreeDS(ds);
    end;
  end;
end;

procedure GetObjectsAndContrCount2(from : TStatType; StationId : integer; wherestr : string; DateFrom, DateTo : string; var DayCount, ObjCount, ObjDayCount, ContCount : integer);
var
  koref: Integer;
  ds: TAdoQuery;
  LDateFrom, LDateTo : TDateTime;
  lTempFromDate, ltempToDate: TDateTime;
  lTempstationId : integer;
begin
  ObjCount := 0;
  DayCount := 0;
  koref := 0;
  ContCount := 0;
  LDateFrom := VisibleStrToDate(DateFrom);
  LDateTo := VisibleStrToDate(DateTo);
  case from of
    stInvoice :
      ds := CreateDS(Format('select oid,frm_time,to_time,koref from fakthead where ' + DefaultWhereStr + ' and ((fakthead.status=0) or (fakthead.status=3)) ' + wherestr + ' order by oid,koref', [DateFrom, DateTo]));
    stReturned :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status>8)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
    stContract :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status=4)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
    stBooked :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status=2)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
    stAll :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
  else
    ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status>8)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
  end;

  try

    FrmStat.FCarStationMatrix.GetObjCount(StationId, LDateFrom, LDateTo, ObjCount, ObjDayCount);

    ds.Open;
    while not ds.eof do
    begin
      if koref <> ds.Fields[3].AsInteger then
      begin
        koref := ds.Fields[3].AsInteger;
        if (StationId <0) or (FrmStat.FCarStationMatrix.GetStationIdSlow(ds.Fields[0].AsString,ds.Fields[1].AsDateTime) = StationId) then
        begin
          lTempFromDate := trunc(ds.Fields[1].AsDateTime);
          ltempToDate  := trunc(ds.Fields[2].AsDateTime);
          if lTempFromDate < LDateFrom then
            lTempFromDate := LDateFrom;
          if ltempToDate > LDateTo then
            ltempToDate := LDateTo;
          DayCount := DayCount + DiffDate(lTempFromDate, ltempToDate)+1;
          inc(ContCount);
        end;
      end;
      ds.Next;
    end;
  finally
    FreeDS(ds);
  end;
  if ObjDayCount = 0 then
    ObjDayCount := 1;
end;

procedure GetObjectsAndContrCount(from : TStatType; wherestr : string; DateFrom, DateTo : string; var DayCount, ObjCount, ContCount : integer);
var
  LastStr: string;
  koref: Integer;
  ds: TAdoQuery;
begin
  ObjCount := 0;
  DayCount := 0;
  koref := 0;
  ContCount := 0;
  LastStr := 'xxxxxxxxxx';

  case from of
    stInvoice :
      ds := CreateDS(Format('select oid,frm_time,to_time,koref from fakthead where ' + DefaultWhereStr + ' and ((fakthead.status=0) or (fakthead.status=3)) ' + wherestr + ' order by oid,koref', [DateFrom, DateTo]));
    stReturned :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status>8)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
    stContract :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status=4)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
    stBooked :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status=2)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
    stAll :
      ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
  else
    ds := CreateDS(Format('select o.Oid, o.Frm_Time, o.To_Time, o.ContrId, b.status from contr_objt o, contr_base b where ' + SQL_5 + ' and o.ContrId = b.ContrId and ((b.status>8)) ' + wherestr + ' order by o.Oid, o.ContrId', [DateFrom, DateTo]));
  end;
  try
    ds.Open;
    while not ds.eof do
    begin
      if ds.Fields[0].AsString <> LastStr then
      begin
        inc(ObjCount);
        LastStr := ds.Fields[0].AsString;
      end;
      if koref <> ds.Fields[3].AsInteger then
      begin
  //      AntalDagar := AntalDagar + DiffDate(max(ds.Fields[1].AsDateTime, StrToDate(DateFrom)), min(ds.Fields[2].AsDateTime, StrToDate(DateTo) + 0.99));
        DayCount := DayCount + DiffDate(ds.Fields[1].AsDateTime, ds.Fields[2].AsDateTime);
        koref := ds.Fields[3].AsInteger;
        inc(ContCount);
      end;
      ds.Next;
    end;
  finally
    FreeDS(ds);
  end;
end;

procedure TFrmStat.FillObjStationMatrix(DateFrom, DateTo : TDateTime);
var
  ds: TAdoQuery;
  ltempDateTo : TDateTime;
begin
  FCarStationMatrix.Clear;
  FCarStationMatrix.EndDate := DateTo;
  FCarStationMatrix.StartDate := DateFrom;

  ds := CreateDS('select Reg_No, Station from objects order by reg_no');
  try
    ds.Open;
    while not ds.eof do
    begin
      FCarStationMatrix.AddStationIdRangeSlow(ds.Fields[0].AsString, ds.Fields[1].AsInteger, DateFrom, DateTo);
      ds.Next;
    end;
  finally
    FreeDS(ds);
  end;


  ds := CreateDS('Select sc.FromStation, o.Reg_No, sc.ChangeDate from stationchange sc, Objects o where sc.objnum = o.objnum order by ChangeDate desc');
  try
    ds.Open;
    while not ds.eof do
    begin
      if ds.Fields[2].AsDateTime < DateFrom then
        ds.Last
      else
      begin
        ltempDateTo := DateTo;
        if ds.Fields[2].AsDateTime < DateTo then
          ltempDateTo := ds.Fields[2].AsDateTime;
        FCarStationMatrix.AddStationIdRangeSlow(ds.Fields[1].AsString, ds.Fields[0].AsInteger, DateFrom, ltempDateTo);
        ds.Next;
      end;
    end;
  finally
    FreeDS(ds);
  end;
end;


procedure FillData(o: TWinControl; DateFrom, DateTo: string; Ledtext: Boolean; wherestr: string = '');
var
  Pan: TGroupBox;
  ds: TAdoQuery;
  AntalObjekt, AntalDagar, AntalKoref: integer;
  AntalObjekt2, AntalDagar2, AntalKoref2: integer;
  AntalObjekt3, AntalDagar3, AntalKoref3: integer;
  AntalObjekt4, AntalDagar4, AntalKoref4: integer;
  AntalObjekt5, AntalDagar5, AntalKoref5: integer;
  AntalObjekt6, AntalDagar6, AntalKoref6, Antal6: integer;
  AntalObjekt7, AntalDagar7, AntalKoref7, Antal7: integer;
  AntalObjekt8, AntalDagar8, AntalKoref8, Antal8: integer;
  AntalObjekt9, AntalDagar9, AntalKoref9, Antal9: integer;
  Antal, Antal2, Antal3, Antal4, Antal5 : real;
  AntalObjektDagar : integer;
  LastStr: string;
  koref: Integer;
  s1, s2, s3, s4, s5, s6: tDatetime;
  TotDagar: Integer;
begin
  Pan := TGroupBox.Create(o);
  pan.Caption := DateFrom + ' - ' + DateTo;
  pan.Parent := o;
  Pan.Top := 18;
  Pan.Left := o.Tag;
  Pan.Height := o.Height - 24;
//  pan.Align := alLeft;
  if Ledtext then
    pan.Width := 250
  else
    pan.Width := 150;
  Pan.Tag := 20;
  Lista.Add(pan);
  o.Tag := o.Tag + Pan.Width;


  LastStr := 'xxxxxxxxxx';
  AntalObjekt := 0;
  koref := 0;
  AntalKoref := 0;
  s1 := 0;
  s2 := 0;

  FrmStat.FillObjStationMatrix(VisibleStrToDate(DateFrom), VisibleStrToDate(DateTo));

  GetObjectsAndContrCount(stInvoice, wherestr, DateFrom, DateTo, AntalDagar, AntalObjekt, AntalKoref);
  Antal := AntalObjekt * (StrToDate(DateTo) + 1 - StrToDate(DateFrom));

{
  GetObjectsAndContrCount(stReturned, wherestr, DateFrom, DateTo, AntalDagar5, AntalObjekt, AntalKoref);
  Antal5 := AntalObjekt * (StrToDate(DateTo) + 1 - StrToDate(DateFrom));

  GetObjectsAndContrCount(stContract, wherestr, DateFrom, DateTo, AntalDagar3, AntalObjekt, AntalKoref);
  Antal3 := AntalObjekt * (StrToDate(DateTo) + 1 - StrToDate(DateFrom));

  GetObjectsAndContrCount(stBooked, wherestr, DateFrom, DateTo, AntalDagar4, AntalObjekt, AntalKoref);
  Antal4 := AntalObjekt * (StrToDate(DateTo) + 1 - StrToDate(DateFrom));
}
//  GetObjectsAndContrCount(stAll, wherestr, DateFrom, DateTo, AntalDagar6, AntalObjekt, AntalKoref);
//  Antal6 := AntalObjekt * (StrToDate(DateTo) + 1 - StrToDate(DateFrom));

  GetObjectsAndContrCount2(stReturned, -1, wherestr, DateFrom, DateTo, AntalDagar8, AntalObjekt8, Antal8, AntalKoref8);
  GetObjectsAndContrCount2(stContract, -1, wherestr, DateFrom, DateTo, AntalDagar7, AntalObjekt7, Antal7, AntalKoref7);
  GetObjectsAndContrCount2(stBooked, -1, wherestr, DateFrom, DateTo, AntalDagar9, AntalObjekt9, Antal9, AntalKoref9);
  GetObjectsAndContrCount2(stAll, -1, wherestr, DateFrom, DateTo, AntalDagar6, AntalObjekt6, Antal6, AntalKoref6);

  if Antal = 0 then Antal := 1;
  if Antal3 = 0 then Antal3 := 1;
  if Antal4 = 0 then Antal4 := 1;
  if Antal5 = 0 then Antal5 := 1;
  if Antal6 = 0 then Antal6 := 1;

  LastStr := 'xxxxxxxxxx';
  AntalObjekt2 := 0;
  koref := 0;

  ds := CreateDS(Format('select oid,frm_time,to_time,koref from fakthead where ' + SQL_4 + ' and ((fakthead.status=0) or (fakthead.status=3)) ' + wherestr + ' order by oid,koref', [DateFrom, DateTo]));
  ds.Open;
  while not ds.eof do
  begin
    if ds.Fields[0].AsString <> LastStr then
    begin
      if not (LastStr = 'xxxxxxxxxx') then
      begin
        TotDagar := TotDagar + trunc(max(s2, StrToDate(DateTo)) - min(s1, StrToDate(DateFrom)) + 1);
      end;
//      s1 := trunc(ds.Fields[1].AsDateTime);
//      s2 := trunc(ds.Fields[2].AsDateTime);
      s1 := trunc(max(ds.Fields[1].AsDateTime, StrToDate(DateFrom)));
      s2 := trunc(min(ds.Fields[2].AsDateTime, StrToDate(DateTo) + 0.99));
      AntalObjekt2 := AntalObjekt2 + 1;
      LastStr := ds.Fields[0].AsString;
    end;
    if s2 < trunc(ds.Fields[2].AsDateTime) then
      s2 := trunc(min(ds.Fields[2].AsDateTime, StrToDate(DateTo)));
//        s2 := trunc(ds.Fields[2].AsDateTime);
    if s1 > trunc(ds.Fields[1].AsDateTime) then
      s1 := trunc(max(ds.Fields[1].AsDateTime, StrToDate(DateFrom)));


//        s1 := trunc(ds.Fields[1].AsDateTime);


    if koref <> ds.Fields[3].AsInteger then
    begin
      AntalDagar2 := AntalDagar2 + DiffDate(max(ds.Fields[1].AsDateTime, StrToDate(DateFrom)), min(ds.Fields[2].AsDateTime, StrToDate(DateTo) + 0.99));
//      AntalDagar2 := AntalDagar2 + DiffDate(ds.Fields[1].AsDateTime, ds.Fields[2].AsDateTime);
      koref := ds.Fields[3].AsInteger;
      AntalKoref2 := AntalKoref2 + 1;
    end;
    ds.Next;
  end;
  TotDagar := TotDagar + trunc(max(s2, StrToDate(DateTo)) - min(s1, StrToDate(DateFrom)) + 1);
  Antal2 := TotDagar;

//  Antal2 := AntalObjekt2 * (StrToDate(DateTo) + 1 - StrToDate(DateFrom));
  FreeDS(ds);
  if Antal2 = 0 then Antal2 := 1;



  if Ledtext then
  begin
    AddTextAndData(pan, 'Hyresintäkter', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad=1) or (rad=3) or (rad=999)) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, 'Kmintäkter', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad=2) or (rad=4)) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, 'Självriskreducering', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where (rad=5) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, 'Övriga Intäkter', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad>5) and (rad<999)) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '- Varav bränsle', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad>5) and (rad<999)) and ((faktrad.text=''' + 'BENSIN' + ''') or (text=''' + 'BENSIN 95' + ''') or (text=''' + 'DIESEL' + ''')) AND ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, ' ', '------------------');
    AddTextAndData(pan, 'Total', FormatFloat('#,##0.00', GetData(Format('select sum(faktsum-momssum-avrundning) from fakthead where ' + DefaultWhereStr + ' ' + wherestr, [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '', '');
    AddTextAndData(pan, 'Körda km', FormatFloat('#,##0', GetData(Format('select sum(km_in-km_out) from fakthead where ' + DefaultWhereStr + ' ' + wherestr, [DateFrom, DateTo]))), ' km');
    AddTextAndData(pan, 'Hyrdagar', FormatFloat('#,##0', AntalDagar), ' dagar');
    AddTextAndData(pan, 'Antal Objekt', FormatFloat('#,##0', AntalObjekt), '');
    AddTextAndData(pan, 'Antal Kontrakt', FormatFloat('#,##0', AntalKoref), '');
    AddTextAndData(pan, 'Bel.grad fakturerat', FormatFloat('#,##0.00', AntalDagar * 100.0 / antal), '%');
    AddTextAndData(pan, 'Bel.grad period', FormatFloat('#,##0.00', AntalDagar2 * 100.0 / antal2), '%');
    AddTextAndData(pan, '', '');
    AddTextAndData(pan, 'Alla Stationer', '');
    AddTextAndData(pan, 'Bel.grad återlämnat', FormatFloat('#,##0.00', AntalDagar8 * 100.0 / antal8), '%');
    AddTextAndData(pan, 'Bel.grad kontrakt', FormatFloat('#,##0.00', AntalDagar7 * 100.0 / antal7), '%');
    AddTextAndData(pan, 'Bel.grad bokningar', FormatFloat('#,##0.00', AntalDagar9 * 100.0 / antal9), '%');
    AddTextAndData(pan, 'Bel.grad totalt', FormatFloat('#,##0.00', AntalDagar6 * 100.0 / antal6), '%');


    ds := CreateDS(Format('select StationId, Name from station', []));
    ds.Open;
    while not ds.eof do
    begin
      AddTextAndData(pan, '', '');
      AddTextAndData(pan, ds.Fields[1].AsString, '');
      GetObjectsAndContrCount2(stReturned, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar8, AntalObjekt8, Antal8, AntalKoref8);
      GetObjectsAndContrCount2(stContract, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar7, AntalObjekt7, Antal7, AntalKoref7);
      GetObjectsAndContrCount2(stBooked, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar9, AntalObjekt9, Antal9, AntalKoref9);
      GetObjectsAndContrCount2(stAll, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar6, AntalObjekt6, Antal6, AntalKoref6);
      AddTextAndData(pan, 'Bel.grad återlämnat', FormatFloat('#,##0.00', AntalDagar8 * 100.0 / antal8), '%');
      AddTextAndData(pan, 'Bel.grad kontrakt', FormatFloat('#,##0.00', AntalDagar7 * 100.0 / antal7), '%');
      AddTextAndData(pan, 'Bel.grad bokningar', FormatFloat('#,##0.00', AntalDagar9 * 100.0 / antal9), '%');
      AddTextAndData(pan, 'Bel.grad totalt', FormatFloat('#,##0.00', AntalDagar6 * 100.0 / antal6), '%');
      ds.Next;
    end;
    FreeDS(ds);



  end
  else
  begin
    AddTextAndData(pan, '', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad=1) or (rad=3) or (rad=999)) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad=2) or (rad=4)) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where (rad=5) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad>5) and (rad<999)) and ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', GetData(Format('select sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad>5) and (rad<999)) and ((text=''BENSIN'') or (text=''BENSIN 95'') or (text=''DIESEL'')) AND ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '', '------------------');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', GetData(Format('select sum(faktsum-momssum-avrundning) from fakthead where ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ':-');
    AddTextAndData(pan, '', '');
    AddTextAndData(pan, '', FormatFloat('#,##0', GetData(Format('select sum(km_in-km_out) from fakthead where ' + DefaultWhereStr + ' ' + wherestr + '', [DateFrom, DateTo]))), ' km');
    AddTextAndData(pan, '', FormatFloat('#,##0', AntalDagar), ' dagar');
    AddTextAndData(pan, '', FormatFloat('#,##0', AntalObjekt), '');
    AddTextAndData(pan, '', FormatFloat('#,##0', AntalKoref), '');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar * 100.0 / antal), '%');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar2 * 100.0 / antal2), '%');
    AddTextAndData(pan, '', '', '');
    AddTextAndData(pan, '', '', '');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar8 * 100.0 / antal8), '%');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar7 * 100.0 / antal7), '%');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar9 * 100.0 / antal9), '%');
    AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar6 * 100.0 / antal6), '%');

    ds := CreateDS(Format('select StationId, Name from station', []));
    ds.Open;
    while not ds.eof do
    begin
      AddTextAndData(pan, '', '');
      AddTextAndData(pan, '', '');
      GetObjectsAndContrCount2(stReturned, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar8, AntalObjekt8, Antal8, AntalKoref8);
      GetObjectsAndContrCount2(stContract, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar7, AntalObjekt7, Antal7, AntalKoref7);
      GetObjectsAndContrCount2(stBooked, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar9, AntalObjekt9, Antal9, AntalKoref9);
      GetObjectsAndContrCount2(stAll, ds.Fields[0].AsInteger, wherestr, DateFrom, DateTo, AntalDagar6, AntalObjekt6, Antal6, AntalKoref6);
      AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar8 * 100.0 / antal8), '%');
      AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar7 * 100.0 / antal7), '%');
      AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar9 * 100.0 / antal9), '%');
      AddTextAndData(pan, '', FormatFloat('#,##0.00', AntalDagar6 * 100.0 / antal6), '%');
      ds.Next;
    end;
    FreeDS(ds);
//    AddTextAndData(pan, '', FormatFloat('#,##0', GetData(Format('select sum(datediff(d,frm_time,to_time)) from fakthead where '+DefaultWhereStr+'', [DateFrom, DateTo]))), ' dagar');
//    AddTextAndData(pan, '',FormatFloat('#,##0.00',(GetData(Format('select sum(datediff(d,frm_time,to_time)) from fakthead where '+DefaultWhereStr+'', [DateFrom, DateTo]))*100.0/antal)), '%');
  end;
end;

{
select 1,'Hyresintäkter',sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad=1) or (rad=3)) and ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31'))
union
select 2,'Kilometer',sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where ((rad=2) or (rad=4)) and ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31'))
union
select 3,'Självriskreducering',sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where rad=5 and ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31'))
union
select 4,cast(text as varchar(30)),sum(summa) from faktrad inner join fakthead on faktrad.faktnr=fakthead.faktnr where rad>5 and ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31')) group by text
union
select 5,'Moms',sum(momssum) from fakthead where ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31'))
union
select 6,'Körda km',sum(km_in-km_out) from fakthead where ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31'))
union
select 7,'hyrdagar',sum(datediff(d,frm_time,to_time)) from fakthead where ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31'))
union
select 8,'Betsätt '+payment,sum(varuvarde) from fakthead where ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31')) group by payment
union
select 9,'Objtyp '+otype,sum(varuvarde) from fakthead where ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31')) group by otype
union
select 10,'Objekt '+oid,sum(varuvarde) from fakthead where ((fakthead.to_time>='2001-05-01') and (fakthead.to_time<='2005-05-31')) and otype='Liten' group by oid

}


procedure TFrmStat.FormCreate(Sender: TObject);
var
  y1, m1, d1: Word;
begin
  Lista := TList.Create;


  DecodeDate(Now, y1, m1, d1);
  DecodeDate(EncodeDate(y1, m1, 1) - 1, y1, m1, d1);
  qrfrom.Text := VisibleDateToStr(EncodeDate(y1, m1, 1));
  qrto.Text := VisibleDateToStr(EncodeDate(y1, m1, d1));


  DecodeDate(VisibleStrToDate(qrfrom.Text), y1, m1, d1);
  DecodeDate(EncodeDate(y1, m1, 1) - 1, y1, m1, d1);
  qrfrom2.Text := VisibleDateToStr(EncodeDate(y1, m1, 1));
  qrto2.Text := VisibleDateToStr(EncodeDate(y1, m1, d1));

  DecodeDate(Now - 365, y1, m1, d1);
  DecodeDate(EncodeDate(y1, m1, 1) - 1, y1, m1, d1);
  qrfrom3.Text := VisibleDateToStr(EncodeDate(y1, m1, 1));
  qrto3.Text := VisibleDateToStr(EncodeDate(y1, m1, d1));

  DecodeDate(Now, y1, m1, d1);
  DecodeDate(EncodeDate(y1, m1, 1) - 1, y1, m1, d1);
  qrfrom4.Text := VisibleDateToStr(EncodeDate(y1, 1, 1));
  qrto4.Text := VisibleDateToStr(EncodeDate(y1, m1, d1));

  DefaultWhereStr := SQL_1;
  FCarStationMatrix := TCarStationMatrix.Create(self);
end;

procedure TFrmStat.FormDestroy(Sender: TObject);
begin
  Lista.Free;
  FCarStationMatrix.Free;
end;

procedure TFrmStat.BitBtn5Click(Sender: TObject);
var
  i: Integer;
begin
  PAObjST.Visible := False;
  while Lista.Count > 0 do
  begin
    if TObject(Lista[lista.Count - 1]) <> nil then
      TObject(Lista[lista.Count - 1]).Free;
    Lista.Delete(lista.Count - 1);
  end;
  PAObjST.Visible := False;
end;



procedure TFrmStat.BitBtn4Click(Sender: TObject);
var
  pan1: TPanel;
  DateFrom, DateTo: string;
  i: Integer;
begin
  PAObjST.Visible := False;
  while Lista.Count > 0 do
  begin
    if TObject(Lista[lista.Count - 1]) <> nil then
      TObject(Lista[lista.Count - 1]).Free;
    Lista.Delete(lista.Count - 1);
  end;


  RowSpace := 18;

  DateFrom := qrfrom.Text;
  DateTo := qrto.Text;

  ScrollBox1.Tag := 10;
  Lista.Add(nil);


//  DateFrom := '2001-01-01';
//  DateTo := '2001-12-31';


  FillData(ScrollBox1, qrfrom.Text, qrto.Text, True, edSql.Text);
  FillData(ScrollBox1, qrfrom2.Text, qrto2.Text, False, edSql.Text);
  FillData(ScrollBox1, qrfrom3.Text, qrto3.Text, False, edSql.Text);
  FillData(ScrollBox1, qrfrom4.Text, qrto4.Text, False, edSql.Text);


  PAObjST.Visible := True;

end;

procedure TFrmStat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmStat.free;
  FrmStat := nil;
  frmMain.Panel1.visible := True;

end;


function mm2pixelX(mm: integer): Integer;
begin
//  Result := pp.UnitToX(mm);
  Result := round(mm * ResolutionX / 25.4);
end;

function mm2pixelY(mm: integer): Integer;
begin
//  Result := pp.UnitToY(mm);
  Result := round(mm * ResolutionY / 25.4);
end;


procedure PrRefresh;
begin
  ResolutionY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  ResolutionX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
//     tmp := GetDeviceCaps(fprn.Handle,HORZRES);
end;

procedure RoundArea(x1, y1, x2, y2, Lines, Tjocklek: Integer);
var
  s2: TBrushStyle;
  s1: TColor;
  s3: Integer;
begin

  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  x2 := mm2pixelX(x2);
  y2 := mm2pixelY(y2);
  with printer.Canvas do
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

procedure StraighLine(x1, y1, x2, y2, Lines: Integer);
var
  s1: Integer;
begin
  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  x2 := mm2pixelX(x2);
  y2 := mm2pixelY(y2);
  s1 := printer.Canvas.pen.Width;
  printer.Canvas.pen.Width := Lines;
  printer.Canvas.MoveTo(x1, y1);
  printer.Canvas.LineTo(x2, y2);
  printer.Canvas.pen.Width := s1;
end;

procedure TextOut(x1, y1, Size: integer; str: string;
  Align: Integer);
var
  i: Integer;
  s1: string;
begin
  x1 := mm2pixelX(x1);
  y1 := mm2pixelY(y1);
  Align := mm2pixelX(Align);
  printer.Canvas.Font.Size := Size;
  if Align <> 0 then
  begin
    if Align > 0 then
      printer.Canvas.TextOut(x1 + Align - printer.Canvas.Textwidth(str),
        y1, StringReplace(str, '¤', ',', [rfReplaceAll]))
    else
      printer.Canvas.TextOut(x1 - Round(printer.Canvas.Textwidth(str) /
        2), y1, StringReplace(str, '¤', ',', [rfReplaceAll]));
  end
  else
  begin
    printer.Canvas.TextOut(x1, y1, StringReplace(str, '¤', ',', [rfReplaceAll]));
  end;
end;


procedure PageToPrinter(o0, o1, o2, o3, o4: TGroupBox);
var
  i: Integer;
  l1, t1, r1, b1: Integer;
begin

  if o0 <> nil then
  begin
    TextOut(10, 10, 12, o0.Caption, 0);
  end;

  l1 := 10;
  t1 := 30;
  r1 := 85;
  b1 := 150;


  with o1 do
  begin
    RoundArea(l1, t1, r1, b1, 0, 4);
    TextOut(l1 + 2, t1 - 10, 10, Caption, 0);

    for i := 0 to ComponentCount - 1 do
    begin
      if tLabel(o1.Components[i]).Left = 20 then
        TextOut(2 + l1, round(tLabel(o1.Components[i]).Top / 4) + t1, 10, tLabel(o1.Components[i]).Caption, 0)
      else
        TextOut(round(tLabel(o1.Components[i]).Left / 3) + l1, round(tLabel(o1.Components[i]).Top / 4) + t1, 9, tLabel(o1.Components[i]).Caption, 0);
    end;
  end;

  l1 := 87; //10; + 67
  r1 := l1 + 50;


  with o2 do
  begin
    RoundArea(l1, t1, r1, b1, 0, 4);
    TextOut(l1 + 2, t1 - 10, 10, Caption, 0);

    for i := 0 to ComponentCount - 1 do
    begin
      TextOut(round(tLabel(o2.Components[i]).Left / 3) + l1, round(tLabel(o2.Components[i]).Top / 4) + t1, 9, tLabel(o2.Components[i]).Caption, 0);
    end;
  end;

  l1 := 139; //10; + 67
  r1 := l1 + 50;


  with o3 do
  begin
    RoundArea(l1, t1, r1, b1, 0, 4);
    TextOut(l1 + 2, t1 - 10, 10, Caption, 0);

    for i := 0 to ComponentCount - 1 do
    begin
      TextOut(round(tLabel(o3.Components[i]).Left / 3) + l1, round(tLabel(o3.Components[i]).Top / 4) + t1, 9, tLabel(o3.Components[i]).Caption, 0);
    end;
  end;

  l1 := 191; //10; + 67
  r1 := l1 + 50;


  with o4 do
  begin
    RoundArea(l1, t1, r1, b1, 0, 4);
    TextOut(l1 + 2, t1 - 10, 10, Caption, 0);

    for i := 0 to ComponentCount - 1 do
    begin
      TextOut(round(tLabel(o4.Components[i]).Left / 3) + l1, round(tLabel(o4.Components[i]).Top / 4) + t1, 9, tLabel(o4.Components[i]).Caption, 0);
    end;
  end;


end;


procedure TFrmStat.BitBtn6Click(Sender: TObject);
var
  i: integer;
begin
  Printer.Orientation := poLandscape;
  Printer.Title := 'Statistik';
  PrRefresh;
  Printer.BeginDoc;

{
  for i := 0 to ScrollBox1.ComponentCount - 1 do
  begin
    if i > 0 then
      Printer.NewPage;

    tpanel(ScrollBox1.Components[i]).PaintTo(printer.handle, 10, 10);
  end;
}

  i := 0;

  while i + 4 < lista.Count do
  begin
    if i > 0 then
      Printer.NewPage;
    if (lista[i] <> nil) then
    begin
      if (tObject(lista[i]).ClassName = 'TGroupBox') then
        PageToPrinter(TGroupBox(Lista[i]), TGroupBox(Lista[i + 1]), TGroupBox(lista[i + 2]), TGroupBox(lista[i + 3]), TGroupBox(lista[i + 4]))
      else
        PageToPrinter(nil, TGroupBox(Lista[i + 1]), TGroupBox(lista[i + 2]), TGroupBox(lista[i + 3]), TGroupBox(lista[i + 4]));
    end
    else
      PageToPrinter(nil, TGroupBox(Lista[i + 1]), TGroupBox(lista[i + 2]), TGroupBox(lista[i + 3]), TGroupBox(lista[i + 4]));
    i := i + 5;
  end;

  printer.EndDoc;
//   FrmStat.Print;
end;

procedure TFrmStat.BitBtn3Click(Sender: TObject);
var
  LastStr: string;
  ds: TAdoQuery;
  pan: TGroupBox;
begin
  PAObjST.Visible := False;
  while Lista.Count > 0 do
  begin
    if TObject(Lista[lista.Count - 1]) <> nil then
      TObject(Lista[lista.Count - 1]).Free;
    Lista.Delete(lista.Count - 1);
  end;


  RowSpace := 18;

  ds := CreateDS('select type from objtype where id>''!'' order by id');
  ds.Open;
  ScrollBox1.Tag := 0;

  while not ds.Eof do
  begin

    Pan := TGroupBox.Create(ScrollBox1);
    pan.Caption := 'Grupp : ' + ds.Fields[0].AsString;
    pan.Parent := Scrollbox1;
    pan.Top := ScrollBox1.Tag;
    pan.Width := ScrollBox1.Width - 5;
    pan.Align := alTop;
    pan.Height := 300;
    pan.Tag := 10;
    Lista.Add(pan);
    ScrollBox1.Tag := ScrollBox1.Tag + pan.Height;



    FillData(pan, qrfrom.Text, qrto.text, True, 'and otype=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom2.Text, qrto2.text, False, 'and otype=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom3.Text, qrto3.text, False, 'and otype=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(Pan, qrfrom4.Text, qrto4.text, False, 'and otype=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    ds.Next;
  end;
  FreeDS(ds);
  PAObjST.Visible := True;
end;

procedure TFrmStat.qrfromKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  y, m, d: word;
begin

  if (Sender is TEQDateEdit) then
  begin
    if key = vk_up then
      TEQDateEdit(Sender).Text := VisibleDateToStr(VisibleStrToDate(TEQDateEdit(Sender).Text) - 1);
    if key = vk_down then
      TEQDateEdit(Sender).Text := VisibleDateToStr(VisibleStrToDate(TEQDateEdit(Sender).Text) + 1);
    if key = vk_Prior then
    begin
      DecodeDate(StrToDate(TEQDateEdit(Sender).Text) + 1, y, m, d);
      if d = 1 then
      begin
        DecodeDate(StrToDate(TEQDateEdit(Sender).Text), y, m, d);
        TEQDateEdit(Sender).Text := VisibleDateToStr(EncodeDate(y, m, 1) - 1);
      end
      else
      begin
        DecodeDate(StrToDate(TEQDateEdit(Sender).Text), y, m, d);
        if d = 1 then
        begin
          DecodeDate(StrToDate(TEQDateEdit(Sender).Text) - 1, y, m, d);
          TEQDateEdit(Sender).Text := VisibleDateToStr(EncodeDate(y, m, 1));
        end
        else
        begin
          TEQDateEdit(Sender).Text := VisibleDateToStr(EncodeDate(y, m, 1));
        end;
      end;
    end;
    if key = vk_Next then
    begin
      DecodeDate(StrToDate(TEQDateEdit(Sender).Text) + 1, y, m, d);
      if d = 1 then
      begin
        DecodeDate(StrToDate(TEQDateEdit(Sender).Text) + 35, y, m, d);
        TEQDateEdit(Sender).Text := VisibleDateToStr(EncodeDate(y, m, 1) - 1);
      end
      else
      begin
        DecodeDate(StrToDate(TEQDateEdit(Sender).Text), y, m, d);
        if d = 1 then
        begin
          DecodeDate(StrToDate(TEQDateEdit(Sender).Text) + 35, y, m, d);
          TEQDateEdit(Sender).Text := VisibleDateToStr(EncodeDate(y, m, 1));
        end
        else
        begin
          DecodeDate(StrToDate(TEQDateEdit(Sender).Text) + 35, y, m, d);
          TEQDateEdit(Sender).Text := VisibleDateToStr(EncodeDate(y, m, 1) - 1);
        end;
      end;
    end;
  end;
end;

procedure TFrmStat.BitBtn2Click(Sender: TObject);
var
  LastStr: string;
  ds: TAdoQuery;
  pan: TGroupBox;
begin
  PAObjST.Visible := False;
  while Lista.Count > 0 do
  begin
    if TObject(Lista[lista.Count - 1]) <> nil then
      TObject(Lista[lista.Count - 1]).Free;
    Lista.Delete(lista.Count - 1);
  end;


  RowSpace := 18;



  ds := CreateDS('select distinct oid from fakthead where (' +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom.Text, qrto.Text]) +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom2.Text, qrto2.Text]) +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom3.Text, qrto3.Text]) +
    Format(' ' + DefaultWhereStr + ') ' + edSql.Text + ' order by oid', [qrfrom4.Text, qrto4.Text]));

  ds.Open;
  ScrollBox1.Tag := 0;

  while not ds.Eof do
  begin

    Pan := TGroupBox.Create(ScrollBox1);
    pan.Caption := 'Objekt : ' + ds.Fields[0].AsString;
    pan.Parent := Scrollbox1;
    pan.Top := ScrollBox1.Tag;
    pan.Width := ScrollBox1.Width - 5;
    pan.Align := alTop;
    pan.Tag := 10;
    pan.Height := 300;
    Lista.Add(pan);
    ScrollBox1.Tag := ScrollBox1.Tag + pan.Height;



    FillData(pan, qrfrom.Text, qrto.text, True, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom2.Text, qrto2.text, False, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom3.Text, qrto3.text, False, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(Pan, qrfrom4.Text, qrto4.text, False, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    ds.Next;
  end;
  FreeDS(ds);
  PAObjST.Visible := True;
end;

procedure TFrmStat.BitBtn1Click(Sender: TObject);
var
  LastStr: string;
  ds: TAdoQuery;
  pan: TGroupBox;
begin
  PAObjST.Visible := False;
  while Lista.Count > 0 do
  begin
    if TObject(Lista[lista.Count - 1]) <> nil then
      TObject(Lista[lista.Count - 1]).Free;
    Lista.Delete(lista.Count - 1);
  end;


  RowSpace := 18;


  ds := CreateDS('select distinct kundvatnr,cast(fakturaadrstr as varchar(80)) from fakthead where (' +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom.Text, qrto.Text]) +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom2.Text, qrto2.Text]) +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom3.Text, qrto3.Text]) +
    Format(' ' + DefaultWhereStr + ') ' + edSql.Text + ' order by kundvatnr', [qrfrom4.Text, qrto4.Text]));

  ds.Open;
  ScrollBox1.Tag := 0;

  while not ds.Eof do
  begin

    Pan := TGroupBox.Create(ScrollBox1);
    pan.Caption := 'Org/Persnr : ' + ds.Fields[0].AsString + ' ' + copy(ds.Fields[1].AsString, 1, pos('#', ds.Fields[1].AsString) - 1);
    pan.Parent := Scrollbox1;
    pan.Top := ScrollBox1.Tag;
    pan.Width := ScrollBox1.Width - 5;
    pan.Align := alTop;
    pan.Tag := 10;
    pan.Height := 300;
    Lista.Add(pan);
    ScrollBox1.Tag := ScrollBox1.Tag + pan.Height;



    FillData(pan, qrfrom.Text, qrto.text, True, 'and kundvatnr=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom2.Text, qrto2.text, False, 'and kundvatnr=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom3.Text, qrto3.text, False, 'and kundvatnr=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(Pan, qrfrom4.Text, qrto4.text, False, 'and kundvatnr=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    ds.Next;
  end;
  FreeDS(ds);
  PAObjST.Visible := True;
end;

procedure TFrmStat.Label31Click(Sender: TObject);
begin
  edSql.Text := TLabel(Sender).Hint;
end;

{ TCarStationMatrix }

procedure TCarStationMatrix.AddStationId(CarId, DateId,
  StationId: integer);
begin
  if (DateId < 0) or (DateId > (FEndDate - FStartDate)) then
    raise Exception.Create('Not a valid DateId');
  if length(FStationIDMatrix[DateId]) <> FCarList.Count then
    SetLength(FStationIDMatrix[DateId], FCarList.Count);
  FStationIDMatrix[DateId, CarId] := StationId;
end;

procedure TCarStationMatrix.AddStationIdRangeSlow(RegNr: string;
  StationId: integer; DateFrom, DateTo: TDateTime);
var
  CarId, DateId, I : integer;
begin
  CarId := GetCarId(RegNr, True);
  For i := trunc(DateFrom) to trunc(DateTo) do
  begin
    DateId := GetDateId(i);
    AddStationId(CarId, DateId, StationID);
  end;
end;

procedure TCarStationMatrix.AddStationIdSlow(RegNr: string;
  Date: TDateTime; StationId: integer);
begin
  AddStationId(GetCarId(RegNr, true), GetDateId(Date), StationId);
end;

procedure TCarStationMatrix.Clear;
begin
  FCarList.Clear;
  SetLength(FStationIDMatrix, 0);
  FStartDate := 0;
  FEndDate := 0;
end;

constructor TCarStationMatrix.Create(AOwner: TComponent);
begin
  inherited;
  FCarList := TCarList.Create(self);

  FCarList.Clear;
  SetLength(FStationIDMatrix, 0);
  FStartDate := 0;
  FEndDate := 0;
end;

destructor TCarStationMatrix.Destroy;
begin

end;

function TCarStationMatrix.GetCarId(RegNr: string;
  AllowAdd: boolean): integer;
var
  i : integer;
begin
  RegNr := ansiuppercase(RegNr);
  result := FCarList.GetCarId(RegNr);
  if result >= 0 then
    exit;
  if AllowAdd then
  begin
    result := FCarList.AddCar(RegNr, -1);
  end else
    raise Exception.CreateFmt('Could not find %s in StationId Matrix',[RegNr]);
end;

function TCarStationMatrix.HasCarId(RegNr: string): integer;
var
  i : integer;
begin
  RegNr := ansiuppercase(RegNr);
  result := FCarList.GetCarId(RegNr);
end;

function TCarStationMatrix.GetDateId(Date: TDateTime): integer;
begin
  if date < FStartDate then
    raise Exception.CreateFmt('Date (%s) is too early for Matrix. Earliest possible date is %s', [VisibleDateToStr(date), VisibleDateToStr(FStartDate)]);
  if date > FEndDate then
    raise Exception.CreateFmt('Date (%s) is too late for Matrix. Latest possible date is %s', [VisibleDateToStr(date), VisibleDateToStr(FEndDate)]);
  result := trunc(Date) - trunc(fStartdate);
end;

procedure TCarStationMatrix.GetObjCount(StationId: integer; DateFrom,
  DateTo: TDateTime; var ObjCount, ObjDayCount: integer);
var
  i, j, DateId : integer;
  tmpObjCount : integer;
begin
  ObjCount := 0;
  ObjDayCount := 0;
  for i := trunc(DateFrom) to trunc(DateTo) do
  begin
    tmpObjCount := 0;
    DateId := GetDateId(i);
    for j := 0 to length(FStationIDMatrix[DateId]) do
    begin
      if (StationId < 0) or (FStationIDMatrix[DateId, j] = StationId) then
      begin
        inc(tmpObjCount);
        inc(ObjDayCount);
      end;
    end;
    if tmpObjCount > ObjCount then
      ObjCount := tmpObjCount;
  end;
end;

function TCarStationMatrix.GetStationId(CarId: integer;
  DateId : integer): integer;
begin
  result :=  FStationIDMatrix[DateId, CarId];
end;

function TCarStationMatrix.GetStationIdSlow(RegNr: string;
  Date: TDateTime): integer;
var
  lCarId : integer;
begin
  result := -1;
  try
    if date < FStartDate then
      date := FStartDate;
    if (date >= FStartDate) and (date <= FEndDate) then
    begin
      lCarId := HasCarId(RegNr);
      if lCarId >=0 then
        result := GetStationId(lCarId, GetDateId(Date));
    end;
  except

  end;
end;

procedure TCarStationMatrix.SetEndDate(const Value: TDateTime);
begin
  FEndDate := Value;
  if (FEndDate > 0) and (FStartDate > 0) then
    SetLength(FStationIDMatrix, trunc(FEndDate) - trunc(FStartDate) +1);

end;

procedure TCarStationMatrix.SetStartDate(const Value: TDateTime);
begin
  FStartDate := Value;
  if (FEndDate > 0) and (FStartDate > 0) then
    SetLength(FStationIDMatrix, trunc(FEndDate) - trunc(FStartDate) +1);
end;


{ TCarList }

function TCarList.AddCar(RegNr: string; StationId: integer) : integer;
var
  i : integer;
begin
  result := GetCarId(RegNr);
  if result < 0 then
  begin
    I := Length(FObjectList);
    SetLength(FObjectList, i+1);
    FObjectList[i].RegNr := RegNr;
    FObjectList[i].StationId := StationId;
    result := i;
  end;
end;

procedure TCarList.Clear;
begin
  SetLength(FObjectList, 0);
end;

function TCarList.GetCar(RegNr: string): TCar;
begin
  result := FObjectList[GetCarId(RegNr)];
end;

function TCarList.GetCarId(RegNr: string): integer;
var
  i : integer;
begin
  for i := 0 to length(FObjectList)-1 do
  begin
    if FObjectList[i].RegNr = RegNr then
    begin
      result := i;
      exit;
    end;
  end;
  result := -1;
//  raise Exception.Create('Car not found');
end;

function TCarList.Count: integer;
begin
  result := length(FObjectList);
end;

function TCarList.GetCarByNum(ObjNum: integer): TCar;
var
  i : integer;
begin
  for i := 0 to length(FObjectList)-1 do
  begin
    if FObjectList[i].ObjNum = ObjNum then
    begin
      result := FObjectList[i];
      exit;
    end;
  end;
  raise Exception.Create('Car not found');
end;

procedure TFrmStat.BitBtn8Click(Sender: TObject);
var
  pan1: TPanel;
  DateFrom, DateTo: string;
  i: Integer;
begin
{  PAObjST.Visible := False;
  while Lista.Count > 0 do
  begin
    if TObject(Lista[lista.Count - 1]) <> nil then
      TObject(Lista[lista.Count - 1]).Free;
    Lista.Delete(lista.Count - 1);
  end;


  RowSpace := 18;

  DateFrom := qrfrom.Text;
  DateTo := qrto.Text;

  ScrollBox1.Tag := 10;

  ds := CreateDS('select distinct oid from fakthead where (' +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom.Text, qrto.Text]) +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom2.Text, qrto2.Text]) +
    Format(' ' + DefaultWhereStr + ' or ', [qrfrom3.Text, qrto3.Text]) +
    Format(' ' + DefaultWhereStr + ') ' + edSql.Text + ' order by oid', [qrfrom4.Text, qrto4.Text]));

  ds.Open;
  ScrollBox1.Tag := 0;

  while not ds.Eof do
  begin

    Pan := TGroupBox.Create(ScrollBox1);
    pan.Caption := 'Objekt : ' + ds.Fields[0].AsString;
    pan.Parent := Scrollbox1;
    pan.Top := ScrollBox1.Tag;
    pan.Width := ScrollBox1.Width - 5;
    pan.Align := alTop;
    pan.Tag := 10;
    pan.Height := 300;
    Lista.Add(pan);
    ScrollBox1.Tag := ScrollBox1.Tag + pan.Height;



    FillData(pan, qrfrom.Text, qrto.text, True, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom2.Text, qrto2.text, False, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(pan, qrfrom3.Text, qrto3.text, False, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    FillData(Pan, qrfrom4.Text, qrto4.text, False, 'and oid=''' + ds.Fields[0].AsString + '''' + edSql.Text);
    ds.Next;
  end;
  FreeDS(ds);
  PAObjST.Visible := True;
 }
end;

end.

