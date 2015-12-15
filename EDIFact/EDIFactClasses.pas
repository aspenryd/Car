unit EDIFactClasses;

interface
uses
  SysUtils, Classes, Windows, Messages, Variants, DateUtils, Controls;
type
  EOdetteException = Exception;

  TFieldType = (ftString, ftInteger, ftDate, ftDateTime, ftReal, ftBool);
  TOdetteCollectionClass = class;

  TOdetteClass = class(TObject)
  private
    FPropName: string;
    function GetPropName: string; virtual;
  public
    function CheckIfValid(value: variant; valuetype: TFieldType; propName: string): boolean; overload;
    function CheckIfValid(valueobject: TOdetteClass; propName: string): boolean; overload;
    function CheckIfValid(valueobject: TOdetteCollectionClass; propName: string): boolean; overload;
    function CheckIfValid(valueobject: TCollection; propName: string): boolean; overload;
    function HasValidFields: boolean; virtual;
  end;

  TOdetteCollectionClass = class(TCollectionItem)
  private
    FPropName: string;
    function GetPropName: string; virtual;
  public
    function CheckIfValid(value: variant; valuetype: TFieldType; propName: string): boolean; overload;
    function CheckIfValid(valueobject: TOdetteClass; propName: string): boolean; overload;
    function CheckIfValid(valueobject: TOdetteCollectionClass; propName: string): boolean; overload;
    function CheckIfValid(valueobject: TCollection; propName: string): boolean; overload;
    function HasValidFields: boolean; virtual;
  end;

  TPersonInfo = class(TOdetteClass)
  private
    FContactInfo: string;
    FDepartment: string;
    FCommunicationCode: string;
    FName: string;
    procedure SetCommunicationCode(const Value: string);
    procedure SetContactInfo(const Value: string);
    procedure SetDepartment(const Value: string);
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
    property Department: string read FDepartment write SetDepartment;
    property ContactInfo: string read FContactInfo write SetContactInfo;
    property CommunicationCode: string read FCommunicationCode write SetCommunicationCode;
    function HasValidFields: boolean; override;
  end;

  TSupplierInfo = class(TOdetteClass)
  private
    FQualifier: string;
    FCountryCode: string;
    FLogicalAddress: string;
    FZipCode: string;
    FInternalAddress: string;
    FStreet: string;
    FCity: string;
    FSalesRep: TPersonInfo;
    FAccountsReceivable: TPersonInfo;
    FSupplierID: string;
    FName: string;
    FVATNumber: string;
    procedure SetAccountsReceivable(const Value: TPersonInfo);
    procedure SetCity(const Value: string);
    procedure SetCountryCode(const Value: string);
    procedure SetInternalAddress(const Value: string);
    procedure SetLogicalAddress(const Value: string);
    procedure SetQualifier(const Value: string);
    procedure SetSalesRep(const Value: TPersonInfo);
    procedure SetStreet(const Value: string);
    procedure SetZipCode(const Value: string);
    procedure SetName(const Value: string);
    procedure SetSupplierID(const Value: string);
    procedure SetVATNumber(const Value: string);
  public
    property Name: string read FName write SetName;
    property SupplierID: string read FSupplierID write SetSupplierID;
    property LogicalAddress: string read FLogicalAddress write SetLogicalAddress;
    property Qualifier: string read FQualifier write SetQualifier;
    property InternalAddress: string read FInternalAddress write SetInternalAddress;
    property City: string read FCity write SetCity;
    property Street: string read FStreet write SetStreet;
    property ZipCode: string read FZipCode write SetZipCode;
    property CountryCode: string read FCountryCode write SetCountryCode;
    property AccountsReceivable: TPersonInfo read FAccountsReceivable write SetAccountsReceivable;
    property SalesRep: TPersonInfo read FSalesRep write SetSalesRep;
    property VATNumber: string read FVATNumber write SetVATNumber;
    function HasValidFields: boolean; override;
    constructor Create();
    destructor Destroy(); override;
  end;

  TVolvoInfo = class(TOdetteClass)
  private
    FStreet: string;
    FInternalAddress: string;
    FLogicalAddress: string;
    FVATNumber: string;
    FZipCode: string;
    FQualifier: string;
    FCountryCode: string;
    FCity: string;
    FVolvoUnit: string;
    FReferencePerson: TPersonInfo;
    procedure SetCity(const Value: string);
    procedure SetCountryCode(const Value: string);
    procedure SetInternalAddress(const Value: string);
    procedure SetLogicalAddress(const Value: string);
    procedure SetQualifier(const Value: string);
    procedure SetReferencePerson(const Value: TPersonInfo);
    procedure SetStreet(const Value: string);
    procedure SetVATNumber(const Value: string);
    procedure SetVolvoUnit(const Value: string);
    procedure SetZipCode(const Value: string);
  public
    property LogicalAddress: string read FLogicalAddress write SetLogicalAddress;
    property Qualifier: string read FQualifier write SetQualifier;
    property InternalAddress: string read FInternalAddress write SetInternalAddress;
    property VATNumber: string read FVATNumber write SetVATNumber;
    property VolvoUnit: string read FVolvoUnit write SetVolvoUnit;
    property City: string read FCity write SetCity;
    property Street: string read FStreet write SetStreet;
    property ZipCode: string read FZipCode write SetZipCode;
    property CountryCode: string read FCountryCode write SetCountryCode;
    property ReferencePerson: TPersonInfo read FReferencePerson write SetReferencePerson;
    function HasValidFields: boolean; override;
    constructor Create();
    destructor Destroy(); override;
  end;

  TPayeeInfo = class(TOdetteClass)
  private
    FZipCode: string;
    FCountryCode: string;
    FCity: string;
    FAccountNumber: string;
    FAccountHolder: string;
    FBank: string;
    FStreet: string;
    FSalesRep: TPersonInfo;
    FAccountsReceivable: TPersonInfo;
    FName: string;
    FParmaNumber: string;
    procedure SetAccountHolder(const Value: string);
    procedure SetAccountNumber(const Value: string);
    procedure SetAccountsReceivable(const Value: TPersonInfo);
    procedure SetBank(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetCountryCode(const Value: string);
    procedure SetSalesRep(const Value: TPersonInfo);
    procedure SetStreet(const Value: string);
    procedure SetZipCode(const Value: string);
    procedure SetName(const Value: string);
    procedure SetParmaNumber(const Value: string);
  public
    property Name: string read FName write SetName;
    property AccountNumber: string read FAccountNumber write SetAccountNumber;
    property AccountHolder: string read FAccountHolder write SetAccountHolder;
    property ParmaNumber: string read FParmaNumber write SetParmaNumber;
    property Bank: string read FBank write SetBank;
    property City: string read FCity write SetCity;
    property Street: string read FStreet write SetStreet;
    property ZipCode: string read FZipCode write SetZipCode;
    property CountryCode: string read FCountryCode write SetCountryCode;
    property AccountsReceivable: TPersonInfo read FAccountsReceivable write SetAccountsReceivable;
    property SalesRep: TPersonInfo read FSalesRep write SetSalesRep;
    function HasValidFields: boolean; override;
    constructor Create();
    destructor Destroy(); override;
  end;


  TInvoiceItem = class(TOdetteCollectionClass)
  private
    FQuantity: integer;
    FVolvoItemNumber: integer;
    FSupplierItemNumber: integer;
    FAGrossPrice: real;
    FVATAmount: real;
    FLangCode: string;
    FVATCategoryCode: string;
    FVolvoOrderNumber: string;
    FVATRate: string;
    FDescription: string;
    FAmount: real;
    FVolvoOrderLineNumber: integer;
    procedure SetAGrossPrice(const Value: real);
    procedure SetDescription(const Value: string);
    procedure SetLangCode(const Value: string);
    procedure SetQuantity(const Value: integer);
    procedure SetSupplierItemNumber(const Value: integer);
    procedure SetVATAmount(const Value: real);
    procedure SetVATCategoryCode(const Value: string);
    procedure SetVATRate(const Value: string);
    procedure SetVolvoItemNumber(const Value: integer);
    procedure SetVolvoOrderNumber(const Value: string);
    procedure SetAmount(const Value: real);
    procedure SetVolvoOrderLineNumber(const Value: integer);
  public
    property VolvoItemNumber: integer read FVolvoItemNumber write SetVolvoItemNumber;
    property SupplierItemNumber: integer read FSupplierItemNumber write SetSupplierItemNumber;
    property Description: string read FDescription write SetDescription;
    property LangCode: string read FLangCode write SetLangCode;
    property Amount: real read FAmount write SetAmount;
    property Quantity: integer read FQuantity write SetQuantity;
    property AGrossPrice: real read FAGrossPrice write SetAGrossPrice;
    property VATRate: string read FVATRate write SetVATRate;
    property VATCategoryCode: string read FVATCategoryCode write SetVATCategoryCode;
    property VATAmount: real read FVATAmount write SetVATAmount;
    property VolvoOrderNumber: string read FVolvoOrderNumber write SetVolvoOrderNumber;
    property VolvoOrderLineNumber: integer read FVolvoOrderLineNumber write SetVolvoOrderLineNumber;
    function HasValidFields: boolean; override;
  end;

  TInvoiceItemList = class(TCollection)
  private
    function GetItem(Index: Integer): TInvoiceItem;
  public
    constructor Create;
    function Add: TInvoiceItem;
    property Item[Index: Integer]: TInvoiceItem read GetItem; default;
  end;

  TInvoiceInfo = class(TOdetteClass)
  private
    FTotalTaxableAmount: real;
    FTotalItemsAmount: real;
    FTotalTaxAmount: real;
    FTotalInvoiceAmount: real;
    FExchangeRate: string;
    FInvoiceNumber: string;
    FReferenceNumber: string;
    FCurrency: string;
    FHomeCurrency: string;
    FInvoiceDate: TDate;
    FExchangeRateDate: TDate;
    FInvoiceItems: TInvoiceItemList;
    procedure SetCurrency(const Value: string);
    procedure SetExchangeRate(const Value: string);
    procedure SetExchangeRateDate(const Value: TDate);
    procedure SetHomeCurrency(const Value: string);
    procedure SetInvoiceDate(const Value: TDate);
    procedure SetInvoiceItems(const Value: TInvoiceItemList);
    procedure SetInvoiceNumber(const Value: string);
    procedure SetReferenceNumber(const Value: string);
    procedure SetTotalInvoiceAmount(const Value: real);
    procedure SetTotalItemsAmount(const Value: real);
    procedure SetTotalTaxableAmount(const Value: real);
    procedure SetTotalTaxAmount(const Value: real);
  public
    property ReferenceNumber: string read FReferenceNumber write SetReferenceNumber;
    property InvoiceNumber: string read FInvoiceNumber write SetInvoiceNumber;
    property InvoiceDate: TDate read FInvoiceDate write SetInvoiceDate;
    property Currency: string read FCurrency write SetCurrency;
    property HomeCurrency: string read FHomeCurrency write SetHomeCurrency;
    property ExchangeRate: string read FExchangeRate write SetExchangeRate;
    property ExchangeRateDate: TDate read FExchangeRateDate write SetExchangeRateDate;
    property TotalInvoiceAmount: real read FTotalInvoiceAmount write SetTotalInvoiceAmount;
    property TotalTaxableAmount: real read FTotalTaxableAmount write SetTotalTaxableAmount;
    property TotalTaxAmount: real read FTotalTaxAmount write SetTotalTaxAmount;
    property TotalItemsAmount: real read FTotalItemsAmount write SetTotalItemsAmount;
    property InvoiceItems: TInvoiceItemList read FInvoiceItems write SetInvoiceItems;
    function HasValidFields: boolean; override;
    constructor Create();
    destructor Destroy(); override;
  end;




  TEdiFactInfo = class(TOdetteClass)
  private
    FIsTest: boolean;
    FReferenceNumber: string;
    FTimeStamp: TDateTime;
    FInvoice: TInvoiceInfo;
    FSupplier: TSupplierInfo;
    FVolvo: TVolvoInfo;
    FVATNumber: string;
    FPayee: TPayeeInfo;
    procedure SetInvoice(const Value: TInvoiceInfo);
    procedure SetIsTest(const Value: boolean);
    procedure SetReferenceNumber(const Value: string);
    procedure SetSupplier(const Value: TSupplierInfo);
    procedure SetTimeStamp(const Value: TDateTime);
    procedure SetVolvo(const Value: TVolvoInfo);
    function GetPropName: string; override;
    procedure SetVATNumber(const Value: string);
    procedure SetPayee(const Value: TPayeeInfo);
  public
    property Supplier: TSupplierInfo read FSupplier write SetSupplier;
    property Volvo: TVolvoInfo read FVolvo write SetVolvo;
    property Payee: TPayeeInfo read FPayee write SetPayee;
    property TimeStamp: TDateTime read FTimeStamp write SetTimeStamp;
    property ReferenceNumber: string read FReferenceNumber write SetReferenceNumber;
    property Invoice: TInvoiceInfo read FInvoice write SetInvoice;
    property IsTest: boolean read FIsTest write SetIsTest;
    property VATNumber: string read FVATNumber write SetVATNumber;
    function HasValidFields: boolean; override;

    constructor Create();
    destructor Destroy(); override;
  end;

  TEdiFactEngine = class(TObject)
  private
    FEdiFactInfo: TEdiFactInfo;
    procedure SetEdiFactInfo(const Value: TEdiFactInfo);

  public
    property EdiFactInfo: TEdiFactInfo read FEdiFactInfo write SetEdiFactInfo;
    function CheckValidFields: boolean;
    function GetEdiFactText: string;
    constructor Create();
    destructor Destroy(); override;
  end;




implementation

{ TPersonInfo }

function TPersonInfo.HasValidFields: boolean;
begin
  result := true;
  result := result and CheckIfValid(FContactInfo, ftString, GetPropName + '.ContactInfo');
  result := result and CheckIfValid(FDepartment, ftString, GetPropName + '.Department');
  result := result and CheckIfValid(FCommunicationCode, ftString, GetPropName + '.CommunicationCode');
  result := result and CheckIfValid(FName, ftString, GetPropName + '.Name');
end;

procedure TPersonInfo.SetCommunicationCode(const Value: string);
begin
  FCommunicationCode := Value;
end;

procedure TPersonInfo.SetContactInfo(const Value: string);
begin
  FContactInfo := Value;
end;

procedure TPersonInfo.SetDepartment(const Value: string);
begin
  FDepartment := Value;
end;

procedure TPersonInfo.SetName(const Value: string);
begin
  FName := Value;
end;

{ TSupplierInfo }

constructor TSupplierInfo.Create;
begin
  FSalesRep:= TPersonInfo.Create();
  FAccountsReceivable:= TPersonInfo.Create;
end;

destructor TSupplierInfo.Destroy;
begin
  FreeAndNil(FSalesRep);
  FreeAndNil(FAccountsReceivable);
  inherited;
end;

function TSupplierInfo.HasValidFields: boolean;
begin
  result := true;
  result := result and CheckIfValid(FQualifier, ftString, GetPropName + '.Qualifier');
  result := result and CheckIfValid(FCountryCode, ftString, GetPropName + '.CountryCode');
  result := result and CheckIfValid(FLogicalAddress, ftString, GetPropName + '.LogicalAddress');
  result := result and CheckIfValid(FZipCode, ftString, GetPropName + '.ZipCode');
  result := result and CheckIfValid(FInternalAddress, ftString, GetPropName + '.InternalAddress');
  result := result and CheckIfValid(FStreet, ftString, GetPropName + '.Street');
  result := result and CheckIfValid(FCity, ftString, GetPropName + '.City');
  result := result and CheckIfValid(FSalesRep, GetPropName + '.SalesRep');
  result := result and CheckIfValid(FAccountsReceivable, GetPropName + '.AccountsReceivable');

end;

procedure TSupplierInfo.SetAccountsReceivable(const Value: TPersonInfo);
begin
  FAccountsReceivable := Value;
end;

procedure TSupplierInfo.SetCity(const Value: string);
begin
  FCity := Value;
end;

procedure TSupplierInfo.SetCountryCode(const Value: string);
begin
  FCountryCode := Value;
end;

procedure TSupplierInfo.SetInternalAddress(const Value: string);
begin
  FInternalAddress := Value;
end;

procedure TSupplierInfo.SetLogicalAddress(const Value: string);
begin
  FLogicalAddress := Value;
end;

procedure TSupplierInfo.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TSupplierInfo.SetQualifier(const Value: string);
begin
  FQualifier := Value;
end;

procedure TSupplierInfo.SetSalesRep(const Value: TPersonInfo);
begin
  FSalesRep := Value;
end;

procedure TSupplierInfo.SetStreet(const Value: string);
begin
  FStreet := Value;
end;

procedure TSupplierInfo.SetSupplierID(const Value: string);
begin
  FSupplierID := Value;
end;

procedure TSupplierInfo.SetVATNumber(const Value: string);
begin
  FVATNumber := Value;
end;

procedure TSupplierInfo.SetZipCode(const Value: string);
begin
  FZipCode := Value;
end;

{ TVolvoInfo }

constructor TVolvoInfo.Create;
begin
    FReferencePerson:= TPersonInfo.Create;

end;

destructor TVolvoInfo.Destroy;
begin
  FreeAndNil(FReferencePerson);
  inherited;
end;

function TVolvoInfo.HasValidFields: boolean;
begin
  result := true;
  result := result and CheckIfValid(FStreet, ftString, GetPropName + '.Street');
  result := result and CheckIfValid(FInternalAddress, ftString, GetPropName + '.InternalAddress');
  result := result and CheckIfValid(FLogicalAddress, ftString, GetPropName + '.LogicalAddress');
  result := result and CheckIfValid(FVATNumber, ftString, GetPropName + '.VATNumber');
  result := result and CheckIfValid(FZipCode, ftString, GetPropName + '.ZipCode');
  result := result and CheckIfValid(FQualifier, ftString, GetPropName + '.Qualifier');
  result := result and CheckIfValid(FCountryCode, ftString, GetPropName + '.CountryCode');
  result := result and CheckIfValid(FCity, ftString, GetPropName + '.City');
  result := result and CheckIfValid(FVolvoUnit, ftString, GetPropName + '.VolvoUnit');
  result := result and CheckIfValid(FReferencePerson, GetPropName + '.ReferencePerson');

end;

procedure TVolvoInfo.SetCity(const Value: string);
begin
  FCity := Value;
end;

procedure TVolvoInfo.SetCountryCode(const Value: string);
begin
  FCountryCode := Value;
end;

procedure TVolvoInfo.SetInternalAddress(const Value: string);
begin
  FInternalAddress := Value;
end;

procedure TVolvoInfo.SetLogicalAddress(const Value: string);
begin
  FLogicalAddress := Value;
end;

procedure TVolvoInfo.SetQualifier(const Value: string);
begin
  FQualifier := Value;
end;

procedure TVolvoInfo.SetReferencePerson(const Value: TPersonInfo);
begin
  FReferencePerson := Value;
end;

procedure TVolvoInfo.SetStreet(const Value: string);
begin
  FStreet := Value;
end;

procedure TVolvoInfo.SetVATNumber(const Value: string);
begin
  FVATNumber := Value;
end;

procedure TVolvoInfo.SetVolvoUnit(const Value: string);
begin
  FVolvoUnit := Value;
end;

procedure TVolvoInfo.SetZipCode(const Value: string);
begin
  FZipCode := Value;
end;

{ TPayeeInfo }

constructor TPayeeInfo.Create;
begin
    FSalesRep:= TPersonInfo.Create;
    FAccountsReceivable:= TPersonInfo.Create;

end;

destructor TPayeeInfo.Destroy;
begin
  FreeAndNil(FSalesRep);
  FreeAndNil(FAccountsReceivable);
  inherited;
end;

function TPayeeInfo.HasValidFields: boolean;
begin
  result := true;
  result := result and CheckIfValid(FZipCode, ftString, GetPropName + '.ZipCode');
  result := result and CheckIfValid(FCountryCode, ftString, GetPropName + '.CountryCode');
  result := result and CheckIfValid(FCity, ftString, GetPropName + '.City');
  result := result and CheckIfValid(FAccountNumber, ftString, GetPropName + '.AccountNumber');
  result := result and CheckIfValid(FAccountHolder, ftString, GetPropName + '.AccountHolder');
  result := result and CheckIfValid(FBank, ftString, GetPropName + '.Bank');
  result := result and CheckIfValid(FStreet, ftString, GetPropName + '.Street');
  result := result and CheckIfValid(FSalesRep, GetPropName + '.SalesRep');
  result := result and CheckIfValid(FAccountsReceivable, GetPropName + '.AccountsReceivable');

end;

procedure TPayeeInfo.SetAccountHolder(const Value: string);
begin
  FAccountHolder := Value;
end;

procedure TPayeeInfo.SetAccountNumber(const Value: string);
begin
  FAccountNumber := Value;
end;

procedure TPayeeInfo.SetAccountsReceivable(const Value: TPersonInfo);
begin
  FAccountsReceivable := Value;
end;

procedure TPayeeInfo.SetBank(const Value: string);
begin
  FBank := Value;
end;

procedure TPayeeInfo.SetCity(const Value: string);
begin
  FCity := Value;
end;

procedure TPayeeInfo.SetCountryCode(const Value: string);
begin
  FCountryCode := Value;
end;

procedure TPayeeInfo.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TPayeeInfo.SetParmaNumber(const Value: string);
begin
  FParmaNumber := Value;
end;

procedure TPayeeInfo.SetSalesRep(const Value: TPersonInfo);
begin
  FSalesRep := Value;
end;

procedure TPayeeInfo.SetStreet(const Value: string);
begin
  FStreet := Value;
end;

procedure TPayeeInfo.SetZipCode(const Value: string);
begin
  FZipCode := Value;
end;

{ TInvoiceItem }

function TInvoiceItem.HasValidFields: boolean;
begin
  result := true;
  result := result and CheckIfValid(FAmount, ftReal, GetPropName + '.Amount');
  result := result and CheckIfValid(FQuantity, ftInteger, GetPropName + '.Quantity');
  result := result and CheckIfValid(FVolvoItemNumber, ftInteger, GetPropName + '.VolvoItemNumber');
  result := result and CheckIfValid(FSupplierItemNumber, ftInteger, GetPropName + '.SupplierItemNumber');
  result := result and CheckIfValid(FAGrossPrice, ftReal, GetPropName + '.AGrossPrice');
  result := result and CheckIfValid(FVATAmount, ftReal, GetPropName + '.VATAmount');
  result := result and CheckIfValid(FLangCode, ftString, GetPropName + '.LangCode');
  result := result and CheckIfValid(FVATCategoryCode, ftString, GetPropName + '.VATCategoryCode');
  result := result and CheckIfValid(FVolvoOrderNumber, ftString, GetPropName + '.VolvoOrderNumber');
  result := result and CheckIfValid(FVATRate, ftString, GetPropName + '.VATRate');
  result := result and CheckIfValid(FDescription, ftString, GetPropName + '.Description');

end;

procedure TInvoiceItem.SetAGrossPrice(const Value: real);
begin
  FAGrossPrice := Value;
end;


procedure TInvoiceItem.SetAmount(const Value: real);
begin
  FAmount := Value;
end;

procedure TInvoiceItem.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TInvoiceItem.SetLangCode(const Value: string);
begin
  FLangCode := Value;
end;

procedure TInvoiceItem.SetQuantity(const Value: integer);
begin
  FQuantity := Value;
end;

procedure TInvoiceItem.SetSupplierItemNumber(const Value: integer);
begin
  FSupplierItemNumber := Value;
end;

procedure TInvoiceItem.SetVATAmount(const Value: real);
begin
  FVATAmount := Value;
end;

procedure TInvoiceItem.SetVATCategoryCode(const Value: string);
begin
  FVATCategoryCode := Value;
end;

procedure TInvoiceItem.SetVATRate(const Value: string);
begin
  FVATRate := Value;
end;

procedure TInvoiceItem.SetVolvoItemNumber(const Value: integer);
begin
  FVolvoItemNumber := Value;
end;

procedure TInvoiceItem.SetVolvoOrderLineNumber(const Value: integer);
begin
  FVolvoOrderLineNumber := Value;
end;

procedure TInvoiceItem.SetVolvoOrderNumber(const Value: string);
begin
  FVolvoOrderNumber := Value;
end;

{ TInvoiceItemList }

function TInvoiceItemList.Add: TInvoiceItem;
begin
  result := inherited Add as TInvoiceItem;
end;

constructor TInvoiceItemList.Create;
begin
  inherited Create(TInvoiceItem)
end;

function TInvoiceItemList.GetItem(Index: Integer): TInvoiceItem;
begin
  result := inherited Items[Index] as TInvoiceItem;
end;

{ TInvoiceInfo }

constructor TInvoiceInfo.Create;
begin
    FInvoiceItems:= TInvoiceItemList.Create;

end;

destructor TInvoiceInfo.Destroy;
begin
  FreeAndNil(FInvoiceItems);
  inherited;
end;

function TInvoiceInfo.HasValidFields: boolean;
begin
  result := true;
  result := result and CheckIfValid(FTotalTaxableAmount, ftReal, GetPropName + '.TotalTaxableAmount');
  result := result and CheckIfValid(FTotalItemsAmount, ftReal, GetPropName + '.TotalItemsAmount');
  result := result and CheckIfValid(FTotalTaxAmount, ftReal, GetPropName + '.TotalTaxAmount');
  result := result and CheckIfValid(FTotalInvoiceAmount, ftReal, GetPropName + '.TotalInvoiceAmount');
  result := result and CheckIfValid(FExchangeRate, ftString, GetPropName + '.ExchangeRate');
  result := result and CheckIfValid(FInvoiceNumber, ftString, GetPropName + '.InvoiceNumber');
  result := result and CheckIfValid(FReferenceNumber, ftString, GetPropName + '.ReferenceNumber');
  result := result and CheckIfValid(FCurrency, ftString, GetPropName + '.Currency');
  result := result and CheckIfValid(FHomeCurrency, ftString, GetPropName + '.HomeCurrency');
  result := result and CheckIfValid(FInvoiceDate, ftDate, GetPropName + '.InvoiceDate');
  result := result and CheckIfValid(FExchangeRateDate, ftDate, GetPropName + '.ExchangeRateDate');
  result := result and CheckIfValid(FInvoiceItems, GetPropName + '.InvoiceItems');

end;

procedure TInvoiceInfo.SetCurrency(const Value: string);
begin
  FCurrency := Value;
end;

procedure TInvoiceInfo.SetExchangeRate(const Value: string);
begin
  FExchangeRate := Value;
end;

procedure TInvoiceInfo.SetExchangeRateDate(const Value: TDate);
begin
  FExchangeRateDate := Value;
end;

procedure TInvoiceInfo.SetHomeCurrency(const Value: string);
begin
  FHomeCurrency := Value;
end;

procedure TInvoiceInfo.SetInvoiceDate(const Value: TDate);
begin
  FInvoiceDate := Value;
end;

procedure TInvoiceInfo.SetInvoiceItems(const Value: TInvoiceItemList);
begin
  FInvoiceItems := Value;
end;

procedure TInvoiceInfo.SetInvoiceNumber(const Value: string);
begin
  FInvoiceNumber := Value;
end;

procedure TInvoiceInfo.SetReferenceNumber(const Value: string);
begin
  FReferenceNumber := Value;
end;

procedure TInvoiceInfo.SetTotalInvoiceAmount(const Value: real);
begin
  FTotalInvoiceAmount := Value;
end;

procedure TInvoiceInfo.SetTotalItemsAmount(const Value: real);
begin
  FTotalItemsAmount := Value;
end;

procedure TInvoiceInfo.SetTotalTaxableAmount(const Value: real);
begin
  FTotalTaxableAmount := Value;
end;

procedure TInvoiceInfo.SetTotalTaxAmount(const Value: real);
begin
  FTotalTaxAmount := Value;
end;

{ TEdiFactInfo }

constructor TEdiFactInfo.Create;
begin
  FInvoice:= TInvoiceInfo.Create;
  FSupplier:= TSupplierInfo.Create;
  FVolvo:= TVolvoInfo.Create;
  FPayee:= TPayeeInfo.Create;

end;

destructor TEdiFactInfo.Destroy;
begin
  FreeAndNil(FInvoice);
  FreeAndNil(FSupplier);
  FreeAndNil(FVolvo);
  FreeAndNil(FPayee);
  inherited;
end;

function TEdiFactInfo.GetPropName: string;
begin
  result := 'EdiFactInfo';
end;

function TEdiFactInfo.HasValidFields: boolean;
begin
  result := true;
  result := result and CheckIfValid(FIsTest, ftBool, GetPropName + '.IsTest');
  result := result and CheckIfValid(FReferenceNumber, ftString, GetPropName + '.ReferenceNumber');
  result := result and CheckIfValid(FTimeStamp, ftDateTime, GetPropName + '.TimeStamp');
  result := result and CheckIfValid(FInvoice, GetPropName + '.Invoice');
  result := result and CheckIfValid(FSupplier, GetPropName + '.Supplier');
  result := result and CheckIfValid(FVolvo, GetPropName + '.Volvo');
end;

procedure TEdiFactInfo.SetInvoice(const Value: TInvoiceInfo);
begin
  FInvoice := Value;
end;

procedure TEdiFactInfo.SetIsTest(const Value: boolean);
begin
  FIsTest := Value;
end;

procedure TEdiFactInfo.SetPayee(const Value: TPayeeInfo);
begin
  FPayee := Value;
end;

procedure TEdiFactInfo.SetReferenceNumber(const Value: string);
begin
  FReferenceNumber := Value;
end;

procedure TEdiFactInfo.SetSupplier(const Value: TSupplierInfo);
begin
  FSupplier := Value;
end;

procedure TEdiFactInfo.SetTimeStamp(const Value: TDateTime);
begin
  FTimeStamp := Value;
end;

procedure TEdiFactInfo.SetVATNumber(const Value: string);
begin
  FVATNumber := Value;
end;

procedure TEdiFactInfo.SetVolvo(const Value: TVolvoInfo);
begin
  FVolvo := Value;
end;

{ TEdiFectEngine }

function TEdiFactEngine.CheckValidFields: boolean;
begin
  result := true;
end;

constructor TEdiFactEngine.Create;
begin
  FEdiFactInfo:= TEdiFactInfo.Create;

end;

destructor TEdiFactEngine.Destroy;
begin
  FreeAndNil(FEdiFactInfo);
  inherited;
end;

function TEdiFactEngine.GetEdiFactText: string;
var
  sl: tstringlist;
  i: integer;
  VatSum25: real;
  VatSum21: real;
  VatSum12: real;
  VatSum6: real;
  VatSum0: real;
  VatVatSum25: real;
  VatVatSum21: real;
  VatVatSum12: real;
  VatVatSum6: real;
  VatVatSum0: real;
  VatCode25: string;
  VatCode21: string;
  VatCode12: string;
  VatCode6: string;
  VatCode0: string;
  LTotAmount: real;

  procedure AddVatSum(VatRate: string; Amount, VatAmount: real; VatCode : string);
  begin
    if VatRate = '25' then
    begin
      VatSum25 := VatSum25 + Amount;
      VatVatSum25 := VatVatSum25 + VatAmount;
      VatCode25 := VatCode;
    end;
    if VatRate = '21' then
    begin
      VatSum21 := VatSum12 + Amount;
      VatVatSum21 := VatVatSum12 + VatAmount;
      VatCode21 := VatCode;
    end;
    if VatRate = '12' then
    begin
      VatSum12 := VatSum12 + Amount;
      VatVatSum12 := VatVatSum12 + VatAmount;
      VatCode12 := VatCode;
    end;
    if VatRate = '6' then
    begin
      VatSum6 := VatSum6 + Amount;
      VatVatSum6 := VatVatSum6 + VatAmount;
      VatCode6 := VatCode;
    end;
    if VatRate = '0' then
    begin
      VatSum0 := VatSum0 + Amount;
      VatVatSum0 := VatVatSum0 + VatAmount;
      VatCode0 := VatCode;
    end;
  end;
begin
  result := '';
  VatSum25 := 0;
  VatSum21 := 0;
  VatSum12 := 0;
  VatSum6 := 0;
  VatSum0 := 0;
  LTotAmount := 0;
  if CheckValidFields then
  begin
    sl := tstringlist.Create();
    try
      with EdiFactInfo do
      begin
        if IsTest then
          sl.Add(format('UNB+UNOC:3+%s:%s:%s+%s:%s:%s+%s+%s++++++1''', [Supplier.LogicalAddress, Supplier.Qualifier, Supplier.InternalAddress, Volvo.LogicalAddress, Volvo.Qualifier, Volvo.InternalAddress, FormatDateTime('yymmdd:hhnn', TimeStamp), ReferenceNumber]))
        else
          sl.Add(format('UNB+UNOC:3+%s:%s:%s+%s:%s:%s+%s+%s''', [Supplier.LogicalAddress, Supplier.Qualifier, Supplier.InternalAddress, Volvo.LogicalAddress, Volvo.Qualifier, Volvo.InternalAddress, FormatDateTime('yymmdd:hhnn', TimeStamp), ReferenceNumber]));
        sl.Add(format('UNH+%s+INVOIC:D:03A:UN:GMI012''', [ReferenceNumber]));
        sl.Add(format('BGM+380+%s''', [Invoice.InvoiceNumber]));
        sl.Add(format('DTM+137:%s:102''', [FormatDateTime('yyyymmdd', Invoice.InvoiceDate)]));
//        sl.Add(format('FTX+%s+++%s+%s''', ['', '', ''])); //Code,Text, Language Code
        sl.Add(format('GEI+%s+::272''', ['OM'])); //om

        sl.Add(format('NAD+BY+%s::91++%s+%s+%s++%s+%s''', [Volvo.InternalAddress, Volvo.VolvoUnit, Volvo.Street, Volvo.City, Volvo.ZipCode, Volvo.CountryCode]));
        sl.Add(format('RFF+VA:%s''', [Volvo.VATNumber]));
        sl.Add(format('CTA+PD+%s:%s''',[Volvo.ReferencePerson.Department, Volvo.ReferencePerson.Name]));
        sl.Add(format('COM+%s:%s''', [Volvo.ReferencePerson.ContactInfo, Volvo.ReferencePerson.CommunicationCode]));

        sl.Add(format('NAD+SE+%s::92++%s+%s+%s++%s+%s''', [Supplier.SupplierID, Supplier.Name, Supplier.Street, Supplier.City, Supplier.ZipCode, Supplier.CountryCode]));

        sl.Add(format('RFF+VA:%s''', [Supplier.VATNumber]));
        sl.Add(format('CTA+AD+%s:%s''', [Supplier.AccountsReceivable.Department, Supplier.AccountsReceivable.Name]));
        sl.Add(format('COM+%s:%s''', [Supplier.AccountsReceivable.ContactInfo, Supplier.AccountsReceivable.CommunicationCode]));
        sl.Add(format('CTA+SR+%s: %s''', [Supplier.SalesRep.Department, Supplier.SalesRep.Name]));
        sl.Add(format('COM+%s:%s''', [Supplier.SalesRep.ContactInfo, Supplier.SalesRep.CommunicationCode]));
        sl.Add(format('NAD+FH++%s:%s:%s:%s''', [Supplier.Name, Supplier.Street, Supplier.City, Supplier.CountryCode]));
        sl.Add(format('NAD+PE+%s::92++%s+%s+%s++%s+%s''', [Payee.ParmaNumber, Payee.Name, Payee.Street, Payee.City, Payee.ZipCode, Payee.CountryCode]));
        sl.Add(format('FII+BF+%s:%s+::::::%s''', [Payee.AccountNumber, Payee.AccountHolder, Payee.Bank]));
        sl.Add(format('CUX+2:%s:4+3:%s:3+%s''',['SEK', '', '']));
        for i := 0 to Invoice.InvoiceItems.count-1 do
        begin
          sl.Add(format('LIN+%d++%d:IN''',[i+1, Invoice.InvoiceItems[i].VolvoItemNumber]));
          sl.Add(format('IMD+++:::%s::%s''', [Invoice.InvoiceItems[i].Description, Invoice.InvoiceItems[i].LangCode]));
          sl.Add(format('QTY+47:%d''', [Invoice.InvoiceItems[i].Quantity]));
          sl.Add(format('MOA+38:%f''', [Invoice.InvoiceItems[i].Amount]));
          sl.Add(format('PRI+AAB:%f:::%d:%s''', [Invoice.InvoiceItems[i].AGrossPrice, 1, '']));
          AddVatSum(Invoice.InvoiceItems[i].VATRate, Invoice.InvoiceItems[i].Amount, Invoice.InvoiceItems[i].VatAmount, Invoice.InvoiceItems[i].VATCategoryCode);
          LTotAmount := LTotAmount + Invoice.InvoiceItems[i].Amount;
          sl.Add(format('RFF+ON:%s:%d''', [Invoice.InvoiceItems[i].VolvoOrderNumber, Invoice.InvoiceItems[i].VolvoOrderLineNumber]));
          sl.Add(format('TAX+7+VAT+++:::%s+%s''', [Invoice.InvoiceItems[i].VATRate, Invoice.InvoiceItems[i].VATCategoryCode]));
          sl.Add(format('MOA+124:%f''', [Invoice.InvoiceItems[i].VATAmount]));
        end;

        sl.Add(format('UNS+S''', []));
        sl.Add(format('MOA+77:%f::4''', [Invoice.TotalInvoiceAmount]));
        sl.Add(format('MOA+125:%f::4''', [Invoice.TotalTaxableAmount]));
        sl.Add(format('MOA+176:%f::4''', [Invoice.TotalTaxAmount]));
        sl.Add(format('MOA+79:%f::4''', [LTotAmount]));

        if VatSum25 > 0 then
        begin
//            Required when the tax rate of 25 % applies
          sl.Add(format('TAX+7+VAT+++:::25+%s''', [VatCode25]));
          sl.Add(format('MOA+124:%f::4''', [VatVatSum25]));
          sl.Add(format('MOA+125:%f::4''', [VatSum25]));
        end;
        if VatSum21 > 0 then
        begin
//            Required when the tax rate of 21 % applies *
          sl.Add(format('TAX+7+VAT+++:::21+%s''', [VatCode21]));
          sl.Add(format('MOA+124:%f::4''', [VatVatSum21]));
          sl.Add(format('MOA+125:%f::4''', [VatSum21]));
        end;
        if VatSum12 > 0 then
        begin
//            Required when the tax rate of 12 % applies *
          sl.Add(format('TAX+7+VAT+++:::12+%s''', [VatCode12]));
          sl.Add(format('MOA+124:%f::4''', [VatVatSum12]));
          sl.Add(format('MOA+125:%f::4''', [VatSum12]));
        end;
        if VatSum6 > 0 then
        begin
//            Required when the tax rate of 6 % applies *
          sl.Add(format('TAX+7+VAT+++:::6+%s''', [VatCode6]));
          sl.Add(format('MOA+124:%f::4''', [VatVatSum6]));
          sl.Add(format('MOA+125:%f::4''', [VatSum6]));
        end;
        if VatSum0 > 0 then
        begin
//            Required when the tax rate of 0 % applies *
          sl.Add(format('TAX+7+VAT+++:::0+%s''', [VatCode0]));
          sl.Add(format('MOA+124:%f::4''', [VatVatSum0]));
          sl.Add(format('MOA+125:%f::4''', [VatSum0]));
        end;
        sl.Add(format('UNT+%d+%s''', [sl.count, ReferenceNumber]));
        sl.Add(format('UNZ+%d+%s''', [1, ReferenceNumber]));


      end;
      result := sl.Text;
    finally
      sl.Free;
    end;

  end;
end;

procedure TEdiFactEngine.SetEdiFactInfo(const Value: TEdiFactInfo);
begin
  FEdiFactInfo := Value;
end;

{ TOdetteClass }

function TOdetteClass.CheckIfValid(value: variant;
  valuetype: TFieldType; propName: string): boolean;
begin
  case valuetype of
    ftString: result := value > '';
    ftInteger: result := value <> 0;
    ftDate: result := value <> 0;
    ftDateTime: result := value <> 0;
    ftReal: result := value <> 0;
    ftBool: result := true;
  else
    raise EOdetteException.CreateFmt('ValueType not handled in CheckIfValid method (%s)', [value]);
  end;
  if not result then
    raise EOdetteException.CreateFmt('Not a valid value for %s', [propName])
end;

function TOdetteClass.CheckIfValid(valueobject: TOdetteClass; propName: string): boolean;
begin
  FPropName := propName;
  result := valueobject.HasValidFields;
end;

function TOdetteClass.CheckIfValid(valueobject: TCollection; propName: string): boolean;
var
  i: integer;
begin
  FPropName := propName;
  result := false;
  if valueobject.ItemClass = TOdetteCollectionClass then
  begin
    for i := 0 to valueobject.Count - 1 do
    begin
      result := CheckIfValid(valueobject.Items[i] as TOdetteCollectionClass, GetPropName + format('(%d)', [i]));
    end;
  end;
end;

function TOdetteClass.CheckIfValid(valueobject: TOdetteCollectionClass;
  propName: string): boolean;
begin
  FPropName := propName;
  result := valueobject.HasValidFields;
end;

function TOdetteClass.GetPropName: string;
begin
  result := FPropName;
end;

function TOdetteClass.HasValidFields: boolean;
begin
  raise EOdetteException.Create('HasValidFields not implemented for class ' + self.ClassName);
end;

{ TOdetteCollectionClass }

function TOdetteCollectionClass.CheckIfValid(valueobject: TOdetteClass;
  propName: string): boolean;
begin
  FPropName := propName;
  result := valueobject.HasValidFields;

end;

function TOdetteCollectionClass.CheckIfValid(value: variant;
  valuetype: TFieldType; propName: string): boolean;
begin
  case valuetype of
    ftString: result := value > '';
    ftInteger: result := value <> 0;
    ftDate: result := value <> 0;
    ftDateTime: result := value <> 0;
    ftReal: result := value <> 0;
    ftBool: result := true;
  else
    raise EOdetteException.CreateFmt('ValueType not handled in CheckIfValid method (%s)', [value]);
  end;
  if not result then
    raise EOdetteException.CreateFmt('Not a valid value for %s', [propName])

end;

function TOdetteCollectionClass.CheckIfValid(valueobject: TCollection;
  propName: string): boolean;
var
  i: integer;
begin
  FPropName := propName;
  result := false;
  if valueobject.ItemClass = TOdetteCollectionClass then
  begin
    for i := 0 to valueobject.Count - 1 do
    begin
      result := CheckIfValid(valueobject.Items[i] as TOdetteCollectionClass, GetPropName + format('(%d)', [i]));
    end;
  end;
end;

function TOdetteCollectionClass.CheckIfValid(
  valueobject: TOdetteCollectionClass; propName: string): boolean;
begin
  FPropName := propName;
  result := valueobject.HasValidFields;
end;

function TOdetteCollectionClass.GetPropName: string;
begin
  result := FPropName;

end;

function TOdetteCollectionClass.HasValidFields: boolean;
begin
  raise EOdetteException.Create('HasValidFields not implemented for class ' + self.ClassName);
end;

end.

