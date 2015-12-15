{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     spin.pas
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
{ $Log:  13127: spin.pas 
{
{   Rev 1.0    2003-03-20 14:01:50  peter
}
{
{   Rev 1.0    2003-03-17 09:26:20  Supervisor
{ Start av vc
}
unit spin;

interface

uses SysUtils, Dialogs, SyncObjs, Windows;

type
  TSpinOmv = function(nFunk : SmallInt;const szIn : String; Var lUtNr : double; Var lfd : double; var nKon : SmallInt; var nTecken : SmallInt) : SmallInt; stdcall;
//  TSpinOmv = procedure(nFunk : SmallInt;const szIn : String; Var lUtNr : double; Var lfd : double; var nKon : SmallInt; var nTecken : SmallInt);

function LoadSpinDLL : boolean;
procedure FreeSpinDLL;
function GetBNum(str : String): string;
function GetBNum2(str : String): string;
function GetBNumInfo(str : String): string;
function GetBNumdat(str : string) : string;
function AntiSpin(str : string): string;
Function SpinOmvandla(nFunk : Integer; strNrIn : String; var strUtNr : String; var dateFd : String; var strkon : String) : SmallInt;

var
  UseBNummer, SpinDllExists : Boolean;
  SpinLib : THandle;
  SpinOmv : TSpinOmv;

implementation

function PNummerKoll(PNUM: String):String;
var
  pnr : string;
  I : integer;
  fault : boolean;
  sum, tio, tal : word;
begin
  fault := false;
  pnr := pnum;

  if length(pnr) > 6 then
    if PNR[7] = '-' then
      delete(PNR,7,1);

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
    While length(PNR) < 9 do
      PNR := Concat(PNR, '0');
  if not fault then
  begin
    sum := 0;
    for I := 1 to 9 do
    begin
      if frac(I/2) = 0 then
        sum := sum + strtoint(PNR[I])
      else
        begin
          tal := 2* strtoint(PNR[I]);
          if tal > 9 then tal := tal-9;
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
      PNR := Concat(PNR,inttostr(tio));
    end;
  end;
  if fault then
    result := 'false'
  else
    result := Copy(PNR,1,6) + '-' + Copy(PNR,7,4);
end;


function intstr(val : integer; num :word): string;
begin
  result := inttostr(val);
  while (length(result) < num) do
    result := '0' + result;
end;


function LoadSpinDLL : boolean;
begin
  result := false;
  if not SpinDllExists then
  begin
    ShowMessage('Hittar ej "Spinapi.dll"');
    Exit;
  end;
  SpinLib := LoadLibrary('Spinapi.dll');
  if SpinLib < 32 then Exit;
  @SpinOmv := GetProcAddress(SpinLib, '?spinomv@@YGHHPBDAAN1AAH2@Z');
  if assigned(SpinOmv) then
    result := true;
end;

procedure FreeSpinDLL;
begin
  if SpinLib > 32 then
  begin
    FreeLibrary(SpinLib);
    SpinLib := 0;
    SpinOmv := nil;
  end;
end;

function GetBNumdat(str : string) : string;
var
  a,b,strUt : String;
begin
  try
    SpinOmvandla(1,str,strUt,a,b);
    result := a;
  except
    on E: Exception do
    begin
      result := '000000-0000';
      ShowMessage(e.message);
    end;
  end;
end;

function GetBNumGender(str : string) : char;
var
  a,b,strUt : String;
begin
  result := #0;
  try
    SpinOmvandla(1,str,strUt,a,b);
    if length(b) > 0 then
      result := b[1];
  except
    on E: Exception do
    begin
      result := #0;
      ShowMessage(e.message);
    end;
  end;
end;

function GetBNumInfo(str : String): string;
var
  a,b,strUt : String;
begin
  try
    SpinOmvandla(1,str,strUt,a,b);
    insert('-',a,5);
    insert('-',a,8);
    result := a;
    if b = 'M' then
      result := result + ' Man'
    else
      result := result + ' Kvinna';
  except
    on E: Exception do
    begin
      result := '000000-0000';
      ShowMessage(e.message);
    end;
  end;
end;


function GetBNum2(str : String): string;
var
  a,b,strUt : String;
begin
  try
    SpinOmvandla(1,str,strUt,a,b);
    result := strUt;
  except
    on E: Exception do
    begin
      result := '000000-0000';
      ShowMessage(e.message);
    end;
  end;
end;

function GetBNum(str : String): string;
var
  a,b,strUt : String;
begin
  try
    SpinOmvandla(1,str,strUt,a,b);
    result := strUt;
    delete(result,7,1);
  except
    on E: Exception do
    begin
      result := '000000-0000';
      ShowMessage(e.message);
    end;
  end;
end;


Function SpinOmvandla(nFunk : Integer; strNrIn : String; var strUtNr : String; var dateFd : String; var strkon : String) : SmallInt;
var
  lUtNr : Double;
  lfd : Double;
  nKon : SmallInt;
  nTecken : SmallInt;
begin
  result := 0;
  if assigned(spinOmv) then
  begin
    If (Length(strNrIn) > 10) Then
    begin
      //Anropa DLL
        lUtNr := 0;
        lfd := 0;
        nKon := 0;
        nTecken := 0;
        result := SpinOmv(nFunk, strNrIn,lUtNr, lfd, nKon, nTecken);
      //Formatera nr
        strUtNr := floattostr(lUtNr);
        insert('-',strUtNr, 7);
     //Fixa födelsedatum
        dateFd := floattostr(lfd);
    //Fixa kön
        strkon := Chr(nKon);
    End;
  end;
end;


function AntiSpin(str : string): string;
var
  test, dat : string;
  Male : boolean;
  I : integer;
begin
    result := '';
    if str[7] <> '-' then
      insert('-',str,7);
    dat := GetBNumdat(str);
    if (str = PNummerKoll(str)) OR (GetBNumGender(str) = 'O') then
    begin
      result := str;
      exit;
    end;
    Male := 'M' = GetBNumGender(str);
    Delete(str,7,1);
    delete(dat,1,2);
    for I := 0 to 999 do
    begin
      if Male = (I mod 2 = 1) then
      begin
        test := PNummerKoll(dat + intstr(I,3));
        if str = GetBNum(test) then
        begin
          result := test;
          exit;
        end;
      end;
    end;
end;

begin
  SpinOmv := nil;
  SpinDLLExists := FileExists('spinapi.dll');
  UseBNummer := false;
end.

