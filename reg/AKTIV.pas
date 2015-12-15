{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Aktiv.pas
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
{ $Log:  12990: AKTIV.pas 
{
{   Rev 1.0    2003-03-20 13:55:36  peter
}
{
{   Rev 1.0    2003-03-17 09:26:24  Supervisor
{ Start av vc
}
unit Aktiv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask;

type
  TBok=Record
   Boks:String[1];
   Bet:String[10];
  End;
  TAktForm = class(TForm)
    Edit2: TEdit;
    MaskEdit1: TMaskEdit;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    procedure Edit1Enter(Sender: TObject);
    Procedure FyllBokArray;
    procedure FormCreate(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AktForm: TAktForm;
  Bokst:Array of TBok;

implementation

uses
  SWSecFunc;

{$R *.DFM}

procedure TAktForm.Edit1Enter(Sender: TObject);
Var i,j:Integer;
begin
  Edit1.Text := GetActCode(MaskEdit1.Text,Edit2.text);

  for i:=1 to Length(edit1.text) do
  begin
   for j:=0 to length(Bokst) do
    if bokst[j].Boks= Edit1.Text[i] then
     listbox1.Items.Add(Bokst[j].Bet);
  end;
end;

procedure TAktForm.FyllBokArray;
 Var i:INteger;
begin
setlength(Bokst,37);
bokst[0].Boks :='ä';
bokst[0].Bet :='Fel';
bokst[1].Boks :='A';
bokst[1].Bet :='Alfa';
bokst[2].Boks :='B';
bokst[2].Bet :='Bravo';
bokst[3].Boks :='C';
bokst[3].Bet :='Charlie';
bokst[4].Boks :='D';
bokst[4].Bet :='Delta';
bokst[5].Boks :='E';
bokst[5].Bet :='Echo';
bokst[6].Boks :='F';
bokst[6].Bet :='Foxtrot';
bokst[7].Boks :='G';
bokst[7].Bet :='Golf';
bokst[8].Boks :='H';
bokst[8].Bet :='Hotell';
bokst[9].Boks :='I';
bokst[9].Bet :='India';
bokst[10].Boks :='J';
bokst[10].Bet :='Juliett';
bokst[11].Boks :='K';
bokst[11].Bet :='Kilo';
bokst[12].Boks :='L';
bokst[12].Bet :='Lima';
bokst[13].Boks :='M';
bokst[13].Bet :='Mike';
bokst[14].Boks :='N';
bokst[14].Bet :='November';
bokst[15].Boks :='O';
bokst[15].Bet :='Oscar';
bokst[16].Boks :='P';
bokst[16].Bet :='Papa';
bokst[17].Boks :='Q';
bokst[17].Bet :='Quebec';
bokst[18].Boks :='R';
bokst[18].Bet :='Romeo';
bokst[19].Boks :='S';
bokst[19].Bet :='Sierra';
bokst[20].Boks :='T';
bokst[20].Bet :='Tango';
bokst[21].Boks :='U';
bokst[21].Bet :='Uniform';
bokst[22].Boks :='V';
bokst[22].Bet :='Victor';
bokst[23].Boks :='W';
bokst[23].Bet :='Whiskey';
bokst[24].Boks :='X';
bokst[24].Bet :='X-Ray';
bokst[25].Boks :='Y';
bokst[25].Bet :='Yankee';
bokst[26].Boks :='Z';
bokst[26].Bet :='Zulu';
bokst[27].Boks :='0';
bokst[27].Bet :='Zero';
bokst[28].Boks :='1';
bokst[28].Bet :='One';
bokst[29].Boks :='2';
bokst[29].Bet :='Two';
bokst[30].Boks :='3';
bokst[30].Bet :='Three';
bokst[31].Boks :='4';
bokst[31].Bet :='Four';
bokst[32].Boks :='5';
bokst[32].Bet :='Five';
bokst[33].Boks :='6';
bokst[33].Bet :='Six';
bokst[34].Boks :='7';
bokst[34].Bet :='Seven';
bokst[35].Boks :='8';
bokst[35].Bet :='Eigth';
bokst[36].Boks :='9';
bokst[36].Bet :='Nine';

end;

procedure TAktForm.FormCreate(Sender: TObject);
begin
  fyllBokArray;
end;

procedure TAktForm.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var i:Integer;
begin
   for i:=0 to length(Bokst) do
    if bokst[i].Boks=chr(Key) then
     listbox1.Items.Add(Bokst[i].Bet);
 if key =VK_Back then  listbox1.items.Delete(listbox1.items.Count-1);
end;

procedure TAktForm.Edit2Exit(Sender: TObject);
begin
  listbox1.Clear;
end;

end.

