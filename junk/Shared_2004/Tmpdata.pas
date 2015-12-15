{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Tmpdata.pas
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
{ $Log:  13625: Tmpdata.pas
{
{   Rev 1.1    2004-01-29 10:24:28  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:26:18  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.2    2003-11-11 11:52:22  peter
{ Ny funktion som kontrollerar om ett kundnr finns som delbetalare.
}
{
{   Rev 1.1    2003-08-04 11:58:04  Supervisor
}
{
{   Rev 1.0    2003-03-20 14:04:04  peter
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
{   Rev 1.0    2003-03-17 09:25:30  Supervisor
{ Start av vc
}
unit tmpData;

interface

uses windows, classes, Sysutils, dbtables;

type
  TTele = record
    ID: string;
    Name: string;
  end;

  TCost = record
    FName: string;
    FNumb: integer;
    FPrice: Real;
    FKonto: string;
    FKStalle: string;
    FMoms: real;
  end;

  TPetrol = record
    Id: string;
    Name: string;
    Cost: Currency;
  end;

  TObjGroup = record
    ObId: string;
    ObTyp: string;
    DefDep: Currency;
    ShowPClass: Boolean;
    ShowPType: Boolean;
    ShowDragbil: Boolean;
    ShowKM: Boolean;
  end;

  TPriceList = record
    PClass: string;
    PType: string;
    PNamn: string;
    FTime: TDateTime;
    TTime: TDateTime
  end;

  TPayAlt = record
    Code: string;
    Name: string;
  end;

  TSign = record
    Sign: string;
    Name: string;
    Pswrd: string;
  end;

  TCCard = record
    Id: string;
    Name: string;
  end;

  TParameterType = (ContrId, RegNr, CustId, CustName, PString);
  TActionType = (NewBook, NewCont, LoadBook, LoadCont, LoadRet, LoginSign, LoginPwd);

  TQPParameter = record
    PAction: TActionType;
    PType: TParameterType;
    PEntry: string;
    PDefault: string;
  end;

  TQPScript = record
    Name: string;
    parameters: array of TQPParameter;
  end;

  TDelbetalare = record
    FDelId: Integer;
    FSub: Integer;
    FKID: Integer;
    FNamn: string;
    FKontaktID: string;
    FHyrDel: Integer;
    FKmDel: Integer;
    FMomsDel: Integer;
    FProcent: Boolean;
    FBetsatt: string;
    FBetVilkor: Integer;
    FForsakring: Boolean;
    FForsKod: string;
    FForsKlass: string;
    FSkadeDat: TDateTime;
    FSkadeNr: string;
    FFoRegNr: string;
    FMpRegNr: string;
    FKontoTyp: string;
    FKontoNr: string;
    FSparr: Boolean;
    FSparrNr: string;
    FHKOSTN: real;
    FKMKOSTN: real;
    FOVERKM: real;
    FXDYGN: real;
    FSRRED: real;
    FDMedel: real;
    FOVR1: real;
    FOVR2: real;
    FSUM: real;
    FHYR: real;
    FMOMS: real;
    FDEP: real;
    FTOTAL: real;
  end;

  TKontrObjekt = class
  public
    KntObId: integer;
    OId: string;
    Utlm_Dat: TDateTime;
    Utlm_Tid: TDateTime;
    Ater_Dat: TDateTime;
    Ater_Tid: TDateTime;
    KM_UT: integer;
    KM_IN: integer;
    PKlass: integer;
    PTyp: string;
    bSRRed: boolean;
    HKostn: integer;
    KMKostn: integer;
    OverKM: integer;
    XDygn: integer;
    Sum: integer;
    SRred: integer;
    Ovrtext1: string;
    Ovrtext2: string;
    Hkostntext: string;
    KMkostntext: string;
    OverKmText: string;
    XDygntext: string;
    Momstext: string;
    DMedel: integer;
    Ovr1: integer;
    Ovr2: integer;
    Rab1: word;
    Rab2: word;
    Hyrk: integer;
    Varav_Moms: integer;
    Depres: integer;
    Total: integer;
    rDays: word;
    rTime: real;
    Km: word;
    procedure BeraknaKtrObj(PrisrT: TTable; Sjalvrisk: boolean);
    procedure SaveToDelKtr(DelKtr: TTable);
    procedure LoadFromDelKtr(DelKtr: TTable);
  end;

  TFakturanotering = record
    FaktSubId: Integer;
    DelId: Integer;
    KID: string;
    KNamn: string;
    FNamn: string;
    BetDel: string;
    Attention: string;
    Kom1: string;
    Kom2: string;
  end;

var
  Telephones: array of TTele;
  Petrols: array of TPetrol;
  Costs: array of TCost;
  OBjTypes: array of TObjGroup;
  PriceLists: array of TPriceList;
  PayAlts: array of TPayAlt;
  Signs: array of TSign;
  CCards: array of TCCard;
  QPScripts: array of TQPScript;
  DelLista: array of TDelbetalare;
  Preview: Boolean;
  RptDirectory: string;
//  Printer: string;
  InternKund: Boolean;
  BTMOMS: Real;
  BTSum: Real;

  DefBetSt: string;
  NumOffeCopies: integer; //Offert
  NumBookCopies: integer; //Bokningsbekräftelse
  NumContCopies: integer; //Kontrakt
  NumCashCopies: integer; //Kontantnota
  NumInteCopies: integer; //Internfaktura
  NumInvoCopies: integer; //Faktura
  NumIDepCopies: integer; //Fakturaunderlag

{
const
  DefBetSt: string = 'O';
  // NumCopies: -1 = preview, 0 = none, 1 = 1 Copy no dialog, >1 = X Copies and dialog
  NumOffeCopies: integer = -1; //Offert
  NumBookCopies: integer = -1; //Bokningsbekräftelse
  NumContCopies: integer = -1; //Kontrakt
  NumCashCopies: integer = -1; //Kontantnota
  NumInteCopies: integer = -1; //Internfaktura
  NumInvoCopies: integer = -1; //Faktura
  NumIDepCopies: integer = -1; //Fakturaunderlag
}
function GetCCIndex(CCType, CCName: string): integer;
function GetPriceName(PClass, PType: string): string;
function GetPriceType(PClass, PName: string): string;
function AddDelBetalare: integer;
procedure DeleteDelbetalare(idx: Integer);
function DoesDelBetalareExist(CustNr: integer): Boolean;
procedure GetPriceTypes(PClass: string; list: TStrings; PDate: TDateTime; OnlyValid: Boolean = true);
function GetBetIndex(ID: string): Integer;
function GetObjTypIndex(Id: string; list: TStrings): integer;
function GetObjTypID(idx: integer; list: TStrings): string;

implementation

uses Main;

function GetCCIndex(CCType, CCName: string): integer;
var
  I: Integer;
begin
  result := -1;
  for I := 0 to length(CCards) - 1 do
    if CCType > '' then
    begin
      if CCards[I].Id = CCType then
      begin
        result := I;
        exit;
      end;
    end
    else
    begin
      if CCards[I].Name = CCName then
      begin
        result := I;
        exit;
      end;
    end;
end;

procedure GetPriceTypes(PClass: string; list: TStrings; PDate: TDateTime; OnlyValid: Boolean = true);
var I: Integer;
begin
  list.clear;
  for I := 0 to length(PriceLists) - 1 do
    if PriceLists[i].PClass = PClass then
    begin
      if OnlyValid then
      begin
        if (Trunc(PriceLists[I].FTime) <= PDate) and (Trunc(PriceLists[I].TTime) >= PDate) then
          list.add(PriceLists[i].PNamn);
      end
      else
        list.add(PriceLists[i].PNamn);
    end;
end;

function GetPriceName(PClass, PType: string): string;
begin
  frmMain.dmodq1.Active := False;
  frmMain.dmodq1.Sql.Text := ' Select PNamn from PriceTab where PKlass=' + dbdel + PClass + dbdel + ' and PTyp=' + dbdel + PType + dbdel + '';
  frmMain.dmodq1.Active := True;
  result := frmMain.dmodq1.fieldbyname('PNamn').asstring;
  frmMain.dmodq1.Active := False;
end;

function GetPriceType(PClass, PName: string): string;
begin
  frmMain.dmodq1.Active := False;
  frmMain.dmodq1.Sql.Text := ' Select PTyp from PriceTab where PKlass=' + dbdel + PClass + dbdel + ' and PNAMN=' + dbdel + PName + dbdel + '';
  frmMain.dmodq1.Active := True;
  result := frmMain.dmodq1.fieldbyname('PTyp').asstring;
  frmMain.dmodq1.Active := False;
end;

function GetObjTypIndex(Id: string; list: TStrings): integer;
var
  I: Integer;
  str: string;
begin
  result := -1;
  for I := 0 to length(Objtypes) - 1 do
    if Id = ObjTypes[i].ObId then
      str := ObjTypes[i].ObTyp;
  for I := 0 to list.count - 1 do
    if list[i] = str then
    begin
      result := I;
      exit;
    end;
end;

function GetObjTypID(idx: integer; list: TStrings): string;
var I: Integer;
  str: string;
begin
  result := '';
  str := list[idx];
  for I := 0 to length(Objtypes) - 1 do
    if str = ObjTypes[i].ObTyp then
    begin
      result := ObjTypes[I].ObId;
      exit;
    end;
end;

function GetBetIndex(ID: string): Integer;
var I: Integer;
begin
  result := -1;
  for I := 0 to length(PayAlts) - 1 do
    if PayAlts[I].Code = Id then
    begin
      result := I;
      exit;
    end;
end;

function GetBetCode(Name: string): string;
var I: Integer;
begin
  for I := 0 to length(PayAlts) do
    if PayAlts[I].Name = Name then
    begin
      result := PayAlts[I].Code;
      exit;
    end;
end;

procedure TKontrObjekt.LoadFromDelKtr(DelKtr: TTable);
begin
  KntObId := Delktr.FieldByName('').value;
  OId := Delktr.FieldByName('OId').value;
  Utlm_Dat := Delktr.FieldByName('Utlm_Dat').value;
  Utlm_Tid := Delktr.FieldByName('Utlm_Tid').value;
  Ater_Dat := Delktr.FieldByName('Ater_Dat').value;
  Ater_Tid := Delktr.FieldByName('Ater_Tid').value;
  KM_UT := Delktr.FieldByName('KM_UT').value;
  KM_IN := Delktr.FieldByName('KM_IN').value;
  PKlass := Delktr.FieldByName('PKlass').value;
  PTyp := Delktr.FieldByName('PTyp').value;
end;

procedure TKontrObjekt.SaveToDelKtr(DelKtr: TTable);
begin
  DelKtr.findKey([KntObId]);
  DelKtr.Edit;
  Delktr.FieldByName('HKostn').value := HKostn;
  Delktr.FieldByName('KMKostn').value := KMKostn;
  Delktr.FieldByName('OverKM').value := OverKM;
  Delktr.FieldByName('XDygn').value := XDygn;
  Delktr.FieldByName('Sum').value := Sum;
  Delktr.FieldByName('SRred').value := SRred;
  Delktr.FieldByName('Ovrtext1').value := Ovrtext1;
  Delktr.FieldByName('Ovrtext2').value := Ovrtext2;
  Delktr.FieldByName('Hkostntext').value := Hkostntext;
  Delktr.FieldByName('KMkostntext').value := KMkostntext;
  Delktr.FieldByName('OverKmText').value := OverKmText;
  Delktr.FieldByName('XDygntext').value := XDygntext;
  Delktr.FieldByName('Momstext').value := Momstext;
  Delktr.FieldByName('DMedel').value := DMedel;
  Delktr.FieldByName('Ovr1').value := Ovr1;
  Delktr.FieldByName('Ovr2').value := Ovr2;
  Delktr.FieldByName('Rab1').value := Rab1;
  Delktr.FieldByName('Rab2').value := Rab2;
  Delktr.FieldByName('Hyrk').value := Hyrk;
  Delktr.FieldByName('Varav_Moms').value := Varav_Moms;
  Delktr.FieldByName('Depres').value := Depres;
  Delktr.FieldByName('Total').value := Total;
  DelKtr.Post;
end;

procedure TKontrObjekt.BeraknaKtrObj(PrisrT: TTable; Sjalvrisk: boolean);
{var
  Hours, Min, Sec, MSec : Word;
  mintid, minkm, minover, minxdygn, minsrred : word;
  mintidtext, minkmtext, minovertext, minxdygntext : string;
  }
begin
{  rDays := Trunc(ATER_DAT - UTLM_DAT);
  rTime := ATER_TID - UTLM_TID;
  Km := KM_In - KM_Ut;

  DecodeTime(rTime, Hours, min , sec, msec);
  if min > 10 then  // Skall parameteriseras :)
   inc(Hours);
  Hours := Hours + rDays * 24;

  PrisrT.Filter := PrisTid + ' AND PKLASS = ''' + inttostr(PKLASS) + ''' AND PTYP = ''' + PTYP + '''';
  PrisrT.Filtered := true;
  PrisrT.refresh;
  if hours > 0 then
    frmPris.Kostnad(rDays, Hours, KM, mintid, minkm, minover, minxdygn, minsrred,
      mintidtext, minkmtext, minovertext, minxdygntext);
  PrisrT.Filtered := false;

  HKostn := mintid;
  KMKostn := minkm;
  OverKM := minover;
  XDygn := minxdygn;
  if Sjalvrisk = true then
    SRred := minsrred
  else
    SRred := 0;

  Hkostntext := mintidtext;
  KMkostntext := minkmtext;
  OverKmText := minovertext;
  XDygntext := minxdygntext;}
end;

procedure AddFaktNot(var FaktNotList: TList; KontrT, DelKtrT, KundrT: TTable);
begin
{
var
  OldFilter : string;
  I : Integer;
  OldFiltered : Boolean;
  Subid : Integer;

  procedure AddNote(DelKtr : Boolean);
  begin
    if not Assigned(FaktNotList) then
      FaktNotList := TList.create;
    FNot := TFakturaNotering.create;
    FNot.KontrId := KontrT.FieldByName('KONTRID').value;
    if DelKtr then
    begin
      FNot.DelId := DelKtrT.FieldByName('DelId').value;
      FNot.KID := DelKtrT.FieldByName('DelKID').value;
      FNot.KNamn := GetKNamn(KundrT,DelKtrT.FieldByName('DelKID').value);
    end
    else begin
      FNot.DelId := 0;
      FNot.KID := KontrT.FieldByName('KID').value;
      FNot.KNamn := GetKNamn(KundrT,KontrT.FieldByName('KID').value);
    end;
    FNot.FNamn := GetKNamn(KundrT,KontrT.FieldByName('FID').value);
    FNot.BetDel := '';
    FNot.Attention := '';
    FNot.Kom1 := '';
    FNot.Kom2 := '';

    FaktNotList.Add(FNot);
  end;
begin
  if assigned(FaktNotList) then
  begin
    for I := 0 to FaktNotList.count-1 do
      TObject(FaktNotList[i]).free;
    FaktNotList.free;
    FaktNotList := nil;
  end;
  if (KontrT.FieldByName('BetSatt').AsString = 'F') or (KontrT.FieldByName('BetSatt').AsString = 'U') then
    AddNote(false);
  with DelKtrT do
  begin
    SubID := Fieldbyname('SUBID').AsInteger;
    OldFilter := Filter;
    OldFiltered := Filtered;
    Filter := 'KontrID = ' + KontrT.FieldByName('KONTRID').AsString;
    Filtered := true;
    First;
    while not EOF do
    begin
      if (DelKtrT.FieldByName('BETSAT').AsString = 'F') or (DelKtrT.FieldByName('BETSAT').AsString = 'U') then
        AddNote(true);
      Next;
    end;
    Filtered := OldFiltered;
    Filter := OldFilter;
    Locate('SUBID',SubId,[]);
  end;
  }
end;

function AddDelBetalare: integer;
begin
  result := length(DelLista);
  SetLength(DelLista, result + 1);
end;

procedure DeleteDelbetalare(idx: Integer);
var
  I: Integer;
begin
  for I := idx to length(dellista) - 2 do
    DelLista[i] := DelLista[i + 1];
  SetLength(DelLista, length(DelLista) - 1);
end;

function DoesDelBetalareExist(CustNr: integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to length(dellista) - 1 do
    if DelLista[i].FKID = CustNr then
    begin
      Result := True;
      Break;
    end;
end;

end.

