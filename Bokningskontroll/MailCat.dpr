program MailCat;
// by Corbin Dunn, cdunn@borland.com

uses
  ExceptionLog,
  Windows,
  Messages,
  SysUtils,
  ShellApi,
  Registry,
  MMSystem,
  CommDlg,
  MailCtrls in 'MailCtrls.pas',
  MailCheck in 'MailCheck.pas';


const
  IDM_CHECK_NOW = 1;
  IDM_SETTINGS = 2;
  IDM_QUIT = 3;

{$R icons.res}


type
  TIconMode = (imGeneral, imRun1, imRun2, imError,
    imMoon1, imMoon2, imMoon3, imMoon4, imMoon5, imMoon6, imMoon7, imMoon8);

const
  CHECK_TIMER = WM_USER + 1;
  ANIMATION_TIMER = WM_USER + 5;
  GOT_MAIL_TIMER = WM_USER + 6;
  DOUBLE_CLICK_TIMER = WM_USER + 7;

  ICON_MESSAGE = WM_USER + 10;

  strAppName = 'MailCat Email Checker';
  cWidth = 360;
  cHeight = 420;
  // Registry contansts
  cRegKey = 'Software\PBKonsult\MailCheck';
  cRegServerName = 'ServerName';
  cRegUserName = 'UserName';
  cRegPassword = 'Password';
  cRegPort = 'Port';
  cRegTimeInterval = 'TimerInterval';
  cRegFirstTime = 'FirstTime';
  cRegPlaySound = 'PlaySound';
  cRegSoundFile = 'SoundFile';
  cRegLaunchEmailProg = 'LaunchEmailProg';


// var's used in procedures
var
  bShowingException: Boolean;
  bErrorOccured: Boolean;
  bGotMailAniGoing: Boolean;
  bFirstTime: Boolean;
  bPlaySound: Boolean;
  bLaunchEmailProg: Boolean;

  strSoundFile: string;

  hPopupMenu: HMENU;

  MailChecker: TMailChecker;

  // global child window variables
  lblTitle: TCrbLabel;
  lblIncoming: TCrbLabel;
  lblPort: TCrbLabel;
  lblLastError: TCrbLabel;
  lblAccountName: TCrbLabel;
  lblPassword: TCrbLabel;
  lblTimerTime: TCrbLabel;
  edtHost: TCrbEdit;

  edtPort: TCrbEdit;
  edtUser: TCrbEdit;
  edtPass: TCrbEdit;
  edtSound: TCrbEdit;
  edtTimerTime: TCrbEdit;
  edtCorbin: TCrbReadOnlyEdit;

  memErrors: TCrbMemo;

  btnCheckNow: TCrbButton;
  btnOkay: TCrbButton;
  btnQuit: TCrbButton;
  btnSelectSound: TCrbButton;

  chkbxPlaySound: TCrbCheckBox;
  chkbxLaunch: TCrbCheckBox;
  // Timer stuff
  nTimerInterval: Cardinal;

  imLastMode: TIconMode;

  // Shell icon stuff
  IconData : TNotifyIconData;

function EmailProgramCommand: string;
var
  Reg: TRegistry;
  P: Integer;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Reg.OpenKey('mailto\shell\open\command', False);
    Result := Reg.ReadString('');
    // Okay, now we have the app. just have to reove the extra's at the
    // end for a mailto url link
//C:\PROGRAM FILES\NETSCAPE\COMMUNICATOR\PROGRAM\NETSCAPE.EXE -h "%1"
    if Result = '' then Exit;

    // look for command link args and delete them.
    P := Pos('-', Result);
    if P <> 0 then
      Delete(Result, P, Length(Result) - P + 1);
    P := Pos('/', Result);
    if P <> 0 then
      Delete(Result, P, Length(Result) - P + 1);
    Result := TrimRight(Result);
    if Result[1] <> '"' then
      Result := '"' + Result;
    if Result[Length(Result)] <> '"' then
      Result := Result + '"';
  finally
    Reg.Free;
  end;
