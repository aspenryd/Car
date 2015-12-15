{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename
     Hints.pas
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
{ $Log:  13558: Hints.pas
{
{   Rev 1.1    2004-01-29 10:26:36  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:25:44  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-03-20 14:00:26  peter
}
{
{   Rev 1.0    2003-03-17 14:41:44  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:58  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:24  Supervisor
{ Start av vc
}
unit hints;

interface

uses Forms, Controls, extctrls, Windows;

type
  THintHandler = class(TObject)
  private
    FTimer: TTimer;
    FHintWindow: THintWindow;
  public
    constructor Create;
    destructor Destroy; override;
    procedure HideHint;
    procedure HintTimeOut(sender: TObject);
  end;

procedure ShowHintWindow(caption: string; Left, Top: integer); overload;
procedure ShowHintWindow(caption: string; control: TControl); overload;
procedure CancelHintWindow;

var
  HintHandler: THintHandler;

implementation

procedure ShowHintWindow(caption: string; control: TControl);
var
  cpt, spt: TPoint;
begin
  cpt.x := 0;
  cpt.y := Control.Height;
  spt := control.ClientToScreen(cpt);
  ShowHintWindow(caption, spt.x, spt.y);
end;

procedure ShowHintWindow(caption: string; Left, Top: integer);
var
  HintRect: TRect;
begin
  if not assigned(HintHandler) then
    HintHandler := THintHandler.Create;
  if Caption > '' then
  begin
    if not assigned(HintHandler.FHintWindow) then
      HintHandler.FHintWindow := THintWindow.Create(nil);
    HintHandler.FHintWindow.caption := Caption;
    HintRect := HintHandler.FHintWindow.CalcHintRect(200, caption, nil);
    HintRect.Left := Left;
    HintRect.Right := Left + HintRect.Right;
    HintRect.Top := Top;
    HintRect.Bottom := Top + HintRect.Bottom;
    HintHandler.FHintWindow.Color := Application.HintColor;
    HintHandler.FTimer.Enabled := false;
    HintHandler.FTimer.Enabled := true;
    HintHandler.FHintWindow.ActivateHint(HintRect, Caption);
  end
  else
    if assigned(HintHandler.FHintWindow) then
    begin
      HintHandler.FTimer.Enabled := false;
      HintHandler.FHintWindow.free;
      HintHandler.FHintWindow := nil;
    end;
end;

procedure CancelHintWindow;
begin
  if assigned(HintHandler) then
    HintHandler.HideHint;
end;

procedure THintHandler.HideHint;
begin
  FTimer.Enabled := false;
  FHintWindow.free;
  FHintWindow := nil;
end;

procedure THintHandler.HintTimeOut(sender: TObject);
begin
  HideHint;
end;

constructor THintHandler.Create;
begin
  FTimer := TTimer.Create(nil);
  FTimer.enabled := false;
  FTimer.interval := 5000000; //!5000
  FTimer.OnTimer := HintTimeOut;
end;

destructor THintHandler.Destroy;
begin
  FTimer.Free;
end;

end.

