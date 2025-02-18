unit TowerImageClass;

interface

uses
  Vcl.Graphics, System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls,
   System.Generics.Collections, DiscInf, Vcl.Dialogs, vcl.stdctrls,  System.StrUtils, vcl.Forms, Winapi.Windows,
   leveldialog;
type
  TTower = class(TImage)
  public
    class var editMoves: Tlabel;
    class var dbgMemo: TMemo;
    class var animTime: integer;
    class var board: TForm;
    class var isGame: boolean;
    class procedure DefineVars(edit:TLabel;memo:TMemo;time:integer;board:TForm;isgame:boolean);

    constructor Create(AOwner: TComponent);
    procedure Init(Parent: TWinControl; Name: string; X, Y, W, H: Integer;num:integer);

    procedure TowerDragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
    procedure TowerDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure PushDisc(Disc: TDisc);
    function PopDisc:TDisc;
    function GetDiscs: TStack<TDisc>;
    class procedure FillFirstTower(tower:TTower;count:integer;parent:TWinControl);

    class procedure setTotalDiscCount(val:integer);
    class function getTotalDiscCount():integer;

    class procedure moveDisk(currDisc:TDisc;prevTower,DestTower:TTower);
  private
    disks: TStack<TDisc>;
    num: integer;
    class var TotalDiscCount:integer;
  end;
  var filepath:string;
implementation

{ TTower }
  class procedure TTower.DefineVars(edit:TLabel;memo:TMemo;time:integer;board:TForm;isgame:boolean);
  begin
     TTower.editMoves:=edit;
     TTower.dbgMemo:=memo;
     TTower.animTime:=time;
     TTower.board:=board;
     TTower.isGame:=isgame;
     filepath:=ExtractFilePath(Application.ExeName) + 'assets\';
  end;

  constructor TTower.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner);
    disks := TStack<TDisc>.Create;
  end;

  procedure TTower.Init(Parent: TWinControl; Name: string; X, Y, W, H: Integer;num:integer);
  begin
    Self.Name := Name;
    Self.Left := X;
    Self.Top := Y;
    Self.Width := W;
    Self.Height := H;
    Self.Parent := Parent;
    self.num := num;
    //self.Stretch:=true;
    self.proportional:=true;
    self.Center:=true;
    self.Picture.LoadFromFile(filepath+'metalrod.png');
  end;

  procedure TTower.PushDisc(Disc: TDisc);
  begin
    disks.push(disc);
  end;

  function TTower.PopDisc;
  begin
    if disks.Count > 0 then result:=disks.Pop;
  end;

  function TTower.GetDiscs: TStack<TDisc>;
  begin
    Result := disks;
  end;

  class procedure TTower.FillFirstTower(tower:TTower;count:integer;parent:TWinControl);
  begin
    TTower.setTotalDiscCount(count);
    if count >10 then  tower.disks := TDisc.GenerateDisksList(tower,count, parent, tower.Left, tower.Top, tower.Width, tower.Height,0)
    else tower.disks := TDisc.GenerateDisksList(tower,count, parent, tower.Left, tower.Top, tower.Width, tower.Height,40);
  end;

  class procedure TTower.setTotalDiscCount(val:integer);
  begin
     TTower.TotalDiscCount:=val;
  end;

  class function TTower.getTotalDiscCount():integer;
  begin
     result:=TTower.TotalDiscCount;
  end;

  class procedure TTower.moveDisk(currDisc:TDisc;prevTower,DestTower:TTower);
  begin

    if DestTower.disks.Count <> 0 then
    begin
        if DestTower.disks.peek.Width < currDisc.Width then exit;
        currDisc.top := DestTower.Top + (DestTower.Height - currDisc.Height) - DestTower.disks.Count*currDisc.Height;
    end
    else currDisc.top := DestTower.Top + DestTower.Height - currDisc.Height;
    currDisc.Left := DestTower.Left + (DestTower.Width - currDisc.Width) div 2;

    dbgmemo.lines.Add(Format('(%d) ������ ���� � ����� %d �� %d',[strtoint(editMoves.caption)+1,prevTower.num+1,destTower.num+1]));
    //dbgmemo.lines.Add(Format('Alloc: %d, n:%d, i:%d, k: %d',[GetHeapStatus.TotalAllocated,currDisc.num,prevTower.num+1,destTower.num+1]));

    prevTower.PopDisc;
    DestTower.PushDisc(currDisc);
    currDisc.setCurrTower(DestTower);
    currdisc.Repaint;

    editMoves.caption:=inttostr(strtoint(editMoves.caption)+1);
    if (destTower.num<>0) and (desttower.GetDiscs.Count=TTower.getTotalDiscCount()) and isgame then
    begin
        dbgmemo.lines.Add('level passed');
        NextLevelDialog.Init(dbgmemo);
        NextLevelDialog.showmodal();
    end;



    sleep(TTower.animTime);
    application.ProcessMessages();

  end;


  procedure TTower.TowerDragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
  begin
      if (source is TTower) then
        try
           if (source as TTower).GetDiscs.Count<>0 then
            source:=(source as TTower).GetDiscs.Peek;
            Accept:= True;
        except
            exit;
        end;

      if (source is TDisc) //���� ���� ��������\ ����� �� ����� ������ �����
      and ((source as TDisc)<>((source as TDisc).getCurrTower() as TTower).disks.Peek)
      and ((sender as TTower)<>((source as TDisc).getCurrTower() as TTower)) then Accept:= True;

  end;

  procedure TTower.TowerDragDrop(Sender, Source: TObject; X, Y: Integer);
  begin
      if (source is TTower) then
          if (source as TTower).GetDiscs.Count<>0 then
                source:=(source as TTower).GetDiscs.Peek;

      if (Source is TDisc) then
      begin
        var currDisc : TDisc := (source as TDisc);
        var DestTower : TTower := (sender as TTower);
        var prevTower := (currDisc.getCurrTower() as TTower);
        //���� ���� �� �������
        if (currDisc <> prevTower.disks.Peek) or (destTower = prevTower) then exit;

        self.moveDisk(currDisc,prevTower,DestTower);

      end;
  end;

end.
