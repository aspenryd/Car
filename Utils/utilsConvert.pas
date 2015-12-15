{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12897: utilsConvert.pas 
{
{   Rev 1.0    2003-03-19 17:37:56  peter
}
{
  Copyright © 1997 by Peter Thornqvist; all rights reserved
  Contact:
    peter.thornqvist@eq-soft.se (preferred)

    URL:
    http://www.eq-soft.se/delphistuff
  Description:
    A collection of conversion utilities
}

unit utilsConvert;

interface

uses
  Windows,SysUtils;

{** convert b to a hexvalue }
function HexByte(B: Byte): String;
{** convert W to a hexvalue }
function HexWord(W: Word): String;
{** Returns the Hi byte of W }
function GetHiByte(W: word): byte; assembler;
{** Sets the hi byte of W to B }
function SetHiByte(B: byte; W: word): word; assembler;
{** Returns the Low byte of W }
function GetLoByte(W: word): byte; assembler;
{** Sets the Low byte of W to the value B }
function SetLoByte(B: byte; W: word): word; assembler;
{** convert a word to a longint }
function WordToLong(HiWord,LoWord:Word):longint;
{** convert a word to a longint }
procedure LongToWord(L:longint;var HiWord,LoWord:word);
{** returns true if the bit b is set in Value }
function BitIsSet(Value: longint; b: byte): boolean;
{** sets the bit b to 1 in Value }
function BitOn(Value: longint; b: byte): LongInt;
{** sets the bit b to 0 in Value }
function BitOff(Value: longint; b: byte): LongInt;
{** toggles the bit b between 0 and 1 in Value }
function BitToggle(Value: longint; b: byte): LongInt;
{** InvertInt inverts an integer value.
    F ex if N is 1011, the value 1101 is returned }
function InvertInt(N:integer):integer;
{** InvertFloat inverts the floating-point value F
    F ex if F is 1.51, 15.1 is returned }
function InvertFloat(F:Extended):Extended;
{** StrToHex converts the string S to it's hexadecimal representation }
function StrToHex(const S:string):string;
{** HexToStr converts a hexadecimal value into a string, automatically
  removing any invalid (non-Hex) characters from the string S before trying to convert it }
function HexToStr(const S:String):string;
{** HexToInt converts the hexadecimal character Ch to it's integer value
  Ch must be in the range '0'..'9','A'..'F'. HexToInt is case-insensitive }
function HexToInt(Ch:char):integer;
{** DecToHex works the same as IntToHex }
function DecToHex(Value: integer; Digits: integer): string;
{** HexToDec converts the given hexadecimal string to the corresponding integer value. }
function HexToDec(const S: string): integer;
{** IntToRoman converts the given value to a roman numeric string
  representation. }
function IntToRoman(Value: Longint): string;
{** RomanToInt converts the given string to an integer value. If the string
  doesn't contain a valid roman numeric value, 0 is returned. }
function RomanToInt(const S: string): Longint;
{** convert a string to an integer with given base }
function StrToIntBase(S: string;Base:integer): Longint;
{** convert an integer with given base to a string  }
function IntToStrBase(Value: Longint;Base:integer): string;
{** converts an integer value into a thousand separator delimited string value }
function IntToThousand(Value:integer):string;
{** Converts Ch to its uppercase equivalent }
function toUpper(Ch:char):char;
{** Converts Ch to its lowercase equivalent }
function toLower(Ch:char):char;
{** Returns true if Ch is a lower case letter }
function isLower(Ch:char):boolean;
{** Returns true if Ch is a upper case letter }
function isUpper(Ch:char):boolean;
{** Returns true if Ch is an alpha numeric character }
function isAlnum(Ch:Char):boolean;
{** Returns true if Ch is an alphabetic character }
function isAlpha(Ch:Char):boolean;
{** Returns true if Ch is an ASCII character }
function isASCII(Ch:Char):boolean;
{** Returns true if Ch is an  control character }
function isCntrl(Ch:char):boolean;
{** Returns true if Ch is a digit }
function isDigit(Ch:char):boolean;
{** Returns true if Ch is a hexdigit }
function isHexDigit(Ch:char):boolean;
{** Returns true if Ch is a space character }
function isSpace(Ch:char):boolean;
{** Returns true if Ch is a punctuation character }
function isPunct(Ch:char):boolean;
{** Returns true if S represents a valid hexadecimal value. If the string starts
  with a '$', that character is skipped }
function isHex(const S:String):boolean;
{** Returns true if S can be converted to an integer. }
function isInt(const S: string): boolean;
{** returns true if S represents a valid floating point value }
function isFloat(S:string):boolean;
{** encodes a string into URL format }
function EncodeURL(const S:string):string;
{** decodes an URL string into a nomal string. Raises an EConvertError if the URL
    string is invalid }
function DecodeURL(const S:string):string;

implementation

const
  cHexChar: array[0..15] of Char = '0123456789ABCDEF';

  cURLEncode:array[char] of string = (
    '','%01','%02','%03','%04','%05','%06','%07','%08','%09','%0A','%0B','%0C','%0D','%0E','%0F','%10',
    '%11','%12','%13','%14','%15','%16','%17','%18','%19','%1A','%1B','%1C','%1D','%1E','%1F','+','%21',
    '%22','%23','%24','%25','%26','%27','%28','%29','%2A','%2B','%2C','%2D','%2E','%2F','0','1','2','3',
    '4','5','6','7','8','9','%3A','%3B','%3C','%3D','%3E','%3F','%40','A','B','C','D','E','F','G','H',
    'I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','%5B','%5C','%5D','%5E','%5F',
    '%60','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x',
    'y','z','%7B','%7C','%7D','%7E','%7F','%80','%81','%82','%83','%84','%85','%86','%87','%88','%89','%8A',
    '%8B','%8C','%8D','%8E','%8F','%90','%91','%92','%93','%94','%95','%96','%97','%98','%99','%9A','%9B',
    '%9C','%9D','%9E','%9F','%A0','%A1','%A2','%A3','%A4','%A5','%A6','%A7','%A8','%A9','%AA','%AB','%AC',
    '%AD','%AE','%AF','%B0','%B1','%B2','%B3','%B4','%B5','%B6','%B7','%B8','%B9','%BA','%BB','%BC','%BD',
    '%BE','%BF','%C0','%C1','%C2','%C3','%C4','%C5','%C6','%C7','%C8','%C9','%CA','%CB','%CC','%CD','%CE',
    '%CF','%D0','%D1','%D2','%D3','%D4','%D5','%D6','%D7','%D8','%D9','%DA','%DB','%DC','%DD','%DE','%DF',
    '%E0','%E1','%E2','%E3','%E4','%E5','%E6','%E7','%E8','%E9','%EA','%EB','%EC','%ED','%EE','%EF','%F0',
    '%F1','%F2','%F3','%F4','%F5','%F6','%F7','%F8','%F9','%FA','%FB','%FC','%FD','%FE','%FF');

function HexByte(B: Byte): String;
begin
 Result := cHexChar[B shr 4] + cHexChar[B and 15];
end;

function HexWord(W: Word): String;
begin
  Result := HexByte(Hi(W)) + HexByte(Lo(W));
end;

function GetHiByte(w: word): byte; assembler;
asm
   mov ax, w
   shr ax, 8
end;

function GetLoByte(w: word): byte; assembler;
asm
   mov ax, w
end;

function SetHiByte(b: byte; w: word): word; assembler;
asm
   xor ax, ax
   mov ax, w
   mov ah, b
end;

function SetLoByte(b: byte; w: word): word; assembler;
asm
   xor ax, ax
   mov ax, w
   mov al, b
end;

function BitIsSet(Value: longint; b: byte): boolean;
begin
  Result := (Value and (1 shl b)) <> 0;
end;

function BitOn(Value: longint; b: byte): LongInt;
begin
  Result := Value or (1 shl b);
end;

function BitOff(Value: longint; b: byte): LongInt;
begin
  Result := Value and not (1 shl b);
end;

function BitToggle(Value: longint; b: byte): LongInt;
begin
  Result := Value xor (1 shl b);
end;

function InvertInt(N:integer):integer;
var E:Extended;
begin
   E := InvertFloat(N);
   Result := Trunc(E);
end;

function InvertFloat(F:Extended):Extended;
var S,T:string;i,j:integer;
begin
   S := FloatToStr(F);
   j := 1;
   T := '';

   if S[1] = '-' then
   begin
     T := '-';
     j := 2;
   end;

   for i := Length(S) downto j do
      T := T + S[i];
   Result := StrToFloat(T);
end;

function WordToLong(HiWord,LoWord:Word):longint;
type
  LRec = record
    Lo,Hi:Word;
  end;
var L:LRec;
begin
  L.Hi := HiWord;
  L.Lo := LoWord;
  Result := Longint(L);
end;

procedure LongToWord(L:longint;var HiWord,LoWord:word);
type
  LRec = record
    Lo,Hi:word;
  end;
var Result:LRec;
begin
  Result := LRec(L);
  HiWord := Result.Hi;
  LoWord := Result.Lo;
end;

function StrToHex(const S:string):string;
var i:Longint;
begin
  Result := '';
  for i := 1 to Length(S) do
    Result := Result + HexByte(Ord(S[i]));
end;

function isHex(const S:String):boolean;
var i,j:integer;
begin
  Result := false;
  j := Length(S);
  for i := 1 to j do
  begin
    if (i = 1) and (S[i] = '$') then Continue;
    if not IsHexDigit(S[i]) then Exit;
  end;
  Result := true;
end;

function HexToStr(const S:String):string;
const
  cHexStr = ['0'..'9','a'..'f','A'..'F'];
var i,Len:Longint;tmp,tmp2:string;
begin
  Result := '';
  tmp := '';
  Len := Length(S);
  for i := 1 to Len do
    if (S[i] in cHexStr) then
      tmp := tmp + S[i];
  Len := Length(tmp);
  i := 1;
  while i <= Len do
  begin
    tmp2 := '$'+ Copy(tmp,i,2);
    try
      Result := Result +  char(StrToInt(tmp2));
    except
      Result := Result + '?';
    end;
    Inc(i,2);
  end;
end;

function HexToInt(Ch:char):integer;
begin
  if Ch in ['0'..'9'] then
    Result := Ord(ch) - Ord('0')
  else
    Result := 10 + Ord(AnsiLowerCase(Ch)[1]) - Ord('a');
end;

function isInt(const S: string): boolean;
begin
  Result:=True;
  try
    StrToInt(S);
  except
    Result:=False;
  end;
end;

function DecToHex(Value: integer; Digits: integer): string;
begin
  Result := IntToHex(Value, Digits);
end;

function HexToDec(const S: string): integer;
var
  HexStr: string;
begin
  HexStr := S;
  if Pos('$', S) = 0 then HexStr := '$' + S;
  Result := StrToIntDef(HexStr, 0);
end;

function RomanToInt(const S: string): Longint;
const
  RomanChars = ['C','D','I','L','M','V','X'];
  RomanValues: array['C'..'X'] of Word =
    (100,500,0,0,0,0,1,0,0,50,1000,0,0,0,0,0,0,0,0,5,0,10);
var
  Index, Next: Char;
  I: Integer;
  Negative: Boolean;
begin
  Result := 0;
  I := 0;
  Negative := (Length(S) > 0) and (S[1] = '-');
  if Negative then Inc(I);
  while (I < Length(S)) do begin
    Inc(I);
    Index := UpCase(S[I]);
    if Index in RomanChars then begin
      if Succ(I) <= Length(S) then Next := UpCase(S[I + 1])
      else Next := #0;
      if (Next in RomanChars) and (RomanValues[Index] < RomanValues[Next]) then
      begin
        Inc(Result, RomanValues[Next]);
        Dec(Result, RomanValues[Index]);
        Inc(I);
      end
      else Inc(Result, RomanValues[Index]);
    end
    else begin
      Result := 0;
      Exit;
    end;
  end;
  if Negative then Result := -Result;
end;

function IntToRoman(Value: Longint): string;
Label
  A500, A400, A100, A90, A50, A40, A10, A9, A5, A4, A1;
begin
  Result := '';
{$IFNDEF WIN32}
  if (Value > MaxInt * 2) then Exit;
{$ENDIF}
  while Value >= 1000 do begin
    Dec(Value, 1000);
    Result := Result + 'M';
  end;
  if Value < 900 then goto A500
  else begin
    Dec(Value, 900); Result := Result + 'CM';
  end;
  goto A90;
A400:
  if Value < 400 then goto A100
  else begin
    Dec(Value, 400); Result := Result + 'CD';
  end;
  goto A90;
A500:
  if Value < 500 then goto A400
  else begin
    Dec(Value, 500); Result := Result + 'D';
  end;
A100:
  while Value >= 100 do begin
    Dec(Value, 100); Result := Result + 'C';
  end;
A90:
  if Value < 90 then goto A50
  else begin
    Dec(Value, 90); Result := Result + 'XC';
  end;
  goto A9;
A40:
  if Value < 40 then goto A10
  else begin
    Dec(Value, 40); Result := Result + 'XL';
  end;
  goto A9;
A50:
  if Value < 50 then goto A40
  else begin
    Dec(Value, 50); Result := Result + 'L';
  end;
A10:
  while Value >= 10 do begin
    Dec(Value, 10); Result := Result + 'X';
  end;
A9:
  if Value < 9 then goto A5
  else begin
    Result := Result + 'IX';
  end;
  Exit;
A4:
  if Value < 4 then goto A1
  else begin
    Result := Result + 'IV';
  end;
  Exit;
A5:
  if Value < 5 then goto A4
  else begin
    Dec(Value, 5); Result := Result + 'V';
  end;
  goto A1;
A1:
  while Value >= 1 do begin
    Dec(Value); Result := Result + 'I';
  end;
end;

function isFloat(S:string):boolean;
begin
  Result := true;
  try
    StrToFloat(S);
  except on EConvertError do
    Result := False;
  end;
end;

function StrToIntBase(S: string;Base:integer): Longint;
var
  Digit, I: Byte;
begin
  Result := 0;
  if isInt(S) then
    for I :=1 to Length(S) do
    begin
      Digit := Ord(S[I]) - Ord('0');
      if Digit > 10 then Dec( Digit, 7);
      Result := Result * Base + Digit;
    end;
end;

function IntToStrBase(Value: Longint;Base:integer): string;
var
  Ch: Char;
begin
  Result :='';
  repeat
    Ch :='0';
    Inc(Ch, Value mod Base);
    if Ch >'9' then Inc(Ch, 7);
    Insert( Ch, Result, 1);
    Value := Value div Base;
  until Value =0;
end;

function toUpper(Ch:char):char;
begin
  Result := AnsiUpperCase(Ch)[1];
end;

function toLower(Ch:char):char;
begin
  Result := AnsiLowerCase(Ch)[1];
end;

function isUpper(Ch:char):boolean;
begin
  Result := isCharUpper(Ch);
end;

function isLower(Ch:char):boolean;
begin
  Result := IsCharLower(Ch);
end;

function isAlnum(Ch:Char):boolean;
begin
  Result := IsCharAlphaNumeric(Ch);
end;

function isAlpha(Ch:Char):boolean;
begin
  Result := IsCharAlpha(Ch);
end;

function isASCII(Ch:Char):boolean;
begin
  Result := (Ord(Ch) > 0) and (Ord(Ch) < 128);
end;

function isCntrl(Ch:char):boolean;
begin
  Result := (Ord(Ch) <= $1F) or (Ord(Ch) = $7F);
end;

function isDigit(Ch:char):boolean;
begin
  Result := Ch in ['0'..'9'];
end;

function isHexDigit(Ch:char):boolean;
begin
  Result := Ch in ['0'..'9','A'..'F','a'..'f'];
end;

function isSpace(Ch:char):boolean;
begin
  Result := Ch in [#9,#10,#13,#20,#32];
end;

function isPunct(Ch:char):boolean;
begin
  Result := Ch in [',','.',';',':'];
end;

function IntToThousand(Value:integer):string;
var F:Extended;
begin
  F := Value;
  Result := Format('%.0n',[F]);
end;

function EncodeURL(const S:string):string;
var i,j:integer;
begin
  Result := '';
  j := Length(S);
  for i := 1 to j do
    Result := Result + cURLEncode[S[i]];
end;

function DecodeURLToken(const S:string;Index:integer):boolean;
var tmp:string;
begin
  tmp := Copy(S,Index + 1,2);
  Result := (Length(tmp) = 2) and IsHex(tmp);
end;


function DecodeURL(const S:string):string;
var i,j:integer;
begin
  Result := '';
  j := Length(S);
  i := 1;
  while i <= j do
  begin
    case S[i] of
    '%':
    begin
      if DecodeURLToken(S,i) then
        Result := Result + Char(StrToInt('$' + Copy(S,i + 1,2)))
      else
        raise EConvertError.Create('Invalid token in URL string');
      Inc(i,2);
    end;
    '+': Result := Result + #32;
    else
      Result := Result + S[i];
    end;
    Inc(i);
  end;
end;

end.
