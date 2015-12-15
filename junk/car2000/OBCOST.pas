{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Obcost.pas
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
{ $Log:  13084: OBCOST.pas 
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
unit ObCost;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ToolWin,
  ComCtrls, adodb;

type
  TfrmObCost = class(TForm)
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    Regnr: TLabel;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    ToolBar1: TToolBar;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
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
    procedure Clear;
    procedure LoadPost;
    procedure PanelEnabled(val: boolean);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDeactivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure BtnFirstClick(Sender: TObject);
    procedure BtnMinEnClick(Sender: TObject);
    procedure BtnPlusenClick(Sender: TObject);
    procedure BtnLastClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure FixRaknare;
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnFilterClick(Sender: TObject);
    procedure BtnASCClick(Sender: TObject);
    procedure BtnDESCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Editing: Boolean;
  end;

function StrToCur(str: TEdit): currency;

var
  frmObCost: TfrmObCost;

implementation

uses Login, Greg, Data2, Datamodule, Main; //!Kalender,

{$R *.DFM}

procedure TfrmObCost.Button2Click(Sender: TObject);
begin
  PanelEnabled(true);
  DBGrid1.Visible := true;
  Panel4.Visible := false;
  Dmod.ObjCostT.active := False;
  Dmod.ObjCostT.CursorLocation := clUseClient;
  Dmod.ObjCostT.active := True;
end;

procedure TfrmObCost.FormActivate(Sender: TObject);
begin
  Dmod.ObjCostT.active := False;
  Dmod.ObjCostT.CursorLocation := clUseClient;
  Dmod.ObjCostT.active := True;
  with Combobox1 do
  begin
    clear;
    items.add('Alla fordon');
    frmgreg.objectsT.ReSync([RMCenter]);
    frmgreg.objectsT.First;
    while not frmgreg.objectsT.EOF do
    begin
      items.add(frmgreg.objectsT.fieldbyname('REG_No').AsString);
      frmgreg.objectsT.next;
    end;
    itemindex := 0;
  end;
  DBGrid1.Visible := true;
  Panel4.Visible := false;
  FixRaknare;
end;

procedure TfrmObCost.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    ActiveControl := FindNextControl(ActiveControl, true, true, false);
  end;
end;

procedure TfrmObCost.FormDeactivate(Sender: TObject);
begin
  DBGrid1.Visible := true;
  Panel4.Visible := false;
end;

procedure TfrmObCost.Button1Click(Sender: TObject);
begin
//!  if not frmgreg.ObjktT.Findkey([Edit1.Text]) then
  if not frmgreg.ObjectsT.locate('Reg_no', Edit1.Text, [lopartialkey]) then
  begin
    ShowMessage('Hittar ej fordonet');
    Edit1.SetFocus;
    exit;
  end;

  with dmod do
  begin
    if Editing then
      ObjCostT.Edit
    else
    begin
      ObjCostT.Cancel;
      ObjCostT.Append;
    end;
    ObjCostT.fieldbyname('Reg_No').value := Edit1.Text;
    ObjCostT.fieldbyname('CostDat').AsString := Edit2.Text;
    ObjCostT.fieldbyname('Measure').value := Edit5.Text;
    ObjCostT.fieldbyname('Cost').AsString := Edit3.Text;
    ObjCostT.fieldbyname('Vat').AsString := Edit4.Text;
    ObjCostT.fieldbyname('Total').AsString := Edit6.Text;
    ObjCostT.fieldbyname('Sign').AsString := frmMain.sign;
    ObjCostT.fieldbyname('NotDate').value := date;
    ObjCostT.Post;
  end;
  Button2Click(nil);
  DBGrid1.Refresh;
  FixRaknare;
  Dmod.ObjCostT.active := False;
  Dmod.ObjCostT.CursorLocation := clUseClient;
  Dmod.ObjCostT.active := True;
end;

procedure TfrmObCost.Clear;
begin
  DBGrid1.Visible := false;
  Panel4.Visible := true;
  Edit1.Clear;
  Edit2.Clear;
  Edit5.Clear;
  Edit3.text := '0';
  Edit4.text := '0';
  Edit6.text := '0';
end;

procedure TfrmObCost.BitBtn1Click(Sender: TObject);
begin
  Dmod.ObjCostT.active := False;
  Dmod.ObjCostT.CursorLocation := clUseClient;
  Dmod.ObjCostT.active := True;
  Clear;
  Editing := false;
  PanelEnabled(false);
  if Combobox1.itemindex > 0 then
    Edit1.Text := Combobox1.Text;
  Editing := false;
  Edit1.SetFocus;
end;

procedure TfrmObCost.PanelEnabled(val: boolean);
begin
  Bitbtn1.enabled := val;
  Bitbtn2.enabled := val;
  Bitbtn3.enabled := val;
end;

procedure TfrmObCost.BitBtn3Click(Sender: TObject);
begin
  Dmod.ObjCostT.active := False;
  Dmod.ObjCostT.CursorLocation := clUseClient;
  Dmod.ObjCostT.active := True;
  if DMod.ObjCostT.Fieldbyname('CostId').value > 0 then
  begin
    PanelEnabled(false);
    Clear;
    Editing := true;
    if Combobox1.itemindex > 0 then
      Edit1.Text := Combobox1.Text;
    LoadPost;
    Edit1.SetFocus;
  end
  else
    ShowMessage('Välj befintlig post');
end;

procedure TfrmObCost.LoadPost;
begin
  with dmod do
  begin
    Edit1.Text := ObjCostT.Fieldbyname('Reg_No').value;
    Edit2.Text := ObjCostT.Fieldbyname('CostDat').AsString;
    Edit3.Text := ObjCostT.Fieldbyname('Cost').AsString;
    Edit4.Text := ObjCostT.Fieldbyname('Vat').AsString;
    Edit5.Text := ObjCostT.Fieldbyname('Measure').AsString;
    Edit6.Text := ObjCostT.Fieldbyname('Total').AsString;
  end;
end;

procedure TfrmObCost.Edit3Exit(Sender: TObject);
begin
  Edit4.Text := floattostr(StrToCur(Edit3) * (DMod.ParamT.fieldbyname('MOMS').value / 100));
  Edit4.Refresh;
  Edit4Exit(nil);
end;

procedure TfrmObCost.Edit4Exit(Sender: TObject);
var sum, moms: currency;
begin
  Sum := StrToCur(Edit3);
  Moms := StrToCur(Edit4);
  Edit6.text := format('%m', [(sum + moms)]);
end;

function StrToCur(str: TEdit): currency;
begin
  result := 0;
  try
    result := strtofloat(str.text);
  except
    str.text := '0';
  end;
end;

procedure TfrmObCost.ComboBox1Click(Sender: TObject);
begin
  if Combobox1.Itemindex > 0 then
  begin
    DMod.ObjCostT.filter := 'Reg_No = ''' + Combobox1.Text + '''';
    DMod.ObjCostT.filtered := true;
  end
  else
    DMod.ObjCostT.filtered := false;
end;

procedure TfrmObCost.Edit2Enter(Sender: TObject);
begin
  if (Sender as TEdit).Text < '!' then
    (Sender as TEdit).Text := DateToStr(now);
end;

procedure TfrmObCost.Edit2Exit(Sender: TObject);
begin
  try
    with (Sender as TEdit) do
      Text := datetostr(strtodate(text));
  except
    on EConvertError do ShowMessage('Felaktigt datumformat');
  end;
end;

procedure TfrmObCost.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F5 then
//!    Get_Date(Sender, 'Kostnadsdatum');
    if Key = VK_DOWN then // Öka tid
      (Sender as TEdit).Text := Datetostr(StrToDate((Sender as TEdit).Text) + 1);
  if Key = VK_UP then // Minska tid
    (Sender as TEdit).Text := Datetostr(StrToDate((Sender as TEdit).Text) - 1);
end;

procedure TfrmObCost.BitBtn2Click(Sender: TObject);
begin
  DMod.ObjCostT.filtered := false;
  frmobcost.Close;
end;

procedure TfrmObCost.BtnFirstClick(Sender: TObject);
begin
  Dmod.ObjCostS.DataSet.First;
  FixRaknare;
end;

procedure TfrmObCost.BtnMinEnClick(Sender: TObject);
begin
  Dmod.ObjCostS.DataSet.MoveBy(-1);
  FixRaknare;
end;

procedure TfrmObCost.BtnPlusenClick(Sender: TObject);
begin
  Dmod.ObjCostS.DataSet.MoveBy(1);
  FixRaknare;
end;

procedure TfrmObCost.BtnLastClick(Sender: TObject);
begin
  Dmod.ObjCostS.DataSet.Last;
  FixRaknare;
end;

procedure TfrmObCost.BtnDelClick(Sender: TObject);
begin
  Dmod.ObjCostS.DataSet.Delete;
  FixRaknare;
end;

procedure TfrmObCost.FixRaknare;
begin
  Dmod.ObjCostT.Open;
  btnRecNo.text := inttostr(Dmod.ObjCostT.RecNo);
  BtnTotRecNo.text := inttostr(Dmod.ObjCostT.recordcount);
end;

procedure TfrmObCost.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FixRaknare;
end;

procedure TfrmObCost.DBGrid1CellClick(Column: TColumn);
begin
  FixRaknare;
end;

procedure TfrmObCost.BtnFilterClick(Sender: TObject);
begin
  if btnfilter.Flat then
  begin
    Dmod.ObjCostT.filtered := False;
    btnfilter.Flat := False;
  end
  else
  begin
    if dbgrid1.SelectedField.AsString > '!' then
    begin
      Dmod.ObjCostT.filtered := False;
      Dmod.ObjCostT.Filter := dbgrid1.SelectedField.FieldName + '=''' + dbgrid1.SelectedField.asstring + '''';
      Dmod.ObjCostT.Filtered := True;
      btnfilter.Flat := True;
    end;
  end;
end;

procedure TfrmObCost.BtnASCClick(Sender: TObject);
begin
  dmod.ObjCostT.sort := dbgrid1.SelectedField.FieldName;
end;

procedure TfrmObCost.BtnDESCClick(Sender: TObject);
begin
  Dmod.ObjCostT.sort := dbgrid1.SelectedField.FieldName + ' DESC';
end;

end.

