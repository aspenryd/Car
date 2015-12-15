{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13155: LookOut.pas 
{
{   Rev 1.0    2003-03-20 14:03:30  peter
}
{
{   Rev 1.0    2003-03-17 10:14:24  Supervisor
}

{**
  TLookOut components
  Written by Peter Thornqvist
  Copyright © 1997 by Peter Thornqvist; all rights reserved

  Part of EQ Soft Delphi Component Pack

  Contact: support@eq-soft.se

  Status:
    Free for non-commercial use. Source and commercial license demands a fee.
    See readme.txt file for details.

  Version: 1.18

  Description:

COMPONENTS:

TLookOut - derived from TCustomControl

properties:
  ActivePage:TLookOutPage
    set this to the TLookOutPage owned by the TLookOut that you want to be
    active. You can achieve the same result by calling each TLookOutPage objects Click
    method.
  AutoSize:boolean
   if set to true, will size the TLookOutPage objects to fit inside the
   TLookOut. Note that when rezising (in design mode) you must sometimes toggle
   this property to update the onscreen image.
  Smooth:boolean;
    if true, the lookout page(s) scrolls smoothly when clicked
  ImageSize:TImageSize
    sets the ImageSize of all TLookOuts that the TLookOut is parent to if
    the TLookOuts have their ParentImageSize property set to true
  Pages[Index:integer]:TLookOutPage
    A read / write array property for the Pages currently assigned to the TLookout.
    The pages are sorted in insertion order, that is, the last page inserted is the
    last one in the array.
  PageCount:integer
    The number of pages assigned to this TLookOut.

methods:
  function AddPage:TLookOutPage
    Adds a page as the last page to the TLookOut
events:
  procedure OnClick:TNotifyEvent
    Called when the ActivePage changes

TLookOutPage - derived from TCustomControl

properties:
  AutoCenter:boolean
    if set to true, will place all owned components in the horizontal middle of
    the TLookOutPage object
  Caption:TCaption
    sets the caption of the button (default 'Outlook')
  PopUpMenu:TPopUpMenu
    specify a popupmenu to show when right-clicking the TLookOutPage
  ImageSize:TImageSize
    sets the ImageSize of all TLookOutButtons that the TLookOutPage is parent to
    if the TLookOutButtons have their ParentImageSize property set to True
  ParentImageSize:boolean;
    if set to true, sets ImageSize according to it's parent ( same
    system as with Font / ParentFont) assuming that Parent is TLookOut
  Bitmap:TBitmap:
    specifies a bitmap that is used as a background on the TLookOutPage.
    Automatically tiles, but does not scroll along with the buttons
  Buttons[Index:integer]:TLookOutButton
    Use this to access the buttons assigned to this page as an array property.
    If you want to rearrange buttons in the array, use the ExchangeButtons procedure.
  ButtonCount:integer
    The number of buttons assigned to this page.

methods:
  procedure Click
    simulates a click on the CaptionButton. Makes this TLookOutPage the active one if
    it is contained in a TLookOut
  procedure UpArrow
    simulates a click on the UpArrow
    only called if the arrowbutton is visible
  procedure DownArrow
    simulates a click on the DownArrow
    only called if the arrowbutton is visible
  function AddButton:TLookOutButton
    Adds a button to the page. The button will be placed as the bottom most button
    in the page.
  procedure ExchangeButtons(Index1,Index2:integer);
    Changes the placement in the Buttons array for buttons at Index1 and Index2. Use this
    when you want to rearrange buttons.


TLookOutButton - derived from TGraphicControl

properties:
  ButtonBorder:TButtonBorder =(bbDark,bbLight,bbMono)
    when set to bbDark, draws a darkgray / black border around the button when
    it has focus. When set to bbLight, draws a white /gray border instead
    When set to bbMono draws a white / black border
  ImageIndex:integer
    specify what image in the imagelist to display. 0 is the first image
  ImageSize:TImageSize = (isSmall,isLarge)
    when set to isLarge, the Image is displayed above the caption, else the image
    is displayed to the left of the image. Default is isLarge
  LargeImages: TImageList
    specify which ImageList to use for the isLarge state
  SmallImages: TImageList
    specify which ImageList to use for the isSmall state
  Spacing:integer
    specify how much larger than the bitmap the border is, i.e. if Spacing is set
    to 0 (zero), the buttonborder will be drawn right on the edge of the bitmap.
    A positive  value will make the border larger than the bitmap and a negative
    value will make it smaller. Default is 4.
  ImageSize:TImageSize
    sets the ImageSize of all TLookOutButtons that the TLookOutPage is parent to
    if the TLookOutButtons have their ParentImageSize property set to True
  ParentImageSize:boolean;
    if set to true, sets ImageSize according to it's parent ( same
    system as with Font / ParentFont) assuming that Parent is TLookOut

  WordWrapping for long captions (isLarge only) and ellipsises (...) when caption
  extends beyond the buttons ClientRect (this happens automatically, no properties
  to set)


TSpacer - derived from TGraphicControl

  The TSpacer component is a convenience component meant to be used when you need
  a little space between components. Just drop it were you want it and set the
  height to your liking.

  Has no methods, standard properties.


TExpress - derived from TLookOutPage
  The TExpress is a single page TLookOut that simulates the look and functionality
  of the "buttonbox" in MS Outlook Express (included with IE 4.0). It has only
  one page of buttons and "popup" arrowbuttons at the upper and lower bounds.
  The TExpress is derived from TLookOutPage and shares most of it's properties,
  but adds one by itself:

property ButtonHeight:integer (default = 60)
  All buttons in a TExpress share the same height and they always fill its entire width.
  Set the ButtonHeight of the TExpress to adjust all Children controls Height

  In addition, the TExpress do not have the AutoCenter property - it's obsolete
  as all children fill the entire width of the TExpress.

TExpressButton - same as the TLookOutButton, but has added properties:
property FillColor: TColor (default=clBtnFace)
  Specifies the color to fill the button with when the mouse enters the button.
  Setting this = clNone, will make the button transparent under all conditions.
property Offset:integer(default = 1)
  Specifies how much the button will move down and right when pressed.
  Setting this to 0 will make only the border appear pressed.
  Offset = 1 mimicks the look of all standard buttons.

  HISTORY:

July 22:

Due to changes in the way up /down arrows are implemented, they are always visible in
design mode, but will show /hide as appropriate at run-time.

Added a component editor to make it a bit easier to select and scroll the contents of
the components. Right click on any of the TLookOutPage or TLookOut components to
see a menu of things you can do. Double-clicking a TLookOutPage will make it the active
lookout if it is contained within a TLookOut. You can also select this option
from the pop-up menu ("Activate"). In addition, you can scroll the contents
of the TLookOutPage by right-clicking and selecting either "scroll up" or "scroll down".
You can also scroll the TLookOutPage contents in design mode by clicking the up/down arrows
Adding buttons and lookouts from the speed menu also works now...

July 23:

  Added the component editor. Rewrote the scrolling code (simpler, nicer, better working).
  Added Smooth property to TLookOutPage. Not altogether pleased. Will work more on this.
  Added popupmenu to TLookOutButtons and TLookOutPage.
  Added ImageSize and ParentImageSize properties.
  Added Bitmap property.
     
July 29:

  Added HiLiteFont property to TLookOutPage and TLookOutButton.
  The font used changes to HiLiteFont when the mouse enters the button
  Set to the same as Font as default.

August 1:

  Changed the name of all components. See rename.txt for details.

  Added (protected) FillColor and Offset to TLookOutButton

  If FillColor (default = clNone) is not clNone, the background will be
  filled with the specified color and the border will be drawn around
  the edge of the button. Otherwise it will stay transparent.

  Offset (default = 0) specifies the amount the button (incl. image and text)
  moves down and to the left when the button is pressed. The default for
  the standard lookout is to not move at all, but the TExpressButton
  use the standard offset -  1.

  Derived TExpressButton and set the properties to mimick an
  Outlook Express button. Only needed a constructor implementation (9 lines of code)
  to set it up. Sometimes OOP can be very simple...

  ( You could also move the new properties from the protected to the published
  field of TOutlookButton. If you have this source, no one is going to stop you. )

August 4:
  Finished the (first) implementation of TExpress - an Outlook
  Express work and look-alike. Doesn't (yet) scroll quite like
  the Outlook Express, but I'll fix that (real) soon. Also added a component
  editor similar to the other ones.

  Added the bbMono type to TButtonBorder: bbMono is a border with
  white top and black bottom (in the default Windows color scheme).

August 18:
  Added ShowPressed (boolean) property to TLookOutPage:
  When true, Pagebutton appears pressed when, uh... pressed.

  Rewrote CalcArrows and ScrollChildren (changed declaration of this too) procedures
  so it's now possible to rearrange buttons at designtime (at last!).
  Did some (small) fixes to the drag events.
  Changed the Buttons popupmenu implementation so the popup's PopupComponent
  property gets set properly (bug reported by Andrew Jackson).

  Added AutoRepeat property to TLookOutPage. set to true to make the arrowbuttons
  autoclick within intervall TimeDelay (=100). Initial delay is controlled by
  InitTime(=400). NOTE: This uses a timer (actually two), so if you're concerned
  with preservation of system resources don't use AutoRepeat. The timer(s) are only
  active while the button is down, so the penalty shouldn't be too severe, but it
  might get noticeable.

August 23
  Added EditCaption method to TLookOutPage: allows you to edit the caption of the
  page alá Outlook - shows a TEdit to write new text into. Pressing ESC or clicking with
  the mouse outside the TEdit will discards the changes, pressing Enter keeps them.

  Added speedkey handling (Alt+Letter) to Page and Button (thanks to Davendra Patel)

September 3:
  Added EnableAdjust and DisableAdjust methods to TLookOutPage: calling DisableAdjust
  disables scrolling until a matching call to EnableAdjust is made. Use this if
  you add components to the page at runtime but they don't appear in increasing
  order, i.e. the first button loaded might be the last one in the page. 

September 9:
  Rewrote the Paint code for TLookOutButtons: mainly broke out the frame painting
  to minimize flicker on Enter / Exit and when clicking the button (offset = 0).

Februari 6 (1998):
  Added Pages, PageCount properties and AddPage function to TLookOut
  Added Buttons,ButtonCount properties and AddButton,ExchangeButtons function to TLookOutPage
Februari 16:
  Added Data (a pointer) property to TExpressButton and TLookOutButton. Use it to
  store your own Data in a button.
  Changed the text drawing for ImageSize = isSmall so the frame doesn't overwrite
  text.
  Changed DrawTextEx to DrawText. I wasn't using the last parameter anyway and
  DrawTextEx doesn't work on NT 3.51.
April 29:
  Added EditCaption to TCustomLookoutButton.
  Added OnEdited events to TCustomLookoutButton and to TLookoutPage
May 6: Version 1.18
  Added GroupIndex to TLookoutbutton and TExpressButton. Works like TSpeedButton
  but without the AllowAllUp property (always allows)
June 10:
  Added FlatButtons property to TLookout: now you can display the top buttons on
  the pages with the new flat style as seen in Outlook 98.
  Rewrote NC paint code a little.
  Small change to TExpress ButtonHeight handler.
August 5:
  Added defines to work w. Delphi 4
October 29:
  Fixed bug in AddButton. The buttons appeared in random order if several buttons
  were added at once. The buttons never got a chance to realign before the next button
  was added. Now Top is forced to (or at least close to) the correct value at creation.

  (OutEdit.pas):
    Added "AddPage" to the LookOutPage Component Editor so it's now easier to add
    several pages to the TLookout at designtime without havinf to rearrange the existing
    ones to get access to the TLookout

}

unit LookOut;

{$IFNDEF WIN32} Lookout is for Win32 only! {$ENDIF}
interface
{$I VER.INC }
uses
  Windows, Messages, SysUtils, Forms, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Buttons, Menus {$IFDEF D4_AND_UP },ImgList, ActnList{$ENDIF};

const
  CM_IMAGESIZECHANGED = CM_BASE + 100;
  CM_LEAVEBUTTON = CM_BASE + 101;
  CM_LOOKOUTBUTTONPRESSED = CM_BASE + 102;

type
  TImageSize = (isSmall,isLarge);
  TButtonBorder =(bbDark,bbLight,bbMono);


  TSpacer = class(TGraphicControl)
  protected
    procedure Paint;override;
  public
    constructor Create(AOwner:TComponent); override;
  published
    property Align;
  end;

  TUpArrowBtn = class(TSpeedButton)
  private
    FTimer:TTimer;
    FAutoRepeat,FDown,FFlat,FInsideButton:boolean;
    procedure SetFlat(Value:boolean);
    procedure CmDesignHitTest(var Message:TCmDesignHitTest);message CM_DESIGNHITTEST;
    procedure CMMouseEnter(var Message:TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message:TMessage); message CM_MOUSELEAVE;
  protected
    procedure OnTime(Sender:TObject);virtual;
    procedure Paint;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    procedure Click;override;
    constructor Create(AOwner:TComponent);override;
  published
    property Flat:boolean read FFlat write SetFlat default False;
    property AutoRepeat:boolean read FAutoRepeat write FAutoRepeat default True;
  end;

  TDownArrowBtn = class(TUpArrowBtn)
  protected
    procedure Paint;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure OnTime(Sender:TObject);override;
  public
    constructor Create(AOwner:TComponent);override;
  end;

  TLookoutEditedEvent = procedure (Sender:TObject;var Caption:string) of object;
  TCustomLookOutButton = class(TGraphicControl)
  private
    FEdit:TEdit;
    FData           :Pointer;
    FPImSize        :boolean;
    FInsideButton   :boolean;
    FDown           :boolean;
    FStayDown       :boolean;
    FCentered       :boolean;
    FImageIndex     :integer;
    FSpacing        :integer;
    FOffset         :integer;
    FImageSize      :TImageSize;
    FImageRect      :TRect;
    FTextRect       :TRect;
    FFillColor      :TColor;
    FHiFont         :TFont;
    FButtonBorder   :TButtonBorder;
    FPopUpMenu      :TPopUpMenu;
    FCaption        :TCaption;
    FGroupIndex     :integer;
    FSmallImages    :TImageList;
    FLargeImages    :TImageList;
    FOnEdited       :TLookoutEditedEvent;
    FLargeImageChangeLink:TChangeLink;
    FSmallImageChangeLink:TChangeLink;
    FMouseEnter:TNotifyEvent;
    FMouseExit:TNotifyEvent;
    procedure SetGroupIndex(Value:integer);
    procedure UpdateExclusive;
    procedure SetCentered(Value:boolean);
    procedure SetDown(Value:boolean);
    procedure SetOffset(Value:integer);
    procedure SetFillColor(Value:TColor);
    procedure SetHiFont(Value:TFont);
    procedure SetSpacing(Value:integer);
    procedure SetPImSize(Value:boolean);
    procedure SetButtonBorder(Value:TButtonBorder);
    procedure SetCaption(Value:TCaption);
    procedure SetSmallImages(Value:TImageList);
    procedure SetLargeImages(Value:TImageList);
    procedure SetImageIndex(Value:integer);
    procedure SetImageSize(Value:TImageSize);
    procedure DrawSmallImages;
    procedure DrawLargeImages;
    procedure ImageListChange(Sender: TObject);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMButtonPressed(var Message: TMessage); message CM_LOOKOUTBUTTONPRESSED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMParentImageSizeChanged(var Message:TMessage);message CM_IMAGESIZECHANGED;
    procedure CMLeaveButton(var Msg:TMessage);message CM_LEAVEBUTTON;
    procedure WMEraseBkgnd(var M : TWMEraseBkgnd);message WM_ERASEBKGND;
  protected
    procedure DoOnEdited(var Caption:string);virtual;
    procedure EditKeyDown(Sender: TObject; var Key: Char);
    procedure EditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
       X, Y: Integer);
    procedure PaintFrame;virtual;
    procedure SetParent(AParent: TWinControl);override;
    procedure Paint;override;
    procedure MouseEnter;virtual;
    procedure MouseExit;virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    property FillColor:TColor read FFillColor write SetFillColor default clNone;
    property Offset:integer read FOffset write SetOffset default 0;
    property ButtonBorder:TButtonBorder read FButtonBorder write SetButtonBorder default bbDark;
    property Caption:TCaption read FCaption write SetCaption;
    property Centered:boolean read FCentered write SetCentered;
    property Down:boolean read FStayDown write SetDown default False;
    property HiLiteFont:TFont read FHiFont write SetHiFont;
    property ImageIndex:integer read FImageIndex write SetImageIndex;
    property ImageSize:TImageSize read FImageSize write SetImageSize default isLarge;
    property ParentImageSize:boolean read FPImSize write SetPImSize default True;
    property PopUpMenu:TPopUpMenu read FPopUpMenu write FPopUpMenu;
    property LargeImages:TImageList read FLargeImages write SetLargeImages;
    property Spacing:integer read FSpacing write SetSpacing default 4; { border offset from bitmap }
    property SmallImages:TImagelist read FSmallImages write SetSmallImages;
    property Data:Pointer read FData write FData;
    property GroupIndex:integer read FGroupIndex write SetGroupIndex default 0;
    property OnEdited:TLookoutEditedEvent read FOnEdited write FOnEdited;
    {$IFDEF D4_AND_UP }
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);override;
    {$ENDIF }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Click; override;
    procedure Assign(Source:TPersistent);override;
    procedure EditCaption;
  published

    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Height default 60;
    property Left;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Top;
    property Visible;
    property Width default 60;
    property OnMouseEnter:TNotifyEvent read FMouseEnter write FMouseEnter;
    property OnMouseExit:TNotifyEvent read FMouseExit write FMouseEXit;
    property OnClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    {$IFDEF D4_AND_UP }
    property Action;
    property Anchors;
    property Constraints;
    property BiDiMode;
    property ParentBiDiMode;
    property DragKind;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
  end;

  TLookOutButton = class(TCustomLookOutButton)
  public
    property Data;
  published
    property ButtonBorder;
    property Caption;
    property Down;
    property GroupIndex;
    property HiLiteFont;
    property ImageIndex;
    property ImageSize;
    property ParentImageSize;
    property PopUpMenu;
    property LargeImages;
    property Spacing;
    property SmallImages;
    property OnEdited;
  end;

  TExpressButton = class(TCustomLookOutButton)
  public
    constructor Create(AOwner:TComponent);override;
    property Data;
  published
    property Down;
    property FillColor default clBtnFace;
    property GroupIndex;
    property Offset default 1;
    property ButtonBorder default bbLight;
    property Caption;
    property HiLiteFont;
    property ImageIndex;
    property ImageSize;
    property ParentImageSize;
    property PopUpMenu;
    property LargeImages;
    property Spacing;
    property SmallImages;
    property OnEdited;
  end;


  TLookOut = class;
  TLookOutPage = class(TCustomControl)
  private
    { Private declarations }
    FEdit:TEdit;
    FAutoRepeat,FAutoCenter,FPImSize,FInsideButton,FDown,FShowPressed:boolean;
    FMargin,FTopControl:integer;
    FPopUpMenu:TPopUpMenu;
    FOnClick:TNotifyEvent;
    FDwnArrow:TDownArrowBtn;
    FScrolling:integer;
    FUpArrow:TUpArrowBtn;
    FCaption:TCaption;
    FBitmap:TBitmap;
    FImageSize:TImageSize;
    FManager:TLookOut;
    FOnCollapse:TNotifyEvent;
    FHiFont:TFont;
    FButtons:TList;
    FActiveButton:TCustomLookOutButton;
    FOnEdited       :TLookoutEditedEvent;
    procedure SetActiveButton(Value:TCustomLookOutButton);
    procedure EditMouseDown(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState;X, Y: Integer);
    procedure EditKeyDown(Sender: TObject; var Key: Char);
    procedure SetAutoRepeat(Value:boolean);
    procedure SetHiFont(Value:TFont);
    procedure SetImageSize(Value:TImageSize);
    procedure SetPImSize(Value:boolean);
    procedure SetBitmap(Value:TBitmap);
    procedure SetCaption(Value:TCaption);
    procedure SetMargin(Value:integer);
    procedure SetButton(Index:integer;Value:TLookOutButton);
    function  GetButton(Index:integer):TLookOutButton;
    function  GetButtonCount:integer;
    procedure SetAutoCenter(Value:boolean);
    function  IsVisible(Control:TControl):boolean;
    procedure CMDialogChar(var Message: TCMDialogChar);message CM_DIALOGCHAR;
    procedure CMMouseLeave(var Message: TMessage);message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMEraseBkGnd(var Message:TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CMParentImageSizeChanged(var Message: TMessage); message CM_IMAGESIZECHANGED;
    procedure TileBitmap;
  protected
    { Protected declarations }
    procedure DoOnEdited(var Caption:string);virtual;
    procedure UpArrowClick(Sender:TObject);virtual;
    procedure DownArrowClick(Sender:TObject);virtual;
    procedure DrawTopButton; virtual;
    procedure CalcArrows;virtual;
    procedure ScrollChildren(Start:word);virtual;
    procedure AlignControls(Control:TControl;var Rect:TRect);override;
    procedure SetParent(AParent: TWinControl);override;
    procedure CreateWnd;override;
    procedure SmoothScroll(aControl:TControl;NewTop,Intervall:integer;Smooth:boolean);virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint;override;
  public
    { Public declarations }
    procedure Click;override;
    procedure DownArrow;
    procedure UpArrow;
    function AddButton:TLookOutButton;
    procedure ExchangeButtons(Button1,Button2:TCustomLookOutButton);virtual;
    procedure EditCaption;virtual;
    procedure DisableAdjust;
    procedure EnableAdjust;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Buttons[Index:integer]:TLookOutButton read GetButton write SetButton;
    property ButtonCount:integer read GetButtonCount;
    property ActiveButton:TCustomLookOutButton read FActiveButton write SetActiveButton;
  published
    { Published declarations }
    property Align;
    property AutoRepeat:boolean read FAutoRepeat write SetAutoRepeat default False;
    property Bitmap:TBitmap read FBitmap write SetBitmap;
    property AutoCenter: boolean read FAutoCenter write SetAutoCenter default False;
    property ImageSize:TImageSize read FImageSize write SetImageSize default isLarge;
    property HiLiteFont:TFont read FHiFont write SetHiFont;
    property ParentImageSize:boolean read FPImSize write SetPImSize default True;
    property ShowPressed:boolean read FShowPressed write FShowPressed default False;
    property Caption:TCaption read FCaption write SetCaption;
    property Color;
    property DragCursor;
    property DragMode;
    property ShowHint;
    property Visible;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopUpMenu:TPopUpMenu read FPopUpMenu write FPopUpMenu;
    property Left;
    property Top;
    property Width;
    property Height;
    property Cursor;
    property Hint;
    property Margin:integer read FMargin write SetMargin default 0;
    property OnEdited:TLookoutEditedEvent read FOnEdited write FOnEdited;
    property OnClick:TNotifyEvent read FOnClick write FOnClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    {$IFDEF D4_AND_UP }
    property Anchors;
    property Constraints;
    property BiDiMode;
    property ParentBiDiMode;
    property DragKind;
    property OnEndDock;
    property OnStartDock;

    { only for containers: }
    property DockSite;
    property UseDockManager;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnGetSiteInfo;
    {$ENDIF}
  end;


  TLookOut = class(TCustomControl)
  private
    FAutoSize,FScroll,FCollapsing:boolean;
    FBorderStyle:TBorderStyle;
    FOnCollapse,FOnClick:TNotifyEvent;
    FActivePage,FCurrentPage:TLookOutPage;
    FPages:TList;
    FImageSize:TImageSize;
    FFlatButtons:boolean;
    procedure SetImageSize(Value:TImageSize);
    procedure SetBorderStyle(Value:TBorderStyle);
    procedure SetAutoSize(Value:boolean);
    procedure UpdateControls;
    procedure DoCollapse(Sender:TObject);
    procedure SetActiveOutLook(Value:TLookOutPage);
    function GetActiveOutlook:TLookOutPage;
    function GetPageCount:integer;
    function GetPage(Index:integer):TLookOutPage;
    procedure SetPage(Index:integer;Value:TLookOutPage);
    procedure SetFlatButtons(Value:boolean);
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
  protected
    procedure SmoothScroll(aControl:TControl;NewTop,Intervall:integer;Smooth:boolean);virtual;
    procedure Paint;override;
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function AddPage:TLookOutPage;
    property Pages[Index:integer]:TLookOutPage read GetPage write SetPage;
    property PageCount:integer read GetPageCount;
  published
    property ActivePage:TLookOutPage read GetActiveOutlook write SetActiveOutlook;
    property Align;
    property AutoSize:boolean read FAutoSize write SetAutoSize default false;
    property BorderStyle:TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color default clBtnShadow;
    property FlatButtons:boolean read FFlatButtons write SetFlatButtons default false;
    property DragCursor;
    property DragMode;
    property ImageSize:TImageSize read FImageSize write SetImageSize default isLarge;
    property ShowHint;
    property Smooth:boolean read FScroll write FScroll default False;
    property Visible;
    property Enabled;
    property Left;
    property Top;
    property Width default 92;
    property Height default 300;
    property Cursor;
    property Hint;
    property OnClick:TNotifyEvent read FOnClick write FOnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    {$IFDEF D4_AND_UP }
    property Anchors;
    property Constraints;
    property BiDiMode;
    property ParentBiDiMode;
    property DragKind;
    property OnEndDock;
    property OnStartDock;

    { only for containers: }
    property DockSite;
    property UseDockManager;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnGetSiteInfo;
    {$ENDIF}
  end;

  TExpress = class(TLookOutPage)
  private
    FBorderStyle:TBorderStyle;
    FButtonHeight:integer;
    procedure SetButtonHeight(Value:integer);
  protected
    procedure CalcArrows;override;
    procedure ScrollChildren(Start:word);override;
    procedure DrawTopButton; override;
    procedure Paint;override;
    procedure CreateWnd;override;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
  public
    constructor Create(AOwner:TComponent);override;
    function AddButton:TExpressButton;
  published
    property AutoCenter: boolean read FAutoCenter;
    property ButtonHeight:integer read FButtonHeight write SetButtonHeight default 60;
    property ImageSize default isLarge;
  end;

procedure Register;  

implementation

const
  ScrollSpeed = 20;
  bHeight     = 19;
  InitTime    = 400;
  TimeDelay   = 120;

procedure Register;
begin
  RegisterComponents('EQ', [TExpress, TLookOut, TLookOutPage, TExpressButton]);
end;

{ utility }

{ this creates a correctly masked bitmap - for use with D2 TImageList }
{
procedure CreateMaskedImageList(ImageList:TImageList);
var Bmp:TBitmap;i:integer;
begin
  Bmp := TBitmap.Create;
  Bmp.Width := ImageList.Width;
  Bmp.Height := ImageList.Height;
  try
    for i := 0 to ImageList.Count - 1 do
    begin
      ImageList.GetBitmap(i,Bmp);
      ImageList.ReplaceMasked(i,Bmp,Bmp.TransparentColor);
    end;
  finally
    Bmp.Free;
  end;
end;
}

{ returns number of visible children }
{
function NoOfVisibles(Control:TWinControl):integer;
var R:TRect;i:integer;
begin
  R := Control.ClientRect;
  Result := 0;
  if (Control = nil) then
    Exit;
  for i := 0 to Control.ControlCount - 1 do
     if (PtInRect(R,Point(R.Left + 1,Control.Controls[i].Top)) and
       PtInRect(R,Point(R.Left + 1,Control.Controls[i].Top + Control.Controls[i].Height)))  then
         Inc(Result);
end;
}

{
function IMax(Val1,Val2:integer):integer;
begin
  Result := Val1;
  if Val2 > Val1 then
    Result := Val2;
end;

function IMin(Val1,Val2:integer):integer;
begin
  Result := Val1;
  if Val2 < Val1 then
    Result := Val2;
end;
}

{ returns Atleast if Value < AtLeast, Val1 otherwise }
{
function IAtLeast(Value,AtLeast:integer):integer;
begin
  Result := Value;
  if Value < AtLeast then
    Result := AtLeast;
end;
}


{ TLookOutEdit }

type
  TLookOutEdit=class(TEdit)
  private
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  end;

procedure TLookOutEdit.CMExit(var Message: TCMExit);
begin
  Visible := False;
end;

{ TSpacer }

constructor TSpacer.Create(Aowner:TComponent);
begin
  inherited Create(AOwner);
  SetBounds(0,0,80,10);
end;

procedure TSpacer.Paint;
begin
  if csDesigning in ComponentState then
  begin
    with Canvas do
    begin
      Brush.Color := clBlack;
      FrameRect(GetClientRect);
    end;
  end;
end;


{ TUpArrowBtn }
constructor TUpArrowBtn.Create(AOwner:TComponent);
var FSize:word;
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csSetCaption,csOpaque];
  ParentColor := True;
  FDown := False;
  FInsideButton := False;
  FAutoRepeat := False;
  FFlat := False;
  FSize := GetSystemMetrics(SM_CXVSCROLL);
  SetBounds(0,0,FSize,FSize);
