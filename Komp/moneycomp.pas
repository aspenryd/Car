{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13159: Moneycomp.pas 
{
{   Rev 1.0    2003-03-20 14:03:30  peter
}
unit moneycomp;

interface

uses Windows, SysUtils, classes, stdctrls, extctrls, controls, dialogs;

type
  TMoneyEdit = class(TEdit)
  private
    FDecFormat : string;
    FByValue : Boolean;
    FPercentFormat: string;
    FMoneyFormat: string;
    FMoneyValue : real;
    FMoneyTotals: real;
    FMoneyPercent: real;
    FDecimals: integer;
    procedure SetMoneyFormat(const Value: string);
    procedure SetPercentFormat(const Value: string);
    procedure SetMoneyPercent(const Value: real);
    procedure SetMoneyTotals(const Value: real);
    procedure SetMoneyValue(const Value: real);
    procedure SetDecimals(const Value: integer);
    procedure SetByValue(const Value: boolean);
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
  public
    FSuppressExceptions : boolean;
    procedure MoneyEditEnter;
    procedure MoneyEditExit;
    constructor Create(aOwner : TComponent); override;
  published
    property Align;
    property Decimals : integer read FDecimals write SetDecimals;
    property ByValue : boolean read FByValue write SetByValue;
    property MoneyTotals : real read FMoneyTotals write SetMoneyTotals;
    property MoneyValue : real read FMoneyValue write SetMoneyValue;
    property MoneyPercent : real read FMoneyPercent write SetMoneyPercent;
    property FormatMoney : string read FMoneyFormat write SetMoneyFormat;
    property FormatPercent : string read FPercentFormat write SetPercentFormat;
  end;

  TMoneyPanel = class(TPanel)
  private
    FImageList: TImageList;
    FWidthPercent: integer;
    FWidthMoney: integer;
    FPercentCaption: string;
    FByValue: boolean;
    FShowPercent: boolean;
    Fvat: real;
    FPrisObj: String;
    FPrisTyp: Integer;
    procedure SetImageList(const Value: TImageList);
    procedure SetWidthMoney(const Value: integer);
    procedure SetWidthPercent(const Value: integer);
    procedure SetPercentCaption(const Value: string);
    procedure SetDecimals(const Value: integer);
    procedure SetFormatMoney(const Value: string);
    procedure SetFormatPercent(const Value: string);
    procedure SetMoneyPercent(const Value: real);
    procedure SetMoneyTotals(const Value: real);
    procedure SetMoneyValue(const Value: real);
    function GetDecimals: integer;
    function GetFormatMoney: string;
    function GetFormatPercent: string;
    function GetMoneyPercent: real;
    function GetMoneyTotals: real;
    function GetMoneyValue: real;
    procedure SetByValue(const Value: boolean);
    function GetByValue: boolean;
    procedure SetShowPercent(const Value: boolean);
    procedure Setvat(const Value: real);
    procedure SetPrisObj(const Value: String);
    procedure SetPrisTyp(const Value: Integer);
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
  public
    FPercentPanel : TPanel;
    FMoneyEdit : TMoneyEdit;
    FImage : TImage;
    procedure MoneyUpdate;
    procedure Resize; override;
    constructor Create(aOwner : TComponent);override;
    destructor destroy; override;
  published
    property vat : real read Fvat write Setvat;
    property ShowPercent : boolean read FShowPercent write SetShowPercent;
    property PercentCaption : string read FPercentCaption write SetPercentCaption;
    property ImageList : TImageList read FImageList write SetImageList;
    property WidthPercent : integer read FWidthPercent write SetWidthPercent;
    property WidthMoney : integer read FWidthMoney write SetWidthMoney;
    property Decimals : integer read GetDecimals write SetDecimals;
    property ByValue : boolean read GetByValue write SetByValue;
    property MoneyTotals : real read GetMoneyTotals write SetMoneyTotals;
    property MoneyValue : real read GetMoneyValue write SetMoneyValue;
    property MoneyPercent : real read GetMoneyPercent write SetMoneyPercent;
    property FormatMoney : string read GetFormatMoney write SetFormatMoney;
    property FormatPercent : string read GetFormatPercent write SetFormatPercent;
    property PrisObj : String read FPrisObj write SetPrisObj;
    property PrisTyp : Integer read FPrisTyp write SetPrisTyp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('muab', [TMoneyEdit, TMoneyPanel]);
end;

{ TMoneyEdit }

constructor TMoneyEdit.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FByValue := true;
  FPercentFormat := '0.0%';
  FDecimals := 4;
  case CurrencyFormat of
    0 : FMoneyFormat := CurrencyString + '0.00';
    1 : FMoneyFormat := '0.00'+CurrencyString;
    2 : FMoneyFormat := CurrencyString + ' 0.00';
    3 : FMoneyFormat := '0.00 '+CurrencyString;
  end;
end;

procedure TMoneyEdit.DoEnter;
begin
  MoneyEditEnter;
  inherited DoEnter;
end;

procedure TMoneyEdit.DoExit;
begin
  MoneyEditExit;
  inherited DoExit;
end;

procedure TMoneyEdit.MoneyEditEnter;
begin
  try
    if FByValue then
    begin
      text := formatfloat(FDecFormat,FMoneyvalue);
      if (length(text) = 2) and (pos(',',text) = 0) then
        text := text +',';
      SelectAll;
    end else begin
      text := formatfloat(FDecFormat+'%',FMoneyPercent);
      SelectAll;
    end;
  except
    if FSuppressExceptions then
      text := formatfloat(FDecFormat,0)
    else
      raise;
  end;
end;

procedure TMoneyEdit.MoneyEditExit;
var
 str : string;
begin
  try
    str := text;
    if str > '' then
    begin
      if length(str) = 2 then
      begin
        if str = '00' then
          str := '100';
        str := str + '%';
      end;
      if copy(str,length(str),1) = '%' then //Belopp i procent
      begin
        FMoneypercent := strTofloat(Copy(str,1,length(str)-1));
        FMoneyvalue := FMoneyTotals * FMoneypercent / 100;
        FByValue := false;
      end else begin  //Belopp i valuta
        FMoneyvalue := strtofloat(Copy(str,1,length(str)));
        if FMoneyTotals <> 0 then
          FMoneypercent := FMoneyvalue / FMoneyTotals * 100
        else
          FMoneypercent := 0;
        FByValue := true;
      end;
    end
    else
      FMoneyvalue := 0;
    text := formatfloat(FMoneyFormat,FMoneyvalue);
  except
    if FSuppressExceptions then
      text := formatfloat(FMoneyFormat,FMoneyvalue)
    else
      raise;
  end;
end;

procedure TMoneyEdit.SetByValue(const Value: boolean);
begin
  FByValue := Value;
end;

procedure TMoneyEdit.SetDecimals(const Value: integer);
var I : Integer;
begin
  FDecimals := Value;
  FDecFormat := '#';
  if value > 0 then
  begin
    FDecFormat := '#.';
    for I := 1 to value do
      FDecFormat := FDecFormat + '#';
  end;
end;

procedure TMoneyEdit.SetMoneyFormat(const Value: string);
begin
  FMoneyFormat := Value;
end;

procedure TMoneyEdit.SetMoneyPercent(const Value: real);
begin
  FMoneyPercent := Value;
end;

procedure TMoneyEdit.SetMoneyTotals(const Value: real);
begin
  FMoneyTotals := Value;
  if fByValue and (FMoneyTotals <> 0) then
    FMoneyPercent := FMoneyValue / FMoneyTotals * 100
  else
    FMoneyValue := FMoneyTotals * FMoneyPercent / 100;

end;

procedure TMoneyEdit.SetMoneyValue(const Value: real);
begin
  FMoneyValue := Value;
end;

procedure TMoneyEdit.SetPercentFormat(const Value: string);
begin
  FPercentFormat := Value;
end;

{ TMoneyPanel }

constructor TMoneyPanel.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  alignment := taLeftJustify;
  height := 25;
  borderwidth := 2;
  BevelOuter := bvNone;
  FPercentPanel := TPanel.Create(self);
  FPercentPanel.parent := self;
  FPercentPanel.align := alRight;
  FPercentPanel.alignment := taRightJustify;
  FPercentPanel.width := 40;
  FPercentPanel.caption := FPercentCaption;
  FPercentPanel.BevelOuter := bvNone;
  FPercentPanel.BorderWidth := 2;
  FMoneyEdit := TMoneyEdit.create(self);
  FMoneyEdit.parent := self;
  FMoneyEdit.align := alRight;
  FImage := TImage.create(self);
  FImage.parent := self;
  FImage.align := alRight;
  FImage.Width := 21;
  FImage.Transparent := true;
  FImage.Center := true;
  FWidthMoney := FMoneyEdit.width;
  FWidthPercent := FPercentPanel.width;
  FVat := -1;
end;

destructor TMoneyPanel.destroy;
begin
  FPercentPanel.free;
  FMoneyEdit.free;
  FImage.free;
  inherited destroy;
end;

procedure TMoneyPanel.DoEnter;
begin
  inherited DoEnter;
end;

procedure TMoneyPanel.DoExit;
begin
  inherited DoExit;
  MoneyUpdate;
end;

function TMoneyPanel.GetByValue: boolean;
begin
  result := FMoneyEdit.ByValue;
end;

function TMoneyPanel.GetDecimals: integer;
begin
  result := FMoneyEdit.Decimals;
end;

function TMoneyPanel.GetFormatMoney: string;
begin
  result := FMoneyEdit.FormatMoney;
end;

function TMoneyPanel.GetFormatPercent: string;
begin
  result := FMoneyEdit.FormatPercent;
end;

function TMoneyPanel.GetMoneyPercent: real;
begin
  result := FMoneyEdit.MoneyPercent;
end;

function TMoneyPanel.GetMoneyTotals: real;
begin
  result := FMoneyEdit.FMoneyTotals;
end;

function TMoneyPanel.GetMoneyValue: real;
begin
  result := FMoneyEdit.MoneyValue;
end;

procedure TMoneyPanel.MoneyUpdate;
begin
  try
    if ByValue then
    begin
      if MoneyTotals <> 0 then
        FMoneyEdit.MoneyPercent := FMoneyEdit.MoneyValue / MoneyTotals * 100
      else
        FMoneyEdit.MoneyPercent := 100;
    end else begin
      FMoneyEdit.MoneyValue := FMoneyEdit.MoneyPercent * MoneyTotals / 100;
    end;

    if FShowPercent then
      PercentCaption := formatfloat(FMoneyEdit.FPercentFormat,FMoneyEdit.MoneyPercent);
    FMoneyEdit.text := formatFloat(FMoneyEdit.FormatMoney,FMoneyEdit.MoneyValue);
    FImage.Picture.Bitmap := nil;
    if assigned(FImageList) and (FMoneyEdit.MoneyValue <> 0) then
        if FMoneyEdit.FByValue then begin
          FImageList.GetBitmap(0,FImage.Picture.Bitmap);
        end else begin
          FImageList.GetBitmap(1,FImage.Picture.Bitmap);
        end;
    if MoneyValue = 0 then
    begin
      FMoneyEdit.Text := '';
      PercentCaption := '';
    end;
  except
  end;
end;

procedure TMoneyPanel.Resize;
begin
  inherited resize;
  FPercentPanel.Left := ClientWidth - FPercentPanel.width;
  FMoneyEdit.Left := FPercentPanel.Left - FMoneyEdit.width;
  FImage.Left := FMoneyEdit.Left - FImage.width;
end;

procedure TMoneyPanel.SetByValue(const Value: boolean);
begin
  FMoneyEdit.ByValue := Value;
end;

procedure TMoneyPanel.SetDecimals(const Value: integer);
begin
  FMoneyEdit.Decimals := Value;
end;

procedure TMoneyPanel.SetFormatMoney(const Value: string);
begin
  FMoneyEdit.FormatMoney := Value;
end;

procedure TMoneyPanel.SetFormatPercent(const Value: string);
begin
  FMoneyEdit.FormatPercent := Value;
end;

procedure TMoneyPanel.SetImageList(const Value: TImageList);
begin
  FImageList := Value;
end;


procedure TMoneyPanel.SetMoneyPercent(const Value: real);
begin
  ByValue := false;
  FMoneyEdit.MoneyPercent := Value;
  MoneyUpdate;
end;

procedure TMoneyPanel.SetMoneyTotals(const Value: real);
begin
  FMoneyEdit.MoneyTotals := Value;
  MoneyUpdate;
end;

procedure TMoneyPanel.SetMoneyValue(const Value: real);
begin
  ByValue := true;
  FMoneyEdit.MoneyValue := Value;
  MoneyUpdate;
end;

procedure TMoneyPanel.SetPercentCaption(const Value: string);
begin
  FPercentCaption := Value;
  if FShowPercent then
    FPercentPanel.Caption := value;
end;

procedure TMoneyPanel.SetPrisObj(const Value: String);
begin
  FPrisObj := Value;
end;

procedure TMoneyPanel.SetPrisTyp(const Value: Integer);
begin
  FPrisTyp := Value;
end;

procedure TMoneyPanel.SetShowPercent(const Value: boolean);
begin
  FShowPercent := Value;
end;

procedure TMoneyPanel.Setvat(const Value: real);
begin
  Fvat := Value;
end;

procedure TMoneyPanel.SetWidthMoney(const Value: integer);
begin
  FWidthMoney := Value;
  FMoneyEdit.width := value;
  Resize;
end;

procedure TMoneyPanel.SetWidthPercent(const Value: integer);
begin
  FWidthPercent := Value;
  FPercentPanel.width := value;
  Resize;
end;

end.
