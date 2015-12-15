{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  15387: uCarLegal.pas 
{
{   Rev 1.0    2006-02-18 13:33:48  pb64
}
unit uCarLegal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DelphiTwain, jpeg;

type
  TfrmCarlegal = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Twain: TDelphiTwain;
    procedure Button1Click(Sender: TObject);
    procedure TwainTwainAcquire(Sender: TObject;
      const Index: Integer; Image: TBitmap; var Cancel: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCarlegal: TfrmCarlegal;

implementation

{$R *.dfm}

procedure TfrmCarlegal.Button1Click(Sender: TObject);
var
  SelectedSource: Integer;
begin
  {It is always recommended to load library dynamically, never forcing}
  {final user to have twain installed}
  if Twain.LoadLibrary then
  begin

    {Load source manager}
    Twain.SourceManagerLoaded := TRUE;
    {Allow user to select source}
//    SelectedSource := Twain.SelectSource;
    SelectedSource := 0;
    if SelectedSource <> -1 then
    begin
      {Load source, select transference method and enable (display interface)}
      Twain.Source[SelectedSource].Loaded := TRUE;
      Twain.Source[SelectedSource].TransferMode := ttmMemory;
//      Twain.Source[SelectedSource].ShowUI := False;
      Twain.Source[SelectedSource].Enabled := TRUE;
    end {if SelectedSource <> -1}

  end
  else
    showmessage('Twain is not installed.');
end;

procedure TfrmCarlegal.TwainTwainAcquire(Sender: TObject;
  const Index: Integer; Image: TBitmap; var Cancel: Boolean);
var
   tjpg:TJpegimage;
begin
//  Image1.Picture.Assign(Image);
//  Image1.Canvas.CopyRect(rect(0,0,Image1.Width,Image1.Height),Image.Canvas,rect(0,0,Image.Width,trunc((Image.width/Image1.Width)*Image1.Height)));
  tjpg:=TJpegImage.Create;
  tjpg.Assign(Image);
  tjpg.Compress;
  Image1.Picture.Assign(tjpg);
  tjpg.Free;
  Cancel := TRUE;  {Only want one image}

end;

end.