end;

procedure TUpArrowBtn.SetFlat(Value:boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TUpArrowBtn.CMMouseEnter(var Message:TMessage);
begin
  if not FInsideButton then
  begin
    FInsideButton := True;
    if FFlat then Invalidate;
  end;
end;

procedure TUpArrowBtn.CMMouseLeave(var Message:TMessage);
begin
  if FInsideButton then
  begin
    FInsideButton := False;
  //  FDown := False;
    if FFlat then Invalidate;
  end;
end;

procedure TUpArrowBtn.CmDesignHitTest(var Message:TCmDesignHitTest);
begin
  Message.Result := 0;
end;


procedure TUpArrowBtn.Paint;
var Flags:integer;R:TRect;
begin
  R := GetClientRect;

  if FDown then Flags := DFCS_PUSHED else Flags := 0;
  if not Enabled then Flags := Flags or DFCS_INACTIVE;

  if FFlat and not FInsideButton then
  begin
    Flags := Flags or DFCS_FLAT;
    OffsetRect(R,0,-2);
  end;

  if FFlat then InflateRect(R,1,1);
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := Color;
  DrawFrameControl(Canvas.Handle,R,DFC_SCROLL,DFCS_SCROLLUP or Flags);

  if FFlat and FInsideButton then
  begin
    R := GetClientRect;

    if FDown then
      Frame3d(Canvas,R,clBlack,clWhite,1)
    else
      Frame3d(Canvas,R,clWhite,clBlack,1);
  end;
end;

procedure TUpArrowBtn.Click;
begin
  if Enabled then
  begin
    inherited Click;
    ReleaseCapture;
    if Assigned(Parent) then
      Parent.Invalidate
    else
      Invalidate;
  end;
end;

procedure TUpArrowBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDown := True;
  inherited MouseDown(Button, Shift, X, Y);
  if Parent is TLookOutPage then
    FAutoRepeat := TLookOutPage(Parent).AutoRepeat;
  if FAutoRepeat then
  begin
    if not Assigned(FTimer) then FTimer := TTimer.Create(self);
    with FTimer do
    begin
      OnTimer := OnTime;
      Interval := InitTime;
      Enabled := True;
    end;
  end;
  Repaint;
end;

procedure TUpArrowBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Assigned(FTimer) then
  begin
    FTimer.Free;
    FTimer := nil;
  end;
  FDown := False;
  (Parent as TLookOutPage).UpArrowClick(self);
end;

procedure TUpArrowBtn.OnTime(Sender:TObject);
var R:TRect;
begin
  FTimer.Interval := TimeDelay;
  if FDown and MouseCapture and Visible then
  begin
    (Parent as TLookOutPage).UpArrowClick(self);
    R := Parent.ClientRect;
    R := Rect(R.Left,R.Top+Top,R.Right,R.Top + bHeight);
    InvalidateRect(Parent.Handle,@R,False);
    Parent.Update;
  end;
end;

{ TDownArrowBtn }

constructor TDownArrowBtn.Create(AOwner:TComponent);
var FSize:word;
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csSetCaption,csOpaque];
  ParentColor := True;
  FDown := False;
  FInsideButton := False;
  FFlat := False;
  FSize := GetSystemMetrics(SM_CXVSCROLL);
  SetBounds(0,0,FSize,FSize);
