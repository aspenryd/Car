{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13611: divutils.pas
{
{   Rev 1.1    2004-01-29 10:26:44  peter
{ Formaterat källkoden C2
}
{
{   Rev 1.0    2004-01-29 09:26:16  peter
{ 2004-01-28 : Start av version 2004
}
{
{   Rev 1.0    2003-12-29 09:30:40  hasp
}
unit divutils;

interface

uses forms, SysUtils;

type
  TLogWriter = class
  private
    FMaxRows: integer;
    FFilename: string;
    FTimeStampRows: boolean;
    FAppendMessages: boolean;
    procedure SetFilename(const Value: string);
    procedure SetMaxRows(const Value: integer);
    procedure SetTimeStampRows(const Value: boolean);
    procedure SetAppendMessages(const Value: boolean);
  public
    procedure WriteToLog(msg: string);
    property TimeStampRows: boolean read FTimeStampRows write SetTimeStampRows;
    property AppendMessages: boolean read FAppendMessages write SetAppendMessages;
    property Filename: string read FFilename write SetFilename;
    property MaxRows: integer read FMaxRows write SetMaxRows;
    constructor Create(AppendMonthToName: boolean = true);
  end;


  TFileInfoType = (dwSignature, dwStrucVersion, dwFileVersionMS, dwFileVersionLS,
    dwProductVersionMS, dwProductVersionLS, dwFileFlagsMask, dwFileFlags, dwFileOS,
    dwFileType, dwFileSubtype, dwFileDateMS, dwFileDateLS);

  TScreenResolution = (sr640x480, sr800x600, sr1024x768, sr1280x1024, sr1600x1200, srOther);


  TSystemChecker = class
  private
    function GetFileInfo(const AFileName: string;
      infoType: TFileInfoType): Cardinal;
    function QueryValue(Filename, ThisValue: string): string;
  public
    function GetColorDepth(form: TForm): integer;
    function IsBeta(filename: string): boolean;
    function IsExeRunning(filename: string): boolean;
    function GetFileVersion(filename: string): string;
    function GetCopyRightText(filename: string): string;
    function GetProductName(filename: string): string;
    function GetVersionInformation(filename, infostring: string): string;
    function GetScreenResolution(handle: integer): TScreenResolution;
  end;

  TFormHelper = class
  public
    procedure LoadFormFromRegistry(Company, Application: string; form: TForm);
    procedure SaveFormToRegistry(Company, Application: string; form: TForm);
  end;

implementation

uses classes, windows, tlhelp32, registry;

{ TLogWriter }

constructor TLogWriter.Create(AppendMonthToName: boolean = true);
begin
  FAppendMessages := false;
  FTimeStampRows := true;
  try
    if AppendMonthToName then
    begin
      FFilename := ExtractFilePath(Application.exename) + formatDatetime('mmm_', now) + ExtractFileName(Application.exename);
    end else
      FFilename := Application.exename;
    FFIlename := ChangeFileExt(FFIlename, '.log');
  except
    FFilename := '';
  end;
end;

procedure TLogWriter.SetAppendMessages(const Value: boolean);
begin
  FAppendMessages := Value;
end;

procedure TLogWriter.SetFilename(const Value: string);
begin
  FFilename := Value;
end;

procedure TLogWriter.SetMaxRows(const Value: integer);
begin
  FMaxRows := Value;
end;

procedure TLogWriter.SetTimeStampRows(const Value: boolean);
begin
  FTimeStampRows := Value;
end;

procedure TLogWriter.WriteToLog(msg: string);
var
  sl: TStringList;
  i: integer;
  saved: boolean;
begin
  if FTimeStampRows then
    msg := DateTimeTostr(now) + ' : ' + msg;
  sl := TStringList.Create;
  try
    if FileExists(FFileName) then
      sl.LoadFromFile(FFileName);
    if FMaxRows > 0 then
      for I := FMaxRows to sl.count do
        sl.Delete(i - 1);
    if FAppendMessages then
      sl.Append(msg)
    else
      sl.Insert(0, msg);
    saved := false;

    i := 0;
    while not saved do
    begin
      //Try to save log file max 10 times with 100ms interval
      //If not succeded raise exception and exit
      if i >= 10 then
      begin
        raise Exception.Create('Could not save logfile');
        break;
      end;
      try
        inc(i);
        sl.SaveToFile(FFileName);
        saved := true;
      except
        saved := false;
        sleep(100);
      end;
    end;
  finally
    sl.free;
  end;
end;


{ TSystemChecker }

function TSystemChecker.GetFileVersion(filename: string): string;
var
  v: cardinal;
  hi, lo: integer;
begin
  v := GetFileInfo(filename, dwFileVersionMS);
  if v < 0 then
  begin
    result := 'No version';
    exit;
  end else begin
    hi := HiWord(v);
    lo := Loword(v);
    result := format('%d.%d', [hi, lo]);
  end;
  v := GetFileInfo(filename, dwFileVersionLS);
  if v >= 0 then
  begin
    hi := HiWord(v);
    lo := Loword(v);
    result := result + format('.%d.%d', [hi, lo]);
  end;
end;

function TSystemChecker.QueryValue(Filename, ThisValue: string): string;
var
  VerSize: integer;
  VerBuf: PChar;
  VerBufValue: pointer;
{$IFDEF Delphi3Below}
  VerHandle: integer;
  VerBufLen: integer;
{$ELSE}
  VerHandle: cardinal;
  VerBufLen: cardinal;
{$ENDIF}
  VerKey: string;
begin
  Result := '';
  VerSize := GetFileVersionInfoSize(PChar(Filename), VerHandle);
  VerBuf := AllocMem(VerSize);
  try
    if GetFileVersionInfo(PChar(Filename), VerHandle, VerSize, VerBuf) then
      if VerQueryValue(VerBuf, '\VarFileInfo\Translation', VerBufValue, VerBufLen) then
      begin
        VerKey := '\StringFileInfo\' + IntToHex(loword(integer(VerBufValue^)), 4) +
          IntToHex(hiword(integer(VerBufValue^)), 4) + '\' + ThisValue;
        if VerQueryValue(VerBuf, PChar(VerKey), VerBufValue, VerBufLen) then
          Result := StrPas(VerBufValue);
      end;
  finally
    FreeMem(VerBuf, VerSize);
  end;
end;



function TSystemChecker.GetFileInfo(const AFileName: string; infoType: TFileInfoType): Cardinal;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := Cardinal(-1);
  // GetFileVersionInfo modifies the filename parameter data while parsing.
  // Copy the string const into a local variable to create a writeable copy.
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          case infoType of

            dwSignature: result := FI.dwSignature;
            dwStrucVersion: result := FI.dwStrucVersion;
            dwFileVersionMS: result := FI.dwFileVersionMS;
            dwFileVersionLS: result := FI.dwFileVersionLS;
            dwProductVersionMS: result := FI.dwProductVersionMS;
            dwProductVersionLS: result := FI.dwProductVersionLS;
            dwFileFlagsMask: result := FI.dwFileFlagsMask;
            dwFileFlags: result := FI.dwFileFlags;
            dwFileOS: result := FI.dwFileOS;
            dwFileType: result := FI.dwFileType;
            dwFileSubtype: result := FI.dwFileSubtype;
            dwFileDateMS: result := FI.dwFileDateMS;
            dwFileDateLS: result := FI.dwFileDateLS;
          end;
        end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

function TSystemChecker.IsExeRunning(filename: string): boolean;
var
  ContinueTest: Boolean;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  filename := ansiuppercase(ExtractFileName(filename));
  result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueTest := Process32First(FSnapshotHandle, FProcessEntry32);
  while ContinueTest do begin
    result := AnsiUpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = filename;
    if result then
      ContinueTest := False
    else
      ContinueTest := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


function TSystemChecker.GetCopyRightText(filename: string): string;
begin
  result := QueryValue(filename, 'LegalCopyright');
end;

function TSystemChecker.GetProductName(filename: string): string;
begin
  result := QueryValue(filename, 'ProductName');
end;


function TSystemChecker.GetColorDepth(form: TForm): integer;
begin
  result := Getdevicecaps(form.canvas.Handle, BITSPIXEL)
end;

function TSystemChecker.GetScreenResolution(
  handle: integer): TScreenResolution;
begin
  case screen.Width of
    640: result := sr640x480;
    800: result := sr800x600;
    1024: result := sr1024x768;
    1280: result := sr1280x1024;
    1600: result := sr1600x1200;
  else
    result := srOther;
  end;
end;

function TSystemChecker.GetVersionInformation(filename, infostring: string): string;
begin
(*
    FileVersionInfo.fCompanyName      := QueryValue('CompanyName');
    FileVersionInfo.fFileDescription  := QueryValue('FileDescription');
    FileVersionInfo.fBuildVersion     := QueryValue('BuildVersion');
    FileVersionInfo.fFileVersion      := QueryValue('FileVersion');
    FileVersionInfo.fInternalName     := QueryValue('InternalName');
    FileVersionInfo.fLegalCopyRight   := QueryValue('LegalCopyRight');
    FileVersionInfo.fLegalTradeMark   := QueryValue('LegalTradeMark');
    FileVersionInfo.fOriginalFileName := QueryValue('OriginalFileName');
    FileVersionInfo.fProductName      := QueryValue('ProductName');
    FileVersionInfo.fProductVersion   := QueryValue('ProductVersion');
    FileVersionInfo.fComments         := QueryValue('Comments');
*)
  result := QueryValue(filename, infostring);
end;

function TSystemChecker.IsBeta(filename: string): boolean;
var
  v: cardinal;
  hi, lo: integer;
const
  fl_debugbuild = 1;
  fl_prerelease = 2;
  fl_privatebuild = 8;
  fl_specialbuild = 32;
begin
  result := false;
  v := GetFileInfo(filename, dwFileFlags);
  if v < 0 then
    exit;
  result := (v and fl_prerelease) = fl_prerelease;
end;

{ TFormHelper }

procedure TFormHelper.SaveFormToRegistry(Company, Application: string;
  form: TForm);
var
  ri: TRegIniFile;
begin
  ri := TRegIniFile.create();
  try
    ri.RootKey := HKEY_CURRENT_USER;
    ri.OpenKey('software\' + company + '\' + application + '\forms', true);
    ri.WriteInteger(form.Name, 'height', form.Height);
    ri.WriteInteger(form.Name, 'width', form.width);
    ri.WriteInteger(form.Name, 'top', form.top);
    ri.WriteInteger(form.Name, 'left', form.left);
  finally
    ri.free;
  end;
end;

procedure TFormHelper.LoadFormFromRegistry(Company, Application: string;
  form: TForm);
var
  ri: TRegIniFile;
begin
  ri := TRegIniFile.create();
  try
    ri.RootKey := HKEY_CURRENT_USER;
    ri.OpenKey('software\' + company + '\' + application + '\forms', true);
    form.Height := ri.ReadInteger(form.Name, 'height', form.Height);
    form.width := ri.ReadInteger(form.Name, 'width', form.width);
    form.top := ri.ReadInteger(form.Name, 'top', form.top);
    form.left := ri.ReadInteger(form.Name, 'left', form.left);
  finally
    ri.free;
  end;
end;



end.

