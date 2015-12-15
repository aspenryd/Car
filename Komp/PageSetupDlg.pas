{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13161: PageSetupDlg.pas 
{
{   Rev 1.0    2003-03-20 14:03:30  peter
}
{
{   Rev 1.0    2003-03-17 10:14:24  Supervisor
}
unit PageSetupDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, PrevPrinter, Buttons, Printers, FormSettings;

type
  TPageSetupForm = class(TForm)
    PageMarginGroup: TGroupBox;
    InchBut: TRadioButton;
    CentBut: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LeftEdit: TEdit;
    RightEdit: TEdit;
    TopEdit: TEdit;
    BotEdit: TEdit;
    PageOrientGroup: TGroupBox;
    PortBut: TRadioButton;
    LandBut: TRadioButton;
    OKBut: TButton;
    CancelBut: TButton;
    HeaderGroup: TGroupBox;
    Label5: TLabel;
    HeaderEdit: TEdit;
    Label6: TLabel;
    HdrMarginEdit: TEdit;
    HdrFontBut: TButton;
    FooterGroup: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    FooterEdit: TEdit;
    FtrMarginEdit: TEdit;
    FtrFontBut: TButton;
    PageNumGroup: TGroupBox;
    Label9: TLabel;
    PageNumFontBut: TButton;
    PrinterSetupBut: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    FooterFontDialog: TFontDialog;
    HeaderFontDialog: TFontDialog;
    PageNumFontDialog: TFontDialog;
    SetDefaultBut: TButton;
    LandShape: TImage;
    PortShape: TImage;
    cbPageLocation: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    cbPageNumAlign: TComboBox;
    cbHeaderAlign: TComboBox;
    Label12: TLabel;
    Label13: TLabel;
    cbFooterAlign: TComboBox;
    PageNumEdit: TEdit;
    procedure FormShow(Sender: TObject);
    procedure OKButClick(Sender: TObject);
    procedure PortButClick(Sender: TObject);
    procedure PrinterSetupButClick(Sender: TObject);
    procedure PageNumFontButClick(Sender: TObject);
    procedure HdrFontButClick(Sender: TObject);
    procedure FtrFontButClick(Sender: TObject);
    procedure SetDefaultButClick(Sender: TObject);
    procedure InchButClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FormSettings1:TFormSettings;
  protected
    procedure  Data_To_Form;
    procedure  Form_To_Data;
  public
    TextOpt    : TTextOptions;
    pp         : TPreviewPrinter;
    function   Execute: integer;
    procedure  GetDefaults;
  end;

implementation

{$R *.DFM}

const
  cDecimalFmt = '%1.2n';
resourcestring
  SSaveAsStandardPrompt = 'Är du säker på att du vill spara dessa inställningar som standard?';

function TPageSetupForm.Execute: integer;
begin
   Result := ShowModal;
end;

procedure TPageSetupForm.FormShow(Sender: TObject);
begin
   Data_To_Form;
end;

procedure TPageSetupForm.OKButClick(Sender: TObject);
begin
   Form_To_Data;
end;

procedure TPageSetupForm.PrinterSetupButClick(Sender: TObject);
begin
   PrinterSetupDialog1.Execute;
end;

procedure TPageSetupForm.PortButClick(Sender: TObject);
var
   b : boolean;
begin
   b := PortBut.Checked;
   PortShape.Visible := b;
   LandShape.Visible := not b;
end;

procedure TPageSetupForm.PageNumFontButClick(Sender: TObject);
begin
  with TFontDialog.Create(nil) do
  try
    Font := TextOpt.PageNumFont;
    if Execute then
      TextOpt.PageNumFont := Font;
  finally
    Free;
  end;
end;

procedure TPageSetupForm.HdrFontButClick(Sender: TObject);
begin
  with TFontDialog.Create(nil) do
  try
    Font := TextOpt.HeaderFont;
    if Execute then
      TextOpt.HeaderFont := Font;
  finally
    Free;
  end;
end;

procedure TPageSetupForm.FtrFontButClick(Sender: TObject);
begin
  with TFontDialog.Create(nil) do
  try
    Font := TextOpt.FooterFont;
    if Execute then
      TextOpt.FooterFont := Font;
  finally
    Free;
  end;
end;

procedure TPageSetupForm.Data_To_Form;
begin
   // Page Margins
   InchBut.Checked := pp.Units = unInches;
   LeftEdit.Text  := Format(cDecimalFmt, [TextOpt.MarginLeft]);
   RightEdit.Text := Format(cDecimalFmt, [TextOpt.MarginRight]);
   TopEdit.Text   := Format(cDecimalFmt, [TextOpt.MarginTop]);
   BotEdit.Text   := Format(cDecimalFmt, [TextOpt.MarginBottom]);

   // Page Orientation
   PortBut.Checked := pp.Orientation = poPortrait;
   LandBut.Checked := not PortBut.Checked;
   PortButClick(nil);

   // Page Number Options

   cbPageLocation.ItemIndex := Ord(TextOpt.PrintPageNumber);
   cbPageNumAlign.ItemIndex := Ord(TextOpt.PageNumAlign);
   PageNumEdit.Text := TextOpt.PageNumText;

   // Header
   HeaderEdit.Text := TextOpt.Header;
   HdrMarginEdit.Text := Format(cDecimalFmt, [TextOpt.HeaderMargin]);
   cbHeaderAlign.ItemIndex := Ord(TextOpt.HeaderAlign);

   // Footer
   FooterEdit.Text := TextOpt.Footer;
   FtrMarginEdit.Text := Format(cDecimalFmt, [TextOpt.FooterMargin]);
   cbFooterAlign.ItemIndex := Ord(TextOpt.FooterAlign);
end;

procedure TPageSetupForm.Form_To_Data;
begin
   // Page Margins
   if InchBut.Checked then
     pp.Units := unInches
   else
     pp.Units := unCentimeters;

   TextOpt.MarginLeft   := StrToFloat(LeftEdit.Text);
   TextOpt.MarginTop    := StrToFloat(TopEdit.Text);
   TextOpt.MarginRight  := StrToFloat(RightEdit.Text);
   TextOpt.MarginBottom := StrToFloat(BotEdit.Text);

   // Page Orientation
   if PortBut.Checked then
     pp.Orientation := poPortrait
   else
     pp.Orientation := poLandscape;

   // Page Number Options
   TextOpt.PrintPageNumber := TPrintPageNumber(cbPageLocation.ItemIndex);
   TextOpt.PageNumAlign    := TAlignment(cbPageNumAlign.ItemIndex);
   TextOpt.PageNumText     := PageNumEdit.Text;
   TextOpt.PageNumFont     := PageNumFontDialog.Font;

   // Header
   TextOpt.Header       := HeaderEdit.Text;
   TextOpt.HeaderMargin := StrToFloat(HdrMarginEdit.Text);

   TextOpt.HeaderAlign  := TAlignment(cbHeaderAlign.ItemIndex);
   TextOpt.HeaderFont   := HeaderFontDialog.Font;

   // Footer
   TextOpt.Footer       := FooterEdit.Text;
   TextOpt.FooterMargin := StrToFloat(FtrMarginEdit.Text);
   TextOpt.FooterAlign  := TAlignment(cbFooterAlign.ItemIndex);
   TextOpt.FooterFont   := FooterFontDialog.Font;
end;

procedure TPageSetupForm.SetDefaultButClick(Sender: TObject);
begin
   if MessageDlg(SSaveAsStandardPrompt,
      mtWarning, mbYesNoCancel, 0) = mrYes then
   begin
      FormSettings1.SaveValues := True;
      FormSettings1.SaveSettings;
      FormSettings1.SaveValues := False;
   end;
end;

procedure TPageSetupForm.GetDefaults;
begin
   Data_To_Form;
   FormSettings1.LoadSettings;
   Form_To_Data;
end;

function StrToFloatDef(const S:string;default:Extended):Extended;
begin
  try
    Result := StrToFloat(S);
  except
    Result := Default;
  end;
end;

procedure TPageSetupForm.InchButClick(Sender: TObject);
var f:Double;
begin
  if Sender = InchBut then
    f := 1 / 2.54
  else if Sender = CentBut then
    f := 2.54
  else
    f := 1.0;
  TopEdit.Text       := Format(cDecimalFmt, [StrToFloatDef(TopEdit.Text,0) * f]);
  LeftEdit.Text      := Format(cDecimalFmt, [StrToFloatDef(LeftEdit.Text,0) * f]);
  RightEdit.Text     := Format(cDecimalFmt, [StrToFloatDef(RightEdit.Text,0) * f]);
  BotEdit.Text       := Format(cDecimalFmt, [StrToFloatDef(BotEdit.Text,0) * f]);
  HdrMarginEdit.Text := Format(cDecimalFmt, [StrToFloatDef(HdrMarginEdit.Text,0) * f]);
  FtrMarginEdit.Text := Format(cDecimalFmt, [StrToFloatDef(FtrMarginEdit.Text,0) * f]);
end;

procedure TPageSetupForm.FormCreate(Sender: TObject);
begin
  FormSettings1 := TFormSettings.Create(self);
  with FormSettings1 do
  begin
    SavePosition := False;
    SaveValues := False;
    LoadValues := True;
    SaveValueOptions := [svEdit, svMemo, svCheckBox, svRadioButton, svListBox, svComboBox, svFontDialog]
  end;

end;

end.