end;

procedure TDownArrowBtn.Paint;
var Flags:integer;R:TRect;
begin
  R := GetClientRect;
  if FDown then Flags := DFCS_PUSHED else Flags := 0;
  if not Enabled then Flags := Flags or DFCS_INACTIVE;
  if FFlat and not FInsideButton then
  begin
    Flags := Flags or DFCS_FLAT;
    OffsetRect(R,0,2);
  end;

  if FFlat then InflateRect(R,1,1);
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := Color;

  DrawFrameControl(Canvas.Handle,R,DFC_SCROLL,DFCS_SCROLLDOWN or Flags);

  if FFlat and FInsideButton then
  begin
    R := GetClientRect;
    if FDown then
      Frame3d(Canvas,R,clBlack,clBtnShadow,1)
    else
      Frame3d(Canvas,R,clWhite,clBlack,1);
  end;
end;

procedure TDownArrowBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDown := True;
  inherited MouseDown(Button, Shift, X, Y);
  if Parent is TLookOutPage then
    FAutoRepeat := TLookOutPage(Parent).AutoRepeat;
  if FAutoRepeat then
  begin

    if not Assigned(FTimer) then FTimer := TTimer.Create(self);
    with FTimer do
    begin
      OnTimer := OnTime;
      Interval := InitTime;
      Enabled := True;
    end;
  end;
  Repaint;
