unit towerinf;

interface
  uses Vcl.Graphics, Vcl.ExtCtrls,System.Classes;

Type TTower = class(TShape)
public
  id:integer;
  constructor Create(AOwner: TComponent;name:string;x,y,height,wigth:integer;clr:Vcl.Graphics.TColor);



private
  num:integer;


end;



implementation

    constructor TTower.Create(AOwner: TComponent;name:string;x,y,height,wigth:integer;clr:Vcl.Graphics.TColor);
    begin
    inherited Create(AOwner);
       self.left:=x;
       self.top:=y;
       self.height:=height;
       self.width:=width;

       self.Name := name;
       self.num:=id;
       self.brush.Color:=clr;


    end;


end.

