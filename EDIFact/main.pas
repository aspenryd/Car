unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses EDIFactClasses, EDIFactUtils;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ee : TEdiFectEngine;
begin
  ee := TEdiFectEngine.create;
  try

    AddTestSupplierInfo(ee.EdiFactInfo.Supplier);
    AddTestVolvoInfo(ee.EdiFactInfo.Volvo);
    AddTestPayeeInfo(ee.EdiFactInfo.Payee);
    AddTestEdiFactInfo(ee.EdiFactInfo);
    AddTestInvoiceInfo(ee.EdiFactInfo.Invoice);
    Memo1.Lines.Text := ee.GetEdiFactText;
  finally
    ee.free;
  end;
end;

end.