end;

procedure TDownArrowBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
//  inherited MouseUp(Button, Shift, X, Y);
  if Assigned(OnMouseUp) then OnMouseUp(self,Button,Shift,X,y);
  FDown := False;
  (Parent as TLookOutPage).DownArrowClick(self);
//  Parent.ScrollBy(0,-50);
  if Assigned(FTimer) then
  begin
    FTimer.Free;
    FTimer := nil;
  end;
  Repaint;
end;


procedure TDownArrowBtn.OnTime(Sender:TObject);
var R:TRect;
begin
  FTimer.Interval := TimeDelay;
  if FDown and MouseCapture and Visible then
  begin
    (Parent as TLookOutPage).DownArrowClick(self);
    R := Parent.ClientRect;
    R := Rect(R.Left,R.Bottom-bHeight,R.Right,R.Bottom);
    InvalidateRect(Parent.Handle,@R,False);
    Parent.Update;
  end;
end;


{ TCustomLookOutButton }

constructor TCustomLookOutButton.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse,csClickEvents];
  FButtonBorder := bbDark;
  FPImSize := True;
  FImageSize := isLarge;
  FFillColor := clNone;
  FSpacing := 4;
  FOffset := 0;
  FStayDown := False;
  FHiFont := TFont.Create;
  FHiFont.Assign(Font);
  Width := 60;
  Height := 60;
  FLargeImageChangeLink := TChangeLink.Create;
  FSmallImageChangeLink := TChangeLink.Create;
  FLargeImageChangeLink.OnChange := ImageListChange;
  FSmallImageChangeLink.OnChange := ImageListChange;
end;

destructor TCustomLookOutButton.Destroy;
begin
  if Assigned(FEdit) then FEdit.Free;
  FLargeImageChangeLink.Free;
  FSmallImageChangeLink.Free;
  FHiFont.Free;
  inherited Destroy;
end;

procedure TCustomLookOutButton.Click;
begin
  inherited Click;
end;


procedure TCustomLookOutButton.EditCaption;
begin
  if not Assigned(FEdit) then
  begin
    FEdit := TLookOutEdit.Create(nil);
    FEdit.Parent := self.Parent;
    FEdit.Visible := false;
  end;

  FEdit.SetBounds(Left + FTextRect.Left,Top + FTextRect.Top,
    Width,FTextRect.Bottom - FTextRect.Top);
  with FEdit do
  begin
    Text := FCaption;
    BorderStyle := bsNone;
    AutoSelect := True;
    OnKeyPress := EditKeydown;
    OnMouseDown := EditMouseDown;
    if not Visible then
      Show;
    SetFocus;
    SetCapture(FEdit.Handle);
    SelStart := 0;
    SelLength := Length(FCaption);
  end;
end;

procedure TCustomLookOutButton.DoOnEdited(var Caption:string);
begin
  if Assigned(FOnEdited) then FOnEdited(self,Caption);
end;

procedure TCustomLookOutButton.EditKeyDown(Sender: TObject; var Key: Char);
var aCaption:string;Modify:boolean;
begin
  Modify := False;
  if (Sender = FEdit) then
  case Key of
    #13:
    begin
      aCaption := FEdit.Text;
      DoOnEdited(aCaption);
      FEdit.Text := aCaption;
      Key := #0;
      Modify := True;
      if FEdit.Handle = GetCapture then
        ReleaseCapture;
      FEdit.Hide;
      FEdit.Free;
      FEdit := nil;  
      Screen.Cursor := crDefault;
    end;
    #27:
    begin
      Key := #0;
      if FEdit.Handle = GetCapture then
        ReleaseCapture;
      FEdit.Hide;
      FEdit.Free;
      FEdit := nil;
      Screen.Cursor := crDefault;
    end;
  end; { case }
  if Modify then
    FCaption := aCaption;
end;

procedure TCustomLookOutButton.EditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
X, Y: Integer);
begin
  if Assigned(FEdit) then
  begin
    if not PtInRect(FEdit.ClientRect,Point(X,Y)) or ((Button = mbRight) and FEdit.Visible) then
    begin
      if FEdit.Handle = GetCapture then
        ReleaseCapture;
      Screen.Cursor := crDefault;
      FEdit.Hide;
      FEdit.Free;
      FEdit := nil;
    end
    else
    begin
      ReleaseCapture;
      Screen.Cursor := crIBeam;
      SetCapture(FEdit.Handle);
    end;
  end;
end;

