{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  15104: SWSecFunc.pas
{
{   Rev 1.2    2005-02-09 19:59:34  pb64
{ wtsapi32.dll laddas nu dynamisk och genererar inga fel vid laddning när dll
{ filen inte finns.
}
{
{   Rev 1.1    2005-02-09 19:22:24  pb64
{ Lagt till funktioner för att hämta maskin namnet (även terminal server).
}
{
{   Rev 1.0    2005-02-07 11:18:26  pb64
{ Rutiner för att hantera den nya licensiering som sparas i databasen.
}
unit SWSecFunc;

interface

uses sysutils, windows;

procedure SetSeed(seed: integer);
procedure InitRnd();
function MyRandom(): integer;
function Encrypt(Seed, Input: string): string;
function Decrypt(Seed: string; input: string): string;
function GetRegCode(Name, SerialNo: string): string;
function GetActCode(Func, RegCode: string): string;
function PBKGetComputerName: string;
function PBKGetClientName: string;

type RandArry = array[0..255] of integer;
// function WTSQuerySessionInformationA(hServer: THandle; SessionId: DWORD;
//  WTSInfoClass: DWORD; var ppBuffer: Pointer; var pBytesReturned: DWORD): BOOL; stdcall; external 'wtsapi32.dll';
// procedure WTSFreeMemory(pMemory: Pointer); stdcall; external 'wtsapi32.dll';

  TWTSQuerySessionInformationA = function(hServer: THandle; SessionId: DWORD;
    WTSInfoClass: DWORD; var ppBuffer: Pointer; var pBytesReturned: DWORD): BOOL; stdcall;

  TWTSFreeMemory = procedure(pMemory: Pointer); stdcall;

const
  WTS_CURRENT_SERVER_HANDLE = THandle(0);
  WTS_CURRENT_SESSION = THandle(-1);
  WTSInitialProgram = 0;
  WTSApplicationName = 1;
  WTSWorkingDirectory = 2;
  WTSOEMId = 3;
  WTSSessionId = 4;
  WTSUserName = 5;
  WTSWinStationName = 6;
  WTSDomainName = 7;
  WTSConnectState = 8;
  WTSClientBuildNumber = 9;
  WTSClientName = 10;
  WTSClientDirectory = 11;
  WTSClientProductId = 12;
  WTSClientHardwareId = 13;
  WTSClientAddress = 14;
  WTSClientDisplay = 15;
  WTSClientProtocolType = 16;

var
  RA: RandArry;
  MyRandSeed: integer;



implementation


function PBKGetComputerName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := '';
end;



function PBKGetClientName: string;
var
  SesID, Size: DWORD;
  Buf: Pointer;
  LibHandle: THandle;
  WTSQuerySessionInformationA: TWTSQuerySessionInformationA;
  WTSFreeMemory: TWTSFreeMemory;
begin
  Result := '';
  try
    LibHandle := LoadLibrary('wtsapi32.dll');
    try
      // If the load failed, LibHandle will be zero.
      if LibHandle <> 0 then
      begin
        // If the code makes it here, the DLL loaded successfully; now obtain
        // the link to the DLL's exported function so that it can be called. }
        @WTSQuerySessionInformationA := GetProcAddress(LibHandle, 'WTSQuerySessionInformationA');
        @WTSFreeMemory := GetProcAddress(LibHandle, 'WTSFreeMemory');
        if not (@WTSQuerySessionInformationA = nil) then
        begin
          if not (@WTSFreeMemory = nil) then
          begin
            if not WTSQuerySessionInformationA(WTS_CURRENT_SERVER_HANDLE,
              WTS_CURRENT_SESSION, WTSClientName,
              Buf, Size) then Exit;
            if Size > 1 then
              Result := PChar(Buf);
            WTSFreeMemory(Buf);
          end;
        end;
        try
          FreeLibrary(LibHandle); // Unload the DLL.
        except
        end;
      end;
    except
    end;
  except
  end;
  try
    if trim(Result) = '' then
      Result := PBKGetComputerName;
  except
  end;

end;



{
function PBKGetClientName: string;
var
  SesID, Size: DWORD;
  Buf: Pointer;
begin
  Result := '';
  try
    if not WTSQuerySessionInformationA(WTS_CURRENT_SERVER_HANDLE,
      WTS_CURRENT_SESSION, WTSClientName,
      Buf, Size) then Exit;
    if Size > 1 then
      Result := PChar(Buf);
    WTSFreeMemory(Buf);
  except
  end;
  try
    if trim(Result) = '' then
      Result := PBKGetComputerName;
  except
  end;
end;
}
{
procedure SetSeed(seed).

Skapad av mbh.
Sätter seed, används ifall funktionen anropas utifrån klassen.
}

procedure SetSeed(seed: integer);
begin
  MyRandSeed := seed;
end;

{
procedure InitRnd()

Skapad av mbh.
Initierar slumptalstabellen. Detta måste göras innan funktionen MyRandom används.
}

procedure InitRnd();
var i: integer;
begin
  RandSeed := 10;
  for i := 0 to 255 do begin
    RA[i] := Random(25);
  end;
end;

{
funtion MyRandom(): integer

Skapad av mbh.
Returenerar ett slumptal.
}

function MyRandom(): integer;
begin
  result := RA[MyRandSeed];

  inc(MyRandSeed);
  if MyRandSeed > 255 then
    MyRandSeed := 0;
end;

{
function Encrypt(seed, input)

Skapad av hasp?, senast ändrad av mbh.
Krypterar strängen input med summan av input som slumptals seed.
}

function Encrypt(Seed, Input: string): string;
var
  charac2, charac, ts: char;
  I, val1, val2: word;
  test: integer;
begin

  InitRnd();

  result := '';
  test := 0;

  for I := 1 to length(seed) do
    test := test + ord(seed[I]) * I;

  SetSeed(test mod 255);

  for I := 1 to length(Input) do
  begin
    charac := input[I];
    val1 := MyRandom();
    val2 := val1 + ord(charac);
    while val2 > 90 do
      val2 := 65 + val2 - 91;
    while val2 < 65 do
      val2 := -64 + val2 + 90;
    charac2 := chr(val2);
    AppendStr(Result, charac2);
  end;
end;

{
funtion Decrypt(seed, input): string

Skapad av hasp?, senast ändrad av mbh.
Dekrypterar strängen input med summan av seed som seed till slumptalgeneratorn.
}

function Decrypt(Seed: string; input: string): string;
var
  charac2, charac: char;
  I, val1, val2, test: integer;
begin
  InitRnd();

  result := '';
  test := 0;
  for I := 1 to length(Seed) do
    test := test + ord(seed[I]) * I;

  SetSeed(test mod 255);

  for I := 1 to length(Input) do
  begin
    charac := input[I];
    val1 := MyRandom();
    val2 := ord(charac) - val1;
    while val2 < 65 do
      val2 := 90 + val2 - 64;
    while val2 < 65 do
      val2 := 64 + val2 - 90;
    charac2 := chr(val2);
    AppendStr(Result, charac2);
  end;
end;

function GetRegCode(Name, SerialNo: string): string;
var str: string;
begin
  Str := Encrypt(Name, SerialNo);
  result := Copy(str, 1, 11);
end;

function GetActCode(Func, RegCode: string): string;
begin
  result := encrypt(Func, RegCode);
  result := Copy(Result, 1, 11);
end;



end.

