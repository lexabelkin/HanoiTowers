unit Boardinf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, towerImageclass, Vcl.StdCtrls, Vcl.ExtCtrls, discinf,
  system.Generics.Collections, Vcl.MPlayer,  System.StrUtils, Vcl.NumberBox,
  Vcl.ComCtrls, Vcl.Samples.Gauges, Vcl.Imaging.jpeg, Vcl.Buttons;

type TSandBoard = class(TForm)
    Memo1: TMemo;
    Label2: TLabel;
    NumberBox1: TNumberBox;
    NumberBox2: TNumberBox;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton4: TSpeedButton;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Reset(Sender: TObject);
    procedure Animate(n,i,k:integer);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);


  private
    towers:array of TTower;

  public
      procedure BoardCreate(custom:integer);
  end;

var
  SandBoard: TSandBoard;
implementation

{$R *.dfm}






 procedure TSandBoard.BoardCreate(custom:integer);
    begin
    TTower.DefineVars(label1,memo1,numberbox2.ValueInt,self,false);

    if self.towers <> nil then exit;

    SetLength(self.towers, 3);
    for var i := 0 to 2 do
    begin
      self.towers[i] := TTower.Create(self);
      //self.towers[i].Init(self, ('tower' + IntToStr(i)), 150 + i * 300, 240, 20, 180,i);
      self.towers[i].OnDragOver:=self.towers[i].TowerDragOver;
      self.towers[i].OnDragDrop:=self.towers[i].TowerDragDrop;

      self.towers[i].DragMode:= dmAutomatic;
      //self.towers[i].DragKind := dkDock;
    end;
    self.towers[0].Init(self, 'tower0', 15, 162, 250, 350,0);
    self.towers[1].Init(self, 'tower1', 110 +  200, 162, 250, 350,1);
    self.towers[2].Init(self, 'tower2' , 150 + 465, 162, 250, 350,2);
    TTower.FillFirstTower(self.towers[0],strtoint(numberbox1.Text),self);
 end;



procedure TSandBoard.Button1Click(Sender: TObject);
begin
  //create board
  sandboard.boardcreate(3);
  speedbutton1.Enabled:= False;
  speedbutton2.Enabled:= True;
  speedbutton3.Enabled:= True;
end;

procedure TSandBoard.Reset(Sender: TObject);
begin
  //reset
  for var i := 0 to 2 do
  begin
    for var j := 0 to self.towers[i].GetDiscs().count-1 do
      self.towers[i].PopDisc().Free ;
    self.towers[i].free;
  end;
  self.towers := nil;
  label1.caption:='0';
  memo1.Lines.Clear;

  speedbutton1.Enabled:=True;
  speedbutton2.Enabled:=False;
  speedbutton3.Enabled:=False;
end;

procedure TSandBoard.SpeedButton4Click(Sender: TObject);
begin
  var
  buttonSelected : Integer;
begin
  // Show a confirmation dialog
  buttonSelected := MessageDlg('�� ������������� ������� ����� � ����?',mtCustom, mbOKCancel, 0);

  // Show the button type selected
  if buttonSelected = mrOK  then
  begin
    try sandboard.Reset(self); except end;
    self.Close();
  end;

end;

end;

procedure TSandBoard.Button3Click(Sender: TObject);
begin
  // start animate
  var h,i,k : integer;
  TTower.DefineVars(label1,memo1,numberbox2.ValueInt,self,false);
  h := strtoint(numberbox1.Text);
  i := 1;
  k := 3;
  speedbutton2.Enabled:=False;
  try
  self.Animate(strtoint(numberbox1.Text),i-1,k-1);
  except end;

  speedbutton2.Enabled:= True;
end;




procedure TSandBoard.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try sandboard.Reset(self); except end;
end;

procedure TSandBoard.FormCreate(Sender: TObject);
begin
label1.Color:=RGB(77, 69, 58);

numberbox1.Color:=RGB(77, 69, 58);
numberbox1.Font.Color:=RGB(203, 174, 134);

numberbox2.Color:=RGB(77, 69, 58);
numberbox2.Font.Color:=RGB(203, 174, 134);
end;

procedure TSandBoard.Animate(n,i,k:integer);
begin

  if n = 1 then TTower.moveDisk(self.towers[i].GetDiscs().Peek,self.towers[i],self.towers[k])
  else
  begin
    var tmp:integer :=3-i-k;
    self.Animate(n-1,i,tmp);

    TTower.moveDisk(self.towers[i].GetDiscs().Peek,self.towers[i],self.towers[k]);
    self.Animate(n-1,tmp,k)

    end;

end;


end.