procedure TCustomLookOutButton.Assign(Source:TPersistent);
begin
  if Source is TCustomLookOutButton then
  begin
    Offset := TCustomLookOutButton(Source).Offset;
    Height := TCustomLookOutButton(Source).Height;
    Width := TCustomLookOutButton(Source).Width;
    ButtonBorder := TCustomLookOutButton(Source).ButtonBorder;
    Caption := TCustomLookOutButton(Source).Caption;
    Centered := TCustomLookOutButton(Source).Centered;
    Down := TCustomLookOutButton(Source).Down;
    Font := TCustomLookOutButton(Source).Font;
    HiLiteFont := TCustomLookOutButton(Source).HiLiteFont;
    ParentImageSize := TCustomLookOutButton(Source).ParentImageSize;
    ImageSize := TCustomLookOutButton(Source).ImageSize;
    ImageIndex := TCustomLookOutButton(Source).ImageIndex;
    LargeImages := TCustomLookOutButton(Source).LargeImages;
    SmallImages := TCustomLookOutButton(Source).SmallImages;
    Spacing := TCustomLookOutButton(Source).Spacing;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TCustomLookOutButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, FCaption) and Enabled then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TCustomLookOutButton.SetGroupIndex(Value:integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomLookOutButton.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_LOOKOUTBUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

procedure TCustomLookOutButton.SetCentered(Value:boolean);
begin
  if FCentered <> Value then
  begin
    FCentered := Value;
    Repaint;
  end;
end;

procedure TCustomLookOutButton.SetDown(Value:boolean);
begin
  if FStayDown <> Value then
  begin
    FStayDown := Value;
    if FStayDown then
    begin
      FInsideButton := True;
      FDown := True;
    end
    else
      FDown := False;
    if FStayDown then UpdateExclusive;
    Invalidate;
  end;
end;

procedure TCustomLookOutButton.SetOffset(Value:integer);
begin
  if FOffset <> Value then
    FOffset := Value;
end;

procedure TCustomLookOutButton.SetCaption(Value:TCaption);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TCustomLookOutButton.SetButtonBorder(Value:TButtonBorder);
begin
  if FButtonBorder <> Value then
  begin
    FButtonBorder := Value;
    Invalidate;
  end;
end;

procedure TCustomLookOutButton.SetSmallImages(Value:TImageList);
begin
  if FSmallImages <> nil then
    FSmallImages.UnRegisterChanges(FSmallImageChangeLink);
  FSmallImages := Value;

  if FSmallImages <> nil then
    FSmallImages.RegisterChanges(FSmallImageChangeLink);
  Repaint;
end;

procedure TCustomLookOutButton.SetLargeImages(Value:TImageList);
begin
  if Assigned(FLargeImages) then
    FLargeImages.UnRegisterChanges(FLargeImageChangeLink);
  FLargeImages := Value;

  if Assigned(FLargeImages) then
    FLargeImages.RegisterChanges(FLargeImageChangeLink);
  Repaint;
end;


procedure TCustomLookOutButton.SetImageIndex(Value:integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Invalidate;
  end;
end;

procedure TCustomLookOutButton.SetImageSize(Value:TImageSize);
begin
  if FImageSize <> Value then
  begin
    FImageSize := Value;
    if csDesigning in ComponentState then
      SetPImSize(False);
    Invalidate;
  end;
end;

procedure TCustomLookOutButton.SetFillColor(Value:TColor);
begin
  if FFillColor <> Value then
  begin
    FFillColor := Value;
    Repaint;
  end;
end;


procedure TCustomLookOutButton.SetHiFont(Value:TFont);
begin
  FHiFont.Assign(Value);
  if FHiFont <> Font then
    Invalidate;
end;

procedure TCustomLookOutButton.SetSpacing(Value:integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;


procedure TCustomLookOutButton.SetPImSize(Value:boolean);
begin
  FPImSize := Value;
  if FPImSize and (Parent is TLookOutPage) then
    SetImageSize((Parent as TLookOutPage).ImageSize);
end;


procedure TCustomLookOutButton.Paint;
var R:TRect;Flags,h:integer;
begin
  R := GetClientRect;

  with Canvas do
  begin
    if csDesigning in ComponentState then
    begin
      Brush.Color := clBlack;
      FrameRect(R);
    end;

    if (FImageSize = isSmall) and Assigned(FSmallImages) then
    begin
      FImageRect.Left := FSpacing;
      FImageRect.Right := FImageRect.Left + FSmallImages.Width;
      FImageRect.Top := (Height - FSmallImages.Height) div 2;
      FImageRect.Bottom := FImageRect.Top + FSmallImages.Height;
    end
    else if Assigned(FLargeImages) then
    begin
      FImageRect.Left := (Width - FLargeImages.Width) div 2;
      FImageRect.Right := FImageRect.Left + FLargeImages.Width;
      FImageRect.Top := FSpacing;
      FImageRect.Bottom := FImageRect.Top + FLargeImages.Height;
    end;

    PaintFrame;

    Flags := DT_END_ELLIPSIS or DT_EDITCONTROL;

    if (FImageSize = isSmall) and Assigned(FSmallImages) then
    begin
      DrawSmallImages;
      Flags := Flags or DT_VCENTER or DT_SINGLELINE;
//      W := FSmallImages.Width;
    end
    else if (FImageSize = isLarge) and Assigned(FLargeImages) then
    begin
      DrawLargeImages;
//      W := FLargeImages.Width;
      Flags := Flags or DT_WORDBREAK or DT_CENTER;
    end;
  end;

  { draw text }
  if Length(Caption) > 0 then
  begin
    if FInsideButton then
      Canvas.Font := FHiFont
    else
      Canvas.Font := Font;

//    W := FSpacing  + W;
    SetBkMode(Canvas.Handle,Windows.Transparent);
    R := GetClientRect;
    if (ImageSize = isLarge) and Assigned(FLargeImages) then
      R.Top := R.Top + FLargeImages.Height + (FSpacing * 2)
    else if (ImageSize = isSmall) and Assigned(FSmallImages) then
      R.Left := R.Left + FSmallImages.Width + (FSpacing * 3)
    else
      Flags := DT_END_ELLIPSIS or DT_EDITCONTROL or DT_WORDBREAK or DT_CENTER or DT_VCENTER;
    if FDown then OffsetRect(R,FOffset,FOffset);
    FTextRect := R;
    h := DrawText(Canvas.Handle,PChar(Caption),-1,FTextRect,Flags or DT_CALCRECT);
    if (ImageSize = isLarge) then
    begin
      FTextRect.Top := R.Top;
      FTextRect.Bottom := FTextRect.Top + h;
      FTextRect.Right := R.Left + Canvas.TextWidth(Caption);
    end
    else
    begin
      FTextRect.Top := (Height - Canvas.TextHeight(Caption)) div 2;
      FTextRect.Bottom := FTextRect.Top + Canvas.TextHeight(Caption);
      FTextRect.Right := R.Left + Canvas.TextWidth(Caption);
    end;
    DrawText(Canvas.Handle,PChar(Caption),-1,R,Flags);
  end;
end;

procedure TCustomLookOutButton.DrawSmallImages;
begin
  if FDown then
    OffsetRect(FImageRect,FOffset,FOffset);
  FSmallImages.Draw(Canvas,FImageRect.Left,FImageRect.Top,FImageIndex);
{   ImageList_DrawEx(FSmallImages.Handle,FImageIndex,Canvas.Handle,
       FImageRect.Left,FImageRect.Top,0,0,clNone,clNone,ILD_TRANSPARENT);}
end;

procedure TCustomLookOutButton.DrawLargeImages;
begin
  if FDown then
    OffsetRect(FImageRect,FOffset,FOffset);
  FLargeImages.Draw(Canvas,FImageRect.Left,FImageRect.Top,FImageIndex);

{  ImageList_DrawEx(FLargeImages.Handle,FImageIndex,Canvas.Handle,
     FImageRect.Left,FImageRect.Top,0,0,clNone,clNone,ILD_TRANSPARENT);}
end;

procedure TCustomLookOutButton.PaintFrame;
var R:TRect;
begin
  R := GetClientRect;

  if csDesigning in ComponentState then
  begin
    Canvas.Brush.Color := clBlack;
    Canvas.FrameRect(R);
  end;

  if not Enabled then Exit;
  if (FInsideButton or (csDesigning in ComponentState)) then
  begin
    if (FFillColor = clNone) then
    begin
      R := FImageRect;
      InflateRect(R,Spacing,Spacing);
    end
    else
    begin { fill it up! }
      Canvas.Brush.Color := FFillColor;
      Windows.FillRect(Canvas.Handle,R,Canvas.Brush.Handle);
    end;

    if FDown then
    begin
      if FButtonBorder = bbDark then
        Frame3D(Canvas,R,cl3DDkShadow,clBtnFace,1)
      else if FButtonBorder = bbLight then
        Frame3D(Canvas,R,clBtnShadow,clBtnHighLight,1)
      else
        Frame3D(Canvas,R,cl3DDkShadow,clBtnHighLight,1)
    end
    else
      case FButtonBorder of    
        bbDark:Frame3D(Canvas,R,clBtnFace,cl3DDkShadow,1);
        bbLight:Frame3D(Canvas,R,clBtnHighLight,clBtnShadow,1);
      else
        Frame3D(Canvas,R,clBtnHighLight,cl3DDkShadow,1);
      end;
  end;
end;

procedure TCustomLookOutButton.ImageListChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TCustomLookOutButton.WMEraseBkgnd(var M : TWMEraseBkgnd);
begin
  inherited;
end;

procedure TCustomLookOutButton.CMParentImageSizeChanged(var Message:TMessage);
var FTmp:boolean;
begin
  if (Message.LParam <> Longint(self)) and FPImSize then
  begin
    FTmp := FPImSize;
    SetImageSize(TImageSize(Message.WParam));
    FPImSize := FTmp;
  end;
end;

procedure TCustomLookOutButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TCustomLookOutButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TCustomLookOutButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FStayDown := False;
        FDown := false;
        FInsideButton := false;
        Invalidate;
      end;
    end;
  end;
end;

procedure TCustomLookOutButton.MouseEnter;
begin
  if Assigned(FMouseEnter) then FMouseEnter(Self);
end;

procedure TCustomLookOutButton.MouseExit;
begin
  if Assigned(FMouseExit) then FMouseExit(Self);
end;

procedure TCustomLookOutButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  MouseEnter;
  if not FInsideButton then
  begin
    FInsideButton := True;
    if FFillColor = clNone then
      PaintFrame
    else
      Invalidate;
  end;
end;


procedure TCustomLookOutButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  MouseExit;
  if FInsideButton and not FStayDown then
  begin
    FInsideButton:= False;
    Invalidate;
  end;
end;

procedure TCustomLookOutButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp:TPoint;Msg:TMsg;
begin
  if Parent is TLookOutPage then
    TLookOutPage(Parent).ActiveButton := self;

  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbRight) then
  begin
    if Assigned(FPopUpMenu) then
    begin
      { calc where to put menu }
      tmp := ClientToScreen(Point(X, Y));
      FPopUpMenu.PopupComponent := self;
      FPopUpMenu.Popup(tmp.X, tmp.Y);
      { wait 'til menu is done }
      while PeekMessage(Msg, 0, WM_MOUSEFIRST, WM_MOUSELAST, PM_REMOVE) do
       	;
    end;
    { release button }
    if not FStayDown then FDown := False;
  end
  else if FInsideButton and (Button = mbLeft) then
    FDown := True
  else if not FStayDown then
    FDown := False;

  if FGroupIndex <> 0 then SetDown(not FStayDown);
  if (FOffset = 0) then
    PaintFrame
  else
    Invalidate;
//  Parent.Update;
end;

procedure TCustomLookOutButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var Msg:TMessage;
begin
  inherited MouseMove(Shift, X, Y);

  if PtInRect(GetClientRect,Point(X,Y)) then { entire button }
  begin
    if not FInsideButton then
    begin
      FInsideButton := True;
    { notify others }
      Msg.Msg := CM_LEAVEBUTTON;
      Msg.WParam := 0;
      Msg.LParam := Longint(self);
      Msg.Result := 0;
      Invalidate;
      Parent.Broadcast(Msg);
    end;
  end
  else if FInsideButton then
  begin
    FInsideButton := False;
    Invalidate;
  end; 
end;

procedure TCustomLookOutButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDown and not FStayDown then
  begin
    FDown := False;
  if (FOffset = 0) then
    PaintFrame
  else
    Invalidate;
//    Parent.Update;
  end;
end;

procedure TCustomLookOutButton.CMLeaveButton(var Msg:TMessage);
begin
  if (Msg.LParam <> longint(self)) and FInsideButton and not FStayDown then
  begin
    FInsideButton := False;
//    FDown := False;
    Invalidate;
  end;
end;

procedure TCustomLookOutButton.SetParent(AParent: TWinControl);
begin
  if (AParent <> Parent) then
  begin
    if (Parent <> nil) and (Parent is TLookOutPage) then
      TLookOutPage(Parent).FButtons.Delete(TLookOutPage(Parent).FButtons.IndexOf(self));
    if (AParent <> nil) and (AParent is TLookOutPage) then
      TLookOutPage(AParent).FButtons.Add(self);
  end;
  inherited SetParent(AParent);
end;

procedure TCustomLookOutButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if Operation = opRemove then
  begin
    if AComponent = FSmallImages then
      FSmallImages := nil;
    if AComponent = FLargeImages then
      FLargeImages := nil;
    if AComponent = FPopUpMenu then
      FPopUpMenu := nil;
  end;
  Invalidate;
end;

{$IFDEF D4_AND_UP }
procedure TCustomLookOutButton.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;

end;
{$ENDIF }

{ TExpressButton }
constructor TExpressButton.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FillColor := clBtnFace;
  Offset := 1;
  FButtonBorder := bbLight;
  FHiFont.Color := clBlack;
  Font.Color := clWhite;
end;


{ TLookOutPage }

constructor TLookOutPage.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls,csCaptureMouse,csSetCaption];
  Color := clBtnShadow;
  FScrolling := 0;
  FCaption := 'Outlook';
  FButtons := TList.Create;
  FDown := False;
  FShowPressed := False;
  SetBounds(0,0,92,100);
  FInsideButton := False;
  FHiFont := TFont.Create;
  FHiFont.Assign(Font);
  FMargin := 0;
  FTopControl := 0;
  FPImSize := True;
  FAutoRepeat := False;
  FBitmap := TBitmap.Create;
end;

destructor TLookOutPage.Destroy;
begin
  if Assigned(FEdit) then FEdit.Free;
  FUpArrow.Free;
  FDwnArrow.Free;
  FBitmap.Free;
  FHiFont.Free;
  FButtons.Free;
  inherited Destroy;
end;


procedure TLookOutPage.DisableAdjust;
begin
  Inc(FScrolling);
end;

procedure TLookOutPage.EnableAdjust;
begin
  Dec(FScrolling);
end;

procedure TLookOutPage.DownArrow;
begin
 if Enabled then DownArrowClick(self);
 Invalidate;
end;

procedure TLookOutPage.UpArrow;
begin
  if Enabled then UpArrowClick(self);
  Invalidate;
end;

procedure TLookOutPage.ExchangeButtons(Button1,Button2:TCustomLookOutButton);
var tmp1:integer;
begin
  tmp1 := Button1.Top;
  Button1.Top := Button2.Top;
  Button2.Top := tmp1;
  FButtons.Exchange(FButtons.IndexOf(Button1),FButtons.IndexOf(Button2));
end;

function TLookOutPage.AddButton:TLookOutButton;
var i:integer;
begin
  Result := TLookOutButton.Create(Self.Owner);
  i := ButtonCount;
  Result.ImageIndex := i;
  if ButtonCount > 0 then
    Result.Top := Buttons[i - 1].Top + Buttons[i - 1].Height
  else
    Result.Top := bHeight + 1;
  Result.Parent := self;
  RequestAlign;
  if Assigned(FUpArrow) and Assigned(FDwnArrow) then
  begin
    FUpArrow.SetZOrder(True);
    FDwnArrow.SetZOrder(True);
  end;
end;

procedure TLookOutPage.DoOnEdited(var Caption:string);
begin
  if self is TExpress then Exit;
  if Assigned(FOnEdited) then FOnEdited(self,Caption);
end;

procedure TLookOutPage.EditCaption;
begin
  if Self is TExpress then Exit;

  if not Assigned(FEdit) then
  begin
    FEdit := TLookOutEdit.Create(nil);
    FEdit.Parent := self;
  end
  else if not FEdit.Visible then
    FEdit.Show;

  with FEdit do
  begin
    Text := FCaption;
//    BorderStyle := bsNone;
    SetBounds(0,0,Width,bHeight);
    AutoSelect := True;
    OnKeyPress := EditKeydown;
    OnMouseDown := EditMouseDown;
    SetFocus;
    SetCapture(FEdit.Handle);
    SelStart := 0;
    SelLength := Length(FCaption);
  end;
end;


procedure TLookOutPage.EditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
X, Y: Integer);
begin
  if Assigned(FEdit) then
  begin
    if not PtInRect(FEdit.ClientRect,Point(X,Y)) or ((Button = mbRight) and FEdit.Visible) then
    begin
      if FEdit.Handle = GetCapture then
        ReleaseCapture;
      Screen.Cursor := crDefault;
      FEdit.Hide;
      FEdit.Free;
      FEdit := nil;
    end
    else
    begin
      ReleaseCapture;
      Screen.Cursor := crIBeam;
      SetCapture(FEdit.Handle);
    end;
  end;
end;

procedure TLookOutPage.EditKeyDown(Sender: TObject; var Key: Char);
var aCaption:string;Modify:boolean;
begin
  Modify := False;
  if (Sender = FEdit) then
  case Key of
    #13:
    begin
      Key := #0;
      aCaption := FEdit.Text;
      DoOnEdited(aCaption);
      FEdit.Text := aCaption;
      Modify := True;
      if FEdit.Handle = GetCapture then
        ReleaseCapture;
      FEdit.Hide;
      FEdit.Free;
      FEdit := nil;
      Screen.Cursor := crDefault;
    end;
    #27:
    begin
      Key := #0;
      if FEdit.Handle = GetCapture then
        ReleaseCapture;
      FEdit.Hide;
      FEdit.Free;
      FEdit := nil;
      Screen.Cursor := crDefault;
    end;
  end; { case }
  if Modify then FCaption := aCaption;
end;


procedure TLookOutPage.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, FCaption) and Enabled then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TLookOutPage.SetActiveButton(Value:TCustomLookOutButton);
begin
  if (Value <> nil) and (FActiveButton <> Value) and (Value.Parent = self) then
    FActiveButton := Value;
