{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12907: utilsMath.pas 
{
{   Rev 1.0    2003-03-19 17:38:00  peter
}
{
  Copyright © 1997 by Peter Thornqvist; all rights reserved
  Contact:
    peter.thornqvist@eq-soft.se (preferred)

    URL:
    http://www.eq-soft.se/delphistuff

  Description:
    Math utilities
}
unit utilsMath;

interface
uses
  Windows,SysUtils;

{** Min and Max}
function IMax(const Val1,Val2:integer):integer;
function IMin(const Val1,Val2:integer):integer;
function FMax(Val1,Val2:Extended):Extended;
function FMin(Val1,Val2:Extended):Extended;

{** check if a number is a prime }
function IsPrime(Num: LongInt): Boolean;
{** return nearest prime lower than input }
function GetLoPrime(input:longint):longint;
{** return nearest prime higher than input }
function GetHiPrime(input:longint):longint;
{** return the prime closest to input }
{** if midway between two primes, returns the lower }
function GetNearestPrime(input:longint):longint;

{** shuffle an array of integers, floats or strings } 
procedure Shuffle(var A: array of integer);overload;
procedure Shuffle(var A: array of extended);overload;
procedure Shuffle(var A: array of string);overload;

implementation


function IMax(const Val1,Val2:integer):integer;
begin
  Result := Val1;
  if Val2 > Val1 then Result := Val2;
end;

function IMin(const Val1,Val2:integer):integer;
begin
  Result := Val1;
  if Val2 < Val1 then Result := Val2;
end;

function FMax(Val1,Val2:Extended):Extended;
begin
  Result := Val1;
  if Val2 > Val1 then Result := Val2;
end;

function FMin(Val1,Val2:Extended):Extended;
begin
  Result := Val1;
  if Val2 < Val1 then Result := Val2;
end;

{** check if a number is a prime }
function IsPrime(Num: LongInt): Boolean;
var x : Longint; y : Integer;
begin
  if Num <= 2 then
  begin
    Result := (Num = 2);
    Exit;
  end
  else if (Num mod 2)= 0 then
  begin
    Result := False;
    Exit;
  end; {Check if Even #}

  x := -1; y := 0;

  while (Sqr(x) < Num) and (y < 2) do
  begin
    Inc(x,2); { Only check with Odd numbers }
    if (Num mod x)=0 then Inc(y);
  end;
  Result := (y = 1);
end;

{**return nearest prime lower than input
 raises Exception for values  1 > x > maxlongint - 1000 (2147482646 in D2) }
function GetLoPrime(input:longint):longint;
begin
  if (input >= maxlongint - 1000) or (input < 1)  then
    raise Exception.CreateFmt('Argument ,%d, not within bounds!',[input])
  else
    while not IsPrime(input) and (input > 1) do
      Dec(input);
  Result := input;
end;

{**return nearest prime higher than input
  raises Exception for values  1 > x > maxlongint - 1000 (2147482646 in D2) }
function GetHiPrime(input:longint):longint;
begin
  if (input >= maxlongint - 1000) or (input < 1)  then
    raise Exception.CreateFmt('Argument ,%d, not within bounds!',[input])
  else
    while not IsPrime(input) do
      Inc(input);
  Result := input;
end;

{**return the prime closest to input
 if midway between two primes, returns the lower }
function GetNearestPrime(input:longint):longint;
var i,j:longint;
begin
  i := GetLoPrime(input);
  j := GetHiPrime(input);
  if (input - i) <= (j - input) then
    Result := i
  else
    Result := j;
end;


procedure Swap(var X, Y: Integer);overload;
var
  Temp: Integer;
begin
  Temp := X;
  X := Y;
  Y := Temp;
end {Swap for Integers};


procedure Swap(var X, Y: Extended);overload;
var
  Temp: Extended;
begin
  Temp := X;
  X := Y;
  Y := Temp;
end {Swap for floats};

procedure Swap(var X, Y: string);overload;
var
  Temp: string;
begin
  Temp := X;
  X := Y;
  Y := Temp;
end {Swap for strings};

procedure Shuffle(var A: array of Integer);
var
  i: Integer;
begin
  for i := High(A) downto 1 do
      Swap (A[i], A[Random(i + 1)]);
end;

procedure Shuffle(var A: array of Extended);
var
  i: Integer;
begin
  for i := High(A) downto 1 do
    Swap (A[i], A[Random(i + 1)]);
end;

procedure Shuffle(var A: array of string);
var
  i: Integer;
begin
  for i := High(A) downto 1 do
      Swap (A[i], A[Random(i + 1)]);
end;


end.
