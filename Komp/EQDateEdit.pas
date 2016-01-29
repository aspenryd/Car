{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  12439: EQDateEdit.pas 
{
{   Rev 1.0    2003-03-19 17:34:40  peter
}
unit EQDateEdit;

interface
{$I VER.INC }

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, DBCtrls;

type
  TEQValidateEvent = procedure (Sender:TObject;var NewText:string;var AllowChange:boolean) of object;
  TEQCustomDateEdit = class(TCustomEdit)
  private
    FValidate: boolean;
    FOnValidate: TEQValidateEvent;
    FDefaultText: string;
    FSilent: boolean;
    procedure SetValidate(const Value: boolean);
    procedure SetDefaultText(const Value: string);
    procedure SetSilent(const Value: boolean);
    { Private declarations }
  protected
    { Protected declarations }
    function DoValidate:boolean;virtual;
    procedure DoExit;override;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure KeyPress(var Key: Char); override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    property Silent:boolean read FSilent write SetSilent;
    property Validate:boolean read FValidate write SetValidate default true;
    property OnValidate:TEQValidateEvent read FOnValidate write FOnValidate;
    property DefaultText:string read FDefaultText write SetDefaultText;
  end;

  TEQDateEdit = class(TEQCustomDateEdit)
  published
    property Silent;
    property Validate;
    property OnValidate;
    property DefaultText;
    property Text;

    {$IFDEF D4_AND_UP }
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF }

    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
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
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;


  TDBEQDateEdit = class(TEQCustomDateEdit)
  private
    FDataLink:TFieldDataLink;
    FNullValue: string;
    function GetDataField: string;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    function GetReadOnly: boolean;
    procedure SetReadOnly(const Value: boolean);
    procedure ResetMaxLength;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataChange(Sender:TObject);
    procedure UpdateData(Sender:TObject);
    procedure ActiveChange(Sender:TObject);
  protected
    procedure Loaded;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure Change;override;
    procedure DoExit;override;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    function DoValidate: boolean;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Field:TField read GetField;
    property Text;
  published
    property NullValue:string read FNullValue write FNullValue;
    property DataField:string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;

    property Silent;
    property Validate;
    property OnValidate;
    property DefaultText;

    {$IFDEF D4_AND_UP }
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF }

    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly:boolean read GetReadOnly write SetReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
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
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  TEQDatePicker = class(TEQCustomDateEdit)
  end;


procedure Register;

implementation
uses
  utilsDateTime;

{ TEQCustomDateEdit }
constructor TEQCustomDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FValidate := true;
end;

procedure TEQCustomDateEdit.DoExit;
begin
  DoValidate;
  inherited;
end;

function TEQCustomDateEdit.DoValidate:boolean;
var NewText:string;
begin
  if not FValidate then Exit;
  Result := true;
  NewText := GetFormattedDate(Text,FDefaultText);
  if Assigned(FOnValidate) then
    FOnValidate(Self,Newtext,Result);
  if Result then
    Text := NewText;
  if CanFocus then
    SelectAll;
end;

procedure TEQCustomDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key,Shift);
  if (Key = VK_RETURN) then
    DoValidate;
end;

procedure TEQCustomDateEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FSilent and (Key = #13) then
    Key := #0; 
end;

procedure TEQCustomDateEdit.SetDefaultText(const Value: string);
begin
  FDefaultText := Value;
end;

procedure TEQCustomDateEdit.SetSilent(const Value: boolean);
begin
  if FSilent <> Value then
    FSilent := Value;
end;

procedure TEQCustomDateEdit.SetValidate(const Value: boolean);
begin
  if FValidate <> Value then
    FValidate := Value;
end;


{ TDBEQDateEdit }

constructor TDBEQDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
  Enabled := false;
end;

destructor TDBEQDateEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TDBEQDateEdit.ActiveChange(Sender: TObject);
begin
  Enabled := FDataLink.Active and Assigned(FDataLink.Field) and not FDataLink.Field.ReadOnly;
  if not FDataLink.Active then
    Text := Name;
end;

procedure TDBEQDateEdit.DataChange(Sender: TObject);
var tmp:string;
begin
  if Assigned(FDataLink.Field) then
    tmp := FDataLink.Field.Text
  else
    tmp := FNullValue;
  if tmp = FNullValue then
    tmp := DefaultText;
  Text := tmp;
end;

procedure TDBEQDateEdit.UpdateData(Sender: TObject);
begin
  if Assigned(FDataLink.Field) then
  begin
    if (Text <> DefaultText) then
      FDataLink.Field.Text := Text
    else
      FDataLink.Field.Text := NullValue;
  end;
end;

function TDBEQDateEdit.DoValidate: boolean;
begin
  FDataLink.Edit;
  Result := inherited DoValidate;
  if Result then
    FDataLink.Modified;
end;

function TDBEQDateEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TDBEQDateEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBEQDateEdit.SetDataField(const Value: string);
begin
  try
    FDataLink.FieldName := Value;
  finally
    Enabled := FDataLink.Active and Assigned(FDataLink.Field) and
      not FDataLink.Field.ReadOnly;
  end;
end;

function TDBEQDateEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBEQDateEdit.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  Enabled := FDataLink.Active and Assigned(FDataLink.Field) and
    not FDataLink.Field.ReadOnly;
end;

procedure TDBEQDateEdit.DoExit;
begin
  FDataLink.Edit;
  inherited;
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
end;

procedure TDBEQDateEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

procedure TDBEQDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
var tmp:word;
begin
  tmp := Key;
  FDataLink.Edit;
  inherited;
  if tmp = VK_RETURN then
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
end;

function TDBEQDateEdit.GetReadOnly: boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBEQDateEdit.SetReadOnly(const Value: boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TDBEQDateEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then
    DataChange(Self);
end;

procedure TDBEQDateEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBEQDateEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType = ftString) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

procedure TDBEQDateEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure Register;
begin
  RegisterComponents('EQ-Soft', [TEQDateEdit, TDBEQDateEdit]);
end;


end.