end;

procedure TLookOutPage.SetParent(AParent: TWinControl);
begin
  if (AParent <> Parent) then
  begin
    if (Parent <> nil) and (Parent is TLookOut) then
      TLookOut(Parent).FPages.Delete(TLookOut(Parent).FPages.IndexOf(self));
    if (AParent <> nil) and (AParent is TLookOut) then
      TLookOut(AParent).FPages.Add(self);
  end;
  inherited SetParent(AParent);
end;

procedure TLookOutPage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) then
  begin
   if (AComponent = FPopUpMenu) then
    FPopUpMenu := nil;
  end;
  if (Operation = opInsert) then
  begin
    if not (csDesigning in ComponentState) and Assigned(FUpArrow) and Assigned(FDwnArrow) then
      begin
        FUpArrow.SetZOrder(True);
        FDwnArrow.SetZOrder(True);
      end;
  end;
end;


procedure TLookOutPage.AlignControls(Control:TControl;var Rect:TRect);
begin
  inherited AlignControls(Control,Rect);
end;

procedure TLookOutPage.SmoothScroll(aControl:TControl;NewTop,Intervall:integer;Smooth:boolean);
begin
  if Smooth and not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
  begin
    if (aControl.Top < NewTop) then
      if (aControl.Top > 0) then
      begin
       while aControl.Top < NewTop do
       begin
         aControl.Top := aControl.Top + Intervall;
         Application.ProcessMessages;
       end;
      end
      else
      begin
       while aControl.Top < NewTop do
       begin
         aControl.Top := aControl.Top - Intervall;
         Application.ProcessMessages;
       end;
      end
    else
      if (aControl.Top > 0) then
      begin
        while aControl.Top > NewTop do
        begin
            aControl.Top := aControl.Top - Intervall;
            Application.ProcessMessages;
        end;
      end
      else
      begin
        while aControl.Top > NewTop do
        begin
            aControl.Top := aControl.Top + Intervall;
            Application.ProcessMessages;
        end;
      end;
  end;
  { adjust }
  aControl.Top := NewTop;
  Application.ProcessMessages;

end;

function Compare(Item1,Item2:Pointer):integer;
begin
  Result := TControl(Item1).Top - TControl(Item2).Top;
end;

procedure TLookOutPage.ScrollChildren(Start:word);
var R:TRect;i,x,aCount:integer;{AList:TList;}aControl:TControl;
begin
  if FScrolling <> 0 then Exit;
  if (csReading in ComponentState) or (csLoading in ComponentState) or (csWriting in ComponentState) or
    (csDestroying in ComponentState) then
    Exit;
  { draw all owned controls }
  if (ControlCount < 3) then
  begin
    if Assigned(FUpArrow) and Assigned(FDwnArrow) then
    begin
      FUpArrow.Visible := False;
      FDwnArrow.Visible := False;
    end;
    Exit;
  end;

  R := GetClientRect;
  x := Width;
  aCount := GetButtonCount;
  if aCount = 0 then Exit;
  FButtons.Sort(Compare);
  for i := 0 to aCount - 1 do
  begin
    aControl := FButtons[i];
    if not aControl.Visible then Continue;
    if aControl.Align <> alNone then aControl.Align := alNone;

    if (i < FTopControl) then
      aControl.Top := -(aControl.Height+1)  * (aCount - i)
    else if (Start > Height) then
      aControl.Top := (Height + 1)  * (i + 1)
    else
    begin
      aControl.Top := Start + FMargin;
      Inc(Start,(aControl.Height + FMargin));
    end;

    if FAutoCenter then
      aControl.Left := (x - aControl.Width) div 2;
  end;
end;

procedure TLookOutPage.CreateWnd;
var R:TRect;
begin
  inherited CreateWnd;
  R := GetClientRect;
  if not Assigned(FUpArrow) then
  begin
    FUpArrow := TUpArrowBtn.Create(nil);
    FUpArrow.Parent := self;
  end;

  if not Assigned(FDwnArrow) then
  begin
    FDwnArrow := TDownArrowBtn.Create(nil);
    FDwnArrow.Parent := self;
  end;

  with FUpArrow do
  begin
    Visible := False;
    SetBounds(R.Right - 23,R.Top + 25,16,16);
    SetZorder(True);
  end;

  with FDwnArrow do
  begin
    Visible := False;
    SetBounds(R.Right - 23,R.Bottom - 23,16,16);
    SetZorder(True);
  end;

  if Assigned(Parent) and (Parent is TLookOut) then
  begin
    FManager := TLookOut(Parent);
    FOnCollapse := FManager.FOnCollapse;
  end;

end;

procedure TLookOutPage.Click;
begin
  if not Enabled then Exit;
  if Assigned(FOnCollapse) then FOnCollapse(Self);
  inherited Click;
end;

procedure TLookOutPage.CMEnabledChanged(var Message: TMessage);
begin
 if not (Assigned(FUpArrow) or Assigned(FDwnArrow)) then Exit;
 if not(Enabled) then
 begin
   FUpArrow.Enabled := False;
   FDwnArrow.Enabled := False;
 end
 else
 begin
   FUpArrow.Enabled := True;
   FDwnArrow.Enabled := True;
 end;
 inherited;
 Refresh;
end;


function TLookOutPage.IsVisible(Control:TControl):boolean;
var R:TRect;
begin
  Result := False;
  if (Control = nil) then
    Exit;
  R := GetClientRect;
  Result := (PtInRect(R,Point(R.Left + 1,Control.Top))
        and PtInRect(R,Point(R.Left + 1,Control.Top + Control.Height)));
end;


procedure TLookOutPage.SetAutoRepeat(Value:boolean);
begin
  if FAutoRepeat <> Value then
  begin
    FAutoRepeat := Value;
    if Assigned(FUpArrow) and Assigned(FDwnArrow) then
    begin
      FUpArrow.AutoRepeat := FAutoRepeat;
      FDwnArrow.AutoRepeat := FAutoRepeat;
    end;
  end;
end;

procedure TLookOutPage.SetHiFont(Value:TFont);
begin
  FHiFont.Assign(Value);
  if FHiFont <> Font then
    DrawTopButton;
end;

procedure TLookOutPage.SetButton(Index:integer;Value:TLookOutButton);
begin
  FButtons[Index] := Value;
end;

function TLookOutPage.GetButton(Index:integer):TLookOutButton;
begin
  Result := TLookOutButton(FButtons[Index]);
end;

function TLookOutPage.GetButtonCount:integer;
begin
  Result := FButtons.Count;
end;

procedure TLookOutPage.SetAutoCenter(Value:boolean);
begin
  if FAutoCenter <> Value then
  begin
    FAutoCenter := Value;
    if FAutoCenter then
      ScrollChildren(bHeight + 7 - FMargin);
  end;
