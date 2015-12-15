{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Funcs.pas
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
{ $Log:  14848: Funcs.pas 
{
{   Rev 1.1    2005-02-07 11:23:18  pb64
{ Tat bort anrop till registry.
}
{
{   Rev 1.0    2004-08-18 11:00:54  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.1    2004-08-10 10:45:38  pb64
}
{
{   Rev 1.0    2003-03-20 14:00:26  peter
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
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
unit funcs;

interface

uses SysUtils, Dialogs, Menus, DBTables, Main;

Function RoundValue(V : Extended):Extended;
function RepExists(V: variant; FNamn: string): boolean;
function GetKNamn(Table: TTable; KID: string): string;
function UnderScoreChar(str: string): char;
//function CheckReg : boolean;
function GetDatabaseFile: string;
function PNummerKoll(PNUM: string): string;
function PNummerOK(PNUM: string): Boolean;
function CopyString(str: string; num: integer): string;
procedure DisableMenu(mnu: TMainMenu; Num: word);
procedure EnableMenu(mnu: TMainMenu; Num: word);
procedure SaveSign;
procedure WriteToErrorLog(val: string);

var
  RegName: string;

implementation


Function RoundValue(V : Extended):Extended;
begin
   Result := (Round((v*100.0))/100.0);
end;

function GetDatabaseFile: string;
begin
//  result := dmSession.DBFile;
end;

procedure SaveSign;
begin
//  DM3.UtskriftT.Edit;
//  DM3.UtskriftTCSIGN.value := frmLogin.sign;
//  DM3.UtskriftT.Post;
end;

function CopyString(str: string; num: integer): string;
var I: Integer;
begin
  result := '';
  for I := 1 to num do
    result := result + str;
end;

function UnderScoreChar(str: string): char;
begin
  result := #0;
  if pos('&', str) > 0 then
    result := UpCase(str[pos('&', str) + 1]);
end;

function GetKNamn(Table: TTable; KID: string): string;
begin
  result := '';
  if KID > '!' then
    if Table.FindKey([KID]) then
      result := Table.Fieldbyname('Namn').AsString + ', ' + Table.Fieldbyname('Adress').AsString + ', ' + Table.Fieldbyname('POSTORT').AsString;
end;

function PNummerKoll(PNUM: string): string;
var
  pnr: string;
  I: integer;
  fault: boolean;
  sum, tio, tal: word;
begin
  fault := false;
  pnr := pnum;
  if frmmain.checkOrgNr = true then
  begin
    if length(pnr) > 6 then
      if PNR[7] = '-' then
        delete(PNR, 7, 1);

    if length(PNR) > 10 then
      fault := true;

    for I := 1 to length(PNR) do
    begin
      case PNR[I] of
        '0'..'9': {Just do nothing}
      else
        fault := true;
      end;
    end;
    if length(PNR) < 6 then
      fault := true
    else
      while length(PNR) < 9 do
        PNR := Concat(PNR, '0');
    if not fault then
    begin
      sum := 0;
      for I := 1 to 9 do
      begin
        if frac(I / 2) = 0 then
          sum := sum + strtoint(PNR[I])
        else
        begin
          tal := 2 * strtoint(PNR[I]);
          if tal > 9 then tal := tal - 9;
          sum := sum + tal;
        end;
      end;

      if sum mod 10 = 0 then
        tio := 0
      else
        tio := 10 - (sum mod 10);
      case PNR[10] of
        '0'..'9':
          if not (tio = strtoint(PNR[10])) then
            fault := true;
      else
        PNR := Concat(PNR, inttostr(tio));
      end;
    end;
    if fault then
      result := 'false'
    else
      result := Copy(PNR, 1, 6) + '-' + Copy(PNR, 7, 4);
  end
  else //!
    result := Pnr; //!
end;

function PNummerOK(PNUM: string): Boolean;
var
  pnr: string;
  I: integer;
  sum, tio, tal: word;
begin
  Result := true;
  pnr := pnum;

  if length(pnr) > 6 then
    if PNR[7] = '-' then
      delete(PNR, 7, 1);

  if length(PNR)<>10 then
      Result := false;

  if Result then
  begin
    for I := 1 to length(PNR) do
    begin
      case PNR[I] of
        '0'..'9': {Just do nothing}
      else
        Result := false;
      end;
    end;
  end;

  if result then
  begin
    sum := 0;
    for I := 1 to 9 do
    begin
      if frac(I / 2) = 0 then
        sum := sum + strtoint(PNR[I])
      else
      begin
        tal := 2 * strtoint(PNR[I]);
        if tal > 9 then tal := tal - 9;
        sum := sum + tal;
      end;
    end;
    if sum mod 10 = 0 then
      tio := 0
    else
      tio := 10 - (sum mod 10);
    if not (tio = strtoint(PNR[10])) then
       Result := false;

  end;
end;

function RepExists(V: variant; FNamn: string): boolean;
var I: Integer;
begin
  result := false;
  for I := 0 to V.Reports.Count - 1 do
    if V.Reports[I].Name = FNamn then
    begin
      result := true;
      exit;
    end;
end;

procedure DisableMenu(mnu: TMainMenu; Num: word);
var I: Integer;
begin
  for I := 0 to Num - 1 do
    TMenuItem(mnu.items[i]).enabled := false;
end;

procedure EnableMenu(mnu: TMainMenu; Num: word);
var I: Integer;
begin
  for I := 0 to Num - 1 do
    TMenuItem(mnu.items[i]).enabled := true;
end;

function StringToChar(val: string): char;
begin
  result := val[1];
end;

function Soundex(aKey: string): string;
const {ABCDEFGHIJKLMNOPQRSTUVWXYZ}
  LetterCodes = '01230120022455012623010202';
  AddLetters = 'ÅÄÖ';
  AddCodes = '000';
  MaxCodeLength = 4;
var
  I: Integer;
  Ch, LastCh: Char;
begin
  result := '';
  LastCh := #0;
  I := 1;
  while length(result) <> MaxCodeLength do
  begin
    if I > Length(aKey) then
      Result := result + '0'
    else
    begin
      Ch := StringToChar(AnsiUpperCase(aKey[I]));
      if Ch in ['A'..'Z'] then
      begin
        if Length(result) = 0 then
          Result := Ch
        else
        begin
          Ch := LetterCodes[Ord(Ch) - 64];
          if (Ch <> '0') and (Ch <> LastCh) then
          begin
            Result := result + Ch;
            LastCh := Ch;
          end;
        end;
      end
      else
      begin // Additional Letters
        if pos(Ch, AddLetters) > 0 then
          if Length(result) = 0 then
            Result := Ch
          else
          begin
            Ch := AddCodes[pos(Ch, AddLetters)];
            if (Ch <> '0') and (Ch <> LastCh) then
            begin
              Result := result + Ch;
              LastCh := Ch;
            end;
          end;
      end;
    end;
  end;
end;

procedure WriteToErrorLog(val: string);
begin
  // Writes an error to the log file
end;

end.

