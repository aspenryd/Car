{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13157: Main.pas 
{
{   Rev 1.0    2003-03-20 14:03:30  peter
}
unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, comp2000, ComCtrls;

type
  TForm1 = class(TForm)
    DateTimeViewer1: TDateTimeViewer;
    DateTimeViewer2: TDateTimeViewer;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure DateTimePicker1CloseUp(Sender: TObject);
    procedure DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DateTimePicker1CloseUp(Sender: TObject);
begin
  DateTimePicker1.SetFocus;
end;

procedure TForm1.DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  caption := inttostr(Key);
  if shift = [ssAlt] then
    if Key = 115 then
      close;
end;

end.
