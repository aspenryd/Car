{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Adeko.pas
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
{ $Log:  13117: Adeko.pas
{
{   Rev 1.4    2003-12-09 09:40:36  peter
{ Fixat problem vid 0 i varuvärde och negativ moms.
}
{
{   Rev 1.3    2003-06-26 11:45:06  Supervisor
}
{
{   Rev 1.2    2003-05-21 14:53:04  Supervisor
{ 1. Överföring av kunder endast 10 och 11 tkn orgnr.
{ 2. Öreskontroll när värdet blir negativt kollar <-0.5 istället för <0
{ 3. Möjlighet att spara filer på flera pathvägar. ( ; används för att dela
{ pathvägarna.
{ 4. Logg spara till disk.
}
{
{   Rev 1.1    2003-03-25 09:54:04  peter
{ Fixat bug i Faktura överföringen när Kredit fakturor överförs.
}
{
{   Rev 1.0    2003-03-20 14:01:48  peter
}
{
{   Rev 1.0    2003-03-17 09:26:22  Supervisor
{ Start av vc
}
unit Adeko;

interface

uses SysUtils, Classes, dbtables, Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, Menus, ComCtrls, IniFiles;


function GetFileName(FormStr: string; SenastOverfordaKundnr, ListNr: Integer;
  Avdelning, VerifikatTyp, BolagsNummer: string; Counter: Integer): String;
function CopyString(str: string; num: integer): string;
procedure RunAdeko(FName, Bolag: string);
procedure RunAdekoFakturor(FName, Bolag, Vertyp: string);
procedure RunAdekoKunder(FName, Bolag, Vertyp: string);
procedure RunIFS_Rader(FName, Bolag, Vertyp: string);
procedure RunIFS(FName, Bolag: string);
procedure WriteLog(Fname, Bolag, Vertyp: string);


var
  LastKund: string;
  LastList: Integer;
  TempQueryT: TQuery;
  CustCount, FaktCount, KontoCount: Integer;
  momskonto, IntKonto: string;
  KorPa: Boolean; //! Ok att köra på Directory mm finns

implementation

uses main, Spin, FormVal, MaskUtils;

function GetFileName(FormStr: string; SenastOverfordaKundnr, ListNr: Integer;
  Avdelning, VerifikatTyp, BolagsNummer: string; Counter: Integer): String;
var
  i: integer;
  y, m, d, dayNo: word;
begin
  Result := '';
// B%1:sR%2:s.%4:5d--->%5:2d-%6:2d-%7:2d:%8:3d
// B%2:sH%4:s.%10:5d

  DecodeDate(Now, y, m, d);
  DayNo := Trunc(now - encodeDate(y, 1, 1)) + 1;
  Result := Format(FormStr, [SenastOverfordaKundnr, ListNr, Avdelning,
                  VerifikatTyp, BolagsNummer, y, m, d, dayNo,Counter]);
  for i := 1 to length(Result) do
    if Result[i] = ' ' then
      Result[i] := '0';
end;




function CopyString(str: string; num: integer): string;
var
  i: Integer;
begin
  result := '';
  for I := 1 to num do
    result := result + str;
end;

function PadString(str: string; num: integer): string;
begin
  Result := Copy(Str, 1, num);
  while Length(Result) < num do
    Result := Result + ' ';
end;

procedure RunAdeko(FName, Bolag: string);
var
  OutTextFile: Text;
  i: Integer;
  frm: TFrmVal;
begin
  if KorPa then
  begin
    KontoCount := 0;
    if DirectoryExists(ExtractFilePath(Fname)) then
    else
    begin
      frm := TFrmVal.Create(Application);
      frm.Label1.Caption := 'Katalogen "' + ExtractFilePath(Fname) + '" finns inte vill du skapa denna?';
      frm.ShowModal;
      if frm.ModalResult = MrOk then
        CreateDirectory(PChar(ExtractFilePath(Fname)), nil) else
      begin
        frm.Free;
        KorPa := False;
        exit;
      end;
      frm.Free;
    end;
    AssignFile(OutTextFile, FName);
    rewrite(OutTextFile);
    frmMain.TempQueryT.Open;

    frmMain.TempQueryT.First;
    while not frmMain.TempQueryT.Eof do
    begin
      Inc(KontoCount);
      Write(OutTextFile, 'K01'); // K02 om det är koncernbolag
      Write(OutTextFile, Bolag); // Bolagsnummer
      Write(OutTextFile, '   '); // Trans
      Write(OutTextFile, '  '); // Verifikationstyp
      Write(OutTextFile, '0000000'); // Verifikationsnummer
      Write(OutTextFile, '00'); // Verifikationsår
      Write(OutTextFile, '0000'); // Rec-nr
      Write(OutTextFile, CopyString(' ', 6)); // Filler
      Write(OutTextFile, CopyString(' ', 27)); // Verifikatnotering
      Write(OutTextFile, CopyString(' ', 23)); // Filler
      Write(OutTextFile, CopyString(' ', 41)); // 41 tecken          // Gör texten 121 tecken lång

      Write(OutTextFile, Format('%-6s', [frmMain.TempQueryT.fields[0].AsString]));
      if copy(frmMain.TempQueryT.fields[1].AsString, 1, 1) = '0' then
        Write(OutTextFile, CopyString(' ', 6))
      else
        Write(OutTextFile, Format('%-6s', [frmMain.TempQueryT.fields[1].AsString]));

      Write(OutTextFile, CopyString(' ', (200 - 12))); // Gör texten 200 tecken lång

      Write(OutTextFile, CopyString(' ', 80)); // Gör texten 80 tecken lång

      Write(OutTextFile, '01'); // Antal svansar
      Write(OutTextFile, '03'); // Segment nr
      Write(OutTextFile, FormatDateTime('yymmdd', date));
      Write(OutTextFile, '0'); // Intern flagga
//! Om Det ät till AdeEko
      if (frmMain.EType = 'A') then
      begin
        if (frmMain.TempQueryT.fields[2].AsFloat - frmMain.TempQueryT.fields[3].AsFloat) > 0 then
          Write(OutTextFile, FormatFloat('0000000000001', (frmMain.TempQueryT.fields[2].AsFloat - frmMain.TempQueryT.fields[3].AsFloat) * 100))
        else
          Write(OutTextFile, FormatFloat('0000000000002', (frmMain.TempQueryT.fields[3].AsFloat - frmMain.TempQueryT.fields[2].AsFloat) * 100));
      end;
//!Hit
//!Om Det Är Till IFS (Norge)
      if (frmMain.EType = 'I') then
      begin
        if (frmMain.TempQueryT.fields[2].AsFloat - frmMain.TempQueryT.fields[3].AsFloat) > 0 then
        begin
          Write(OutTextFile, FormatFloat('000000000000', (frmMain.TempQueryT.fields[2].AsFloat - frmMain.TempQueryT.fields[3].AsFloat) * 100));
          Write(OutTextFile, ' ');
        end else
        begin
          Write(OutTextFile, FormatFloat('000000000000', (frmMain.TempQueryT.fields[3].AsFloat - frmMain.TempQueryT.fields[2].AsFloat) * 100));
          Write(OutTextFile, '-');
        end;
      end;
//!Hit
      Write(OutTextFile, CopyString(' ', 14)); // Gör texten 38 tecken lång
      Write(OutTextFile, chr(10));

      if frmMain.TempQueryT.fields[4].AsInteger > LastList then
        LastList := frmMain.TempQueryT.fields[4].AsInteger;

      frmMain.TempQueryT.Next;
    end;
    frmMain.TempQueryT.Close;
//     end;
    CloseFile(OutTextFile);
    if KontoCount=0 then
       DeleteFile(pchar(FName));
  end;
end;

procedure WriteLog(FName, Bolag, Vertyp: string);
var
  OutTextFile: Text;
begin
  AssignFile(OutTextFile, FName);
  rewrite(OutTextFile);

  Writeln(OutTextFile, 'Etrans Logg');
  Writeln(OutTextFile, '===========');
  Writeln(OutTextFile, '');
  Writeln(OutTextFile, 'Datum : ' + DateToStr(Now));
  Writeln(OutTextFile, 'Listnr: ' + IntToStr(Adeko.LastList));
  Writeln(OutTextFile, 'Bolag : ' + Bolag);
  Writeln(OutTextFile, 'VerTyp: ' + Vertyp);
  Writeln(OutTextFile, '');
  Writeln(OutTextFile, 'Antal överförda Kunder     : ' + IntToStr(CustCount));
  Writeln(OutTextFile, 'Antal överförda Fakturor   : ' + intToStr(FaktCount));
  Writeln(OutTextFile, 'Antal överförda Kontoposter: ' + IntToStr(kontocount));
  Writeln(OutTextFile, '');
  Writeln(OutTextFile, '****** Slut på Etrans logg ******');
  CloseFile(OutTextFile);
end;

procedure RunAdekoFakturor(FName, Bolag, Vertyp: string);
var
  OutTextFile: Text;
  pnr: string;
  test: string[1];
begin
  if KorPa then
  begin
    FaktCount := 0;
    AssignFile(OutTextFile, FName);
    rewrite(OutTextFile);
//     with DM5 do
//     begin
    frmMain.TempQueryT.Open;
    frmMain.TempQueryT.First;
    while not frmMain.TempQueryT.Eof do
    begin
      Inc(FaktCount);
      Write(OutTextFile, 'K01'); // K02 om det är koncernbolag
      Write(OutTextFile, Bolag); // Bolagsnummer


      if frmMain.TempQueryT.fields[6].AsBoolean = true then
        Write(OutTextFile, Format('%-10s', [Copy(frmMain.TempQueryT.fields[0].AsString, 1, 10)])) // Utländskt Kundnr
      else begin

        if frmMain.Checkbox1.checked then
          pnr := GetBNum(frmMain.TempQueryT.fields[0].AsString)
        else

          pnr := Copy(frmMain.TempQueryT.fields[10].AsString, 1, 6) + Copy(frmMain.TempQueryT.fields[10].AsString, 8, 4);

//!För Norska IFS....
        if (frmMain.EType = 'I') then
        begin
          Test := Copy(frmMain.TempQueryT.fields[10].AsString, 7, 1);
          if test = '-' then
            pnr := Copy(frmMain.TempQueryT.fields[10].AsString, 1, 6) + Copy(frmMain.TempQueryT.fields[10].AsString, 8, 4) else
            pnr := frmMain.TempQueryT.fields[10].AsString;
        end;
//!Hit...

        Write(OutTextFile, Format('%-10s', [pnr]));
      end;
//           Write(OutTextFile,Format('%-10s',[TempQueryT.fields[0].AsString]));    // Kundnr


      Write(OutTextFile, FormatFloat('0000000000', frmMain.TempQueryT.fields[1].AsInteger)); // Faktnr
      Write(OutTextFile, Vertyp); // Verifikationstyp
      Write(OutTextFile, CopyString(' ', 8)); // Gör texten 80 tecken lång

      Write(OutTextFile, FormatDateTime('yymmdd', frmMain.TempQueryT.fields[2].AsDateTime)); // Fakturadatum
      Write(OutTextFile, FormatDateTime('yymmdd', frmMain.TempQueryT.fields[3].AsDateTime)); // Förfallodatum
      Write(OutTextFile, FormatDateTime('yymmdd', frmMain.TempQueryT.fields[2].AsDateTime)); // Bokf.datum = fakturadatum
//!           Write(OutTextFile,FormatFloat('000000000000',abs(frmMain.TempQueryT.fields[4].AsFloat  )*100));  // Faktsumma
//!           Write(OutTextFile,FormatFloat('000000000000',abs(frmMain.TempQueryT.fields[4].AsFloat +frmMain.TempQueryT.fields[11].AsFloat )*100));  // Faktsumma
      if (frmMain.EType = 'I') then
      begin
        Write(OutTextFile, FormatFloat('000000000000', abs(frmMain.roundBaz(frmMain.TempQueryT.fields[4].AsFloat) * 100))); // Faktsumma
        Write(OutTextFile, FormatFloat('000000000000', abs(frmMain.RoundBaz(frmMain.TempQueryT.fields[4].AsFloat + frmMain.TempQueryT.fields[11].AsFloat) * 100))); // Faktsumma Inkl Moms
      end;
      if (frmMain.EType = 'A') then
      begin
        Write(OutTextFile, FormatFloat('000000000000', abs(frmMain.RoundBaz(frmMain.TempQueryT.fields[4].AsFloat + frmMain.TempQueryT.fields[11].AsFloat) * 100))); // Faktsumma Inkl Moms
        Write(OutTextFile, FormatFloat('000000000000', abs(frmMain.roundBaz(frmMain.TempQueryT.fields[4].AsFloat) * 100))); // Faktsumma
      end;
      if frmMain.TempQueryT.fields[12].AsFloat < -0.5 then
        write(OutTextFile, '-') else
        write(OutTextFile, ' ');


//!           Write(OutTextFile,'00000000000'); // 100 % moms
      Write(OutTextFile, '00000000000'); // 60 % moms
      Write(OutTextFile, '000000000000'); // 20 % moms
      if frmMain.TempQueryT.fields[4].AsFloat < -0.5 then
        Write(OutTextFile, 'K')
      else
        Write(OutTextFile, 'D');
      Write(OutTextFile, CopyString(' ', 20)); // Format('%-20s',[TempQueryT.fields[5].AsString]));    // Referens
      Write(OutTextFile, '000000000000000'); // Utlänsk fakturasumma
      Write(OutTextFile, '   '); // Valutakod
      Write(OutTextFile, ' '); // Fakturatyp
      Write(OutTextFile, '                  '); // Filler
      Write(OutTextFile, CopyString(' ', 18)); // Gör texten 80 tecken lång
      Write(OutTextFile, chr(10));

      frmMain.TempQueryT.Next;
    end;
    frmMain.TempQueryT.Close;
//     end;
    CloseFile(OutTextFile);
    if FaktCount=0 then
       DeleteFile(Pchar(FName));
  end;
end;

procedure RunAdekoKunder(FName, Bolag, Vertyp: string);
var
  OutTextFile: Text;
  pnr: string;
  Test: string[1];
  frm: TFrmVal;
begin
  if KorPa then
  begin
    CustCount := 0;
    AssignFile(OutTextFile, FName);
    rewrite(OutTextFile);
//     with DM5 do
//     begin
    frmMain.TempQueryT.Open;

    frmMain.TempQueryT.First;
    while not frmMain.TempQueryT.Eof do
    begin
      Inc(CustCount);
      Write(OutTextFile, 'K01'); // K02 om det är koncernbolag
      Write(OutTextFile, Bolag); // Bolagsnummer
      Write(OutTextFile, 'KK00'); // Ny kund


      if frmMain.TempQueryT.fields[8].AsBoolean = true then
        Write(OutTextFile, Format('%-10s', [Copy(frmMain.TempQueryT.fields[0].AsString, 1, 10)])) // Utländskt Kundnr
      else begin

        if frmMain.Checkbox1.checked then
          pnr := GetBNum(frmMain.TempQueryT.fields[0].AsString)
        else
          pnr := Copy(frmMain.TempQueryT.fields[0].AsString, 1, 6) + Copy(frmMain.TempQueryT.fields[0].AsString, 8, 4);
//!För Norska IFS....
        if (frmMain.EType = 'I') then
        begin
          Test := Copy(frmMain.TempQueryT.fields[0].AsString, 7, 1);
          if test = '-' then
            pnr := Copy(frmMain.TempQueryT.fields[0].AsString, 1, 6) + Copy(frmMain.TempQueryT.fields[0].AsString, 8, 4) else
            pnr := frmMain.TempQueryT.fields[0].AsString;
        end;
//!Hit...
        Write(OutTextFile, Format('%-10s', [pnr])); //! Skriv in PNummer
      end;
//           Write(OutTextFile,Format('%-10s',[TempQueryT.fields[0].AsString]));    // Kundnr


      Write(OutTextFile, PadString(frmMain.TempQueryT.fields[1].AsString, 33)); // Namn
      Write(OutTextFile, PadString(frmMain.TempQueryT.fields[2].AsString, 27)); // Adress
      Write(OutTextFile, PadString(frmMain.TempQueryT.fields[3].AsString, 27)); // Adress2
//!Till IFS PostNummer och PostOrt
      if (frmMain.EType = 'I') then
      begin
        Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 1, 3)); // postnr
        Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 4, 2)); // postnr
        Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 6, 15)); // postadress
      end;
//!Om det är till Adeko PostNummer o PostOrt
      if (frmMain.EType = 'A') then
      begin
        Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 1, 3)); // postnr
        if copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 4, 1) = ' ' then
        begin
          Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 5, 2)); // postnr
          Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 9, 15)); // postadress
        end
        else
        begin
          Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 4, 2)); // postnr
          Write(OutTextFile, copy(frmMain.TempQueryT.fields[4].AsString + Copystring(' ', 15), 8, 15)); // postadress
        end;
      end;
      Write(OutTextFile, Format('%-25s', [copy(frmMain.TempQueryT.fields[5].AsString, 1, 25)])); // Land
      Write(OutTextFile, '  '); // Kundkategori
      Write(OutTextFile, Format('%-11s', [copy(frmMain.TempQueryT.fields[6].AsString, 1, 11)])); // Telefonnummer

      Write(OutTextFile, CopyString(' ', 20)); // Handläggare
      Write(OutTextFile, CopyString(' ', 3)); // Valutakod
      Write(OutTextFile, CopyString(' ', 20)); // Statistik
      Write(OutTextFile, CopyString(' ', 50)); // Fria kunduppgifter
      Write(OutTextFile, CopyString(' ', 2)); // Språkkod
      Write(OutTextFile, CopyString(' ', 40)); // Filler
      Write(OutTextFile, chr(10));
      LastKund := frmMain.TempQueryT.fields[7].AsString;
      frmMain.TempQueryT.Next;
    end;
    frmMain.TempQueryT.Close;
//     end;
    CloseFile(OutTextFile);
    if CustCount=0 then
       DeleteFile(Pchar(FName));
  end;
end;

procedure RunIFS_Rader(FName, Bolag, Vertyp: string);
var
  OutTextFile: Text;
  belopp, Msats: Integer;
  mk, kk: string; //! MomsKonto o KundfdrKonto
  TTKonto, TTKstalle, TTFaktNr: string; //! 310 Raderna som ska slås ihop per Konto&Kstalle
  TTDebet, TTKredit: Integer;
  TTjuFaktNr: string;
  belopp2: double;
  spec: Boolean; //!Om det ska vara en 310 på Momsen
begin
  TTKonto := '';
  TTKStalle := '';
  TTFaktNr := '';
  TTjuFaktNr := '';
  FaktCount := 0;
//! Plocka ut KundfdrKonto
  frmMain.QKonto.Active := False;
  frmMain.QKonto.SQL.Text := 'SELECT KundFdrKonto from Param';
  frmMain.QKonto.Active := True;
  KK := frmMain.QKonto.Fields[0].AsString;

  frmMain.QKonto.Active := False;
  frmMain.QKonto.SQL.Text := 'SELECT Kontering.Konteringsid, Kontering.Kontonr FROM Kontering WHERE (((Kontering.Konteringsid)=' + kk + '));';
  frmMain.QKonto.Active := True;
  IntKonto := frmMain.QKonto.Fields[1].AsString;
//! Plocka ut MomsKonto
  frmMain.QKonto.Active := False;
  frmMain.QKonto.SQL.Text := 'SELECT MomsKonto from Param';
  frmMain.QKonto.Active := True;
  MK := frmMain.QKonto.Fields[0].AsString;

  frmMain.QKonto.Active := False;
  frmMain.QKonto.SQL.Text := 'SELECT Kontering.Konteringsid, Kontering.Kontonr FROM Kontering WHERE (((Kontering.Konteringsid)=' + MK + '));';
  frmMain.QKonto.Active := True;
  MomsKonto := frmMain.QKonto.Fields[1].AsString;
//! Här körs det igång...
  AssignFile(OutTextFile, FName);
  rewrite(OutTextFile);
//! Momssats
  frmMain.IFSQ1.Active := False;
  frmMain.IFSQ1.SQL.text := 'SELECT Param.MOMS FROM Param;';
  frmMain.IFSQ1.Active := True;
  msats := frmMain.IFSQ1.Fields[0].AsInteger;

//! För rad 1 300...
  frmMain.IFSQ1.Active := False;
  frmMain.IFSQ1.SQL.Text := 'SELECT LoggTabell.LoggNr, LoggTabell.NrTyp, Contr_Sub.Payment, Contr_Sub.ENummer, Contr_Sub.Print_Date, Contr_Sub.ForfalloDat, Contr_Sub.Print_Date, Customer.Org_No, Contr_SubCost.DMOMS';
  frmMain.IFSQ1.SQL.Text := frmMain.IFSQ1.SQL.Text + ' FROM ((Contr_Sub INNER JOIN LoggTabell ON Contr_Sub.ENummer = LoggTabell.Nummer) LEFT JOIN Customer ON Contr_Sub.SubCustId = Customer.Cust_Id) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId';
  frmMain.IFSQ1.SQL.Text := frmMain.IFSQ1.SQL.Text + ' WHERE (((LoggTabell.LoggNr)>' + frmMain.Edit2.Text + ') AND ((LoggTabell.NrTyp)=1) AND ((Contr_Sub.Payment)=''F''));';
  frmMain.IFSQ1.Active := True;
  frmMain.IFSQ1.First;
  while not frmMain.IFSQ1.Eof do
  begin
    spec := False;
    inc(FaktCount);
//! För rad 1 300...
    Write(OutTextFile, '300'); //!RecordType (3)
    Write(OutTextFile, Bolag); //!CompanyCode (3)
    Write(OutTextFile, FormatFloat('0000000000000000', frmMain.IFSQ1.fields[3].AsInteger)); //!FakturaNummer (16)
    Write(OutTextFile, formatdatetime('yyyymmdd', frmMain.IFSQ1.fields[4].Asdatetime)); //!FaktureringsDatum (8)
    Write(OutTextFile, formatdatetime('yyyymmdd', frmMain.IFSQ1.fields[6].Asdatetime)); //!BokföringsDatum (8)
    Write(OutTextFile, formatdatetime('yyyymmdd', frmMain.IFSQ1.fields[5].Asdatetime)); //!FörfalloDatum (8)
    Write(OutTextFile, formatfloat('000', frmMain.IFSQ1.fields[5].AsFloat - frmMain.IFSQ1.fields[4].Asfloat)); //!DueDate-DocDate (3)
    Write(OutTextFile, Format('%-10s', [Copy(stringreplace(frmMain.IFSQ1.fields[7].AsString, '-', '', [RfReplaceAll]), 1, 10)])); //!KundNummer (10)
    Write(OutTextFile, 'SEK  '); //!Currency Key (5)
    Write(OutTextFile, '000000001'); //!Exchange Rate (9)
    Writeln(OutTextFile, 'Car2000                  '); //!DokumentHeaderText (25)
//! Hit...
    frmMain.IFSQ2.Active := False;
    frmMain.IFSQ2.sql.text := 'SELECT KnterRad.Nummer, KnterRad.Konto, KnterRad.KStalle, KnterRad.Debet, KnterRad.Kredit';
    frmMain.IFSQ2.sql.text := frmMain.IFSQ2.sql.text + ' FROM KnterRad WHERE (((KnterRad.Nummer)=' + frmMain.IFSQ1.fields[3].Asstring + ' AND (KnterRad.Konto)<>' + IntKonto + ' And (KnterRad.Konto)<>' + MomsKonto + '))ORDER BY KnterRad.Konto, KnterRad.KStalle;';
    frmMain.IFSQ2.Active := True;
    frmMain.IFSQ2.First;
    while not frmMain.IFSQ2.Eof do
    begin
//! För rad 2 (320)
      if TTjuFaktNr <> INttostr(frmMain.IFSQ2.fields[0].AsInteger) then
      begin
        frmMain.Q320.Active := False;
        frmMain.Q320.sql.text := 'SELECT Sum(KnterRad.Debet), Sum(KnterRad.Kredit) FROM KnterRad WHERE (((KnterRad.Nummer)=' + frmMain.IFSQ1.fields[3].Asstring + ' AND (KnterRad.Konto)<>' + IntKonto + ' And (KnterRad.Konto)<>' + MomsKonto + '));';
        frmMain.Q320.Active := true;
        TTjuFaktNr := INttostr(frmMain.IFSQ2.fields[0].AsInteger);
        if frmMain.Q320.Fields[0].AsInteger <> 0 then
        begin
          Belopp := 0;
          Write(OutTextFile, '320'); //!RecordType (3)
          Write(OutTextFile, Bolag); //!CompanyCode (3)
          Write(OutTextFile, FormatFloat('0000000000000000', frmMain.IFSQ2.fields[0].AsInteger)); //!FakturaNummer (16)
          belopp := frmMain.Q320.fields[0].AsInteger * 100;
          Write(OutTextFile, FormatFloat('000000000000000', ABS(belopp))); //!Belopp (15)
          if belopp > 0 then //! Om det är plus eller minus (1)
            Write(OutTextFile, '-') else
            Write(OutTextFile, '+');
          if frmMain.IFSQ1.fieldbyname('DMoms').AsInteger > 0 then
            Write(OutTextFile, Inttostr(Msats)) else //!Momssats (2)
            Write(OutTextFile, '0 ');
          Write(OutTextFile, CopyString(' ', 13)); //!Quantity
          Write(OutTextFile, CopyString(' ', 18)); //!RegNo eller ChassiNr
          WriteLn(OutTextFile, CopyString(' ', 10)); //!ProduktNr
        end;
        if frmMain.Q320.Fields[1].AsInteger <> 0 then
        begin
          Belopp := 0;
          Write(OutTextFile, '320'); //!RecordType (3)
          Write(OutTextFile, Bolag); //!CompanyCode (3)
          Write(OutTextFile, FormatFloat('0000000000000000', frmMain.IFSQ2.fields[0].AsInteger)); //!FakturaNummer (16)
          belopp := frmMain.Q320.fields[1].AsInteger * 100;
          Write(OutTextFile, FormatFloat('000000000000000', ABS(belopp))); //!Belopp (15)
          if belopp > 0 then //! Om det är plus eller minus (1)
            Write(OutTextFile, '+') else
            Write(OutTextFile, '-');
          if frmMain.IFSQ1.fieldbyname('DMoms').AsInteger > 0 then
            Write(OutTextFile, Inttostr(Msats)) else //!Momssats (2)
            Write(OutTextFile, '0 ');
          Write(OutTextFile, CopyString(' ', 13)); //!Quantity
          Write(OutTextFile, CopyString(' ', 18)); //!RegNo eller ChassiNr
          WriteLn(OutTextFile, CopyString(' ', 10)); //!ProduktNr
        end;
//! Om det är en delad betalare med all Moms eller % av Moms
        belopp2 := int((frmMain.Q320.Fields.Fields[1].AsInteger - frmMain.Q320.Fields.Fields[0].AsInteger) * 0.25);
        if (belopp2 <> frmMain.IFSQ1.fieldbyname('DMoms').asinteger) and
          (belopp2 - 1 <> frmMain.IFSQ1.fieldbyname('DMoms').asinteger) and
          (belopp2 + 1 <> frmMain.IFSQ1.fieldbyname('DMoms').asinteger) and
          (frmMain.IFSQ1.fieldbyname('DMoms').asinteger > 0) then
        begin
          spec := True; // Om det ska vara en 310 rad på Momsen
          Write(OutTextFile, '320'); //!RecordType (3)
          Write(OutTextFile, Bolag); //!CompanyCode (3)
          Write(OutTextFile, FormatFloat('0000000000000000', frmMain.IFSQ2.fields[0].AsInteger)); //!FakturaNummer (16)
          belopp2 := frmMain.IFSQ1.fieldbyname('DMoms').asinteger - belopp2;
          Write(OutTextFile, FormatFloat('000000000000000', ABS(belopp2 * 100))); //!Belopp (15)
          if belopp > 0 then //! Om det är plus eller minus (1)
            Write(OutTextFile, '+') else
            Write(OutTextFile, '-');
          Write(OutTextFile, '0 '); //!MomsKod
          Write(OutTextFile, CopyString(' ', 13)); //!Quantity
          Write(OutTextFile, CopyString(' ', 18)); //!RegNo eller ChassiNr
          WriteLn(OutTextFile, CopyString(' ', 10)); //!ProduktNr
//! Hit med delad betalare
        end;

      end;
//!Hit
//! För rad 3 (310)

//! ************************************************************ 011022
      if (TTkonto <> frmMain.IFSQ2.fields[1].Asstring) or
        (TTKStalle <> frmMain.IFSQ2.fields[2].AsString) or
        (TTFaktNr <> inttostr(frmMain.IFSQ2.fields[0].AsInteger)) then
      begin
        TTkonto := frmMain.IFSQ2.fields[1].Asstring;
        TTkstalle := frmMain.IFSQ2.fields[2].AsString;
        TTFaktNr := Inttostr(frmMain.IFSQ2.fields[0].AsInteger);
        frmMain.Q310.Active := False;
        frmMain.Q310.SQL.Text := 'Select Sum(Debet), Sum(Kredit) from Knterrad where Konto=' + TTKonto + ' AND Kstalle=' + TTKstalle + ' AND Nummer=' + TTFaktNr;
        frmMain.Q310.Active := True;
//! ************************************************************ 011022
        if frmMain.Q310.Fields.Fields[0].AsINteger > 0 then
        begin
          Write(OutTextFile, '310'); //!RecordType (3)
          Write(OutTextFile, Bolag); //!CompanyCode (3)
          Write(OutTextFile, FormatFloat('0000000000000000', StrToInt(TTFaktNr))); //!FakturaNummer (16)
          Write(OutTextFile, '01'); //!Debet

//! Ändrat från formatfloat 0000000000   010821
          Write(OutTextFile, Format('%-10s', [TTKonto])); //!KontoNr (10)
//! Belopp (15)
          Write(OutTextFile, FormatFloat('000000000000000', ABS(frmMain.Q310.fields[0].Ascurrency * 100)));
//! + eller - för belopp
          if frmMain.Q310.fields[0].AsInteger > 0 then
            Write(OutTextFile, '+') else
            Write(OutTextFile, '-');
//! Ändrat från formatfloat 0000000000  010821
          Write(OutTextFile, Format('%-10s', [TTKStalle])); //!KostSt (10)
          Write(OutTextFile, CopyString(' ', 10)); //!Typ
          Write(OutTextFile, CopyString(' ', 10)); //!ProjektNr
          Write(OutTextFile, CopyString(' ', 13)); //!Quantity
          Write(OutTextFile, CopyString(' ', 18)); //!RegNo eller ChassiNr
          Writeln(OutTextFile, CopyString(' ', 10)); //!ProduktNr
//! Hit
        end;
//! ************************************************************
        if frmMain.Q310.Fields.Fields[1].AsINteger > 0 then
        begin
          Write(OutTextFile, '310'); //!RecordType (3)
          Write(OutTextFile, Bolag); //!CompanyCode (3)
          Write(OutTextFile, FormatFloat('0000000000000000', strtoINt(TTFaktnr))); //!FakturaNummer (16)
          Write(OutTextFile, '11'); //!Kredit

//! Ändrat från formatfloat 0000000000   010821
          Write(OutTextFile, Format('%-10s', [TTKonto])); //!KontoNr (10)
//! Belopp (15)
          Write(OutTextFile, FormatFloat('000000000000000', ABS(frmMain.Q310.fields[1].Ascurrency * 100)));
//! + eller - för belopp
          if frmMain.Q310.fields[1].AsInteger > 0 then
            Write(OutTextFile, '-') else
            Write(OutTextFile, '+');

//! Ändrat från formatfloat 0000000000  010821
          Write(OutTextFile, Format('%-10s', [TTKStalle])); //!KostSt (10)
          Write(OutTextFile, CopyString(' ', 10)); //!Typ
          Write(OutTextFile, CopyString(' ', 10)); //!ProjektNr
          Write(OutTextFile, CopyString(' ', 13)); //!Quantity
          Write(OutTextFile, CopyString(' ', 18)); //!RegNo eller ChassiNr
          Writeln(OutTextFile, CopyString(' ', 10)); //!ProduktNr
//! Hit
        end; //! För att slå ihop per Konto & KStalle Begin
      end;
      frmMain.IFSQ2.Next;
    end;
//! ************************************************************
//!om Momsen Skall Specialfixas
    if spec = True then
    begin
      Write(OutTextFile, '310'); //!RecordType (3)
      Write(OutTextFile, Bolag); //!CompanyCode (3)
      Write(OutTextFile, FormatFloat('0000000000000000', strtoINt(TTFaktnr))); //!FakturaNummer (16)
      Write(OutTextFile, '11'); //!Kredit

//! Ändrat från formatfloat 0000000000   010821
      Write(OutTextFile, Format('%-10s', [momskonto])); //!KontoNr (10)
//! Belopp (15)
      Write(OutTextFile, FormatFloat('000000000000000', belopp2 * 100));
//! + eller - för belopp
      Write(OutTextFile, '-');

//! Ändrat från formatfloat 0000000000  010821
      Write(OutTextFile, Format('%-10s', [TTKStalle])); //!KostSt (10)
      Write(OutTextFile, CopyString(' ', 10)); //!Typ
      Write(OutTextFile, CopyString(' ', 10)); //!ProjektNr
      Write(OutTextFile, CopyString(' ', 13)); //!Quantity
      Write(OutTextFile, CopyString(' ', 18)); //!RegNo eller ChassiNr
      Writeln(OutTextFile, CopyString(' ', 10)); //!ProduktNr
//! Hit
    end;
    frmMain.IFSQ1.Next;
  end;
  CloseFile(OutTextFile);

end;

procedure RunIFS(FName, Bolag: string);
var
  OutTextFile: Text;
begin
  KontoCount := 0;
  AssignFile(OutTextFile, FName);
  rewrite(OutTextFile);
  frmMain.TempQueryT.Active := True;

  frmMain.TempQueryT.First;
  while not frmMain.TempQueryT.Eof do
  begin
    inc(KontoCount);
    Write(OutTextFile, Bolag); // Bolagsnummer (3)
    Write(OutTextFile, formatdatetime('yyyy', Date)); //!Datum (4)
    Write(OutTextFile, '                '); // Dokumentnummer (16)
//!  010821         Write(OutTextFile,FormatFloat('0000000000',TempQueryT.fields[0].AsInteger)); // KontoNummer (10)
//!  010821         Write(OutTextFile,FormatFloat('0000000000',TempQueryT.fields[1].AsInteger)); // KostST (10)
    Write(OutTextFile, Format('%-10s', [frmMain.TempQueryT.fields[0].AsString])); // KontoNummer (10)
    Write(OutTextFile, Format('%-10s', [frmMain.TempQueryT.fields[1].AsString])); // KostST (10)
    Write(OutTextFile, '          '); // Produktnummer (10)
    Write(OutTextFile, '          '); // ProjectNr (10)
    Write(OutTextFile, formatdatetime('yyyymmdd', Date)); //!Datum (8)
    if (frmMain.TempQueryT.fields[2].AsFloat - frmMain.TempQueryT.fields[3].AsFloat) > 0 then
      Write(OutTextFile, FormatFloat('000000000000000+', ((frmMain.TempQueryT.fields[2].AsFloat - frmMain.TempQueryT.fields[3].AsFloat) * 100)))
    else
      Write(OutTextFile, FormatFloat('000000000000000-', ((frmMain.TempQueryT.fields[3].AsFloat - frmMain.TempQueryT.fields[2].AsFloat) * 100)));
    Write(OutTextFile, 'SEK  '); // SEK (5)
    Write(OutTextFile, '          '); // Typ (10)
    Write(OutTextFile, '             '); // Tom (13)
    Writeln(OutTextFile, '                  '); // ChassiNo (18)

    if frmMain.TempQueryT.fields[4].AsInteger > LastList then
      LastList := frmMain.TempQueryT.fields[4].AsInteger;

    frmMain.TempQueryT.Next;
  end;
  frmMain.TempQueryT.Active := False;
//     end;
  CloseFile(OutTextFile);

end;


end.

