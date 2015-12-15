{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13147: EQIniStrings.pas
{
{   Rev 1.1    2003-12-29 16:37:16  peter
}
{
{   Rev 1.0    2003-03-20 14:03:28  peter
}
{
{   Rev 1.0    2003-03-17 10:14:20  Supervisor
}
{**
  @copyright
    Copyright © 1999 by EQ Soft AB; all rights reserved

  @author
    P3 (peter.thornqvist@eq.soft-se)
  @desc
    A class that works just like TIniFile, but can be accessed as a TStrings
    (using the Strings property) class. Has the same methods and properties as
    TIniFile, with the following differences and additions:
    * The Filename in the constructor is optional: if invalid or empty, the class
      starts out with an empty Strings property
    * No changes to the internl representation are implicitly written back to the
      file unless SaveToFile (or SaveToStream with a TFileStream argument) is called
    * Supports LoadFromFile, LoadFromStream, SaveToFile, SaveToStream methods
    * Filename is read-only and is updated when the content of the class is saved or loaded
      to / from a file.
    * Although Strings is a read-only property, you can replace its content by
      assigning to it, like this:
        EQIniStrings.Strings.Assign(ListBox1.Items);
    * The class does not cache any information but instead makes an explicit search
      at every insert / delete / search event. This might slow down performance
      (especially on large files), but avoids any problems due to synchronizing
      errors.
    * The TIniFile class raises Exceptions on different occasions, this class *does not*
      (unless you try stupid things like accessing a Strings index > Count - 1...)
    * If you don't set a path for a TIniFile, it will be created in the Windows
      directory by default. TEQIniStrings saves the file in the current directory
    * Starting with D4, a new class TMemIniFile is available. This class works exactly
      like this one but trades larger size for (possibly) higher speed. It works
      by storing each sections data in nested TStrings objects.


  @history
    990321 - created unit

}

unit EQIniStrings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls;

type
  TEQIniStrings = class(TStringlist)
  private
    { Private declarations }
    FStrings: TStringList;
    FFilename: string;
    FStripComments: Boolean;
    FPreFixSectionString: string;
    function GetStrings: TStrings;
    procedure SetPreFixSectionString(const Value: string);
  protected
    function FindSection(const Section: string; var StartIndex, EndIndex: integer): boolean; virtual;
    function FindName(const Name: string; var StartIndex: integer): boolean; virtual;
  public
    { Public declarations }
    constructor Create(const Filename: string); virtual; // Filename is optional
    destructor Destroy; override;
    procedure SaveToFile(const Filename: string); override;
    procedure LoadFromFile(const Filename: string); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure WriteString(const Section, Name: string; Value: string); virtual;
    procedure WriteInteger(const Section, Name: string; Value: Integer); virtual;
    procedure WriteBool(const Section, Name: string; Value: Boolean); virtual;
    procedure WriteDate(const Section, Name: string; Value: TDateTime); virtual;
    procedure WriteDateTime(const Section, Name: string; Value: TDateTime); virtual;
    procedure WriteFloat(const Section, Name: string; Value: Double); virtual;
    procedure WriteTime(const Section, Name: string; Value: TDateTime); virtual;
    procedure WriteFont(const Section, Name: string; Value: TFont); virtual;
    procedure WriteRect(const Section, Name: string; Value: TRect); virtual;
    procedure ReadSection(const Section: string; Strings: TStrings); virtual;
    procedure ReadSectionNames(const Section: string; Strings: TStrings); virtual;
    procedure ReadSections(Strings: TStrings); virtual;
    procedure ReadSectionValues(const Section: string; Strings: TStrings); virtual;
    procedure EraseSection(const Section: string); virtual;
    procedure DeleteKey(const Section, Name: string); virtual;

    function ReadString(const Section, Name: string; Default: string): string; virtual;
    function ReadInteger(const Section, Name: string; Default: Integer): Integer; virtual;
    function ReadBool(const Section, Name: string; Default: Boolean): Boolean; virtual;
    function SectionExists(const Section: string): Boolean; virtual;
    function ReadDate(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    function ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    function ReadFloat(const Section, Name: string; Default: Double): Double; virtual;
    function ReadTime(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    function ReadFont(const Section, Name: string; Default: TFont): TFont; virtual;
    function ReadRect(const Section, Name: string; Default: TRect): TRect; virtual;
    function ValueExists(const Section, Name: string): Boolean; virtual;
    property Strings: TStrings read GetStrings;
    property Filename: string read FFilename;
    property StripComments: Boolean read FStripComments write FStripComments;
    property PreFixSectionString: string read FPreFixSectionString write SetPreFixSectionString;
  end;

function FontStylesToString(Styles: TFontStyles): string;
function StringToFontStyles(Styles: string): TFontStyles;
procedure StrTokenize(const S: string; Delims: TSysCharSet; Strings: TStrings);

implementation

function FontStylesToString(Styles: TFontStyles): string;
begin
  Result := '';
  if fsBold in Styles then Result := Result + 'B';
  if fsItalic in Styles then Result := Result + 'I';
  if fsUnderline in Styles then Result := Result + 'U';
  if fsStrikeOut in Styles then Result := Result + 'S';
  if Result = '' then Result := 'X';
end;

function StringToFontStyles(Styles: string): TFontStyles;
begin
  Result := [];
  if Pos('B', UpperCase(Styles)) > 0 then Include(Result, fsBold);
  if Pos('I', UpperCase(Styles)) > 0 then Include(Result, fsItalic);
  if Pos('U', UpperCase(Styles)) > 0 then Include(Result, fsUnderline);
  if Pos('S', UpperCase(Styles)) > 0 then Include(Result, fsStrikeOut);
end;

{**$IFOPT J-}
  {**$DEFINE J_CHANGED}
  {**$J+}// assignable typed constants ON
{**$ENDIF}

function strtok(Search, Delim: string): string;
var
  i: integer;
  Len: integer;
  PrvStr: string;
begin
  i := 1;
  Len := 0;
  prvStr := '';

  Result := '';
  if Search <> '' then
  begin
    I := 1;
    PrvStr := Search;
    Len := Length(PrvStr);
  end;
  if PrvStr = '' then Exit;
  while (Pos(PrvStr[i], Delim) > 0) and (i <= Len) do
    Inc(I);
  while (Pos(PrvStr[i], Delim) = 0) and (i <= Len) do
  begin
    Result := Result + PrvStr[i];
    Inc(i);
  end;
end;

function CharSetToStr(const Chs: TSysCharSet): string;
var i: char;
begin
  Result := '';
  for i := #0 to #255 do
    if i in Chs then
      AppendStr(Result, i);
end;

{**$IFDEF J_CHANGED}
  {**$J-}
  {**$UNDEF J_CHANGED}
{**$ENDIF}

procedure StrTokenize(const S: string; Delims: TSysCharSet; Strings: TStrings);
var tmp, d: string;
begin
  d := CharSetToStr(Delims);
  tmp := strtok(S, d);
  while tmp <> '' do
  begin
    Strings.Add(tmp);
    tmp := strtok('', d);
  end;
end;

{ TEQIniStrings }

constructor TEQIniStrings.Create(const Filename: string);
begin
  inherited Create;
  FStrings := TStringlist.Create;
  if FileExists(Filename) then
  begin
    FStrings.LoadFromFile(FIlename);
    FFilename := Filename;
  end;
end;

procedure TEQIniStrings.DeleteKey(const Section, Name: string);
var S, E: integer;
begin
  if FindSection(Section, S, E) and FindName(Name, S) then
    FStrings.Delete(S);
end;

destructor TEQIniStrings.Destroy;
begin
  FStrings.Free;
  inherited Destroy;
end;

procedure TEQIniStrings.EraseSection(const Section: string);
var i: integer;
begin
  i := FStrings.IndexOf(Format('[%s]', [Section]));
  if i > -1 then
  begin
    FStrings.Delete(i);
    while (i < FStrings.Count) do
    begin
      if (Length(FStrings[i]) > 0) and (FStrings[i][1] = '[') then
        Break;
      FStrings.Delete(i);
    end;
  end;
end;

function TEQIniStrings.FindSection(const Section: string; var StartIndex,
  EndIndex: integer): boolean;
begin
  StartIndex := FStrings.IndexOf(Format('[%s]', [Section]));
  Result := StartIndex > -1;
  if Result then
  begin
    EndIndex := StartIndex + 1;
    while EndIndex < FStrings.Count do
    begin
      if Pos('[', FStrings[EndIndex]) = 1 then
        Exit;
      Inc(EndIndex);
    end;
  end;
end;

function TEQIniStrings.FindName(const Name: string; var StartIndex: integer): boolean;
var i: integer;
begin
  Result := false;
  i := StartIndex + 1;
  while i < FStrings.Count do
  begin
    if (Length(FStrings[i]) > 0) and (FStrings[i][1] = '[') then Exit;
    if AnsiCompareText(FStrings.Names[i], Name) = 0 then
    begin
      StartIndex := i;
      Result := true;
      Exit;
    end;
    Inc(i);
  end;
end;

procedure TEQIniStrings.LoadFromFile(const Filename: string);
begin
  try
    if FileExists(Filename) then
      FStrings.LoadFromFile(Filename);
  except
  end;
  FFilename := Filename;
end;

procedure TEQIniStrings.LoadFromStream(Stream: TStream);
begin
  FStrings.LoadFromStream(Stream);
end;

function TEQIniStrings.ReadBool(const Section, Name: string;
  Default: Boolean): Boolean;
begin
  Result := ReadInteger(Section, Name, Ord(Default)) <> 0;
end;

function TEQIniStrings.ReadDate(const Section, Name: string;
  Default: TDateTime): TDateTime;
begin
  Result := Trunc(ReadFloat(Section, Name, Default));
end;

function TEQIniStrings.ReadDateTime(const Section, Name: string;
  Default: TDateTime): TDateTime;
begin
  Result := ReadFloat(Section, Name, Default);
end;

function TEQIniStrings.ReadFloat(const Section, Name: string;
  Default: Double): Double;
begin
  Result := StrToFloat(ReadString(Section, Name, FloatToStr(Default)));
end;

function TEQIniStrings.ReadInteger(const Section, Name: string;
  Default: Integer): Longint;
var
  IntStr: string;
begin
  IntStr := ReadString(Section, Name, '');
  if (Length(IntStr) > 2) and (IntStr[1] = '0') and
    ((IntStr[2] = 'X') or (IntStr[2] = 'x')) then
    IntStr := '$' + Copy(IntStr, 3, Maxint);
  Result := StrToIntDef(IntStr, Default);
end;

procedure TEQIniStrings.ReadSection(const Section: string;
  Strings: TStrings);
var S, E: integer;
begin
  if FindSection(FPreFixSectionString + Section, S, E) then
  begin
    Inc(S);
    while (S < E) do
    begin
      if not StripComments or ((Length(FStrings[S]) > 0) and (Pos(';', FStrings[S]) <> 1)) then
        Strings.Add(FStrings[S]);
      Inc(S);
    end;
  end
  else
  begin
    if FindSection(Section, S, E) then
    begin
      Inc(S);
      while (S < E) do
      begin
        if not StripComments or ((Length(FStrings[S]) > 0) and (Pos(';', FStrings[S]) <> 1)) then
          Strings.Add(FStrings[S]);
        Inc(S);
      end;
    end;
  end;
end;

procedure TEQIniStrings.ReadSectionNames(const Section: string;
  Strings: TStrings);
var S, E: integer;
begin
  if FindSection(Section, S, E) then
  begin
    Inc(S);
    while S < E do
    begin
      if not StripComments or ((Length(FStrings[S]) > 0) and (Pos(';', FStrings[S]) <> 1)) then
        Strings.Add(FStrings.Names[S]);
      Inc(S);
    end;
  end;
end;

procedure TEQIniStrings.ReadSections(Strings: TStrings);
var i: integer;
begin
  for i := 0 to FStrings.Count - 1 do
    if Pos('[', FStrings[i]) = 1 then
      Strings.Add(Copy(FStrings[i], 2, Length(FStrings[i]) - 2));
end;

procedure TEQIniStrings.ReadSectionValues(const Section: string;
  Strings: TStrings);
var S, E: integer;
begin
  if FindSection(Section, S, E) then
  begin
    Inc(S);
    while S < E do
    begin
      if not StripComments or ((Length(FStrings[S]) > 0) and (Pos(';', FStrings[S]) <> 1)) then
        Strings.Add(Copy(FStrings[S], Pos('=', FStrings[S]) + 1, MaxInt));
      Inc(S);
    end;
  end;
end;

function TEQIniStrings.ReadString(const Section, Name: string;
  Default: string): string;
var S, E: integer;
begin
  Result := '';
  if FindSection(Section, S, E) and FindName(Name, S) then
    Result := FStrings[S];
  if (Result <> '') and (Pos('=', Result) > 0) then
    Result := Copy(Result, Pos('=', Result) + 1, MaxInt)
  else
    Result := Default;
end;

function TEQIniStrings.ReadTime(const Section, Name: string;
  Default: TDateTime): TDateTime;
begin
  Result := Frac(ReadFloat(Section, Name, Default));
end;

procedure TEQIniStrings.SaveToFile(const Filename: string);
begin
  FStrings.SaveToFile(Filename);
  FFilename := Filename;
end;

procedure TEQIniStrings.SaveToStream(Stream: TStream);
begin
  FStrings.SaveToStream(Stream);
end;

function TEQIniStrings.SectionExists(const Section: string): Boolean;
begin
  Result := FStrings.IndexOf(Format('[%s]', [Section])) > -1;
end;

function TEQIniStrings.ValueExists(const Section, Name: string): Boolean;
var S, E: integer;
begin
  Result := FindSection(Section, S, E) and FindName(Name, S);
end;

procedure TEQIniStrings.WriteBool(const Section, Name: string;
  Value: Boolean);
begin
  WriteInteger(Section, Name, integer(Value));
end;

procedure TEQIniStrings.WriteDate(const Section, Name: string;
  Value: TDateTime);
begin
  WriteFloat(Section, Name, Trunc(Value));
end;

procedure TEQIniStrings.WriteDateTime(const Section, Name: string;
  Value: TDateTime);
begin
  WriteFloat(Section, Name, Value);
end;

procedure TEQIniStrings.WriteFloat(const Section, Name: string;
  Value: Double);
begin
  WriteString(Section, Name, FloatToStr(Value));
end;

procedure TEQIniStrings.WriteInteger(const Section, Name: string;
  Value: Integer);
begin
  WriteFloat(Section, Name, Value);
end;

procedure TEQIniStrings.WriteString(const Section, Name: string;
  Value: string);
var S, E: integer;
begin
  if not FindSection(Section, S, E) then
    S := FStrings.Add(Format('[%s]', [Section]));
  if FindName(Name, S) then
    FStrings[S] := Format('%s=%s', [Name, Value])
  else
    FStrings.Insert(S + 1, Format('%s=%s', [Name, Value]));
end;

procedure TEQIniStrings.WriteTime(const Section, Name: string;
  Value: TDateTime);
begin
  WriteFloat(Section, Name, Frac(Value));
end;

function TEQIniStrings.GetStrings: TStrings;
begin
  Result := FStrings;
end;

function TEQIniStrings.ReadFont(const Section, Name: string;
  Default: TFont): TFont;
var S: string;
begin
  Result := Default;
  S := ReadString(Section, Name, '');
  if S = '' then Exit;
  Result.Name := Copy(S, 1, Pos(';', S) - 1);
  S := Copy(S, Pos(';', S) + 1, MaxInt);

  Result.Size := StrToIntDef(Copy(S, 1, Pos(';', S) - 1), 8);
  S := Copy(S, Pos(';', S) + 1, MaxInt);

  Result.Style := StringToFontStyles(Copy(S, 1, Pos(';', S) - 1));
  S := Copy(S, Pos(';', S) + 1, MaxInt);

  Result.Color := StrToIntDef(Copy(S, 1, Pos(';', S) - 1), 0);
  S := Copy(S, Pos(';', S) + 1, MaxInt);
end;

procedure TEQIniStrings.WriteFont(const Section, Name: string;
  Value: TFont);
var S: string;
begin
  if Value = nil then
    S := ''
  else
    S := Format('%s;%d;%s;%d', [Value.Name, Value.Size, FontStylesToString(Value.Style), Value.Color]);
  WriteString(Section, Name, S);
end;

function TEQIniStrings.ReadRect(const Section, Name: string;
  Default: TRect): TRect;
var S: string; List: TStringlist;
begin
  S := ReadString(Section, Name, '');
  if S = '' then
    Result := Default
  else
  begin
    List := TStringlist.Create;
    try
      strTokenize(S, [';'], List);
      if List.Count = 4 then
      begin
        with Result do
        begin
          Left := StrToInt(List[0]);
          Top := StrToInt(List[1]);
          Right := StrToInt(List[2]);
          Bottom := StrToInt(List[3]);
        end;
      end
      else
        Result := Default;
    finally
      List.Free;
    end;
  end;
end;

procedure TEQIniStrings.WriteRect(const Section, Name: string; Value: TRect);
begin
  with Value do
    WriteString(Section, Name, Format('%d;%d;%d;%d', [Left, Top, Right, Bottom]));
end;

procedure TEQIniStrings.SetPreFixSectionString(const Value: string);
begin
  FPreFixSectionString := Value;
end;

end.

