{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13145: COMP2000.pas 
{
{   Rev 1.0    2003-03-20 14:03:28  peter
}
unit comp2000;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, comctrls, commctrl;

type
  TShrinkGroupBox = class(TGroupBox)
  public
    FCaptionLabel: TLabel;
    procedure Open;
    procedure Close;
    procedure Click; override;
    constructor Create(aOwner : TComponent);override;
    destructor Destroy; override;
  protected
    procedure DoExit; override;
    procedure DoEnter; override;
  private
    Fisopen : boolean;
    FMaxHeight: integer;
    FMinHeight: integer;
    FOnClose: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    procedure SetHeight;
    procedure Loaded; override;
    procedure SetMaxHeight(const Value: integer);
    procedure SetMinHeight(const Value: integer);
    procedure SetSummaryText(const Value: string);
    function GetSummaryText: string;
    procedure SetIsOpen(const Value: boolean);
    procedure SetOnClose(const Value: TNotifyEvent);
    procedure SetOnOpen(const Value: TNotifyEvent);
  published
    property OnClose : TNotifyEvent read FOnClose write SetOnClose;
    property OnOpen : TNotifyEvent read FOnOpen write SetOnOpen;
    property IsOpen : boolean read FIsOpen write SetIsOpen;
    property SummaryText : string read GetSummaryText write SetSummaryText;
    property MinHeight : integer read FMinHeight write SetMinHeight default 40;
    property MaxHeight : integer read FMaxHeight write SetMaxHeight default 100;
  end;


  TSGBObject = class(TshrinkGroupBox)
  public
    FcbObjId : integer;
    FDTVFrom : TDateTime;
    FDTVTO : TDateTime;
    FDTVOut : TDateTime;
    FDTVReturn : TDateTime;
    FedtObjId : string;
    FedtPKlass : string;
    FcbPType : string;
    FchSRRed : boolean;
    FedtDragbil : string;
    FedtKM_UT : string;
    FedtKM_IN : string;
    FedtKM_KORT : string;
    FedtKM_BER : string;
  private
  protected
    procedure Click; override;
  published
  end;

  TDateTimeViewer = class(TPanel)
  public
    FTabStop : Boolean;
    DatePicker : TDateTimePicker;
    TimePicker : TDateTimePicker;
    constructor create(aOwner : TComponent); override;
    destructor destroy; override;
  private
    FDateTime: TDateTime;
    FOnChange: TNotifyEvent;
    FDateTabStop: Boolean;
    FDateFormat: string;
    FTimeFormat: string;
    FTimeWidth: integer;
    FDateWidth: integer;
    procedure Resize; override;
    procedure Loaded; override;
    procedure SetDateTime(const Value: TDateTime);
    procedure DateTimeChange(Sender : TObject);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetDateTabStop(const Value: Boolean);
    procedure SetDateFormat(const Value: string);
    procedure SetTimeFormat(const Value: string);
    procedure SetDateWidth(const Value: integer);
    procedure SetTimeWidth(const Value: integer);
  published
    property DateWidth : integer read FDateWidth write SetDateWidth;
    property TimeWidth : integer read FTimeWidth write SetTimeWidth;
    property DateFormat : string read FDateFormat write SetDateFormat;
    property TimeFormat : string read FTimeFormat write SetTimeFormat;
    property DateTabStop : Boolean read FDateTabStop write SetDateTabStop;
    property OnChange : TNotifyEvent read FOnChange write SetOnChange;
    property DateTime : TDateTime read FDateTime write SetDateTime;
  end;


procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('muab', [TShrinkGroupBox,TSGBObject,TDateTimeViewer]);
end;

{ TShrinkGroupBox }

procedure TShrinkGroupBox.Click;
begin
  FIsOpen := not FIsOpen;
  SetHeight;
  inherited Click;
end;

procedure TShrinkGroupBox.Close;
begin
  Fisopen := false;
  SetHeight;
end;

constructor TShrinkGroupBox.Create(aOwner: TComponent);
begin
  inherited create(aOwner);
  FCaptionLabel:= TLabel.create(self);
  FCaptionLabel.parent := self;
  FCaptionLabel.Top := 18;
  FCaptionLabel.Left := 25;
  FCaptionLabel.Caption := 'Summary text';
  FMinHeight := 40;
  FMaxHeight := 100;
  self.close;
end;

destructor TShrinkGroupBox.Destroy;
begin
  FCaptionLabel.free;
  inherited destroy;
end;

procedure TShrinkGroupBox.DoEnter;
begin
  if not IsOpen then
    self.open;
  inherited DoEnter;
end;

procedure TShrinkGroupBox.DoExit;
begin
  inherited DoExit;
  if IsOpen then
    self.close;
end;

function TShrinkGroupBox.GetSummaryText: string;
begin
  result := FCaptionLabel.Caption;
end;

procedure TShrinkGroupBox.Loaded;
begin
  inherited loaded;
  SetHeight;
end;

procedure TShrinkGroupBox.Open;
begin
  Fisopen := true;
  SetHeight;
end;


procedure TShrinkGroupBox.SetHeight;
begin
  if FIsOpen then
  begin
    height := FMaxHeight;
    if assigned(FOnOpen) then
      FOnOpen(self);
  end
  else begin
    height := FMinHeight;
    if assigned(FOnClose) then
      FOnClose(self);
  end;
  self.repaint;
end;

procedure TShrinkGroupBox.SetIsOpen(const Value: boolean);
begin
  FIsOpen := Value;
  SetHeight;
end;

procedure TShrinkGroupBox.SetMaxHeight(const Value: integer);
begin
  FMaxHeight := Value;
end;

procedure TShrinkGroupBox.SetMinHeight(const Value: integer);
begin
  FMinHeight := Value;
end;

procedure TShrinkGroupBox.SetOnClose(const Value: TNotifyEvent);
begin
  FOnClose := Value;
end;

procedure TShrinkGroupBox.SetOnOpen(const Value: TNotifyEvent);
begin
  FOnOpen := Value;
end;

procedure TShrinkGroupBox.SetSummaryText(const Value: string);
begin
  FCaptionLabel.caption := Value;
end;

{ TDateTimeViewer }

constructor TDateTimeViewer.create(aOwner: TComponent);
begin
  inherited create(aOwner);
  ControlStyle := ControlStyle - [csReflector];
  Self.caption := 'Time';
  Self.Alignment := taLeftJustify;
  Self.Width := 300;
  Self.BevelOuter := bvNone;
  DatePicker := TDateTimePicker.Create(self);
  TimePicker := TDateTimePicker.Create(self);
  DatePicker.parent := self;
  TimePicker.parent := self;
  Self.Height := DatePicker.Height;
  Self.DateTime := DatePicker.DateTime;
  TimePicker.Width := 60;
  FTimeWidth := 60;
  TimePicker.Top := 0;
  TimePicker.DateMode := dmUpDown;
  TimePicker.Kind := dtkTime;
  TimePicker.OnChange := DateTimeChange;
  DatePicker.Kind := dtkDate;
  DatePicker.Width := 113;
  FDateWidth := 113;
  DatePicker.Top := 0;
  DatePicker.OnChange := DateTimeChange;
  FDateFormat := 'ddd yyyy-MM-dd';
  FTimeFormat := 'HH:mm';
//  Resize;
end;

procedure TDateTimeViewer.DateTimeChange(Sender: TObject);
begin
  FDateTime := (Sender as TDateTimePicker).DateTime;
  if DatePicker.DateTime <> FDateTime then
    DatePicker.DateTime := FDateTime;
  if TimePicker.DateTime <> FDateTime then
    TimePicker.DateTime := FDateTime;
  if Assigned(FOnChange) then FOnChange(Self);
end;

destructor TDateTimeViewer.destroy;
begin
  DatePicker.free;
  TimePicker.free;
  inherited destroy;
end;


procedure TDateTimeViewer.Loaded;
begin
  inherited Loaded;
  Resize;
end;

procedure TDateTimeViewer.Resize;
begin
  inherited Resize;
  try  //Invokes an Exception on creation
    DateTime_SetFormat(DatePicker.Handle,pChar(FDateFormat));
    DateTime_SetFormat(TimePicker.Handle,pChar(FTimeFormat));
  except
  end;
  TimePicker.Left := self.Width - TimePicker.width - 2;
  DatePicker.Left := TimePicker.Left - DatePicker.width - 8;
  self.Repaint;
end;


procedure TDateTimeViewer.SetDateFormat(const Value: string);
begin
  FDateFormat := Value;
  DateTime_SetFormat(DatePicker.Handle,pChar(value));
end;

procedure TDateTimeViewer.SetDateTabStop(const Value: Boolean);
begin
  FDateTabStop := Value;
  DatePicker.TabStop := Value;
  TimePicker.TabStop := Value;
end;

procedure TDateTimeViewer.SetDateTime(const Value: TDateTime);
begin
  FDateTime := Value;
  DatePicker.DateTime := value;
  TimePicker.DateTime := value;
end;

procedure TDateTimeViewer.SetDateWidth(const Value: integer);
begin
  FDateWidth := Value;
  DatePicker.width := value;
  Resize;
end;

procedure TDateTimeViewer.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TDateTimeViewer.SetTimeFormat(const Value: string);
begin
  FTimeFormat := Value;
  DateTime_SetFormat(TimePicker.Handle,pChar(value));
end;

procedure TDateTimeViewer.SetTimeWidth(const Value: integer);
begin
  FTimeWidth := Value;
  TimePicker.width := value;
  Resize;
end;

{ TSGBObject }

procedure TSGBObject.Click;
var I:Integer;
begin
  inherited Click;
  if FIsOpen then
    for I := 0 to controlcount -1 do
      if (controls[i] is TCombobox) then
      begin
        (controls[i] as TCombobox).SetFocus;
        exit;
      end;

end;

end.
