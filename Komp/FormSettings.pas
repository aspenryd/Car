{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13151: FormSettings.pas 
{
{   Rev 1.0    2003-03-20 14:03:30  peter
}
{
{   Rev 1.0    2003-03-17 10:14:22  Supervisor
}
unit FormSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, StdCtrls;

type
   TSaveValOpt = (svEdit, svMemo, svCheckBox, svRadioButton, svListBox,
      svComboBox, svFontDialog);
   TSaveValSet = set of TSaveValOpt;

   TFormSettings = class(TComponent)
   protected
      FSavePos    : boolean;
      FSaveVals   : boolean;
      FLoadVals   : boolean;
      FKeyName    : string;
      FSaveOpt    : TSaveValSet;
      FRootCon    : TWinControl;
      DidLastSave : boolean;
      procedure   Loaded; override;
      function    StrToWS(const s: string): TWindowState;
      function    WSToStr(ws: TWindowState): string;
      function    GetKeyName: string;
      procedure   Notification(AComponent: TComponent; Operation: TOperation); override;
      procedure   DoLoadValues(reg: TRegIniFile);
      procedure   DoSaveValues(reg: TRegIniFile);
      procedure   ReadFont(Name: string; f: TFont; reg: TRegIniFile);
      procedure   WriteFont(Name: string; f: TFont; reg: TRegIniFile);
   public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      procedure   LoadSettings;
      procedure   SaveSettings;
   published
      property    SavePosition: boolean read FSavePos write FSavePos;
      property    SaveValues: boolean read FSaveVals write FSaveVals;
      property    LoadValues: boolean read FLoadVals write FLoadVals;
      property    SaveValueOptions: TSaveValSet read FSaveOpt write FSaveOpt;
      property    KeyName: string read GetKeyName write FKeyName;
      property    RootControl: TWinControl read FRootCon write FRootCon;
   end;

procedure Register;

implementation

const
   WindowStr : array[1..3] of string = ('NORMAL', 'MAXIMIZED', 'MINIMIZED');


constructor TFormSettings.Create(AOwner: TComponent);
begin
   inherited;
   FreeNotification(AOwner);
   FSavePos    := True;
   FSaveVals   := False;
   FLoadVals   := False;
   DidLastSave := False;
   FSaveOpt := [svEdit, svMemo, svCheckBox, svRadioButton, svListBox,
      svComboBox, svFontDialog];
end;

destructor TFormSettings.Destroy;
begin
   inherited;
end;

procedure TFormSettings.Notification(AComponent: TComponent; Operation: TOperation);
begin
   inherited;
   if (not DidLastSave) and (csDestroying in ComponentState) then begin
      DidLastSave := True;
      // This still doesn't work!  All the window handles are gone! -bpz
      // SaveSettings;
   end;
end;

procedure TFormSettings.Loaded;
begin
   inherited;
   LoadSettings;
end;

function TFormSettings.StrToWS(const s: string): TWindowState;
var
   t : string;
begin
   t := UpperCase(s);
   Result := wsNormal;
   if t = WindowStr[1] then Result := wsNormal;
   if t = WindowStr[2] then Result := wsMaximized;
   if t = WindowStr[3] then Result := wsMinimized;
end;

function TFormSettings.WSToStr(ws: TWindowState): string;
begin
   case ws of
      wsNormal    : Result := WindowStr[1];
      wsMaximized : Result := WindowStr[2];
      wsMinimized : Result := WIndowStr[3];
   else
      Result := WindowStr[1];
   end;
end;

function TFormSettings.GetKeyName: string;
begin
   Result := FKeyName;

   if (Result='') and (not (csDesigning in ComponentState))
      and (Application<>nil) and (Owner<>nil) then
      Result := 'Software\' + Application.Title + '\' + Owner.Name;
end;

procedure TFormSettings.LoadSettings;
var
   f   : TForm;
   reg : TRegIniFile;
begin
   if (Owner = nil) or (not (Owner is TForm)) then exit;
   if csDesigning in ComponentState then exit;

   f := Owner as TForm;
   f.Position := poDesigned;

   reg := TRegIniFile.Create(KeyName);

   if SavePosition then begin
      f.Left        := reg.ReadInteger('Position', 'Left', f.Left);
      f.Top         := reg.ReadInteger('Position', 'Top', f.Top);
      f.Width       := reg.ReadInteger('Position', 'Width', f.Width);
      f.Height      := reg.ReadInteger('Position', 'Height', f.Height);
      f.WindowState := StrToWS(reg.ReadString('Position', 'WindowState', 'Normal'));
   end;

   if LoadValues then
      DoLoadValues(reg);

   reg.Free;
end;

procedure TFormSettings.SaveSettings;
var
   f   : TForm;
   reg : TRegIniFile;
begin
   if (Owner = nil) or (not (Owner is TForm)) then exit;
   if csDesigning in ComponentState then exit;

   f := Owner as TForm;
   f.Position := poDesigned;

   reg := TRegIniFile.Create(KeyName);

   if SavePosition then begin
      if f.WindowState = wsNormal then begin
         reg.WriteInteger('Position', 'Left', f.Left);
         reg.WriteInteger('Position', 'Top', f.Top);
         reg.WriteInteger('Position', 'Width', f.Width);
         reg.WriteInteger('Position', 'Height', f.Height);
      end;
      reg.WriteString('Position', 'WindowState', WSToStr(f.WindowState));
   end;

   if SaveValues then
      DoSaveValues(reg);

   reg.Free;
end;

procedure TFormSettings.DoLoadValues(reg: TRegIniFile);
var
   i     : integer;
   con   : TWinControl;
   c     : TControl;
   cp    : TComponent;
begin
   con := RootControl;
   if con=nil then con := Owner as TForm;
   Assert(con<>nil);

   for i := 0 to con.ComponentCount-1 do begin
      cp := con.Components[i];
      if not (cp is TControl) then continue;
      c := cp as TControl;

      if c is TEdit then
         TEdit(c).Text := reg.ReadString('Values', c.Name, TEdit(c).Text);
      if c is TMemo then
         TMemo(c).Text := reg.ReadString('Values', c.Name, TMemo(c).Text);
      if c is TCheckBox then
         TCheckBox(c).Checked := reg.ReadBool('Values', c.Name, TCheckBox(c).Checked);
      if c is TRadioButton then
         TRadioButton(c).Checked := reg.ReadBool('Values', c.Name, TRadioButton(c).Checked);
      if c is TListBox then
         TListBox(c).ItemIndex := reg.ReadInteger('Values', c.Name, TListBox(c).ItemIndex);
      if c is TComboBox then
         TComboBox(c).ItemIndex := reg.ReadInteger('Values', c.Name, TComboBox(c).ItemIndex);
   end;

   for i := 0 to con.ComponentCount-1 do begin
      cp := con.Components[i];
      if cp is TFontDialog then
         ReadFont(cp.Name, TFontDialog(cp).Font, reg);
   end;
end;

procedure TFormSettings.DoSaveValues(reg: TRegIniFile);
var
   i     : integer;
   con   : TWinControl;
   c     : TControl;
   cp    : TComponent;
begin
   con := RootControl;
   if con=nil then con := Owner as TForm;
   Assert(con<>nil);

   for i := 0 to con.ComponentCount-1 do begin
      cp := con.Components[i];
      if not (cp is TControl) then continue;
      c := cp as TControl;

      if c is TEdit then
         reg.WriteString('Values', c.Name, TEdit(c).Text);
      if c is TMemo then
         reg.WriteString('Values', c.Name, TMemo(c).Text);
      if c is TCheckBox then
         reg.WriteBool('Values', c.Name, TCheckBox(c).Checked);
      if c is TRadioButton then
         reg.WriteBool('Values', c.Name, TRadioButton(c).Checked);
      if c is TListBox then
         reg.WriteInteger('Values', c.Name, TListBox(c).ItemIndex);
      if c is TComboBox then
         reg.WriteInteger('Values', c.Name, TComboBox(c).ItemIndex);
   end;

   for i := 0 to con.ComponentCount-1 do begin
      cp := con.Components[i];
      if cp is TFontDialog then
         WriteFont(cp.Name, TFontDialog(cp).Font, reg);
   end;
end;

procedure TFormSettings.ReadFont(Name: string; f: TFont; reg: TRegIniFile);
var
   b : boolean;
begin
   f.Name  := reg.ReadString('Values', Name + '_Name', f.Name);
   f.Size  := reg.ReadInteger('Values', Name + '_Size', f.Size);
   f.Color := reg.ReadInteger('Values', Name + '_Color', f.Color);

   b := reg.ReadBool('Values', Name + '_Bold', fsBold in f.Style);
   if b then f.Style := f.Style + [fsBold]
      else f.Style := f.Style - [fsBold];

   b := reg.ReadBool('Values', Name + '_Italic', fsItalic in f.Style);
   if b then f.Style := f.Style + [fsItalic]
      else f.Style := f.Style - [fsItalic];

   b := reg.ReadBool('Values', Name + '_Underline', fsUnderline in f.Style);
   if b then f.Style := f.Style + [fsUnderline]
      else f.Style := f.Style - [fsUnderline];

   b := reg.ReadBool('Values', Name + '_StrikeOut', fsStrikeOut in f.Style);
   if b then f.Style := f.Style + [fsStrikeOut]
      else f.Style := f.Style - [fsStrikeOut];
end;

procedure TFormSettings.WriteFont(Name: string; f: TFont; reg: TRegIniFile);
begin
   reg.WriteString('Values', Name + '_Name', f.Name);
   reg.WriteInteger('Values', Name + '_Size', f.Size);
   reg.WriteInteger('Values', Name + '_Color', f.Color);

   reg.WriteBool('Values', Name + '_Bold', fsBold in f.Style);
   reg.WriteBool('Values', Name + '_Italic', fsItalic in f.Style);
   reg.WriteBool('Values', Name + '_Underline', fsUnderline in f.Style);
   reg.WriteBool('Values', Name + '_StrikeOut', fsStrikeOut in f.Style);
end;


procedure Register;
begin
  RegisterComponents('Samples', [TFormSettings]);
end;

end.
