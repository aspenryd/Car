{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13197: Unit1.pas 
{
{   Rev 1.0    2003-03-20 14:04:54  peter
}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Buttons;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    MainMenu1: TMainMenu;
    Arkiv1: TMenuItem;
    Avsluta1: TMenuItem;
    SpeedButton1: TSpeedButton;
    procedure Avsluta1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses spin;

{$R *.dfm}

procedure TForm1.Avsluta1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
SpinDLLExists := FileExists('spinapi.dll');
if LoadSpinDLL then
 edit2.Text := getbnum(edit1.Text);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
 if Length(edit1.Text) >9 then
 Begin
  SpinDLLExists := FileExists('spinapi.dll');
  if LoadSpinDLL then
   edit2.Text := AntiSpin(edit1.Text);
 end;
end;

end.
