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

uses Greg, DataSession;

var
  oldval : variant;
{$R *.dfm}

procedure TStationChangeDlg.BitBtn1Click(Sender: TObject);
begin
  frmGReg.StationChangeT.Open;
  try
    frmGReg.StationChangeT.Insert;
    frmGReg.StationChangeT.FieldByName('FromStation').Value := Oldval;
    frmGReg.StationChangeT.FieldByName('ToStation').Value := frmGReg.ObjectsT.FieldByName('Station').Value;
    frmGReg.StationChangeT.FieldByName('ObjNum').Value := frmGReg.ObjectsT.FieldByName('ObjNum').Value;
    frmGReg.StationChangeT.FieldByName('ChangeDate').Value := trunc(dtpChangeDate.DateTime);
    frmGReg.StationChangeT.Post;
  finally
    frmGReg.StationChangeT.Close;
  end;
end;

procedure TStationChangeDlg.FormShow(Sender: TObject);
begin
  frmGReg.StationT.Locate('StationId', frmGReg.ObjectsT.FieldByName('Station').Value, []);
  oldval := frmGReg.ObjectsT.FieldByName('Station').Value;
  edFromStation.Text := frmGReg.StationT.FieldByName('Name').Value;

end;

procedure TStationChangeDlg.BitBtn2Click(Sender: TObject);
begin
  if frmGReg.ObjectsT.FieldByName('Station').Value <> oldval then
    frmGReg.ObjectsT.FieldByName('Station').Value := oldval;
end;

end.
