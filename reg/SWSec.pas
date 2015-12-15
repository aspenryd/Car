{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     SWSec.pas
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
{ $Log:  12983: SWSec.pas
{
{   Rev 1.2    2005-02-07 11:19:14  pb64
{ Rutiner för att hantera den nya licensiering som sparas i databasen.
{ Hantering av tidsbegränsad licens.
}
{
{   Rev 1.1    2004-01-29 10:26:26  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2003-03-20 13:53:48  peter
}
{
{   Rev 1.0    2003-03-19 20:49:42  peter
{ test
}
{
{   Rev 1.0    2003-03-17 14:41:40  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:54  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:26:24  Supervisor
{ Start av vc
}
{
        Fil: SWSec.pas
        Author: hasp?

        Version: 1.01

        Changes:

        2002-04-20 mbh
        Ändrade Encrypt funktionen så att den använder en egen random funktion.
        Lade också till Funktionerna MyRandom, SetSeed och InitRnd.
}
unit SWSec;

interface

uses
  SysUtils, Dialogs, Controls, ADODb;

function RegProg(path, Name, SerNo, RegCode, ActCode: string): boolean;
function DeRegProg(path: string): boolean;
function CheckRegVal(path: string): boolean;
function CheckReg(var RegName: string; path: string): boolean;



implementation

uses
  Pris, SWSecFunc , DateUtils, DateUtil;


Function HexToInt(HexStr:String):Integer;
var
   i, j : integer;
begin
   Result := 0;
   HexStr := LowerCase(trim(HexStr));
   For i := 1 to Length(HexStr) do
   begin
     j := pos(HexStr[i],'0123456789abcdef')-1;
     if j>-1 then
     begin
       Result := Result * 16;
       Result := Result + j;
     end;
   end;
end;



function DeRegProg(path: string): boolean;
begin
  result := false;
  SetValueToInit('REG', '!MM', 'RDate', InternalDatetostr(date));
  SetValueToInit('REG', '!MM', 'Reg', '');
  SetValueToInit('REG', '!MM', 'DDays', '');
  if GetValueFromInit('REG', '!MM', 'LDate') < '!' then
    SetValueToInit('REG', '!MM', 'LDate', '');
  if GetValueFromInit('REG', '!MM', 'FDate') < '!' then
    SetValueToInit('REG', '!MM', 'FDate', '');
  SetValueToInit('REG', '!MM', 'Serial', '');
  SetValueToInit('REG', '!MM', 'RegCode', '');
  SetValueToInit('REG', '!MM', 'ActCode', '');
  result := true;
end;

function RegProg(path, Name, SerNo, RegCode, ActCode: string): boolean;
begin
  result := false;
  SetValueToInit('REG', '!MM', 'RDate', InternalDatetostr(date));
  SetValueToInit('REG', '!MM', 'Reg', Name);
  SetValueToInit('REG', '!MM', 'Serial', SerNo);
  SetValueToInit('REG', '!MM', 'RegCode', RegCode);
  SetValueToInit('REG', '!MM', 'ActCode', ActCode);
  if Name < '!' then
  begin
    if GetValueFromInit('REG', '!MM', 'LDate') < '!' then
      SetValueToInit('REG', '!MM', 'LDate', '');
    if GetValueFromInit('REG', '!MM', 'FDate') < '!' then
      SetValueToInit('REG', '!MM', 'FDate', '');
  end
  else
  begin
    SetValueToInit('REG', '!MM', 'DDays', '');
    SetValueToInit('REG', '!MM', 'LDate', '');
    SetValueToInit('REG', '!MM', 'FDate', '');
  end;
  result := true;
end;

function CheckRegVal(path: string): boolean;
var
  Name, SerNo, RegC, ActC, Func: string;
  Q : TADOQuery;
begin
  result := false;
  Name := GetValueFromInit('REG', '!MM', 'Reg');
  SerNo := GetValueFromInit('REG', '!MM', 'Serial');
  Func := GetValueFromInit('REG', '!MM', 'Funktioner');
  Func:= Copy(Func,1,11);
  RegC := GetValueFromInit('REG', '!MM', 'RegCode');
  ActC := GetValueFromInit('REG', '!MM', 'ActCode');
  if (RegC = GetRegCode(Name, SerNo)) and (ActC = GetActCode(Func, RegC)) then
    result := true;

  if Result then
  begin
     Q := CreateDS('SELECT COMPANY,ORG_NR FROM COMPANY');
     q.Open;
     if Q.IsEmpty then
     begin
       Result := False;
     end;
     if (Q.FieldByName('COMPANY').AsString<>Name) and (result) then
     begin
       Result := False;
     end;
     if (Q.FieldByName('ORG_NR').AsString<>SerNo) and (result) then
     begin
       Result := False;
     end;
     Q.Close;
     FreeDS(Q);

  end;
end;

function CheckReg(var RegName: string; path: string): boolean;
var
  str: string;
  i, days, LastDate: integer;
begin
  result := false;
  RegName := GetValueFromInit('REG', '!MM', 'Reg');
  if RegName > '!' then
  begin
    if CheckRegVal(path) then
    begin
      result := true;
      try
        if GetValueFromInit('REG', '!MM', 'LDate') > '!' then
          SetValueToInit('REG', '!MM', 'LDate', '');
        if GetValueFromInit('REG', '!MM', 'FDate') > '!' then
          SetValueToInit('REG', '!MM', 'FDate', '');
      except
      end;
      str := GetValueFromInit('REG', '!MM', 'Funktioner');
      days := HexToInt(copy(Str,4,2));
      if days=0 then
        exit;
      LastDate := ((2005+trunc(days/12))*100)+(days mod 12);
      if (YearOf(Now)*100+MonthOf(Now))>LastDate then
      begin
         ShowMessage('Programmets licens har utgått!' + #13 + 'Kontakta återförsäljare för inköp av ny licens');
         Result := False;
         exit;
      end;
      if (YearOf(Now)*100+MonthOf(Now))=LastDate then
      begin
        if MessageDlg('Denna versions utgår nästa månad.' + #13 + 'Kontakta återförsäljare för inköp av ny licens',
          mtInformation, [mbOk, mbCancel], 0) = mrCancel then
          result := false
        else
        begin
          result := true;
        end;
      end;
      exit;
    end
    else
      ShowMessage('Aktiveringskoden stämmer ej!' + #13 + 'Kontakta återförsäljare för korrekt registrering');
  end
  else
  begin
    str := GetValueFromInit('REG', '!MM', 'FDate');
    if Str < '!' then
    begin
      try
        SetValueToInit('REG', '!MM', 'FDate', InternalDateToStr(now));
        Str := InternalDateToStr(now);
      except
        Str := InternalDateToStr(EncodeDate(2000, 1, 1));
      end;
    end;
    i := trunc(Now - InternalStrToDate(str));
    days := 60;
    if I < days then
    begin
//! Här ska Ny Form IN Med 4 Knappar...
//! Start.Doc Ok Avbryt Regit
      if MessageDlg('Denna version är inte registrerad. Du har ' + inttostr(days - I) + ' provdag(ar) kvar.',
        mtInformation, [mbOk, mbCancel], 0) = mrCancel then
        result := false
      else
      begin
        RegName := 'Oregistrerad version';
        result := true;
      end;
    end
    else
      ShowMessage('Denna version är inte registrerad');
  end;
end;

end.