end;

function GetIcon(IconMode: TIconMode): HICON;
begin
  // load the small icons!
  case IconMode of
    imGeneral:  Result := LoadIcon(hInstance, 'ZGENERAL');
    imRun1:     Result := LoadIcon(hInstance, 'ZRUN1');
    imRun2:     Result := LoadIcon(hInstance, 'ZRUN2');
    imError:    Result := LoadIcon(hInstance, 'ZERROR');
    imMoon1:    Result := LoadIcon(hInstance, 'ZMOON1');
    imMoon2:    Result := LoadIcon(hInstance, 'ZMOON2');
    imMoon3:    Result := LoadIcon(hInstance, 'ZMOON3');
    imMoon4:    Result := LoadIcon(hInstance, 'ZMOON4');
    imMoon5:    Result := LoadIcon(hInstance, 'ZMOON5');
    imMoon6:    Result := LoadIcon(hInstance, 'ZMOON6');
    imMoon7:    Result := LoadIcon(hInstance, 'ZMOON7');
    imMoon8:    Result := LoadIcon(hInstance, 'ZMOON8');
  else
    Result := 0;
  end;
end;

procedure SetTrayIcon(IconMode: TIconMode);
begin
  imLastMode := IconMode;
  IconData.uFlags := NIF_ICON;
  IconData.hIcon := GetIcon(IconMode);
  Shell_NotifyIcon(NIM_MODIFY, @IconData);
end;

procedure SetTrayMessage(Message: string);
begin
  StrPCopy(IconData.szTip, Message);
  IconData.uFlags := NIF_TIP;
  Shell_NotifyIcon(NIM_MODIFY, @IconData);
end;


procedure CreateChildWindows(wnd: HWND);
{ Creates all the child windows on the form. }
var
  Registry: TRegistry;
