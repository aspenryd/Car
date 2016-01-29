{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12495: EQFormatEdit.pas 
{
{   Rev 1.0    2003-03-19 17:34:52  peter
}
{**
  Copyright © 1997 by EQ soft; all rights reserved

  Namn:
    TFormatEdit

  Beskrivning:
    En editkontroll med möjlighet att begränsa inmatning till fördefinierade typer.
    Om RestrictInput = true visas bara giltiga tecken i kontrollen
    'Format' anger giltiga format och endast tecken med
             giltigt format accepteras vid inmatning.
             Typer: alla, datum, heltal, flyttal,hexadecimala,
             bokstäver, bokstäver + siffror, "vecka" (enl. format YWWD)


  Status:
    * när man använder formatet efWeek, sätts RestrictInput := false och
    man måste anropa IsValidInput för att få reda på ifall inmatningen är på rätt form.
    Om den är det, visas aktuellt år och datum i kontrollen annars händer ingenting.
    Om du senare byter tillbaka till något annat format, måste du sätta
    RestrictInput := true för att hindra ogiltiga tecken från att dyka upp i kontrollen.

    * EnterAsTab - sätt till true om Enter tangenten skall behandlas som TAB tangent

  Historia:
    971020: första versionen
    980515: EnterAsTab

  Programmerare:
    Peter Thörnqvist (peter.thornqvist@eq-soft.se)

}
unit EQFormatEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls;

type
  TEditFormat=(efAll, efDate, efWeek, efInteger, efFloat, efHex, efAlpha, efAlphaNum);
  TEQFormatEdit = class(TEdit)
  private
    { Private declarations }
    FFormat:TEditFormat;
    FRestrict:boolean;
    FAsTab:boolean;
    procedure SetFormat(Value:TEditFormat);
    function IsValidChar(S:String;Key:Char):boolean;
    function GetIsValid:boolean;
    procedure MakeValid;
    procedure WMPaste(var Message:Tmessage); message WM_PASTE;
    procedure SetText(Value:TCaption);
    function GetText:TCaption;
  protected
    { Protected declarations }
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure KeyPress(var Key:Char);override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;
  published
    { Published declarations }
    property EnterAsTab:boolean read FAsTab write FAsTab;
    property Format:TEditFormat read FFormat write SetFormat default efAll;
    property RestrictInput:boolean read FRestrict write FRestrict default false;
    property IsValidInput:boolean read GetIsValid;
    property Text:TCaption read GetText write SetText;
  end;

procedure Register;

implementation

type
  THackControl=class(TWinControl);


function IsValidInt(S:String;Key:char):boolean;
begin
  if Key > #31 then
    S := S + Key;
  Result := true;
  try
    StrToInt(S);
  except
    Result := false;
  end;
end;

function IsValidFloat(S:String;Key:char):boolean;
begin
  if Key > #31 then
    S := S + Key;
  Result := true;
  try
    StrToFloat(S);
  except
    Result := false;
  end;
end;

function IsValidDate(S:string;Key:char):boolean;
begin
  if Key > #31 then
    S := S + Key;
  Result := true;
  try
    StrToDate(S);
  except
    Result := false;
  end;
end;

{ konvertera år, vecka, dag till TDatetime }
function WeekToDate(Y,W,D:integer):TDateTime;
var FirstWeek,FirstDayOfWeek:integer; FirstDay:TDateTime;
begin
  FirstDay := EncodeDate(Y,1,1);
  FirstDayOfWeek := DayOfWeek(FirstDay);

  if FirstDayOfWeek = 1 then
    FirstDayOfWeek := 7 { Amerika börjar på Söndag... }
  else
    Dec(FirstDayOfWeek);

  if FirstDayOfWeek < 5 then
    FirstWeek := 1
  else
    FirstWeek := 0;

  Result := 7 * (W - FirstWeek) + D - FirstDayOfWeek + FirstDay;
end;

function GetDecade(InYear:integer):integer;
var ThisYear,FirstYear,LastYear,TestYear,D1,Dummy:word;
begin
  DecodeDate(Now,ThisYear,D1,Dummy);
  FirstYear := ThisYear - 4;
  LastYear := ThisYear + 5;

  TestYear := ((ThisYear div 10) - 1) * 10 + InYear;

  while (TestYear < LastYear) do
  begin
    if (TestYear >= FirstYear) and (TestYear <=LastYear) then
      Break;
    Inc(TestYear,10);
  end;
  Result := TestYear;
end;

procedure TEQFormatEdit.MakeValid;
var S:String;i:integer;
begin
  S := '';
  for i := 1 to Length(Text) do
    if IsValidChar(S,Text[i]) then
      S := S + Text[i];
  inherited Text := S;
end;

constructor TEQFormatEdit.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FFormat := efAll;
  FRestrict := False;
end;

destructor TEQFormatEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TEQFormatEdit.WMPaste(var Message:Tmessage);
begin
  inherited;
  MakeValid;
end;

procedure TEQFormatEdit.SetText(Value:TCaption);
begin
  inherited Text := Value;
  MakeValid;
end;

function TEQFormatEdit.GetText:TCaption;
begin
  Result := inherited Text;
end;

function TEQFormatEdit.IsValidChar(S:string;Key:Char):boolean;
const
  ControlCodes=[#0..#31];
  IntCodes = ControlCodes + ['0'..'9'];
  FloatCodes = IntCodes;
  AlphaCodes = ControlCodes + ['A'..'Z','a'..'z'];
  DateCodes = IntCodes - ['+'];
  HexCodes = IntCodes + ['A'..'F','a'..'f'];
  AlphaNumCodes = IntCodes + AlphaCodes;
begin
  case FFormat of
    efAll:      Result := True;
    efWeek:
    begin
      FRestrict := False;
      Result := true;
    end;
    efDate:     Result := (Key in DateCodes);
    efInteger:  Result := (Key in IntCodes) or ((Key = '+') and (Pos('+',S) = 0)) or ((Key = '-') and (Pos('-',S) = 0));
    efFloat:    Result := (Key in IntCodes) or ((Key = DecimalSeparator)
                             and (Pos(DecimalSeparator,S) = 0))
                             or ((Key in ['E','e']) and (Pos('E',UpperCase(S)) = 0))
                             or ((Key = '+') and (Pos('+',S) = 0)) or ((Key = '-') and (Pos('-',S) = 0));
    efHex:      Result := (Key in HexCodes);
    efAlpha:    Result := (Key in AlphaCodes);
    efAlphaNum: Result := (Key in AlphaNumCodes);
  else
    Result := False;
  end;
end;

function TEQFormatEdit.GetIsValid:boolean;
var Year:integer;Y,W,D:string;TrueDate:TDateTime;
begin
  Result := false;
  if csDesigning in ComponentState then Exit;
  case FFormat of
    efWeek:
    begin
      if Length(Text) < 4 then Exit;
      { format: YWWD }
      Y := Copy(Text,1,1);
      W := Copy(Text,2,2);
      D := Copy(Text,4,1);
      if StrToInt(W) > 53 then Exit;
      if StrToInt(D) > 7 then Exit;
      Year := GetDecade(StrToInt(Y));
      TrueDate := WeekToDate(Year,StrToInt(W),StrToInt(D));
      Text := DateToStr(TrueDate);
    end;
    else
    begin
      for Year := 1 to Length(Text) do
      begin
        Result := IsValidChar(Text,Text[Year]);
        if not Result then Exit;
      end;
    end;
   end;
end;

function GetFirstParent(P:TWinControl):TWinControl;
begin
  Result := nil;
  while Assigned(P) do
  begin
    Result := P;
    P := P.Parent;
  end;    // while
end;

procedure TEQFormatEdit.KeyDown(var Key: Word; Shift: TShiftState);
var P:TWinControl;
begin
  if FAsTab and (Key = VK_RETURN) and (Parent is TWinControl) then
  begin
    Key := 0;
    P := GetFirstParent(THackControl(Parent));
    if Assigned(P) then
      THackControl(P).SelectNext(self,not (ssShift in Shift),false);
    Exit;
  end;
  inherited KeyDown(Key,Shift);
end;


procedure TEQFormatEdit.KeyPress(var Key:Char);
begin
  if (not IsValidChar(Text,Key) and FRestrict) or ((Key = #13) and (FAsTab) and (Parent is TWinControl)) then
    Key := #0;
  inherited;
end;


procedure TEQFormatEdit.SetFormat(Value:TEditFormat);
begin
  if FFormat <> Value then
  begin
    FFormat := Value;
    { radera ev. text }
    MakeValid;
  end;
end;

procedure Register;
begin
  RegisterComponents('EQ-Soft', [TEQFormatEdit]);
end;


end.
