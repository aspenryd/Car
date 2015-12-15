{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Statiska.pas
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
{ $Log:  13511: Statiska.pas
{
{   Rev 1.1    2004-01-29 10:24:22  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:24:12  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 13:58:58  peter
}
{
{   Rev 1.0    2003-03-17 14:39:44  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:35:06  Supervisor
{ Nystart
}
{
{   Rev 1.0    2003-03-17 14:28:08  Supervisor
{ Bytt ut LMD och BFC Combo
}
unit Statiska;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Mask, DBCtrls, ADODB, DB, Grids, DBGrids;

type
  TFrmStatiska = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    DBEdit22: TDBEdit;
    Label2: TLabel;
    DBEdit26: TDBEdit;
    Label11: TLabel;
    DBEdit25: TDBEdit;
    Label12: TLabel;
    DBEdit24: TDBEdit;
    Label13: TLabel;
    DBEdit23: TDBEdit;
    Label67: TLabel;
    DBEdit15: TDBEdit;
    Label68: TLabel;
    DBEdit32: TDBEdit;
    Label37: TLabel;
    DBEdit40: TDBEdit;
    Label38: TLabel;
    DBEdit41: TDBEdit;
    PaBetsG: TPanel;
    PaDrivMG: TPanel;
    PaKontokG: TPanel;
    PaTeleG: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure DBGrid4DblClick(Sender: TObject);
  private
    { Private declarations }
    AktTabell2: TADOTable;
    procedure GetTable2;
  public
    { Public declarations }
  end;

var
  FrmStatiska: TFrmStatiska;

implementation

uses Main, Dmod;

{$R *.DFM}

procedure TFrmStatiska.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Freeandnil(FrmStatiska);
  frmMain.Panel1.visible := True;
  frmMain.DbNavBaz := '';
  frmMain.S_H_DBNav(False);
end;

procedure TFrmStatiska.PageControl1Change(Sender: TObject);
begin
  frmMain.SpeedButton2.Flat := False;
  frmMain.SpeedButton2.Glyph := nil;
  frmMain.ImageList1.GetBitmap(0, frmMain.SpeedButton2.Glyph);
  frmMain.NoFilt;
  frmMain.btnfilter.enabled := False;
  frmMain.BtnAsc.enabled := False;
  frmMain.btnDesc.enabled := False;
  frmMain.Fixraknare;
  PaBetsG.visible := False;
  PaDrivMG.visible := False;
  PaKontokG.visible := False;
  PaTeleG.visible := False;
end;

procedure TFrmStatiska.FormCreate(Sender: TObject);
begin
//!
end;

procedure TFrmStatiska.GetTable2;
begin
  case pagecontrol1.ActivePageIndex of
    0: AktTabell2 := Dmod2.BetstT;
    1: AktTabell2 := Dmod2.DrivMT;
    2: AktTabell2 := Dmod2.CardsT;
    3: AktTabell2 := Dmod2.TtypT;
  end;
end;

procedure TFrmStatiska.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in [VK_Next, VK_Prior, VK_Delete, VK_Insert, VK_RETURN, VK_HOME] then
  begin
    getTable2;
    if (key = VK_Next) and (shift = [ssCtrl]) then
    begin
      AktTabell2.Last;
      Key := 0;
    end
    else
      if (key = VK_Next) then
      begin
        AktTabell2.next;
        Key := 0;
      end;
    if (key = VK_Prior) and (shift = [ssCtrl]) then
    begin
      AktTabell2.First;
      Key := 0;
    end
    else
      if key = VK_Prior then
      begin
        AktTabell2.Prior;
        Key := 0;
      end;
    if (key = VK_HOME) and (shift = [ssCtrl]) then
    begin
      AktTabell2.Cancel;
      Key := 0;
    end;
    if (key = VK_Delete) and (shift = [ssCtrl]) then
    begin
      AktTabell2.Delete;
      Key := 0;
    end;
    if (key = VK_Insert) and (shift = [ssCtrl]) then
    begin
      AktTabell2.Insert;
      Key := 0;
    end;
    if (key = VK_RETURN) and (shift = [ssCtrl]) then
    begin
      if AktTabell2.state in [dsEdit, dsInsert] then
        AktTabell2.Post
      else
        AktTabell2.Resync([RmCenter]);
      Key := 0;
    end;
  end;
  frmMain.Fixraknare;
end;

procedure TFrmStatiska.FormDeactivate(Sender: TObject);
begin
  close;
end;

procedure TFrmStatiska.FormActivate(Sender: TObject);
begin
  //!frmMain.Fixraknare ;
  frmMain.speedbutton2.flat := false;
  frmMain.SpeedButton2.Glyph := nil;
  frmMain.ImageList1.GetBitmap(0, frmMain.SpeedButton2.Glyph);
  frmMain.btnRecNo.Text := inttostr(dmod2.ObjTypeT.RecNo);
  frmMain.BtnTotRecNo.Text := inttostr(dmod2.ObjTypeT.recordcount);
end;

procedure TFrmStatiska.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.Fixraknare;
end;

procedure TFrmStatiska.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.fixraknare;
end;

procedure TFrmStatiska.DBGrid3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.fixraknare;
end;

procedure TFrmStatiska.DBGrid4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmMain.FixRaknare;
end;

procedure TFrmStatiska.DBGrid1CellClick(Column: TColumn);
begin
  frmMain.fixRaknare;
end;

procedure TFrmStatiska.DBGrid1DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.BetstT.fieldbyname('Kod').asstring;
  PaBetsG.visible := False;
  frmMain.FindBack(dmod2.BetstT, 'Kod', bmark);
end;

procedure TFrmStatiska.DBGrid2DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.DrivMT.fieldbyname('id').asstring;
  PaBetsG.visible := False;
  frmMain.FindBack(dmod2.DrivMT, 'id', bmark);
end;

procedure TFrmStatiska.DBGrid2CellClick(Column: TColumn);
begin
  frmMain.fixraknare;
end;

procedure TFrmStatiska.DBGrid3CellClick(Column: TColumn);
begin
  frmMain.fixraknare;
end;

procedure TFrmStatiska.DBGrid3DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.CardsT.fieldbyname('Typ').asstring;
  PaBetsG.visible := False;
  frmMain.FindBack(dmod2.CardsT, 'Typ', bmark);

end;

procedure TFrmStatiska.DBGrid4CellClick(Column: TColumn);
begin
  frmMain.Fixraknare;
end;

procedure TFrmStatiska.DBGrid4DblClick(Sender: TObject);
var
  bmark: string;
begin
  bmark := dmod2.TtypT.fieldbyname('TeleTyp').asstring;
  PaBetsG.visible := False;
  frmMain.FindBack(dmod2.TtypT, 'TeleTyp', bmark);
end;

end.

