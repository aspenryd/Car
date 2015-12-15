unit EDIFactUtils;

interface
uses windows, Messages, SysUtils, Variants, Classes, EdiFactClasses;

procedure AddTestSupplierInfo(supplier : TSupplierInfo);
procedure AddTestVolvoInfo(Volvo : TVolvoInfo);
procedure AddTestPayeeInfo(Payee : TPayeeInfo);
procedure AddTestEdiFactInfo(EdiFactInfo : TEdiFactInfo);
procedure AddTestInvoiceInfo(Invoice : TInvoiceInfo);

implementation

procedure AddTestSupplierInfo(supplier : TSupplierInfo);
begin
  Supplier.Name := 'Volvo Bil i Göteborg AB';
  Supplier.SupplierID := '279031';
  Supplier.LogicalAddress := 'O094200005560566266';
  Supplier.Qualifier := '30';
  Supplier.InternalAddress := '001806';
  Supplier.City := 'Gothenburg';
  Supplier.Street := 'Huggåsvägen';
  Supplier.ZipCode := '40531';
  Supplier.CountryCode := 'SE';
  Supplier.VATNumber := 'SE556056626601';
  Supplier.AccountsReceivable.Name := 'Matias Öberg';
  Supplier.AccountsReceivable.Department := 'IT';
  Supplier.AccountsReceivable.ContactInfo := 'matias@volvo.se';
  Supplier.AccountsReceivable.CommunicationCode := 'email';
  Supplier.SalesRep.Name := 'Matias Öberg';
  Supplier.SalesRep.Department := 'IT';
  Supplier.SalesRep.ContactInfo := 'matias@volvo.se';
  Supplier.SalesRep.CommunicationCode := 'email';
end;

procedure AddTestVolvoInfo(Volvo : TVolvoInfo);
begin
  Volvo.LogicalAddress := '094200005560139700';
  Volvo.Qualifier := '30';
  Volvo.InternalAddress := '001001';
  Volvo.City := 'Gothenburg';
  Volvo.Street := '';
  Volvo.ZipCode := '40508';
  Volvo.CountryCode := 'SE';
  Volvo.VATNumber := 'SE556013970001';
  Volvo.VolvoUnit := 'Volvo Truck Corporation, Gothenburg';
  Volvo.ReferencePerson.Name := 'Åsa Lindgren';
  Volvo.ReferencePerson.Department := '';
  Volvo.ReferencePerson.ContactInfo := 'åsa@volvo.se';
  Volvo.ReferencePerson.CommunicationCode := 'email';
end;

procedure AddTestEdiFactInfo(EdiFactInfo : TEdiFactInfo);
begin
  EdiFactInfo.TimeStamp := now;
  EdiFactInfo.ReferenceNumber := '9';
  EdiFactInfo.IsTest := true;
  EdiFactInfo.VATNumber := 'SE1212121212-01';
end;

procedure AddTestPayeeInfo(Payee : TPayeeInfo);
begin
  Payee.Name := 'Volvo Bil i Göteborg AB';
  Payee.AccountNumber := '1234567890';
  Payee.AccountHolder := 'Arne Bankman';
  Payee.Bank := 'Volvo Banken';
  Payee.ParmaNumber := '279031';
  Payee.City := 'Gothenburg';
  Payee.Street := '';
  Payee.ZipCode := '40531';
  Payee.CountryCode := 'SE';
end;

procedure AddTestInvoiceInfo(Invoice : TInvoiceInfo);
begin
  Invoice.ReferenceNumber := '9';
  Invoice.InvoiceNumber := '01234';
  Invoice.InvoiceDate := Date;
  Invoice.Currency := 'SEK';
  Invoice.HomeCurrency := 'SEK';
  Invoice.ExchangeRate := '1';

    with Invoice.InvoiceItems.Add do
    begin
      VolvoItemNumber := 1;
      SupplierItemNumber := 1;
      Description := 'Test faktura rad';
      LangCode :=  'SE';
      Amount := 100;
      Quantity := 2;
      VATRate := '25';
      AGrossPrice := 200;
      VATCategoryCode := 'S';
      VATAmount := 25;
      VolvoOrderNumber := '331';
      VolvoOrderLineNumber := 1;
    end;
    with Invoice.InvoiceItems.Add do
    begin
      VolvoItemNumber := 1;
      SupplierItemNumber := 1;
      Description := 'Test faktura rad 2';
      LangCode :=  'SE';
      Amount := 100;
      Quantity := 2;
      VATRate := '25';
      AGrossPrice := 200;
      VATCategoryCode := 'S';
      VATAmount := 25;
      VolvoOrderNumber := '331';
      VolvoOrderLineNumber := 2;
    end;
    Invoice.TotalInvoiceAmount := 200;
    Invoice.TotalTaxableAmount := 200;
    Invoice.TotalTaxAmount := 50;
    Invoice.TotalItemsAmount := 200;
end;


end.
