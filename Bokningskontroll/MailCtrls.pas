unit MailCtrls;

interface
uses Windows;

type

  TMessage = packed record
    Msg: Cardinal;
    case Integer of
      0: (
        WParam: Longint;
        LParam: Longint;
        Result: Longint);
      1: (
        WParamLo: Word;
        WParamHi: Word;
        LParamLo: Word;
        LParamHi: Word;
        ResultLo: Word;
        ResultHi: Word);
  end;

  TWndProc = function(wnd: HWND; iMsg: UINT; wp: WPARAM; lp: LPARAM): Cardinal;
    stdcall;

  TCrbWinControl = class
  private
    FFont: HFONT;
    FHandle: HWND;
    FParent: HWND;
    FOldWndProc: Pointer;

    FCaption: string;
    FTop: Integer;
    FLeft: Integer;
    FWidth: Integer;
    FHeight: Integer;

    FFontHeight: Integer;
    FFontName: string;

    FEnabled: Boolean;

    function CreateFontHandle: HWND;
    procedure SetFontName(const Value: string);
    procedure SetFontSize(const Value: Integer);
    function GetFontSize: Integer;
    procedure WindowProc(var Message: TMessage);
    procedure SetEnabled(const Value: Boolean);
  protected
    function GetCaption: string; virtual;
    procedure SetCaption(const Value: string); virtual;
    procedure CreateWindow(ClassName: string; ExStyle: Cardinal;
      Style: Cardinal);
    procedure CreateWindowHandle; virtual; abstract;
  public
    constructor Create(Parent: HWND); virtual;
    destructor Destroy; override;
    property Handle: HWND read FHandle;
    procedure Show;
    property Caption: string read GetCaption write SetCaption;
    property Top: Integer read FTop write FTop;
    property Left: Integer read FLeft write FLeft;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property FontSize: Integer read GetFontSize write SetFontSize;
    property FontName: string read FFontName write SetFontName;
    property Enabled: Boolean read FEnabled write SetEnabled;
  end;

  TCrbLabel = class(TCrbWinControl)
  public
    constructor Create(Parent: HWND); override;
    destructor Destroy; override;
    procedure CreateWindowHandle; override;
  end;

  TCrbEdit= class(TCrbWinControl)
  private
    FPasswordChar: Char;
  protected
    function GetCaption: string; override;
  public
    constructor Create(Parent: HWND); override;
    destructor Destroy; override;
    procedure CreateWindowHandle; override;
    property PasswordChar: Char read FPasswordChar write FPasswordChar;
  end;

  TCrbReadOnlyEdit = class (TCrbEdit)
  public
    procedure CreateWindowHandle; override;
  end;


  TCrbMemo = class(TCrbWinControl)
  public
    constructor Create(Parent: HWND); override;
    destructor Destroy; override;
    procedure CreateWindowHandle; override;
  end;

  TCrbButton = class(TCrbWinControl)
  public
    constructor Create(Parent: HWND); override;
    procedure CreateWindowHandle; override;
  end;

  TCrbCheckBox = class (TCrbWinControl)
  private
    FChecked: Boolean;
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
  public
    constructor Create(Parent: HWND); override;
    procedure CreateWindowHandle; override;
    property Checked: Boolean read GetChecked write SetChecked;
  end;


implementation

uses SysUtils, Messages;

var
  ScreenLogPixels: Integer;

// standard window procedure. Passes it to the CrbWinControl's
// window proc
function StdWndProc(Window: HWND; iMsg: UINT; WParam: Longint;
  LParam: Longint): Longint; stdcall;
var
  CrbPointer: TCrbWinControl;
  Message: TMessage;
begin
  CrbPointer := TCrbWinControl(GetWindowLong(Window, GWL_USERDATA));
  Message.Msg := iMsg;
  Message.WParam := WParam;
  Message.LParam := LParam;
  CrbPointer.WindowProc(Message);
  Result := Message.Result;
end;

{ TCrbWinControl }

constructor TCrbWinControl.Create(Parent: HWND);
begin
  inherited Create;
  FParent := Parent;
  FOldWndProc := nil;
  FHandle := 0;
  FFont := 0;
  FTop := 0;
  FLeft := 0;
  FWidth := 100;
  FHeight := 30;
  // Create a font
  FFontName := 'MS Sans Serif';
  FontSize := 10;
  FEnabled := True;
