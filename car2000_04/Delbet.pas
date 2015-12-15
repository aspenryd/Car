{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Delbet.pas
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
{ $Log:  14838: Delbet.pas 
{
{   Rev 1.0    2004-08-18 11:00:52  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.4    2004-08-10 10:45:40  pb64
}
{
{   Rev 1.3    2003-11-27 13:49:26  peter
{ Bokningsgraf bokning sedan dubbelklick gav fel.
{ Fix av delbetalar kontroll
{ Fix av ett fel inträffar + avrundning av moms i prisberäkning.
}
{
{   Rev 1.2    2003-11-11 11:51:36  peter
{ Fixat kontroll så att en kund kan inte registreras flera gånger på kontraktet.
}
{
{   Rev 1.1    2003-10-14 11:35:24  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.0    2003-03-20 14:00:24  peter
}
{
{   Rev 1.0    2003-03-17 14:41:44  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:58  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
unit Delbet;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, DB, Dialogs;

type
  TdlgDelbetalare = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox8: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label3: TLabel;
    lblKontakt: TLabel;
    Label8: TLabel;
    edtDelBet: TEdit;
    edtKontakt: TEdit;
    cbBetalning: TComboBox;
    cbForsakring: TCheckBox;
    GroupBox4: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit7: TEdit;
    Label2: TLabel;
    Edit8: TEdit;
    Label5: TLabel;
    Edit9: TEdit;
    cbProcent: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label35: TLabel;
    gbCard: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    CheckBox3: TCheckBox;
    Edit18: TEdit;
    Edit19: TEdit;
    cbCard: TComboBox;
    pnlBetVillkor: TPanel;
    SpeedButton1: TSpeedButton;
    lblOrgNo: TLabel;
    procedure ClearFields;
    procedure SetBetSatt(KID: string);
    procedure cbProcentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbBetalningExit(Sender: TObject);
    procedure cbForsakringClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtDelBetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDelBetExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbBetalningKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbBetalningClick(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtDelBetChange(Sender: TObject);
    procedure edtKontaktExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    BetVilkor: Integer;
    New: Boolean;
    PartId, KontaktId: Integer;
    procedure LoadDelbet(cuid: string);
    procedure LoadKontakt(cuid: string);
  end;

var
  dlgDelbetalare: TdlgDelbetalare;

const stdBetVilkor = 30;

implementation

uses Kontrakt, BetVilk, tmpData, search, Greg, Funcs, Datamodule, Main,
  DateUtil;

//uses Data1, BetVilk, Kontrakt, GReg, Funcs, Data2;

{$R *.DFM}

procedure TdlgDelbetalare.cbProcentClick(Sender: TObject);
begin
  if cbProcent.checked then
  begin
    label6.Caption := '%';
    label7.Caption := '%';
    label9.Caption := '%';
  end
  else
  begin
    label6.Caption := 'Kr';
    label7.Caption := 'Kr';
    label9.Caption := 'Kr';
  end;
  Edit7.Text := '0';
  Edit8.Text := '0';
  Edit9.Text := '0';
end;

procedure TdlgDelbetalare.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  cbBetalning.clear;
  for I := 0 to length(PayAlts) - 1 do
    cbBetalning.Items.add(PayAlts[i].Name);
  cbBetalning.Itemindex := GetBetIndex(DefBetSt);

  cbCard.Clear;
  for I := 0 to length(CCards) - 1 do
    cbCard.Items.add(CCards[i].Name);
  cbCard.Itemindex := 0;
end;

procedure TdlgDelbetalare.ClearFields;
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := visibledatetostr(date);
  Edit4.Text := '';
  Edit5.Text := '';
  Edit6.Text := '';
  Edit7.Text := '0';
  Edit8.Text := '0';
  Edit9.Text := '0';
  edtDelBet.Text := '';
  edtKontakt.Text := '';
  Edit18.Text := '';
  Edit19.Text := '';
  Label3.Caption := '';
  lblKontakt.Caption := '';
  pnlBetVillkor.caption := inttostr(stdDays);
  cbBetalning.Itemindex := GetBetIndex(DefBetSt);
  cbCard.text := '';
  BetVilkor := stdBetVilkor;
  cbProcent.Checked := true;
  Checkbox3.Checked := false;
  cbForsakring.Checked := false;
  Groupbox4.visible := false;
  gbCard.visible := false;
end;

procedure TdlgDelbetalare.cbBetalningExit(Sender: TObject);
var
  konto, kstalle: integer;
begin
  if PayAlts[cbBetalning.itemindex].code = 'I' then
    if not frmKontrakt.IsInternKund(PartId, Konto, Kstalle) then
    begin
      MessageDlg('Kunden är ej en internkund?', mtConfirmation, [mbOK], 0);
      (Sender as TCombobox).SetFocus;
    end
    else
      pnlBetVillkor.caption := '0';

  if PayAlts[cbBetalning.itemindex].code = 'F' then
  begin
    if lblOrgNo.Tag=1 then
    begin
      ShowMessage('INFO! Fakturakund kan inte vara markerad som utländsk!');
    end
    else
    begin
      if Not PNummerOK(lblOrgNo.Caption) then
        ShowMessage('INFO! Kundens Pers/Org nr är inte korrekt för att vara fakturakund!');
    end;
  end;


end;

procedure TdlgDelbetalare.cbForsakringClick(Sender: TObject);
begin
  Groupbox4.visible := cbForsakring.Checked;
end;

procedure TdlgDelbetalare.FormActivate(Sender: TObject);
begin
  if New then
    ClearFields;
  edtDelBet.SetFocus;
end;

procedure TdlgDelbetalare.LoadDelbet(cuid: string);
var
  ptyp, payment: string;
  pterms: integer;
  fors: boolean;
begin
  frmSearch.GSQLString := 'Select Customer.name, Customer.Adress, Customer.Postal_name, Customer.Tel_nr_1, Customer.Org_no, Customer.Payment, Customer.Terms_pay, Customer.Ins_comp, Customer.utlandsk from Customer Where Cust_id = ' + cuid;
  if frmSearch.GetSearchResult then
  begin
    with frmSearch.GSearchCDS do
    begin
      edtDelBet.text := fieldbyname('Name').AsString;
      PartID := strtoint(Cuid);
      Label3.caption := ConcatCustInfo(fieldbyname('Org_no').AsString, fieldbyname('Adress').AsString, fieldbyname('Postal_name').AsString, fieldbyname('Tel_Nr_1').AsString, '');

      payment := FieldbyName('Payment').AsString;
      pterms := FieldbyName('Terms_pay').AsInteger;
      fors := FieldbyName('Ins_comp').AsBoolean;
      lblOrgNo.Caption := fieldbyname('Org_no').AsString;
      if FieldbyName('utlandsk').AsBoolean then lblOrgNo.Tag := 1 else lblOrgNo.Tag := 0;
      if Payment='F' then
      begin
        if FieldbyName('utlandsk').AsBoolean then
        begin
          ShowMessage('INFO! Fakturakund kan inte vara markerad som utländsk!');
        end
        else
        begin
          if Not PNummerOK(fieldbyname('Org_no').AsString) then
            ShowMessage('INFO! Kundens Pers/Org nr är inte korrekt för att vara fakturakund!');
        end;
      end;
//      if not Loading then
      begin
        if payment > '' then
          cbBetalning.itemindex := GetBetIndex(payment);
        if pterms > 0 then
          pnlBetVillkor.Caption := inttostr(pterms);
        cbForsakring.checked := fors;
      end;
    end;
  end
  else
  begin
    PartID := 0;
//    edtDelBet.text := '';
    Label3.caption := '';
  end;
end;

procedure TdlgDelbetalare.LoadKontakt(cuid: string);
begin
  frmSearch.GSQLString := 'Select Customer.name, Customer.Adress, Customer.Postal_name, Customer.Tel_nr_1, Customer.Org_no from Customer Where Cust_id = ' + cuid;
  if frmSearch.GetSearchResult then
  begin
    with frmSearch.GSearchCDS do
    begin
      KontaktID := strtoint(Cuid);
      edtKontakt.text := fieldbyname('Name').AsString;
      lblKontakt.caption := ConcatCustInfo(fieldbyname('Org_no').AsString, fieldbyname('Adress').AsString, fieldbyname('Postal_name').AsString, fieldbyname('Tel_Nr_1').AsString, '');
    end;
  end
  else
  begin
    KontaktID := 0;
//    edtDelBet.text := '';
    lblKontakt.caption := '';
  end;
end;

procedure TdlgDelbetalare.edtDelBetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F5 then
    if SearchCustomer((Sender as TEdit).text) then
      with frmSearch.SSearchCDS do
        if sender = edtDelBet then
          LoadDelBet(fieldbyname('Cust_Id').AsString)
        else
          LoadKontakt(fieldbyname('Cust_Id').AsString);
end;

procedure TdlgDelbetalare.edtDelBetExit(Sender: TObject);
begin
//!  021107 BAZ & LASP För att kunna hämta in även felaktiga personnummer...
//!  if frmGReg.CustomerT.Locate('Org_No',PNummerKoll((sender as TEdit).Text),[loPartialkey]) then
 if (sender as TEdit).Text >'!' then
 Begin
     Dmod.Q1.Active := False;
     if PartID=0 then
       Dmod.Q1.Sql.Text := 'Select Cust_id from customer where Org_No='+dbdel+(sender as TEdit).Text+dbdel+''
     else
       Dmod.Q1.Sql.Text := 'Select Cust_id from customer where Cust_Id='+IntToStr(PartId);
     Dmod.Q1.Active := True;
     if dmod.Q1.RecordCount > 0 then
     Begin
      if sender = edtDelBet then
      LoadDelbet(dmod.q1.fieldbyname('Cust_ID').AsString) else
       LoadKontakt(Dmod.q1.fieldbyname('Cust_Id').AsString);
     End
     else
     begin
       if sender = edtDelBet then
       begin
         ShowMessage('Du måste söka upp en kund innan du lämnar detta fält!');
         edtDelBet.SetFocus;
       end;
     end;
     dmod.q1.Active :=False;
 End;
//!  if frmGReg.CustomerT.Locate('Org_No',(sender as TEdit).Text,[loPartialkey]) then
//!   Begin
//!    if sender = edtDelBet then
//!    LoadDelbet(frmGReg.CustomerT.fieldbyname('Cust_Id').AsString) else
//!    LoadKontakt(frmGReg.CustomerT.fieldbyname('Cust_Id').AsString);
//!   end;
end;

procedure TdlgDelbetalare.SetBetSatt(KID: string);
var value, SetVal: string;
begin
{  DM1.KundrT.FindKey([KID]);
  value := DM1.KundrTBETSATT.value;
  if not DM1.BetstT.findkey([value]) then
    SetVal := DM1.ParamTDEF_BETSATT.value
  else
    SetVal := value;

  if DM1.BetstT.findkey([SetVal]) then
    combobox6.text := DM1.BetstTNAMN.value;

  if DM1.KundrTBETVILLKOR.value <= 0 then
    BetVilkor := stdBetVilkor
  else
    BetVilkor := DM1.KundrTBETVILLKOR.value;
  BetVillkorDlg.BetVillkor := BetVilkor;
  Label12.Caption := inttostr(BetVilkor);

  if (SetVal = 'F') OR (SetVal = 'U') then
  begin
    label12.visible := true;
    SpeedButton1.Visible := true;
  end
  else begin
    label12.visible := false;
    SpeedButton1.Visible := false;
  end;
  }
end;

procedure TdlgDelbetalare.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    ActiveControl := FindNextControl(ActiveControl, true, true, false);
  end;
end;

procedure TdlgDelbetalare.SpeedButton1Click(Sender: TObject);
var
  days: integer;
begin
  days := ShowDlgBetVillkor(strtoint(pnlBetVillkor.Caption));
  if days > 0 then
  begin
    pnlBetVillkor.Caption := inttostr(days);
  end;
end;

procedure TdlgDelbetalare.cbBetalningKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F5) and SpeedButton1.Visible then
    SpeedButton1Click(nil);
end;

procedure TdlgDelbetalare.cbBetalningClick(Sender: TObject);
begin
  gbCard.Visible := cbBetalning.Itemindex = 1;
  pnlBetVillkor.Visible := (cbBetalning.Itemindex = 2) or (cbBetalning.Itemindex = 3);
end;

procedure TdlgDelbetalare.Edit3Exit(Sender: TObject);
begin
  if Edit3.Text > '!' then
  try
    Edit3.Text := VisibleDateToStr(VisibleStrToDate(Edit3.Text));
  except
    Edit3.SetFocus;
    raise;
  end;
end;

procedure TdlgDelbetalare.BitBtn1Click(Sender: TObject);
begin
   if edtDelBet.Text='' then
   begin
     ShowMessage('En kund måste finnas!');
     ModalResult := mrNone;
     edtDelBet.SetFocus;
   end;
   if (New) and (DoesDelBetalareExist(dlgDelbetalare.PartID)) then
   begin
     ShowMessage('Denna kund finns redan registrerad på detta kontrakt!');
     ModalResult := mrNone;
     edtDelBet.SetFocus;
   end;

{  if DM1.BetstT.Locate('NAMN', combobox6.text, [loCaseInsensitive]) then
    if (DM1.BetstTKOD.value = 'F') AND (BetVilkor = 0) then
    begin
      ShowMessage('Betalningsvillkor måste vara större än 0 för faktura');
      combobox6.setfocus;
      modalresult := mrNone;
      abort;
    end;}
end;

procedure TdlgDelbetalare.edtDelBetChange(Sender: TObject);
begin
   PartId:=0;
end;

procedure TdlgDelbetalare.edtKontaktExit(Sender: TObject);
begin
  if (sender as TEdit).Text >'!' then
  Begin
     Dmod.Q1.Active := False;
     Dmod.Q1.Sql.Text := 'Select Cust_id from customer where Org_No='+dbdel+edtKontakt.Text+dbdel+'';
     Dmod.Q1.Active := True;
     if dmod.Q1.RecordCount > 0 then
     begin
       LoadKontakt(Dmod.q1.fieldbyname('Cust_Id').AsString);
     end;
     dmod.q1.Active :=False;
  End;
end;

end.

