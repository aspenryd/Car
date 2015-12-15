{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Bilbyte.pas
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
{ $Log:  13050: BILBYTE.pas 
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
{   Rev 1.0    2003-03-17 09:25:20  Supervisor
{ Start av vc
}
////////////////////////////////////////////////////////////////////
//  Copyright (c) 1997 MJUKVARUUTVECKLAREN Henry Aspenryd AB      //
//                                                                //
//                                                                //
//                                                                //
//                                                                //
//  Skapad: 1997-02-07 10:58:36                                   //
//                                                                //
// Noteringar :                                                   //
//                                                                //
//                                                                //
// Historia :                                                     //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////
unit BilByte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, comp2000;

type
  TfrmBilByte = class(TForm)
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn6: TBitBtn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label24: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit8: TEdit;
    Label23: TLabel;
    Panel3: TPanel;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    Edit7: TEdit;
    Edit9: TEdit;
    EditOID: TEdit;
    ComboBox1: TComboBox;
    Edit11: TEdit;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    EditDragBil: TEdit;
    ComboBox4: TComboBox;
    DateTimeViewer1: TDateTimeViewer;
    DateTimeViewer2: TDateTimeViewer;
    DateTimeViewer3: TDateTimeViewer;
    DateTimeViewer4: TDateTimeViewer;
    procedure SkapaBokning(OBID: real);
    procedure ClearAll;
    procedure SparaObjekt;
    function BokningOK: Boolean;
    function BilCheck: Boolean;
    procedure AnpassaFordon(FDate, TDate: TDateTime);
    procedure Book_Car(Sender: TObject);
    procedure HamtaKontrakt(KontrId: Integer);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit4Enter(Sender: TObject);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit7Enter(Sender: TObject);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit5Enter(Sender: TObject);
    procedure Edit9Exit(Sender: TObject);
    procedure EditOIDExit(Sender: TObject);
    procedure EditOIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowfrmByte;

var
  frmBilByte: TfrmBilByte;

implementation

//uses Data1, KontrSrc, Kalender, Bokning, hyrbok, Prislist, Login, Data4;

{$R *.DFM}

procedure ShowfrmByte;
begin
  frmBilByte := TfrmBilByte.Create(application);
  try
    frmBilByte.ShowModal;
  finally
    frmBilByte.free;
  end;
end;

procedure TfrmBilByte.BitBtn6Click(Sender: TObject);
begin
{  with KontrSearchForm do
  begin
    AterQ.Close;
    Caption := 'Återlämning';
    DBGrid1.Datasource := AterS;
    AterQ.Open;
    BitBtn3.Visible := false;
  end;
  KontrSearchForm.ShowModal;
  if KontrSearchForm.ModalResult = mrOK then
    HamtaKontrakt(Trunc(KontrSearchForm.AterQKontrId.value));
  }
end;

procedure TfrmBilByte.HamtaKontrakt(KontrId: Integer);
begin
  // Här hämtas kontrakt
(*  if not DM1.KontrT.FindKey([KontrId]) then
    ShowMessage('Hittar ej kontrakt')
  else
  begin
    Label16.caption := DM1.KontrTKONTRID.AsString;
    Edit2.Text := DM1.KontrTKID.value;
    if DM1.KundrT.locate('PERS_NR', DM1.KontrTKID.value, [{loCaseInsensitive}]) Then
    Begin
      Label17.Caption := DM1.KundrTKUNDID.value;
      Label18.Caption := DM1.KundrTNamn.value + ', ' + DM1.KundrTAdress.value + ', ' + DM1.KundrTPOSTORT.value;
    end;

    //**** Kontrakts objekt ******
    if DM1.KtrObjT.locate('KONTRID', KontrID, [{loCaseInsensitive}]) Then
    begin
      Label23.caption := DM1.KtrObjTKNTOBID.AsString;
      if DM1.ObjktT.Findkey([DM1.KtrObjTOID.value]) then
        Label15.caption := DM1.ObjktTMODELL.value;
      Edit1.Text := DM1.KtrObjTOID.value;
      EditFrom_dat.Text := DM1.KtrObjTFROM_DAT.AsString;
      EditFrom_tid.Text := Copy(TimeToStr(DM1.KtrObjTFROM_TID.value),1,5);
      EditTill_dat.Text := DM1.KtrObjTTILL_DAT.AsString;
      EditTill_tid.Text := Copy(TimeToStr(DM1.KtrObjTTILL_TID.value),1,5);
      Edit3.Text := DM1.KtrObjTUTLM_DAT.AsString;
      Edit6.Text := Copy(TimeToStr(DM1.KtrObjTUTLM_TID.value),1,5);
      Edit8.text := DM1.KtrObjTKM_UT.AsString;
      Combobox2.Text := DM1.KtrObjTPTYP.AsString;
      Combobox3.Text := DM1.KtrObjTPKLASS.AsString;
      if DM1.KtrObjTDRAGBIL.AsString > '!' then
      begin
        EditDragBil.Text := DM1.KtrObjTDRAGBIL.AsString;
        EditDragBil.visible := true;
        Label27.visible := true;
      end else begin
        Label27.visible := false;
        EditDragBil.visible := false;
      end;

//      Edit4.Text := EditFrom_dat.Text;
//      Edit7.Text := EditFrom_tid.Text;
//      Edit5.Text := EditTill_dat.Text;
//      Edit9.Text := EditTill_tid.Text;
      Edit4.SetFocus;
    end;
  end;
  *)
end;

procedure TfrmBilByte.FormActivate(Sender: TObject);
begin
  Edit1.SetFocus;
  ClearAll;
end;

procedure TfrmBilByte.ClearAll;
begin
{  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  Edit7.Clear;
  Edit8.Clear;
  Edit9.Clear;
  EditOID.Clear;
  Edit11.Clear;
  EditFrom_dat.Clear;
  EditFrom_tid.Clear;
  EditTill_dat.Clear;
  EditTill_tid.Clear;
  Label15.Caption := '';
  Label16.Caption := '';
  Label17.Caption := '';
  Label18.Caption := '';
  Label19.Caption := '';
  Label20.Caption := '';
  Label21.Caption := '';
  Label22.Caption := '';
  Label23.Caption := '';
  Combobox1.Clear;
  DM1.ObtypT.First;
  while not DM1.ObtypT.EOF do
  begin
    Combobox1.Items.Add(DM1.ObtypTTYP.value);
    DM1.ObtypT.Next;
  end;
  Combobox1.ItemIndex := 0;
  With ComboBox4 do
  begin
    clear;
    DM4.SignrT.First;
    While not DM4.SignrT.EOF do
    begin
      items.add(DM4.SignrT.FieldByName('NAMN').value);
      DM4.SignrT.next;
    end;
    ItemIndex := 0;
    Text := '';
    if frmLogin.inne then
      text := frmLogin.namn;
  end;
  }
end;

procedure TfrmBilByte.Edit4Enter(Sender: TObject);
begin
{  if (Sender as TEdit).Text < '!' then
    if (Sender as TEdit) = Edit4 then
      (Sender as TEdit).Text := DateToStr(now);
    }
end;

procedure TfrmBilByte.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
  if key = VK_F5 then
    if (Sender as TEdit) = Edit4 then
      Get_Date(Sender, 'Bytes datum');
      }
end;

procedure TfrmBilByte.Edit7Enter(Sender: TObject);
//var
//  Hour, Min, Sec, Msec : Word;
//  diff : real;
begin
{  DecodeTime(now,Hour,Min,Sec,Msec);
  diff := Min / DM1.ParamTMINUT_INTERVALL.value;
  if frac(diff) > 0 then
  begin
    MIN := trunc((trunc(diff)+1)*DM1.ParamTMINUT_INTERVALL.value);
    if Min >= 60 then
    begin
      inc(hour);
      min := min - 60;
    end;
  end;
  if (Sender as TEdit).Text < '!' then
    (Sender as TEdit).Text := Copy(TimeToStr(EncodeTime(Hour,Min,0,0)),1,5);
    }
end;

procedure TfrmBilByte.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//var
//  Tid : TDateTime;
//  Hour, Min : word;
begin
{  Hour := 0;
  Min := Trunc(DM1.ParamTMINUT_INTERVALL.value);
  if Min > 59 then
  begin
    Hour := Min div 60;
    Min := Trunc(frac(Min / 60) * 60);
  end;
  Tid := EncodeTime(Hour,Min,0,0);
  if Key = VK_UP then  // Öka tid
    (Sender as TEdit).Text := Copy(timetostr(StrToTime((Sender as TEdit).Text) + Tid),1,5);
  if Key = VK_DOWN then  // Minska tid
    (Sender as TEdit).Text := Copy(timetostr(StrToTime((Sender as TEdit).Text) - Tid),1,5);
 }
end;

procedure TfrmBilByte.BitBtn2Click(Sender: TObject);
begin
  if not BokningOK then
    ShowMessage('Förlängningen kolliderar med andra bokningar')
  else
    SparaObjekt;
end;

procedure TfrmBilByte.SparaObjekt;
begin
    //  **** Spara gamla objektet
(*    DM1.KtrObjT.locate('KNTOBID', label23.caption, [{loCaseInsensitive}]);
    DM1.KtrObjT.Edit;
    DM1.KtrObjTATER_DAT.value := strtodate(Edit4.Text);
    DM1.KtrObjTATER_TID.value := strtotime(Edit5.Text);
    DM1.KtrObjTKM_IN.AsString := Edit9.Text;
    DM1.KtrObjTSTATUS.value := 2;
    DM1.KtrObjT.Post;
    // **** Lägg till nytt objekt
    //  KtrObjTKNTOBID
    DM1.KtrObjT.Insert;
    DM1.KtrObjTKONTRID.AsString := Label16.Caption;
    DM1.ObTypT.First;
    while (not DM1.ObTypT.EOF) and (DM1.ObTypTTYP.value <> ComboBox1.Text) do
      DM1.ObTypT.Next;
    DM1.KtrObjTOBTYP.value := DM1.ObTypTNR.AsInteger;
    DM1.KtrObjTOID.value := EditOID.text;
    DM1.KtrObjTFROM_DAT.value := StrToDate(Edit4.text);
    DM1.KtrObjTFROM_TID.value := strToTime(Edit5.text);
    DM1.KtrObjTTILL_DAT.value := StrToDate(EditTILL_DAT.text);
    DM1.KtrObjTTILL_TID.value := StrToTime(EditTILL_TID.text);
    DM1.KtrObjTUTLM_DAT.value := StrToDate(Edit4.Text);
    DM1.KtrObjTUTLM_TID.value := StrToTime(Edit5.Text);
  //  KtrObjTATER_DAT: TDateField
  //  KtrObjTATER_TID: TTimeField
    DM1.KtrObjTKM_UT.AsString := Edit7.Text;
  //  KtrObjTKM_IN: TFloatField
    DM1.KtrObjTPKLASS.AsString := Combobox3.text;
    DM1.KtrObjTPTYP.AsString := Combobox2.text;
    DM1.KtrObjTSTATUS.value := 1;
  //  KtrObjTHKOSTN: TFloatField
  //  KtrObjTKMKOSTN: TFloatField
  //  KtrObjTOVERKM: TFloatField
  //  KtrObjTXDYGN: TFloatField
  //  KtrObjTSUM: TFloatField
  //  KtrObjTSRRED: TFloatField
  //  KtrObjTOVRTEXT1: TStringField
  //  KtrObjTOVRTEXT2: TStringField
  //  KtrObjTHKOSTNTEXT: TStringField
  //  KtrObjTKMKOSTNTEXT: TStringField
  //  KtrObjTOVERKMTEXT: TStringField
  //  KtrObjTXDYGNTEXT: TStringField
  //  KtrObjTMOMSTEXT: TStringField
  //  KtrObjTOVR1: TFloatField
  //  KtrObjTOVR2: TFloatField
  //  KtrObjTRAB1: TSmallintField
  //  KtrObjTRAB2: TSmallintField
  //  KtrObjTHYRK: TFloatField
  //  KtrObjTVARAV_MOMS: TFloatField
  //  KtrObjTDEPRES: TFloatField
  //  KtrObjTTOTAL: TFloatField
//    DM1.KtrObjTKNOT1.value := Edit15.text;
//    DM1.KtrObjTKNOT2.value := Edit12.text;
    DM1.KtrObjTINOT.value := 'Fordonsbyte från ' + Edit1.Text;
//    DM1.KtrObjTINOT2.value := Edit14.text;
    DM1.KtrObjTDRAGBIL.value := EditDragBil.Text;
    DM1.KtrObjTBYTESOBID.AsString := label23.caption;
    DM1.KtrObjT.Post;
    // Lägg till bokning
//    ShowMessage('4');

    SkapaBokning(DM1.KtrObjTKNTOBID.value);
    *)
end;

procedure TfrmBilByte.SkapaBokning(OBID: real);
begin
(*  if DM1.ktrObjT.locate('KNTOBID', OBID, [{loCaseInsensitive}]) then
    with DM1 do
    begin
      BoknrT.Cancel;
      BoknrT.Append;
      BoknrTOBJNR.value := KtrObjTOBTYP.value;
    //  BoknrTOBJTYP.value := ;
      BoknrTOBID.value := KtrObjTOID.value;
      BoknrTFDAT.value := KtrObjTUTLM_DAT.value;
      BoknrTFTID.value := KtrObjTUTLM_TID.value;
      BoknrTTDAT.value := KtrObjTTILL_DAT.value;
      BoknrTTTID.value := KtrObjTTILL_TID.value;
      if KontrT.locate('KONTRID',KtrObjTKONTRID.value, [{loCaseInsensitive}]) then
      begin
        BoknrTKNUMMER.value := KontrTKID.value;
        BoknrTFNUMMER.value := KontrTFID.value;
      end;
      BoknrTSTATUS.value := 2;
      if DM4.SignrT.Locate('NAMN', Combobox4.text, [{loCaseInsensitive}]) then
        BoknrTSign.value := DM4.SignrT.FieldByName('SIGN').value;
      BoknrTBOKNINGSTID.value := now;
      BoknrT.Post;
    end;
    *)
end;

function TfrmBilByte.BokningOK: Boolean;
// var
//  OID : string;
//  BokId, OldStatus : Integer;
//  TDate, FDate, OldTDate, OldFDate : TdateTime;
begin
  result := true;
(*  OldStatus := 0;
  if DM1.BoknrT.Locate('KONTRID', Label16.caption, [{loCaseInsensitive}]) then
  begin
    BokId := DM1.BoknrTBOKID.value;
    OldStatus := Trunc(DM1.BoknrTSTATUS.value);
    DM1.BoknrT.Edit;
    DM1.BoknrTSTATUS.value := 2;
    DM1.BoknrT.Post;
  end
  else
    BokId := 0;
  result := false; // Fordonet är uppbokat
  OldFDate := strtodate(Edit4.Text)+strtotime(Edit5.Text);
  OldTDate := strtodate(EditTill_dat.Text)+strtotime(EditTill_tid.Text);
  OID := Edit1.Text;
  if frmBokning.GetFreeTime(FDate, TDate, OldFDate, OldTDate, OID) then
  begin
    result := true;
    if (FDate-OldFDate > 0) OR (TDate-OldTDate < 0) then
    begin
       // Fordonet delvis Ledigt
      if MessageDlg('Fordonet är delvis uppbokat. Vill du anpassa bokningen efter fordonet?',
      mtInformation, [mbYes, mbNo], 0) = mrYes then
      begin
        //AnpassaFordon(FDate, TDate);
        Edit4.Text := DateToStr(FDate);
        Edit7.Text := TimeToStr(FDate);
        Edit5.Text := DateToStr(TDate);
        Edit9.Text := TimeToStr(TDate);
      end
      else
        exit;
    end;
{    DM1.KtrObjT.Edit;
    DM1.KtrObjTFROM_DAT.value := StrToDate(Edit4.Text);
    DM1.KtrObjTFROM_TID.value := StrToTime(Edit5.Text);
    DM1.KtrObjTTILL_DAT.value := StrToDate(Edit4.Text);
    DM1.KtrObjTTILL_TID.value := StrToTime(Edit5.Text);
    DM1.KtrObjT.Post;
 }
  end;
  if (BokId > 0) AND (DM1.BoknrT.FindKey([BokId])) then
  begin
    DM1.BoknrT.Edit;
    DM1.BoknrTFDat.value := DM1.KtrObjTFROM_DAT.value;
    DM1.BoknrTFTid.value := DM1.KtrObjTFROM_TID.value;
    DM1.BoknrTTDat.value := DM1.KtrObjTTILL_DAT.value;
    DM1.BoknrTTTid.value := DM1.KtrObjTTILL_TID.value;
    DM1.BoknrTSTATUS.value := OldStatus;
    DM1.BoknrT.Post;
  end;
  *)
end;

procedure TfrmBilByte.Edit5Enter(Sender: TObject);
//var
//  Hour, Min, Sec, Msec : Word;
//  diff : real;
begin
(*  DecodeTime(now,Hour,Min,Sec,Msec);
  diff := Min / DM1.ParamTMINUT_INTERVALL.value;
  if frac(diff) > 0 then
  begin
    MIN := trunc((trunc(diff)+1)*DM1.ParamTMINUT_INTERVALL.value);
    if Min >= 60 then
    begin
      inc(hour);
      min := min - 60;
    end;
  end;
  if (Sender as TEdit).Text < '!' then
    (Sender as TEdit).Text := Copy(TimeToStr(EncodeTime(Hour,Min,0,0)),1,5);
  *)
end;

procedure TfrmBilByte.Edit9Exit(Sender: TObject);
begin
(*  if (Edit9.text = '') OR (strtoint(Edit9.Text) <= strtoint(Edit8.Text)) and (strtoint(Edit8.Text) <> 0) then
  begin
    Edit9.SetFocus;
    StopHere := true;
    ShowMessage('Du måste ange korrekt mätarställning');
  end
  else
    Edit11.Text := inttostr(strtoint(Edit9.Text) - strtoint(Edit8.Text));
  *)
end;

procedure TfrmBilByte.EditOIDExit(Sender: TObject);
begin
(*  if EditOID.Text > '!' then
    if DM1.ObjktT.Findkey([EditOID.Text]) then
    begin
      if not BilCheck then
        ShowMessage('Bilen är uppbokad')
      else
      begin
        if DM1.ObtypT.Locate('NR', DM1.ObjktTTYP.value, []) then
          ComboBox1.Text := DM1.ObtypTTYP.value;
        Edit7.Text := DM1.ObjktTKM_NU.AsString;
//        Edit7.SetFocus;
      end;
    end
    else begin
      showMessage('Bilen finns ej med i fordonsregistret');
      EditOID.SetFocus;
    end;
  *)
end;

function TfrmBilByte.BilCheck: Boolean;
//var
//  OID : string;
//  TDate, FDate, OldTDate, OldFDate : TdateTime;
begin
  result := true;
(*
  result := false; // Fordonet är uppbokat
  OldFDate := strtodate(Edit4.Text)+strtotime(Edit5.Text);
  OldTDate := strtodate(EditTill_dat.Text)+strtotime(EditTill_tid.Text);
  OID := EditOID.text;
  if frmBokning.GetFreeTime(FDate, TDate, OldFDate, OldTDate, OID) then
  begin
    result := true;
    if (FDate-OldFDate > 0) OR (TDate-OldTDate < 0) then
    begin
       // Fordonet delvis Ledigt
      if MessageDlg('Fordonet är delvis uppbokat. Vill du anpassa bokningen efter fordonet?',
      mtInformation, [mbYes, mbNo], 0) = mrYes then
      begin
        AnpassaFordon(FDate, TDate);
        EditOID.Text := OID;
      end;
    end
    else
      // Fordonet Ledigt
      EditOID.Text := OID;
  end;
  *)
end;

procedure TfrmBilByte.EditOIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F5 then
    book_car(sender);
end;

procedure TfrmBilByte.Book_Car(Sender: TObject);
//var
//  from, tom : string;
begin
(*  from := DateToStr(strtodate(Edit4.Text) + strtotime(Edit5.Text));
  tom := DateToStr(strtodate(EditTill_Dat.Text) + strtotime(EditTill_tid.Text));
  DM1.ObtypT.Filter := 'TYP = ''' + Combobox1.Text + '''';
  DM1.ObtypT.Filtered := true;
  DM1.ObtypT.Refresh;
  frmBokning.Find_car(from,tom,DM1.ObtypTNR.AsInteger);
  DM1.ObtypT.Filtered := false;
  if KontrSearchForm.ShowModal = mrOK then
    editOID.text := KontrSearchForm.QLedigaREGNR.AsString;
    *)
end;

procedure TfrmBilByte.AnpassaFordon(FDate, TDate: TDateTime);
//var
//  MarginTimeInMinutes : word;
//  MarginAsTime : Real;
begin
(*  MarginTimeInMinutes := 30;
  MarginAsTime := MarginTimeInMinutes / (24*60);
  // Från datum & tid
  if FDate > StrToDate(EditFrom_dat.Text) + StrToTime(EditFrom_tid.Text) then
  begin
    Edit4.Text := dateTostr(FDate);
    Edit5.Text := Copy(TimeTostr(Fdate-MarginAsTime),1,5);
  end;
  // Till datum & tid
  if TDate < StrToDate(EditTill_dat.Text) + StrToTime(EditTill_tid.Text) then
  begin
    EditTill_dat.Text := dateTostr(TDate);
    EditTill_tid.Text := Copy(TimeTostr(Tdate+MarginAsTime),1,5);
  end;
  *)
end;

procedure TfrmBilByte.Edit4Exit(Sender: TObject);
begin
(*  try
    if strToDate(Edit4.Text) > strToDate(EditTill_Dat.text) then
    begin
      ShowMessage('Datum får ej vara senare än "Till" datum.');
      Edit4.SetFocus;
    end;
  except
    on EConvertError do //Nothing
  end;
  *)
end;

procedure TfrmBilByte.Edit5Exit(Sender: TObject);
begin
(*  if strToDate(Edit4.Text) + strToTime(Edit5.text) >
  strToDate(EditTill_Dat.text) + strToTime(EditTill_Tid.text) then
  begin
    ShowMessage('Tidpunkt får ej vara senare än "Till" tid.');
    Edit5.SetFocus;
  end;
  *)
end;

procedure TfrmBilByte.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//var
//  Tid : TDateTime;
//  Hour, Min : word;
begin
(*  Hour := 0;
  Min := Trunc(DM1.ParamTMINUT_INTERVALL.value);
  if Min > 59 then
  begin
    Hour := Min div 60;
    Min := Trunc(frac(Min / 60) * 60);
  end;
  Tid := EncodeTime(Hour,Min,0,0);
  if Key = VK_UP then  // Öka tid
    (Sender as TEdit).Text := Copy(timetostr(StrToTime((Sender as TEdit).Text) + Tid),1,5);
  if Key = VK_DOWN then  // Minska tid
    (Sender as TEdit).Text := Copy(timetostr(StrToTime((Sender as TEdit).Text) - Tid),1,5);
    *)
end;

procedure TfrmBilByte.ComboBox3Change(Sender: TObject);
begin
(*  if ComboBox3.Text <> '' then
  With ComboBox2 do
  begin
    clear;
    DM1.PrisrT.Filter := PrisTid + ' AND PKLASS = ' + ComboBox3.Text;
    DM1.PrisrT.Filtered := true;
    DM1.PrisrT.Refresh;
    DM1.PrisrT.First;
    While not DM1.PrisrT.EOF do
    begin
      items.add(DM1.PrisrTPTYP.value);
      DM1.PrisrT.next;
    end;
    text := Items[0];
    ItemIndex := 0;
  end;
  DM1.PrisrT.Filtered := false;
  *)
end;

procedure TfrmBilByte.ComboBox3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
(*
  if Key = VK_F5 then
  begin
    PrisDlg.Edit1.Text := Combobox3.text;
    if PrisDlg.ShowModal = mrOK then
    begin
      Combobox3.text := PrisDlg.Table1PKLASS.AsString;
      Combobox2.text := PrisDlg.Table1PTYP.AsString;
    end;
  end;
 *)
end;

procedure TfrmBilByte.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F5 then
    BitBtn6Click(nil);
end;

end.

