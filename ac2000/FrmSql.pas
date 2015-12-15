{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     FrmSql.pas
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
{ $Log:  13010: FrmSql.pas
{
{   Rev 1.3    2006-02-18 13:33:20  pb64
}
{
{   Rev 1.2    2005-04-29 12:43:26  pb64
{ Fixat SQL hantering så att insert och update inte utförs 2 gånger
}
{
{   Rev 1.1    2004-01-28 14:40:20  peter
}
{
{   Rev 1.0    2003-03-20 13:58:56  peter
}
{
{   Rev 1.0    2003-03-17 14:39:46  Supervisor
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
unit FrmSql;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, ADODB, ExtCtrls, Grids, DBGrids, Menus;

type
  TFormSql = class(TForm)
    Memo1: TMemo;
    DBGrid6: TDBGrid;
    Panel2: TPanel;
    Button4: TButton;
    Button5: TButton;
    Sql1: TADOQuery;
    DataSource1: TDataSource;
    Od1: TOpenDialog;
    SD1: TSaveDialog;
    Button2: TButton;
    SaveDiaSql: TSaveDialog;
    PopupMenu1: TPopupMenu;
    Tm1: TMenuItem;
    Lsin1: TMenuItem;
    Spara1: TMenuItem;
    PopupMenu2: TPopupMenu;
    SelectFrga1: TMenuItem;
    UppdateringsFrga1: TMenuItem;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Tm1Click(Sender: TObject);
    procedure Lsin1Click(Sender: TObject);
    procedure Spara1Click(Sender: TObject);
    procedure SelectFrga1Click(Sender: TObject);
    procedure UppdateringsFrga1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSql: TFormSql;

implementation

uses DmSession, Main;

{$R *.DFM}

procedure TFormSql.Button4Click(Sender: TObject);
var
  i : Integer;
begin

  i:=Pos('SELECT ', uppercase(memo1.lines.Text));
  if (i > 0) and (i<10) then
  begin
    try
      sql1.active := False;
      sql1.SQL.Text := memo1.Lines.text;
      sql1.active := True;
      DataSource1.DataSet := Sql1;
    except
      on E: Exception do Showmessage('Fel i Sql Sträng'+#13+E.Message);
    end;
  end
  else
  begin
    try
      DataSource1.DataSet := Nil;
      sql1.active := False;
      sql1.SQL.Text := memo1.Lines.text;
      i := sql1.ExecSQL;
      sql1.SQL.Text := 'SELECT '''+IntToStr(I)+' Rader uppdaterades eller lades till'' AS Resultat' ;
      sql1.active := True;
      DataSource1.DataSet := Sql1;
    except
      on E: Exception do Showmessage('Fel i Sql Sträng'+#13+E.Message);
    end;
  end;
end;

procedure TFormSql.Button5Click(Sender: TObject);
begin
  memo1.lines.text := ' ';
  sql1.active := False;
  Sql1.sql.text := '';
end;

procedure TFormSql.Button6Click(Sender: TObject);
var Text: textfile;
  s: string;
  i: integer;
begin
  od1.initialdir := Extractfilepath(application.exename);
  if od1.execute then
    Memo1.lines.LoadFromFile(OD1.FileName);
end;

procedure TFormSql.Button7Click(Sender: TObject);
var text: textfile;
  i: integer;
begin
  sd1.InitialDir := Extractfilepath(application.exename);
  if sd1.Execute then
    Memo1.lines.SaveToFile(SD1.FileName);
end;

procedure TFormSql.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Formsql.free;
  formSql := nil;
  frmMain.Panel1.visible := True;
end;

procedure TFormSql.Button1Click(Sender: TObject);
begin
  try
    begin
      sql1.active := False;
      sql1.SQL.Text := memo1.Lines.text;
      sql1.ExecSQL;
      showmessage('Databas Uppdaterad');
    end;
  except
    showmessage('Fel i Sql Sträng');
  end;
end;

procedure TFormSql.Button2Click(Sender: TObject);
var
  Col: LongInt;
  F: TextFile;
  NewStr: string;
begin
  savediasql.InitialDir := extractfilepath(application.exename);
  if SaveDiaSql.execute then
  begin
    AssignFile(F, SaveDiaSql.filename);
    Rewrite(F);

    if sql1.Active = False then exit;

    NewStr := '';
    with sql1 do
    begin
      for Col := 0 to FieldCount - 1 do
        NewStr := NewStr + Fields[Col].FieldName + ';';
      Writeln(F, NewStr);
      NewStr := '';
      first;
      while not EOF do
      begin
        for Col := 0 to FieldCount - 1 do
          NewStr := NewStr + Fields[Col].AsString + ';';
        Writeln(F, NewStr);
        NewStr := '';
        next;
      end;
    end;
    CloseFile(F);
  end;
end;

procedure TFormSql.Tm1Click(Sender: TObject);
begin
  memo1.lines.text := ' ';
  sql1.active := False;
  Sql1.sql.text := '';
end;

procedure TFormSql.Lsin1Click(Sender: TObject);
begin
  od1.initialdir := Extractfilepath(application.exename);
  if od1.execute then
    Memo1.lines.LoadFromFile(OD1.FileName);
end;

procedure TFormSql.Spara1Click(Sender: TObject);
begin
  sd1.InitialDir := Extractfilepath(application.exename);
  if sd1.Execute then
    Memo1.lines.SaveToFile(SD1.FileName);
end;

procedure TFormSql.SelectFrga1Click(Sender: TObject);
begin
  try
    begin
      sql1.active := False;
      sql1.SQL.Text := memo1.Lines.text;
      sql1.active := True;
    end;
  except
    showmessage('Fel i Sql Sträng');
  end;

end;

procedure TFormSql.UppdateringsFrga1Click(Sender: TObject);
begin
  try
    begin
      sql1.active := False;
      sql1.SQL.Text := memo1.Lines.text;
      sql1.ExecSQL;
      showmessage('Databas Uppdaterad');
    end;
  except
    showmessage('Fel i Sql Sträng');
  end;
end;

end.