end;

procedure TLookOutPage.SetMargin(Value:integer);
begin
  if FMargin <> Value then
  begin
    FMargin := Value;
    Repaint;
  end;
end;

procedure TLookOutPage.SetImageSize(Value:TImageSize);
var Message:TMessage;
begin
  if FImageSize <> Value then
  begin
    FImageSize := Value;
    if csDesigning in ComponentState then
      SetPImSize(False);
    { notify children }
    Message.Msg := CM_IMAGESIZECHANGED;
    Message.WParam := Longint(Ord(FImageSize));
    Message.LParam := Longint(self);
    Message.Result := 0;
    if Parent <> nil then Parent.Broadcast(Message);
    Broadcast(Message);
  end;
end;

procedure TLookOutPage.SetPImSize(Value:boolean);
begin
  FPImSize := Value;
  if FPImSize and (FManager <> nil) then
     SetImageSize(FManager.ImageSize);
end;

procedure TLookOutPage.CMParentImageSizeChanged(var Message:TMessage);
var FTmp:boolean;
begin
  if (Message.LParam <> Longint(self)) and FPImSize then
  begin
    FTmp := FPImSize;
    SetImageSize(TImageSize(Message.WParam));
    FPImSize := FTmp;
  end;
end;

procedure TLookOutPage.SetBitmap(Value:TBitmap);
begin
  FBitmap.Assign(Value);
  if FBitmap.Empty then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
//  RecreateWnd;
  Invalidate;
end;
  
procedure TLookOutPage.SetCaption(Value:TCaption);
begin
  FCaption := Value;
  Invalidate;
end;

{ determine if arrows should be visible }
procedure TLookOutPage.CalcArrows;
var i:integer;R:TRect;AList:TList;
begin
  if Assigned(FUpArrow) and Assigned(FDwnArrow) then
  begin
    if Height < 65  then
    begin
//      FUpArrow.Visible := False;
//      FDwnArrow.Visible := False;
      FDwnArrow.Top := FUpArrow.Top + 16;
      Exit;
    end;

    R := GetClientRect;
    FUpArrow.SetBounds(R.Right - 23,R.Top + 25,16,16);
    FDwnArrow.SetBounds(R.Right - 23,R.Bottom - 23,16,16);
    AList := TList.Create;
  try
    for i := 0 to ControlCount - 1 do
    begin
      if (Controls[i] = FUpArrow ) or (Controls[i] = FDwnArrow ) or (Controls[i] = FEdit) then
        Continue;

      if not Controls[i].Visible and not (csDesigning in ComponentState) then
        Continue;
      AList.Insert(AList.Count,Controls[i]);
    end;

    if AList.Count =  0 then Exit;
    AList.Sort(Compare);
    FDwnArrow.Visible := not IsVisible(AList.Items[AList.Count - 1]);
    FUpArrow.Visible := not IsVisible(AList.Items[0]);
  finally
    AList.Free;
  end;
end;
end;


procedure TLookOutPage.UpArrowClick(Sender:TObject);
begin
  if (FScrolling = 0) and (FTopControl > 0) then
    Dec(FTopControl);
end;

procedure TLookOutPage.DownArrowClick(Sender:TObject);
begin
  if (FScrolling = 0) and (FTopControl < ControlCount - 3) then
    Inc(FTopControl);
end;

procedure TLookOutPage.Paint;
begin
  inherited Paint;
  if not FBitmap.Empty then
  begin
    ControlStyle := ControlStyle + [csOpaque];
    TileBitmap;
  end
  else
    ControlStyle := ControlStyle - [csOpaque];

  DrawTopButton;
  CalcArrows;
  ScrollChildren(bHeight + 7 - FMargin);
end;

