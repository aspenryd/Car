{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12919: utilsString.pas 
{
{   Rev 1.1    2003-05-26 11:16:42  Supervisor
}
{
{   Rev 1.0    2003-03-19 17:38:02  peter
}
{**
  Copyright © 1997 by Peter Thornqvist; all rights reserved
  Contact:
    peter.thornqvist@eq-soft.se (preferred)

    URL:
    http://www.eq-soft.se/delphistuff

  Name:
    utilsString
  Description:
     String utility functions of varying usefulness...
     Some by me, some stolen
}

unit utilsString;

interface
{$I VER.INC}
uses
  Windows, SysUtils, Classes;


type
  TCharSet = set of char;
  PBoyerMooreSkips = ^TBoyerMooreSkips;
  PBoyerMooreSkipsLarge = ^TBoyerMooreSkipsLarge;
  TBoyerMooreSkips = array[char] of byte;
  TBoyerMooreSkipsLarge = array[word] of integer;

{** strrev reverses Str and returns the result }
function strrev(const AText:string):string;

{**
  strtok tokenizes a string and returns the current token.
  Pass the string to tokenize in Search and the breaking delimiters
  in Delim. For subsequent tokenizing of the same string, pass an empty string in Search.
  Delimiters can change between calls. Returns next token or '' when no more tokens or
  end of string is reached.

  @note : This routine is *not* re-entrant safe!
  @note : Delimiters will *not* be preserved in the output.
}
function strtok(search,delim:string):string;
{** tokenizes a string from the delimiters given and places each token as a
    separate item in the Strings list
}
procedure StrTokenize(const S:string;Delims:TCharSet;Strings:TStrings);
{**
  strrchr finds last occurence of Ch in S
  Returns index of last Ch or 0 if not found
}
function strrchr(const S:string;const Ch:Char):integer;
{** strchr finds first occurence of Ch in S
    Returns index of Ch in S or 0 if not found }
function strchr(const S:string; const Ch:char):integer;
{**
  strspn returns the length of the initial segment of S
  which consist entirely of characters found in T

  returns length of initial S consisting of characters in T
  or 0 if s[1] not in T
}
function strspn(const S:string; T:TCharSet):integer;
{**
  strcspn finds first occurence in S of any character
  belonging to the set T and returns the index of where the
  character was found in S, Returns 0 if no character in T was found in S
}
function strcspn(const S:string; T:TCharSet):integer;
{**
  strpbrk finds the first occurance in S of any character in the set T
  This function is equivalent to strcspn, only differing in the return value

  returns the string after the first occurence of T or
  an empty string if not found
}
function strpbrk(const S:string;const T:TCharSet):string;
{** returns everything before the first occurance of Find in Search. If Find does
    not occur in Search, Search is returned. }
function strBeforeMatch(const Search, Find: string): string;
{** returns everything after the first occurance of Find in Search. If Find does
   not occur in Search, Search is returned. }
function strAfterMatch(const Search, Find: string): string;
{** strPos is like Pos, but allows a StartIndex to be specified.
    If StartIndex is 1, then this is the same as Pos. The returned value is 0 if not found
    or the absolute index  of the first occurance of Find in Search }
function strPos(const Find,Search:string;StartIndex:integer):integer;
{** strRPos is like strPos but searches in reverse. }
function strRPos(const Find, Search: string;StartIndex:integer): integer;

{** BMPos is like Pos, but uses the Boyer-Moore search algorithm
  Note that SubStr must be <= 255 characters long. Use BMPosLarge for larger SubStr }
function BMPos(const SubStr,S:String):integer;
{** same as BMPos, but for SubStr > 255 }
function BMPosLarge(const SubStr,S:string):integer;
{** Same as BMPos, but uses a pre-built skiplist. This can be generated with the
    BuildBMSkips procedure. If you want to search different texts with the same SubStr, it
    is faster to generate the Skip list once and apply it to the different search strings.
    BMPos generates a skiplist each time it is run, regardless of if the SubStr is the same
    between calls }
function BoyerMoore(const SubStr,S:string;var Skips:TBoyerMooreSkips):integer;
{** Builds a skiplist Skips from SubStr for passing along to the BoyerMoore function }
procedure InitializeBM(const SubStr:string;var Skips:TBoyerMooreSkips);
{** Same as BMPosLarge, but uses a pre-built skiplist. This can be generated with the
    InitializeBMLarge procedure. If you want to search different texts with the same SubStr, it
    is faster to generate the Skip list once and apply it to the different search strings.
    BMPosLarge generates a skiplist each time it is run, regardless of if the SubStr is the same
    between calls }
function BoyerMooreLarge(const SubStr,S:string;var Skips:TBoyerMooreSkipsLarge):integer;
{** Builds a skiplist Skips from SubStr for passing along to the BoyerMooreLarge function }
procedure InitializeBMLarge(const SubStr:string;var Skips:TBoyerMooreSkipsLarge);

{** strSetPos returns the index of the first occurance of any character
  of Find in Search. If no character from Find occur in Search then
  0 is returned. }
function strSetPos(const Search: string; const Find: TCharSet): integer;
{** strSetRPos returns the index of the last occurance of any character
  of Find in Search. If no characters from Find occur in Search then
  0 is returned. }
function strSetRPos(const Search: string; const Find: TCharSet): integer;
{** strInside returns the string enclosed by the most inside nested
  LeftBrace ... RightBrace pairs.
}
function strInside(const Search, LeftBrace, RightBrace: string): string;
{** strLeftside returns what is to the left of strInside or Search. }
function strLeftside(const Search, LeftBrace, RightBrace: string): string;
{** strRightside returns what is to the right of strInside or an empty string. }
function strRightside(const Search, LeftBrace, RightBrace: string): string;
{**
  strLast returns the last continuous set of BlackSpaces in
  Search.
  NOTE: Returns empty string if the last characters of Search
  are WhiteSpaces.
}
function strLast(const Search: string): string;
{** strLastRest returns everything strLast does not return. }
function strLastRest(const Search: string): string;
{**
  strExtract returns a list of Count items starting with Start from
  the Separator separated list Search. Extract ignores any separator
  located between paired QuoteChar's.
}
function strExtract(const Search: string; const Start, Count: integer;
    const Separator, QuoteChar: char): string;
{**
  strMatch returns the item position of Find in Search. If Find does not
  occur in Search then 0 is returned. Search is a list of Separator
  separated items. The item position of the first element of the list is 1.
  Match ignores any separators located between paired QuoteChars.
}
function strMatch(const Search, Find: string; const Separator, QuoteChar: char): integer;
{** returns the index of the character RMatch that matches the character LMatch
    in S.  The search starts at StartIndex in S.

    Example:
    if S = '(btw, don't try this at home (it could be dangerous)).'
    strFindMatch(S,2,'(',')') would return 52
    strFindMatch(S,1,'(',')') would return 53
    strFindMatch(S,31,'(',')') would return 52
    If LMatch does not occur in S, then the index of the first occurence of RMatch
    is returned. If RMatch can't be found, 0 is returned.
}
function strFindMatch(const S:string;StartIndex:integer;LMatch,RMatch:char):integer;
{** returns true if the number of Ch1 and Ch2 is equal in S. This function
    also returns true if Ch1 and Ch2 does not appear in S }
function strCharsAreMatched(const S:string;Ch1,Ch2:char):boolean;
{** StrAnsiToOem translates a string from the Windows character set into the
    OEM character set. }
function StrAnsiToOem(const AnsiStr: string): string;
{** strOemToAnsi translates a string from the OEM character set into the
    Windows character set. }
function strOemToAnsi(const OemStr: string): string;
{** StrIsEmpty returns true if the given string contains only character
    from the EmptyChars set. }
function strIsEmpty(const S: string; EmptyChars: TCharSet): Boolean;
{** replace first occurence of Srch in S with Replace }
function strReplaceOne(const S,Srch,Replace:string):string;
{** replace first occurence of Srch in S with Replace, starting at FromPos
   and continuing to ToPos  }
function strReplaceOnePos(const S,Srch,Replace:string;FromPos,ToPos:integer):string;
{** replace last occurence of Srch in S with Replace }
function strRevReplaceOne(const S,Srch,Replace:string):string;
{** replace last occurence of Srch in S with Replace, starting at FromPos
   and continuing to ToPos  }
function strRevReplaceOnePos(const S,Srch,Replace:string;FromPos,ToPos:integer):string;
{** Returns string with every occurrence of Srch string replaced with
  Replace string. }
function strReplaceAll(const S, Srch, Replace: string): string;
{** Returns string with every occurrence of Srch string replaced with
  Replace string, starting at FromPos in S and continuing to ToPos. }
function strReplaceAllPos(const S,Srch,Replace:string;FromPos,ToPos:integer):string;
{** Tab2Space converts any tab character in the given string to
  SpaceCount * spaces characters. }
function strTab2Space(const S: string; SpaceCount: integer): string;
{** Space2Tab converts spaces in S into tabs,
   SpaceCount is the number of spaces that makes up one tab }
function strSpace2Tab(const S: string; SpaceCount: integer): string;
{** strNPos searches for Srch in S starting at FromPos. Returns 0 if not found or the position
    of the start of Srch in S.
    Note that the position is calculated starting at FromPos.
    To get the index from the start of S, add FromPos to the result
}
function strNPos(const Srch,S:String;FromPos:integer):integer;
{** strMake return a string of length Count filled with character C. }
function strMake(C: Char; Count: Integer): string;
{** strCenter centers the characters in the string based upon the
  Len specified. }
function strCenter(const S: string; Len: Integer):string;
{** Returns string, with the first letter of each word in uppercase,
  all other letters in lowercase. Words are delimited by WordDelims. }
function strAnsiProperCase(const S: string; WordDelims: TCharSet): string;
{** strWordCount given a set of word delimiters, return number of words in S. }
function strWordCount(const S: string; WordDelims: TCharSet): Integer;
{** Given a set of word delimiters, return start position of N'th word in S. }
function strWordPosition(const N: Integer; const S: string; WordDelims: TCharSet): Integer;
{** strIsWild compares InputStr with Wilds and return True if they correspond. }
function strIsWild(InputStr, Wilds: string; IgnoreCase: Boolean): Boolean;
{** returns true if any of the characters in CharSet is found in S }
function strSetIsIn(CharSet:TCharSet;S:string):boolean;
{** removes trailing ch from a string }
function strTrimRight(const S: string; const ch : Char): string;
{** Removes leading ch from a string.}
function strTrimLeft(const S : string; const ch : Char): string;
{** trims all characters in Chars from string }
function strTrimAll(const S : String; const Chars : TCharSet) : String;
{** trims all duplicate occurences of any character in Chars from S
   and returns result }
function strTrimDupes(const S:string;Chars:TCharSet):string;
{** convert a string to a TCharSet value }
function StrToCharSet(const S:string):TCharSet;
{** convert a TCharSet set into a string }
function CharSetToStr(const Chs:TCharSet):string;
{** right pads a string, Str, with ch until Length(Str) = Len }
function strRPad(Str:string;Len:integer;Ch:Char):string;
{** left pads a string,Str, with ch until Length(Str) = Len }
function strLPad(Str:string;Len:integer;Ch:Char):string;
{** hash a string value }
function strHashString(Str:string;ignoreBlanks:boolean):DWORD;
function CalcELFHash(const S : string) : longint;

{** return a soundex value for the input string }
function strSoundex(S: string): string;
{** return true if two words sound alike }
function strSoundAlike(Word1, Word2: string): boolean;
{**
  strFindInFile finds all occurances of Find in Filename and returns
  a TStringList where the line index is saved as an integer value into
  the objects property and the entire line where the text was found is placed into
  the Strings property
}
procedure strFindInFile(Filename,Find:string;Result:TStrings);
{**
  Calculates a CRC value for the string S
  NOTE: This routine strips the signed bit from the CRC.
}
function strCRC(const S : string):LongInt;
{** Save a string to a file. If Append is false, the previous contents of the file
  is overwritten }
procedure strSaveToFile(const S,Filename:string;Append:boolean);
{** Load a file and return it as a string }
function strLoadFromFile(const Filename:string):string;
{** Returns the Count'th word in S or empty string if not found.
  Words are separated as defined with Delims. Count is 0-based }
function strGetWord(const S:string;Delims:TCharSet;Count:integer):string;
{** ScanStr finds and returns a pointer to the first occurence of Ch in Str and
  is case-sensitive }
function ScanStr(Str: PChar; Chr: Char):PChar;
{** ScanRStr returns the last occurence of Ch in Str and is case-sensitive }
function ScanRStr(Str: PChar; Chr: Char):PChar;

{** removes multiple QuoteChars from the string S. }
function strTrimQuotes(const S:String;QuoteChar:Char):string;
{**
  returns the number of characters in S and T that are equal and is
  case-sensitive.  strCompareLen compares at most len characters from S and T.
  If either S or T is shorter than len, the comparison is performed up to the
  end of the shortest string.
}
function strCompareLen(const S,T:string;len:integer):integer;
{** Returns true if URL is valid, but does not verify that the URL exists }
function IsValidURL(URL:string):boolean;
{** Returns true if MailAdr is a valid e-mail adress but does not verify that
  the adress exists }
function IsValidMailAdress(MailAdr:string):boolean;
{** Returns true if Source and Mask matches. Mask can contain normal wildcard
    characters, like * and ?, but Source should not.
    This input:
      MatchesString('Peter','*ter')
    would return true.
    The function is case-sensitive
}
function MatchesString(const Source, Mask:string):boolean;
{**
  Converts an index in a TStrings (S) into the corresponding Row, Col coordinates.
  The Index could come from f ex a TMemo's SelStart property
  Row and Col are 0-based indices and for each complete row, a CRLF count of 2 is added
  to the calculation. If S is not assigned or an error occurs (S.Count < 1 f ex) ,
  0 is returned in Row and Col
}
procedure IndexToRowCol(Index:integer;S:TStrings;var Row,Col:integer);
{** converts the 0-based Row, Col coordinate pair into a character index suitable to
    pass to f ex a TMemo's SelStart property.
    If S is not Assigned or Row and Col are invalid (too large or too small), 0 is returned.
}
function RowColToIndex(Row,Col:integer;S:TStrings):integer;

{** The values of BlackSpaces and WhiteSpaces should be changed for non-Western users. }
var
  BlackSpaces:TCharSet = [#33..#255]; // printing characters
  WhiteSpaces:TCharSet = [#0..#32];   // non-printing characters

implementation

uses
  utilsConvert, utilsMath;

function strchr(const S:string; const Ch:char):integer;
var i:integer;
begin
  i := Length(S);
  for Result := 1 to i do
    if S[Result] = Ch then  Exit;
  Result := 0;
end;

function strrchr(const S:string;const Ch:Char):integer;
begin
  Result := Length(S);
  while Result >= 1 do
  begin
    if S[Result] = Ch then  Exit;
    Dec(Result);
  end;

  Result := 0;
end;

function strcspn(const S:string; T:TCharSet):integer;
var i:integer;
begin
  i := Length(S);
  for Result := 1 to i do
    if (S[Result] in T) then Exit;
  Result := 0;
end;

function strspn(const S:string;T:TCharSet):integer;
var i:integer;
begin
  Result := 1;
  i := Length(S);
  while (Result <= i) and (S[Result] in T) do Inc(Result);
  Dec(Result);
end;


function strpbrk(const S:string;const T:TCharSet):string;
var i,j:integer;
begin
  j := Length(S);
  for i := 1 to j do
  begin
    if (S[i] in T) then
    begin
      Result := Copy(S,i+1,Length(S));
      Exit;
    end;
  end;
end;

function strrev(const AText:string):string;
var
  I,J: Integer;
  P: PChar;
begin
  J := Length(AText);
  SetLength(Result, J);
  P := PChar(Result);
  for I := J downto 1 do
  begin
    P^ := AText[I];
    Inc(P);
  end;
end;

(*
function strrev(Str:string):string;
var E,S:integer;
begin

  Result := Str;
  E := Length(Str);
  S := 1;

  while (E >= 1) do
  begin
    Str[S] := char(integer(Str[S]) xor integer(Result[E]));
    Result[E] := char(integer(Result[E]) xor integer(Str[S]));
//       Str[S] := char(integer(Str[S]) xor integer(Result[E])); // reset to normal
    Inc(S);
    Dec(E);
  end;
end;
*)

function strBeforeMatch(const Search, Find: string): string;
var index: integer;
begin
  index := Pos(Find, Search);
  if index = 0 then
    Result := Search
  else
    Result := Copy(Search, 1, index - 1);
end;

function strAfterMatch(const Search, Find: string): string;
var index: integer;
begin
  index:=Pos(Find, Search);
  if index = 0 then
    Result := Search
  else
    Result := Copy(Search, index + Length(Find), Length(Search));
end;

function strPos(const Find,Search:string;StartIndex:integer):integer;
begin
  Result := Pos(Find,Copy(Search,StartIndex,MaxInt));
  if Result > 0 then
    Result := Result + StartIndex - 1;
end;

function strRPos(const Find, Search: string;StartIndex:integer): integer;
begin
  Result := strPos(strrev(Find), strrev(Search),StartIndex);
  if Result > 0 then
    Result := Length(Search) - Length(Find) - Result + 2;
end;

function strSetPos(const Search: string; const Find: TCharSet): integer;
var i:integer;
begin
  i := Length(Search);
  for Result := 1 to i do
    if Search[Result] in Find then
      Exit;
  Result:=0;
end;

function strSetRPos(const Search: string; const Find: TCharSet): integer;
begin
  for Result := Length(Search) downto 1 do
    if Search[Result] in Find then
      Exit;
  Result := 0;
end;

function strInside(const Search, LeftBrace, RightBrace: string): string;
var
  Index, Len: integer;
begin
  Len := Pos(RightBrace, Search);
  Result := '';
  if Len > 0 then
  begin
    Index := strRPos(LeftBrace, Copy(Search, 1, Len - 1),1);
    if Index > 0 then
      Result := Copy(Search, Index + Length(LeftBrace), Len - Index - Length(LeftBrace));
  end;
end;

function strLeftside(const Search, LeftBrace, RightBrace: string): string;
var
  Index, Len: integer;
begin
  Result := Search;
  Len := Pos(RightBrace, Search);
  if Len > 0 then
  begin
    Index := strRPos(LeftBrace, Copy(Search, 1, Len - 1),1);
    if Index > 0 then
      Result := Copy(Search, 1, Index - 1);
  end;
end;

function strRightside(const Search, LeftBrace, RightBrace: string): string;
var
  Index, Len: integer;
begin
  Result := '';
  Len := Pos(RightBrace, Search);
  if Len > 0 then
  begin
    Index := strRPos(LeftBrace, Copy(Search, 1, Len - 1),1);
    if Index > 0 then
      Result := Copy(Search, Len + Length(RightBrace), Length(Search));
  end;
end;

function strLast(const Search: string): string;
var
  Index: integer;
begin
  Result := '';
  Index := Length(Search);
  while (Search[Index] in BlackSpaces) and (Index > 0) do
    Dec(Index);
  Result := Copy(Search, Index + 1, Length(Search));
end;

function strLastRest(const Search: string): string;
var
  Index: integer;
begin
  Result:='';
  Index := Length(Search);
  while (Search[Index] in BlackSpaces) and (Index > 0) do
    Dec(Index);
  Result := Copy(Search, 1, Index);
end;

function strExtract(const Search: string; const Start, Count: integer;
    const Separator, QuoteChar: char): string;
var
  i,j, Item: integer;
  InQuote: boolean;
begin
  InQuote := False;
  Item := 1;
  Result := '';
  j := Length(Search);
  for i := 1 to j do
  begin
    InQuote := (Search[i] = QuoteChar) xor InQuote;
    if Item in [Start..Start + Count - 1] then
      Result := Result + Search[i];
    Item := Item + Ord((Search[i] = Separator) and not InQuote);
    if Item = (Start + Count) then
      Break;
  end;
  j := Length(Result);
  if Result[j] = Separator then
    SetLength(Result,j - 1);
end;

function strMatch(const Search, Find: string;
    const Separator, QuoteChar: char): integer;
var
  Index, Start: integer;
  InQuote: boolean;
begin
  InQuote:=False;
  Result:=1;
  Start:=1;
  if Search = Find then
    Exit;
  for Index:=1 to Length(Search) do
  begin
    InQuote := (Search[Index] = QuoteChar) xor InQuote;
    if (Search[Index] = Separator) and not InQuote then
    begin
      if Find = Copy(Search, Start, Index - Start) then
        Exit;
      Inc(Result);
      Start:=Index + 1;
    end;
  end;
  Result:=0;
end;

function strFindMatch(const S:string;StartIndex:integer;LMatch,RMatch:char):integer;
var i,j:integer;
begin
  Result := 0;
  j := Length(S);
  for i := StartIndex to j do
    if S[i] = LMatch then
      Inc(Result)
    else if (S[i] = RMatch) then
    begin
      if (Result = 0) then
      begin
        Result := i;
        Exit;
      end;
      Dec(Result);
    end;
  Result := 0;
end;

{**$IFOPT J-}
  {**$DEFINE J_CHANGED}
  {**$J+}  // assignable typed constants ON
{**$ENDIF}
function strtok(Search,Delim:string):string;
var
  i:integer;
  Len:integer;
  PrvStr:string;
begin
  i:= 1;
  Len:= 0;
  PrvStr:= '';

  Result := '';
  if Search <> '' then
  begin
    I := 1;
    PrvStr := Search;
    Len := Length(PrvStr);
  end;
  if PrvStr = '' then Exit;
  while (Pos(PrvStr[i],Delim)> 0) and (i <= Len)  do
    Inc(I);
  while (Pos(PrvStr[i],Delim) = 0) and (i <= Len) do
  begin
    Result := Result + PrvStr[i];
    Inc(i);
  end;
end;
{**$IFDEF J_CHANGED}
  {**$J-}
  {**$UNDEF J_CHANGED}
{**$ENDIF}

procedure StrTokenize(const S:string;Delims:TCharSet;Strings:TStrings);
var tmp:String;
begin
  tmp := strtok(S,CharSetToStr(Delims));
  while tmp <> '' do
  begin
    Strings.Add(tmp);
    tmp := strtok('',CharSetToStr(Delims));
  end;
end;

function strCharsAreMatched(const S:string;Ch1,Ch2:char):boolean;
var i,j,c:integer;
begin
  j := Length(S);
  c := 0;
  for i := 1 to j do
    if S[i] = Ch1 then
      Inc(c)
    else if S[i] = Ch2 then
      Dec(c);
  Result := C = 0;
end;

function StrAnsiToOem(const AnsiStr: string): string;
begin
  SetLength(Result, Length(AnsiStr));
  if Length(Result) > 0 then
    AnsiToOem(PChar(AnsiStr), PChar(Result));
end;

function strOemToAnsi(const OemStr: string): string;
var P:PChar;
begin
  Result := '';
  if Length(OemStr) > 0 then
  begin
    SetLength(Result,Length(OemStr));
    P := PChar(Result);
    OemToAnsi(PChar(OemStr), P);
  end;
end;

function strIsEmpty(const S: string; EmptyChars: TCharSet): Boolean;
var
  i, j: Integer;
begin
  j := Length(S);
  Result := false;
  for i := 1 to j do
    if not (S[I] in EmptyChars) then
      Exit;
  Result := true;
end;

function strReplaceOne(const S,Srch,Replace:string):string;
var i: integer;
begin
  Result := S;
  i := Pos(Srch, Result);
  if i > 0 then
    Result := Copy(Result, 1, i - 1) + Replace + Copy(Result, i + Length(Srch), MaxInt);
end;

function strReplaceOnePos(const S,Srch,Replace:string;FromPos,ToPos:integer):string;
begin
  Result := strReplaceOne(Copy(S,FromPos,ToPos - FromPos),Srch,Replace);
end;

function strRevReplaceOne(const S,Srch,Replace:string):string;
var i:integer;
begin
  Result := S;
  i := strRPos(Srch,Result,1);
  if i > 0 then
    Result := Copy(Result, 1, i - 1) + Replace + Copy(Result, i + Length(Srch), MaxInt);
end;

function strRevReplaceOnePos(const S,Srch,Replace:string;FromPos,ToPos:integer):string;
begin
  Result := strRevReplaceOne(Copy(S,FromPos,ToPos-FromPos),Srch,Replace);
end;

function strReplaceAll(const S, Srch, Replace: string): string;
var
  i: Integer;
  S2: string;
begin
  S2 := S;
  Result := '';
  repeat
    i := Pos(Srch, S2);
    if i > 0 then
    begin
      Result := Result + Copy(S2, 1, i - 1) + Replace;
      S2 := Copy(S2, i + Length(Srch), MaxInt);
    end
    else
      Result := Result + S2;
  until i < 1;
end;

function strReplaceAllPos(const S,Srch,Replace:string;FromPos,ToPos:integer):string;
begin
  Result := strReplaceAll(Copy(S,FromPos,ToPos - FromPos),Srch,Replace);
end;

function strTab2Space(const S: string; SpaceCount: integer): string;
begin
  Result := strReplaceAll(S,#9,strMake(' ',SpaceCount));
end;

function strSpace2Tab(const S: string; SpaceCount: integer): string;
begin
  Result := strReplaceAll(S,strMake(' ',SpaceCount),#9);
end;

function strMake(C: Char; Count: Integer): string;
begin
  Result := '';
  if Count < 1 then Exit;
{$IFNDEF WIN32}
  if N > 255 then N := 255;
{$ENDIF}
  SetLength(Result, Count);
  FillChar(Result[1], Count, C);
end;

function strNPos(const Srch,S:String;FromPos:integer):integer;
begin
  Result := Pos(Srch,Copy(S,FromPos,MaxInt));
end;

function strAnsiProperCase(const S: string; WordDelims: TCharSet): string;
var
  SLen, I: Cardinal;
begin
  Result := AnsiLowerCase(S);
  I := 1;
  SLen := Length(Result);
  while I <= SLen do begin
    while (I <= SLen) and (Result[I] in WordDelims) do Inc(I);
    if I <= SLen then Result[I] := toUpper(Result[I]);
    while (I <= SLen) and not (Result[I] in WordDelims) do Inc(I);
  end;
end;

function strWordCount(const S: string; WordDelims: TCharSet): Integer;
var
  SLen, I: Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do begin
    while (I <= SLen) and (S[I] in WordDelims) do Inc(I);
    if I <= SLen then Inc(Result);
    while (I <= SLen) and not(S[I] in WordDelims) do Inc(I);
  end;
end;

function strWordPosition(const N: Integer; const S: string; WordDelims: TCharSet): Integer;
var
  Count, I: Cardinal;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do begin
    {** skip over delimiters }
    while (I <= Length(S)) and (S[I] in WordDelims) do Inc(I);
    {** if we're not beyond end of S, we're at the start of a word }
    if I <= Length(S) then Inc(Count);
    {** if not finished, find the end of the current word }
    if Count <> N then
      while (I <= Length(S)) and not (S[I] in WordDelims) do Inc(I)
    else Result := I;
  end;
end;

function strCenter(const S: string; Len: Integer):string;
var i:integer;
begin
  i := Length(S);
  if i < Len then
  begin
    Result := strMake(' ', (Len div 2) - (i div 2)) + S;
    Result := Result + strMake(' ', Len - Length(Result));
  end
  else
    Result := S;
end;


function strFindPart(const HelpWilds, InputStr: string): Integer;
var
  I, J: Integer;
  Diff: Integer;
begin
  I := Pos('?', HelpWilds);
  if I = 0 then begin
    {** if no '?' in HelpWilds }
    Result := Pos(HelpWilds, InputStr);
    Exit;
  end;
  {** '?' in HelpWilds }
  Diff := Length(InputStr) - Length(HelpWilds);
  if Diff < 0 then begin
    Result := 0;
    Exit;
  end;
  {** now move HelpWilds over InputStr }
  for I := 0 to Diff do begin
    for J := 1 to Length(HelpWilds) do begin
      if (InputStr[I + J] = HelpWilds[J]) or
        (HelpWilds[J] = '?') then
      begin
        if J = Length(HelpWilds) then begin
          Result := I + 1;
          Exit;
        end;
      end
      else Break;
    end;
  end;
  Result := 0;
end;

function strIsWild(InputStr, Wilds: string; IgnoreCase: Boolean): Boolean;

 function SearchNext(var Wilds: string): Integer;
 {** looking for next *, returns position and string until position }
 begin
   Result := Pos('*', Wilds);
   if Result > 0 then Wilds := Copy(Wilds, 1, Result - 1);
 end;

var
  CWild, CInputWord: Integer; {** counter for positions }
  I, LenHelpWilds: Integer;
  MaxInputWord, MaxWilds: Integer; {** Length of InputStr and Wilds }
  HelpWilds: string;
begin
  if Wilds = InputStr then
  begin
    Result := True;
    Exit;
  end;
  repeat {** delete '**', because '**' = '*' }
    I := Pos('**', Wilds);
    if I > 0 then
      Wilds := Copy(Wilds, 1, I - 1) + '*' + Copy(Wilds, I + 2, MaxInt);
  until I = 0;
  if Wilds = '*' then
  begin {** for fast end, if Wilds only '*' }
    Result := True;
    Exit;
  end;
  MaxInputWord := Length(InputStr);
  MaxWilds := Length(Wilds);
  if IgnoreCase then
  begin {** upcase all letters }
    InputStr := AnsiUpperCase(InputStr);
    Wilds := AnsiUpperCase(Wilds);
  end;
  CInputWord := 1;
  CWild := 1;
  Result := True;
  repeat
    if InputStr[CInputWord] = Wilds[CWild] then
    begin {** equal letters }
      {** goto next letter }
      Inc(CWild);
      Inc(CInputWord);
      Continue;
    end;
    if Wilds[CWild] = '?' then
    begin {** equal to '?' }
      {** goto next letter }
      Inc(CWild);
      Inc(CInputWord);
      Continue;
    end;
    if Wilds[CWild] = '*' then
    begin {** handling of '*' }
      HelpWilds := Copy(Wilds, CWild + 1, MaxWilds);
      I := SearchNext(HelpWilds);
      LenHelpWilds := Length(HelpWilds);
      if I = 0 then
      begin
        {** no '*' in the rest, compare the ends }
        if HelpWilds = '' then Exit; {** '*' is the last letter }
        {** check the rest for equal Length and no '?' }
        for I := 0 to LenHelpWilds - 1 do
        begin
          if (HelpWilds[LenHelpWilds - I] <> InputStr[MaxInputWord - I]) and
             (HelpWilds[LenHelpWilds - I]<> '?') then
          begin
            Result := False;
            Exit;
          end;
        end;
        Exit;
      end;
      {** handle all to the next '*' }
      Inc(CWild, 1 + LenHelpWilds);
      I := strFindPart(HelpWilds, Copy(InputStr, CInputWord, MaxInt));
      if I= 0 then
      begin
        Result := False;
        Exit;
      end;
      CInputWord := I + LenHelpWilds;
      Continue;
    end;
    Result := False;
    Exit;
  until (CInputWord > MaxInputWord) or (CWild > MaxWilds);
  {** no completed evaluation }
  if (CInputWord <= MaxInputWord) or ((CWild <= MaxWilds) and (Wilds[MaxWilds] <> '*')) then
    Result := False;
end;


function strSetIsIn(CharSet:TCharSet;S:string):boolean;
var i,Len:integer;
begin
  Result := True;
  Len := Length(S);
  for I := 1 to  Len do
  if S[i] in CharSet then Exit;
  Result := False;
end;

function strTrimRight(const S: string; const ch : Char): string;
var
  I: integer;
begin
  I := Length(S);
  while (I > 0) AND (S[i] = ch) do
    Dec(i);

  Result := Copy(s, 1, i);
end;

function strTrimDupes(const S:string;Chars:TCharSet):string;
var i,c:integer;
begin
  Result := '';
  c := Length(S);
  if c = 0 then Exit;
  Result := S[1];
  for i := 2 to c do
  begin
    if (S[i] in Chars) and (S[i - 1] = S[i]) then
      Continue;
    AppendStr(Result,S[i]);
  end;
end;


function StrToCharSet(const S:string):TCharSet;
var i,j:integer;
begin
  Result := [];
  j := Length(S);
  for i := 1 to j do
    Include(Result,S[i]);
end;


function CharSetToStr(const Chs:TCharSet):string;
var i:char;
begin
  Result := '';
  for i := #0 to #255 do
    if i in Chs then
      AppendStr(Result,i);
end;


function strTrimLeft(const S : string; const ch : Char): string;
var
  I,
  len : Integer;
begin
  len := Length(S);
  I := 1;
  while (I <= len) and (S[I] = ch) do
    Inc(I);
  Result := Copy(S, I, (len + 1) - I);
end;

function strTrimAll(const S : String; const Chars : TCharSet) : String;
var i,j:integer;
begin
  j := Length(S);
  for i := 1 to j do
    if not (S[i] in Chars) then
      Result := Result + S[i];
end;

function strRPad(Str:string;Len:integer;Ch:Char):string;
begin
  Result := Str + strMake(' ',Length(Str) - Len);
end;

function strLPad(Str:string;Len:integer;Ch:Char):string;
begin
  Result := strMake(' ',Length(Str) - Len) + Str;
end;

function strHashString(Str:string;IgnoreBlanks:boolean):DWORD;
const
  LARGENUMBER=6293815;
var sum,multiple:DWORD;index:integer;P:PChar;
begin
  sum := 0;
  multiple := LARGENUMBER;
  index := 1;
  P := PChar(Str);
  while P^ <> '' do
  begin
    if Ignoreblanks then
      while (P^ <= #32) do
        Inc(P);
    sum := sum + multiple * index * Ord(P^);
    Inc(index);
    Inc(P);
    multiple := multiple * LARGENUMBER;
  end;
  Result := sum;
end;

function CalcELFHash(const S : string) : longint;
var
  G : longint;
  i : integer;
begin
  Result := 0;
  for i := 1 to length(S) do begin
    Result := (Result shl 4) + ord(S[i]);
    G := Result and longint($F0000000);
    if (G <> 0) then
      Result := Result xor (G shr 24);
    Result := Result and (not G);
  end;
end;

function strSoundex(S: string): string;
var
  Tempstring1, Tempstring2: string;
  Count: integer;
begin
  Result := '';
  if S = '' then Exit;
  Tempstring1 := '';
  Tempstring2 := '';
  S := Uppercase(S); {**Make original word uppercase}
  Appendstr(Tempstring1, S[1]); {**Use the first letter of the word}
  for Count := 2 to length(S) do
    {**Assign a numeric value to each letter, except the first}

    case S[Count] of
      'B','F','P','V': Appendstr(Tempstring1, '1');
      'C','G','J','K','Q','S','X','Z': Appendstr(Tempstring1, '2');
      'D','T': Appendstr(Tempstring1, '3');
      'L': Appendstr(Tempstring1, '4');
      'M','N': Appendstr(Tempstring1, '5');
      'R': Appendstr(Tempstring1, '6');
      {**All other letters, punctuation and numbers are ignored}
    end;

  AppendStr(Tempstring2, S[1]);

  {** Go through the result removing any consecutive duplicate numeric values. }
  for Count := 2 to length(Tempstring1) do
    if Tempstring1[Count-1] <> Tempstring1[Count] then
        Appendstr(Tempstring2,Tempstring1[Count]);
  Result := Tempstring2; {**This is the soundex value}
end;

{** return true if Word1 and Word2 sound alike }
function strSoundAlike(Word1, Word2: string): boolean;
begin
  Result := strSoundex(Word1) = strSoundex(Word2);
end;

procedure strFindInFile(Filename,Find:string;Result:TStrings);
var SFile:TStringList;i,Count:integer;
begin
  if FileExists(Filename) then
  begin
    SFile := TStringList.Create;
    SFile.LoadFromFile(Filename);
    Count := SFile.Count - 1;
    for i := 0 to Count do
      if Pos(Find,SFile[i]) > 0 then
        Result.AddObject(SFile[i],TObject(i));
    SFile.Free;
  end;
end;

const
  CRCTable : array [0..255] of {$IFDEF D4_AND_UP}Cardinal{$ELSE}longint{$ENDIF} =
  (
   $00000000, $77073096, $EE0E612C, $990951BA,
   $076DC419, $706AF48F, $E963A535, $9E6495A3,
   $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,
   $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
   $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
   $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
   $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
   $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
   $3B6E20C8, $4C69105E, $D56041E4, $A2677172,
   $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
   $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,
   $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
   $26D930AC, $51DE003A, $C8D75180, $BFD06116,
   $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
   $2802B89E, $5F058808, $C60CD9B2, $B10BE924,
   $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,
   $76DC4190, $01DB7106, $98D220BC, $EFD5102A,
   $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
   $7807C9A2, $0F00F934, $9609A88E, $E10E9818,
   $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
   $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
   $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
   $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,
   $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
   $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
   $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
   $4369E96A, $346ED9FC, $AD678846, $DA60B8D0,
   $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
   $5005713C, $270241AA, $BE0B1010, $C90C2086,
   $5768B525, $206F85B3, $B966D409, $CE61E49F,
   $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,
   $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,
   $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,
   $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
   $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
   $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
   $F00F9344, $8708A3D2, $1E01F268, $6906C2FE,
   $F762575D, $806567CB, $196C3671, $6E6B06E7,
   $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,
   $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
   $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252,
   $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
   $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60,
   $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
   $CB61B38C, $BC66831A, $256FD2A0, $5268E236,
   $CC0C7795, $BB0B4703, $220216B9, $5505262F,
   $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,
   $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,
   $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
   $9C0906A9, $EB0E363F, $72076785, $05005713,
   $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,
   $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
   $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,
   $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
   $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
   $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
   $A00AE278, $D70DD2EE, $4E048354, $3903B3C2,
   $A7672661, $D06016F7, $4969474D, $3E6E77DB,
   $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,
   $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
   $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,
   $BAD03605, $CDD70693, $54DE5729, $23D967BF,
   $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
   $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D
  );



function strCRC(const S : String):LongInt;
var
  Len,crc : LongInt;
  K : PChar;
begin
  Len := Length(S);
  K := PChar(S);
  asm
    mov       dword ptr [crc],$FFFFFFFF
@@2:
    dec       dword ptr [len]
    cmp       dword ptr [len],$FFFFFFFF
    je        @@1
    mov       eax,dword ptr [K]
    movsx     eax,byte ptr [eax]
    mov       ecx,dword ptr [crc]
    sar       ecx,$18
    xor       eax,ecx
    and       eax,$000000ff
    mov       eax,dword ptr [crctable + eax * $4]
    mov       ecx,dword ptr [crc]
    shl       ecx,$08
    xor       eax,ecx
    mov       dword ptr [crc],eax
    inc       dword ptr [K]
    jmp       @@2
@@1:
// NOTE: From here on the asm is optional...
    mov       eax,dword ptr [crc]
    not       eax
// Next line strips signed bit...
    and       eax,$7fffffff
    mov       dword ptr [crc],eax
  end;

  Result := crc;
end;


procedure strSaveToFile(const S,Filename:string;Append:boolean);
var tmpList:TStringList;
begin
  tmpList := TStringlist.Create;
  try
    if Append then
      tmpList.LoadFromFile(Filename);
    tmpList.Add(S);
    tmpList.SaveToFile(Filename);
  finally
    tmpList.Free;
  end;
end;

function strLoadFromFile(const Filename:string):string;
var tmpList:TStringList;
begin
  tmpList := Tstringlist.Create;
  try
    tmpList.LoadFromFile(Filename);
    Result := tmpList.Text;
  finally
    tmpList.Free;
  end;
end;

{** returns the Count'th word in S or empty string if not found.
  Words are separated by Delims. Count is 1 based }
function strGetWord(const S:string;Delims:TCharSet;Count:integer):string;
var chSet:string;
begin
  chSet := CharSetToStr(Delims);
  Result := strtok(S,chSet);
  Dec(Count);
  while (Result <> '') and (Count >= 0) do
  begin
    Result := strtok('',chSet);
    Dec(Count);
  end;
end;


function ScanStr(Str: PChar; Chr: Char):PChar;
begin
  Result := Str;
  if Result <> nil then
    while (Result^ <> #0) do
    begin
      if Result^ = Chr then
        Break;
      Inc(Result);
    end;
end;

function ScanRStr(Str: PChar; Chr: Char):PChar;
begin
  Result := Str;
  if Result <> nil then
  begin
    Inc(Result,StrLen(Result) - 1);
    while (Result^ <> #0) do
    begin
      if Result^ = Chr then
        Break;
      Dec(Result);
    end;
  end;
end;

function strTrimQuotes(const S:String;QuoteChar:Char):string;
var i,j:integer;
begin
  Result := '';
  j := Length(S);
  i := 1;
  while i < j do
  begin
    while (S[i] = QuoteChar) and (S[i + 1] = QuoteChar) do
    begin
      Inc(i);
      if i >= j then Exit;
    end;
    Result := Result + S[i];
  end;
end;

function EqualLen(var a,b;len:integer):integer;
asm
    PUSH ESI
    PUSH EDI
    mov esi,a
    mov edi,b
    cld
    mov eax,len
    mov ecx,eax
    rep cmpsb
    inc ecx
    sub eax,ecx
    POP EDI
    POP ESI
end;

function strCompareLen(const S, T:string;len:integer):integer;
begin
   Result := EqualLen(PChar(S)^,PChar(T)^,IMin(len,IMin(Length(S),Length(T)))) + 1;
end;

function IsValidURL(URL:string):boolean;
var i:integer;
begin
  Result := false;
  for i := 1 to Length(URL) do
  begin
    Result := URL[i] in ['A'..'Z','a'..'z',':','/','.'];
    if not Result then Break;
  end;
end;

function IsValidMailAdress(MailAdr:string):boolean;
var i:integer;
begin
  Result := false;
  for i := 1 to Length(MailAdr) do    // Iterate
  begin
    Result := MailAdr[i] in ['@','A'..'Z','a'..'z','.'];
    if not Result then Break;
  end;    // for
end;



function MatchesString(const Source, Mask:string):boolean;
function MatchMask(Source, Mask: PChar): Boolean;
    function IsPatternWild(Pattern: PChar): Boolean;
    begin
      Result := StrScan(Pattern,'*') <> nil;
      if not Result then
        Result := StrScan(Pattern,'?') <> nil;
    end;
  begin
    if StrComp(Mask,'*') = 0 then
      Result := true
    else if (Source^ = #0) and (Mask^ <> #0) then
      Result := false
    else if Source^ = #0 then
      Result := true
    else begin
      case Mask^ of
      '*': if MatchMask(Source,@Mask[1]) then
             Result := True
           else
             Result := MatchMask(@Source[1],Mask);
      '?': Result := MatchMask(@Source[1],@Mask[1]);
      else
        if Source^ = Mask^ then
          Result := MatchMask(@Source[1],@Mask[1])
        else
          Result := False;
      end;
    end;
  end;
begin
  Result := MatchMask(PChar(Source),PChar(Mask));
end;

function BMPos(const SubStr,S:String):integer;
var aPattern:TBoyerMooreSkips;
begin
  InitializeBM(SubStr,aPattern);
  Result := BoyerMoore(SubStr,S,aPattern);
end;

function BoyerMoore(const SubStr,S:string;var Skips:TBoyerMooreSkips):integer;
var iText,iNewText,iPat,lPat,lText,iSkip:integer;Ch:char;Match:boolean;
begin
  lPat := Length(SubStr);
  lText := Length(S);
  if (SubStr = '') or (lPat > lText) then
  begin
    Result := 0;
    Exit;
  end;
  Ch := SubStr[lPat];
  iText := lPat;
  while iText <= lText do
  begin
    iSkip := Skips[S[iText]];
    if Ch <> S[iText] then
      Inc(iText,iSkip)
    else
    begin
      Match := true;
      Result := iText;
      for iPat := lPat - 1 downto 1 do
      begin
        Dec(Result);
        if SubStr[iPat] <> S[Result] then
        begin
          iNewText := Result + Skips[S[Result]];
          Inc(iText,iSkip);
          if iText < iNewText then
            iText := iNewText;
          Match := false;
          Break;
        end;
      end;
      if Match then Exit;
    end;
  end;
  Result := 0;
end;

procedure InitializeBM(const SubStr:string;var Skips:TBoyerMooreSkips);
var i,j,k:integer;
begin
  k := Length(SubStr);
  if k > High(byte) then
    raise Exception.Create('Pattern too long!');
  FillChar(Skips,sizeof(Skips),k);
  j := k - 1;
  for i := 1 to k - 1 do
  begin
    Skips[SubStr[i]] := j;
    Dec(j);
  end;
end;

function BMPosLarge(const SubStr,S:string):integer;
var aPattern:TBoyerMooreSkipsLarge;
begin
  InitializeBMLarge(SubStr,aPattern);
  Result := BoyerMooreLarge(SubStr,S,aPattern);
end;

function BoyerMooreLarge(const SubStr,S:string;var Skips:TBoyerMooreSkipsLarge):integer;
var iText,iNewText,iPat,lPat,lText,iSkip:integer;Ch:char;Match:boolean;
begin
  lPat := Length(SubStr);
  lText := Length(S);
  if (SubStr = '') or (lPat > lText) then
  begin
    Result := 0;
    Exit;
  end;
  Ch := SubStr[lPat];
  iText := lPat;
  while iText <= lText do
  begin
    iSkip := Skips[Ord(S[iText])];
    if Ch <> S[iText] then
      Inc(iText,iSkip)
    else
    begin
      Match := true;
      Result := iText;
      for iPat := lPat - 1 downto 1 do
      begin
        Dec(Result);
        if SubStr[iPat] <> S[Result] then
        begin
          iNewText := Result + Skips[Ord(S[Result])];
          Inc(iText,iSkip);
          if iText < iNewText then
            iText := iNewText;
          Match := false;
          Break;
        end;
      end;
      if Match then Exit;
    end;
  end;
  Result := 0;
end;

procedure InitializeBMLarge(const SubStr:string;var Skips:TBoyerMooreSkipsLarge);
var i,j,k:integer;
begin
  k := Length(SubStr);
  if k > High(Word) then
    raise Exception.Create('Pattern too long!');
  FillChar(Skips,sizeof(Skips),k);
  j := k - 1;
  for i := 1 to k - 1 do
  begin
    Skips[Ord(SubStr[i])] := j;
    Dec(j);
  end;
end;

procedure IndexToRowCol(Index:integer;S:TStrings;var Row,Col:integer);
var Count:integer;
begin
  Row := 0;
  Col := 0;
  if not Assigned(S) or (S.Count < 1) then Exit;
  Count := 0;
  S.BeginUpdate;
  try
    while Row <= S.Count - 1 do
    begin
      Count := Count + Length(S[Row]) + 2;
      if Count > Index then
      begin
        Col := Length(S[Row]) - Count + Index + 2;
        Exit;
      end;
      Inc(Row);
    end;
  finally
    S.EndUpdate;
  end;
end;

function RowColToIndex(Row,Col:integer;S:TStrings):integer;
begin
  Result := 0;
  if not Assigned(S) or (Row > S.Count - 1) or (Row < 0) then Exit;
  if (Col > Length(S[Row])) or (Col < 0) then Exit;
  S.BeginUpdate;
  try
    Dec(Row);
    while Row >= 0 do
    begin
      Result := Result + Length(S[Row]) + 2;
      Dec(Row);
    end;
    Result := Result + Col;
  finally
    S.EndUpdate;
  end;
end;

end.