begin
  /////////////
  // Create the title label
  lblTitle := TCrbLabel.Create(wnd);
  with lblTitle do
  begin
    Left := 52;
    Width := 252;
    Height := 24;
    Caption := 'Boknings kontroll';
    FontName := 'Arial';
    FontSize := 14;
    Show;
  end;

  lblIncoming := TCrbLabel.Create(wnd);
  with lblIncoming do
  begin
    Left := 15;
    Top := 34;
    Width := 169;
    Caption := 'Incoming mail server (POP3):';
    FontName := 'Arial';
    Show;
  end;

  lblPort := TCrbLabel.Create(wnd);
  with lblPort do
  begin
    Left := 24;
    Top := 106;
    Width := 160;
    Caption := 'Port Number (110 - default):';
    FontName := 'Arial';
    Show;
  end;

  lblLastError := TCrbLabel.Create(wnd);
  with lblLastError do
  begin
    Left := 17;
    Top := 156;
    Width := 135;
    Caption := 'Last Server Message:';
    FontName := 'Arial';
    Show;
  end;

  lblAccountName := TCrbLabel.Create(wnd);
  with lblAccountName do
  begin
    Left := 96;
    Top := 58;
    Width := 88;
    Height := 16;
    Caption := 'Account name:';
    FontName := 'Arial';
    Show;
  end;

  lblPassword := TCrbLabel.Create(wnd);
  with lblPassword do
  begin
    Left := 123;
    Top := 82;
    Width := 61;
    Caption := 'Password:';
    FontName := 'Arial';
    Show;
  end;

  lblTimerTime := TCrbLabel.Create(wnd);
  with lblTimerTime do
  begin
    Left := 37;
    Top := 130;
    Width := 148;
    Height := 16;
    FontName := 'Arial';
    Caption := 'Minutes between checks:';
    Show;
  end;
  // Create the Registry object
  Registry := TRegistry.Create;
  try
    Registry.OpenKey(cRegKey, False);
    try
      bFirstTime := Registry.ReadBool(cRegFirstTime);
    except
      bFirstTime := True;
    end;
    try
      bLaunchEmailProg := Registry.ReadBool(cRegLaunchEmailProg);
    except
      bLaunchEmailProg := True;
    end;

    // load settings from registry
    edtHost := TCrbEdit.Create(wnd);
    with edtHost do
    begin
      Left := 189;
      Top := 31;
      Width := 130;
      // read in the settings
      Caption := Registry.ReadString(cRegServerName);
      if Caption = '' then
        Caption := 'mail.yourserver.com';
      MailChecker.Host := Caption;
      Show;
    end;

    edtUser := TCrbEdit.Create(wnd);
    with edtUser do
    begin
      Left := 189;
      Top := 55;
      Width := 130;
      // read in the settings
      Caption := Registry.ReadString(cRegUserName);
      MailChecker.UserName := Caption;
      Show;
    end;

    edtPass := TCrbEdit.Create(wnd);
    with edtPass do
    begin
      Left := 189;
      Top := 79;
      Width := 130;
      PasswordChar := '*';
      // maybe add some encryption to the password
      // read in the settings
      Caption := Registry.ReadString(cRegPassword);
      MailChecker.Password := Caption;
      Show;
    end;

    edtPort := TCrbEdit.Create(wnd);
    with edtPort do
    begin
      Left := 189;
      Top := 103;
      Width := 130;
      // read in the settings
      Caption := Registry.ReadString(cRegPort);
      if Caption = '' then
        Caption := '110';
      MailChecker.Port := StrToInt(Caption);
      Show;
    end;

    edtTimerTime := TCrbEdit.Create(wnd);
    with edtTimerTime do
    begin
      Left := 189;
      Top := 127;
      Width := 130;
      // load the timer interval
      try
        nTimerInterval := Cardinal(Registry.ReadInteger(cRegTimeInterval));
      except
        nTimerInterval := 120000; // default 2 minutes
      end;
        Caption := IntToStr(nTimerInterval div 60000);
        Show;
    end;

    try
      bPlaySound := Registry.ReadBool(cRegPlaySound);
    except
      bPlaySound := True;
    end;

    strSoundFile := Registry.ReadString(cRegSoundFile);
    if strSoundFile = '' then
      strSoundFile := ExtractFilePath(ParamStr(0)) + 'awake.wav';
    Registry.CloseKey;
  finally
    Registry.Free;
  end;


  memErrors := TCrbMemo.Create(wnd);
  with memErrors do
  begin
    Left := 12;
    Top := 177;
    Width := 325;
    Height := 89;
    Show;
  end;

  chkbxPlaySound := TCrbCheckBox.Create(wnd);
  with chkbxPlaySound do
  begin
    Left := 17;
    Width := 85;
    Height := 17;
    FontName := 'Arial';
    Top := 280;
    Caption := 'Play sound: ';
    Show;
    Checked := bPlaySound;
  end;

  edtSound := TCrbEdit.Create(wnd);
  with edtSound do
  begin
    Left := 108;
    Top := 278;
    Width := 205;
    Height := 21;
    Caption := strSoundFile;
    Show;
  end;


  btnSelectSound := TCrbButton.Create(wnd);
  with btnSelectSound do
  begin
    Left := 320;
    Top := 278;
    Width := 28;
    Height := 22;
    Caption := '...';
    Show;
  end;

  chkbxLaunch := TCrbCheckBox.Create(wnd);
  with chkbxLaunch do
  begin
    Left := 82;
    Top := 305;
    Width := 199;
    Height := 17;
    FontName := 'Arial';
    Caption := 'Launch Default Email Program';
    Show;
    Checked := bLaunchEmailProg;
  end;

  edtCorbin := TCrbReadOnlyEdit.Create(wnd);
  with edtCorbin do
  begin
    Left := 46;
    Top := 327;
    Width := 275;
    Height := 21;
    FontName := 'Arial';
    Caption := 'Web - http://www.bluetreesoft.com';
    Show;
  end;

  btnOkay := TCrbButton.Create(wnd);
  with btnOkay do
  begin
    Left := 35;
    Top := 357;
    Width := 80;
    Height := 30;
    Caption := 'Okay';
    Show;
  end;

  btnCheckNow := TCrbButton.Create(wnd);
  with btnCheckNow do
  begin
    Left := 125;
    Top := 357;
    Width := 90;
    Height := 30;
    Caption := 'Check Now';
    Show;
  end;

  btnQuit := TCrbButton.Create(wnd);
  with btnQuit do
  begin
    Left := 228;
    Top := 357;
    Width := 90;
    Height := 30;
    Caption := 'Quit MailCat';
    Show;
  end;

  SetFocus(edtHost.Handle);
  // make the host not be all selected
  SendMessage(edtHost.Handle, EM_SETSEL, 0, 0);
