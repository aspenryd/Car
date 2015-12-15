unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edBaseDatabase: TEdit;
    btnCheckBase: TButton;
    Label2: TLabel;
    edMergingDatabase: TEdit;
    btnCheckMerging: TButton;
    gbIds: TGroupBox;
    Label3: TLabel;
    edAddContrId: TEdit;
    btnGetBaseContrId: TButton;
    Label4: TLabel;
    edAddSubId: TEdit;
    btnGetBaseSubId: TButton;
    Label5: TLabel;
    edAddCustId: TEdit;
    btnGetBaseCustId: TButton;
    Label6: TLabel;
    edAddSubCustId: TEdit;
    btnGetBaseSubCustId: TButton;
    gbAfter: TGroupBox;
    Button7: TButton;
    gbMerge: TGroupBox;
    btnMergeContr: TButton;
    btnMergeCustomer: TButton;
    btnMergeSignR: TButton;
    ConBase: TADOConnection;
    ConMerge: TADOConnection;
    qryBase: TADOQuery;
    qryMerge: TADOQuery;
    btnStart: TButton;
    btnCommit: TButton;
    btnRollback: TButton;
    pbMerge: TProgressBar;
    lblTable: TLabel;
    procedure btnCheckBaseClick(Sender: TObject);
    procedure btnCheckMergingClick(Sender: TObject);
    procedure btnGetBaseContrIdClick(Sender: TObject);
    procedure btnGetBaseSubIdClick(Sender: TObject);
    procedure btnGetBaseCustIdClick(Sender: TObject);
    procedure btnGetBaseSubCustIdClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnCommitClick(Sender: TObject);
    procedure btnRollbackClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure btnMergeCustomerClick(Sender: TObject);
    procedure btnMergeContrClick(Sender: TObject);
    procedure btnMergeSignRClick(Sender: TObject);
    procedure edBaseDatabaseChange(Sender: TObject);
    procedure edMergingDatabaseChange(Sender: TObject);
  private
    function ConnectBase: boolean;
    function ConnectMerge: boolean;
    procedure SetOpenTransaction;
    procedure SetCloseTransaction;
    procedure DoContr_base;
    procedure DoContr_Sub;
    procedure DoContr_Costs;
    procedure DoContr_Hist;
    procedure DoContr_Not;
    procedure DoContr_Insur;
    procedure DoContr_ObjT;
    procedure DoContr_SubCost;
    procedure DoContr_SubCostRow;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.ConnectBase : boolean;
begin
  if not ConBase.Connected then
  begin
    ConBase.ConnectionString := edBaseDatabase.Text;
    ConBase.Open;
  end;
  result := ConBase.Connected;
end;

function TForm1.ConnectMerge : boolean;
begin
  if not ConMerge.Connected then
  begin
    ConMerge.ConnectionString := edMergingDatabase.Text;
    ConMerge.Open;
  end;
  result := ConMerge.Connected;
end;

procedure TForm1.btnCheckBaseClick(Sender: TObject);
var
  b, m : boolean;
begin
  b := ConnectBase;
  if b then
    ShowMessage('Connection successful')
  else
    ShowMessage('Could not connect');
  ConBase.Close;

  gbIds.Enabled := b;
  gbAfter.Enabled := b;
  m := false;
  if b then
  begin
    try
      m := ConnectMerge;
    except
      m := false;
    end;
    gbMerge.Enabled := b and m
  end;
  btnCheckBase.Enabled := not b;
  btnCheckMerging.Enabled := not m;
end;

procedure TForm1.btnCheckMergingClick(Sender: TObject);
var
  m : boolean;
begin
  m := ConnectMerge;
  if m then
    ShowMessage('Connection successful')
  else
    ShowMessage('Could not connect');
  ConMerge.Close;

  gbMerge.Enabled := m and gbIds.Enabled;
  btnCheckMerging.Enabled := not m;
end;

procedure TForm1.btnGetBaseContrIdClick(Sender: TObject);
begin
  if ConnectBase then
  begin
    qryBase.SQL.Text := 'select max(contrid) from contr_base';
    qryBase.Open;
    try
      if not qryBase.EOF then
      begin
        edAddContrId.Text := qryBase.Fields[0].Value;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.btnGetBaseSubIdClick(Sender: TObject);
