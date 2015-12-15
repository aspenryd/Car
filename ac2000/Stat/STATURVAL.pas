{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Stat\StatUrval.pas
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
{ $Log:  13035: STATURVAL.pas 
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
unit StatUrval;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons,  Db, ADODB;

type
  TFrmStatUrval = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Edit1: TEdit;
    Label1: TLabel;
    q1: TADOQuery;
    BFC_ComboBox1: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BFC_ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStatUrval: TFrmStatUrval;

implementation

uses Statistik, DmSession;

{$R *.DFM}

procedure TFrmStatUrval.BitBtn1Click(Sender: TObject);
begin
 sbaz:=BFC_ComboBox1.Text;
 fd:=datetostr(DateTimePicker1.Date);
 td:=Datetostr(Datetimepicker2.date); 
end;

procedure TFrmStatUrval.FormActivate(Sender: TObject);
 Var
  TTyp:String;
begin
  if (frmstat.Typ ='ObjTypStat') AND (edit1.visible) then
  begin
   ttyp:=TrimRight(copy(BFC_ComboBox1.Text,0,2));
    q1.Active :=False;
    q1.SQL.Text :='SELECT Objects.Reg_No, Objects.Type FROM Objects WHERE (((Objects.Type)='''+TTyp+'''));';
    q1.Active:=True;
    edit1.Text := inttostr(q1.recordcount);
  end;
  BFC_ComboBox1.SetFocus ;
end;

procedure TFrmStatUrval.BFC_ComboBox1Change(Sender: TObject);
 Var
  TTyp:String;
begin
  if (frmstat.Typ ='ObjTypStat') AND (edit1.visible) then
  begin
   ttyp:=TrimRight(copy(BFC_ComboBox1.Text,0,2));
    q1.Active :=False;
    q1.SQL.Text :='SELECT Objects.Reg_No, Objects.Type FROM Objects WHERE (((Objects.Type)='''+TTyp+'''));';
    q1.Active:=True;
    edit1.Text := inttostr(q1.recordcount);
  end;

end;

end.