end;

procedure OnGotMail(Sender: TObject; NumMessages: Integer);
var
  Output: string;
  var i: Integer;
begin
  Output := 'You have ' + IntToStr(NumMessages) + ' message(s) waiting.';
  SetTrayMessage(Output);
  if bPlaySound then
    PlaySound(PChar(strSoundFile), 0, SND_FILENAME or SND_NOWAIT);

  for i := 0 to MailChecker.MessageCount - 1 do
    Output := Output + CRLF + ' Message ' + IntToStr(i + 1) + CRLF +
                       '   Subject: ' + MailChecker.EmailHeaders[i].Subject + CRLF +
                       '   From: ' + MailChecker.EmailHeaders[i].From + CRLF;
  // Start the animation timer
  bGotMailAniGoing := True;
  SetTimer(MailChecker.Handle, GOT_MAIL_TIMER, 250, nil);

  // now ouput this to the memo
  memErrors.Caption := Output;
end;

procedure OnMailOutput(Sender: TObject; Output: string);
begin
  memErrors.Caption := memErrors.Caption + CRLF + Output;
  SendMessage(memErrors.handle, EM_LINESCROLL, 0, 1024);
end;

procedure OnMailError(Sender: TObject; Output: string);
begin
  bErrorOccured := True;
  if not btnCheckNow.Enabled then btnCheckNow.Enabled := True;
  SetTrayIcon(imError);
  SetTrayMessage(Output);
  memErrors.Caption := memErrors.Caption + CRLF + Output;
  SendMessage(memErrors.handle, EM_LINESCROLL, 0, 1024);
end;

procedure OnMailClose(Sender: TObject);
begin
  if not btnCheckNow.Enabled then btnCheckNow.Enabled := True;
  // do stuff when socket closed connection
  // write no new mail if none was there

  if not bErrorOccured and (MailChecker.MessageCount <= 0) then
  begin
    bGotMailAniGoing := False;
    memErrors.Caption := memErrors.Caption + CRLF + 'No mail waiting';
    SetTrayMessage('No mail waiting');    
    SetTrayIcon(imGeneral)
  end
  else if bErrorOccured then
  begin
    bGotMailAniGoing := False;
    SetTrayIcon(imError);
  end;
  // the else is that there is mail with no error...
  // meaning the OnGotMailEvent would have fired
end;

procedure OnCreate(wnd: HWND);
begin
  // load the popup menu
  hPopupMenu := LoadMenu(hInstance, 'Popmenu');
  hPopupMenu := GetSubMenu(hPopupMenu, 0);
  SetMenuDefaultItem(hPopupMenu, IDM_CHECK_NOW, 0);

  imLastMode := imGeneral;
  nTimerInterval := 20000;
  bGotMailAniGoing := False;
  bErrorOccured := False;
  // Create the MailChecker object
  MailChecker := TMailChecker.Create(wnd);

  MailChecker.OnGotMail := OnGotMail;
  MailChecker.OnMailOutput := OnMailOutput;
  MailChecker.OnError := OnMailError;
  MailChecker.OnClose := OnMailClose;
  bShowingException := False;

  // Create the shell icon stuff
  IconData.cbSize := sizeof(IconData);
  IconData.Wnd := wnd;
  IconData.uID := 1; // icon identifier; only one in app
  IconData.uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
  IconData.uCallbackMessage := ICON_MESSAGE;
  IconData.hIcon := GetIcon(imGeneral);
  StrPCopy(IconData.szTip, strAppName);

  Shell_NotifyIcon(NIM_ADD, @IconData);

  // now create the child windows
  CreateChildWindows(wnd);
  // Create the timer for checking the email
  // note that calling CreateChildWindows fills out the
  // nTimerInterval
  SetTimer(wnd, CHECK_TIMER, nTimerInterval, nil);
