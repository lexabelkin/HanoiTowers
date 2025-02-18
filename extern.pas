unit extern;

interface
uses
  Classes,
  SysUtils,StrUtils, Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls,
   Vcl.ImgList, Vcl.Graphics, System.Types;

type
  TShapeDragObject = class(TDragObject)
  private
    FShape: TShape;
    FDragImage: TBitmap;
  public


  end;


procedure hanoi_any(textelem:TMemo; n,i,k:integer);




implementation


procedure hanoi_any(textelem:TMemo;n,i,k:integer);
begin
  if n = 1 then textelem.lines.Add(Format('Move disk 1 from pin %d to %d',[i,k]))
  else
  begin
    var tmp:integer :=3-i-k;

    hanoi_any(textelem, n-1, i, tmp);

    textelem.lines.Add(Format('Move disk %d from pin %d to %d',[n,i,k]));
    hanoi_any(textelem, n-1, tmp, k);
    end;
end;


end.
