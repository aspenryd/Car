{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13167: SENDKEYS.pas 
{
{   Rev 1.0    2003-03-20 14:03:32  peter
}
{***************************************************************
 *
 * Unit Name: SendKey
 * Purpose  : Sends Keystrokes to any Application
 * Author   : Fred Schetterer
 * History  : Created on 6/26/1999
 *            Rewrite to work with Windows 98
 *            01-Mar-2000 -  updated for Windowns 2000
 *            01-Mar-2000 - added non translatable character support
 *                          Icelandic for now
 *
 ****************************************************************}

unit Sendkeys;

interface

uses
  windows, Sysutils, Classes, Controls, Forms, Dialogs, Messages;

{$I SendKeys.Inc}

type
  TSendKey = class(TComponent)
  private
    fTokensOnly : Boolean;
    isAltPressed : Boolean;
    isControlPressed : Boolean;
    isShiftPressed : Boolean;
    isAltGrPressed : Boolean;
    function FindKeyInArray(Key : TKeyString; var Code : Byte) : Boolean;
    procedure MakeMessage(VirtKey : byte; IsUp : Boolean);
    procedure SimKeyPresses(VKeyCode : Word);
    procedure ProcessString(S : string);
  protected
    procedure TranslateToCurrentKeyboard(CharToTranslate : char);
    procedure MakeTranslatedKeys(CharToTranslate : char; TranslateArray : array of TKeyTranslateRec);
  public
    constructor Create(AOwner : TComponent); override;
    function SendKeys(const AStr : string) : Boolean;
    function SendKeysTo(const AStr : string; FocusHwnd : Thandle) : Boolean;
    function SendKeysToTopWindow(const AStr : string; WindowClass, Title : Pchar) : Boolean;
  published
    property TokensOnly : Boolean read fTokensOnly write fTokensOnly;
  end;

function ForceForegroundWindow98(hWnd : THandle) : Boolean;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FreDsterWare', [TSendKey]);
end;

{-----------------------------------------------------
          ForceForegroundWindow98

 * Purpose  : Forces a Window to the Foreground in Windows98
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

function ForceForegroundWindow98(hWnd : THandle) : Boolean;
const
  SPI_GETFOREGROUNDLOCKTIMEOUT               = $2000;
  SPI_SETFOREGROUNDLOCKTIMEOUT               = $2001;
var
  timeout                                    : DWORD;
begin
  // If NT 5
  if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4))
    // Windows
  or ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS)
    // 98
    and ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and (Win32MinorVersion > 0)))) then
  begin
    SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
    SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0), SPIF_SENDCHANGE);
    Result := SetForegroundWindow(hWnd);
    SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(timeout), SPIF_SENDCHANGE);
  end
  else
  begin
    Result := SetForegroundWindow(hWnd);
  end;
end;
{-----------------------------------------------------
          GetParentwithPopupStyle

 * Purpose  : Get the top most parent window
              in cases of dialogs this would be
              the top most window which has the
              WS_POPUP or WS_POPUPWINDOW  classs style
 * Author   : Fred Schetterer
 * History  :
              3/8/00 - Created
--------------------------------------------------------}

function GetParentwithPopupStyle(FocushWnd : THandle): Thandle;
var
  tmpHandle                                  : THandle;
  iStyle                                     : Longint;
begin

  Result := FocushWnd;
  repeat
    iStyle := GetWindowLong(Result, GWL_STYLE);
    if ((iStyle and WS_POPUP) <> 0) or ((iStyle and WS_POPUPWINDOW) <> 0) then
      Exit;

    tmpHandle := GetParent(Result);
    if tmpHandle <> 0 then
      Result := tmpHandle;
  until tmpHandle = 0;

end;
{-----------------------------------------------------
          SetThreadFocus

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
              3/8/00 - Added GetParentwithPopupStyle
                       there was a problem sending keystrokes
                       to system dialog windows.
                       The bug was found while sending keystrokes to
                       the Network applet dialog windows
--------------------------------------------------------}

function SetThreadFocus(FocushWnd : THandle) : Boolean;
var
  ParentHwnd                                 : THandle;
  ThisThreadID                               : DWord;
  AttachToThreadID                           : DWord;
begin

  ThisThreadID := GetCurrentThreadID;
  AttachToThreadID := GetWindowThreadProcessId(FocushWnd, nil);

  if ThisThreadID <> AttachToThreadID then
  begin
    Result := AttachThreadInput(ThisThreadID, AttachToThreadID, True);
    if Result then
    begin
      ParentHwnd := GetParentwithPopupStyle(FocushWnd);
      ForceForegroundWindow98(ParentHwnd);
      Result := (SetFocus(FocushWnd) <> 0);
      AttachThreadInput(ThisThreadID, AttachToThreadID, false);
    end;
  end
  else
    Result := (SetFocus(FocushWnd) <> 0);