begin
  if ConnectBase then
  begin
    qryBase.SQL.Text := 'select max(subid) from contr_sub';
    qryBase.Open;
    try
      if not qryBase.EOF then
      begin
        edAddSubId.Text := qryBase.Fields[0].Value;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');

end;

procedure TForm1.btnGetBaseCustIdClick(Sender: TObject);
begin
  if ConnectBase then
  begin
    qryBase.SQL.Text := 'select max(cust_id) from customer';
    qryBase.Open;
    try
      if not qryBase.EOF then
      begin
        edAddCustId.Text := qryBase.Fields[0].Value;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.btnGetBaseSubCustIdClick(Sender: TObject);
begin
  if ConnectBase then
  begin
    qryBase.SQL.Text := 'select max(subcustid) from contr_sub';
    qryBase.Open;
    try
      if not qryBase.EOF then
      begin
        edAddSubCustId.Text := qryBase.Fields[0].Value;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  if ConnectBase then
  begin
    ConBase.BeginTrans;
    SetOpenTransaction;
  end;
end;

procedure TForm1.SetOpenTransaction();
begin
  btnStart.enabled := false;
  btnCommit.enabled := true;
  btnRollback.enabled := true;
  btnMergeContr.enabled := true;
  btnMergeCustomer.enabled := true;
  btnMergeSignR.enabled := true;
end;

procedure TForm1.SetCloseTransaction();
begin
  btnStart.enabled := true;
  btnCommit.enabled := false;
  btnRollback.enabled := false;
  btnMergeContr.enabled := false;
  btnMergeCustomer.enabled := false;
  btnMergeSignR.enabled := false;
end;

procedure TForm1.btnCommitClick(Sender: TObject);
begin

  ConBase.CommitTrans;
  SetCloseTransaction
end;

