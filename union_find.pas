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
var	j,t:longint;
	path:array[1..maxn]of longint;
begin
	t:=0;
	find:=x;
	while fa[find]<>find do
	begin
		inc(t);
		path[t]:=find;
		find:=fa[find];
	end;
	for j:=1 to t-1 do fa[path[j]]:=find;
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