program XO;


USES graph, crt,sysutils;

VAR x0,y0,i,k,j:integer;
ch,zn:char;
a:array[1..5,1..5] of shortint;
n,w,e,ctrl,Winner:shortint;
output:TextFile;


CONST gm:smallint=2;
gd:smallint=vga;

{=================================}
procedure StartMenu; {startovaja stranica}
begin
SetColor(15);
SetTextStyle(0,0,3);
OutTextXY(300,30,'XOX');
SetTextStyle(0,0,1);
OutTextXY(150,110,'CREATOR: Nasypalov Nikita IT-12.');
OutTextXY(150,180,'MANUAL:');
OutTextXY(150,200,'Use keys');
OutTextXY(150,220,'LEFT'); OutTextXY(200,220,chr(27));
OutTextXY(150,240,'RIGHT'); OutTextXY(200,240,chr(26));
OutTextXY(150,260,'UP'); OutTextXY(200,260,chr(24));
OutTextXY(150,280,'DOWN'); OutTextXY(200,280,chr(25));
OutTextXY(150,300,'for moving the cursor.');
OutTextXY(250,330,'Use ENTER for check your symbol.');
OutTextXY(250,380, 'PRESS ANY KEY TO START GAME');
end;
{=====================================}
procedure ExitMenu; {menu posle igri}
begin setcolor(15);
SetTextStyle(0,0,1);
OutTextXY(20,330,'If you want to exit, press ''ESCAPE''');
OutTextXY(20,360,'If you want to restart game, press ANY KEY');
line(0,302,450,302);
line(0,302,0,400);
line(0,400,450,400);
line(450,400,450,302);
end;
{=====================================}
procedure rect(x,y,c:integer);
begin
setcolor(c);
rectangle(x,y,x+26,y+26);
end;
{======================================}
procedure Lattice;
begin setcolor(14);
line(50,80,50,230); {reshetka}
line(80,80,80,230);
line(110,80,110,230);
line(140,80,140,230);

line(20,110,170,110);
line(20,140,170,140);
line(20,170,170,170);
line(20,200,170,200);

SetTextStyle(0,0,2);
OutTextXY(20,30,'Let''s play!');
line(0,0,0,300); {ramka}
line(223,0,223,300);
line(0,300,223,300);
line(0,0,223,0);
end;
{=================================}
procedure Manual;
begin setcolor(4);
line(225,0,225,300);
line(225,300,450,300);
line(450,0,450,300);
line(225,0,450,0);
SetTextStyle(0,0,2);
OutTextXY(240,30,'How to play');
SetTextStyle(0,0,1);
OutTextXY(290,80,'Use keys');
OutTextXY(295,105,'LEFT'); OutTextXY(350,110,chr(27));
OutTextXY(295,125,'RIGHT'); OutTextXY(350,130,chr(26));
OutTextXY(295,145,'UP'); OutTextXY(350,150,chr(24));
OutTextXY(295,165,'DOWN'); OutTextXY(350,170,chr(25));
OutTextXY(245,190,'for moving the cursor.');
OutTextXY(290,230,'Use ENTER');
OutTextXY(250,250,'for check your symbol.');
end;
{=================================}
procedure Symbol(var x,y:integer;zn:char;clr:shortint); {simvol X or O v igrovom pole}
begin SetColor(clr+3);
SetTextStyle(0,0,2);
case x of
22:
  begin
   case y of
    82: OutTextXY(30,90,zn);
    112: OutTextXY(30,120,zn);
    142: OutTextXY(30,150,zn);
    172: OutTextXY(30,180,zn);
    202: OutTextXY(30,210,zn);
   end;
  end;
52:
  begin
   case y of
    82: OutTextXY(60,90,zn);
    112: OutTextXY(60,120,zn);
    142: OutTextXY(60,150,zn);
    172: OutTextXY(60,180,zn);
    202: OutTextXY(60,210,zn);
   end;
  end;
82:
begin
 case y of
  82: OutTextXY(90,90,zn);
  112: OutTextXY(90,120,zn);
  142: OutTextXY(90,150,zn);
  172: OutTextXY(90,180,zn);
  202: OutTextXY(90,210,zn);
 end;
end;
112:
  begin
   case y of
    82: OutTextXY(120,90,zn);
    112: OutTextXY(120,120,zn);
    142: OutTextXY(120,150,zn);
    172: OutTextXY(120,180,zn);
    202: OutTextXY(120,210,zn);
   end;
  end;
142:
  begin
   case y of
    82: OutTextXY(150,90,zn);
    112: OutTextXY(150,120,zn);
    142: OutTextXY(150,150,zn);
    172: OutTextXY(150,180,zn);
    202: OutTextXY(150,210,zn);
   end;
  end;
