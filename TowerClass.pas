unit TowerClass;

interface

uses
  Vcl.Graphics, System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls,
   System.Generics.Collections, discinf, Vcl.Dialogs, vcl.stdctrls,  System.StrUtils, vcl.Forms, Winapi.Windows,gameunit;

type
  TTower = class(TShape)
  public
    class var editMoves: TEdit;
    class var dbgMemo: TMemo;
    class var animTime: integer;

    class procedure DefineVars(edit:TEdit;memo:TMemo;time:integer);

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

implementation

{ TTower }
  class procedure TTower.DefineVars(edit:TEdit;memo:TMemo;time:integer);
  begin
     TTower.editMoves:=edit;
     TTower.dbgMemo:=memo;
     TTower.animTime:=time;
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
    self.Brush.Color := RGB(254, 195, 78);
    self.Pen.Width:=1;
    Self.Parent := Parent;
    self.num := num;
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
        currDisc.top := DestTower.Top + (DestTower.Height - 1*currDisc.Height)-DestTower.disks.Count*20;
    end
    else currDisc.top := DestTower.Top + DestTower.Height - 1*currDisc.Height;
    currDisc.Left := DestTower.Left + (DestTower.Width - currDisc.Width) div 2;

    dbgmemo.lines.Add(Format('(%d) ���������� ���� [%d] � ����� %d �� %d',[strtoint(SplitString(editMoves.text,' ')[1])+1,currdisc.num,prevTower.num+1,destTower.num+1]));
    //dbgmemo.lines.Add(Format('Alloc: %d, n:%d, i:%d, k: %d',[GetHeapStatus.TotalAllocated,currDisc.num,prevTower.num+1,destTower.num+1]));

    prevTower.PopDisc;
    DestTower.PushDisc(currDisc);
    currDisc.setCurrTower(DestTower);
    currdisc.Repaint;

    editMoves.Text:='�����: ' +inttostr(strtoint(SplitString(editMoves.text,' ')[1])+1);
    if (destTower.num<>0) and (desttower.GetDiscs.Count=TTower.getTotalDiscCount()) then
    begin
      showmessage('�� �������� �������');
       dbgmemo.lines.Add('level passed');
    end;

    sleep(TTower.animTime);
    application.ProcessMessages();

  end;


  procedure TTower.TowerDragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
  begin
      if (source is TDisc) //���� ���� ��������\ ����� �� ����� ������ �����
      and ((source as TDisc)<>((source as TDisc).getCurrTower() as TTower).disks.Peek)
      and ((sender as TTower)<>((source as TDisc).getCurrTower() as TTower)) then Accept:= True;

      if Accept then (source as TDisc).DragCursor := crDrag
      else (source as TDisc).DragCursor := crNo;     //�� ��������
  end;

  procedure TTower.TowerDragDrop(Sender, Source: TObject; X, Y: Integer);
  begin
      if (Source is TDisc) then
      begin
        var currDisc : TDisc := (source as TDisc);
        var DestTower : TTower := (sender as TTower);
        var prevTower := (currDisc.getCurrTower() as TTower);
        //���� ���� �� �������
        if (currDisc <> prevTower.disks.Peek) or (destTower = prevTower) then exit;
//        if DestTower.disks.Count <> 0 then
//        begin
//            if DestTower.disks.peek.Width < currDisc.Width then exit;
//            currDisc.top := DestTower.Top + (DestTower.Height - 1*currDisc.Height)-DestTower.disks.Count*20;
//        end
//        else currDisc.top := DestTower.Top + DestTower.Height - 1*currDisc.Height;
//        currDisc.Left := DestTower.Left + (DestTower.Width - currDisc.Width) div 2;

//        prevTower.PopDisc();
//        destTower.PushDisc(currDisc);
//        currdisc.setCurrTower(destTower);

        self.moveDisk(currDisc,prevTower,DestTower);




      end;
  end;

end.