end;


procedure SaveSettings;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.OpenKey(cRegKey, True);
    Registry.WriteString(cRegServerName, MailChecker.Host);
    Registry.WriteString(cRegUserName, MailChecker.UserName);
    // possibly encrypt pass here
    Registry.WriteString(cRegPassword, MailChecker.Password);
    Registry.WriteString(cRegPort, IntToStr(MailChecker.Port));
    Registry.WriteString(cRegSoundFile, strSoundFile);
    Registry.WriteInteger(cRegTimeInterval, nTimerInterval);
    Registry.WriteBool(cRegFirstTime, False);
    Registry.WriteBool(cRegPlaySound, bPlaySound);
    Registry.WriteBool(cRegLaunchEmailProg, bLaunchEmailProg);
    Registry.CloseKey;
  finally
    Registry.Free;
  end;
end;

procedure OnDestroy(wnd: HWND);
begin
  // remove the tray icon

  Shell_NotifyIcon(NIM_DELETE, @IconData);

  // Kill the timer if not already killed
  KillTimer(wnd, CHECK_TIMER);
  // Save the settings to the registry
  SaveSettings;

  // Free our MailChecker Object
  MailChecker.Free;
  // Free labels
  lblTitle.Free;
  lblIncoming.Free;
  lblPort.Free;
  lblLastError.Free;
  lblAccountName.Free;
  lblPassword.Free;
  lblTimerTime.Free;

  // Free edit boxes
  edtHost.Free;
  edtSound.Free;
  edtPass.Free;
  edtPort.Free;
  edtTimerTime.Free;
  edtUser.Free;
  edtCorbin.Free;

  // Free the memo
  memErrors.Free;

  chkbxPlaySound.Free;
  chkbxLaunch.Free;

  btnCheckNow.Free;
  btnOkay.Free;
  btnQuit.Free;
  btnSelectSound.Free;

  // Tell windows we are quitting
  PostQuitMessage(0);
end;

procedure ShowException(E: Exception; wnd: HWND);
begin
  bErrorOccured := True;
  // Only show one exception at a time for this application
  if not bShowingException then
  begin
    bShowingException := True;
    MessageBox(wnd, PChar(E.Message), PChar(strAppName),
      MB_OK + MB_ICONSTOP);
    bShowingException := False;
  end;
end;

procedure CheckMail(wnd: HWND);
begin
  // generic check mail proc
  try
    if not MailChecker.Connected then
    begin
      bErrorOccured := False;
      memErrors.Caption := 'Checking mail...';
      SetTrayMessage('Checking mail...');
      SetTrayIcon(imRun1);
      SetTimer(wnd, ANIMATION_TIMER, 250, nil);
      MailChecker.Connect;
      btnCheckNow.Enabled := False;
    end;
  except
    on E: Exception do ShowException(E, wnd);
  end;
end;

procedure OnAnimationTimer(wnd: HWND);
begin
  if not MailChecker.Connected then
    KillTimer(wnd, ANIMATION_TIMER)
  else
    if imLastMode = imRun2 then
      SetTrayIcon(imRun1)
    else
      SetTrayIcon(imRun2);
end;

procedure OnMailAniTimer(wnd: HWND);
  procedure KillIt;
  begin
    KillTimer(wnd, GOT_MAIL_TIMER);
    bGotMailAniGoing := False;
  end;
