{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     PrintDialog.pas
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
{ $Log:  13621: PRINTDIALOG.pas
{
{   Rev 1.1    2004-01-29 10:24:26  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:26:18  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.1    2003-08-04 11:58:04  Supervisor
}
{
{   Rev 1.0    2003-03-20 14:04:04  peter
}
{
{   Rev 1.0    2003-03-17 14:39:48  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:10  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:08  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit PrintDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, EQPrn, Adodb, EQDateEdit,
  EQFormatEdit;

type
  TfrmPrintDialog = class(TForm)
    Notebook1: TNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    btnPrinter: TButton;
    Panel3: TPanel;
    btnCancel: TButton;
    btnPrint: TButton;
    Label2: TLabel;
    edLoggnr: TEdit;
    cbPreview: TCheckBox;
    Label3: TLabel;
    ed2_1: TEdit;
    Label1: TLabel;
    ED4_1: TEdit;
    ed3_1: TEQFormatEdit;
    ed3_2: TEQFormatEdit;
    ed3_3: TEQDateEdit;
    ed3_4: TEQDateEdit;
    Label4: TLabel;
    Label5: TLabel;
    ed5_4: TEQDateEdit;
    ed5_2: TEQFormatEdit;
    ed5_1: TEQFormatEdit;
    ed5_3: TEQDateEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure btnPrintClick(Sender: TObject);
    procedure edLoggnrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FUrvalsTyp: Integer;
    FFormCaption: string;
    procedure SetUrvalsTyp(const Value: Integer);
    procedure SetFormCaption(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    ReportFileName: string;
    Q1: tAdoQuery;
    property UrvalsTyp: Integer read FUrvalsTyp write SetUrvalsTyp;
    property FormCaption: string read FFormCaption write SetFormCaption;
  end;

var
  frmPrintDialog: TfrmPrintDialog;

implementation

{$R *.dfm}

procedure TfrmPrintDialog.btnPrintClick(Sender: TObject);
var
  Str: string;
begin
  Screen.Cursor := crHourGlass;
  try
    case Notebook1.PageIndex of
      0: Str := ';';
      1: Str := edLoggnr.Text + ';';
      2: begin
          Str := ed2_1.Text + ';' + frmPrintDialog.Caption + ';';
        end;
      3: Str := ed3_1.Text + ';' + ed3_2.Text + ';' + ed3_3.Text + ';' + ed3_4.Text + ';';
      4: Str := ed4_1.Text + ';';
      5: Str := ed5_1.Text + ';' + ed5_2.Text + ';' + ed5_3.Text + ';' + ed5_4.Text + ';';
      6: Str := ';';
      7: Str := ';';
      8: Str := ';';
      9: Str := ';';
      10: Str := ';';
      11: Str := ';';
      12: Str := ';';
    end;
    PrintOutReport(ReportFileName, str, 1, cbPreview.Checked);
  except
  end;
  Screen.Cursor := crDefault;
  ModalResult := mrOk;
end;

procedure TfrmPrintDialog.SetUrvalsTyp(const Value: Integer);
var
  y1, m1, d1: Word;
begin
  if ((Value > -1) and (Value < 13)) then
    FUrvalsTyp := Value;
  Notebook1.PageIndex := FUrvalsTyp;
  if FUrvalsTyp = 1 then
  begin
    q1.Close;
    q1.SQL.Text := 'Select Loggnr from Param';
    q1.Active := True;
    edLoggNr.Text := q1.Fields[0].AsString;
    q1.Close;
  end;
  if FUrvalsTyp = 3 then
  begin
    q1.Close;
    q1.SQL.Text := 'Select max(reg_no),Min(reg_no) from objects';
    q1.Active := True;
    ed3_1.Text := q1.Fields[1].AsString;
    ed3_2.Text := q1.Fields[0].AsString;
    q1.Close;
    DecodeDate(Now, y1, m1, d1);
    DecodeDate(EncodeDate(y1, m1, 1) - 1, y1, m1, d1);
    ed3_3.Text := DateToStr(EncodeDate(y1, m1, 1));
    ed3_4.Text := DateToStr(EncodeDate(y1, m1, d1));
  end;
  if FUrvalsTyp = 5 then
  begin
    ed5_1.Text := 'A';
    ed5_2.Text := 'W';
    q1.Close;
    DecodeDate(Now, y1, m1, d1);
    DecodeDate(EncodeDate(y1, m1, 1) - 1, y1, m1, d1);
    ed5_3.Text := DateToStr(EncodeDate(y1, m1, 1));
    ed5_4.Text := DateToStr(EncodeDate(y1, m1, d1));
  end;
end;

procedure TfrmPrintDialog.edLoggnrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not Key in [ord('0')..ORD('9')]) then
    key := 0;
end;

procedure TfrmPrintDialog.SetFormCaption(const Value: string);
begin
  FFormCaption := Value;
  frmPrintDialog.Caption := Value;
end;

end.

