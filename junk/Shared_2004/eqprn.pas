{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     eqprn.pas
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
{ $Log:  13615: eqprn.pas
{
{   Rev 1.1    2004-01-29 10:24:28  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:26:16  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.2    2003-10-14 11:35:24  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.1    2003-08-04 11:58:04  Supervisor
}
{
{   Rev 1.0    2003-03-20 14:04:04  peter
}
{
{   Rev 1.0    2003-03-17 14:41:48  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:36:02  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
unit eqprn;

interface

uses
  SysUtils, WinTypes, WinProcs, Registry, Dialogs, Controls, ADOdb, EQPrinterdata,
  Printers, Classes, DB, Forms;

function CreateComps: Boolean;
procedure DestroyComps;
procedure PrintOutReport(RapportNamn, Params: string; PageCount: integer; Preview: Boolean = true);
procedure PrintAvtal(ContrID, Enr, Copies: integer; Preview: boolean);
procedure PrintKvitto(ContrID, MainSub, ENummer, NumCopies: integer; preview: boolean);
procedure PrintRapport(TheFile: string; copies: integer; preview: boolean);
procedure PrintRegDatAvt(Reg, Dat: string; Copies: Integer; Preview: Boolean);
procedure PrintRegDatKvi(Reg, Dat: string; Copies: Integer; Preview: Boolean);
procedure PrintReportParams(TheFile: string; NumCopies: Integer; Preview: boolean; parms: TStringList);
function MyPos(substr, str: string): integer;
function GetMyStream(ident: string): TStream;

var
  ADOConn: TADOConnection;
  ADOQ1: TADOQuery;
  ADOQ2: TADOQuery;
  Q: TADOQuery;
implementation

uses main, tmpData;

function CreateComps: Boolean;
begin
  try
    ADOConn := TADOConnection.Create(nil);
    with ADOConn do begin
      ConnectionString := Main.dbway;
      LoginPrompt := False
    end;
    ADOQ1 := TADOQuery.Create(nil);
    ADOQ1.Connection := ADOConn;
    ADOQ2 := TADOQuery.Create(nil);
    ADOQ2.Connection := ADOConn;
    result := true;
  except
    ShowMessage('Kunde inte skapa nödvändiga komponenter');
    result := false;
  end;

end;

procedure DestroyComps;
begin
  ADOQ1.free;
  ADOQ2.free;
  ADOConn.free;

  ADOQ1 := nil;
  ADOQ1 := nil;
  ADOConn := nil;
end;

function MyPos(substr, str: string): integer;
var
  i: integer;
begin
  result := 0;
  for i := 1 to Length(str) do
  begin
    if (substr = Copy(str, i, length(substr))) then
    begin
      result := i;
      exit;
    end;
  end;
end;

procedure PrintOutReport(RapportNamn, Params: string; PageCount: integer; Preview: Boolean = true);
var
  d: TEQPrinterData;
  i, j: integer;
  S: string;
  DoKillComps: Boolean;
begin
  if PageCount < 1 then Exit;
  DoKillComps := False;
  if not assigned(ADOConn) then
  begin
    if not CreateComps then
      Exit;
    DoKillComps := True;
  end;

  try
    printers.Printer.Title := 'Test av utskrift';
    printers.Printer.Orientation := poPortrait;
    printers.Printer.Canvas.Font.Name := 'Arial';
    d := TEQPrinterData.Create(printers.Printer, ADOQ1, ADOQ2);
    try
      d.Font.Name := 'Arial';
      S := RapportNamn;
      s := Copy(RapportNamn, LastDelimiter('\', RapportNamn) + 1, Length(RapportNamn) - LastDelimiter('/', RapportNamn) + 1);
      d.ReportPath := tmpData.rptDirectory;
      d.StreamFunc := GetMyStream;
      d.LoadFile(S);

//      if not FileExists(S) then
//        raise Exception.CreateFmt('Kan inte hitta rapporten %s',[s]);
//      d.LoadFile(S);

      if (Length(Params) > 0) and (AnsiLastChar(Params) <> ';') then
        Params := Params + ';';

      // Params := '125;"SWE";true;'
      for j := 1 to 9 do
      begin
        i := Pos(';', Params);
        if i > 0 then
        begin
          d.Parametrar[j] := Copy(Params, 1, i - 1);
          Params := Copy(Params, i + 1, MaxInt);
        end;
      end;
      d.Copies := PageCount;
      d.Preview := Preview;
      d.Print;
    finally
      d.Free;
    end;
  finally
  end;
  if DoKillComps then
    DestroyComps;
end;

procedure PrintAvtal(ContrID, Enr, Copies: integer; Preview: boolean);
var TheFile: string;
  params: string;
begin
  TheFile := tmpData.rptDirectory + 'Avtal.ini';
  params := IntToStr(ContrID) + ';';

  if preview then
    Copies := 1;

  if not CreateComps then
    Exit;

  with ADOQ1.SQL do begin
    Clear;
    Add('SELECT Status FROM Contr_Base WHERE contrid = ' + IntToStr(ContrID));
  end;

  ADOQ1.Open;

  if ADOQ1.RecordCount > 0 then begin
    case ADOQ1.FieldByName('Status').AsInteger of
      1: Params := Params + 'OFFERT;';
      2: Params := Params + 'BOKNING;';
      4: Params := Params + 'KONTRAKT;';
    else
      if ADOQ1.FieldByName('Status').AsInteger > 4 then
        Params := Params + 'KOPIA RETUR;'
      else
        Params := Params + 'Tjollahopp;';
    end;
  end else
    Params := Params + ' ;';

  ADOQ1.Close;

  try
    PrintOutReport(TheFile, params, Copies, Preview);
  except
    ShowMessage('Fel i utskrift.');
  end;

  DestroyComps;
end;

procedure PrintKvitto(ContrID, MainSub, ENummer, NumCopies: integer; preview: boolean);
var TheFile: string;
  Params: string;
  temp: string;
begin

{
  Kvitto filer:
  kvitto.ini - default.
  kvitto_x.ini  (x = 1-4, 1 Kontant, 2 Kredit kort, 3 Faktura, 4 Intern faktura)
  kvitto_yx.ini ( x = 1-4 se åvan, y = 2  deladbetalre)

  ex. kvitto_1.ini - kontant kvitto. kvitto_23.ini - faktura deladbetalare
}
  TheFile := tmpData.rptDirectory + 'kvitto';

  if not CreateComps then
    Exit;

  with ADOQ1.SQL do begin
    Clear;
    Add('SELECT contr_sub.contrid, contr_sub.enummer, contr_sub.subid, contr_sub.payment, contr_subcost.dtotal, contr_sub.sprule_rent, contr_sub.sprule_vat, contr_sub.sprule_km FROM ');
    Add('contr_sub contr_sub inner join contr_subcost contr_subcost on contr_sub.subid = contr_subcost.subid WHERE ');
    if ENummer <> 0 then
      Add('contr_sub.enummer = ' + IntToStr(ENummer))
    else begin
      if MainSub <> 0 then
        Add('contr_sub.subid = ' + IntToStr(MainSub));
      if (MainSub <> 0) and (ContrID <> 0) then
        Add(' AND ');
      if ContrID <> 0 then
        Add('contr_sub.contrid = ' + IntToStr(ContrId));
    end;
  end;

  ADOQ1.Open;

  if ADOQ1.RecordCount < 1 then begin
    ShowMessage('Kunde inte hitta något sådant kvitto.');
    exit;
  end;

  if AdoQ1.FieldByName('enummer').AsInteger <> 0 then
  begin
    if preview then
      NumCopies := 1;
    try
      PrintOutReport(tmpData.rptDirectory + 'kvitto_sf.ini', AdoQ1.FieldByName('enummer').AsString + ';', NumCopies, preview);
    except
    end;
    ADOQ1.Close;
  end
  else
  begin
    Params := ADOQ1.FieldByName('contrid').AsString + ';';
    if ADOQ1.FieldByName('dtotal').AsInteger < 0 then
      Params := Params + 'Kredit ';

    with ADOQ1 do
      if (FieldByName('sprule_rent').AsInteger <> 100) or
        (FieldByName('sprule_vat').AsInteger <> 100) or
        (FieldByName('sprule_km').AsInteger <> 100) then
        temp := '2;' + ADOQ1.FieldByName('payment').AsString + ';'
      else
        temp := '1;' + ADOQ1.FieldByName('payment').AsString + ';';

    case pos(ADOQ1.FieldByName('payment').AsString, 'FUIKO') of
      1: begin
          Params := Params + 'Underlag;';
        end;
      2: Params := Params + 'Fakturaunderlag;';
      3: begin
          Params := Params + 'Intern;';
        end;
      4: begin
          Params := Params + 'Kontantnota;';
        end;
      5: begin
          Params := Params + 'Kontokort;';
        end;
    else
      Params := Params + 'Tjollahopp;';
    end;
    Params := Params + ADOQ1.FieldByName('subid').AsString + ';' + temp;

    ADOQ1.Close;
    TheFile := TheFile + '.ini';

    if preview then
      NumCopies := 1;

    try
      PrintOutReport(TheFile, params, NumCopies, Preview);
    except
      ShowMessage('Fel i utskrift.');
    end;
  end;

  DestroyComps;
end;

procedure PrintRapport(TheFile: string; copies: integer; preview: boolean);
begin

  if not CreateComps then
    Exit;

  try
    PrintOutReport(TheFile, '', copies, preview);
  except
    ShowMessage('Fel i utskrift.');
  end;

  DestroyComps;
end;

procedure PrintRegDatAvt(Reg, Dat: string; Copies: Integer; Preview: Boolean);
var TheFile: string;
  params: string;
begin
  TheFile := tmpData.rptDirectory + 'Avtal.ini';

  if preview then
    Copies := 1;

  if not CreateComps then
    Exit;

  with ADOQ1.SQL do begin
    Clear;
    Add('SELECT Contr_Base.Status, Contr_Base.ContrId FROM Contr_Base INNER JOIN Contr_ObjT contr_objt ON contr_objt.ContrId = Contr_Base.ContrId WHERE (contr_objt.Frm_Time <= CONVERT(DATETIME, ''' + Dat + ' 23:59:59'', 102)) AND (contr_objt.To_Time >= CONVERT(DATETIME, ''' + Dat + ' 00:00:00'',  102)) AND (contr_objt.OId = N''' + Reg + ''')');
  end;

  ADOQ1.Open;

  if ADOQ1.RecordCount > 0 then begin
    Params := ADOQ1.FieldByName('ContrID').AsString + ';';
    case ADOQ1.FieldByName('Status').AsInteger of
      1: Params := Params + 'OFFERT;';
      2: Params := Params + 'BOKNING;';
      4: Params := Params + 'KONTRAKT;';
    else
      if ADOQ1.FieldByName('Status').AsInteger > 4 then
        Params := Params + 'KOPIA RETUR;'
      else
        Params := Params + 'Tjollahopp;';
    end;
  end else begin
    ADOQ1.Close;
    ShowMessage('Kunde inte hitta något avtal.');
    exit;
  end;

  ADOQ1.Close;

  try
    PrintOutReport(TheFile, params, Copies, Preview);
  except
    ShowMessage('Fel i utskrift.');
  end;

  DestroyComps;

end;

procedure PrintRegDatKvi(Reg, Dat: string; Copies: Integer; Preview: Boolean);
var TheFile: string;
  params: string;
begin
  TheFile := tmpData.rptDirectory + 'kvitto.ini';

  if not CreateComps then
    Exit;

  with ADOQ1.SQL do begin
    Clear;
    Add('SELECT contr_sub.subid, contr_base.contrid, contr_sub.payment, contr_subcost.dtotal,contr_sub.enummer FROM Contr_Base Contr_Base INNER JOIN Contr_sub Contr_sub ON contr_sub.contrid = contr_base.contrid');
    Add(' INNER JOIN contr_subcost contr_subcost ON contr_sub.subid = contr_subcost.subid INNER JOIN contr_objt contr_objt ON contr_objt.contrid = contr_base.contrid WHERE ');
    Add('(contr_objt.frm_time <= CONVERT(DATETIME, ''' + Dat + ' 23:59:59'', 102)) AND (contr_objt.to_time >= CONVERT(DATETIME, ''' + Dat + ' 00:00:00'',  102)) AND (contr_objt.oid = N''' + Reg + ''')');
  end;

  ADOQ1.Open;

  if ADOQ1.RecordCount > 0 then begin

    if AdoQ1.FieldByName('enummer').AsInteger <> 0 then
    begin
      if preview then
        Copies := 1;
      try
        PrintOutReport(tmpData.rptDirectory + 'kvitto_sf.ini', AdoQ1.FieldByName('enummer').AsString + ';', Copies, preview);
      except
      end;
      ADOQ1.Close;
    end
    else
    begin
      Params := ADOQ1.FieldByName('ContrID').AsString + ';';
      if ADOQ1.FieldByName('dtotal').AsInteger < 0 then
        Params := Params + 'Kredit ';

      case pos(ADOQ1.FieldByName('payment').AsString, 'FUIKO') of
        1: Params := Params + 'Faktura;';
        2: Params := Params + 'Fakturaunderlag;';
        3: Params := Params + 'Internfaktura;';
        4: Params := Params + 'Kontantnota;';
        5: Params := Params + 'Kontokort;';
      else
        Params := Params + 'Tjollahopp;';
      end;
      Params := Params + ADOQ1.FieldByName('subid').AsString + ';';
    end;
    ADOQ1.Close;


    if preview then
      Copies := 1;

    try
      PrintOutReport(TheFile, params, Copies, Preview);
    except
      ShowMessage('Fel i utskrift.');
    end;
  end
  else
  begin
    ADOQ1.Close;
    ShowMessage('Kunde inte hitta något kvitto.');
  end;
  DestroyComps;
end;

procedure PrintReportParams(TheFile: string; NumCopies: Integer; Preview: boolean; parms: TStringList);
var
  params: string;
  i, k: integer;
begin
  if (NumCopies < 1) and Preview then
    NumCopies := 1;

  params := '';

  k := parms.count - 1;
  if k < 0 then
    k := 0;

  for i := 0 to k do
  begin
    params := params + parms.Strings[i] + ';';
  end;

  try
    PrintOutReport(TheFile, params, NumCopies, Preview);
  except
    on E: exception do ShowMessage('Fel i utskrift: ' + E.Message);
  end;

  DestroyComps;
end;

// MBH

function GetMyStream(ident: string): TStream;
var
  Q: TADOQuery;
begin
  Q := TADOQuery.Create(nil);
  Q.Connection := ADOConn;

  with Q.SQL do begin
    Clear;
    Add('SELECT Ini AS Ini FROM Reports WHERE Program=''' + Application.Title + ''' AND CallName = ''' + ident + '''');
  end;

  Q.Open;
  if (Q.RecordCount < 1) then
    raise Exception.CreateFmt('Kan inte hitta rapporten %s', [ident]);

  result := Q.CreateBlobStream(Q.FieldByName('Ini'), bmRead);
  Q.Close;
  Q.Free;
end;

end.

