{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12899: utilsDateTime.pas 
{
{   Rev 1.0    2003-03-19 17:37:56  peter
}
unit utilsDateTime;
{**

Date and time utilities
Copyright © 1997 by EQ Soft AB; all rights reserved

@author P3 (peter.thornqvist@eq-soft.se)
URL: http://www.eq-soft.se/delphistuff
@version 1.0
}

interface
uses
  SysUtils;

{$I VER.INC }

const
  daySun = 1;
  dayMon = 2;
  dayTue = 3;
  dayWed = 4;
  dayThu = 5;
  dayFri = 6;
  daySat = 7;

  mJan   = 1;
  mFeb   = 2;
  mMar   = 3;
  mApr   = 4;
  mMay   = 5;
  mJun   = 6;
  mJul   = 7;
  mAug   = 8;
  mSep   = 9;
  mOct   = 10;
  mNov   = 11;
  mDec   = 12;

{** converts a Delphi 1 date to a TDateTime compatible with later versions of Delphi }
function dateFromDelphi1(aDate:TDateTime):TDateTime;
{** converts a TDateTime to a delphi 1 compatible TDateTime }
function dateToDelphi1(aDate:TDateTime):TDateTime;
{** returns first day of year }
function dateFirstDayOfYear(D: TDateTime): TDateTime;
{** returns last day of year }
function dateLastDayOfYear(D: TDateTime): TDateTime;
{** returns the first day of prev month }
function dateFirstDayOfPrevMonth(aDate:TDateTime): TDateTime;
{** returns the last day of prev month }
function dateLastDayOfPrevMonth(aDate:TDateTime): TDateTime;
{** returns the first day of next month }
function dateFirstDayOfNextMonth(aDate:TDateTime): TDateTime;
{** returns day part of ADate }
function dateDay(ADate: TDateTime): Word;
{** returns month part of ADate }
function dateMonth(ADate: TDateTime): Word;
{** @return year part of ADate }
function dateYear(ADate: TDateTime): Word;
{** Increment ADate with Days,Months and Years
  Decrement by using negative values }
function dateIncDate(ADate: TDateTime; Days, Months, Years: Integer): TDateTime;
{** Increment ADate with Delta days. Use negative values to decrement ADate }
function dateIncDay(ADate: TDateTime; Delta: Integer): TDateTime;
{** Increment ADate with Delta months. Use negative values to decrement ADate }
function dateIncMonth(ADate: TDateTime; Delta: Integer): TDateTime;
{** Increment ADate with Delta years. Use negative values to decrement ADate }
function dateIncYear(ADate: TDateTime; Delta: Integer): TDateTime;
{** returns true if ADate is valid }
function dateValidDate(ADate: TDateTime): Boolean;
{** Returns Difference between Date1 and Date2 in Days, Months and Years
  Values are always positive }
procedure dateDiff(Date1, Date2: TDateTime; var Days, Months, Years: Word);
{** returns number of months between Date1 and Date2 }
function dateMonthsBetween(Date1, Date2: TDateTime): Double;
{** returns number of days between Date1 and Date2 }
function dateDayInterval(Date1, Date2: TDateTime): Longint;
{** increment ATime by specified values }
function dateIncTime(ATime: TDateTime; Hours, Minutes, Seconds, MSecs: Integer): TDateTime;
{** increment ATime by specified values }
function dateIncHour(ATime: TDateTime; Delta: Integer): TDateTime;
{** increment ATime by specified values }
function dateIncMinute(ATime: TDateTime; Delta: Integer): TDateTime;
{** increment ATime by specified values }
function dateIncSecond(ATime: TDateTime; Delta: Integer): TDateTime;
{** increment ATime by specified values }
function dateIncMSec(ATime: TDateTime; Delta: Integer): TDateTime;
{** returns Week number that D falls in (US valid only)  }
function dateWeekOfYear(D: TDateTime): integer; { Armin Hanisch }
{** Returns date of the first monday of week 1 for passed year.
  NOTE: this date can be in the preceeding year }
function dateFirstWeek(aYear:integer):TDateTime;
{** returns Date for Count'th aDay in aYear / aMonth.
  Example:
    dateForDayOfMonth(2,1999,1,dayMon) returns the date for the second monday
    in january 1999 }
function dateForDayOfMonth(aCount,aYear,aMonth,aDay:integer):TDateTime;

{** Decodes aDate into aYear, aWeek and aDay.
  aDay is a value in the range 1 - 7: Monday to Sunday
}
procedure DecodeWeek(aDate:TDateTime;var aYear,aWeek,aDay:integer);

{** Encodes aYear, aWeek and aDay into a TDateTime variable
    aDay should be in the range 1 - 7: Monday to Sunday }
function EncodeWeek(aYear,aWeek,aDay:integer):TDateTime;


{** returns the day number (1~366) of the year }
function dateDayOfYear(D: TDateTime): integer;
{** returns day of week, 0 is Sunday }
function dateDayOfWeek(D: TDateTime): integer;
function GetFirstDate(Datum : TDateTime; PlusYear : Integer) : TDateTime;
function GetFirstWeekDateInYear(Datum : TDateTime; PlusYear : Integer) : TDateTime;
{** returns date in current year that corresponds to given week and day }
function GetDateFromWeek(WeekNo, Day : Integer) : TDateTime;
{** Calculates calendar week assuming:
    - Monday is the 1st day of the week.
    - The 1st calendar week is the 1st week
      of the year that contains a Thursday (ISO standard).
      If result is 53, then previous year is assumed.
}
function dateCalendarWeek(aDate: TDateTime): integer;

{** Calculates the four-digit year from a two-digit year using the
  TwoDigitYearCenturyWindow variable:
  if TwoDigitYearCenturyWindow is 0, values between 0-99 are placed in the current century,
  all others are returned unchanged.
  If TwoDigitYearCenturyWindow > 0 then this value is subtracted from the current year and
  the resulting value is used as a pivot to determine what century to use:
  if (CurrentCentury + aYear) is less than the pivot, it is placed in the next century,
  otherwise it is placed in this century
  Example:
    TwoDigitYearCenturyWindow is 50
    CurrentYear is 1999
    Pivot becomes (19)99 - (19)50 := (19)49
    if aYear is 49 or less, Result = 2049 or less
    if aYear is 50 or more, Result = 1950 or more
  NOTE:
   If you are running Delphi 3 or less, the TwoDigitYearCenturyWindow
   variable is declared in this unit and initially set to 0
}
function dateFourDigitYear(const aYear:integer):integer;


{** returns a formatted string that contains the wanted date:
  Allowed formats are:
  d         - today
  d + 1     - tomorrow
  d - 1     - yesterday
  v5        - next weekday 5
  v015      - next weekday 5 week 1 
  v00015    - next year 00 day 5 week 1
  v2000015  - day 5 week 1 year 2000
  06        - next monthday 6
  -06       - prev monthday 6
  0606      - next month 6, day 6
  -0606     - prev month 6, day 6
  990606    - next year 99 month 6 day 6
  -990606   - prev year 99 month 6 day 6
  Weekdays are in the range 1 to 7: Monday to Sunday
  Prefixes (v and d) is case-insensitive
  Prefix v can be replaced by w
  If any error occurs, Default is returned
  Invalid characters are stripped before validation
}
function GetFormattedDate(const Str,Default:string):string;

{$IFDEF D3_AND_DOWN }
var
  TwoDigitYearCenturyWindow:word = 0;
{$ENDIF }
    
implementation


function dateFromDelphi1(aDate:TDateTime):TDateTime;
begin
  Result := aDate - 693594;
end;

function dateToDelphi1(aDate:TDateTime):TDateTime;
begin
  Result := aDate + 693594;
end;

function dateFirstDayOfYear(D: TDateTime): TDateTime;
var
  Year,Month,Day : Word;
begin
  DecodeDate(D,Year,Month,Day);
  Result:=EncodeDate(Year,1,1);
end;

function dateLastDayOfYear(D: TDateTime): TDateTime;
var
  Year,Month,Day : Word;
begin
  DecodeDate(D,Year,Month,Day);
  Result:=EncodeDate(Year,12,31);
end;

function dateFirstDayOfNextMonth(aDate:TDateTime): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(aDate, Year, Month, Day);
  Day := 1;
  if Month < 12 then Inc(Month)
  else begin
    Inc(Year);
    Month := 1;
  end;
  Result := EncodeDate(Year, Month, Day);
end;

function dateFirstDayOfPrevMonth(aDate:TDateTime): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(aDate, Year, Month, Day);
  Day := 1;
  if Month > 1 then Dec(Month)
  else begin
    Dec(Year);
    Month := 12;
  end;
  Result := EncodeDate(Year, Month, Day);
end;

function dateLastDayOfPrevMonth(aDate:TDateTime): TDateTime;
var
  D: TDateTime;
  Year, Month, Day: Word;
begin
  D := dateFirstDayOfPrevMonth(aDate);
  DecodeDate(D, Year, Month, Day);
  Day := MonthDays[IsLeapYear(Year), Month];
  Result := EncodeDate(Year, Month, Day);
end;

function dateDay(ADate: TDateTime): Word;
var
  M, Y: Word;
begin
  DecodeDate(ADate, Y, M, Result);
end;

function dateMonth(ADate: TDateTime): Word;
var
  D, Y: Word;
begin
  DecodeDate(ADate, Y, Result, D);
end;

function dateYear(ADate: TDateTime): Word;
var
  D, M: Word;
begin
  DecodeDate(ADate, Result, M, D);
end;

function dateIncDate(ADate: TDateTime; Days, Months, Years: Integer): TDateTime;
var
  D, M, Y: Word;
  Day, Month, Year, DayCount, Day28Delta: Longint;
begin
  DecodeDate(ADate, Y, M, D);
  Year := Y; Month := M; Day := D;
  Day28Delta := Day - 28;
  if Day28Delta < 0 then Day28Delta := 0
  else Day := 28;
  Inc(Year, Years);
  Inc(Year, Months div 12);
  Inc(Month, Months mod 12);
  if Month < 1 then begin
    Inc(Month, 12);
    Dec(Year);
  end
  else if Month > 12 then begin
    Dec(Month, 12);
    Inc(Year);
  end;
  DayCount := Day + Days + Day28Delta;
  while DayCount < 1 do begin
    Dec(Month);
    if Month < 1 then begin
      Inc(Month, 12);
      Dec(Year);
    end;
    DayCount := MonthDays[IsLeapYear(Year), Month] - Abs(DayCount);
  end;
  while DayCount > MonthDays[IsLeapYear(Year), Month] do begin
    Dec(DayCount, MonthDays[IsLeapYear(Year), Month]);
    Inc(Month);
    if Month > 12 then begin
      Dec(Month, 12);
      Inc(Year);
    end;
  end;
  Result := EncodeDate(Year, Month, DayCount);
end;

function dateIncDay(ADate: TDateTime; Delta: Integer): TDateTime;
begin
  Result := dateIncDate(ADate, Delta, 0, 0);
end;

function dateIncMonth(ADate: TDateTime; Delta: Integer): TDateTime;
begin
  Result := dateIncDate(ADate, 0, Delta, 0);
end;

function dateIncYear(ADate: TDateTime; Delta: Integer): TDateTime;
begin
  Result := dateIncDate(ADate, 0, 0, Delta);
end;

procedure DateDiff(Date1, Date2: TDateTime; var Days, Months, Years: Word);
var
  DtSwap: TDateTime;
  Day1, Day2, Month1, Month2, Year1, Year2: Word;
begin
  if Date1 > Date2 then begin
    DtSwap := Date1;
    Date1 := Date2;
    Date2 := DtSwap;
  end;
  DecodeDate(Date1, Year1, Month1, Day1);
  DecodeDate(Date2, Year2, Month2, Day2);
  if Day2 < Day1 then begin
    Dec(Month2);
    if Month2 = 0 then begin
      Month2 := 12;
      Dec(Year2);
    end;
    Inc(Day2, MonthDays[IsLeapYear(Year2), Month2]);
  end;
  Days := Day2 - Day1;
  if Month2 < Month1 then begin
    Inc(Month2, 12);
    Dec(Year2);
  end;
  Months := Month2 - Month1;
  Years := Year2 - Year1;
end;

function dateMonthsBetween(Date1, Date2: TDateTime): Double;
var
  D, M, Y: Word;
begin
  DateDiff(Date1, Date2, D, M, Y);
  Result := 12 * Y + M;
  if (D > 1) and (D < 7) then Result := Result + 0.25
  else if (D >= 7) and (D < 15) then Result := Result + 0.5
  else if (D >= 15) and (D < 21) then Result := Result + 0.75
  else if (D >= 21) then Result := Result + 1;
end;

function dateValidDate(ADate: TDateTime): Boolean;
var
  Year, Month, Day: Word;
begin
  try
    DecodeDate(ADate, Year, Month, Day);
    Result := Trunc(ADate) > 0;
  except
    Result := False;
  end;
end;

function dateDayInterval(Date1, Date2: TDateTime): Longint;
begin
  Result := Abs(Trunc(Date2) - Trunc(Date1));
//  if Result < 0 then Result := -1;
end;

function dateIncTime(ATime: TDateTime; Hours, Minutes, Seconds, MSecs: Integer): TDateTime;

  function dateSign(Value: Integer): SmallInt;
  begin
    if Value > 0 then Result := 1
    else if Value = 0 then Result := 0
    else Result := -1;
  end;

var
  H, M, S, MS: Word;
begin
  DecodeTime(ATime, H, M, S, MS);
  MSecs := MS + MSecs;
  while (MSecs < 0) or (MSecs >= 1000) do begin
    Inc(Seconds, dateSign(MSecs));
    MSecs := MSecs - 1000 * dateSign(MSecs);
  end;
  Seconds := S + Seconds;
  while (Seconds < 0) or (Seconds >= 60) do begin
    Inc(Minutes, dateSign(Seconds));
    Seconds := Seconds - 60 * dateSign(Seconds);
  end;
  Minutes := M + Minutes;
  while (Minutes < 0) or (Minutes >= 60) do begin
    Inc(Hours, dateSign(Minutes));
    Minutes := Minutes - 60 * dateSign(Minutes);
  end;
  Hours := H + Hours;
  while (Hours < 0) or (Hours >= 24) do
    Hours := Hours - 24 * dateSign(Hours);
  Result := EncodeTime(Hours, Minutes, Seconds, MSecs);
end;

function dateIncHour(ATime: TDateTime; Delta: Integer): TDateTime;
begin
  Result := dateIncTime(ATime, Delta, 0, 0, 0);
end;

function dateIncMinute(ATime: TDateTime; Delta: Integer): TDateTime;
begin
  Result := dateIncTime(ATime, 0, Delta, 0, 0);
end;

function dateIncSecond(ATime: TDateTime; Delta: Integer): TDateTime;
begin
  Result := dateIncTime(ATime, 0, 0, Delta, 0);
end;

function dateIncMSec(ATime: TDateTime; Delta: Integer): TDateTime;
begin
  Result := dateIncTime(ATime, 0, 0, 0, Delta);
end;


function dateDayOfWeek(D: TDateTime): integer;
begin
  Result := Pred(DayOfWeek(D));
end;


function dateFirstWeek(aYear:integer):TDateTime;
const
  DOWThu = 5;
var
  Month1stJan:TDateTime; Day1stJan:integer;
begin
  Month1stJan := EncodeDate(aYear,1,1);
  Day1stJan := DayOfWeek(Month1stJan);
  if Day1stJan <= DOWThu then
    Result := DOWThu - Day1stJan + Month1stJan - 3
  else
    Result := DOWThu - Day1stJan + Month1stJan + 4;
end;

function dateForDayOfMonth(aCount,aYear,aMonth,aDay:integer):TDateTime;
var
  Month1st:TDateTime;Day1st:integer;
begin
  Month1st := EncodeDate(aYear,aMonth,1);
  Day1st := DayOfWeek(Month1st);
  if Day1st <= aDay then
    Result := aDay - Day1st + ((aCount - 1) * 7) + Month1st
  else
    Result := aDay - Day1st + (aCount * 7) + Month1st;
  if (Result - Month1st + 1) > MonthDays[IsLeapYear(aYear),aMonth] then
    Result := 0;
end;

procedure DecodeWeek(aDate:TdateTime;var aYear,aWeek,aDay:integer);
var WeekOne:TDateTime;Year,Month,Day:word;
begin
//  aDate := Trunc(aDate);
  DecodeDate(aDate,Year,Month,Day);
  WeekOne := dateFirstWeek(Year);
  if aDate >= WeekOne then
  begin
    aYear := Year;
    aWeek := (Trunc(aDate - WeekOne) div 7) + 1;
    aDay := (Trunc(aDate - WeekOne) mod 7) + 1;
    if (aDate - WeekOne) >= 364 then
    begin
      WeekOne := dateFirstWeek(Year + 1);
      if aDate >= WeekOne then
      begin
        aYear := Year + 1;
        aWeek := (Trunc(aDate - WeekOne) div 7) + 1;
        aDay := (Trunc(aDate - WeekOne) mod 7) + 1;
      end;
    end;
  end
  else
  begin
    aYear := Year - 1;
    WeekOne := dateFirstWeek(aYear);
    aWeek := (Trunc(aDate - WeekOne) div 7) + 1;
    aDay := (Trunc(aDate - WeekOne) mod 7) + 1;
  end;
end;

function EncodeWeek(aYear,aWeek,aDay:integer):TDateTime;
begin
  Result := dateFirstWeek(aYear) + (aWeek - 1) * 7 + aDay - 1;
end;

function dateDayOfYear(D: TDateTime): Integer;
begin
  Result := Trunc(D - dateFirstDayOfYear(D))+1;
end;

function dateWeekOfYear(D: TDateTime): Integer;
const
  t1: array[1..7] of ShortInt = ( -1,  0,  1,  2,  3, -3, -2);
  t2: array[1..7] of ShortInt = ( -4,  2,  1,  0, -1, -2, -3);
var
  doy1,
  doy2    : Integer;
  NewYear : TDateTime;
begin
  NewYear := dateFirstDayOfYear(D);
  doy1 := dateDayofYear(D) + t1[dateDayOfWeek(NewYear)];
  doy2 := dateDayofYear(D) + t2[dateDayOfWeek(D)];
  if doy1 <= 0 then
    Result := dateWeekOfYear(NewYear-1)
  else if (doy2 >= dateDayofYear(dateLastDayOfYear(NewYear))) then
    Result:= 1
  else
    Result:=((doy1-1) div 7) + 1;
end;

function GetFirstDate(Datum : TDateTime; PlusYear : Integer) : TDateTime;
var year, Month, Day : Word;
begin
  DecodeDate(Datum, year, Month, Day);
  Result := EncodeDate(Year+PlusYear,1,1);
end;


function GetFirstWeekDateInYear(Datum : TDateTime; PlusYear : Integer) : TDateTime;
Begin
   Result := GetFirstDate(Datum,PlusYear);
   Case DayOfWeek(Result) of
     1 : Result := Result + 1;
     2 : Result := Result;
     3 : Result := Result - 1;
     4 : Result := Result - 2;
     5 : Result := Result - 3;
     6 : Result := Result + 3;
     7 : Result := Result + 2;
   end;
end;

function GetWeekNo(aDate: TDateTime): Integer;
var
  Y, M, D,
  FDay : Word;
  JanF : TDateTime;
  Days : Integer;
begin
  try
    DecodeDate(aDate, Y, M, D);
    JanF := EncodeDate(Y, 1, 1);
    FDay := DayOfWeek(JanF);
    Days := Trunc(Int(aDate) - JanF) + 7 - DayOfWeek(aDate - 1);
    Inc(Days, 7 * Ord(FDay in [dayMon..dayThu]));
    Result := Days div 7;
    if Result = 0 then
    Begin
      if (DayOfWeek(EncodeDate(Y - 1,  1,  1)) > dayThu) or (DayOfWeek(EncodeDate(Y - 1, 12, 31)) < dayThu) then
        Result := 52
      else
        Result := 53;
    end
    else
      if Result = 53 then
        if (FDay > dayThu) or (DayOfWeek(EncodeDate(Y, 12, 31)) < 5) then
          Result := 1;
  except
    Result := -1;
  end;
end;


function GetDateFromWeek(WeekNo, Day : Integer) : TDateTime;
begin
  Result := GetFirstWeekDateInYear(EncodeDate(WeekNo div 100,5,5), 0) + (((WeekNo mod 100)-1)*7) + Day;
end;

function dateCalendarWeek(ADate: TDateTime): integer;
var
  day:         word;
  dayOne:      word;
  firstOfYear: TDateTime;
  month:       word;
  monthOne:    word;
  year:        word;
begin
  DecodeDate(ADate, year, month, day);

  case DayOfWeek(EncodeDate(year, 1, 1)) of
    daySun: dayOne := 2;  // Sunday
    dayMon: dayOne := 1;  // Monday
    dayTue: dayOne := 31; // Tuesday
    dayWed: dayOne := 30; // Wednesday
    dayThu: dayOne := 29; // Thursday
    dayFri: dayOne := 4;  // Friday
    daySat: dayOne := 3;  // Saturday
  end;

  if dayOne > dayWed then
  begin
    Dec(year);
    monthOne := 12
  end
  else
    monthOne := 1;

  firstOfYear := EncodeDate(year, monthOne, dayOne);

  if aDate < firstOfYear then
    Result := 53
  else
    Result := (Trunc(aDate - firstOfYear) div 7) + 1;
end;

function dateFourDigitYear(const aYear:integer):integer;
var Y:integer;
begin
  if aYear > 99 then // ignore these - just send back
  begin
    Result := aYear;
    Exit;
  end;

  Y := dateYear(Date);
  if TwoDigitYearCenturyWindow <= 0 then
  begin
    Result := aYear + Y div 100 * 100;
    Exit;
  end;
  Y := Y - TwoDigitYearCenturyWindow;
  Result := aYear + (Y div 100) * 100;
  if aYear <= (Y mod 100) then // next century
    Inc(Result,100);
end;

function LastChar(const S:string):char;
begin
  if Length(S) = 0 then
    Result := #0
  else
    Result := S[Length(S)];
end;

{ allowed formats:
  d       - today
  d + 1   - tomorrow
  d  - 1  - yeaterday
  etc
  invalid characters are ignored
}
function DoDayFormat(const Str,Default:string):String;
var i:integer;
begin
  Result := '';
  if Length(Str) = 1 then
  begin
    Result := DateToStr(Date);
    Exit;
  end;

  { trim: }
  for i := 1 to Length(Str) do
    if (Str[i] in ['-','+','0'..'9']) then
      Result := Result + Str[i];

  if Length(Result) > 1 then
  begin
    if Result[1] = '-' then
      Result := DateToStr(Date - StrToInt(Copy(Result,2,MaxInt)))
    else if Result[1] = '+' then
      Result := DateToStr(Date + StrToInt(Copy(Result,2,MaxInt)))
    else
      Result := Default;
  end
  else
    Result := Default;
end;

{
 allowed formats:
  v5       - next weekday 5
  v015     - next week 1, weekday 5
  v00015   - nästa år XX00, vecka 01, veckodag 5
  v2000015 - vecka 1, veckodag 5, år 2000
  invalid characters are ignored
}
function DoWeekFormat(const Str,Default:string):String;
var aYear,aWeek,aDay,dY,dW,dD,i:integer;
    Y,M,D:word;
begin

  if Str = '' then
  begin
    Result := Default;
    Exit;
  end;

  { trim string }
  for i := 1 to Length(Str) do
    if Str[i] in ['0'..'9'] then
      Result := Result + Str[i];

  if not (LastChar(Result) in ['1'..'7']) then  // Monday to Thursday
  begin
    Result := Default;
    Exit;
  end;

  DecodeDate(Date,Y,M,D);

  case Length(Result) of
    1: // 5
    begin
      DecodeWeek(Date,aYear,aWeek,dD);
      aDay := StrToInt(LastChar(Result));
      if aDay < dD then
        Inc(aWeek);
      if aWeek > GetWeekNo(EncodeDate(aYear,12,31)) then
      begin
        Inc(aYear);
        aWeek := 1; // ??? kan kanske vara fel ibland (P3)
      end;
    end;
    3: // 015
    begin
      DecodeWeek(Date,dY,dW,dD);
      aYear := Y;
      aWeek := StrToInt(Copy(Result,1,2));
      aDay := StrToInt(LastChar(Result));
      if (aWeek < dW) or ((aWeek = dW) and (aDay < dD)) then
        Inc(aYear);
    end;
    5: // 00015
    begin
      aYear := StrToInt(Copy(Result,1,2));
      aYear := dateFourDigitYear(aYear);
      aWeek := StrToInt(Copy(Result,3,2));
      aDay := StrToInt(LastChar(Result));
    end;
    7: // 19990101
    begin
      aYear := StrToInt(Copy(Result,1,4));
      aWeek := StrToInt(Copy(Result,5,2));
      aDay := StrToInt(LastChar(Result));
    end;
  else
    Result := Default;
    Exit;
  end;

  try
    Result := DateToStr(EncodeWeek(aYear,aWeek,aDay));
  except
    Result := Default;
  end;
end;

{
Allowed formats:
06         - next monthday 6
-06        - prev monthday 6
0706       - next month 7 day 6
-0706      - previous month 7 day 6
990706     - next year 99 month 7 day 6
-990706    - prev year 99 month 7 day 6
19990706   - year 1999 month 7 day 6
invalid characters are stripped from the input before validation
}

function DoDateFormat(const Str,Default:string):string;
var i,aYear,aMonth,aDay:integer;
    Y,M,D:Word;
    tmp:string;
    tmpDate:TDateTime;
    FPrev:boolean;
begin
  if Length(Str) = 0 then
  begin
    Result := Default;
    Exit;
  end;
  FPrev := Str[1] = '-';
  for i := 1 to Length(Str) do
    if (Str[i] in ['0'..'9']) then
      Result := Result + Str[i];

  DecodeDate(Date,Y,M,D);
  try
    case Length(Result) of
      2: // 06
      begin
        aDay := StrToInt(Result);
        if aDay >= D then
          Result := DateToStr(EncodeDate(Y,M,aDay))
        else if not FPrev then
        begin
          tmpDate := IncMonth(Date,1);
          DecodeDate(tmpDate,Y,M,D);
          Result := DateToStr(EncodeDate(Y,M,aDay));
        end
        else
        begin
          tmpDate := IncMonth(Date,-1);
          DecodeDate(tmpDate,Y,M,D);
          Result := DateToStr(EncodeDate(Y,M,aDay));
        end;
      end;
      4: // 0706
      begin
        aMonth := StrToInt(Copy(Result,1,2));
        aDay   := StrToInt(Copy(Result,3,2));
        if (aMonth > M)  or ((aMonth = M) and (aDay >= D)) then
           //do nothing
        else
          Inc(Y);
        if FPrev then Dec(Y);
        Result := DateToStr(EncodeDate(Y,aMonth,aDay))
      end;
      6: // 990706
      begin
        aYear  := StrToInt(Copy(Result,1,2));
        aMonth := StrToInt(Copy(Result,3,2));
        aDay   := StrToInt(Copy(Result,5,2));
        // TwoDigitYearCenturyWindow controls the return value:
        aYear := dateFourDigitYear(aYear);
        if FPrev then Dec(aYear,100);
//        if (aMonth > M)  or ((aMonth = M) and (aDay >= D)) then
        Result := DateToStr(EncodeDate(aYear,aMonth,aDay))
//        else
//          Result := DateToStr(EncodeDate(aYear + 1,aMonth,aDay));
      end;
      8: // 19990706
      begin
        aYear  := StrToInt(Copy(Result,1,4));
        aMonth := StrToInt(Copy(Result,5,2));
        aDay   := StrToInt(Copy(Result,7,2));
        Result := DateToStr(EncodeDate(aYear,aMonth,aDay));
      end;
    else
      Result := Default;
    end;
  except
    Result := Default;
  end;
end;

function GetFormattedDate(const Str,Default:string):string;
var i:integer;tmp:string;
begin
  if Str = '' then
  begin
    Result := Default;
    Exit;
  end;

  if Str[1] in ['v','w','V','W'] then
  begin
    Result := DoWeekFormat(Str,Default);
    Exit;
  end;

  if Str[1] in ['d','D'] then
  begin
    Result := DoDayFormat(Str,Default);
    Exit;
  end;

  Result := DoDateFormat(Str,Default);
end;

end.



