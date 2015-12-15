{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13153: ListComb.pas 
{
{   Rev 1.0    2003-03-20 14:03:30  peter
}
{
{   Rev 1.0    2003-03-17 10:14:34  Supervisor
}
{
  Written by Peter Thornqvist
  Copyright © 1997 by Peter Thornqvist; all rights reserved

  Part of EQ Soft Delphi Component Pack

  Contact: support@eq-soft.se

  Status:
    Free for non-commercial use. Source and commercial license demands a fee.
    See readme.txt file for details.
  Description:
    A unit to allow display of bitmaps in TComboboxes and TListboxes
    Use an ImageList to store the pictures: assign the ImageList to
    the components ImageList property, write something in the Items
    property and go!

  Version 0.3
}

unit ListComb;

interface
{$I VER.INC }
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
  ExtCtrls,ImgList;

type
  TButtonColors = (fsLighter,fsLight,fsMedium,fsDark,fsDarker);
  TComboBoxEx = class(TCustomComboBox)
  private
    { Private declarations }
    FIStrings:TStrings;
    FImages:TImagelist;
    FChangeLink:TChangeLink;
    FCanvas:TCanvas;
    MouseInControl:boolean;
    FWidth,FHeight:integer;
    FColHi,FColHiText:TColor;
    FDrawSelected:boolean;
    FOnChange: TNotifyEvent;
    FButtonFrame:boolean;
    FDefIndex:integer;
    FDroppedWidth:integer;
    FButtonStyle:TButtonColors;
    procedure SetColHi(Value:TColor);
    procedure SetColHiText(Value:TColor);
    procedure SetItemImages(Value:TStrings);
    function GetItemImages:TStrings;
    procedure SetImageIndex(Index,Value:integer);
    function GetImageIndex(Index:integer):integer;
    procedure SetImages(Value:TImageList);
    procedure CMEnabledChanged (var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged (var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus (var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize (var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint (var Message: TMessage); message WM_NCPAINT;
    procedure ResetItemHeight;
    procedure ImageListChange(Sender: TObject);
    function GetDroppedWidth:integer;
    procedure SetDroppedWidth(Value:integer);
  protected
    { Protected declarations }
    procedure CreateWnd; override;
    procedure RecreateWnd;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer;var Height: Integer);override;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure Change; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property    Canvas: TCanvas read FCanvas;
    property    Text;
    property    ImageIndex[Index:integer]:integer read GetImageIndex write SetImageIndex;
  published
    { Published declarations }
    property Align;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DefaultIndex:integer read FDefIndex write FDefIndex default -1;
    property DroppedWidth:integer read GetDroppedWidth write SetDroppedWidth;
    property Enabled;
    property ButtonFrame:boolean read FButtonFrame write FButtonFrame default false;
    property ButtonStyle:TButtonColors read FButtonStyle write FButtonStyle;
    property ColorHighLight:TColor read FColHi write SetColHi default clHighLight;
    property ColorHighLightText:TColor read FColHiText write SetColHiText default clHighLightText;
    property FocusImage:boolean read FDrawSelected write FDrawSelected default true;
    property Font;
    property Items;
    property ImageList:TImageList read FImages write SetImages;
    property ItemImages:TStrings read GetItemImages write SetItemImages;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Tag;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    {$IFDEF D4_AND_UP }
    property Anchors;
    property Constraints;
    property BiDiMode;
    property ParentBiDiMode;
    property DragKind;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
  end;

  { TImageListBox }
  TTextAlign=(ttaLeft,ttaCenter,ttaRight);
  TListBoxEx = class(TCustomListBox)
  private
    { Private declarations }
    FIStrings:TStrings;
    FImages:TImagelist;
    FChangeLink:TChangeLink;
    FCanvas:TCanvas;
    FWidth:integer;
    FHeight:integer;
    FTextAlign:TTextAlign;
    FDrawSelected:boolean;
    FColHi,FColHiText:TColor;
    FDefIndex:integer;
    FButtonFrame:boolean;
    FButtonStyle:TButtonColors;
    procedure SetColHi(Value:TColor);
    procedure SetColHiText(Value:TColor);
    procedure SetItemImages(Value:TStrings);
    function GetItemImages:TStrings;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure ResetItemHeight;
    procedure SetImages(Value:TImageList);
    procedure SetTextAlign(Value:TTextAlign);
    procedure DrawLeftGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
    procedure DrawRightGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
    procedure DrawCenteredGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
  protected
    { Protected declarations }
    procedure ImageListChange(Sender: TObject);
    procedure CreateWnd; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer;var Height: Integer);override;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMSize(var Message: TWMSize);message WM_SIZE;
//    procedure Change; dynamic;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas:TCanvas read FCanvas;
  published
    { Published declarations }
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property ButtonFrame:boolean read FButtonFrame write FButtonFrame default false;
    property ButtonStyle:TButtonColors read FButtonStyle write FButtonStyle;
    property ColorHighLight:TColor read FColHi write SetColHi default clHighLight;
    property ColorHighLightText:TColor read FColHiText write SetColHiText default clHighLightText;
    property DefaultIndex:integer read FDefIndex write FDefIndex default -1;
    property FocusImage:boolean read FDrawSelected write FDrawSelected default true;
    property ItemImages:TStrings read GetItemImages write SetItemImages;
    property ImageList:TImageList read FImages write SetImages;
    property MultiSelect;
    property IntegralHeight;
    property ItemHeight;
    property Items;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TextAlign:TTextAlign read FTextAlign write SetTextAlign;
    property TabOrder;
    property TabStop;
    property Visible;
//    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property Sorted;
    property Tag;
    {$IFDEF VER120 }
    property Anchors;
    property Constraints;
    property BiDiMode;
    property ParentBiDiMode;
    property DragKind;
    property OnEndDock;
    property OnStartDock;

    {$ENDIF}
  end;




implementation
uses Consts;
{ utility }

{
function DropArrowWidth:integer;
begin
  Result := GetSystemMetrics(SM_CXVSCROLL);
end;
}

function GetItemHeight(Font: TFont): Integer;
var DC: HDC; SaveFont: HFont; Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

function IMax(i,j:integer):integer;
begin
  if j > i then
    Result := j
  else
    Result := i;
end;
{
function Min(i,j:Integer):integer;
begin
  Result := i;
  if j < i then
    Result := j;
end;
}

procedure DrawBtnFrame(Canvas:TCanvas;ButtonStyle:TButtonColors;DefColor:TColor;Default:boolean;R:TRect);
var FTop,FBtm:TColor;
begin
  if Default then
  begin
    Frame3d(Canvas,R,DefColor,DefColor,1);
    Exit;
  end;
  FTop := DefColor;
  FBtm := DefColor;
  
  case ButtonStyle of    //
    fsLighter:
    begin
      FTop := clBtnHighLight;
      FBtm := clBtnFace;
    end;
    fsLight:
    begin
      FTop := clBtnHighLight;
      FBtm := clBtnShadow;
    end;
    fsMedium:
    begin
      FTop := clBtnHighLight;
      FBtm := cl3DDkShadow;
    end;
    fsDark:
    begin
      FTop := clBtnFace;
      FBtm := cl3DDkShadow;
    end;
    fsDarker:
    begin
      FTop := clBtnShadow;
      FBtm := cl3DDkShadow;
    end;
  end;    // case
  Frame3d(Canvas,R,FTop,FBtm,1);
end;
{ TComboBoxEx }

constructor TComboBoxEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWidth := 0;
  FHeight := 0;
  FImages := nil;
  FDefIndex := -1;
  FDrawSelected := true;
  FButtonFrame := false;
  FIStrings := TStringList.Create;
  Style := csOwnerDrawFixed;
  Color := clWindow;
  FColHi := clHighLight;
  FColHiText := clHighLightText;
  FCanvas := TControlCanvas.Create;
  ResetItemHeight;
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := ImageListChange;
end;

destructor TComboBoxEx.Destroy;
begin
  FCanvas.Free;
  FIStrings.Free;
  FChangeLink.Free;
  inherited Destroy;
end;

procedure TComboBoxEx.ImageListChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TComboBoxEx.SetImages(Value:TImageList);
begin
 if FImages <> Value then
 begin
   if FImages <> nil then
      FImages.UnRegisterChanges(FChangeLink);
   FImages := Value;

   if FImages <> nil then
     FImages.RegisterChanges(FChangeLink);

   if Assigned(FImages) then
   begin
     FWidth := FImages.Width;
     FHeight := FImages.Height;
   end
   else
   begin
     FWidth := 0;
     FHeight := 0;
   end;
   ResetItemHeight;
   RecreateWnd;
 end;
end;

procedure TComboBoxEx.CreateWnd;
begin
  inherited CreateWnd;
  SetDroppedWidth(FDroppedWidth);
end;

procedure TComboBoxEx.RecreateWnd;
begin
  inherited RecreateWnd;
  SetDroppedWidth(FDroppedWidth);
end;

procedure TComboBoxEx.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = FImages) then
    FImages := nil;
end;

procedure TComboBoxEx.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do
  begin
    {$IFDEF D5_AND_UP }
    State := TOwnerDrawState(Lo(itemState));
    {$ELSE }
    State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
    {$ENDIF}
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      FCanvas.Brush.Color := FColHi;
      FCanvas.Font.Color := FColHiText;
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      FCanvas.FillRect(rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TComboBoxEx.DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState);
var Offset,tmp:integer;TmpCol:TColor;OldStyle:TDrawingStyle;tmpR:TRect;
begin
  with FCanvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if Assigned(FImages) then
    begin
      OldStyle := FImages.DrawingStyle;

      if (odFocused in State) and DroppedDown and FDrawSelected then
        FImages.DrawingStyle := dsFocus
      else
        FImages.DrawingStyle := dsTransparent;
      if FIStrings.Count < Index + 1 then
        tmp := FDefIndex
      else
        tmp := StrToIntDef(FIStrings[Index],FDefIndex);
      Offset := ((R.Bottom - R.Top) - FWidth) div 2;
      FImages.Draw(Canvas,R.Left + 2,R.Top + Offset,tmp);
      if (FButtonFrame)  then
      begin
       tmpR := Rect(R.Left,R.Top,R.Left + FImages.Width + 4,R.Top + FImages.Height + 4);
       DrawBtnFrame(Canvas,FButtonStyle,Color,not ((tmp in [0..FImages.Count - 1])and (odFocused in State) and (DroppedDown)),tmpR);
      end;
      FImages.DrawingStyle := OldStyle;
      Inc(R.Left,FWidth + 8);
    end
    else
      FillRect(R);

    R.Right := R.Left + TextWidth(Items[Index]);
    InflateRect(R,2,-1);
    if Length(Items[Index]) > 0 then
      FillRect(R);
    Inc(R.Left,2);
    DrawText(Canvas.Handle, PChar(Items[Index]), -1, R, DT_SINGLELINE or DT_NOPREFIX
                                                        or DT_VCENTER );
    Dec(R.Left,2);
    if (odSelected in State) and (Length(Items[Index]) > 0) and (Color <> FColHi) then
      DrawFocusRect(R);
  end;
end;


procedure TComboBoxEx.MeasureItem(Index: Integer;var Height: Integer);
begin
  Height:= IMax(GetItemHeight(Font) + 2,FHeight);
end;

procedure TComboBoxEx.SetColHi(Value:TColor);
begin
  if FColHi <> Value then
  begin
    FColHi := Value;
    Invalidate;
  end;
end;

procedure TComboBoxEx.SetColHiText(Value:TColor);
begin
  if FColHiText <> Value then
  begin
    FColHiText := Value;
    Invalidate;
  end;
end;

procedure TComboBoxEx.SetItemImages(Value:TStrings);
begin
  FIStrings.Assign(Value);
end;

function TComboBoxEx.GetItemImages:TStrings;
begin
  Result := FIStrings;
end;

procedure TComboBoxEx.SetImageIndex(Index,Value:integer);
begin
  FIStrings[Index] := IntToStr(Value);
end;

function TComboBoxEx.GetImageIndex(Index:integer):integer;
begin
  Result := StrToIntDef(FIStrings[Index],FDefIndex);
end;

function TComboBoxEx.GetDroppedWidth:integer;
begin
  HandleNeeded;
  Result := SendMessage(Handle,CB_GETDROPPEDWIDTH,0,0);
end;

procedure TComboBoxEx.SetDroppedWidth(Value:integer);
begin
  HandleNeeded;
  FDroppedWidth := SendMessage(Handle,CB_SETDROPPEDWIDTH,Value,0);
end;

procedure TComboBoxEx.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;

procedure TComboBoxEx.ResetItemHeight;
begin
  ItemHeight := IMax(GetItemHeight(Font) + 4,FHeight + 4);
end;


procedure TComboBoxEx.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TComboBoxEx.CNCommand(var Message: TWMCommand);
begin
inherited;
   case Message.NotifyCode of
    CBN_SELCHANGE:
        Change;
  end;
end;

procedure TComboBoxEx.CMEnabledChanged (var Message: TMessage);
const
  EnableColors: array[Boolean] of TColor = (clBtnFace, clWindow);
begin
  inherited;
  Color := EnableColors[Enabled];
end;

procedure TComboBoxEx.WMSetFocus (var Message: TWMSetFocus);
begin
  inherited;
end;

procedure TComboBoxEx.WMKillFocus (var Message: TWMKillFocus);
begin
  inherited;
end;

procedure TComboBoxEx.WMNCCalcSize (var Message: TWMNCCalcSize);
begin
  inherited;
//  InflateRect (Message.CalcSize_Params^.rgrc[0], -1, -1);
end;

procedure TComboBoxEx.WMNCPaint (var Message: TMessage);
begin
  inherited;
end;


procedure TComboBoxEx.CMMouseEnter (var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TComboBoxEx.CMMouseLeave (var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

{ TListBoxEx }

constructor TListBoxEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(0,0,121,97);
  FIStrings := TStringlist.Create;
  Color := clWindow;
  FColHi := clHighLight;
  FColHiText := clHighLightText;
  FDefIndex := -1;
  FDrawSelected := true;
  FWidth := 0;
  FHeight := 0;
  FTextAlign := ttaRight;
  FButtonFrame := false;
  Style := lbOwnerDrawFixed;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := ImageListChange;
  ResetItemHeight;
end;

destructor TListBoxEx.Destroy;
begin
  FCanvas.Free;
  FIStrings.Free;
  FChangeLink.Free;
  inherited Destroy;
end;

procedure TListBoxEx.ImageListChange;
begin
  Invalidate;
end;

procedure TListBoxEx.SetImages(Value:TImageList);
begin
 if FImages <> Value then
 begin
   if FImages <> nil then
      FImages.UnRegisterChanges(FChangeLink);
   FImages := Value;

   if FImages <> nil then
     FImages.RegisterChanges(FChangeLink);

   if Assigned(FImages) then
   begin
     FWidth := FImages.Width;
     FHeight := FImages.Height;
   end
   else
   begin
     FWidth := 0;
     FHeight := 0;
   end;
   ResetItemHeight;
   RecreateWnd;
 end;
end;


procedure TListBoxEx.SetTextAlign(Value:TTextAlign);
begin
  if FTextAlign <> Value then
  begin
    FTextAlign := Value;
    ResetItemHeight;
  end;
end;

procedure TListBoxEx.CreateWnd;
begin
  inherited CreateWnd;
  SetBkMode(Canvas.Handle,TRANSPARENT);
end;

procedure TListBoxEx.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = FImages) then
    FImages := nil;
end;


procedure TListBoxEx.SetColHi(Value:TColor);
begin
  if FColHi <> Value then
  begin
    FColHi := Value;
    Invalidate;
  end;
end;
procedure TListBoxEx.SetColHiText(Value:TColor);
begin
  if FColHiText <> Value then
  begin
    FColHiText := Value;
    Invalidate;
  end;
end;

procedure TListBoxEx.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do
  begin
    {$IFDEF D5_AND_UP }
    State := TOwnerDrawState(Lo(itemState));
    {$ELSE }
    State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
    {$ENDIF}
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;

    if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      FCanvas.Brush.Color := FColHi;
      FCanvas.Font.Color := FColHiText;
    end;

    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      FCanvas.FillRect(rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TListBoxEx.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  case FTextAlign of
    ttaLeft:   DrawRightGlyph(Index,Rect,State);
    ttaRight:  DrawLeftGlyph(Index,Rect,State);
    ttaCenter: DrawCenteredGlyph(Index,Rect,State);
  end;
end;

procedure TListBoxEx.DrawCenteredGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
var tmp,tmp2:integer;TmpCol:TColor;OldStyle:TDrawingStyle;tmpR:TRect;
begin
  with Canvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if Assigned(FImages) then
    begin
      tmp := ((R.Right - R.Left) - FWidth) div 2;
      OldStyle := FImages.DrawingStyle;

      if (odSelected in State) and FDrawSelected then
        FImages.DrawingStyle := dsSelected
      else
        FImages.DrawingStyle := dsTransparent;
      if FIStrings.Count < Index + 1 then
        tmp2 := FDefIndex
      else
        tmp2 := StrToIntDef(FIStrings[Index],FDefIndex);

      FImages.Draw(Canvas,R.Left + tmp,R.Top + 2,tmp2);
      if (FButtonFrame)  then
      begin
       tmpR := Rect(R.Left + tmp - 2,R.Top,R.Left + tmp + FImages.Width + 2,R.Top + FImages.Height + 2);
       DrawBtnFrame(Canvas,FButtonStyle,Color,not ((tmp2 in [0..FImages.Count - 1]) and (odSelected in State)),tmpR);
      end;
      FImages.DrawingStyle := OldStyle;
      InflateRect(R,1,-4);
    end;
    DrawText(Canvas.Handle, PChar(Items[Index]), -1, R,
             DT_SINGLELINE or DT_NOPREFIX or DT_CENTER or DT_BOTTOM);
    if (odSelected in State) and (Length(Items[Index]) > 0) and (Color <> FColHi) then
    begin
      R.Left := ((R.Right - R.Left) - TextWidth(Items[Index])) div 2 - 1;
      R.Right := R.Left + TextWidth(Items[Index]) + 1;
      R.Top := R.Bottom - TextHeight(Items[Index]) - 1;
      DrawFocusRect(R);
    end;
  end;
end;

procedure TListBoxEx.DrawLeftGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
var Offset,tmp:integer;TmpCol:TColor;OldStyle:TDrawingStyle;tmpR:TRect;
begin
  with Canvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if Assigned(FImages) then
    begin
      OldStyle := FImages.DrawingStyle;
      if (odFocused in State) and (FDrawSelected) then
        FImages.DrawingStyle := dsFocus
      else
        FImages.DrawingStyle := dsTransparent;
      if FIStrings.Count < Index + 1 then
        tmp := FDefIndex
      else
        tmp := StrToIntDef(FIStrings[Index],FDefIndex);

      Offset := ((R.Bottom - R.Top) - FWidth) div 2;
      FImages.Draw(Canvas,R.Left + 2,R.Top + Offset,tmp);
      if (FButtonFrame)  then
      begin
       tmpR := Rect(R.Left,R.Top,R.Left + FImages.Width + 4,R.Top + FImages.Height + 4);
       DrawBtnFrame(Canvas,FButtonStyle,Color,not ((tmp in [0..FImages.Count - 1])and (odSelected in State)),tmpR);
      end;
      FImages.DrawingStyle := OldStyle;
      Inc(R.Left,FWidth + 8);
    end
    else
      FillRect(R);

    R.Right := R.Left + TextWidth(Items[Index]);
    InflateRect(R,2,-1);
    if (Length(Items[Index]) > 0) then
      FillRect(R);
    Inc(R.Left,2);
    DrawText(Canvas.Handle, PChar(Items[Index]), -1, R, DT_SINGLELINE or DT_NOPREFIX
                                                        or DT_VCENTER );
    Dec(R.Left,2);
    if (odSelected in State) and (Length(Items[Index]) > 0) and (Color <> FColHi) then
      DrawFocusRect(R);
  end;
end;

procedure TListBoxEx.DrawRightGlyph(Index: Integer; R: TRect; State: TOwnerDrawState);
var Offset,tmp:integer;TmpCol:TColor;OldStyle:TDrawingStyle;tmpR:TRect;
begin
  with Canvas do
  begin
    TmpCol := Brush.Color;
    Brush.Color := Color;
    FillRect(R);
    Brush.Color := TmpCol;

    if Assigned(FImages) then
    begin
      OldStyle := FImages.DrawingStyle;
      if (odFocused in State) and (FDrawSelected) then
        FImages.DrawingStyle := dsFocus
      else
        FImages.DrawingStyle := dsTransparent;

      if FIStrings.Count < Index + 1 then
        tmp := FDefIndex
      else
        tmp := StrToIntDef(FIStrings[Index],FDefIndex);

      Offset := ((R.Bottom - R.Top) - FWidth) div 2;
      FImages.Draw(Canvas,R.Right - (FWidth + 2),R.Top + Offset,tmp);
      if (FButtonFrame)  then
      begin
       tmpR := Rect(R.Right - (FImages.Width + 2) - 2,R.Top + Offset - 2,R.Right - 2,R.Top + Offset + FImages.Height + 2);
       DrawBtnFrame(Canvas,FButtonStyle,Color,not ((tmp in [0..FImages.Count - 1])and (odSelected in State)),tmpR);
      end;
      FImages.DrawingStyle := OldStyle;
      Inc(R.Left,4);
    end
    else
      FillRect(R);

    R.Right := R.Left + TextWidth(Items[Index]);
    InflateRect(R,2,-1);
    if (Length(Items[Index]) > 0) then
      FillRect(R);
    Inc(R.Left,2);
    DrawText(Canvas.Handle, PChar(Items[Index]), -1, R, DT_SINGLELINE or DT_NOPREFIX
                                                        or DT_VCENTER );
    Dec(R.Left,2);
    if (odSelected in State) and (Length(Items[Index]) > 0) and (Color <> FColHi) then
      DrawFocusRect(R);
  end;
end;

procedure TListBoxEx.MeasureItem(Index: Integer;var Height: Integer);
begin
  Height:= IMax(GetItemHeight(Font) + 4,FHeight + 4);
end;

procedure TListBoxEx.SetItemImages(Value:TStrings);
begin
  FIStrings.Assign(Value);
end;

function TListBoxEx.GetItemImages:TStrings;
begin
  Result := FIStrings;
end;

procedure TListBoxEx.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;

procedure TListBoxEx.ResetItemHeight;
begin
  case FTextAlign of
    ttaLeft,ttaRight: ItemHeight := IMax(GetItemHeight(Font) + 4, FHeight + 4);
    ttaCenter:        ItemHeight := GetItemHeight(Font) + FHeight + 8;
  end;
  Invalidate;
end;


procedure TListBoxEx.CNCommand(var Message: TWMCommand);
begin
inherited;
   case Message.NotifyCode of
    LBN_SELCHANGE:
    begin
      inherited Changed;
      Click;
    end;
  end;
end;

procedure TListBoxEx.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

end.
