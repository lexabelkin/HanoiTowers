unit DiscImageInf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Generics.Collections, System.Types, extern;

type
  TDisc = class(TPanel)
  public
     num:integer;
    constructor Create(AOwner: TComponent); override;

    class function GenerateDisksList(CurrTower:TObject;NumDisks: Integer; Parent: TWinControl;
     Left, Top, Width, Height: Integer): TStack<TDisc>;

    function getCurrTower():TObject;
    procedure setCurrTower(shape:TObject);

  private
    currTower : TObject;

    FIsDragging: Boolean;
    FDragOffset: TPoint;
    FSourceParent: TWinControl;
  end;

implementation

{ TDisc }

constructor TDisc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsDragging := False;
end;


class function TDisc.GenerateDisksList(currTower:TObject;NumDisks: Integer; Parent: TWinControl;
 Left, Top, Width, Height: Integer): TStack<TDisc>;
var
  I: Integer;
  Disk: TDisc;
  R, G, B: Byte;
  DiskWidth: Integer;
  DiskTop: Integer;
  DiskScale: Single;
begin
  Result := TStack<TDisc>.Create;
  DiskScale := 0.5 / NumDisks;

  for I := NumDisks downto 1 do
  begin
    Disk := TDisc.Create(Parent);
    Disk.Parent := Parent;
    Disk.BorderStyle := bsSingle;
    Disk.BorderWidth := 5;
    disk.Color := clDefault;
    //Disk.Color := clWhite;

    var img:Timage:=TImage.Create(Parent);





    img := TImage.Create(Parent);
    img.Picture.LoadFromFile('D:\deFolder\source\repos_dephi\HanoiTowers\assets\disc.png');
    img.Parent := Disk;

    disk.Repaint;

//    Disk.OnMouseDown := Disk.DiscMouseDown;
//    Disk.OnMouseMove := Disk.DiscMouseMove;
//    Disk.OnMouseUp := Disk.DiscMouseUp;

    // ��������� ���� �����
    R := Random(256);
    G := Random(256);
    B := Random(256);
    //disk.Proportional:=True;
    img.Stretch:=true;

    //Disk.Brush.Color := RGB(R, G, B);
//    Disk.Pen.Color := clBlack;
//    Disk.Pen.Width := 1;
//    Disk.Shape := stRoundRect;


    Disk.DragMode:= dmAutomatic;
    Disk.DragKind := dkDrag;
    //disk.OnStartDrag:=disk.DiscStartDrag;
    // ����� ������ � ������� �� ��������� ����� � �������, � 8 ��� ����



    DiskWidth := Round(NumDisks * Width * 8 * (sqrt(I) * DiskScale));

    Disk.Width := DiskWidth;
    Disk.Height := 40;
    Disk.Left := Left + (Width - DiskWidth) div 2;

    // ��������� ����� ����� �����, ������� � ��������� �����
    DiskTop := (Top + Height - (NumDisks - I + 1) * Disk.Height);
    Disk.Top := DiskTop;

    img.Width := DiskWidth;
    img.Height := 40;
    img.Transparent:=true;

    disk.currTower := currTower;
    disk.num := I;

    Result.push(Disk);
  end;
end;


function TDisc.getCurrTower():TObject;
begin
  result:=self.currTower;
end;

procedure TDisc.setCurrTower(shape:TObject);
begin
  self.currTower:=shape
end;





end.