begin
  if bGotMailAniGoing then
  begin
    if MailChecker.Connected then
      KillIt
    else if MailChecker.MessageCount <= 0 then
      KillIt
    else
    begin
      case imLastMode of
        imMoon1: SetTrayIcon(imMoon2);
        imMoon2: SetTrayIcon(imMoon3);
        imMoon3: SetTrayIcon(imMoon4);
        imMoon4: SetTrayIcon(imMoon5);
        imMoon5: SetTrayIcon(imMoon6);
        imMoon6: SetTrayIcon(imMoon7);
        imMoon7: SetTrayIcon(imMoon8);
      else
        SetTrayIcon(imMoon1);
      end;
    end;
  end;
end;

procedure OnTraySingleClick(wnd: HWND);
begin
  // kill the timer that called this proc
  KillTimer(wnd, DOUBLE_CLICK_TIMER);
  if bLaunchEmailProg and bGotMailAniGoing then
    // find the window of the email prog, and see if it is running
    ShellExecute(wnd, 'open', PChar(EmailProgramCommand), '', '', SW_NORMAL)
  else
    CheckMail(wnd);
  if bGotMailAniGoing then
  begin
    SetTrayIcon(imGeneral);
    bGotMailAniGoing := False;
  end;
end;

procedure OnTimer(wnd: HWND; TimerID: Cardinal);
begin
  case TimerId of
    CHECK_TIMER: CheckMail(wnd);
    ANIMATION_TIMER: OnAnimationTimer(wnd);
    GOT_MAIL_TIMER: OnMailAniTimer(wnd);
    DOUBLE_CLICK_TIMER: OnTraySingleClick(wnd);
  end;
end;

procedure FillMailCheckerSettings;
var
  nTemp: Cardinal;
begin
  MailChecker.Host := edtHost.Caption;
  MailChecker.Port := StrToInt(edtPort.Caption);
  MailChecker.UserName := edtUser.Caption;
  MailChecker.Password := edtPass.Caption;
  strSoundFile := edtSound.Caption;
  bPlaySound := chkbxPlaySound.Checked;
  bLaunchEmailProg := chkbxLaunch.Checked;
  //reset the timer if need be
  nTemp := StrToInt(edtTimerTime.Caption) * 60000;
  if nTemp <> nTimerInterval then
  begin
    nTimerInterval := nTemp;
    KillTimer(MailChecker.Handle, CHECK_TIMER);
    SetTimer(MailChecker.Handle, CHECK_TIMER, nTimerInterval, nil);
  end;

end;

procedure btnCheckNowClick(wnd: HWND);
begin
  // when this button is clicked, fill in the data in the
  // MailChecker at that moment
  FillMailCheckerSettings;
  CheckMail(wnd);
end;

procedure btnOkayClick(wnd: HWND);
begin
  // save settings
  FillMailCheckerSettings;
  SaveSettings;
  // reset the timer interval on okay

  // hide the main window
  ShowWindow(wnd, SW_HIDE);
end;

procedure btnQuitClick(wnd: HWND);
begin
  FillMailCheckerSettings;
  SendMessage(wnd, WM_CLOSE, 0, 0);
end;

procedure btnSelectSoundClick(wnd: HWND);
// show a dialog to select a sound
var
  OpenFileName: TOpenFileName;
  TempFilter: string;
  TheTitle: string;
  TheFile: string;
  Ext: string;
begin
  Ext := 'wav';
  FillChar(OpenFileName, SizeOf(TOpenFileName), 0);
  TempFilter := 'Wave Files (*.wav)'#0'*.wav'#0#0;
  SetLength(TheFile, MAX_PATH + 2);

  TheTitle := 'Find a sound file...';
  with OpenFileName do
  begin
    lStructSize := SizeOf(TOpenFileName);
    hWndOwner := wnd;
    lpstrFilter := PChar(TempFilter);
    lpstrTitle := PChar(TheTitle);
    nMaxFile := MAX_PATH;
    nFilterIndex := 1;
    lpstrFile := PChar(TheFile);
    FillChar(lpstrFile^, nMaxFile + 2, 0);
    Flags := OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST
      or OFN_HIDEREADONLY;
    lpstrDefExt := PChar(Ext);
  end;

  if GetOpenFileName(OpenFileName) then
  begin
    SetLength(TheFile, Length(PChar(TheFile)));
    edtSound.Caption := TheFile;
    strSoundFile := TheFile;
  end;