procedure TLookOutPage.DrawTopButton;
var R,R2:TRect;DC:hDC;FFlat,FPush:boolean;
begin
  if FInsideButton then
    Canvas.Font := FHiFont
  else
    Canvas.Font := self.Font;

  Canvas.Brush.Color := clBtnFace;
  DC := Canvas.Handle;
  R := GetClientRect;

  { draw top button }
  R.Bottom := bHeight;
  Canvas.FillRect(R);
  FPush := FShowPressed and FDown;
  FFlat := Assigned(FManager) and (FManager.FFlatButtons);
  if FFlat then
  begin
    if FManager.ActivePage = self then
    begin
      R2 := GetClientRect;
      R2.Top := R.Bottom;
      Frame3d(Canvas,R2,cl3DDkShadow,clBtnFace,1);
    end;

    if FPush then
      Frame3D(Canvas,R,clBtnShadow,clBtnHighlight,1)
    else if FInsideButton then
    begin
      Frame3D(Canvas,R,clBtnHighLight,cl3DDkShadow,1);
      Frame3D(Canvas,R,clBtnFace,clBtnShadow,1);
    end
    else
      Frame3D(Canvas,R,clBtnHighlight,clBtnShadow,1)
  end
  else
  begin
    if FPush then
    begin
      Frame3D(Canvas,R,cl3DDkShadow,clBtnHighlight,1);
      Frame3D(Canvas,R,clBtnShadow,clBtnFace,1);
    end
    else
    begin
      Frame3D(Canvas,R,clBtnHighlight,cl3DDkShadow,1);
      Frame3D(Canvas,R,clBtnFace,clBtnShadow,1);
    end;
  end;

  { draw top caption }
  R := GetClientRect;
  R.Bottom := bHeight;
  SetBkMode(DC,Windows.Transparent);
  if FCaption <> '' then
  begin
    if not Enabled then
    begin
    { draw disabled text }
      SetTextColor(DC,ColorToRGB(clBtnHighLight));
      OffsetRect(R,1,1);
      DrawText(DC, PChar(FCaption), Length(FCaption), R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      OffsetRect(R,-1,-1);
      SetTextColor(DC,ColorToRGB(clBtnShadow));
    end
    else
      SetTextColor(DC,ColorToRGB(Canvas.Font.Color));
    if FShowPressed and FDown then
      OffsetRect(R,1,1);
    DrawText(DC, PChar(FCaption), Length(FCaption), R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  end;
end;

procedure TLookOutPage.TileBitmap;
var
  X, Y, W, H: LongInt;
  Dest,Source:TRect;
  Tmp:TBitmap;
begin
  if not FBitmap.Empty then
  begin
    with FBitmap do
    begin
      W := Width;
      H := Height;
    end;

    Tmp := TBitmap.Create;
    Tmp.Width := Width;
    Tmp.Height := Height;

    Y := 0;
    Source := Rect(0,0,W,H);
    while y < Height do begin
      X := 0;
      while X < Width do
      begin
        Dest := Rect(X,Y,X+W,Y+H);
        Tmp.Canvas.CopyRect(Dest,FBitmap.Canvas,Source);
        Inc(X, W);
      end;
      Inc(Y, H);
    end;
    Canvas.Draw(0,0,Tmp);
    Tmp.Free;
  end;
end;

procedure TLookOutPage.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var R:TRect;tmp:TPoint;Msg:TMsg;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Assigned(FPopUpMenu) and (Button = mbRight) then
  begin
   { calc where to put menu }
 	tmp := ClientToScreen(Point(X, Y));
    FPopUpMenu.PopupComponent := self;
    FPopUpMenu.Popup(tmp.X, tmp.Y);
    { wait 'til menu is done }
   while PeekMessage(Msg, 0, WM_MOUSEFIRST, WM_MOUSELAST, PM_REMOVE) do
      ;
   FDown := False;
  end
  else
  begin
    R := GetClientRect;
    R.Bottom := bHeight;
    if PtInRect(R,Point(X,Y)) and (Button = mbLeft) then
    begin
      FDown := True;
      DrawTopButton;
    end;
  end;  
end;

procedure TLookOutPage.MouseMove(Shift: TShiftState; X, Y: Integer);
  var R:TRect;
begin
  R := GetClientRect;
  R.Bottom := bHeight;
  if PtInRect(R,Point(X,Y)) then
  begin
    if not FInsideButton then
    begin
      FInsideButton := True;
      DrawTopButton;
    end
  end
  else if FInsideButton or FDown then
  begin
    FInsideButton := False;
//    FDown := False;
    DrawTopButton;
  end;
  inherited MouseMove(Shift, X, Y);

end;

procedure TLookOutPage.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
var R:TRect;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if not Enabled then Exit;
  FDown := False;
  R := GetClientRect;
  R.Bottom := bHeight;
  if PtInRect(R,Point(X,Y)) and (Button = mbLeft) then
  begin
    if Assigned(FOnCollapse) then FOnCollapse(self);
    if Assigned(FOnClick) then FOnClick(self);
  end;
  DrawTopButton;
end;

procedure TLookOutPage.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if FInsideButton then
  begin
    FInsideButton:= False;
//    FDown := False;
    DrawTopButton;
  end;
end;

procedure TLookOutPage.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  Message.Result := 1;
end;

{ TLookOut}

procedure TLookOut.SetFlatButtons(Value:boolean);
// var i:integer;
begin
  if FFlatButtons <> Value then
  begin
    FFlatButtons := Value;
//    for i := 0 to PageCount - 1 do
//      Pages[i].DrawTopButton;
    RecreateWnd;
  end;
end;

constructor TLookOut.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque];
  FPages := TList.Create;
  Width := 92;
  Height := 300;
  FBorderStyle := bsSingle;
  FAutoSize := False;
  FScroll := False;
  FFlatButtons := false;
  Color := clBtnFace;
  FOnCollapse := DoCollapse;
  FImageSize := isLarge;
end;

destructor TLookOut.Destroy;
begin
  FPages.Free;
  inherited Destroy;
end;

function TLookOut.AddPage:TLookOutPage;
begin
  Result := TLookOutPage.Create(self.Owner);
  Result.Parent := self;
  Result.Top := PageCount * bHeight;
end;

procedure TLookOut.Notification(AComponent:TComponent;Operation:TOperation);
var i:integer;
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FActivePage) then
      FActivePage := nil;
    if (AComponent) = FCurrentPage then
      FCurrentPage := nil;
    if (AComponent is TLookoutPage) and (TLookOutPage(AComponent).Parent = self) then
    begin
      i := FPages.IndexOf(AComponent);
      if i > -1 then
        FPages.Delete(i);
    end;
  end
  else // insertion
    if (AComponent is TLookoutPage) and (TLookoutPage(AComponent).Parent = self) then
    begin
      if FPages.IndexOf(AComponent) = -1 then
        FPages.Add(AComponent);
    end;

//  if Canvas <> nil then Invalidate;
end;

procedure TLookOut.UpdateControls;
begin
  if FCollapsing then Exit;
  if (FCurrentPage <> nil) then
    DoCollapse(FCurrentPage)
  else if (FActivePage <> nil) then
    DoCollapse(FActivePage)
  else if (ControlCount > 0) and (Controls[0] is TLookOutPage) then
    DoCollapse(Controls[0]);
end;

procedure TLookOut.SetAutoSize(Value:boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if FAutoSize then
      UpdateControls;
  end;
end;

procedure TLookOut.SetImageSize(Value:TImageSize);
var Message:TMessage;
begin
  if FImageSize <> Value then
  begin
    FImageSize := Value;
    { notify children }
    Message.Msg := CM_IMAGESIZECHANGED;
    Message.WParam := Longint(Ord(FImageSize));
    Message.LParam := Longint(self);
    Message.Result := 0;
    Broadcast(Message);
  end;
end;

procedure TLookOut.SetBorderStyle(Value:TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

{ calculate which TLookOutPage should be visible and which should not }
procedure TLookOut.DoCollapse(Sender:TObject);
var C:TControl;
    done:boolean;
    vis,i,ht,ofs,bh,cc,flt:integer;
begin
    FCollapsing := true;
    if Sender is TLookOutPage then
    begin
      FCurrentPage := TLookOutPage(Sender);
      FActivePage := FCurrentPage;
      FCurrentPage.DrawTopButton;
    end;

    if Assigned(FOnClick) then FOnClick(Sender);


    cc := ControlCount - 1;
    done := false;
    ht := Height;
    vis := 0;
    ofs := 0;

   { make sure non-visible pages don't mess up the display }
    for i := 0 to cc do
      if Controls[i].Visible then
        Inc(vis);
    if Height <= (bHeight * vis) + 65 then
      Exit;
    if FFlatButtons then flt := 2 else flt := 4;

    for i := 0 to cc do
    begin
      C := Controls[i];

      if not C.Visible then
      begin
        Inc(ofs);
        Continue;
      end;

      C.Align := alNone;
      bh := bHeight + 1;

      if FAutoSize then
        C.SetBounds(0,C.Top,Width-flt,C.Height);

      C.Height := ht - (vis - 1) * bh;

      if (C = Sender) then done := true;

      if (C = Sender) or (i = 0) then { first or caller }
        SmoothScroll(C,(i - ofs) * bh,ScrollSpeed,FScroll)
      else if done and (C <> Sender) then { place at bottom }
         SmoothScroll(C,ht - (vis - i + ofs ) * bh - flt + 1,ScrollSpeed,FScroll)
      else { place at top }
        SmoothScroll(C,(i - ofs) * bh,ScrollSpeed,FScroll);
    end;
    FCollapsing := false;
end;

procedure TLookOut.SmoothScroll(aControl:TControl;NewTop,Intervall:integer;Smooth:boolean);
begin
  if Smooth and not (csDesigning in ComponentState) then
  begin
    if aControl.Top < NewTop then
       while aControl.Top < NewTop do
       begin
         aControl.Top := aControl.Top + Intervall;
         Application.ProcessMessages;
       end
    else
      while aControl.Top > NewTop do
      begin
          aControl.Top := aControl.Top - Intervall;
          Application.ProcessMessages;
      end;
  end;
  { adjust }
  aControl.Top := NewTop;
  Application.ProcessMessages;
end;

procedure TLookOut.SetActiveOutLook(Value:TLookOutPage);
var i:integer;
begin
  if (FActivePage = Value) or FCollapsing then Exit;
  if (Value <> nil) and (Value.Parent = self) and (Value.Visible) then
    DoCollapse(Value)
  else if (PageCount > 0) then
    for i := 0 to PageCount - 1 do
      if Pages[i].Visible then
         DoCollapse(Pages[i])
  else
    FActivePage := nil;
end;

function TLookOut.GetActiveOutlook:TLookOutPage;
begin
  if csDesigning in ComponentState then
    Result := FActivePage
  else
    Result := FCurrentPage;
end;

function TLookOut.GetPageCount:integer;
begin
  Result := FPages.Count;
end;

function TLookOut.GetPage(Index:integer):TLookOutPage;
begin
  Result := TLookOutPage(FPages[Index]);
end;

procedure TLookOut.SetPage(Index:integer;Value:TLookOutPage);
begin
  FPages[Index] := Value;
end;

procedure TLookOut.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  with Message.CalcSize_Params^ do
  if FFlatButtons then
    InflateRect(rgrc[0], -1, -1)
  else
    InflateRect(rgrc[0], -2, -2);
  inherited;
end;

procedure TLookOut.WMNCPaint(var Message: TMessage);
var
  DC: HDC;
  RC, RW: TRect;
begin
  DC := GetWindowDC(Handle);
  try
    Windows.GetClientRect(Handle, RC);
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    if FBorderStyle = bsSingle then
      DrawEdge(DC,RW,EDGE_SUNKEN,BF_RECT)
    else
    begin
      Canvas.Brush.Color := Color;
      Windows.FrameRect(DC,RW,Canvas.Brush.Handle);
      InflateRect(RW,-1,-1);
      Windows.FrameRect(DC,RW,Canvas.Brush.Handle);
      InflateRect(RW,1,1);
    end;
    { Erase parts not drawn }
    IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TLookOut.Paint;
begin
  if not (Visible or (csDesigning in ComponentState)) then Exit;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(GetClientRect);
  { make TLookOuts adjust to Managers size }
  if (ControlCount > 0) and FAutoSize then
    UpdateControls;
end;


{ TExpress }
constructor TExpress.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ImageSize := isLarge;
  FBorderStyle := bsSingle;
  FTopControl := 0;
  FButtonHeight := 60;
end;

procedure TExpress.Paint;
begin
  if not FBitmap.Empty then
  begin
    ControlStyle := ControlStyle + [csOpaque];
    TileBitmap;
  end
  else
  begin
    ControlStyle := ControlStyle - [csOpaque];
    Canvas.Brush.Color := Color;
    Canvas.FillRect(GetClientRect);
  end;

  CalcArrows;
  ScrollChildren(0);
end;

function TExpress.AddButton:TExpressButton;
var i:integer;
begin
  Result := TExpressButton.Create(Self.Owner);
  i := ButtonCount;
  Result.ImageIndex := i;
  if ButtonCount > 0 then
    Result.Top := Buttons[i - 1].Top + Buttons[i - 1].Height
  else
    Result.Top := 0;
  Result.Parent := self;
  RequestAlign;
  if Assigned(FUpArrow) and Assigned(FDwnArrow) then
  begin
    FUpArrow.SetZOrder(True);
    FDwnArrow.SetZOrder(True);
  end;
end;

{
procedure TExpress.SetButton(Index:integer;Value:TExpressButton);
begin
  inherited SetButton(Index,Value);
end;

function TExpress.GetButton(Index:integer):TExpressButton;
begin
  Result := TExpressButton(inherited GetButton(Index));
end;

function TExpress.GetButtonCount:integer;
begin
  inherited GetButtonCount;
end;
}

procedure TExpress.CalcArrows;
var i:integer;R:TRect;AList:TList;
begin
  if Assigned(FUpArrow) and Assigned(FDwnArrow) then
  begin
    if Height < 65 then
    begin
//      FDwnArrow.Top := FUpArrow.Top + 16;
      Exit;
    end;

    R := GetClientRect;
    AList := TList.Create;
  try
    for i := 0 to ControlCount - 1 do
    begin
      if (Controls[i] = FUpArrow ) or (Controls[i] = FDwnArrow ) or (Controls[i] = FEdit) then
        Continue;

      if not (Controls[i].Visible or (csDesigning in ComponentState)) then
        Continue;
      AList.Insert(AList.Count,Controls[i]);
    end;

    if AList.Count =  0 then Exit;
    AList.Sort(Compare);
    FDwnArrow.Visible := not IsVisible(AList.Items[AList.Count - 1]);
    FUpArrow.Visible := not IsVisible(AList.Items[0]);
  finally
    AList.Free;
  end;
end;
end;

procedure TExpress.ScrollChildren(Start:word);
var i:integer;
begin
{ size all children to width of TExpress }
  for i := 0 to ControlCount - 1 do
    if (Controls[i] = FDwnArrow) or (Controls[i] = FUpArrow) or (Controls[i] is TLookoutEdit) then
      Continue
    else
      Controls[i].SetBounds(0,Controls[i].Top,Width - 4,FButtonHeight);

  if Assigned(FUpArrow) then
    Start := 12 * Ord(FUpArrow.Visible)
  else
    Start := 0;
  inherited ScrollChildren(Start);
end;

procedure TExpress.DrawTopButton;
begin
  { do nothing }
end;

procedure TExpress.SetButtonHeight(Value:integer);
var i:integer;
begin
  if FButtonHeight <> Value then
  begin
    FButtonHeight := Value;
    for i := 0 to ButtonCount - 1 do    // Iterate
      Buttons[i].Height := FButtonHeight;
  end;
end;

procedure TExpress.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  with Message.CalcSize_Params^ do
    InflateRect(rgrc[0], -2, -2);
  inherited;
end;

procedure TExpress.CreateWnd;
begin
  inherited CreateWnd;
  if not Assigned(FUpArrow) then
    FUpArrow := TUpArrowBtn.Create(nil);

  if not Assigned(FDwnArrow) then
    FDwnArrow := TDownArrowBtn.Create(nil);
  with FUpArrow do
  begin
    Parent := self;
    Flat := True;
    Height := 13;
    Align := alTop;
    SetZOrder(True);
  end;

  with FDwnArrow do
  begin
    Parent := self;
    Flat := True;
    Height := 13;
    Align := alBottom;
    SetZOrder(True);
  end;
end;

procedure TExpress.WMNCPaint(var Message: TMessage);
var
  DC: HDC;
  RC, RW: TRect;
begin
  DC := GetWindowDC(Handle);
  try
    Windows.GetClientRect(Handle, RC);
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    if FBorderStyle = bsSingle then
      DrawEdge(DC,RW,EDGE_SUNKEN,BF_RECT)
    else
    begin
      if csDesigning in ComponentState then
        Canvas.Brush.Color := clBlack
      else
        Canvas.Brush.Color := Color;
      Windows.FrameRect(DC,RW,Canvas.Brush.Handle);
      InflateRect(RW,-1,-1);
      if csDesigning in ComponentState then
        Canvas.Brush.Color := Color;
      Windows.FrameRect(DC,RW,Canvas.Brush.Handle);
      InflateRect(RW,1,1);
    end;
    { Erase parts not drawn }
    IntersectClipRect(DC, RW.Left, RW.Top, RW.Right, RW.Bottom);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

end.


