{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     FaktUts.pas
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
{ $Log:  13499: FaktUts.pas
{
{   Rev 1.2    2004-01-30 14:44:20  peter
{ Fixat journal + kontering + + + +
}
{
{   Rev 1.1    2004-01-29 10:24:24  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:24:08  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.2    2004-01-28 14:40:20  peter
}
{
{   Rev 1.1    2003-12-30 11:18:12  peter
}
{
{   Rev 1.0    2003-03-20 13:58:56  peter
}
{
{   Rev 1.0    2003-03-17 14:39:44  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:06  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:06  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit FaktUts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, CheckLst, Buttons, db, ComCtrls, Grids, DBGrids, Variants, adodb;

type
  TFrmFaktUts = class(TForm)
    Panel2: TPanel;
    RG1: TRadioGroup;
    RBAlla: TRadioButton;
    RBEgna: TRadioButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    EdtNamn: TEdit;
    Label5: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    DT: TDateTimePicker;
    Label6: TLabel;
    CBIntExt: TComboBox;
    Label1: TLabel;
    EdtSum: TEdit;
    SpeedButton3: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RBAllaClick(Sender: TObject);
    procedure RBEgnaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FillDBGRid;
    procedure HideCols;
    procedure SpeedButton3Click(Sender: TObject);
    procedure EdtNamnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    subnr: Integer;
  public
    { Public declarations }
  end;

var
  FrmFaktUts: TFrmFaktUts;

implementation

uses Dmod, Main, eqprn, DmSession, func; //Crystal;

{$R *.DFM}





procedure TFrmFaktUts.FormCreate(Sender: TObject);
begin
  dt.DateTime := now - dmod2.ParamT.fieldbyname('SDate').asinteger;
  FillDbGrid;
  Caption := 'Journalhantering';
  dmod2.BetstT.first;
  while not dmod2.BetstT.Eof do
  begin
    cbintext.Items.Add(dmod2.BetstT.FieldByName('Kod').asstring + ' ' + dmod2.BetstT.FieldByName('Namn').asstring);
    dmod2.BetstT.Next;
  end;
  dmod2.q1.filtered := False;
end;

procedure TFrmFaktUts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeandNil(frmfaktuts);
  FrmMain.Panel1.Visible := True;
end;

procedure TFrmFaktUts.RBAllaClick(Sender: TObject);
begin
  dbgrid1.DataSource.DataSet.First;
  while not dbgrid1.DataSource.DataSet.EOF do
  begin
    dbgrid1.SelectedRows.CurrentRowSelected := True;
    dbgrid1.DataSource.DataSet.Next;
  end;
  label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
  HideCols;
end;

procedure TFrmFaktUts.RBEgnaClick(Sender: TObject);
begin
  dbgrid1.DataSource.DataSet.First;
  while not dbgrid1.DataSource.DataSet.EOF do
  begin
    dbgrid1.SelectedRows.CurrentRowSelected := False;
    dbgrid1.DataSource.DataSet.Next;
  end;
  label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
  dbgrid1.DataSource.DataSet.First;
  HideCols;
end;

procedure TFrmFaktUts.SpeedButton1Click(Sender: TObject);
begin
  dmod2.q1.filtered := False;
  FilldbGrid;
  HIdeCols;
  EdtSum.Text := '';
  edtnamn.text := '';
  cbintext.Text := '';
  speedbutton1.Enabled := False;
  edit1.text := '';
end;

procedure TFrmFaktUts.SpeedButton2Click(Sender: TObject);
var
  ENummer: Integer;
  KontrId: string;
  Namn: string;
begin
  dbgrid1.Visible := False;
  dbgrid1.DataSource.DataSet.First;
  while not dbgrid1.DataSource.DataSet.EOF do
  begin
    if dbgrid1.SelectedRows.CurrentRowSelected then
    begin
      //!Läs in Contr_id och SubName till Variabler
      KontrId := dbgrid1.Columns[0].Field.AsSTRING;
      Namn := dbgrid1.Columns[1].Field.AsString;
      //!Höj status i Basen till 10
      dmod2.Contr_BaseT.Locate('ContrId', dbgrid1.Columns[0].Field.AsString, [loCaseInsensitive]);
      dmod2.Contr_BaseT.Edit;
      dmod2.Contr_BaseT.FieldByName('Status').asinteger := 10;
      dmod2.Contr_BaseT.Post;
      //! Släng in PrintDatum i subben
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayof([KontrId, Namn]), [loCaseInsensitive]);
      dmod2.Contr_SubT.Edit;
      dmod2.Contr_SubT.FieldByName('Print_Date').asstring := DateToStr(date);
      dmod2.Contr_SubT.FieldByName('ForfalloDat').asstring := DateToStr(date + dmod2.ParamT.Fieldbyname('FaktDagar').asinteger);
      dmod2.Contr_SubT.FieldByName('Status').asinteger := 10;
      dmod2.Contr_SubT.Post;
      //!Finns det ett enummer använd det
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayOf([KontrId, Namn]), [loCaseInsensitive]);
      if dmod2.Contr_SubT.FieldByName('Enummer').asinteger > 1 then
        enummer := dmod2.Contr_SubT.fieldbyname('ENummer').asinteger
      //!Annars hämta ett nytt...
      else
      begin
        Enummer := 0;
        if dbgrid1.Columns[7].Field.AsString = 'K' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('KNOTENR').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('KNOTENR').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'O' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('FBolagNR').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('FBolagNR').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'I' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('InternNr').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('InternNr').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
        if dbgrid1.Columns[7].Field.AsString = 'F' then
        begin
          enummer := dmod2.ParamT.Fieldbyname('FaktNr').asinteger + 1;
          dmod2.ParamT.Edit;
          dmod2.ParamT.Fieldbyname('FaktNr').asinteger := enummer;
          Dmod2.ParamT.Post;
        end;
      end;
      //! Släng in ett ENummer
      dmod2.Contr_SubT.Locate('ContrId;SubName', VarArrayOf([KontrId, Namn]), [loCaseInsensitive]);
      dmod2.Contr_SubT.Edit;
      dmod2.Contr_SubT.FieldByName('ENummer').asinteger := Enummer;
      dmod2.Contr_SubT.Post;
      MoveCSub2Faktura(dmod2.Contr_SubT.FieldByName('SUBID').AsInteger);
    end;
    dbgrid1.DataSource.DataSet.Next;
  end;
//!Avsluta pros med att visa DbGriden och SKRIV UT!!!
  FilldbGrid;
  dbgrid1.Visible := True;
//  List := TStringList.Create;
//  List.Add(DateToStr(Date));
//  eqprn.PrintReportParams('journal.ini', 1, frmMain.preview, List);
//  List.Free;
  Speedbutton1.Click;
end;

procedure TFrmFaktUts.FillDBGrid;
begin
  dmod2.q1.close;
  dmod2.q1.sql.Text := 'SELECT Contr_Base.ContrId, Contr_Sub.SubName, Contr_ObjT.OId, Contr_ObjT.Ret_Time, Contr_SubCost.DTOTAL, Contr_Base.Status, Contr_Sub.SubId, Contr_Sub.Payment';
  dmod2.q1.sql.Text := dmod2.q1.sql.Text + ' FROM (Contr_Base LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId) INNER JOIN (Contr_Sub LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId) ON Contr_Base.ContrId = Contr_Sub.ContrId';
  dmod2.q1.sql.Text := dmod2.q1.sql.Text + ' WHERE (((Contr_Base.Status)=9));';
  dmod2.Q1.Open;

//! dbgrid1.Columns[3].:=False;
//! dbgrid1.Columns[5].:=False;
  rbegna.checked := True;
  dbgrid1.DataSource.DataSet.First;
  label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
end;

procedure TFrmFaktUts.HideCols;
begin
  dbgrid1.Columns[3].visible := False;
  dbgrid1.Columns[5].visible := False;
  dbgrid1.Columns[6].visible := False;
end;

procedure TFrmFaktUts.SpeedButton3Click(Sender: TObject);
begin
  if (cbintExt.Text > '!') and (edtSum.text > '!') then
  begin
    dmod2.q1.filter := 'Ret_time <= ''' + datetostr(dt.date) + ''' AND Payment = ''' + cbintext.Text[1] + ''' AND DTotal >''' + EdtSum.Text + ''''; //!
    dmod2.q1.filtered := True;
    label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
    speedbutton1.Enabled := True;
  end
  else
    showmessage('Du måste fylla i "Betal sätt" och "Summa större än"');
end;

procedure TFrmFaktUts.EdtNamnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_F2 then
  begin
    dmod2.q1.filter := 'Subname like ''' + Edtnamn.Text + '%''';
    dmod2.q1.filtered := True;
    label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
    speedbutton1.Enabled := True;
  end;
end;

procedure TFrmFaktUts.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_F2 then
  begin
    dmod2.q1.filter := 'OID like ''' + Edit1.Text + '%''';
    dmod2.q1.filtered := True;
    label4.Caption := Inttostr(dbgrid1.DataSource.DataSet.RecordCount);
    speedbutton1.Enabled := True;
  end;
end;

end.

