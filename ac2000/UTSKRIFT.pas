{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Utskrift.pas
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
{ $Log:  13022: UTSKRIFT.pas 
{
{   Rev 1.3    2003-10-14 13:12:56  peter
{ Fixat utskrift av kontokort samt sortering i internt fakturanummer.
}
{
{   Rev 1.2    2003-08-04 11:58:46  Supervisor
}
{
{   Rev 1.1    2003-03-21 10:16:08  peter
}
{
{   Rev 1.0    2003-03-20 13:58:58  peter
}
{
{   Rev 1.0    2003-03-17 14:39:46  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:06  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:10  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Utskrift;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, db,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, ADODB;

type
  TFrmUtskr = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    DTP1: TDateTimePicker;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CBGranska: TCheckBox;
    ADOQuery1: TADOQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUtskr: TFrmUtskr;

implementation

uses {Crystal,} Dmod, Main, Eqprn, DateUtil;

{$R *.DFM}

procedure TFrmUtskr.BitBtn1Click(Sender: TObject);
var sub: Integer;
begin
  if Caption = 'Faktura utskrift' then
  begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('SELECT e_faktnr FROM fakthead WHERE utskrdat = '''+InternalDateToStr(trunc(DTP1.Date))+''' AND Payment = ''F'' ORDER BY FAKTNR');
    ADOQuery1.Open;
    while not ADOQuery1.Eof do begin
      try
        PrintOutReport('kvitto_sf.ini', ADOQuery1.FieldByName('e_faktnr').AsString+';', DMod2.ParamT.FieldByName('FAKTURA_COPY').AsInteger, CbGranska.Checked);
      except
        ShowMessage('Kunde inte skriva ut fakturanummer : '+ADOQuery1.FieldByName('e_faktnr').AsString);
      end;
      ADOQuery1.Next;
    end;
    ADOQuery1.Close;
  end;
  if Caption = 'Intern faktura utskrift' then
  begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('SELECT e_faktnr FROM fakthead WHERE utskrdat = '''+InternalDateToStr(DTP1.Date)+''' AND Payment = ''I'' ORDER BY FAKTNR');
    ADOQuery1.Open;
    while not ADOQuery1.Eof do begin
      try
        PrintOutReport('kvitto_sf.ini', ADOQuery1.FieldByName('e_faktnr').AsString+';', DMod2.ParamT.FieldByName('FAKTURA_COPY').AsInteger, CbGranska.Checked);
      except
        ShowMessage('Kunde inte skriva ut fakturanummer : '+ADOQuery1.FieldByName('e_faktnr').AsString);
      end;
      ADOQuery1.Next;
    end;
    ADOQuery1.Close;
  end;
  if Caption = 'Kontant faktura utskrift' then
  begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('SELECT e_faktnr FROM fakthead WHERE utskrdat = '''+InternalDateToStr(DTP1.Date)+''' AND Payment = ''K'' ORDER BY FAKTNR');
    ADOQuery1.Open;
    while not ADOQuery1.Eof do begin
      try
        PrintOutReport('kvitto_sf.ini', ADOQuery1.FieldByName('e_faktnr').AsString+';', DMod2.ParamT.FieldByName('FAKTURA_COPY').AsInteger, CbGranska.Checked);
      except
        ShowMessage('Kunde inte skriva ut fakturanummer : '+ADOQuery1.FieldByName('e_faktnr').AsString);
      end;
      ADOQuery1.Next;
    end;
    ADOQuery1.Close;
  end;

  if Caption = 'Kontokort faktura utskrift' then
  begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('SELECT e_faktnr FROM fakthead WHERE utskrdat = '''+InternalDateToStr(DTP1.Date)+''' AND Payment = ''O'' ORDER BY FAKTNR');
    ADOQuery1.Open;
    while not ADOQuery1.Eof do begin
      try
        PrintOutReport('kvitto_sf.ini', ADOQuery1.FieldByName('e_faktnr').AsString+';', DMod2.ParamT.FieldByName('FAKTURA_COPY').AsInteger, CbGranska.Checked);
      except
        ShowMessage('Kunde inte skriva ut fakturanummer : '+ADOQuery1.FieldByName('e_faktnr').AsString);
      end;
      ADOQuery1.Next;
    end;
    ADOQuery1.Close;
  end;

end;

procedure TFrmUtskr.FormActivate(Sender: TObject);
begin
  dtp1.DateTime := now - dmod2.ParamT.FieldByname('SDate').asinteger;
end;

end.

