{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Search.pas
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
{ $Log:  13092: Search.pas
{
{   Rev 1.9    2004-08-10 10:45:36  pb64
}
{
{   Rev 1.8    2004-05-11 11:02:50  peter
}
{
{   Rev 1.7    2004-01-28 13:34:06  peter
}
{
{   Rev 1.6    2004-01-27 12:17:12  peter
{ Vid sökning historiska data skall delad betalar namn+enummer visas.
{ + Fixat
{ + Numera fungerar urvalen
}
{
{   Rev 1.5    2003-10-14 11:35:26  peter
{ Fixar kring combobox + cust_id kontroll vid delbetalare.
}
{
{   Rev 1.4    2003-09-16 15:20:58  peter
{ Fixat bug där rätt kontrakt ej visas
}
{
{   Rev 1.3    2003-08-20 12:04:42  peter
}
{
{   Rev 1.2    2003-08-04 11:58:02  Supervisor
}
{
{   Rev 1.1    2003-06-10 13:31:44  hasp
}
{
{   Rev 1.0    2003-03-20 14:00:28  peter
}
{
{   Rev 1.0    2003-03-17 14:41:40  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:54  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:28  Supervisor
{ Start av vc
}
unit search;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBClient, Db, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  DBTables, ADODB, ActiveX, filectrl, Variants;

type
  NrTypes = TOleEnum;
  TfrmSearch = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SSearchCDS: TADOQuery;
    GSearchCDS: TADOQuery;
    BetsQ: TADOQuery;
    ObtypQ: TADOQuery;
    ObjktQ: TADOQuery;
    PriceQ: TADOQuery;
    CardsQ: TADOQuery;
    ObjDateQ: TADOQuery;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    BitBtn4: TBitBtn;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    BtnPrintContr: TButton;
    procedure SaveSQL_Sign(SqlQ, SqlTxt: string);
    function GetSQL_Sign(SqlQ: string): string;
    function CheckObj(RegNr: string): Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function UpdateContrObj(ContrId: Integer; const OldOID,
      NewOID, ObTypId: WideString; From, Tom: TDateTime; KmOut,
      KmIn: Integer): WordBool;
    function CheckObjFree(const OID: WideString; From,
      Tom: TDateTime; ContrID: Integer; SetDB: WordBool): WordBool;
    procedure DeleteContract(ContrId: Integer);
    procedure SaveContrHist(HistNr, ContrId: Integer; const Subject, Notes,
      Sign: WideString; Status: Integer);
    procedure GetBestPrice(From, Tom: TDateTime; KmTot: Integer; const PType,
      PClass: WideString; var Days, Km, XDays, XKm, SRisk: Currency);
    procedure BeginTransaction;
    function SaveContrBase(ContractNo, CustId: Integer; const Sign,
      Referens: WideString; Status: Integer; const Payment: WideString;
      PayDays: Integer; Delfakt : Boolean; StartDatum,SlutDatum,Belopp : String): Byte;
    function SaveContrObjT(ContrID: Integer; const ObjTyp, REGNR: WideString;
      FTime, TTime, OTime, RTime: TDateTime; KmOut, KmIn, KmBer: Integer;
      const PClass, PType: WideString; SRRed: WordBool; Status: Integer;
      const CarryCar: WideString; InvNo: Integer): Integer;

    function GetNewNo(NrType: NrTypes): Integer;
    procedure UpdateCreditCard(CustId: Integer; const CardId,
      CardNo, KortExp: WideString);
    function SavePartPayer(ContrID, SubCustId: Integer; const SubName,
      Contact: WideString; SpPercent: WordBool; SpRule_rent, SpRule_KM,
      SpRule_Vat: Integer; const Payment: WideString;
      Terms_Pay: Integer): Integer;

    procedure SaveContrComp(ContrID, DriveID: Integer; SRiskReduc: WordBool;
      SRDygn, Dep: Integer);
    procedure SaveContrNot(ContrId: Integer; const CNot1, CNot2, INot1,
      INot2: WideString);
    procedure SaveContrCosts(ContrID: Integer; const CostName: WideString;
      No: Real; Price: Currency; VAT: Double; Acc_code,
      Acc_center: Integer);
    procedure SavePartCost(SubId: Integer; DSUM, DHYR, DMOMS, DTOTAL: Extended;
      const KontoTyp, KontoNr: WideString; K_SparrKoll: WordBool;
      const K_SparrNr: WideString);
    procedure SavePartRow(SubId, RowNr: Integer; const RowText: WideString;
      Value, Percent: Extended; ByValue: WordBool);
    function GetNewCustomerId: Integer;
    procedure SavePartNote(SubId, KID: Integer; const FaktAtt, FaktNot1,
      FaktNot2: WideString);
    procedure DeleteContrHist(HistId: Integer);
    procedure SaveInsurInfo(SubId: Integer; const ICode: WideString;
      IDate: TDateTime; const FRegNr, IClass, INo, MPRegNr: WideString);
    procedure ChangeContrId(ContrId, NewContrId: Integer);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetGridObjekt;
    procedure SetGridKundId;
    procedure SetGridNamn;
    procedure SetGridBokning;
    procedure SetGridKontrakt;
    procedure SetGridReturn;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPrintContrClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    SSQLString: string;
    GSQLString: string;
    Param1: string;
    StrRikt: string;
    mintidtext: string;
    function ShowSearchResult: boolean;
    function GetSearchResult: boolean;
  end;

function GetPostOrt(postnr: string): string;

var
  frmSearch: TfrmSearch;
  strRikt: string;

const
  KontantNr = $00000000;
  FakturaNr = $00000001;
  InternNr = $00000002;
  OffertNr = $00000003;
  UnderNr = $00000004;
  KontraktNr = $00000005;

  SQLKontrakt =
    'SELECT Contr_objt.Status, Contr_base.ContrId , Contr_objt.OId AS RegNr, Contr_objt.Frm_Time AS Från, Contr_objt.To_Time AS Till, Customer.Name AS Namn, Contr_base.Referens AS Referens ' +
    'FROM [Contr_Base] Contr_base, [Contr_ObjT] Contr_objt, Customer Customer ' +
    'WHERE  (Contr_base.ContrId = Contr_objt.ContrId) AND (Contr_base.CustID = Customer.Cust_Id) AND ((Contr_base.Status < 7) OR (Contr_base.Status = 8)) ' +
    'ORDER BY Contr_objt.Frm_Time, Contr_objt.OId';

  SQLReturn =
    'SELECT Contr_objt.Status, Contr_base.ContrId, Contr_objt.OId AS RegNr, Contr_objt.Frm_Time AS Från, Contr_objt.To_Time AS Till, Customer.Name AS Namn, Contr_base.Referens AS Referens ' +
    'FROM [Contr_Base] Contr_base, [Contr_ObjT] Contr_objt, Customer Customer ' +
    'WHERE  (Contr_base.ContrId = Contr_objt.ContrId) AND (Contr_base.CustID = Customer.Cust_Id) AND (Contr_base.Status > 2) AND (Contr_base.Status < 9)' +
    'ORDER BY Contr_objt.To_Time, Contr_objt.OId';

  SQLBokning =
    'SELECT Contr_objt.Status, Contr_base.ContrId , Contr_objt.OId AS RegNr, Contr_objt.Frm_Time AS Från, Contr_objt.To_Time AS Till, Customer.Name AS Namn, Contr_base.Referens AS Referens ' +
    'FROM ([Contr_Base] AS Contr_base LEFT JOIN Customer ON Contr_base.CustID = Customer.Cust_Id) INNER JOIN [Contr_ObjT] AS Contr_objt ON Contr_base.ContrId = Contr_objt.ContrId ' +
    'WHERE (((Contr_base.Status)<3)) ' +
    'ORDER BY Contr_objt.To_Time, Contr_objt.OId; ';


  SQLReturnAll =

//!    'SELECT Contr_objt.Status , Contr_base.ContrId , Contr_objt.OId AS RegNr, Contr_objt.Frm_Time AS Från, Contr_objt.To_Time AS Till, Customer.Name AS Namn ' +
//!    'FROM [Contr_Base] Contr_base, [Contr_ObjT] Contr_objt, Customer Customer '  +
//!    'WHERE  (Contr_base.ContrId = Contr_objt.ContrId) AND (Contr_base.CustID = Customer.Cust_Id) AND (Contr_base.Status > 8) '+
//!    'ORDER BY Contr_objt.To_Time DESC, Contr_objt.OId';

  'SELECT Contr_ObjT.Status, Contr_Base.ContrId, Contr_ObjT.OId AS RegNr, Convert(varchar(16),Contr_ObjT.Frm_Time,121) AS Från, Convert(varchar(16),Contr_ObjT.To_Time,121) AS Till, Customer.Name AS [Kund/betalare], ' +
    ' Contr_Sub.SubId, Contr_Sub.Enummer, Customer_1.Name As [Förare], Contr_base.Referens AS Referens' +
    ' FROM Contr_Base INNER JOIN Contr_Sub ON Contr_Base.ContrId = Contr_Sub.ContrId INNER JOIN Customer ON Contr_sub.SubCustID = Customer.Cust_Id LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId ' +
    ' LEFT JOIN Customer AS Customer_1 ON Contr_Base.DriveId = Customer_1.Cust_Id WHERE Contr_Base.Status>8 ' +
    ' ORDER BY Contr_ObjT.To_Time DESC , Contr_ObjT.OId';

//

//!0111 Torsl 'SELECT Contr_ObjT.Status, Contr_Base.ContrId, Contr_ObjT.OId AS RegNr, Contr_ObjT.Frm_Time AS Från, Contr_ObjT.To_Time AS Till, Customer.Name AS Namn, Contr_Sub.SubId ' +
//!0111 Torsl 'FROM ((Contr_Base LEFT JOIN Contr_ObjT ON Contr_Base.ContrId = Contr_ObjT.ContrId) INNER JOIN Contr_Sub ON Contr_Base.ContrId = Contr_Sub.ContrId) INNER JOIN Customer ON Contr_Base.CustID = Customer.Cust_Id ' +
//!0111 Torsl 'WHERE  (Contr_base.ContrId = Contr_objt.ContrId) AND (Contr_base.CustID = Customer.Cust_Id) AND (Contr_base.Status > 8)' +
//!0111 Torsl 'ORDER BY Contr_objt.To_Time DESC, Contr_objt.OId';
//! För att få med Föraren till Torslanda

{  SQLBokning =
    'SELECT Contr_objt.Status, Contr_base.ContrId, Customer.Name AS Namn, Contr_objt.Frm_Time AS Från, Contr_objt.OId AS RegNr, Contr_objt.To_Time AS Till ' +
    'FROM [Contr-Base] Contr_base, [Contr-ObjT] Contr_objt, Customer Customer '  +
    'WHERE  (Contr_base.ContrId = Contr_objt.ContrId) AND (Contr_base.CustID = Customer.Cust_Id) AND (Contr_base.Status < 3) '+
    'ORDER BY Contr_objt.To_Time, Contr_objt.OId';
 }

  SQLHistory =
    'SELECT [Time], Subject, Note, Sign, Status, ContrId, HistNum ' +
    'FROM [Contr_Hist] Contr_hist';

  SQLObjekt =
    'SELECT DISTINCTROW objects.REG_NO, objects.PriceClass, objects.MODEL, objects.Accesories , objects.Color , objects.KM_N , ([n_service]-[km_n]) AS Service , objects.type, Objects.Status ' +
    'FROM objects LEFT JOIN boknr ON objects.REG_No = boknr.OBID ';

  SQLKunder =
    'SELECT Customer.Org_No, Customer.Name, Customer.Adress, Customer.Postal_Name, Customer.Tel_Nr_1, Customer.Cust_Id, Customer.Driver ' +
    'FROM Customer ' +
    'Where (Customer.Driver IS NULL OR Customer.Driver = 0) ';

  SQLDriver =
    'SELECT Org_No, Name , Adress, Postal_name , Tel_nr_1 , Cust_Id  ' +
    'FROM Customer ';

implementation

uses main, Greg, Datamodule, Data2, Kontrakt, DataSession, eqprn;
{$R *.DFM}

function TfrmSearch.ShowSearchResult: boolean;
begin
  result := false;
  SSearchCDS.Active := false;
//!  SSearchCDS.PacketRecords := 5;
  if TCARSearch.ChangeSQL(SSQLString) > 0 then
  begin
//!      SSearchCDS.provider := ICARSearch.SearchQ;
    SSearchCDS.Active := true;
    Param1 := SSearchCDS.Fields[1].AsString;
    frmSearch.ShowModal;
//    Param1 := SSearchCDS.Fields[1].AsString;
    result := modalresult = mrOK;
  end;
end;

function TfrmSearch.GetSearchResult: boolean;
begin
  result := false;
  GSearchCDS.Active := false;
  SSearchcds.filtered := False;
  if TCARSearch.ChangeSQL(GSQLString) > 0 then
  begin
//!    GSearchCDS.provider := ICARSearch.SearchQ;
//!    GSearchCDS.PacketRecords := 5;
    GSearchCDS.Active := true;
    result := true;
  end;
end;

procedure TfrmSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    modalresult := mrOK;
  if key = VK_ESCAPE then
    modalresult := mrCancel;
end;

procedure TfrmSearch.DBGrid1DblClick(Sender: TObject);
begin
  Param1 := DBGrid1.DataSource.DataSet.Fields[1].AsString;
  modalresult := mrOK;
end;

procedure TfrmSearch.FormActivate(Sender: TObject);
begin
  ssearchcds.filtered := False;
  SSearchCDS.Filter := '';
  Combobox1.text := 'Fältval';
  Edit2.text := 'Ange Värde';
  BitBtn4.Enabled := True;
  BitBtn4.Tag := 0;

  if caption = 'Historik Återlämning' then
    btnprintcontr.visible := true;
  dbgrid1.setfocus;
  //!För att göra om Columnerna till svenska...
  if Caption = 'Sökresultat objekt' then SetGridObjekt;
  if caption = 'Sökresultat KundNr' then SetGridKundId;
  if Caption = 'Sökresultat Namn' then SetGridNamn;
  if Caption = 'Sökresultat bokning' then
  begin
    SetGridBokning;
    BitBtn3.click;
    edit2.setfocus;
    combobox1.itemindex := 2;
  end;
  if caption = 'Sökresultat kontrakt' then
  begin
    SetGridKontrakt;
    BitBtn3.click;
    edit2.setfocus;
    combobox1.itemindex := 2;
  end;
  if Caption = 'Sökresultat återlämning' then
  begin
    SetGridReturn;
    BitBtn3.click;
    edit2.setfocus;
    combobox1.itemindex := 2;
  end;
  if Caption = 'Historik Återlämning' then
  begin
    BitBtn3.click;
    edit2.setfocus;
    combobox1.itemindex := 2;
  end;


  //!Hit
//!  dbgrid1.columns.clear;
  //! Om man redan valt en annan ordning på Dbgriden
//!  if FileExists('C:\Program\Car2000\Users\'+frmmain.sign+'\'+frmsearch.caption+'.txt')then
//!  dbgrid1.Columns.LoadFromFile('C:\Program\Car2000\Users\'+frmmain.sign+'\'+frmsearch.caption+'.txt');
  //!Hit
end;

function GetPostOrt(postnr: string): string;
begin
  result := postnr;
  try
    if length(postnr) > 4 then
    begin
      if (postnr[1] <= '9') and (postnr[1] >= '1') then
      begin
        if frmmain.checkPnr = true then
        begin //!
          if (length(postnr) = 5) and (postnr[4] <> ' ') then
            postnr := Copy(postnr, 1, 3) + ' ' + Copy(postnr, 4, 2);
          if length(postnr) = 6 then
          begin
            frmSearch.GSQLString := 'Select * from Ortrg Where PNR = ''' + postnr + '''';
            if frmSearch.GetSearchResult then
              result := postnr + '  ' + frmSearch.GSearchCDS.FieldByName('ORT').AsString;
            StrRikt := frmsearch.GsearchCDS.Fieldbyname('Rikt').asstring;
          end;
        end; //!
      end;
    end;
  except
    //Delete all exceptions
  end;

end;

function TfrmSearch.UpdateContrObj(ContrId: Integer; const OldOID, NewOID,
  ObTypId: WideString; From, Tom: TDateTime; KmOut,
  KmIn: Integer): WordBool;
//var reg : string;
begin
  result := CheckObjFree(NewOID, From, Tom, ContrId, true);
  //Spara förändringar
  if result then
  begin
    Dmod.Q1.Active := False;
    Dmod.Q1.Sql.Text := 'Update Contr_ObjT set OID=' + DBDel + Trim(NewOID) + DBDel + ',Frm_Time=' + DBDel + DateTimeToStr(From) + DBDel + ', To_Time=' + DBDel + DateTimeToStr(tom) + DBDel + ',Out_Time=' + DBDel + DateTimeToStr(From) + DBDel + ', Ret_Time=' + DBDel + DateTimeToStr(Tom) + DBDel + ',Km_Out=' + DBDel + Inttostr(KmOut) + DBDel + ',Km_In=' + DBDel + Inttostr(KMIn) + DBDel + ' where contrid=' + DBDel + inttostr(Contrid) + DBDel + ' AND OID=' + DBDel + OldOID + DBDel + '';
    Dmod.Q1.ExecSQL;
  end;
end;

function TfrmSearch.CheckObjFree(const OID: WideString; From,
  Tom: TDateTime; ContrID: Integer; SetDB: WordBool): WordBool;
var
  reg: string;
  First: boolean;
begin
  result := True;
  reg := TrimRight(OID);
// Kontrollera att objektet finns
  if not CheckObj(reg) then
  begin
    Result := False;
    Exit;
  end;
// Kontrollera objektsdatum
  First := true;
//!ObjDateQ.Params[0].value := OID;
  ObjDateQ.Parameters[0].value := OID; //!Lagt till
  ObjDateQ.Open;
  while (not ObjDateQ.EOF) do
  begin
    if ObjDateQ.FieldbyName('TransIn-Out').AsBoolean then //inkommande
    begin
      // Om första transaktionen är inkommande finns ej bilen tidigare
      if First and (ObjDateQ.FieldbyName('TransDate').AsDateTime >= from) then
        result := false
      else
        if not result and (ObjDateQ.FieldbyName('TransDate').AsDateTime < from) then
          result := true;
    end
    else
    begin //utgående
      if (ObjDateQ.FieldbyName('TransDate').AsDateTime <= tom) then
        result := false;
    end;
    First := false;
    ObjDateQ.next;
  end;
  ObjDateQ.Close;

  //Kontrollera kontrakt om objektet finns tillgängligt
{  if result then
  begin
    Dmod.Contr_ObjTT.Refresh;
    Dmod.Contr_ObjTT.filter := 'OID = ''' + reg + '''';
    Dmod.Contr_ObjTT.filtered := true;
    Dmod.Contr_ObjTT.First;
    while not Dmod.Contr_ObjTT.EOF do
    begin
      if (Dmod.Contr_ObjTT.Fieldbyname('Out_time').value <=Tom) AND (Dmod.Contr_ObjTT.Fieldbyname('Ret_time').value >=From) then
        if Dmod.Contr_ObjTT.Fieldbyname('ContrID').value <> ContrID  then
             result := false;
      Dmod.Contr_ObjTT.next;
    end;
    Dmod.Contr_ObjTT.filtered := false;
  end;   }

  if result then
  begin
    dmod.Q2.SQL.Text := 'SELECT * FROM CONTR_OBJT WHERE OID = ''' + reg + ''' AND STATUS<>2';
    Dmod.Q2.Open;
    while not Dmod.Q2.EOF do
    begin
      if (Dmod.Q2.Fieldbyname('Out_time').value <= Tom) and (Dmod.Q2.Fieldbyname('Ret_time').value >= From) then
//!      if (Dmod.Contr_ObjTT.Fieldbyname('Frm_time').value <= Tom) and (Dmod.Contr_ObjTT.Fieldbyname('To_time').value >= From) then
//!Tagit bort för att kunna hyra ut igen fast den är uthyrd
        if Dmod.Q2.Fieldbyname('ContrID').value <> ContrID then
          result := false;
      Dmod.Q2.next;
    end;
    Dmod.Q2.Close;
    Dmod.Q2.SQL.Text := '';
  end;


  if SetDB then
    if frmgreg.ObjectsT.Locate('Reg_No', reg, [lopartialkey]) then
    begin
      //Spara status i tabell
      frmgreg.ObjectsT.Edit;
      if result then
        frmgreg.ObjectsT.Fieldbyname('status').AsInteger := 0 //Objekt ledigt
      else
        frmgreg.ObjectsT.Fieldbyname('status').AsInteger := 2; //Objekt uppbokat
      frmgreg.ObjectsT.Post;
    end;
end;

procedure TfrmSearch.DeleteContract(ContrId: Integer);
var
  i: integer;
begin
//!Base
  dmod.Q1.Active := False;
  dmod.Q1.SQL.Text := 'Delete from contr_base where contrid=''' + inttostr(contrid) + '''';
  dmod.Q1.ExecSQL;
//! Cost
  dmod.Q1.Active := False;
  dmod.Q1.SQL.Text := 'Delete from contr_Costs where contrid=''' + inttostr(contrid) + '''';
  dmod.Q1.ExecSQL;
//! Econ
  dmod.Q1.Active := False;
  dmod.Q1.SQL.Text := 'Delete from contr_Econ where contrid=''' + inttostr(contrid) + '''';
  dmod.Q1.ExecSQL;
//!Not
  dmod.Q1.Active := False;
  dmod.Q1.SQL.Text := 'Delete from contr_not where contrid=''' + inttostr(contrid) + '''';
  dmod.Q1.ExecSQL;
//!Obj
  dmod.Q1.Active := False;
  dmod.Q1.SQL.Text := 'Delete from contr_ObjT where contrid=''' + inttostr(contrid) + '''';
  dmod.Q1.ExecSQL;
//!Töm alla Sub
  dmod.Q2.Active := False;
  dmod.Q2.SQL.Text := 'Select Subid from Contr_Sub where contrid=''' + inttostr(contrid) + '''';
  dmod.Q2.active := True;
  while not dmod.q2.eof do
  begin
//!SubCost
    dmod.Q1.Active := False;
    dmod.Q1.SQL.Text := 'Delete from contr_subCost where sUBiD=''' + dmod.q2.fieldbyname('SubId').asstring + '''';
    dmod.Q1.ExecSQL;
//!SubCostRow
    dmod.Q1.Active := False;
    dmod.Q1.SQL.Text := 'Delete from contr_subCostRow where sUBiD=''' + dmod.q2.fieldbyname('SubId').asstring + '''';
    dmod.Q1.ExecSQL;
//!SubNot
    dmod.Q1.Active := False;
    dmod.Q1.SQL.Text := 'Delete from contr_subNot where sUBiD=''' + dmod.q2.fieldbyname('SubId').asstring + '''';
    dmod.Q1.ExecSQL;
//!Insur
    dmod.Q1.Active := False;
    dmod.Q1.SQL.Text := 'Delete from contr_insur where sUBiD=''' + dmod.q2.fieldbyname('SubId').asstring + '''';
    dmod.Q1.ExecSQL;
    DMOD.Q2.NEXT;
  end;
//!Sub
  dmod.Q1.Active := False;
  dmod.Q1.SQL.Text := 'Delete from contr_sub where contrid=''' + inttostr(contrid) + '''';
  dmod.Q1.ExecSQL;
//! In till History...
  SaveContrHist(0, ContrID, 'Deletad', 'Borttagen', frmMain.sign, 99);
end;

procedure TfrmSearch.GetBestPrice(From, Tom: TDateTime; KmTot: Integer;
  const PType, PClass: WideString; var Days, Km, XDays, XKm,
  SRisk: Currency);
var
  tempdays, rad: word;
  minpris, Selfrisk, tidkostnad, kmkostnad: real;
  minrad, Rdays, Rhours: integer;
  dag, prisdygn, prisxdygn, maxpris: real;
  srdag, maxdagar: word;
  mindag, antdag, kostnad, inkl, xdygn, xinkl: real;
  over: real;
  overkm, overdag, AllowMoreDays: boolean;

  Test: integer;
  loop1: integer;
begin
//!010227
  frmgreg.pricetabrowsT.close;
  frmgreg.pricetabrowsT.OPen;
//!Hit
//  minrad := -1;
  minpris := 2000000;
  mindag := 0;
  antdag := 0;
  kostnad := 0;
  inkl := 0;
  over := 0;
  xdygn := 0;
  xinkl := 0;
  tidkostnad := 0;
  kmkostnad := 0;
//  tempdays := 0;
  AllowMoreDays := false;

  Days := 0;
  Km := 0;
  XDays := 0;
  XKm := 0;
  SRisk := 0;
  with frmGreg.PricetabT do
  begin
    Filter := 'PKlass = ''' + string(PClass) + ''' AND PTYP = ''' + string(PType) + ''' AND FDat<=''' + datetostr(From) + ''' AND TDat >=''' + Datetostr(From) + '''';
    Filtered := true;
    Rdays := Trunc(Tom - From);
    RHours := Trunc((Tom - From) * 24);

    if (Rdays < FieldByName('SR_DAG2').value) then
      Rdays := Trunc(FieldByName('SR_DAG2').value);
    if (Rdays = FieldByName('SR_DAG2').value) and (Rhours < FieldByName('SR_MAX2').value) then
      RHours := Trunc(FieldByName('SR_MAX2').value);

    // **** självriskreducerings beräkning ****
    prisdygn := FieldByName('SR_DYGN').AsFloat;
    prisxdygn := FieldByName('SR_OVERDYGN').AsFloat;
    maxdagar := trunc(FieldByName('SR_DAG1').AsFloat);
    maxpris := FieldByName('SR_MAX1').AsFloat;

    if RHours - RDays * 24 > Dmod.ParamT.Fieldbyname('TimFrist').AsFloat then // Om mer än 1 timme överskjuter, räkna upp antal dagar.
      srdag := trunc(RHours / 24) + 1
    else
      srdag := Rdays;

    if srdag > maxdagar then
      selfrisk := prisdygn * maxdagar + (srdag - maxdagar) * prisxdygn
    else
      selfrisk := prisdygn * srdag;
    if maxdagar = 0 then
      maxdagar := 1;
    dag := Trunc((srdag - 1) / maxdagar) + 1;

    if srdag > maxdagar then
    begin
      if selfrisk > ((srdag div maxdagar) * maxpris) + ((srdag mod maxdagar) * prisxdygn) then
        selfrisk := ((srdag div maxdagar) * maxpris) + ((srdag mod maxdagar) * prisxdygn);
    end
    else
    begin
      if selfrisk > maxpris then
        selfrisk := maxpris;
    end;

    SRisk := round(selfrisk);

    // **** Huvudsnurra för att gå igenom alla rader i pristabellen *****
    rad := 0;

    FrmGreg.PriceTabRowsT.First;
    while not FrmGreg.PriceTabRowsT.EOF do
    begin
      if rad = 0 then
      begin
        // Beräkna timhyreskostnad **************
        if FieldByName('SR_DAG2').value < 1 then
        begin
        //!för att sätta Timmar till Minsta antal Timmar...
          if FrmGreg.PriceTabT.Locate('PKlass;PTyp', VarArrayOf([pclass, PType]), [lopartialkey])
            then
            if RHours < FrmGreg.PriceTabT.FieldByname('SR_MAX2').asinteger
              then RHours := FrmGreg.PriceTabT.FieldByname('SR_MAX2').asinteger;
           //!Hit
          tidkostnad := RHours * FieldByName('PRIS_TIM').AsFloat;
          kmkostnad := KMTot * FieldByName('KOST_TIM').AsFloat;
          kostnad := 1;
        end;
      end
      else
      begin
        mindag := FrmGreg.PriceTabRowsT.FieldByName('MINDAG').AsFloat;
        antdag := FrmGreg.PriceTabRowsT.FieldByName('PRISDAG').AsFloat;
        kostnad := FrmGreg.PriceTabRowsT.FieldByName('KOST').AsFloat;
        inkl := FrmGreg.PriceTabRowsT.FieldByName('INKL_KM').AsFloat;
        over := FrmGreg.PriceTabRowsT.FieldByName('OVERKM').AsFloat;
        xdygn := FrmGreg.PriceTabRowsT.FieldByName('XDYGN').AsFloat;
        xinkl := FrmGreg.PriceTabRowsT.FieldByName('XINKLKM').AsFloat;
        FrmGreg.PriceTabRowsT.next;
      end;

      if (Rdays >= mindag) or AllowMoreDays or (rad = 0) then
      begin
        if (kostnad > 0) and (antdag > 0) then
        begin
          overdag := false;
          overkm := false;
        end; //!000815
      end; //!000815
      if rad <> 0 then // Hoppa över om timhyra
      begin

            // **** Hyrkostnad ****
        if RHours - RDays * 24 > Dmod.ParamT.FieldbyName('TimFrist').AsFloat then // Om mer än 1 timme överskjuter, räkna upp antal dagar.
          inc(Rdays);

        if Rdays < mindag then
          tempdays := trunc(mindag)
        else
          tempdays := Rdays;

        tidkostnad := kostnad;

        if tempdays > antdag then
        begin
          overdag := true;
          if Xdygn > 0 then
            tidkostnad := tidkostnad + (tempdays - antdag) * Xdygn
          else
            if frac(tempdays / antdag) > 0 then
              tidkostnad := (Trunc(tempdays / antdag) + 1) * kostnad
            else
              tidkostnad := Trunc(tempdays / antdag) * kostnad
        end else
        begin
          overdag := false;
        end;

            // Beräkna km kostnad *****

        if not overdag then
        begin
          if kmtot > inkl then
            kmkostnad := (kmtot - inkl) * over
          else
            kmkostnad := 0;
        end
        else
        begin
          if kmtot > inkl + xinkl * Trunc(tempdays - antdag) then
            kmkostnad := (kmtot - inkl - xinkl * Trunc(tempdays - antdag)) * over
          else
            kmkostnad := 0;
        end;

            // Kontrollera överkm *****
        if over > 0 then
        begin
          if overdag then
          begin
            if xinkl > 0 then
            begin
              if (kmtot - inkl - (xinkl * Trunc(tempdays - antdag)) > 0) and (inkl > 0) then
                overkm := true;
            end
            else
              if (kmtot - inkl * Trunc(tempdays - antdag) > 0) and (inkl > 0) then
//              if (tempdays - antdag > 0) and (kmtot - inkl * Trunc(tempdays - antdag) > 0) and (inkl > 0) then
                overkm := true;
          end
          else
            if (kmtot - inkl > 0) and (inkl > 0) then
              overkm := true;

              // beräkna ny kmkostnad om överkm ****
          if overkm then
            if overdag then
            begin
              if xinkl > 0 then
                kmkostnad := (kmtot - inkl - xinkl * Trunc(tempdays - antdag)) * over
              else
                kmkostnad := (kmtot - inkl * Trunc(tempdays - antdag)) * over;
            end
            else
              kmkostnad := (kmtot - inkl) * over;
        end;
      end;
//! Benny för prisberäkning...
      if kmkostnad < 0 then
        KmKostnad := 0;

          // **** Om detta pris är det billigaste hittills *****
      if minpris = 0 then minpris := 2000000; //!000815
          //!Hit
      if minpris > round(tidkostnad + kmkostnad) then
      begin
        if overdag and (xdygn > 0) then
        begin
          xdays := round(tidkostnad - kostnad);
          days := round(kostnad);
        end
        else
        begin
          days := round(tidkostnad);
          xdays := 0;
        end;
        if overkm then
        begin
          km := 0;
          xkm := round(kmkostnad);
        end
        else
        begin
          km := round(kmkostnad);
          xkm := 0;
        end;
//! Tagit bort remarken
        if rad > 0 then
        begin
          if overdag and (xdygn > 0) then
            mintidtext := '( ' + inttostr(round(antdag)) + ' dagar )'
          else
            mintidtext := '( ' + inttostr(Tempdays) + ' dagar )';
        end
        else
          mintidtext := '( ' + inttostr(RHours) + ' timmar )';
//!Hit
        minpris := km + days + xkm + xdays;
      end;
      inc(rad);
    end; // while

    if FieldByName('InkMoms').AsBoolean then //Dra bort momsen
    begin
      km := round(km * 100 / (100 + Dmod.ParamT.FieldByName('MOMS').AsFloat));
      days := round(days * 100 / (100 + Dmod.ParamT.FieldByName('MOMS').AsFloat));
      xkm := round(xkm * 100 / (100 + Dmod.ParamT.FieldByName('MOMS').AsFloat));
      xdays := round(xdays * 100 / (100 + Dmod.ParamT.FieldByName('MOMS').AsFloat));
      SRisk := round(SRisk * 100 / (100 + Dmod.ParamT.FieldByName('MOMS').AsFloat));
    end;
  end;
end;

procedure TfrmSearch.SaveContrHist(HistNr, ContrId: Integer; const Subject,
  Notes, Sign: WideString; Status: Integer);
var
  oldHist: boolean;
begin
  try
    if (HistNr > 0) then
    begin
      Dmod.Q1.Active := False;
      Dmod.Q1.Sql.Text := 'Update Contr_Hist set ContrId=' + DBDel + Inttostr(Contrid) + DBDel + ',Subject=' + DBDel + Subject + DBDel + ', Note=' + DBDel + Notes + DBDel + ',Sign=' + DBDel + Sign + DBDel + ', Status=' + DBDel + Inttostr(Status) + DBDel + ' Where HistNr =' + dbDel + inttostr(Histnr) + dbdel + '';
      Dmod.Q1.ExecSQL;
    end
    else
    begin
      dmod.Q1.Active := False;
      dmod.Q1.SQL.Text := 'Insert into Contr_Hist(ContrId,Time, Subject,Note,Sign,Status) Values(' + dbdel + Inttostr(ContrID) + dbdel + ',' + dbdel + DateTimeToStr(Now) + dbdel + ',' + dbdel + SUbject + dbdel + ',' + dbdel + Notes + dbdel + ',' + dbdel + Sign + dbdel + ',' + dbdel + inttostr(Status) + dbdel + ')';
      dmod.Q1.ExecSQL;
    end;
  except
  end;
end;

procedure TfrmSearch.BeginTransaction;
begin
//!  DMSession.DBAccess.StartTransaction;
end;

function TfrmSearch.GetNewNo(NrType: NrTypes): Integer;
begin
  DMod.ParamT.Close;
  DMod.ParamT.Open;
  DMod.ParamT.Edit;
  case NrType of
    KontantNr:
      begin
        result := DMod.ParamT.fieldbyname('KNoteNr').AsInteger + 1;
        DMod.ParamT.fieldbyname('KNoteNr').AsInteger := result;
      end;
    FakturaNr:
      begin
        result := DMod.ParamT.fieldbyname('FaktNr').AsInteger + 1;
        DMod.ParamT.fieldbyname('FaktNr').AsInteger := result;
      end;
    InternNr:
      begin
        result := DMod.ParamT.fieldbyname('InternNr').AsInteger + 1;
        DMod.ParamT.fieldbyname('InternNr').AsInteger := result;
      end;
    OffertNr:
      begin
        result := DMod.ParamT.fieldbyname('OffertNr').AsInteger + 1;
        DMod.ParamT.fieldbyname('OffertNr').AsInteger := result;
      end;
    UnderNr:
      begin
        result := DMod.ParamT.fieldbyname('FaktNr').AsInteger + 1;
        DMod.ParamT.fieldbyname('FaktNr').AsInteger := result;
      end;
    KontraktNr:
      begin
        result := DMod.ParamT.fieldbyname('KontrNr').AsInteger + 1;
        DMod.ParamT.fieldbyname('KontrNr').AsInteger := result;
      end;
  end;
  DMod.ParamT.Post;
end;

function TfrmSearch.SaveContrBase(ContractNo, CustId: Integer; const Sign,
  Referens: WideString; Status: Integer; const Payment: WideString;
  PayDays: Integer; Delfakt : Boolean; StartDatum,SlutDatum, Belopp : String): Byte;
begin
  result := 0;
  With Dmod.Q3 do
  begin
    Active := False;
    SQL.Text := 'select * from Contr_Base where Contrid=' + dbdel + inttostr(ContractNo) + dbdel;
    Active := True;
    if RecordCount > 0 then
    begin
      Edit;
    end
    else
    begin
      Append;
      FieldByName('ContrId').AsInteger := ContractNo;
      FieldByName('DF_FAKT2DATUM').AsString := '';
      FieldByName('DF_ACKBELOPP').AsInteger := 0;
    end;

    FieldByName('Custid').AsInteger := CustId;
    FieldByName('Contr_Date').AsDateTime := Now;
    FieldByName('Sign').AsString := Sign;
    FieldByName('Referens').AsString := Referens;
    FieldByName('Status').AsInteger := Status;
    FieldByName('Payment').AsString := Payment;
    FieldByName('Pay-fact').AsInteger := PayDays;
    if DelFakt then
      FieldByName('DF').AsInteger := 1
    else
      FieldByName('DF').AsInteger := 0;
    FieldByName('DF_STARTDATUM').AsString := StartDatum;
    try
      FieldByName('DF_BELOPP').AsInteger := StrToInt(Belopp);
    except
      FieldByName('DF_BELOPP').AsInteger := 0;
    end;
    FieldByName('DF_SLUTDATUM').AsString := SlutDatum;
    Post;
  end;
  result := 1;
  dmod.Q3.Active := False;
end;

function TfrmSearch.SaveContrObjT(ContrID: Integer; const ObjTyp,
  REGNR: WideString; FTime, TTime, OTime, RTime: TDateTime; KmOut, KmIn,
  KmBer: Integer; const PClass, PType: WideString; SRRed: WordBool;
  Status: Integer; const CarryCar: WideString; InvNo: Integer): Integer;
var
  OID: string;
  OTid, RTid: string;
  RR: string;
begin
  OID := Regnr;
  if SRRed = True then
    RR := '1'
  else
    RR := '0';
  if status < 2 then
  begin
    Otid := DateTimeToStr(Ftime);
    RTid := DateTimeToStr(Ttime);
  end else
  begin
    Otid := DateTimeToStr(Otime);
    RTid := DateTimeToStr(Rtime);
  end;
  result := 0;
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_ObjT where Contrid=' + dbdel + inttostr(ContrId) + dbdel + ' AND OID=' + dbdel + OID + dbdel + '';
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    result := 1;
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_ObjT set Frm_Time=' + DBDel + DateTimeToStr(Ftime) + DBDel + ',To_Time=' + DBDel + DateTimeToStr(TTime) + DBDel + ',Out_time=' + DBDel + OTid + DBDel + ',Ret_time=' + DBDel + RTid + DBDel + ',KM_Out=' + DBDel + inttostr(KmOut) + DBDel + ',KM_In=' + DBDel + Inttostr(KMIn) + DBDel + ',Km_Ber=' + DBDel + Inttostr(KMBer) + DBDel + ',PClass=' + DBDel + PClass + DBDel + ',PType=' + DBDel + PType + DBDel + ',SRRed=' + DBDel + RR + DBDel + ',Status=' + DBDel + Inttostr(Status) + DBDel + ',CarryCar=' + DBDel + CarryCar + DBDel + 'where contrid=' + DBDel + inttostr(ContrId) + DBDel + ' AND OID=' + DBDel + OID + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_ObjT(ContrId,OID, ObTypId,Frm_Time,To_Time,Out_time,Ret_Time,Km_Out,Km_In,Km_Ber,PClass,PType, SRRed, Status, CarryCar) Values (' + dbdel + Inttostr(ContrId) + dbdel + ',' + dbdel + OID + dbdel + ',' + dbdel + ObjTyp + dbdel + ',' + dbdel + DateTimeToStr(Ftime) + dbdel + ',' + dbdel + DateTimeToStr(TTime) + dbdel + ',' + dbdel + OTid + dbdel + ',' + dbdel + RTid + dbdel + ',' + dbdel + Inttostr(KMOut) + dbdel + ',' + dbdel + Inttostr(KMIn) + dbdel + ',' + dbdel + Inttostr(KMBer) + dbdel + ',' + dbdel + PClass + dbdel + ',' + dbdel + PType + dbdel + ',' + dbdel + RR + dbdel + ',' + dbdel + Inttostr(Status) + dbdel + ',' + dbdel + CarryCar + dbdel + ')';
    dmod.Q4.ExecSQL;
    result := 1;
  end;
  dmod.Q3.Active := False;
end;

procedure TfrmSearch.SaveContrComp(ContrID, DriveID: Integer;
  SRiskReduc: WordBool; SRDygn, Dep: Integer);
var
  BDep, SRisk: string;
begin
  if SRiskReduc then
    srisk := '1' else
    srisk := '0';

  if dep > 0 then
    BDep := '1' else
    BDep := '0';

  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_Base where Contrid=' + dbdel + inttostr(ContrID) + dbdel;
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_Base set DriveID=' + DBDel + inttostr(DriveID) + DBDel + ', SRiskreduc=' + DBDel + SRisk + DBDel + ', Sr_Dygnspremie=' + DBDel + Inttostr(SRDygn) + DBDel + ',Deposit=' + DBDel + BDep + DBDel + ', Dep_Amount=' + DBDel + inttostr(Dep) + DBDel + ' where  contrid=' + DBDel + inttostr(ContrID) + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_Base(ContrId,DriveId, SRiskReduc,SR_Dygnspremie,Deposit,Dep_Amount) Values (' + dbdel + Inttostr(ContrID) + dbdel + ',' + dbdel + inttostr(DriveID) + dbdel + ',' + dbdel + SRisk + dbdel + ',' + dbdel + Inttostr(Srdygn) + dbdel + ',' + dbdel + BDep + dbdel + ',' + dbdel + Inttostr(Dep) + dbdel + ')';
    dmod.Q4.ExecSQL;
  end;
  dmod.Q3.Active := False;
end;

procedure TfrmSearch.SaveContrNot(ContrId: Integer; const CNot1, CNot2,
  INot1, INot2: WideString);
begin
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_Not where Contrid=' + dbdel + inttostr(ContrID) + dbdel;
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_Not set Cnot1=' + DBDel + Cnot1 + DBDel + ', Cnot2=' + DBDel + Cnot2 + DBDel + ', INot1=' + DBDel + INot1 + DBDel + ',Inot2=' + DBDel + Inot2 + DBDel + ' where  contrid=' + DBDel + inttostr(ContrID) + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_Not(ContrId,CNot1,Cnot2,INot1,Inot2) Values (' + dbdel + Inttostr(ContrID) + dbdel + ',' + dbdel + CNot1 + dbdel + ',' + DBDel + CNot2 + DBDel + ',' + dbdel + INot1 + dbdel + ',' + dbdel + INot2 + dbdel + ')';
    dmod.Q4.ExecSQL;
  end;
  dmod.Q3.Active := False;
end;

procedure TfrmSearch.SaveContrCosts(ContrID: Integer;
  const CostName: WideString; No: Real; Price: Currency; VAT: Double;
  Acc_code, Acc_center: Integer);
var
  cname: string;
  tmp: Char;
begin
  try
    tmp := DecimalSeparator;
    DecimalSeparator := '.';
    cname := Costname;
    dmod.Q3.Active := False;
    dmod.Q3.SQL.Text := 'select * from Contr_Costs where Contrid=' + dbdel + inttostr(ContrId) + dbdel + ' AND Costname=' + dbdel + Cname + dbdel + '';
    dmod.Q3.Active := True;
    if dmod.Q3.RecordCount > 0 then
    begin
//! Update
      dmod.Q4.Active := False;
      dmod.Q4.SQL.Text := 'Update Contr_Costs set No=' + DBDel + floattostr(No) + DBDel + ',Price=Convert(Money,' + DBDel + StringReplace(Currtostr(Price), ',', '.', [rfreplaceall]) + DBDel + '),VAT=' + DBDel + floattostr(VAT) + DBDel + ',Acc_Code=' + DBDel + Inttostr(Acc_Code) + DBDel + ',Acc_Center=' + DBDel + inttostr(Acc_Center) + DBDel + ' where contrid=' + DBDel + inttostr(ContrId) + DBDel + ' AND Costname=' + DBDel + CostName + DBDel + '';
      dmod.Q4.ExecSQL;
    end else
    begin
//! Insert
      dmod.Q4.Active := False;
      dmod.Q4.SQL.Text := 'Insert into Contr_Costs(ContrId,Costname, No,price,VAT,Acc_Code,Acc_Center) Values (' + dbdel + Inttostr(ContrId) + dbdel + ',' + dbdel + Costname + dbdel + ',' + dbdel + floattostr(No) + dbdel + ',Convert(Money,' + dbdel + StringReplace(Currtostr(Price), ',', '.', [rfreplaceall]) + dbdel + '),' + dbdel + floattostr(VAT) + dbdel + ',' + dbdel + Inttostr(Acc_Code) + dbdel + ',' + dbdel + Inttostr(Acc_Center) + dbdel + ')';
      dmod.Q4.ExecSQL;
    end;
    dmod.Q3.Active := False;
  finally
    DecimalSeparator := tmp;
  end;
end;

procedure TfrmSearch.UpdateCreditCard(CustId: Integer; const CardId,
  CardNo, KortExp: WideString);
begin
  dmod.Q4.Active := False;
  dmod.Q4.SQL.Text := 'Update Customer set KTyp=' + DBDel + CardID + DBDel + ', KontoNr=' + DBDel + CardNo + DBDel + ', KExp=' + DBDel + KortExp + DBDel + ' Where Cust_Id =' + dbdel + Inttostr(Custid) + dbdel + '';
  dmod.Q4.ExecSQL;
end;

function TfrmSearch.SavePartPayer(ContrID, SubCustId: Integer;
  const SubName, Contact: WideString; SpPercent: WordBool; SpRule_rent,
  SpRule_KM, SpRule_Vat: Integer; const Payment: WideString;
  Terms_Pay: Integer): Integer;
var
  SB: string;
begin
  if SpPercent then
    SB := '1' else
    SB := '0';
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_Sub where Contrid=' + dbdel + inttostr(ContrId) + dbdel + ' AND SubCustId=' + dbdel + Inttostr(SubCustId) + dbdel + '';
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_Sub set SubName=' + DBDel + SubName + DBDel + ',Contact=' + DBDel + Contact + DBDel + ',SpPercent=' + DBDel + SB + DBDel + ',SpRule_Rent=' + DBDel + Inttostr(SpRule_Rent) + DBDel + ',SpRule_Km=' + DBDel + inttostr(SpRule_KM) + DBDel + ',SPRule_Vat=' + DBDel + Inttostr(SpRule_Vat) + DBDel + ',Payment=' + DBDel + Payment + DBDel + ',Terms_Pay=' + DBDel + Inttostr(Terms_Pay) + DBDel + ' where contrid=' + DBDel + inttostr(ContrId) + DBDel + ' AND SubCustID=' + DBDel + inttostr(SubCustID) + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_Sub(ContrId,SubCustId,Subname,Contact,SpPercent,SpRule_Rent,SpRule_KM,SpRule_VAT,Payment,Terms_Pay) Values (' + dbdel + Inttostr(ContrId) + dbdel + ',' + dbdel + Inttostr(SubCustID) + dbdel + ',' + dbdel + SubName + dbdel + ',' + dbdel + Contact + dbdel + ',' + dbdel + SB + dbdel + ',' + dbdel + Inttostr(SpRule_rent) + dbdel + ',' + dbdel + Inttostr(SpRule_KM) + dbdel + ',' + dbdel + Inttostr(SpRule_VAT) + dbdel + ',' + dbdel + Payment + dbdel + ',' + dbdel + Inttostr(Terms_Pay) + dbdel + ')';
    dmod.Q4.ExecSQL;
  end;
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select SUBID from Contr_Sub where Contrid=' + dbdel + inttostr(ContrId) + dbdel + ' AND SubCustId=' + dbdel + Inttostr(SubCustId) + dbdel + '';
  dmod.Q3.Active := True;
  result := StrtoInt(dmod.q3.fieldbyname('SubId').asstring);
  dmod.Q3.Active := False;
end;

procedure TfrmSearch.SavePartCost(SubId: Integer; DSUM, DHYR, DMOMS,
  DTOTAL: Extended; const KontoTyp, KontoNr: WideString;
  K_SparrKoll: WordBool; const K_SparrNr: WideString);
var
  KKoll: string;
begin
  if K_SparrKoll then
    KKoll := '1' else
    KKoll := '0';
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_SubCost where SubID=' + dbdel + inttostr(SubID) + dbdel;
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_SubCost set DSum=convert(Money,' + DBDel + StringReplace(Currtostr(Dsum), ',', '.', [rfreplaceall]) + DBDel + '),DHyr=convert(Money,' + DBDel + StringReplace(Currtostr(DHyr), ',', '.', [rfreplaceall]) + DBDel + '), DMoms=convert(Money,' + DBDel + StringReplace(Currtostr(DMoms), ',', '.', [rfreplaceall]) + DBDel + '),DTotal=convert(Money,' + DBDel + StringReplace(Currtostr(DTotal), ',', '.', [rfreplaceall]) + DBDel + '), KontoTyp=' + DBDel + KontoTyp + DBDel + ', KontoNr=' + DBDel + KontoNr + DBDel + ',K_Sparrkoll=' + DBDel + KKoll + DBDel + ',K_SparrNr=' + DBDel + K_SparrNr + DBDel + ' where SubID=' + DBDel + inttostr(SubId) + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_SubCost(SubId,DSum,DHyr,DMoms,DTotal,KontoTyp,KontoNr,K_Sparrkoll,K_SparrNr) Values (' + dbdel + Inttostr(SubID) + dbdel + ',Convert(Money,' + dbdel + StringReplace(Currtostr(Dsum), ',', '.', [rfreplaceall]) + dbdel + '),convert(Money,' + DBDel + StringReplace(Currtostr(DHyr), ',', '.', [rfreplaceall]) + DBDel + '),Convert(Money,' + dbdel + StringReplace(Currtostr(DMoms), ',', '.', [rfreplaceall]) + dbdel + '),Convert(Money,' + dbdel + StringReplace(Currtostr(DTotal), ',', '.', [rfreplaceall]) + dbdel + '),' + dbdel + KontoTyp + dbdel + ',' + dbdel + KontoNr + dbdel + ',' + dbdel + KKoll + dbdel + ',' + dbdel + K_SparrNr + dbdel + ')';
    dmod.Q4.ExecSQL;
  end;
  dmod.Q3.Active := False;
end;

procedure TfrmSearch.SavePartRow(SubId, RowNr: Integer;
  const RowText: WideString; Value, Percent: Extended; ByValue: WordBool);
var
  BV: string;
begin
  if ByValue then
    BV := '1' else
    BV := '0';
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_SubCostRow where SubId=' + dbdel + inttostr(SubId) + dbdel + ' AND RowNumb=' + dbdel + inttostr(RowNr) + dbdel + '';
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_SubCostRow set RowText=' + DBDel + RowText + DBDel + ',Value=convert(Money,' + DBDel + StringReplace(Currtostr(Value), ',', '.', [rfreplaceall]) + DBDel + '),[Percent]=' + DBDel + Floattostr(Round(Percent)) + DBDel + ',ByValue=' + DBDel + BV + DBDel + ' where SubId=' + DBDel + inttostr(SubId) + DBDel + ' AND RowNumb=' + DBDel + Inttostr(RowNr) + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_SubCostRow(SubId,RowNumb,RowText,Value, [Percent],ByValue) Values (' + dbdel + Inttostr(SubId) + dbdel + ',' + dbdel + INttostr(RowNr) + dbdel + ',' + dbdel + RowText + dbdel + ',Convert(Money,' + dbdel + StringReplace(Currtostr(Value), ',', '.', [rfreplaceall]) + dbdel + '),' + dbdel + floattostr(round(Percent)) + dbdel + ',' + dbdel + BV + dbdel + ')';
    dmod.Q4.ExecSQL;
  end;
  dmod.Q3.Active := False;
end;

function TfrmSearch.GetNewCustomerId: Integer;
var
  OKuId: Integer;
begin
  Result := 0;
  dmod.Q4.Active := False;
  dmod.Q4.SQL.Text := 'Update Param set KundId= KundId+1';
  dmod.Q4.ExecSQL;
  dmod.Q4.Active := False;
  dmod.Q4.SQL.Text := 'Select KundID from Param';
  dmod.Q4.Active := True;
  result := dmod.Q4.fieldbyname('KundID').AsInteger;
  dmod.Q4.Active := False;
end;

procedure TfrmSearch.SavePartNote(SubId, KID: Integer; const FaktAtt,
  FaktNot1, FaktNot2: WideString);
begin
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_SubNot where SubID=' + dbdel + inttostr(SubID) + dbdel;
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_SubNot set Kid=' + DBDel + inttostr(Kid) + DBDel + ', FaktAtt=' + DBDel + FaktAtt + DBDel + ', FaktNot1=' + DBDel + FaktNot1 + DBDel + ',FaktNot2=' + DBDel + FaktNot2 + DBDel + ' where  SubId=' + DBDel + inttostr(SubId) + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_SubNot(SubID,Kid,FaktATT,FaktNot1,FaktNot2) Values (' + dbdel + Inttostr(SubID) + dbdel + ',' + dbdel + inttostr(KID) + dbdel + ',' + DBDel + FaktAtt + DBDel + ',' + dbdel + FaktNot1 + dbdel + ',' + dbdel + FaktNot2 + dbdel + ')';
    dmod.Q4.ExecSQL;
  end;
  dmod.Q3.Active := False;
{
  if DMod.Contr_SubNotT.Locate('SubId', SubId, [lopartialkey]) then
    DMod.Contr_SubNotT.Edit
  else
  begin
    DMod.Contr_SubNotT.Append;
    DMod.Contr_SubNotT.Fieldbyname('SubID').AsInteger := SubId;
  end;
  DMod.Contr_SubNotT.Fieldbyname('Kid').AsInteger := Kid;
  DMod.Contr_SubNotT.Fieldbyname('FaktAtt').AsString := FaktAtt;
  DMod.Contr_SubNotT.Fieldbyname('FaktNot1').AsString := FaktNot1;
  DMod.Contr_SubNotT.Fieldbyname('FaktNot2').AsString := FaktNot2;
  DMod.Contr_SubNotT.Post;
}
end;

procedure TfrmSearch.DeleteContrHist(HistId: Integer);
begin
  if (HistId > 0) then
    if DMod.Contr_HistT.locate('HistId', HistId, [lopartialkey]) then
      DMod.Contr_HistT.delete;
end;

procedure TfrmSearch.SaveInsurInfo(SubId: Integer; const ICode: WideString;
  IDate: TDateTime; const FRegNr, IClass, INo, MPRegNr: WideString);
begin
  dmod.Q3.Active := False;
  dmod.Q3.SQL.Text := 'select * from Contr_Insur where SubID=' + dbdel + inttostr(SubID) + dbdel;
  dmod.Q3.Active := True;
  if dmod.Q3.RecordCount > 0 then
  begin
//! Update
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Update Contr_Insur set ICode=' + DBDel + ICode + DBDel + ', IDate=' + DBDel + DateTimeToStr(IDate) + DBDel + ', FregNr=' + DBDel + FregNr + DBDel + ',IClass=' + DBDel + IClass + DBDel + ', INumber=' + DBDel + INo + DBDel + ', MPRegNr=' + DBDel + MPRegNR + DBDel + ' where SubID=' + DBDel + inttostr(SubID) + DBDel + '';
    dmod.Q4.ExecSQL;
  end else
  begin
//! Insert
    dmod.Q4.Active := False;
    dmod.Q4.SQL.Text := 'Insert into Contr_Insur(SubID,ICode,IDate,FRegNr,IClass,INumber,MPRegNr) Values (' + dbdel + Inttostr(SubID) + dbdel + ',' + dbdel + ICode + dbdel + ',' + DBDel + DateTimeToStr(IDate) + DBDel + ',' + dbdel + FregNr + dbdel + ',' + dbdel + IClass + dbdel + ',' + dbdel + INO + dbdel + ',' + dbdel + MPRegNr + dbdel + ')';
    dmod.Q4.ExecSQL;
  end;
  Dmod.Q3.Active := False;
end;

procedure TfrmSearch.ChangeContrId(ContrId, NewContrId: Integer);
begin
  Dmod.Q1.Active := False;
  Dmod.Q1.Sql.Text := 'Update Contr_Base Set Contrid=' + dbdel + Inttostr(NewContrId) + dbdel + ' where Contrid=' + dbdel + Inttostr(contrid) + dbdel + '';
  Dmod.Q1.ExecSQL;
{
  if DMod.Contr_BaseT.Locate('ContrId', ContrId, [lopartialkey]) then
  begin
    DMod.Contr_BaseT.Edit;
    DMod.Contr_BaseT.Fieldbyname('ContrID').AsInteger := NewContrId;
    DMod.Contr_BaseT.Post;
  end;
}
end;

procedure TfrmSearch.BitBtn3Click(Sender: TObject);
var x: string;
  i, j: Integer;
begin
  BitBtn4.Enabled := True;
  if panel2.visible then
    panel2.visible := False
  else
  begin
    panel2.visible := true;
    i := -1;
    Combobox1.clear;
    j := (dbgrid1.Columns.Count) - 1;
    while i < j do
    begin
      inc(i);
      x := dbgrid1.Columns.Items[i].Title.Caption;
      combobox1.Items.Add(x);
    end;
    Combobox1.text := 'Fältval';
    combobox1.setfocus;
  end;
end;

procedure TfrmSearch.FormDeactivate(Sender: TObject);
begin
  btnprintcontr.visible := False;
  Panel2.visible := False;
  Combobox1.clear;
  Edit2.text := 'Ange Värde ';
end;

procedure TfrmSearch.BitBtn4Click(Sender: TObject);
var SStr, Seek, TmpStr: string;
  i, j: Integer;
begin
  if Trim(edit2.text) = '' then
    Exit;
  BitBtn4.Enabled := False;
  i := combobox1.itemindex;
  SStr := dbgrid1.Columns.Items[i].Fieldname;
  TmpStr := '';
  if BitBtn4.Tag = 1 then
    TmpStr := ssearchcds.Filter + ' and ';
//!Gör om * till %
  seek := StringReplace(edit2.text, '*', '%', [rfReplaceAll]);

// Ta bort sista % för att inte få fel i söksträngen
  j := Length(seek);
  if seek[j] = '%' then
    SetLength(seek, j - 1);

  case dbgrid1.Columns.Items[i].Field.DataType of

    ftString, ftBlob, ftMemo, ftWideString:
      begin
        ssearchcds.Filter := TmpStr + sstr + ' Like ''' + seek + '%''';
      end;
    ftDateTime:
      begin
        ssearchcds.Filter := TmpStr + sstr + '>= ''' + seek + ''' and ' + sstr + '<= ''' + seek + ' 23:59:00''';
      end
  else
    begin
      ssearchcds.Filter := TmpStr + sstr + ' = ' + seek + ' ';
    end;
  end;
//!
  ssearchcds.Filtered := true;

  BitBtn4.Enabled := true;
  BitBtn4.Tag := 1;

  DbGrid1.setfocus;
end;

procedure TfrmSearch.BitBtn2Click(Sender: TObject);
begin
  ssearchcds.filtered := False;
end;

procedure TfrmSearch.SpeedButton1Click(Sender: TObject);
begin
  ssearchcds.filtered := False;
  SSearchCDS.Filter := '';
  Combobox1.text := 'Fältval';
  Edit2.text := 'Ange Värde';
  BitBtn4.Enabled := True;
  BitBtn4.Tag := 0;
  ComboBox1.SetFocus;

end;

procedure TfrmSearch.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_F5 then bitbtn4.click;
end;

procedure TfrmSearch.SetGridBokning;
begin
{
  dbgrid1.Columns.Items[0].Title.Caption := 'Status';
  dbgrid1.Columns.Items[1].Title.Caption := 'Kontrakt';
  dbgrid1.Columns.Items[2].Title.Caption := 'RegNr';
  dbgrid1.Columns.Items[3].Title.Caption := 'Från';
  dbgrid1.Columns.Items[4].Title.Caption := 'Till';
  dbgrid1.Columns.Items[5].Title.Caption := 'Namn';
}
end;

procedure TfrmSearch.SetGridKontrakt;
begin
{
  dbgrid1.Columns.Items[0].Title.Caption := 'Status';
  dbgrid1.Columns.Items[1].Title.Caption := 'Kontrakt';
  dbgrid1.Columns.Items[2].Title.Caption := 'RegNr';
  dbgrid1.Columns.Items[3].Title.Caption := 'Från';
  dbgrid1.Columns.Items[4].Title.Caption := 'Till';
  dbgrid1.Columns.Items[5].Title.Caption := 'Namn';
}
end;

procedure TfrmSearch.SetGridKundId;
begin
{
  dbgrid1.Columns.Items[0].Title.Caption := 'OrgNr';
  dbgrid1.Columns.Items[1].Title.Caption := 'Namn';
  dbgrid1.Columns.Items[2].Title.Caption := 'Adress';
  dbgrid1.Columns.Items[3].Title.Caption := 'PostAdr';
  dbgrid1.Columns.Items[4].Title.Caption := 'Tele';
  dbgrid1.Columns.Items[5].Title.Caption := 'KundNr';
}
end;

procedure TfrmSearch.SetGridNamn;
begin
{
  dbgrid1.Columns.Items[0].Title.Caption := 'OrgNr';
  dbgrid1.Columns.Items[1].Title.Caption := 'Namn';
  dbgrid1.Columns.Items[2].Title.Caption := 'Adress';
  dbgrid1.Columns.Items[3].Title.Caption := 'PostAdr';
  dbgrid1.Columns.Items[4].Title.Caption := 'Tele';
  dbgrid1.Columns.Items[5].Title.Caption := 'KundNr';
}
end;

procedure TfrmSearch.SetGridObjekt;
begin
{
  dbgrid1.Columns.Items[0].Title.Caption := 'Typ';
  dbgrid1.Columns.Items[1].Title.Caption := 'RegNr';
  dbgrid1.Columns.Items[2].Title.Caption := 'Pris';
  dbgrid1.Columns.Items[3].Title.Caption := 'Modell';
  dbgrid1.Columns.Items[4].Title.Caption := 'Tillbehör';
  dbgrid1.Columns.Items[5].Title.Caption := 'Färg';
  dbgrid1.Columns.Items[6].Title.Caption := 'KmSt';
  dbgrid1.Columns.Items[7].Title.Caption := 'Service';
  dbgrid1.Columns.Items[8].Title.Caption := 'ObjNr';
}
end;

procedure TfrmSearch.SetGridReturn;
begin
{
  dbgrid1.Columns.Items[0].Title.Caption := 'Status';
  dbgrid1.Columns.Items[1].Title.Caption := 'Kontrakt';
  dbgrid1.Columns.Items[2].Title.Caption := 'RegNr';
  dbgrid1.Columns.Items[3].Title.Caption := 'Från';
  dbgrid1.Columns.Items[4].Title.Caption := 'Till';
  dbgrid1.Columns.Items[5].Title.Caption := 'Namn';
}
end;

procedure TfrmSearch.FormCreate(Sender: TObject);
begin
  BetsQ.open;
  ObtypQ.open;
  ObjKtQ.Open;
  Priceq.Open;
  CardsQ.open;
  ObjDateQ.Open;
end;

procedure TfrmSearch.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//!
end;

procedure TfrmSearch.BtnPrintContrClick(Sender: TObject);
begin
  eqprn.PrintKvitto(strtoint(dbgrid1.Columns.Items[1].Field.asstring), strtoint(dbgrid1.Columns.Items[6].Field.AsString), 0, 1, true);
end;

function TfrmSearch.CheckObj(RegNr: string): Boolean;
begin
  dmod.Q1.Active := False;
  dmod.Q1.SQL.Text := 'Select * from Objects where reg_no =' + dbdel + RegNr + dbdel;
  dmod.Q1.Active := True;
  if dmod.Q1.RecordCount > 0 then
    result := true
  else
    result := False;
  dmod.Q1.Active := False;
end;

function TfrmSearch.GetSQL_Sign(SqlQ: string): string;
begin
  Dmod.Q1.Active := False;
  Dmod.Q1.Sql.Text := 'Select * from Ini where Signr=' + dbdel + frmmain.sign + dbdel + ' and Prog=' + dbdel + SqlQ + dbdel + '';
  Dmod.Q1.Active := True;
  Result := Dmod.Q1.fieldbyname('Ini').AsString;
  Dmod.q1.Active := False;
end;

procedure TfrmSearch.SaveSQL_Sign(SqlQ, SqlTxt: string);
begin
  Dmod.Q1.Active := False;
  Dmod.Q1.Sql.Text := 'Select * from Ini where Prog=' + dbdel + SqlQ + dbdel + ' AND Signr=' + dbdel + frmmain.sign + dbdel + '';
  Dmod.Q1.Active := True;
  if dmod.q1.RecordCount > 0 then
  begin
    Dmod.Q1.Active := False;
    Dmod.Q1.Sql.Text := 'Update Ini Set Ini=' + dbdel + SqlTxt + dbdel + ' where Prog=' + dbdel + SqlQ + dbdel + ' AND Signr=' + dbdel + frmmain.sign + dbdel + '';
    Dmod.Q1.ExecSQL;
  end else
  begin
    Dmod.Q1.Active := False;
    Dmod.Q1.Sql.Text := 'Insert into Ini (Prog,Signr,Ini) Values(' + dbdel + SqlQ + dbdel + ',' + dbdel + Frmmain.sign + dbdel + '' + dbdel + SqlTxt + dbdel + ')';
    Dmod.Q1.ExecSQL;
  end;
end;

procedure TfrmSearch.BitBtn1Click(Sender: TObject);
begin
  Param1 := DBGrid1.DataSource.DataSet.Fields[1].AsString;
end;

procedure TfrmSearch.DBGrid1Enter(Sender: TObject);
begin
  BitBtn1.Default := true;
  BitBtn4.Default := False;
end;

procedure TfrmSearch.Edit2Enter(Sender: TObject);
begin
  BitBtn4.Default := true;
  BitBtn1.Default := False;
end;

procedure TfrmSearch.ComboBox1Enter(Sender: TObject);
begin
  BitBtn4.Default := true;
  BitBtn1.Default := False;
end;

end.