procedure TForm1.btnRollbackClick(Sender: TObject);
begin
  ConBase.RollbackTrans;
  SetCloseTransaction;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  if ConnectBase then
  begin
    ConBase.BeginTrans;
    try
      qryBase.SQL.Text := 'update param set kundid = (select max(cust_id) from customer)';
      qryBase.ExecSQL;
      qryBase.SQL.Text := 'update param set kontrnr = (select max(contrid) from contr_base)';
      qryBase.ExecSQL;
      qryBase.SQL.Text := 'update Param set ObjNr = (select max(objnum) from objects)';
      qryBase.ExecSQL;
      ConBase.CommitTrans;
    except
      ConBase.RollbackTrans;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.btnMergeCustomerClick(Sender: TObject);
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  tot := 0;
  btnMergeCustomer.Enabled := false;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from customer';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from customer';
      qryBase.Open;
      try
        while not qryMerge.EOF do
        begin
          pbMerge.Max := qryMerge.RecordCount;
          qryBase.Insert;
          try
            for i := 0 to qryMerge.FieldCount-1 do
            begin
              if qryMerge.Fields[i].FieldName = 'Cust_Id' then
                qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddCustId.Text)
              else
                qryBase.Fields[i].value := qryMerge.Fields[i].value;
            end;
            qryBase.Post;
            inc(num);
          except
            qryBase.cancel;
          end;
          inc(tot);
          if tot mod 10 = 0 then
          begin
            pbMerge.Position := tot;
            Application.ProcessMessages;
          end;
          qryMerge.Next;
        end;
        ShowMessage(format('Merged %d out of %d customers', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;


procedure TForm1.DoContr_base();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_Base';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_base';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_base';
      qryBase.Open;
      try
        screen.cursor := crHourglass;
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'ContrId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddContrId.Text)
                else if qryMerge.Fields[i].FieldName = 'CustID' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddCustId.Text)
                else if qryMerge.Fields[i].FieldName = 'DriveId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddCustId.Text)
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_base', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.DoContr_Sub();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_Sub';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_sub';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_sub';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'ContrId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddContrId.Text)
                else if qryMerge.Fields[i].FieldName = 'SubId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddSubId.Text)
                else if qryMerge.Fields[i].FieldName = 'SubCustId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddSubCustId.Text)
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_sub', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.DoContr_Costs();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_Costs';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_costs';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_costs';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'ContrId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddContrId.Text)
                else if qryMerge.Fields[i].FieldName = 'Cost_ID' then
                begin
                  //Autogenerated
                end
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        showmessage(format('Merged %d out of %d Contr_Costs', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.DoContr_Hist();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_Hist';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_hist';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_hist';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'ContrId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddContrId.Text)
                else if qryMerge.Fields[i].FieldName = 'HistNum' then
                begin
                  //Autogenerated
                end
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;

        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_hist', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.DoContr_Not();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_Not';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_not';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_not';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'ContrId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddContrId.Text)
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_Not', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.DoContr_ObjT();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_ObjT';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_objt';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_objt';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'ContrId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddContrId.Text)
                else if qryMerge.Fields[i].FieldName = 'ConObjID' then
                begin
                  //Autogenerated
                end
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_ObjT', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;


procedure TForm1.DoContr_Insur();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_Insur';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_insur';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_insur';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'SubId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddSubId.Text)
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_Insur', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.DoContr_SubCost();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_SubCost';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_subcost';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_subcost';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'SubId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddSubId.Text)
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_SubCost', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;

procedure TForm1.DoContr_SubCostRow();
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  lblTable.caption := 'Contr_SubCostRow';
  Application.ProcessMessages;
  tot := 0;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from contr_subcostrow';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from contr_subcostrow';
      qryBase.Open;
      screen.cursor := crHourglass;
      try
        try
          while not qryMerge.EOF do
          begin
            pbMerge.Max := qryMerge.RecordCount;
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                if qryMerge.Fields[i].FieldName = 'SubId' then
                  qryBase.Fields[i].value := qryMerge.Fields[i].value + strtoint(edAddSubId.Text)
                else
                  qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
            inc(tot);
            if tot mod 10 = 0 then
            begin
              pbMerge.Position := tot;
              Application.ProcessMessages;
            end;
            qryMerge.Next;
          end;
        finally
          screen.cursor := crDefault;
        end;
        ShowMessage(format('Merged %d out of %d Contr_SubCostRow', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');
end;


procedure TForm1.btnMergeContrClick(Sender: TObject);
begin
  btnMergeContr.Enabled := false;
  DoContr_base;
  DoContr_Sub;
  DoContr_Costs;
  DoContr_Hist;
  DoContr_Not;
  DoContr_Insur;
  DoContr_ObjT;
  DoContr_SubCost;
  DoContr_SubCostRow;
end;

procedure TForm1.btnMergeSignRClick(Sender: TObject);
var
   i, num, tot : integer;
begin
  num := 0;
  pbMerge.Position := 0;
  tot := 0;
  btnMergeSignR.Enabled := false;
  if ConnectMerge then
  begin
    qryMerge.SQL.Text := 'select * from signr';
    qryMerge.Open;
    try
      qryBase.SQL.Text := 'select * from signr';
      qryBase.Open;
      try
        while not qryMerge.EOF do
        begin
          pbMerge.Max := qryMerge.RecordCount;
          if not qryBase.Locate('SIGN', qryMerge.FieldValues['SIGN'], []) then
          begin
            qryBase.Insert;
            try
              for i := 0 to qryMerge.FieldCount-1 do
              begin
                qryBase.Fields[i].value := qryMerge.Fields[i].value;
              end;
              qryBase.Post;
              inc(num);
            except
              qryBase.cancel;
            end;
          end;
          inc(tot);
          if tot mod 10 = 0 then
          begin
            pbMerge.Position := tot;
            Application.ProcessMessages;
          end;
          qryMerge.Next;
        end;
        ShowMessage(format('Merged %d out of %d signr', [num, tot]));
      finally
        qryBase.Close;
      end;
    finally
      qryBase.Close;
    end;
  end else
    ShowMessage('Could not connect to Base');

end;

procedure TForm1.edBaseDatabaseChange(Sender: TObject);
begin
  gbIds.Enabled := false;
  gbAfter.Enabled := false;
  gbMerge.Enabled := false;
  btnCheckBase.Enabled := true;
end;

procedure TForm1.edMergingDatabaseChange(Sender: TObject);
begin
  gbMerge.Enabled := false;
  btnCheckMerging.Enabled := true;
end;

end.
