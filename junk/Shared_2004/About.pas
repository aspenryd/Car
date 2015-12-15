{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     ..\Shared\About.pas
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
{ $Log:  13607: About.pas
{
{   Rev 1.1    2004-01-29 10:24:24  peter
{ Formatterat källkoden.
}
{
{   Rev 1.0    2004-01-29 09:26:14  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 14:04:02  peter
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
{   Rev 1.0    2003-03-17 14:28:04  Supervisor
{ Bytt ut LMD och BFC Combo
}

unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls, jpeg;

type
  TfrmAbout = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Animate1: TAnimate;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function GetVersionNumber: string;
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses Main;

{$R *.DFM}

function TfrmAbout.GetVersionNumber: string;
var
  verBufLen, ValLen: Cardinal;
  verBuf: PChar; {version resource buffer}
  VersionPointer: PChar;
  langBuf: pchar; {language buffer}
  LangBufLen: cardinal;
  Temp: integer;
  LanguageParam: string;

begin
  Result := '';
  {Get the size of the File Version Info}
  verBufLen := GetFileVersionInfoSize(PChar(Application.Exename), verBufLen);
  if (verBufLen > 0) then
  begin
    {Allocate memory for the version resource buffer}
    verBuf := AllocMem(verBufLen);

    {Stuff buffer with File Version Info}
    GetFileVersionInfo(PChar(Application.Exename), 0, verBufLen,
      verBuf);

    {Determine which Language to use...stuff result into LangBuf}
    VerQueryValue(verBuf, '\VarFileInfo\Translation', Pointer(langBuf),
      LangBufLen);

    {Decode the Language into a string representation of the Hex value}
    if LangBufLen >= 4 then
    begin
      StrLCopy(@temp, langBuf, 2);
      LanguageParam := IntToHex(temp, 4);
      StrLCopy(@temp, langBuf + 2, 2);
      LanguageParam := LanguageParam + IntToHex(temp, 4);
    end;

    {Determine value of "FileVersion"...stuff result into the function
Result}
    VerQueryValue(verBuf, PChar('\StringFileInfo\' + LanguageParam + '\' +
      'FileVersion'),
      Pointer(VersionPointer), ValLen);
    if (ValLen > 1) then
    begin
      SetLength(Result, valLen);
      StrLCopy(Pchar(Result), VersionPointer, valLen);
    end
    else
      Result := 'Version Info Not Available';

    {Clean up}
    FreeMem(verBuf, verBufLen);
  end;
end; {function GetVersionNumber}


procedure TfrmAbout.SpeedButton1Click(Sender: TObject);
var J: Integer;
const
  frmOpen = 440;
  frmClosed = 236;
begin

  J := frmAbout.Height;
  if frmAbout.Height < frmOpen then
  begin
    while J < frmOpen do
    begin
      inc(J, 4);
      if J > frmOpen then
        J := frmOpen;
      frmAbout.Height := J;
      Refresh;
    end;
  end
  else
    while J > frmClosed do
    begin
      dec(J, 4);
      if J < frmClosed then
        J := frmClosed;
      frmAbout.Height := J;
      Refresh;
    end;
end;

procedure TfrmAbout.FormActivate(Sender: TObject);
begin
  if FileExists((Application.MainForm as TFrmMain).AviFilm) then
  begin
    animate1.FileName := (Application.MainForm as TFrmMain).avifilm;
    Animate1.Active := true;
    Animate1.Visible := true;
  end else
    Animate1.Visible := false;
  Label1.Caption := Application.Title + ' Version: ' + GetVersionNumber;
  Label1.Left := ClientWidth div 2 - Label1.Width div 2;
  Label2.Left := ClientWidth div 2 - Label2.Width div 2;
  Label2.Caption := Format('Copyright 1999-%d Maxi Marketing AB', [CurrentYear]);
end;

end.

