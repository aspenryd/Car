{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  14882: uRfid.pas 
{
{   Rev 1.2    2004-12-20 16:49:24  pb64
}
{
{   Rev 1.1    2004-12-20 16:42:46  pb64
{ Läser endast Hex tecken
}
{
{   Rev 1.0    2004-08-18 11:01:06  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
unit uRfid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdPort, OoMisc, ADTrmEmu, StdCtrls;

type
  TForm1 = class(TForm)
    AdTerminal1: TAdTerminal;
    AdVT100Emulator1: TAdVT100Emulator;
    ApdComPort1: TApdComPort;
    edit1: TMemo;
    procedure AdVT100Emulator1ProcessChar(Sender: TObject; Character: Char;
      var ReplaceWith: String; Commands: TAdEmuCommandList;
      CharSource: TAdCharSource);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AdVT100Emulator1ProcessChar(Sender: TObject;
  Character: Char; var ReplaceWith: String; Commands: TAdEmuCommandList;
  CharSource: TAdCharSource);
begin
   if Character=#13 then
   begin
     // Trigga något med data
     Edit1.Lines.Add(FloatToStr(now));
     Edit1.Lines.SaveToFile('Cardirect.txt');
     edit1.Tag :=1;
   end
   else
   begin
     if Edit1.Tag=1 then
//       Edit1.Lines.Add('');
       Edit1.Text := '';
     Edit1.Tag := 0;
     if Pos(Character,'0123456789abcdefABCDEF')>0 then
         Edit1.Text := Edit1.Text + Character;
   end;
end;

end.
