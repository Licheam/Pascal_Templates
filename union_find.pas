const maxn=10000;
var n,m,i,a,b,c:longint;
	fa:array[1..maxn]of longint;

procedure ini();
var j:longint;
begin
	for j:=1 to n do
	fa[j]:=j;
end;

function find(x:longint):longint;
var	j:longint;
begin
	if fa[x]=x then exit(x);
	fa[x]:=find(fa[x]);
	exit(fa[x]);
end;

procedure union(x,y:longint);
begin
	fa[find(x)]:=find(y);
end;

begin
	readln(n,m);
	ini;
	for i:=1 to m do
	begin
		readln(a,b,c);
		if a=1 then union(b,c)
		else if find(b)=find(c) then writeln('Y')
		else writeln('N');
	end;
end.