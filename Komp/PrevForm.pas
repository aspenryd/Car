{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13163: PrevForm.pas 
{
{   Rev 1.0    2003-03-20 14:03:30  peter
}
{
{   Rev 1.0    2003-03-17 10:14:26  Supervisor
}
unit PrevForm;

{
   Print Preview
   Version 2.0
   by Ben Ziegler

   Updated on:
   - April 11, 1998
   - December 18, 1997

TODO:
   Printing in a thread (Refresh Next buttons as new pages come, etc)
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, PrevPrinter, ComCtrls;

type
  TPreviewForm = class(TForm)
    ToolBarPanel: TPanel;
    GridBut: TSpeedButton;
    ZoomCursorBut: TSpeedButton;
    HandCursorBut: TSpeedButton;
    TwoPageBut: TSpeedButton;
    CloseBut: TButton;
    ZoomBox: TComboBox;
    ScrollBox1: TScrollBox;
    ContainPanel: TPanel;
    PagePanel: TPanel;
    PB1: TPaintBox;
    PagePanel2: TPanel;
    PB2: TPaintBox;
    PrintDialog1: TPrintDialog;
    FitPageBut: TSpeedButton;
    FitWidthBut: TSpeedButton;
    PrintBut: TSpeedButton;
    StatusBar1: TStatusBar;
    LastPageSpeed: TSpeedButton;
    NextPageSpeed: TSpeedButton;
    PrevPageSpeed: TSpeedButton;
    FirstPageSpeed: TSpeedButton;
    PrintSetupBut: TSpeedButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure FormCreate(Sender: TObject);
    procedure CloseButClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure PBPaint(Sender: TObject);
    procedure GridButClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ZoomBoxChange(Sender: TObject);
    procedure TwoPageButClick(Sender: TObject);
    procedure NextPageButClick(Sender: TObject);
    procedure PrevPageButClick(Sender: TObject);
    procedure FirstPageSpeedClick(Sender: TObject);
    procedure LastPageSpeedClick(Sender: TObject);
    procedure ZoomCursorButClick(Sender: TObject);
    procedure HandCursorButClick(Sender: TObject);
    procedure PB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PB1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PrintButClick(Sender: TObject);
    procedure FitPageButClick(Sender: TObject);
    procedure FitWidthButClick(Sender: TObject);
    procedure PrintSetupButClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  protected
    FCurPage      : integer;
    OldHint       : TNotifyEvent;
    DownX, DownY  : integer;
    Moving        : boolean;
    ZoomingOut    :boolean;
    procedure     DrawMetaFile(PB: TPaintBox; mf: TMetaFile);
    procedure     OnHint(Sender: TObject);
    procedure     SetCurPage(Val: integer);
    procedure     CheckEnable;
    property      CurPage: integer read FCurPage write SetCurPage;
  public
    Zoom          : double;
    PrevPrinter   : TPreviewPrinter;
  end;

resourcestring
  SPageNumFmt = 'Sida %d av %d';

implementation
uses
 Printers;
 
const
   crZoomIn = 40;
   crZoomOut  = 41;
   crHandMove = 42;
   ZOOMFACTOR = 1.5;

{$R *.DFM}
{$R PREVFORMCURSORS.RES}

procedure TPreviewForm.FormCreate(Sender: TObject);
begin
   ZoomBox.ItemIndex := 0;
   WindowState := wsMaximized;
   Screen.Cursors[crZoomIn] := LoadCursor(hInstance, 'ZOOMIN');
   Screen.Cursors[crZoomOut] := LoadCursor(hInstance, 'ZOOMOUT');
   Screen.Cursors[crHandMove] := LoadCursor(hInstance, 'HANDMOVE');
   ZoomCursorButClick(nil);
end;

procedure TPreviewForm.CloseButClick(Sender: TObject);
begin
   Close;
end;

procedure TPreviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   Application.OnHint := OldHint;
end;

procedure TPreviewForm.ScrollBox1Resize(Sender: TObject);
const
   BORD = 20;
var
   z        : double;
   tmp      : integer;
   TotWid   : integer;
begin
   case ZoomBox.ItemIndex of
      0  : FitPageBut.Down := True;
      1  : FitWidthBut.Down := True;
      else
      begin
        FitPageBut.Down := False;
        FitWidthBut.Down := False;
      end;
   end;

   if ZoomBox.ItemIndex = -1 then
      ZoomBox.ItemIndex := 0;

   case ZoomBox.ItemIndex of
      0: z := ((ScrollBox1.ClientHeight - BORD) / PixelsPerInch) /
         (PrevPrinter.PageHeight / PrevPrinter.PixelsPerInchY);
      1: z := ((ScrollBox1.ClientWidth - BORD) / PixelsPerInch) /
         (PrevPrinter.PageWidth / PrevPrinter.PixelsPerInchX);
      2: z := Zoom;
      3: z := 0.25;
      4: z := 0.50;
      5: z := 0.75;
      6: z := 1.00;
      7: z := 1.25;
      8: z := 1.50;
      9: z := 2.00;
      10: z := 3.00;
      11: z := 4.00;
      else z := 1;
   end;

   if ZoomBox.ItemIndex<>0 then
     TwoPageBut.Down := false;

   PagePanel.Height := TRUNC(PixelsPerInch * z * PrevPrinter.PageHeight / PrevPrinter.PixelsPerInchY);
   PagePanel.Width := TRUNC(PixelsPerInch * z * PrevPrinter.PageWidth / PrevPrinter.PixelsPerInchX);

   PagePanel2.Visible := TwoPageBut.Down;
   if TwoPageBut.Down then begin
      PagePanel2.Width := PagePanel.Width;
      PagePanel2.Height := PagePanel.Height;
   end;

   TotWid := PagePanel.Width + BORD;
   if TwoPageBut.Down then
      TotWid := TotWid + PagePanel2.Width + BORD;
   
   // Resize the Contain Panel
   tmp := PagePanel.Height + BORD;
   if tmp < ScrollBox1.ClientHeight then tmp := ScrollBox1.ClientHeight-1;
   ContainPanel.Height := tmp;

   tmp := TotWid;
   if tmp < ScrollBox1.ClientWidth then tmp := ScrollBox1.ClientWidth-1;
   ContainPanel.Width := tmp;

   // Center the Page Panel
   if PagePanel.Height + BORD < ContainPanel.Height then begin
      PagePanel.Top := ContainPanel.Height div 2 - PagePanel.Height div 2;
   end else begin
      PagePanel.Top := BORD div 2;
   end;
   PagePanel2.Top := PagePanel.Top;

   if TotWid < ContainPanel.Width then begin
      PagePanel.Left := ContainPanel.Width div 2 - (TotWid - BORD) div 2;
   end else begin
      PagePanel.Left := BORD div 2;
   end;
   PagePanel2.Left := PagePanel.Left + PagePanel.Width + BORD;

   // Set the Zoom Variable
   if z < 0.25 then
     z := 0.25;
   Zoom := z;
   StatusBar1.Panels[0].Text := Format('%1.0n', [z * 100]) + '%';
end;

procedure TPreviewForm.DrawMetaFile(PB: TPaintBox; mf: TMetaFile);
begin
   PB.Canvas.Draw(0, 0, mf);
end;

procedure TPreviewForm.PBPaint(Sender: TObject);
var
   PB       : TPaintBox;
//   x1, y1   : integer;
//   x, y     : integer;
   Draw     : boolean;
   Page     : integer;
begin
   PB := Sender as TPaintBox;

   if PB = PB1 then begin
      Draw := CurPage < PrevPrinter.LastAvailPage;
      Page := CurPage;
   end else begin
      // PB2
      Draw := TwoPageBut.Down and (CurPage+1 < PrevPrinter.LastAvailPage);
      Page := CurPage + 1;
   end;

   SetMapMode(PB.Canvas.Handle, MM_ANISOTROPIC);
   SetWindowExtEx(PB.Canvas.Handle, PrevPrinter.PageWidth, PrevPrinter.PageHeight, nil);
   SetViewportExtEx(PB.Canvas.Handle, PB.Width, PB.Height, nil);
   if Draw then
      DrawMetaFile(PB, PrevPrinter.MetaFiles[Page]);

   if GridBut.Down then
   begin
     PB.Canvas.Pen.Color := ContainPanel.Color;

     PB.Canvas.MoveTo(PrevPrinter.PixelsPerInchX, 0);
     PB.Canvas.LineTo(PrevPrinter.PixelsPerInchX, PrevPrinter.PageHeight);
     PB.Canvas.MoveTo(PrevPrinter.PageWidth - PrevPrinter.PixelsPerInchX, 0);
     PB.Canvas.LineTo(PrevPrinter.PageWidth - PrevPrinter.PixelsPerInchX,PrevPrinter.PageHeight);

     PB.Canvas.MoveTo(0, PrevPrinter.PixelsPerInchY);
     PB.Canvas.LineTo(PrevPrinter.PageWidth,PrevPrinter.PixelsPerInchY);
     PB.Canvas.MoveTo(0, PrevPrinter.PageHeight - PrevPrinter.PixelsPerInchY);
     PB.Canvas.LineTo(PrevPrinter.PageWidth, PrevPrinter.PageHeight - PrevPrinter.PixelsPerInchY);
   end;
end;

procedure TPreviewForm.GridButClick(Sender: TObject);
begin
  PB1.Invalidate;
  PB2.Invalidate;
end;

procedure TPreviewForm.OnHint(Sender: TObject);
begin
   StatusBar1.Panels[2].Text := Application.Hint;
end;


procedure TPreviewForm.FormShow(Sender: TObject);
begin
   CurPage := 0;
   OldHint := Application.OnHint;
   Application.OnHint := OnHint;
   CheckEnable;
end;

procedure TPreviewForm.SetCurPage(Val: integer);
var
   tmp : integer;
begin
   FCurPage := Val;
   tmp := 0;
   if PrevPrinter <> nil then tmp := PrevPrinter.LastAvailPage;
   StatusBar1.Panels[1].Text := Format(SPageNumFmt, [Val+1, tmp]);
   PB1.Invalidate;
   PB2.Invalidate;
end;

procedure TPreviewForm.ZoomBoxChange(Sender: TObject);
begin
   ScrollBox1Resize(nil);
//   ScrollBox1Resize(nil);
end;

procedure TPreviewForm.TwoPageButClick(Sender: TObject);
begin
  ZoomBox.ItemIndex := 0;
  ScrollBox1Resize(nil);
end;

procedure TPreviewForm.NextPageButClick(Sender: TObject);
begin
   CurPage := CurPage + 1;
   CheckEnable;
end;

procedure TPreviewForm.PrevPageButClick(Sender: TObject);
begin
   CurPage := CurPage - 1;
   CheckEnable;
end;

procedure TPreviewForm.CheckEnable;
begin
   NextPageSpeed.Enabled := CurPage + 1 < PrevPrinter.LastAvailPage;
   PrevPageSpeed.Enabled := CurPage > 0;

   FirstPageSpeed.Enabled := PrevPageSpeed.Enabled;
   LastPageSpeed.Enabled  := NextPageSpeed.Enabled;
   PrintSetupBut.Visible := PrevPrinter.AllowPrinterSetup;
end;


procedure TPreviewForm.FirstPageSpeedClick(Sender: TObject);
begin
   CurPage := 0;
   CheckEnable;
end;

procedure TPreviewForm.LastPageSpeedClick(Sender: TObject);
begin
   CurPage := PrevPrinter.LastAvailPage-1;
   CheckEnable;
end;

procedure TPreviewForm.ZoomCursorButClick(Sender: TObject);
begin
   PB1.Cursor := crZoomIn;
   PB2.Cursor := crZoomIn;
end;

procedure TPreviewForm.HandCursorButClick(Sender: TObject);
begin
   PB1.Cursor := crHandMove;
   PB2.Cursor := crHandMove;
end;

procedure TPreviewForm.PB1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   sx, sy : single;
   nx, ny : integer;
begin
   if ZoomCursorBut.Down then
   begin
      sx := X / PagePanel.Width;
      sy := Y / PagePanel.Height;
      if ZoomingOut then
      begin
        PB1.Cursor := crZoomOut;
        PB2.Cursor := crZoomOut;
        Zoom := Zoom / ZOOMFACTOR;
        ZoomingOut := Zoom >= 0.25;
      end
      else
      begin
        PB1.Cursor := crZoomIn;
        PB2.Cursor := crZoomIn;
        ZoomingOut := Zoom >= 4;
        Zoom := Zoom * ZOOMFACTOR;
      end;
//      if ssLeft  in Shift then Zoom := Zoom * ZOOMFACTOR;
//      if ssRight in Shift then Zoom := Zoom / ZOOMFACTOR;
      ZoomBox.ItemIndex := 2;
      ScrollBox1Resize(nil);

      nx := trunc(sx * PagePanel.Width);
      ny := trunc(sy * PagePanel.Height);
      ScrollBox1.HorzScrollBar.Position := nx - ScrollBox1.Width div 2;
      ScrollBox1.VertScrollBar.Position := ny - ScrollBox1.Height div 2;
   end;
   if HandCursorBut.Down then
   begin
      DownX  := X;
      DownY  := Y;
      Moving := True;
   end;
end;

procedure TPreviewForm.PB1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if Moving then
   begin
      ScrollBox1.HorzScrollBar.Position := ScrollBox1.HorzScrollBar.Position + (DownX - X);
      ScrollBox1.VertScrollBar.Position := ScrollBox1.VertScrollBar.Position + (DownY - Y);
   end;
end;

procedure TPreviewForm.PB1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Moving := False;
end;

procedure TPreviewForm.PrintButClick(Sender: TObject);
begin
  if PrintDialog1.Execute then
    PrevPrinter.Print;
end;

procedure TPreviewForm.FitPageButClick(Sender: TObject);
begin
   ZoomBox.ItemIndex := 0;
   ZoomBoxChange(nil);
end;

procedure TPreviewForm.FitWidthButClick(Sender: TObject);
begin
   ZoomBox.ItemIndex := 1;
   ZoomBoxChange(nil);
end;

procedure TPreviewForm.PrintSetupButClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
  begin
    PrevPrinter.Orientation := Printer.Orientation;
    Close;
    PrevPrinter.Preview;
  end;
end;

procedure TPreviewForm.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ZoomingOut := WheelDelta > 0;
  PB1MouseDown(Sender,mbLeft,Shift,MousePos.X,MousePos.Y);
  Handled := true;
end;

end.


