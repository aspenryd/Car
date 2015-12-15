{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     History.pas
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
{ $Log:  14854: HISTORY.pas 
{
{   Rev 1.0    2004-08-18 11:00:56  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.0    2003-03-20 14:00:26  peter
}
{
{   Rev 1.0    2003-03-17 14:41:42  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:56  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:24  Supervisor
{ Start av vc
}
unit history;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, search,
  StdCtrls, Buttons, DBCtrls, Mask, ExtCtrls, Grids, DBGrids, Db, DBClient;

type
  TfrmHistory = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    dsHistoryCDS: TDataSource;
    edtTitle: TEdit;
    meNote: TMemo;
    Panel2: TPanel;
    btnNew: TBitBtn;
    btnSave: TButton;
    btnDelete: TBitBtn;
    procedure dsHistoryCDSDataChange(Sender: TObject; Field: TField);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtTitleChange(Sender: TObject);
    procedure meNoteChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    changed: boolean;
    function ShowSearchResult: boolean;
    procedure Changing(value: boolean);
  public
    { Public declarations }
    ContId: integer;

    procedure ShowHistoryForContract(contrid: integer);
  end;

var
  frmHistory: TfrmHistory;

implementation

uses Main, Data2;
{$R *.DFM}

procedure TfrmHistory.ShowHistoryForContract(contrid: integer);
begin
  contid := contrid;
  frmSearch.SSQLString := SQLHistory + ' WHERE CONTRID = ' + inttostr(ContId);
  frmHistory.caption := 'Kontraktshistorik för kontrakt ' + inttostr(ContId);
  ShowSearchResult;
end;

function TfrmHistory.ShowSearchResult: boolean;
begin
  result := false;
  frmSearch.SSearchCDS.Active := false;
//!  frmSearch.SSearchCDS.PacketRecords := -1;
  dsHistoryCDS.DataSet := frmSearch.SSearchCDS;
  try
//!    if ICARSearch.ChangeSQL(frmSearch.SSQLString) > 0 then
//!Benny Lagt till raden under
    if TCARSearch.ChangeSQL(frmSearch.SSQLString) > 0 then
    begin
//!      frmSearch.SSearchCDS.provider := ICARSearch.SearchQ;
      frmSearch.SSearchCDS.Active := true;
      ShowModal;
      result := true;
    end;
  finally
    dsHistoryCDS.DataSet := nil;
  end;
end;

procedure TfrmHistory.dsHistoryCDSDataChange(Sender: TObject;
  Field: TField);
begin
  try
    changing(false);
    edtTitle.Enabled := dsHistoryCDS.DataSet.FieldByName('Status').AsInteger = 99;
    meNote.enabled := edtTitle.Enabled;
    btnDelete.enabled := edtTitle.Enabled;
    btnSave.enabled := edtTitle.Enabled;
    edtTitle.text := dsHistoryCDS.DataSet.FieldByName('Subject').AsString;
    meNote.text := dsHistoryCDS.DataSet.FieldByName('Note').AsString;
  except
    edtTitle.Enabled := false;
    meNote.enabled := false;
    btnDelete.enabled := false;
    btnSave.enabled := false;
    edtTitle.text := '';
    meNote.text := '';
  end;
end;

procedure TfrmHistory.btnNewClick(Sender: TObject);
begin
//!  LocalServer.SaveContrHist(0,ContID,'','',frmMain.sign,99);
  FrmSearch.SaveContrHist(0, ContID, '', '', frmMain.sign, 99);

//!  ICARSearch.UpdateQuery;
//! TCARSearch.UpdateQuery;

  dsHistoryCDS.Dataset.refresh;
//  changing(true);
end;

procedure TfrmHistory.btnDeleteClick(Sender: TObject);
begin
//!  LocalServer.DeleteContrHist(dsHistoryCDS.Dataset.FieldByName('HistNum').AsInteger);
//!    FrmSearch.DeleteContrHist(dsHistoryCDS.Dataset.FieldByName('HistNum').AsInteger);

//!  ICARSearch.UpdateQuery;
  dsHistoryCDS.Dataset.refresh;
end;

procedure TfrmHistory.btnSaveClick(Sender: TObject);
var
  HistId: integer;
begin
  HistId := dsHistoryCDS.Dataset.FieldByName('HistNum').AsInteger;
  if HistId > 0 then
  begin
//!    LocalServer.SaveContrHist(HistId,ContID,edtTitle.text,meNote.Text,frmMain.sign,99);
    FrmSearch.SaveContrHist(HistId, ContID, edtTitle.text, meNote.Text, frmMain.sign, 99);

    dsHistoryCDS.Dataset.refresh;
  end;
  changing(false);

end;

procedure TfrmHistory.edtTitleChange(Sender: TObject);
begin
  if edtTitle.Focused then
    changing(true);
end;

procedure TfrmHistory.meNoteChange(Sender: TObject);
begin
  if meNote.Focused then
    changing(true);
end;

procedure TfrmHistory.FormActivate(Sender: TObject);
begin
  changing(false);
end;

procedure TfrmHistory.Changing(value: boolean);
begin
  changed := value;
  btnSave.enabled := changed;
end;

procedure TfrmHistory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if changed and
    (MessageDlg('Du har förändrat texten. Vill du spara?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    btnSaveClick(nil);
end;

end.