end;

function OnCommand(wnd: HWND; iMsg: UInt; wp, lp: Cardinal): LResult;
var
  SentFrom: HWND;
  wID: Word;
begin
  Result := 0;
  SentFrom := HWND(lp);
  wID := Word(wp);

  if (btnCheckNow <> nil) and (SentFrom = btnCheckNow.Handle) then
    btnCheckNowClick(wnd)
  else if (btnOkay <> nil) and (SentFrom = btnOkay.Handle) then
    btnOkayClick(wnd)
  else if (btnQuit <> nil) and (SentFrom = btnQuit.Handle) then
    btnQuitClick(wnd)
  else if (btnSelectSound <> nil) and (SentFrom = btnSelectSound.Handle) then
    btnSelectSoundClick(wnd)
  // now check for menu clicks
  else if wID = IDM_CHECK_NOW then
    CheckMail(wnd)
  else if wID = IDM_SETTINGS then
    ShowWindow(wnd, SW_NORMAL)
  else if wID = IDM_QUIT then
    SendMessage(wnd, WM_CLOSE, 0, 0)
//  else if wID = EDM_DISABLE then // add this in later
  else
    Result := DefWindowProc(wnd, iMsg, wp, lp);
end;

procedure ProcessSocketMessage(wnd: HWND; var Message: TCMSocketMessage);
begin
  try
    MailChecker.ProcessSocketMessage(Message);
  except
    on E: Exception do OnMailError(nil, E.Message);
  end;
end;

procedure ProcessSocketGetHostName(wnd: HWND; var Message: TCMGetHostName);
begin
  try
    MailChecker.ProcessGetHostNameMessage(Message);
  except
    on E: Exception do OnMailError(nil, E.Message);
  end;
end;

function OnClose(wnd: HWND; iMsg: UINT; wp: WPARAM; lp: LPARAM): LResult;
begin
  FillMailCheckerSettings;
  Result := DefWindowProc(wnd, iMsg, wp, lp);
end;

procedure OnIconDoubleClick(wnd: HWND);
begin
  // kill the single click timer
  KillTimer(wnd, DOUBLE_CLICK_TIMER);
  // the default for a double click is to show the
  // settings box

  // kill the animation if it is going
  SetTrayIcon(imGeneral);
  bGotMailAniGoing := False;

  ShowWindow(wnd, SW_NORMAL);
  SetForegroundWindow(wnd);
end;

procedure OnIconMessage(wnd: HWND; MouseMessage: Cardinal);
  function IsWindowShowing: Boolean;
  begin
    // if visible, return true
    if (GetWindowLong(wnd, GWL_STYLE) and WS_VISIBLE) = WS_VISIBLE then
    begin
      Result := True;
      SetForegroundWindow(wnd);
    end else
      Result := False;
  end;
var
  Point: TPoint;
begin
  case MouseMessage of
    WM_RBUTTONDOWN:
      begin
        if not IsWindowShowing then
        begin
          GetCursorPos(Point);
          SetForegroundWindow(wnd);
          TrackPopupMenu(hPopupMenu, 0,Point.x, Point.y, 0, wnd, nil);
        end;
      end;
    WM_LBUTTONDOWN:
      begin
        // set a timer so we don't do a single click if a double click
        // is about to happen
        if not IsWindowShowing then
          SetTimer(wnd, DOUBLE_CLICK_TIMER, GetDoubleClickTime, nil);
      end;
    WM_LBUTTONDBLCLK:
      if not IsWindowShowing then
        OnIconDoubleClick(wnd);
  end
end;

