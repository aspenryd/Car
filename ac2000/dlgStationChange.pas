unit dlgStationChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, DBCtrls, Mask;

type
  TStationChangeDlg = class(TForm)
    Label112: TLabel;
    Label119: TLabel;
    DBEdit97: TDBEdit;
    DBEdit98: TDBEdit;
    Label145: TLabel;
    Label1: TLabel;
    dtpChangeDate: TDateTimePicker;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBLookupComboBox2: TDBLookupComboBox;
    edFromStation: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StationChangeDlg: TStationChangeDlg;

implementation

uses Dmod, DmSession;

var
  oldval : variant;
{$R *.dfm}

procedure TStationChangeDlg.BitBtn1Click(Sender: TObject);
begin
  Dmod2.StationChangeT.Open;
  try
    Dmod2.StationChangeT.Insert;
    Dmod2.StationChangeT.FieldByName('FromStation').Value := Oldval;
    Dmod2.StationChangeT.FieldByName('ToStation').Value := DMod2.ObjectT.FieldByName('Station').Value;
    Dmod2.StationChangeT.FieldByName('ObjNum').Value := DMod2.ObjectT.FieldByName('ObjNum').Value;
    Dmod2.StationChangeT.FieldByName('ChangeDate').Value := trunc(dtpChangeDate.DateTime);
    Dmod2.StationChangeT.Post;
  finally
    Dmod2.StationChangeT.Close;
  end;
end;

procedure TStationChangeDlg.FormShow(Sender: TObject);
begin
  Dmod2.StationT.Locate('StationId', DMod2.ObjectT.FieldByName('Station').Value, []);
  oldval := DMod2.ObjectT.FieldByName('Station').Value;
  edFromStation.Text := DMod2.StationT.FieldByName('Name').Value
end;

procedure TStationChangeDlg.BitBtn2Click(Sender: TObject);
begin
  if DMod2.ObjectT.FieldByName('Station').Value <> oldval then
    DMod2.ObjectT.FieldByName('Station').Value := oldval;
end;

end.
