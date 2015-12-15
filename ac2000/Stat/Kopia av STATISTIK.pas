{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat\Statistik.pas
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
{ $Log:  13033: STATISTIK.pas 
{
{   Rev 1.0    2003-03-20 13:59:34  peter
}
{
{   Rev 1.0    2003-03-17 14:39:46  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:08  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:10  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Statistik;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, LookOut, ImgList, Db, ADODB, Grids, DBGrids, DBCGrids, StdCtrls,
  TeeProcs, TeEngine, Chart, Series, QuickRpt, Qrctrls, Buttons;

type
  TFrmStat = class(TForm)
    ImageList1: TImageList;
    QStatS: TDataSource;   
    QStat: TADOQuery;
    Kstat: TADOQuery;
    KstatS: TDataSource;
    KundPanel: TPanel;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRFrom: TQRLabel;
    QRTO: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRIntDag: TQRLabel;
    QRHyrasnitt: TQRLabel;
    QRUtnyt: TQRLabel;
    QRNetto: TQRLabel;
    QRHyrD: TQRLabel;
    QRAvHy: TQRLabel;
    QRObjD: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRIntObj: TQRLabel;
    QRTotObj: TQRLabel;
    QRLabel6: TQRLabel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    GBPris: TGroupBox;
    LB: TListBox;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRPHyror: TQRLabel;
    QRLabel9: TQRLabel;
    QROHyror: TQRLabel;
    PStat: TPanel;
    Label16: TLabel;
    Label7: TLabel;
    Label17: TLabel;
    Label8: TLabel;
    Label18: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    Label12: TLabel;
    Label19: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    Label14: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label24: TLabel;
    Label15: TLabel;
    Label22: TLabel;
    Label13: TLabel;
    Label21: TLabel;
    Label9: TLabel;
    Label25: TLabel;
    PKund: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    GBObj: TGroupBox;
    LBO: TListBox;
    StatQ: TADOQuery;
    GB2: TGroupBox;
    LBTill: TListBox;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape3: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    PAObjST: TPanel;
    GroupBox2: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Panel2: TPanel;
    DBGrid2: TDBGrid;
    Od1: TOpenDialog;
    GroupBox4: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    procedure BtnKundClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EBTomClick(Sender: TObject);
    procedure BtnObjClick(Sender: TObject);
    procedure EBSamClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EBPrintClick(Sender: TObject);
    procedure ExpressButton3Click(Sender: TObject);
    procedure EBObjClick(Sender: TObject);
    procedure EBObjTypStatClick(Sender: TObject);
    Procedure FixaUrvalsDatum;
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ExpressButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  Typ: string;
  end;

var
  FrmStat: TFrmStat;
  Fd,TD:String;
  SBaz:string;
  forprinting:Boolean;

implementation

uses  UObjStat, QkundStat,
  StatUrval, QObjTyper, DmSession, Dmod, FormReg, Statiska, Bearb,
  FrmStatSamUrval, Stat_AntalBilar, Main;

{$R *.DFM}

procedure TFrmStat.BtnKundClick(Sender: TObject);
var
  dsum:Integer;
  t,tagen:Integer;
  qptyp:TQRLabel;
  frm:TFrmStatUrval;
  frm2:TFrmQKundStat;
  AYear, AMonth, ADay: Word;
begin
  BitBtn5.Click ;
  typ:='KundStat';
  PAObjST.Visible := False;
//! Fyll Combobox med Kunder
  qstat.Active :=False;
  qstat.sql.text:='SELECT Customer.Org_No FROM Customer ORDER BY Customer.Org_No';
  qstat.Active :=True;
  qstat.First;
  frm:=TFrmStatUrval.Create(self);
  Frm.Label1.Visible :=False;
  Frm.Edit1.Visible :=False;
  Frm.BFC_ComboBox1.Items.Clear;
  while not qstat.Eof do
  begin
   Frm.BFC_ComboBox1.Items.Add(qstat.fieldbyname('Org_No').asstring);
   qstat.next;
  end;
//! Hit
//!  FixaUrvalsDatum;
  DecodeDate(Now, AYear, AMonth, ADay);
  Frm.DateTimePicker1.date := EncodeDate(AYear, AMonth-1, 1);
  Frm.DateTimePicker2.date:=now-3;

  Frm.BFC_ComboBox1.ItemIndex :=0;
  Frm.showmodal;
  if frm.ModalResult = MrOK then
  begin
      BitBtn6.visible:=True;
      kstat.active := False;
      kstat.SQL.Text := 'SELECT Customer.Cust_Id, Customer.Name, Customer.Adress, Customer.Postal_Name, Customer.Country, Customer.Org_No, Customer.Tel_Nr_1 FROM Customer where Org_No like ''' + sbaz + '%''';
      kstat.active := True;
//! Flyytat från innan Clicked ok 010604
      Kundpanel.visible := True;
      PStat.visible := False;
      PKund.visible := True;
      gbpris.visible := false;
      gbobj.visible := False;
//! Hit
      Label1.caption := kstat.Fields[1].AsString; //!Namn
      Label2.caption := kstat.Fields[2].AsString; //!Adress
      Label3.caption := kstat.Fields[3].AsString; //!PostOrt
      Label4.caption := kstat.Fields[4].AsString; //!Land
      Label5.caption := kstat.Fields[5].AsString; //!Org Nr
      Label6.caption := kstat.Fields[6].AsString; //!Tele1
//! Label7.caption:=kstat.Fields[7].AsString;
//! Label8.caption:=kstat.Fields[8].AsString;
//! Label9.caption:=kstat.Fields[9].AsString;
      if (FD > '!') and (TD > '!') then
      begin
        qstat.active := False;
        qstat.sql.text:='SELECT Customer.Org_No AS SubName, Contr_Sub.ContrId, Contr_ObjT.OId, Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_SubCost.DSUM'+
        ' FROM Contr_Sub Contr_Sub LEFT JOIN Contr_ObjT ON Contr_Sub.ContrId = Contr_ObjT.ContrId INNER JOIN Customer ON Contr_Sub.SubName = Customer.Name LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId'+
        ' WHERE Contr_ObjT.To_Time > ' + fd + ' And Contr_ObjT.To_Time < ' + td + ' AND Customer.Org_No =''' + sbaz+ ''''+
        ' ORDER BY Contr_ObjT.To_Time;';
        QStat.active := True;
      end;
    frm2:=TFrmQKundStat.Create(self);
    frm2.QrFd.caption :=Fd;
    frm2.QrTd.caption :=Td;
    frm2.QrNamn.Caption :=  Label1.caption; //!Namn
    frm2.QrAddr.Caption :=  Label2.caption; //!Adress
    frm2.QrPAddr.Caption :=  Label3.caption; //!PostOrt
    frm2.QrLand.Caption :=  Label4.caption; //!Land
    frm2.QrOrgNr.Caption :=  Label5.caption; //!Org Nr
    frm2.QrTele.Caption :=  Label6.caption;  //!Tele 1
//! Antalet AVslutade Hyror
    frm2.QrHyror.caption :='Antal avslutade hyror: '+  inttostr(qstat.RecordCount);
//! Totala intäkter
    dsum := 0;
    qstat.First;
    while not qstat.eof do
    begin
      dsum := dsum + qstat.fieldbyname('DSum').asinteger;
      qstat.next;
    end;
     frm2.QrTot.caption := 'Totala intäkter:     ' + inttostr(dsum) + ' Kr';
//!Hit
//! Summa Snitt
    if qstat.RecordCount > 0 then
      frm2.QrSnitt.caption:='Intäkter i snitt: ' + FormatFloat('0.00',dsum/qstat.RecordCount)
    else
      frm2.QrSnitt.caption:='Intäkter i snitt: 0';
//!
    T := 400;
    tagen := 101;
    qstat.First;
    while not qstat.Eof do
    begin
        QPTyp := TQRLabel.Create(Self);
        qptyp.Parent := frm2.QuickRep1;
        qptyp.Tag := tagen;
        Inc(tagen);
        QPTyp.Left := 60;
        QPTyp.Height := 17;
        qptyp.Top := t;
        inc(t, 20);
        QPTyp.Caption := qstat.fieldbyname('ContrId').asstring+'     '+qstat.fieldbyname('frm_time').asstring+'     '+qstat.fieldbyname('to_time').asstring+'     '+qstat.fieldbyname('DSum').asstring ;
      qstat.next;
    end;
//!

frm.Free;
Frm2.Free;
end;
end;

procedure TFrmStat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmstat.free;
  frmstat := nil;
end;

procedure TFrmStat.EBTomClick(Sender: TObject);
begin
  PAObjST.Visible := False;
  Qstat.active := False;
  KStat.Active := False;
  label1.caption := '';
  label2.caption := '';
  label3.caption := '';
  label4.caption := '';
  label5.caption := '';
  label6.caption := '';
  label7.caption := '';
  label8.caption := '';
  label9.caption := '';
  label10.caption := '';
  label11.caption := '';
  label12.caption := '';
  label13.caption := '';
  label14.caption := '';
  label15.caption := '';
  Kundpanel.visible := False;
  BitBtn6.visible := False;
  lb.Clear;
  lbo.clear;
end;

procedure TFrmStat.BtnObjClick(Sender: TObject);
begin
  Kundpanel.Visible := False;
end;

procedure TFrmStat.EBSamClick(Sender: TObject);
var
  frm2:TFrmStatAntBil ;
  frm:TFrmUrvSams ;
  FD: string;
  TD: string;
  FromDate: TDate;
  TODate: TDate;
  HDagar: Double;
  MedD: Double; //dagar / Återlämningar
  Netto: Double; //nettoomsättning
  AntalBilar: Integer; //! För att räkna ut antalet bilar
  RegNR:String; //! För att räkna ut antalet bilar
  ab: string; //!Antal bilar i vagnparken
  PL: string;
  I, BazRec: Integer;
  BazSum: Double;
  clickedok: Boolean;
  AYear, AMonth, ADay: Word;
  costN:String;
  costTot:Real;
  depsum:Real;
begin
  BitBtn5.Click ;
  typ := 'Stat';
  PAObjST.Visible := False;
  gbpris.visible := True;
  gbobj.visible := True;
  PKund.visible := False;
  PSTat.visible := True;
  Hdagar := 0;
  Netto := 0;
  i := 0;
  lb.clear;
  lbo.clear;
  DecodeDate(Now, AYear, AMonth, ADay);
  Fromdate := EncodeDate(AYear, AMonth, 1);
frm:=TFrmUrvSams.Create(self);
frm.DateTimePicker1.date:=fromdate;
frm.DateTimePicker2.date:=Now;
Frm.ShowModal;
//!  clickedok := Inputquery('Datum From', datetostr(fromdate), fd);
//!  if clickedok then
//!  begin
//!    clickedok := Inputquery('Datum tom', Datetostr(now), td);
    if frm.ModalResult =MrOk then
    begin
  FromDate := frm.DateTimePicker1.date;
  todate := frm.DateTimePicker2.date  + 1;
    BitBtn6.visible:=True;
        qstat.Active := False;
        qstat.sql.text := 'SELECT Contr_Sub.SubName, Contr_ObjT.OId, Contr_ObjT.PType, Contr_ObjT.PClass, Contr_ObjT.KM_Ber, Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_SubCost.DHYR, Contr_SubCost.DSUM, Contr_SubCost.DMOMS, Contr_SubCost.DTOTAL,Contr_Base.Status';
        qstat.sql.text := qstat.sql.text + ' FROM ((Contr_Sub RIGHT JOIN Contr_Base ON Contr_Sub.ContrId = Contr_Base.ContrId) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId) LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId';
        qstat.sql.text := qstat.sql.text + ' WHERE (((Contr_ObjT.To_Time)>''' + datetostr(fromDate) + ''' And (Contr_ObjT.To_Time)<''' + datetostr(todate) + ''') AND ((Contr_Base.Status)>8)) ORDER BY Contr_ObjT.OId;'; //!ORDER BY Contr_ObjT.PType
        qstat.active := True;
//! För att räkna ut antalet använda bilar
   antalBilar:=0;
   regNr:='';
     qstat.First;
     while not qstat.Eof do
     begin
      if qstat.FieldByName('OID').AsString <> RegNr then
       begin
        regnr:=qstat.FieldByName('OID').AsString;
        Inc(antalBilar);
       end;
     qstat.next;
     end;
//! Hit
//!      ab := Inputbox('Antal bilar', 'Antal bilar i vagnparken', inttostr(antalBilar));
     frm2:=TFrmStatAntBil.Create(self);
     frm2.Edit1.Text :=inttostr(antalBilar);
     frm2.ShowModal;
     ab:=Frm2.Edit1.Text;
      qrfrom.Caption := datetostr(fromdate);
      qrto.caption :=datetostr(toDate-1);

      try
//!        FromDate := Strtodate(fd);
//!        todate := strtodate(td) + 1;

//!Antal Bildagar
//!   qstat.Active :=False;
//!   qstat.sql.text:='Select * from Objects';
//!   qstat.active:=True;
//!   if ab>'!' then
        antalbilar := strtoint(ab); //!else
//!   Antalbilar:=qstat.recordcount;
        label7.caption := INttostr(antalbilar * Trunc(todate - fromdate));
        qrobjd.caption := Label7.caption;
//!Avslutade Hyror
        qstat.Active := False;
        qstat.sql.text := 'SELECT Contr_Sub.SubName, Contr_ObjT.OId, Contr_ObjT.PType, Contr_ObjT.PClass, Contr_ObjT.KM_Ber, Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_SubCost.DHYR, Contr_SubCost.DSUM, Contr_SubCost.DMOMS, Contr_SubCost.DTOTAL,Contr_Base.Status';
        qstat.sql.text := qstat.sql.text + ' FROM ((Contr_Sub RIGHT JOIN Contr_Base ON Contr_Sub.ContrId = Contr_Base.ContrId) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId) LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId';
        qstat.sql.text := qstat.sql.text + ' WHERE (((Contr_ObjT.To_Time)>''' + datetostr(fromDate) + ''' And (Contr_ObjT.To_Time)<''' + datetostr(todate) + ''') AND ((Contr_Base.Status)>8)) ORDER BY Contr_ObjT.PType;'; //!ORDER BY Contr_ObjT.PType
        qstat.active := True;
        Label8.caption := INttostr(qstat.RecordCount);
        qravhy.caption := label8.caption;
//!Antalet InDagar
        Qstat.First;
        while not qstat.Eof do
        begin
          Hdagar := Hdagar + trunc((qstat.fieldbyname('to_time').AsDateTime + 1) - qstat.fieldbyname('frm_time').AsDateTime);
          qstat.next;
        end;
        bazrec := qstat.RecordCount;
        if bazrec < 1 then
          Bazrec := 1;
        medd := Hdagar / BazRec;
        label9.caption := formatfloat('0.00', Medd);
        qrHyrasnitt.caption := Label9.caption;
//nettoomsättning
        Qstat.First;
        while not qstat.Eof do
        begin
          Netto := Netto + qstat.fieldbyname('dsum').Asfloat;
          qstat.next;
        end;
        label10.caption := formatfloat('0.00', Netto);
        qrnetto.caption := label10.caption;
//!Hyresdagar
        label11.caption := Floattostr(Strtofloat(label8.caption) * strtofloat(label9.caption));
        qrhyrd.caption := label11.caption;
//! Utnyttjande Grad
        if StrToFloat(Label7.Caption) > 0 then
          label12.caption := formatfloat('0.00', (Strtofloat(label11.caption) / strtofloat(label7.caption) * 100))
        else
          Label12.Caption := '0.00';
        qrutnyt.caption := Label12.caption;
//!Intäkt per Hyresdag
        if StrToFloat(Label11.Caption) > 0 then
          label13.Caption := formatfloat('0.00', netto / strtoFloat(label11.caption))
        else
          label13.Caption := '0.00';
        Qrintdag.caption := label13.caption;
//!Intäkt per Bil
        if AntalBilar > 0 then
          Label14.caption := Formatfloat('0.00', Netto / AntalBilar)
        else
          Label14.Caption := '0.00';
        qrintobj.caption := label14.caption;
//!Totalt antal bilar
        label15.caption := inttostr(antalbilar);
        qrtotobj.caption := label15.caption;
//!Pengar per Prislista i Listbox
        qstat.first;
        while not qstat.eof do
        begin
          inc(i);
          if not (PL = trimright(qstat.fieldbyname('PType').asstring)) then
          begin
            Bazsum := 0;
            PL := trimright(qstat.fieldbyname('PType').asstring);
            qstat.filter := 'PType = ''' + PL + '''';
            qstat.Filtered := True;
            qstat.first;
            while not qstat.eof do
            begin
              bazsum := bazsum + qstat.fieldbyname('DSum').asfloat;
              qstat.next;
            end;

            lb.items.add(PL + ' Antal: ' + inttostr(qstat.RecordCount) + ' Totalt: ' + currtostr(round(Bazsum)) + 'Kr');
            qstat.Filtered := False;
            qstat.MoveBy(i + 1);
          end;
          qstat.Next;
        end;
//!Hit
//! Antalet utdagar
        qstat.Active := False;
        qstat.sql.text := 'SELECT Contr_Base.ContrId, Contr_ObjT.Frm_Time, Contr_Base.Status, Contr_Base.Payment';
        qstat.sql.text := qstat.sql.text + ' FROM Contr_Base LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId';
        qstat.sql.text := qstat.sql.text + ' WHERE (((Contr_ObjT.Frm_Time)>''' + datetostr(fromDate) + ''' And (Contr_ObjT.Frm_Time)<''' + datetostr(toDate) + '''))';
        qstat.sql.text := qstat.sql.text + ' ORDER BY Contr_Base.Payment;';
        qstat.active := True;
        Label27.caption := inttostr(qstat.RecordCount);
        QRPHyror.caption := label27.Caption;
//! Antalet öppna hyror
        qstat.Active := False;
        qstat.sql.text := 'SELECT Contr_Base.ContrId, Contr_ObjT.Frm_Time, Contr_Base.Status, Contr_Base.Payment, Contr_ObjT.To_Time';
        qstat.sql.text := qstat.sql.text + ' FROM Contr_Base LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId';
        qstat.sql.text := qstat.sql.text + ' WHERE (((Contr_Base.Status)<9))';
        qstat.sql.text := qstat.sql.text + ' ORDER BY Contr_Base.Payment;';
        qstat.active := True;
        Label29.caption := inttostr(qstat.RecordCount);
        qrohyror.caption := label29.Caption;
//!Statistik / Objektsgrupp
        qstat.Active := False;
        qstat.sql.text := 'SELECT Contr_Sub.SubName, Contr_ObjT.OId, Contr_ObjT.PType, Contr_ObjT.PClass, Contr_ObjT.KM_Ber, Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_SubCost.DHYR, Contr_SubCost.DSUM, Contr_SubCost.DMOMS, Contr_SubCost.DTOTAL, Contr_Base.Status, ';
        qstat.sql.text := qstat.sql.text + ' Objects.Model, Objects.Type FROM ((Contr_Sub RIGHT JOIN Contr_Base ON Contr_Sub.ContrId = Contr_Base.ContrId) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId) LEFT JOIN (Contr_ObjT LEFT JOIN Objects ON Contr_ObjT.OId = Objects.Reg_No) ';
        qstat.sql.text := qstat.sql.text + ' ON Contr_Base.ContrId = Contr_ObjT.ContrId WHERE (((Contr_ObjT.To_Time)>''' + datetostr(fromDate) + ''' And (Contr_ObjT.To_Time)<''' + datetostr(ToDate) + ''') AND ((Contr_Base.Status)>8))';
        qstat.sql.text := qstat.sql.text + ' ORDER BY Objects.Type;';
        qstat.active := True;
        qstat.first;
        lbo.Clear;
        i := 0;
        while not qstat.eof do
        begin
          inc(i);
          if not (PL = qstat.fieldbyname('Type').asstring) then
          begin
            Bazsum := 0;
            PL := qstat.fieldbyname('Type').asstring;
            qstat.filter := 'Type = ''' + PL + '''';
            qstat.Filtered := True;
            qstat.first;
            while not qstat.eof do
            begin
              bazsum := bazsum + qstat.fieldbyname('DSum').asfloat;
              qstat.next;
            end;

            lbo.items.add(PL + ' Antal: ' + inttostr(qstat.RecordCount) + ' Totalt: ' + currtostr(round(Bazsum)) + 'Kr');
            qstat.Filtered := False;
            qstat.MoveBy(i + 1);
          end;
          qstat.Next;
        end;
//! Statistik per tillägg
        qstat.active := False;
        qstat.SQL.Text:='SELECT [Contr_Sub].[SubName], [Contr_ObjT].[OId], [Contr_ObjT].[PType], [Contr_ObjT].[PClass], [Contr_ObjT].[KM_Ber], [Contr_ObjT].[Frm_Time], [Contr_ObjT].[To_Time], [Contr_SubCost].[DHYR], [Contr_SubCost].[DSUM], [Contr_SubCost].[DMOMS],';
        qstat.SQL.Text:=qstat.SQL.Text+' [Contr_SubCost].[DTOTAL], [Contr_Base].[Status], [Contr_Costs].[Costname], [Contr_Costs].[No] FROM (((Contr_Sub RIGHT JOIN Contr_Base ON [Contr_Sub].[ContrId]=[Contr_Base].[ContrId]) LEFT JOIN Contr_SubCost ON [Contr_Sub].[SubId]=';
        qstat.SQL.Text:=qstat.SQL.Text+' [Contr_SubCost].[SubId]) LEFT JOIN Contr_ObjT ON [Contr_Base].[ContrId]=[Contr_ObjT].[ContrId]) LEFT JOIN Contr_Costs ON [Contr_Base].[ContrId]=[Contr_Costs].[ContrID] WHERE ((([Contr_ObjT].[To_Time])>''' + datetostr(fromDate) + ''' And ';
        qstat.SQL.Text:=qstat.SQL.Text+' ([Contr_ObjT].[To_Time])<''' + datetostr(todate) + ''') And (([Contr_Base].[Status])>8) And (([Contr_Costs].[Costname])>''!'')) ORDER BY [Contr_Costs].[Costname];';
        qstat.active := True;
        costN:='';
LBTill.Clear ;
 qstat.first;
 while not qstat.Eof do
 begin
  if qstat.FieldByName('costname').asstring <> CostN then
  Begin
    StatQ.Active :=False;
    StatQ.SQL.Text:='SELECT Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_Base.Status, Contr_Costs.Costname, Contr_Costs.[No]';
    StatQ.SQL.Text :=StatQ.SQL.Text +' FROM (((Contr_Sub RIGHT JOIN Contr_Base ON Contr_Sub.ContrId = Contr_Base.ContrId) LEFT JOIN Contr_Costs ON Contr_Base.ContrId = Contr_Costs.ContrID) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId)';
    StatQ.SQL.Text :=StatQ.SQL.Text +' LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId WHERE (((Contr_ObjT.To_Time)>''' + datetostr(fromDate) + ''' And (Contr_ObjT.To_Time)<''' + datetostr(todate) + ''') AND ((Contr_Base.Status)>8) AND ((Contr_Costs.Costname)='''+qstat.fieldbyname('costname').asstring +'''))';
    StatQ.SQL.Text :=StatQ.SQL.Text +' ORDER BY Contr_Costs.Costname;';
    statq.Active :=True;
    statq.First ;
    costTot:=0;
    while not statq.Eof do
    Begin
      costtot:=costtot+statQ.fieldbyname('no').asfloat;
      statq.next;
    end;
    LBTill.items.Add(inttostr(statq.recordcount)+'st '+Statq.fieldbyname('CostName').asstring +' Totalt '+ floattostr(costtot));
  end;
  costn:=Qstat.fieldbyname('CostName').asstring;
  qstat.next;
 end;
//! Deposition
    StatQ.Active :=False;
    StatQ.SQL.Text:='SELECT Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_Base.Status, Contr_Base.Deposit, Contr_Base.Dep_Amount';
    StatQ.SQL.Text:=StatQ.SQL.Text+' FROM (((Contr_Sub RIGHT JOIN Contr_Base ON Contr_Sub.ContrId = Contr_Base.ContrId) LEFT JOIN Contr_Costs ON Contr_Base.ContrId = Contr_Costs.ContrID) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId)';
    StatQ.SQL.Text:=StatQ.SQL.Text+' LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId WHERE (((Contr_ObjT.To_Time)>''' + datetostr(fromDate) + ''' And (Contr_ObjT.To_Time)<''' + datetostr(todate) + ''') AND ((Contr_Base.Status)>8) AND ((Contr_Base.Dep_Amount)>0));';
    StatQ.Active :=True;
    statq.First;
    depsum:=0;
    while not statq.Eof do
    begin
     depsum:=depsum+statq.fieldbyname('Dep_Amount').asfloat;
     statq.next;
    end;
  LBTill.items.Add(inttostr(statq.recordcount)+'st Depositioner Totalt '+ floattostr(depsum)+' Kr');
//!Återgå till sorterat på Datum

        qstat.Active := False;
        qstat.sql.text := 'SELECT Contr_Sub.SubName, Contr_ObjT.OId, Contr_ObjT.PType, Contr_ObjT.PClass, Contr_ObjT.KM_Ber, Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_SubCost.DHYR, Contr_SubCost.DSUM, Contr_SubCost.DMOMS, Contr_SubCost.DTOTAL,Contr_Base.Status';
        qstat.sql.text := qstat.sql.text + ' FROM ((Contr_Sub RIGHT JOIN Contr_Base ON Contr_Sub.ContrId = Contr_Base.ContrId) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId) LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId';
        qstat.sql.text := qstat.sql.text + ' WHERE (((Contr_ObjT.To_Time)>''' + datetostr(fromDate) + ''' And (Contr_ObjT.To_Time)<''' + datetostr(todate) + ''') AND ((Contr_Base.Status)>8)) ORDER BY Contr_ObjT.To_Time;'; //!ORDER BY Contr_ObjT.PType
        qstat.active := True;
        Kundpanel.visible := True;

      except
        showmessage('Fel i datumformat');
      end;
    end; //! Clicked ok
  end; //! ClickedOk

procedure TFrmStat.Button1Click(Sender: TObject);
begin
  quickrep1.Preview;
//!  quickrep1.Print;
end;

procedure TFrmStat.FormCreate(Sender: TObject);
begin
  quickrep1.Hide;
end;

procedure TFrmStat.EBPrintClick(Sender: TObject);
var QPTyp: TQRLabel;
  i, t, tagen: Integer;
  frm:Tfrmqkundstat;
  frm2:TfrmUObjStat;
  frm3:TFrmQObjTyp;
begin
  forprinting :=True;
//! Om det är Statistik
  if typ = 'Stat' then
  begin
    T := 610;
    tagen := 101;
    for i := 0 to lb.Items.Count - 1 do
    begin
      QPTyp := TQRLabel.Create(Self);
      qptyp.Parent := quickrep1;
      qptyp.Tag := tagen;
      Inc(tagen);
      QPTyp.Left := 100;
      QPTyp.Height := 17;
      qptyp.Top := t;
      inc(t, 20);
      QPTyp.Caption := lb.items.strings[i];
    end;
    T := 610;
    for i := 0 to lbo.Items.Count - 1 do
    begin
      QPTyp := TQRLabel.Create(Self);
      qptyp.Parent := quickrep1;
      qptyp.Tag := tagen;
      inc(tagen);
      QPTyp.Left := 300;
      QPTyp.Height := 17;
      qptyp.Top := t;
      inc(t, 20);
      QPTyp.Caption := lbo.items.strings[i];
    end;
//! Tillägg
    T := 610;
    for i := 0 to lbTill.Items.Count - 1 do
    begin
      QPTyp := TQRLabel.Create(Self);
      qptyp.Parent := quickrep1;
      qptyp.Tag := tagen;
      inc(tagen);
      QPTyp.Left := 500;
      QPTyp.Height := 17;
      qptyp.Top := t;
      inc(t, 20);
      QPTyp.Caption := lbTill.items.strings[i];
    end;
    quickrep1.Preview;
    for I := 0 to componentcount - 1 do
    begin
      if components[i] is TQRLabel then
      begin
        if (components[i] as TQRLabel).Tag > 100 then
          (components[i] as TQRLabel).Caption := '';
      end;
    end;
  end;
//! Hit
//! Om det är Kunder
  if typ = 'KundStat' then
  Begin
    frm:=TFrmQKundStat.Create(self);
    Frm.QuickRep1.Preview;
    frm.Free;
  end;
//! Hit
//!Om det är Objekt
  if typ = 'ObjStat' then
  Begin
    frm2:=TfrmUObjStat.Create(self);
    frm2.QuickRep1.Preview;
    frm2.Free;
  end;
//!Hit
//!ObjektsTyper
  if typ = 'ObjTypStat' then
  Begin
    frm3:=TFrmQObjTyp.create(self);
    Frm3.QuickRep1.Preview;
    frm3.free;
  end;
//!Hit

end;

procedure TFrmStat.ExpressButton3Click(Sender: TObject);
var QPTyp: TQRLabel;
  i, t, tagen: Integer;
begin
  T := 580;
  tagen := 101;
  for i := 0 to lb.Items.Count - 1 do
  begin
    QPTyp := TQRLabel.Create(Self);
    qptyp.Parent := quickrep1;
    qptyp.Tag := tagen;
    Inc(tagen);
    QPTyp.Left := 56;
    QPTyp.Height := 17;
    qptyp.Top := t;
    inc(t, 20);
    QPTyp.Caption := lb.items.strings[i];
  end;
  quickrep1.Preview;
  for I := 0 to componentcount - 1 do
  begin
    if components[i] is TQRLabel then
    begin
      if (components[i] as TQRLabel).Tag > 100 then
        (components[i] as TQRLabel).Caption := '';
    end;
  end;

end;

procedure TFrmStat.EBObjClick(Sender: TObject);
var
  Dsum: Integer;
  hdagar: integer;
  utngrad: real;
  qptyp: TqrLabel;
  Tagen, T: Integer;
  Frm:TFrmStatUrval;
  Frm2:TfrmUObjStat;
  AYear, AMonth, ADay: Word;
begin
  BitBtn5.Click ;
  Typ := 'ObjStat';
  frm:=TFrmStatUrval.Create(Application);
  frm.BFC_ComboBox1.Items.Clear;
  frm.Label1.Visible :=False;
  frm.Edit1.Visible :=False;
  qstat.active:=False;
  qstat.sql.text:='SELECT Objects.Reg_No FROM Objects ORDER BY Objects.Reg_No';
  qstat.Active :=True;
  Qstat.first;
  while not qstat.eof do
  begin
    frm.BFC_ComboBox1.Items.add(qstat.fieldbyname('Reg_No').asstring);
    qstat.next;
  end;
//!  FixaUrvalsDatum;
  DecodeDate(Now, AYear, AMonth, ADay);
  Frm.DateTimePicker1.date := EncodeDate(AYear, AMonth-1, 1);
  Frm.DateTimePicker2.date:=now-3;


  frm.BFC_ComboBox1.ItemIndex :=0;
  frm.ShowModal ;
  if frm.ModalResult =MrOk then
  begin
    BitBtn6.visible:=True;
    qstat.active := False;
    qstat.SQL.Text := 'SELECT [Contr_ObjT].[ContrId], [Contr_ObjT].[OId], [Contr_ObjT].[Frm_Time], [Contr_ObjT].[To_Time], [Contr_ObjT].[KM_Out], [Contr_ObjT].[KM_In], [Contr_ObjT].[PClass], [Contr_ObjT].[PType], [Contr_Sub].[SubName], [Contr_Sub].[ENummer],';
    qstat.SQL.Text := qstat.SQL.Text + ' [Contr_SubCost].[DSUM] FROM (Contr_ObjT LEFT JOIN Contr_Sub ON [Contr_ObjT].[ContrId]=[Contr_Sub].[ContrId]) LEFT JOIN Contr_SubCost ON [Contr_Sub].[SubId]=[Contr_SubCost].[SubId]';
    qstat.SQL.Text := qstat.SQL.Text + ' WHERE ((([Contr_ObjT].[OId])=''' + sbaz + ''') And (([Contr_ObjT].[To_Time])>' + fd + ' And ([Contr_ObjT].[To_Time])<' + td + ')) ORDER BY Contr_ObjT.To_Time';
    qstat.active := true;
    label30.Caption := 'Antal avslutade hyror: ' + inttostr(qstat.RecordCount) + ' st';
//! Totala intäkter under perioden
    dsum := 0;
    qstat.First;
    while not qstat.eof do
    begin
      dsum := dsum + qstat.fieldbyname('DSum').asinteger;
      qstat.next;
    end;
    label31.Caption := 'Totala intäkter:     ' + inttostr(dsum) + ' Kr';
//! Hit  Totala intäkter
//! Antalet Uthyrda Dagar
    hdagar := 0;
    Qstat.First;
    while not qstat.Eof do
    begin
      if qstat.fieldbyname('frm_time').AsDateTime < strtodate(fd) then
        Hdagar := Hdagar + trunc((qstat.fieldbyname('to_time').AsDateTime + 1) - strtodate(FD))
      else
        Hdagar := Hdagar + trunc((qstat.fieldbyname('to_time').AsDateTime + 1) - qstat.fieldbyname('frm_time').AsDateTime);
      qstat.next;
    end;
//!     utngrad:=hdagar/Trunc(strtodate(td) - strtodate(fd));
    label32.Caption := 'Utnyttjandegrad:     ' + formatfloat('0.00', hdagar / Trunc(strtodate(td) - strtodate(fd)) * 100) + '%';
//!Hit Uthyrda dagar
//! För utskrift
    BitBtn6.Visible := True;
    Frm2:=TfrmUObjStat.Create(self);
    Frm2.QRRegNr.Caption := 'RegNr ' + Sbaz;
    Frm2.QrFD.Caption := FD;
    Frm2.QrTd.Caption := TD;
    Frm2.QrAntalRet.Caption := Label30.caption;
    Frm2.QrTotInt.Caption := Label31.Caption;
    Frm2.QRUtnGrad.Caption := Label32.Caption;

T := 300;
tagen := 101;
    qstat.First;
    while not qstat.Eof do
    begin
        QPTyp := TQRLabel.Create(Self);
        qptyp.Parent := Frm2.quickrep1;
        qptyp.Tag := tagen;
        Inc(tagen);
        QPTyp.Left := 60;
        QPTyp.Height := 17;
        qptyp.Top := t;
        inc(t, 20);
        QPTyp.Caption := qstat.fieldbyname('ContrId').asstring+'     '+qstat.fieldbyname('frm_time').asstring+'     '+qstat.fieldbyname('to_time').asstring+'     '+qstat.fieldbyname('Subname').asstring ;
      qstat.next;
    end;

//!Hit Utskrift
    groupbox2.Caption := 'RegNr : ' + sbaz;
    PAObjST.Visible := True;
Frm2.Free;
  end;
  frm.Free;
end;

procedure TFrmStat.EBObjTypStatClick(Sender: TObject);
var
  Dsum: Integer;
  hdagar: integer;
  utngrad: real;
  qptyp: TqrLabel;
  Tagen, T: Integer;
  ObjD:Real;
  frm:TFrmStatUrval;
  AYear, AMonth, ADay: Word;
  frm2:TFrmQObjTyp;
begin
  BitBtn5.Click ;
  Typ := 'ObjTypStat';
  frm:=TFrmStatUrval.Create(self);
  frm.BFC_ComboBox1.Items.Clear;
  frm.Label1.Visible :=True;
  frm.Edit1.Visible :=True;
  qstat.active:=False;
  qstat.sql.text:='SELECT ObjType.ID, ObjType.Type FROM ObjType';
  qstat.Active :=True;
  Qstat.first;
  while not qstat.eof do
  begin
    if  uppercase(qstat.fieldbyname('Type').asstring)<> 'ALLT' then
      frm.BFC_ComboBox1.Items.add(qstat.fieldbyname('Type').asstring);
    qstat.next;
  end;
//!  FixaUrvalsDatum;
  DecodeDate(Now, AYear, AMonth, ADay);
  Frm.DateTimePicker1.date := EncodeDate(AYear, AMonth-1, 1);
  Frm.DateTimePicker2.date:=now-3;

  frm.BFC_ComboBox1.ItemIndex :=0;
  frm.ShowModal ;
  if frm.ModalResult =MrOk then
    begin
     BitBtn6.visible:=True;
     qstat.active := False;

    qstat.sql.text:='SELECT Contr_ObjT.ContrId, Contr_ObjT.OId, Contr_ObjT.Frm_Time, Contr_ObjT.To_Time, Contr_ObjT.KM_Out, Contr_ObjT.KM_In, Contr_ObjT.PClass, Contr_ObjT.PType, Contr_Sub.SubName, Contr_Sub.ENummer, Contr_SubCost.DSUM, Contr_ObjT.ObTypId, ObjType.Type';
    qstat.sql.text:=qstat.sql.text+' FROM ((Contr_ObjT LEFT JOIN Contr_Sub ON Contr_ObjT.ContrId = Contr_Sub.ContrId) LEFT JOIN Contr_SubCost ON Contr_Sub.SubId = Contr_SubCost.SubId) LEFT JOIN ObjType ON Contr_ObjT.ObTypId = ObjType.ID';
    qstat.sql.text:=qstat.sql.text+' WHERE (((Contr_ObjT.To_Time)>'+fd+' And (Contr_ObjT.To_Time)<'+td+') AND ((ObjType.Type)='''+sbaz+'''))';
    qstat.sql.text:=qstat.sql.text+' ORDER BY Contr_ObjT.To_Time';
    qstat.active := true;
    label30.Caption := 'Antal avslutade hyror: ' + inttostr(qstat.RecordCount) + ' st';
//! Totala intäkter under perioden
    dsum := 0;
    qstat.First;
    while not qstat.eof do
    begin
      dsum := dsum + qstat.fieldbyname('DSum').asinteger;
      qstat.next;
    end;
    label31.Caption := 'Totala intäkter:     ' + inttostr(dsum) + ' Kr';
//! Hit  Totala intäkter
//! Antalet Uthyrda Dagar
    hdagar := 0;
    Qstat.First;
    while not qstat.Eof do
    begin
      if qstat.fieldbyname('frm_time').AsDateTime < strtodate(fd) then
        Hdagar := Hdagar + trunc((qstat.fieldbyname('to_time').AsDateTime + 1) - strtodate(FD))
      else
        Hdagar := Hdagar + trunc((qstat.fieldbyname('to_time').AsDateTime + 1) - qstat.fieldbyname('frm_time').AsDateTime);
      qstat.next;
    end;
   label32.Caption :='Antal Hyresdagar: '+inttostr(hdagar);
//!Hit Uthyrda dagar
//! För utskrift
    BitBtn6.Visible := True;
    frm2:=TFrmQObjTyp.create(self);
    frm2.QLAntObj.Caption :='Antal objekt: '+Frm.edit1.text;
    frm2.QRobjtyp.Caption := Sbaz;
    frm2.QrFd.Caption := FD;
    frm2.QrTd.Caption := TD;
    frm2.QrAntalRet.Caption := Label30.caption;
    frm2.QrTotInt.Caption := Label31.Caption;
    frm2.QRUtnGrad.Caption := Label32.Caption;
    ObjD :=strtoint(Frm.edit1.text)* Trunc(strtodate(td) - strtodate(fd));
    frm2.QObjD.Caption  :='Objektsdagar: '+ floattostr(strtoint(Frm.edit1.text)* Trunc(strtodate(td) - strtodate(fd)));
    if ObjD > 0 then
      frm2.QRUtn.Caption :='Utnyttjandegrad '+FormatFloat('0.00', (hdagar /ObjD) * 100)+'%'
    else
      frm2.QRUtn.Caption :='Utnyttjandegrad 0.00%';
    T := 300;
    tagen := 101;
    qstat.First;
    while not qstat.Eof do
    begin
        QPTyp := TQRLabel.Create(Self);
        qptyp.Parent := frm2.quickrep1;
        qptyp.Tag := tagen;
        Inc(tagen);
        QPTyp.Left := 60;
        QPTyp.Height := 17;
        qptyp.Top := t;
        inc(t, 20);
        QPTyp.Caption := qstat.fieldbyname('ContrId').asstring+'     '+qstat.fieldbyname('frm_time').asstring+'     '+qstat.fieldbyname('to_time').asstring+'     '+qstat.fieldbyname('Subname').asstring ;
      qstat.next;
    end;

//!Hit Utskrift
    groupbox2.Caption := 'ObjTyp : ' + sbaz;
    PAObjST.Visible := True;
  end;
  frm.Free;
end;

procedure TFrmStat.FixaUrvalsDatum;
 Var
    AYear, AMonth, ADay: Word;
begin
  DecodeDate(Now, AYear, AMonth, ADay);
  FrmStatUrval.DateTimePicker1.date := EncodeDate(AYear, AMonth-1, 1);
  FrmStatUrval.DateTimePicker2.date:=now-3;
end;

procedure TFrmStat.FormDeactivate(Sender: TObject);
begin
 if forprinting then
 else
 begin
  frmstat.Free;
  frmstat:=Nil;
  forprinting:=False;
 end;
end;

procedure TFrmStat.FormActivate(Sender: TObject);
begin
  forprinting := False;
  ImageList1.GetBitmap(0, BitBtn1.Glyph);
  ImageList1.GetBitmap(1, BitBtn2.Glyph);
  ImageList1.GetBitmap(1, BitBtn3.Glyph);
  ImageList1.GetBitmap(3, BitBtn4.Glyph);
  ImageList1.GetBitmap(2, BitBtn5.Glyph);
  ImageList1.GetBitmap(4, BitBtn6.Glyph);
  ImageList1.GetBitmap(1, BitBtn7.Glyph);
end;

procedure TFrmStat.ExpressButton1Click(Sender: TObject);
 Var
  AB:Integer;
begin
  if od1.Execute then
  begin

  end;
end;

end.