end;

function TCrbWinControl.CreateFontHandle: HWND;
var
  LogFont: TLogFont;
begin
  FillChar(LogFont, SizeOf(LogFont), 0);
  with LogFont do
  begin
    lfHeight := FFontHeight;
    lfWidth := 0; { have font mapper choose }
    lfEscapement := 0; { only straight fonts }
    lfOrientation := 0; { no rotation }
    lfWeight := FW_NORMAL;
    lfItalic := 0;
    lfUnderline := 0;
    lfStrikeOut := 0;
    lfCharSet := 0;
    StrPCopy(lfFaceName, FFontName);
    lfQuality := DEFAULT_QUALITY;
    { Everything else as default }
    lfOutPrecision := OUT_DEFAULT_PRECIS;
    lfClipPrecision := CLIP_DEFAULT_PRECIS;
    lfPitchAndFamily := DEFAULT_PITCH;
    Result := CreateFontIndirect(LogFont);
  end
end;

procedure TCrbWinControl.CreateWindow(ClassName: string;
  ExStyle: Cardinal; Style: Cardinal);
begin
  // call create window on it
  FHandle := CreateWindowEx(ExStyle,
    PChar(ClassName), PChar(FCaption),
    Style,
    FLeft, FTop, FWidth, FHeight, FParent, 0, hInstance, nil);
  // create the font handle, if needed
  if FFont = 0 then
    FFont := CreateFontHandle;
  // now apply the font to the window
  SendMessage(FHandle, WM_SETFONT, FFont, 0);

  // save a pointer to myself in my user_data section of the class
  SetWindowLong(FHandle, GWL_USERDATA, LongInt(Self));

  // now subclass the window proc if Tab's are enabled
  if (Style and WS_TABSTOP) = WS_TABSTOP then
    FOldWndProc := Pointer(SetWindowLong(FHandle, GWL_WNDPROC, LongInt(@StdWndProc)));
end;

destructor TCrbWinControl.Destroy;
begin
  if FFont <> 0 then
    DeleteObject(FFont);
  inherited Destroy;
end;

function TCrbWinControl.GetCaption: string;
begin
  Result := FCaption;
end;

function TCrbWinControl.GetFontSize: Integer;
begin
  Result := -MulDiv(FFontHeight, 72, ScreenLogPixels)
end;

procedure TCrbWinControl.SetCaption(const Value: string);
begin
  FCaption := Value;
  if FHandle <> 0 then
    SetWindowText(FHandle, PChar(Value));
end;

procedure TCrbWinControl.SetFontSize(const Value: Integer);
begin
  FFontHeight := -MulDiv(Value, ScreenLogPixels, 72);
  if FFont <> 0 then
    DeleteObject(FFont);
  if FHandle <> 0 then
  begin
    FFont := CreateFontHandle;
    SendMessage(FHandle, WM_SETFONT, FFont, 0);
  end;
end;

procedure TCrbWinControl.SetFontName(const Value: string);
begin
  FFontName := Value;
  if FFont <> 0 then
    DeleteObject(FFont);
  if FHandle <> 0 then
  begin
    FFont := CreateFontHandle;
    SendMessage(FHandle, WM_SETFONT, FFont, 0);
  end;
end;

procedure TCrbWinControl.Show;
begin
  if FHandle = 0 then
    CreateWindowHandle;
  ShowWindow(FHandle, SW_SHOW);
end;

procedure TCrbWinControl.WindowProc(var Message: TMessage);
  procedure Default;
  begin
    with Message do
      Result := CallWindowProc(FOldWndProc, FHandle, Msg, wParam, lParam);
  end;
begin
  if (Message.Msg = WM_CHAR) and (Message.WParam = VK_TAB) then
    SetFocus(GetNextDlgTabItem(FParent, FHandle, GetKeyState(VK_SHIFT) < 0))
  else if (Message.Msg = WM_CHAR) and (Message.WParam = Vk_Escape) then
    // if visible, then hide
    if (GetWindowLong(FParent, GWL_STYLE) and WS_VISIBLE) = WS_VISIBLE then
      ShowWindow(FParent, SW_HIDE)
    else
      Default
  else if Message.Msg = WM_SETFOCUS then
  begin
    SendMessage(FHandle, EM_SETSEL, 0, -1);
    Default;
  end
  else
    Default;
