unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StrUtils, extern,
  System.Sensors, System.Sensors.Components, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Buttons,inifiles;

type
  TMainMenu = class(TForm)
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;

 published
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);



  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  MainMenu: TMainMenu;

implementation

{$R *.dfm}

uses  Boardinf, GameUnit;








procedure TMainMenu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
Application.Terminate();
end;

procedure TMainMenu.SpeedButton1Click(Sender: TObject);
begin
//with sandboard.Create(Self) do try ShowModal; finally Destroy; end;
  sandboard.Showmodal();
end;

procedure TMainMenu.SpeedButton2Click(Sender: TObject);
begin
  GameBoard.Showmodal();

end;

end.
