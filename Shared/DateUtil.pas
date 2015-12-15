unit DateUtil;

interface

uses SysUtils, Classes, Windows;

function InternalDateToStr(date : TDateTime) : string;
function InternalStrToDate(date : string) : TDateTime;

function VisibleDateToStr(date : TDateTime) : string;
function VisibleStrToDate(date : string) : TDatetime;

implementation

function InternalDateTimeToStr(date : TDateTime) : string;
begin
  result := formatDateTime('yyyy-mm-dd hh:nn:ss', date);
end;

function InternalDateToStr(date : TDateTime) : string;
begin
  result := formatDateTime('yyyy-mm-dd', date);
end;

function VisibleDateToStr(date : TDateTime) : string;
begin
  result := datetostr(date);
end;

function InternalStrToDate(date : string) : TDateTime;
var
  y, m, d, h, n, s : integer;
begin
  try
    y := strtoint(Copy(date, 1, 4));
    m := strtoint(Copy(date, 6, 2));
    d := strtoint(Copy(date, 9, 2));
    h := strtoint(Copy(date, 12, 2));
    n := strtoint(Copy(date, 15, 2));
    s := strtoint(Copy(date, 18, 2));
    result := EncodeDate(y, m, d) + encodeTime(h, n, s, 0);
  except
    on E:Exception do
    begin
      raise Exception.CreateFmt('Unable to convert string to internal date with string "%s". Error: %s', [date, E.Message]);
    end;
  end;
end;

function VisibleStrToDate(date : string) : TDatetime;
begin
  result := strtodate(date);
end;

end.