end;
{-----------------------------------------------------
          TSendKey.FindKeyInArray

 * Purpose  : Searches KeyDefArray defined in SendKey.inc for a string
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

function TSendKey.FindKeyInArray(Key : TKeyString; var Code : Byte) : Boolean;
var
  i                                          : Integer;
begin
  Result := False;
  i := 1;

  while (i <= MaxKeys) do
    if UpperCase(Key) = KeyDefArray[i].Key then
    begin
      Code := KeyDefArray[i].vkCode;
      Result := True;
      Break;
    end
    else
      Inc(i);
end;

{-----------------------------------------------------
          TSendKey.MakeMessage

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

procedure TSendKey.MakeMessage(VirtKey : byte; IsUp : Boolean);
var
  iScancode                                  : UINT;
  KeyStateFlags                              : DWORD;
begin

  KeyStateFlags := 0;

  iScancode := MapVirtualKey(VirtKey, 0);                        { Map virtual keycode to scancode }

  if ((iScancode and 224) > 0) then                              { need to add scancode }
    KeyStateFlags := KEYEVENTF_EXTENDEDKEY;

  if IsUp then
    KeyStateFlags := KeyStateFlags or KEYEVENTF_KEYUP;

  keybd_event(VirtKey,                                           { virtual-key code}
    iScancode,                                                   { hardware scan code}
    KeyStateFlags,                                               { flags specifying Key up/down or KEYEVENTF_EXTENDEDKEY}
    0);                                                          { additional data associated with keystroke}
end;
{-----------------------------------------------------
          TSendKey.SimKeyPresses

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

procedure TSendKey.SimKeyPresses(VKeyCode : Word);
begin

  case hi(VKeyCode) of                                           { test to see if code was passed other then Token }
    2 : isControlPressed := TRUE;
    3 :
      begin
        isControlPressed := TRUE;
        isShiftPressed := TRUE;
      end;
    6 : isAltGrPressed := TRUE;                                  { - \ Alternative characters}
    7 :
      begin
        isAltGrPressed := TRUE;
        isShiftPressed := TRUE;
      end;
  end;

  if isAltPressed then
    MakeMessage(vk_Menu, false);                                 {Down}

  if isControlPressed then                                       { press Control key if flag has been set }
    MakeMessage(vk_Control, false);                              {Down}

  if isShiftPressed then                                         { if shift flag is set, reset flag }
    MakeMessage(vk_Shift, false);                                {Down}

  if isAltGrPressed then                                         { if ALTGR flag is set, reset flag }
  begin
    MakeMessage(vk_Control, false);                              {Down}
    MakeMessage(vk_Menu, false);                                 {Down}
  end;

  { if shift is pressed, or shifted key and control is not pressed... }
  if (((Hi(VKeyCode) and 1) <> 0)
    and (not isControlPressed)) or isShiftPressed then
    MakeMessage(vk_Shift, false);                                { ...press shift }
  MakeMessage(Lo(VKeyCode), false);                              { press key down }
  MakeMessage(Lo(VKeyCode), true);                               { release key }

  { if shift is pressed, or shifted key and control is not pressed... }
  if (((Hi(VKeyCode) and 1) <> 0) and (not isControlPressed)) or isShiftPressed then
    MakeMessage(vk_Shift, true);                                 { ...release shift }

  { if shift flag is set, reset flag }
  if isShiftPressed then
  begin
    MakeMessage(vk_Shift, true);
    isShiftPressed := False;
  end;
  { Release Control key if flag has been set, reset flag }
  if isControlPressed then
  begin
    MakeMessage(vk_Control, true);
    isControlPressed := False;
  end;
  { Release Alt key if flag has been set, reset flag }
  if isAltPressed then
  begin
    MakeMessage(vk_Menu, true);
    isAltPressed := False;
  end;
  { if ALTGR flag is set, reset flag }
  if isAltGrPressed then
  begin
    MakeMessage(vk_Control, True);                               {up}
    MakeMessage(vk_Menu, True);                                  {up}
    isAltGrPressed := False;
  end;
end;
{-----------------------------------------------------
          GetCurrentKeyBoardLanguage

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              01-Mar-2000 - Created
--------------------------------------------------------}

function GetCurrentKeyBoardLanguage : integer;
var
  LangID                                     : string;
  KeyboardLanguage                           : WORD;
begin
  SetLength(LangId, KL_NAMELENGTH);
  if not GetKeyboardLayoutName(Pchar(LangID)) then
    raise Exception.create('Could Not Retrieve Keyboard Name');
  LangID := Pchar(LangID);
  KeyboardLanguage := strtoInt('$' + LangID);
  result := LoByte(KeyboardLanguage);
end;
{-----------------------------------------------------
          TSendKey.TranslateToCurrentKeyboard

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              01-Mar-2000 - Created
--------------------------------------------------------}

procedure TSendKey.TranslateToCurrentKeyboard(CharToTranslate : char);
begin
  case GetCurrentKeyBoardLanguage of
    LANG_ICELANDIC : MakeTranslatedKeys(CharToTranslate, ICELANDIC_TranslateArray);
  end;
end;
{-----------------------------------------------------
          FindTranslateRecordInArray

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              01-Mar-2000 - Created
--------------------------------------------------------}

function FindTranslateRecordInArray(CharToTranslate : char; TranslateArray : array of TKeyTranslateRec) : Integer;
begin
  Result := High(TranslateArray);
  while (Result >= 0) do
    if CharToTranslate = TranslateArray[Result].NonTranslatable then
      Break
    else
      Dec(Result);
end;
{-----------------------------------------------------
          TSendKey.MakeTranslatedKeys

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              01-Mar-2000 - Created
--------------------------------------------------------}

procedure TSendKey.MakeTranslatedKeys(CharToTranslate : char; TranslateArray : array of TKeyTranslateRec);
var
  RecPos                                     : integer;
  KeyCode                                    : WORD;
begin
  RecPos := FindTranslateRecordInArray(CharToTranslate, TranslateArray);
  if RecPos > -1 then
  begin
    if TranslateArray[RecPos].ExtendedCode > 0 then
      MakeMessage(TranslateArray[RecPos].ExtendedCode, false);   {Down}

    KeyCode := vkKeyScan(TranslateArray[RecPos].Translated);
    SimKeyPresses(KeyCode);

    if TranslateArray[RecPos].ExtendedCode > 0 then
      MakeMessage(TranslateArray[RecPos].ExtendedCode, true);    {up}
  end;
end;

{-----------------------------------------------------
          TSendKey.ProcessString

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

procedure TSendKey.ProcessString(S : string);
const
  NonTranslatable                            = 65535;
var
  KeyCode                                    : word;
  Key                                        : byte;
  index                                      : integer;
  Token                                      : TKeyString;

  procedure SendStrokes;
  begin
    KeyCode := vkKeyScan(char(S[index]));
    if (NonTranslatable = KeyCode) then
      TranslateToCurrentKeyboard(char(S[index]))
    else
      SimKeyPresses(KeyCode);
  end;
begin

  index := 1;
  repeat
    case S[index] of
      KeyGroupClose :
        if (Length(S) = 1) then                                  { Single Bracket gets through}
        begin
          SendStrokes;
          Break;
        end
        else
          raise Exception.create('Invalid token');
      KeyGroupOpen :
        begin
          { Single Bracket gets through}
          if (Length(S) = 1) then
          begin
            SendStrokes;
            Break;
          end;
          Token := '';
          inc(index);
          while (S[index] <> KeyGroupClose) do
          begin
            Token := Token + S[index];
            inc(index);
            if (Length(Token) = 7) and (S[index] <> KeyGroupClose) then
              raise Exception.create('No Closing brackets');
          end;
          if not FindKeyInArray(Token, Key) then

            raise Exception.create('Invalid token');

          { Skim the shiftstate keys here}
          if (Pos('ALT', Token) > 0) then
            isAltPressed := True
          else if (Pos('CTRL', Token) > 0) then
            isControlPressed := True
          else if (Pos('SHIFT', Token) > 0) then
            isShiftPressed := True
          else
            SimKeyPresses(Makeword(key, 0));

        end;

      AltKey :
        if fTokensOnly then                                      { not turned off}
          SendStrokes
        else
          isAltPressed := True;
      ControlKey :
        if fTokensOnly then                                      { not turned off}
          SendStrokes
        else
          isControlPressed := True;
      ShiftKey :
        if fTokensOnly then                                      { not turned off}
          SendStrokes
        else
          isShiftPressed := True;
    else
      SendStrokes;
    end;
    inc(index);
  until index > Length(S);

end;

{-----------------------------------------------------
          TSendKey.SendKeys

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

function TSendKey.SendKeys(const AStr : string) : Boolean;
begin
  Result := false;

  if AStr = '' then Exit;

  ProcessString(AStr);
  Application.ProcessMessages;

  Result := True;

end;

{-----------------------------------------------------
          TSendKey.SendKeysto

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

function TSendKey.SendKeysto(const AStr : string; FocusHwnd : Thandle) : Boolean;
begin
  Result := false;
  if FocusHwnd > 0 then
  begin
    SetThreadFocus(FocusHwnd);
    Result := SendKeys(AStr);
  end;
end;
{-----------------------------------------------------
          TSendKey.SendKeystoTopWindow

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

function TSendKey.SendKeystoTopWindow(const AStr : string; WindowClass, Title : Pchar) : Boolean;
var
  FocusHwnd                                  : THandle;
begin
  Result := False;
  FocusHwnd := FindWindowEx(0, 0, WindowClass, Title);
  if (FocusHwnd = 0) then Exit;
  Result := SendKeysTo(AStr, FocusHwnd);
end;

{-----------------------------------------------------
          TSendKey.Create

 * Purpose  :
 * Author   : Fred Schetterer
 * History  :
              6/26/1999 - Created
--------------------------------------------------------}

constructor TSendKey.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

{$IFDEF UNREGISTERED}
  if not (csDesigning in ComponentState) then                    { running outside IDE}
    if (FindWindowEx(0, 0, 'TAppBuilder', nil) = 0) then
    begin                                                        { Delphi not found}
      Application.NormalizeTopMosts;
      ShowMessage('TSendKey is NOT a public domain product, if you find it usefull then please register it..');
      Application.RestoreTopMosts;
    end;
{$ENDIF}
end;

end.

