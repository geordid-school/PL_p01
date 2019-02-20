program gcd(input,output);

function gcd(x,y:integer):integer;
begin
  while x<>y do
    if x>y then
      x:=x-y
    else
      y:=y-x;
  gcd:=x
end;

procedure extendedEuclid(u,v:integer; var u3out,u1out,u2out:integer);
// See Knuth, TAOCP, Vol 2, p. 342, Algorithm X
// u and v are input; u1out, u2out, u3out are output such that
// u•u1out + v•u2out = u3out = gcd(u,v)
var
  t,uArray,vArray:array[1..3] of integer;
  i,q:integer;
begin
  uArray[1]:=1;
  uArray[2]:=0;
  uArray[3]:=u;

  vArray[1]:=0;
  vArray[2]:=1;
  vArray[3]:=v;

  while vArray[3]<>0 do
  begin
    q:=uArray[3] Div vArray[3];

    for i:=1 to 3 do
      t[i]:=uArray[i]-vArray[i]*q;

    for i:=1 to 3 do
      uArray[i]:=vArray[i];

    for i:=1 to 3 do
      vArray[i]:=t[i]
  end;

  u1out:=uArray[1];
  u2out:=uArray[2];
  u3out:=uArray[3]
end;

procedure main;
var x,y,u1out,u2out,u3out:integer;

begin
  read(x);
  read(y);
  while (x<>0) and (y<>0) do
  begin
    writeln('gcd of ',x:1,' and ',y:1,' is ',gcd(x,y):1);
    extendedEuclid(x,y,u3out,u1out,u2out);
    writeln(x:1,'•',u1out:1,' + ',y:1,'•',u2out:1,' = ',u3out:1,
      ' = gcd(',x:1,',',y:1,')');
    read(x);
    read(y)
  end
end;

begin
  main
end.