end;

procedure TCrbWinControl.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    EnableWindow(FHandle, Value);
    FEnabled := Value;
  end;
end;

{ TCrbLabel }

constructor TCrbLabel.Create(Parent: HWND);
begin
  inherited Create(Parent);
  FHeight := 16;
end;

procedure TCrbLabel.CreateWindowHandle;
begin
  CreateWindow('STATIC', 0, WS_CHILD or WS_VISIBLE);
end;

destructor TCrbLabel.Destroy;
begin
  inherited Destroy;
end;

{ TCrbEdit }

constructor TCrbEdit.Create(Parent: HWND);
begin
  inherited Create(Parent);
  FPasswordChar := #0;
  FHeight := 21;
end;

procedure TCrbEdit.CreateWindowHandle;
const
  Passwords: array[Boolean] of DWORD = (0, ES_PASSWORD);
begin
  CreateWindow('EDIT', WS_EX_CLIENTEDGE	, WS_CHILD or WS_VISIBLE or
    ES_AUTOHSCROLL or ES_AUTOVSCROLL or
    Passwords[FPasswordChar <> #0] or WS_TABSTOP);
end;

destructor TCrbEdit.Destroy;
begin
  inherited Destroy;
end;


procedure InitScreenLogPixels;
var
  DC: HDC;
begin
  DC := GetDC(0);
  ScreenLogPixels := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0,DC);
end;

function TCrbEdit.GetCaption: string;
const
  BufferSize = 1024;
var
  Buffer: PChar;
begin
  if Handle = 0 then
    Result := FCaption
  else
  begin
    Buffer := AllocMem(BufferSize);
    try
      GetWindowText(FHandle, Buffer, BufferSize);
      Result := Buffer;
    finally
      FreeMem(Buffer, BufferSize);
    end;
  end;
end;

{ TCrbMemo }

constructor TCrbMemo.Create(Parent: HWND);
begin
  inherited Create(Parent);
  FHeight := 200;
end;

procedure TCrbMemo.CreateWindowHandle;
begin
  CreateWindow('EDIT', WS_EX_CLIENTEDGE, WS_CHILD or WS_VISIBLE or
    ES_AUTOVSCROLL or ES_AUTOHSCROLL or WS_VSCROLL or
    ES_MULTILINE or ES_READONLY);
end;

destructor TCrbMemo.Destroy;
begin
  inherited Destroy;
end;

{ TCrbButton }

constructor TCrbButton.Create(Parent: HWND);
begin
  inherited Create(Parent);
  FWidth := 75;
  FHeight := 25;
end;

procedure TCrbButton.CreateWindowHandle;
begin
  CreateWindow('BUTTON', WS_EX_CLIENTEDGE, WS_CHILD or WS_VISIBLE or
    BS_PUSHBUTTON or WS_TABSTOP);
end;

{ TCrbCheckBox }

constructor TCrbCheckBox.Create(Parent: HWND);
begin
  inherited Create(Parent);
  FChecked := False;
end;

procedure TCrbCheckBox.CreateWindowHandle;
begin
  CreateWindow('BUTTON', 0, WS_CHILD or WS_VISIBLE or
    BS_CHECKBOX	 or WS_TABSTOP or BS_AUTOCHECKBOX	);
end;

function TCrbCheckBox.GetChecked: Boolean;
begin
  Result := (BST_CHECKED = SendMessage(FHandle, BM_GETCHECK, 0, 0));
end;

procedure TCrbCheckBox.SetChecked(const Value: Boolean);
const
  CheckedState: array[Boolean] of Cardinal = (BST_UNCHECKED, BST_CHECKED);
begin
  if Value <> FChecked then
  begin
    FChecked := Value;
    SendMessage(FHandle, BM_SETCHECK, CheckedState[Value], 0);
  end;
end;

{ TCrbReadOnlyEdit }

procedure TCrbReadOnlyEdit.CreateWindowHandle;
begin
  CreateWindow('EDIT', WS_EX_CLIENTEDGE	, WS_CHILD or WS_VISIBLE or
    ES_AUTOHSCROLL or ES_AUTOVSCROLL or ES_READONLY );
end;

initialization
  InitScreenLogPixels;
end.


