program hanoi;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainMenu},
  discinf in 'discinf.pas',
  Boardinf in 'Boardinf.pas' {SandBoard},
  TowerClass in 'TowerClass.pas',
  GameUnit in 'GameUnit.pas' {GameBoard},
  TowerImageClass in 'TowerImageClass.pas',
  LevelDialog in 'LevelDialog.pas' {NextLevelDialog},
  loadWnd in 'loadWnd.pas' {LoadingScreen};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
   Application.CreateForm(TLoadingScreen, LoadingScreen);
  Application.CreateForm(TMainMenu, MainMenu);
  Application.CreateForm(TSandBoard, SandBoard);
  Application.CreateForm(TGameBoard, GameBoard);
  Application.CreateForm(TNextLevelDialog, NextLevelDialog);
  Application.Run;
end.
