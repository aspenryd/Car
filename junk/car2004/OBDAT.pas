{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Obdat.pas
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
{ $Log:  13574: OBDAT.pas
{
{   Rev 1.1    2004-01-29 10:26:38  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:48  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 14:00:28  peter
}
{
{   Rev 1.0    2003-03-17 14:41:46  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:58  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:26  Supervisor
{ Start av vc
}
unit Obdat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, StdCtrls, DBCtrls, Buttons, ExtCtrls, ToolWin,
  ComCtrls, adodb;

type
  TfrmObdat = class(TForm)
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    ComboBox1: TComboBox;
    Regnr: TLabel;
    BitBtn3: TBitBtn;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    CB1: TCheckBox;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    ToolBar1: TToolBar;
    BtnFirst: TSpeedButton;
    BtnMinEn: TSpeedButton;
    BtnPlusen: TSpeedButton;
    BtnLast: TSpeedButton;
    BtnDel: TSpeedButton;
    BtnFilter: TSpeedButton;
    BtnASC: TSpeedButton;
    BtnDESC: TSpeedButton;
    BtnTotRecNo: TEdit;
    BtnRecNo: TEdit;
    procedure ClearIn;
    procedure LoadPost;
    procedure PanelEnabled(val: boolean);
    procedure ComboBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFirstClick(Sender: TObject);
    procedure BtnMinEnClick(Sender: TObject);
    procedure BtnPlusenClick(Sender: TObject);
    procedure BtnLastClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure FixRaknare;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnFilterClick(Sender: TObject);
    procedure BtnASCClick(Sender: TObject);
    procedure BtnDESCClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Editing: Boolean;
  public
    { Public declarations }
  end;

var
  frmObdat: TfrmObdat;

implementation

uses Login, Kontrakt, Datamodule, Greg, Data2, Main;

{$R *.DFM}

procedure TfrmObdat.ComboBox1Click(Sender: TObject);
begin
  if Combobox1.Itemindex > 0 then
  begin
    DMod.ObjdateT.filter := 'Reg_No = ''' + Combobox1.Text + '''';
    DMod.ObjdateT.filtered := true;
  end
  else
    DMod.ObjdateT.filtered := false;
end;

procedure TfrmObdat.FormActivate(Sender: TObject);
begin
  with Combobox1 do
  begin
    clear;
    items.add('Alla fordon');
    frmgreg.ObjectsT.Resync([RMCenter]);
    frmgreg.ObjectsT.First;
    while not frmgreg.ObjectsT.EOF do
    begin
      items.add(frmgreg.ObjectsT.fieldbyname('REG_No').AsString);
      frmgreg.ObjectsT.next;
    end;
    itemindex := 0;
  end;
  DBGrid1.Visible := true;
  Panel4.Visible := false;
  Dmod.ObjDateT.active := False;
  Dmod.ObjDateT.CursorLocation := clUseClient;
  Dmod.ObjDateT.active := True;
  fixraknare;
end;

procedure TfrmObdat.BitBtn2Click(Sender: TObject);
begin
  if DMod.ObjdateT.State in [dsEdit, dsInsert] then
    DMod.ObjdateT.post;
  DMod.ObjDateT.filtered := false;
  FrmObDat.Close;
end;

procedure TfrmObdat.BitBtn3Click(Sender: TObject);
begin
  if DMod.ObjdateT.fieldbyname('ObjdateId').value > 0 then
  begin
    PanelEnabled(false);
    ClearIn;
    if Combobox1.itemindex > 0 then
      Edit1.Text := Combobox1.Text;
    DBGrid1.Visible := false;
    Panel4.Visible := true;
    Editing := true;
    LoadPost;
    Edit1.SetFocus;
  end
  else
    ShowMessage('Välj befintlig post');
end;

procedure TfrmObdat.LoadPost;
begin
  with DMod do
  begin
    Edit1.Text := ObjdateT.fieldbyname('Reg_no').AsString;
    Edit2.Text := ObjdateT.fieldbyname('TransDate').AsString;
    CB1.Checked := ObjdateT.Fieldbyname('TransIn-out').value;
    Edit3.Text := ObjdateT.Fieldbyname('Where').AsString;
    Edit4.Text := ObjdateT.FieldbyName('TransCode').AsString;
  end;
end;

procedure TfrmObdat.BitBtn1Click(Sender: TObject);
begin
  Dmod.ObjDateT.active := False;
  Dmod.ObjDateT.CursorLocation := clUseClient;
  Dmod.ObjDateT.active := True;

  ClearIn;
  PanelEnabled(false);
  if Combobox1.itemindex > 0 then
    Edit1.Text := Combobox1.Text;
  DBGrid1.Visible := false;
  Panel4.Visible := true;
  Editing := false;
  Edit1.SetFocus;
end;

procedure TfrmObdat.ClearIn;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  CB1.Checked := false;
end;

procedure TfrmObdat.Button2Click(Sender: TObject);
begin
  ClearIn;
  PanelEnabled(true);
  DBGrid1.Visible := true;
  Panel4.Visible := false;
  Dmod.ObjDateT.active := False;
  Dmod.ObjDateT.CursorLocation := clUseClient;
  Dmod.ObjDateT.active := True;
  fixraknare;
end;

procedure TfrmObdat.Button1Click(Sender: TObject);
var val: integer;
begin
  val := -1;
  if not frmgreg.ObjectsT.Locate('Reg_no', Edit1.Text, [lopartialkey]) then
  begin
    ShowMessage('Hittar ej fordonet');
    Edit1.SetFocus;
    exit;
  end;

 { with DM1 do
  begin
    BoknrT.Filter := 'OBID = ''' + Edit1.Text + '''';
    BoknrT.Filtered := true;
    BoknrT.First;
    while not BoknrT.EOF AND (Val = -1) do
    begin
      if (not CB1.Checked and (BoknrTTDAT.value > strToDate(Edit2.Text))) then
      begin
        val := MessageDlg('Transfer datum kolliderar med befintlig bokning. Vill du fortsätta?',
        mtConfirmation, [mbYes, mbNo], 0);
      end
      else if (CB1.Checked and (BoknrTFDAT.value < strToDate(Edit2.Text))) then
      begin
        val := MessageDlg('Transfer datum kolliderar kanske med befintlig bokning. Vill du fortsätta?',
        mtConfirmation, [mbYes, mbNo], 0);
      end;
      BoknrT.Next;
    end;
    BoknrT.Filtered := false;
  end; }
  if Val = mrNo then
    exit;
  with DMod do
  begin
    if Editing then
      ObjdateT.Edit
    else
    begin
      ObjdateT.Cancel;
      ObjdateT.Append;
    end;
    ObjdateT.Fieldbyname('Reg_no').AsString := Edit1.Text;
    ObjdateT.Fieldbyname('TransDate').AsString := Edit2.Text;
    ObjdateT.Fieldbyname('TransIn-out').value := CB1.Checked;
    ObjdateT.Fieldbyname('Where').AsString := Edit3.Text;
    ObjdateT.Fieldbyname('TransCode').AsString := Edit4.Text;
    ObjdateT.fieldbyname('Sign').AsString := frmmain.Statusbar1.Panels[1].text;
    ObjdateT.fieldbyname('NotDate').value := date;
    ObjdateT.Fieldbyname('Objtyp').text := frmgreg.ObjectsT.fieldbyname('Type').Asstring;
    ObjdateT.Post;
  end;
  PanelEnabled(true);
  DBGrid1.Visible := true;
  Panel4.Visible := false;
  DBGrid1.Refresh;
  Dmod.ObjDateT.active := False;
  Dmod.ObjDateT.CursorLocation := clUseClient;
  Dmod.ObjDateT.active := True;
  fixraknare;
end;

procedure TfrmObdat.FormDeactivate(Sender: TObject);
begin
  DBGrid1.Visible := true;
  Panel4.Visible := false;
end;

procedure TfrmObdat.Edit2Exit(Sender: TObject);
begin
  try
    with (Sender as TEdit) do
      Text := datetostr(strtodate(text));
  except
    on EConvertError do ShowMessage('Felaktigt datumformat');
  end;
end;

procedure TfrmObdat.Edit2Enter(Sender: TObject);
begin
  if (Sender as TEdit).Text < '!' then
    (Sender as TEdit).Text := DateToStr(now);
end;

procedure TfrmObdat.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F5 then
//!    Get_Date(Sender, 'Transaktionsdatum');
    if Key = VK_DOWN then // Öka tid
      (Sender as TEdit).Text := Datetostr(StrToDate((Sender as TEdit).Text) + 1);
  if Key = VK_UP then // Minska tid
    (Sender as TEdit).Text := Datetostr(StrToDate((Sender as TEdit).Text) - 1);
end;

procedure TfrmObdat.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    ActiveControl := FindNextControl(ActiveControl, true, true, false);
  end;
end;

procedure TfrmObdat.PanelEnabled(val: boolean);
begin
  Bitbtn1.enabled := val;
  Bitbtn2.enabled := val;
  Bitbtn3.enabled := val;
end;

procedure TfrmObdat.BtnFirstClick(Sender: TObject);
begin
  dmod.ObjDateT.First;
  fixraknare;
end;

procedure TfrmObdat.BtnMinEnClick(Sender: TObject);
begin
  dmod.ObjDateT.MoveBy(-1);
  fixraknare;
end;

procedure TfrmObdat.BtnPlusenClick(Sender: TObject);
begin
  dmod.ObjDateT.MoveBy(1);
  fixraknare;
end;

procedure TfrmObdat.BtnLastClick(Sender: TObject);
begin
  dmod.ObjDateT.Last;
  fixraknare;
end;

procedure TfrmObdat.BtnDelClick(Sender: TObject);
begin
  dmod.ObjDateT.Delete;
  fixraknare;
end;

procedure TfrmObdat.FixRaknare;
begin
  Dmod.ObjDateT.Open;
  btnRecNo.text := inttostr(Dmod.ObjDateT.RecNo);
  BtnTotRecNo.text := inttostr(Dmod.ObjDateT.recordcount);
end;

procedure TfrmObdat.DBGrid1CellClick(Column: TColumn);
begin
  fixraknare;
end;

procedure TfrmObdat.BtnFilterClick(Sender: TObject);
begin
  if btnfilter.Flat then
  begin
    Dmod.ObjDateT.filtered := False;
    btnfilter.Flat := False;
  end
  else
  begin
    if dbgrid1.SelectedField.AsString > '!' then
    begin
      Dmod.ObjDateT.filtered := False;
      Dmod.ObjDateT.Filter := dbgrid1.SelectedField.FieldName + '=''' + dbgrid1.SelectedField.asstring + '''';
      Dmod.ObjDateT.Filtered := True;
      btnfilter.Flat := True;
    end;
  end;
end;

procedure TfrmObdat.BtnASCClick(Sender: TObject);
begin
  dmod.ObjDateT.sort := dbgrid1.SelectedField.FieldName;
end;

procedure TfrmObdat.BtnDESCClick(Sender: TObject);
begin
  Dmod.objdatet.sort := dbgrid1.SelectedField.FieldName + ' DESC';
end;

procedure TfrmObdat.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fixraknare;
end;

end.

