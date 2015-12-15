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
{ $Log:  14770: Adeko.pas
{
{   Rev 1.0    2004-07-02 08:50:02  pb64
}
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


function CopyString(str: string; num: integer): string;
procedure RunPyramid(FName: string);
procedure WriteLog(Fname: string);


var
  LastFakt: Integer;
  TempQueryT: TQuery;
  FaktCount, Rowcount: Integer;
  KorPa: Boolean; //! Ok att köra på Directory mm finns

implementation

uses main, FormVal, MaskUtils;

function CopyString(str: string; num: integer): string;
var
  i: Integer;
begin
  result := '';
  for I := 1 to num do
    result := result + str;
end;


function SplitString(var s: string; del: string): string;
var
  iPos: Integer;
begin
  iPos := Pos(del, s);
  if iPos > 0 then
  begin
    Result := Copy(s, 1, iPos - 1);
    s := Copy(s, iPos + length(del), 999);
  end
  else
  begin
    Result := s;
    s := '';
  end;
end;


function PadString(str: string; num: integer): string;
begin
  Result := Copy(Str, 1, num);
  while Length(Result) < num do
    Result := Result + ' ';
end;

function FormatDate(d: TDateTime; typ: integer): string;
begin
  Result := '';
  if Typ = 1 then
    Result := FormatDateTime('yymmdd', D);
  if Typ = 2 then
    Result := FormatDateTime('yyyy-mm-dd hh:nn', D);
end;


procedure RunPyramid(FName: string);
var
  OutTextFile: Text;
  i: Integer;
  frm: TFrmVal;
  tmpStr, nstr: string;
  s1, s2: string;
begin
  if KorPa then
  begin
    if DirectoryExists(ExtractFilePath(Fname)) then
    else
    begin
      frm := TFrmVal.Create(Application);
      frm.Label1.Caption := 'Katalogen "' + ExtractFilePath(Fname) + '" finns inte vill du skapa denna?';
      frm.ShowModal;
      if frm.ModalResult = MrOk then
        CreateDirectory(PChar(ExtractFilePath(Fname)), nil)
      else
      begin
        frm.Free;
        KorPa := False;
        exit;
      end;
      frm.Free;
    end;

    AssignFile(OutTextFile, FName);
    rewrite(OutTextFile);

    frmMain.TempQueryT.SQL.Text := '';
    frmMain.TempQueryT.SQL.Add('');
    frmMain.TempQueryT.SQL.Add('SELECT * FROM FAKTHEAD WHERE FAKTNR>' + IntToStr(LastFakt) + ' ORDER BY FAKTNR');


    frmMain.TempQueryT.Open;

    frmMain.TempQueryT.First;
    while not frmMain.TempQueryT.Eof do
    begin
      inc(FaktCount);
      Write(OutTextFile, '01');
      Writeln(OutTextFile, Format('%sB%d', [PadString(frmMain.TempQueryT.FieldByName('Kundnr').AsString, 10), frmMain.TempQueryT.FieldByName('Faktnr').AsInteger]));
      Writeln(OutTextFile, '#12312;' + FormatDate(now, 1));
      Writeln(OutTextFile, '#12211;' + frmMain.TempQueryT.FieldByName('payment').AsString);

      tmpStr := frmMain.TempQueryT.FieldByName('FAKTURAADRSTR').AsString;

      s2 := frmMain.TempQueryT.FieldByName('NOTE').AsString;
      s1 := SplitString(s2, '#13');

      nstr := SplitString(tmpStr, '#13');
      Writeln(OutTextFile, '#12243;' + nStr);
      Writeln(OutTextFile, '#12257;' + frmMain.TempQueryT.FieldByName('Kundvatnr').AsString);
      nstr := SplitString(tmpStr, '#13');
      nstr := SplitString(tmpStr, '#13');
      Writeln(OutTextFile, '#12246;' + nStr);
      nstr := SplitString(tmpStr, '#13');
      Writeln(OutTextFile, '#12247;' + nStr);

      frmMain.Q1.SQL.Text := 'SELECT TEL_NR_1 FROM CUSTOMER WHERE CUST_ID=' + frmMain.TempQueryT.FieldByName('Kundnr').AsString;
      frmMain.Q1.Open;

      Writeln(OutTextFile, '#12241;' + frmMain.Q1.FieldByName('TEL_NR_1').AsString); // Telefon nummer
//      Writeln(OutTextFile,'#12398;'); // Object nummer

      frmMain.Q1.Close;

      if (trim(s1) <> '') or (trim(s2) <> '') then
      begin
        if trim(s1) <> '' then
          Writeln(OutTextFile, '12Referens : ' + trim(s1));
        if trim(s2) <> '' then
          Writeln(OutTextFile, '12         : ' + trim(s2));
        Writeln(OutTextFile, '12');
      end;

      Writeln(OutTextFile, '12Kontraktsnummer : ' + frmMain.TempQueryT.FieldByName('KOREF').AsString);
      Writeln(OutTextFile, '12Från ' + FormatDate(frmMain.TempQueryT.FieldByName('FRM_TIME').AsDateTime, 2) + ' Till ' + FormatDate(frmMain.TempQueryT.FieldByName('TO_TIME').AsDateTime, 2));
      Writeln(OutTextFile, Format('12Reg nr: %s Modell: %s %s', [frmMain.TempQueryT.FieldByName('OID').AsString, frmMain.TempQueryT.FieldByName('MODEL').AsString, frmMain.TempQueryT.FieldByName('OTYPE').AsString]));
      if (frmMain.TempQueryT.FieldByName('KM_IN').AsInteger - frmMain.TempQueryT.FieldByName('KM_OUT').AsInteger) > 0 then
        Writeln(OutTextFile, '12Körda Kilometer: ' + IntToStr(frmMain.TempQueryT.FieldByName('KM_IN').AsInteger - frmMain.TempQueryT.FieldByName('KM_OUT').AsInteger) + ' Km');
      Writeln(OutTextFile, '12');


      frmMain.Q1.SQL.Text := '';
      frmMain.Q1.SQL.Add('');
      frmMain.Q1.SQL.Add('SELECT * FROM FAKTRAD WHERE FAKTNR=' + frmMain.TempQueryT.FieldByName('Faktnr').AsString + ' AND A_PRIS<>0 ORDER BY RAD');
      frmMain.Q1.Open;
      frmMain.Q1.First;
      while not frmMain.Q1.Eof do
      begin
        Inc(Rowcount);
        if (frmMain.Q1.FieldByName('RAD').AsInteger = 1) then
        begin
          Writeln(OutTextFile, '11PD              1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
          Writeln(OutTextFile, '#12421;' + frmMain.Q1.FieldByName('TEXT').AsString);
        end;
        if (frmMain.Q1.FieldByName('RAD').AsInteger = 2) then
        begin
          Writeln(OutTextFile, '11KM KILOMETER    1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
          Writeln(OutTextFile, '#12421;Kilometer ');
        end;
        if (frmMain.Q1.FieldByName('RAD').AsInteger = 3) then
        begin
          Writeln(OutTextFile, '11PD ÖVERDYGN     1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
          Writeln(OutTextFile, '#12421;Överdygn ');
        end;
        if (frmMain.Q1.FieldByName('RAD').AsInteger = 4) then
        begin
          Writeln(OutTextFile, '11KM KILOMETER    1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
          Writeln(OutTextFile, '#12421;Kilometer ');
        end;
        if (frmMain.Q1.FieldByName('RAD').AsInteger = 5) then
        begin
          Writeln(OutTextFile, '11SRP SJäLVRISK RE1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
          Writeln(OutTextFile, '#12421;Självrisk reducering ');
        end;
        if (frmMain.Q1.FieldByName('RAD').AsInteger > 5) then
        begin
          if Uppercase(frmMain.Q1.FieldByName('TEXT').AsString) = 'DIESEL' then
          begin
            Writeln(OutTextFile, '11DIESEL DIESEL   1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
            Writeln(OutTextFile, '#12421;Diesel');
          end
          else if Uppercase(frmMain.Q1.FieldByName('TEXT').AsString) = 'BENSIN 95' then
          begin
            Writeln(OutTextFile, '1195OKT BENSIN 95 1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
            Writeln(OutTextFile, '#12421;Bensin 95');
          end
          else if Uppercase(frmMain.Q1.FieldByName('TEXT').AsString) = 'SJÄLVRISK' then
          begin
            Writeln(OutTextFile, '11TB SJäLVRISK    1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
            Writeln(OutTextFile, '#12421;Självrisk');
          end
          else if Uppercase(frmMain.Q1.FieldByName('TEXT').AsString) = 'RABATT' then
          begin
            Writeln(OutTextFile, '11RB RABATT       1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
            Writeln(OutTextFile, '#12421;Rabatt');
          end
          else
          begin
            Writeln(OutTextFile, '11TB              1       ' + frmMain.Q1.FieldByName('A_PRIS_SEK').AsString);
            Writeln(OutTextFile, '#12421;' + frmMain.Q1.FieldByName('TEXT').AsString);
          end;

        end;
        FrmMain.Q1.Next;
      end;

      {  Skriv ut data  }


      if frmMain.TempQueryT.FieldByName('Faktnr').AsInteger > LastFakt then
        LastFakt := frmMain.TempQueryT.FieldByName('Faktnr').AsInteger;

      frmMain.TempQueryT.Next;
    end;
    frmMain.TempQueryT.Close;
    CloseFile(OutTextFile);
  end;
//  LastFakt:=0;
end;

procedure WriteLog(FName: string);
var
  OutTextFile: Text;
begin
  AssignFile(OutTextFile, FName);
  rewrite(OutTextFile);

  Writeln(OutTextFile, 'Ptrans Logg');
  Writeln(OutTextFile, '===========');
  Writeln(OutTextFile, '');
  Writeln(OutTextFile, 'Datum : ' + DateToStr(Now));
  Writeln(OutTextFile, 'Faktnr: ' + IntToStr(LastFakt));
  Writeln(OutTextFile, '');
  Writeln(OutTextFile, 'Antal överförda Fakturor   : ' + intToStr(FaktCount));
  Writeln(OutTextFile, 'Antal överförda Fakt.rader : ' + IntToStr(Rowcount));
  Writeln(OutTextFile, '');
  Writeln(OutTextFile, '****** Slut på Ptrans logg ******');
  CloseFile(OutTextFile);
end;



end.