function OnSysCommand(wnd: HWND; iMsg: UINT; wp, lp: Cardinal): Cardinal;
begin
  // hide the window instead of closing the window
  if wp = SC_CLOSE then
  begin
    // simulate clicking okay button
    btnOkayClick(wnd);
    Result := 0;
  end
  else
    Result := DefWindowProc(wnd, iMsg, wp, lp);
end;

function WndProc(wnd: HWND; iMsg: UINT; wp: WPARAM; lp: LPARAM): LResult; stdcall;
var
  Message: TMessage;
begin
  Message.Msg := iMsg;
  Message.WParam := wp;
  Message.LParam := lp;

  Result := 0; // default result
	case iMsg of
		WM_CREATE:
      OnCreate(wnd);
		WM_DESTROY:
      OnDestroy(wnd);
    WM_TIMER:
      OnTimer(wnd, wp);
    WM_COMMAND:
      Result := OnCommand(wnd, iMsg, wp, lp);
    CM_SOCKETMESSAGE:
      ProcessSocketMessage(wnd, TCMSocketMessage(Message));
    CM_GETHOSTNAME:
      ProcessSocketGetHostName(wnd, TCMGetHostName(Message));
    WM_CLOSE:
      Result := OnClose(wnd, iMsg, wp, lp);
    ICON_MESSAGE:
      OnIconMessage(wnd, lp);
    WM_SYSCOMMAND:
      Result := OnSysCommand(wnd, iMsg, wp, lp);
    WM_CHAR:
      begin
        if (iMsg = WM_CHAR) and (wp = Vk_Escape) then
          // if visible, then hide
          if (GetWindowLong(wnd, GWL_STYLE) and WS_VISIBLE) = WS_VISIBLE then
            ShowWindow(wnd, SW_HIDE)
          else
            Result := DefWindowProc(wnd, iMsg, wp, lp)
        else
          Result := DefWindowProc(wnd, iMsg, wp, lp);
      end;
    else
      Result := DefWindowProc(wnd, iMsg, wp, lp);
  end;
end;

var
  wnd: HWND;
	mess: TMsg;
	wndclass: WNDCLASSEX;

begin
	wndclass.cbSize			:= sizeof(wndclass);
	wndclass.style			:= CS_HREDRAW or CS_VREDRAW;
	wndclass.lpfnWndProc	:= @WndProc;
	wndclass.cbClsExtra		:= 0;
	wndclass.cbWndExtra		:= 0;
	wndclass.hInstance		:= hInstance;
	wndclass.hIcon			:= LoadIcon(hInstance, 'MAINICON');
	wndclass.hCursor		:= LoadCursor(0, IDC_ARROW);
	wndclass.hbrBackground	:= COLOR_WINDOW;
	wndclass.lpszMenuName	:= nil;
	wndclass.lpszClassName	:= strAppName;
	wndclass.hIconSm		:= LoadIcon(hInstance, 'MAINICON');

	RegisterClassEx(wndclass);

  // Create the window smack dab in the middle
	wnd := CreateWindow(strAppName,		// Window class name
		strAppName,  					// Window caption
		WS_CLIPSIBLINGS or WS_POPUP or WS_OVERLAPPED or WS_SYSMENU	or WS_CAPTION,			// Window style
    GetSystemMetrics(SM_CXSCREEN) div 2 - (cWidth div 2),
		GetSystemMetrics(SM_CYSCREEN) div 2 - (cHeight div 2),
		cWidth,					// x size
		cHeight,					// y size
		0,							// Parent window handle
		0,							// Window menu handle
		hInstance,						// Program instance handle
		nil);							// Creation parameters

  // if first time, show window normal, else only icon
  if bFirstTime then
  begin
  	ShowWindow(wnd, SW_SHOW);
	  UpdateWindow(wnd);
  end
  else //keep it hidden
    ShowWindow(wnd, SW_HIDE);

  while GetMessage(mess, HWND(nil), 0, 0) do
	begin
		TranslateMessage(mess);
		DispatchMessage(mess);
  end;
end.