end;
end;
{=================================}
Procedure UpDown(var x,y: integer);
begin
if ch=#0 then ch:=readkey;
case ch of
#72: begin rect(x,y,0);
if y=82 then y:=202 else y:=y-30;
rect(x,y,15);
end;
#80: begin rect(x,y,0);
if y=202 then y:=82 else y:=y+30;
rect(x,y,15);
end;
end;
end;
{=================================}
procedure LeftRight(var x,y:integer);
begin if ch=#0 then ch:=readkey;
case ch of
#75: begin rect(x,y,0); {left}
if x=22 then x:=142 else x:=x-30;
rect(x,y,15);
end;
#77: begin rect(x,y,0); {right}
if x=142 then x:=22 else x:=x+30;
rect(x,y,15);
end;
end;
end;
{=================================}
procedure CheckWinner();
var sum_row,sum_col,sum_diag1,sum_diag2 : shortint;
BEGIN
sum_diag1:=0;
sum_diag2:=0;
for k:=1 to 5 do begin
  sum_row:=0;
  sum_col:=0;
  for j:=1 to 5 do begin
    sum_row:=sum_row + a[k,j];
    sum_col:=sum_col + a[j,k];
  end;
  sum_diag1:=sum_diag1 + a[k,k];
  sum_diag2:=sum_diag2 + a[k,6-k];
  if (sum_row=5) OR (sum_col=5) then Winner:=1;
  if (sum_row=-5) OR (sum_col=-5) then Winner:=2;
end;
  if (sum_diag1=5) OR (sum_diag2=5) then Winner:=1;
  if (sum_diag1=-5) OR (sum_diag2=-5) then Winner:=2;
END;


BEGIN

initgraph(gd,gm,'');
repeat StartMenu;
until keypressed;

assign(output,'output.txt');
rewrite(output);


REPEAT
ClearDevice;
x0:=22; y0:=82;
i:=1;
Winner:=0;
for k:=1 to 5 do
for j:=1 to 5 do a[k,j]:=0;
repeat
ctrl:=0;
if (i mod 2 = 1) then begin zn:='X'; n:=1; end
else begin zn:='O'; n:=-1; end;
Lattice;
Manual;
ch:=readkey;
if (ord(ch)=72) or (ord(ch)=80) then UpDown(x0,y0);
if (ord(ch)=75) or (ord(ch)=77) then LeftRight(x0,y0);
case x0 of
22: begin case y0 of
82: begin w:=1; e:=1; end;
112: begin w:=1; e:=2; end;
142: begin w:=1; e:=3; end;
172: begin w:=1; e:=4; end;
202: begin w:=1; e:=5; end;
end;
end;
52: begin case y0 of
82: begin w:=2; e:=1; end;
112: begin w:=2; e:=2; end;
142: begin w:=2; e:=3; end;
172: begin w:=2; e:=4; end;
202: begin w:=2; e:=5; end;
end;
end;
82: begin case y0 of
82: begin w:=3; e:=1; end;
112: begin w:=3; e:=2; end;
142: begin w:=3; e:=3; end;
172: begin w:=3; e:=4; end;
202: begin w:=3; e:=5; end;
end;
end;
112: begin case y0 of
82: begin w:=4; e:=1; end;
112: begin w:=4; e:=2; end;
142: begin w:=4; e:=3; end;
172: begin w:=4; e:=4; end;
202: begin w:=4; e:=5; end;
end;
end;
142: begin case y0 of
82: begin w:=5; e:=1; end;
112: begin w:=5; e:=2; end;
142: begin w:=5; e:=3; end;
172: begin w:=5; e:=4; end;
202: begin w:=5; e:=5; end;
end;
end;
end;
if ord(ch)=13 then begin
if a[w,e]=0 then begin a[w,e]:=n; inc(i); symbol(x0,y0,zn,n);
writeln(output,zn+': ('+IntToStr(w)+', '+IntToStr(e)+')');
end
else continue;
end;

CheckWinner;

if Winner = 1 then
begin setcolor(1);
outtextxy(10,270,'Player X wins');
writeln(output,'Player X wins');
close(output);
break;
end;

if Winner = 2 then
begin setcolor(2);
outtextxy(10,270,'Player O wins');
writeln(output,'Player O wins');
close(output);
break;
end;

for k:=1 to 5 do
for j:=1 to 5 do
if a[k,j]=0 then inc(ctrl);
if ctrl=0 then
begin setcolor(15);
OutTextXY(20,220,'Drawn game!');
writeln(output,'Drawn game!');
close(output);
break;
end;

until ord(ch)=27;
ExitMenu;
ch:=readkey;
if ord(ch)=32 then continue;
UNTIL ord(ch)=27;
closegraph;
END.
