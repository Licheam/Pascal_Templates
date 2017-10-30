program Binary_Indexed_Tree;
const maxn=500000;
var n,m,i,t,c,p,q:longint;
	a:array[1..maxn]of longint;

function lowbit(x:longint):longint;
begin
	exit(x and (-x));
end;

procedure change(x,y:longint);
begin
	while x<=n do
	begin
		inc(a[x],y);
		inc(x,lowbit(x));
	end;
end;

function sum(x:longint):longint;
begin
	sum:=0;
	while x>0 do
	begin
		inc(sum,a[x]);
		dec(x,lowbit(x));
	end;
end;

begin
	readln(n,m);
	fillchar(a,4*n,0);
	for i:=1 to n do
	begin
		read(t);
		change(i,t);
	end;
	for i:=1 to m do
	begin
		readln(c,p,q);
		if c=1 then change(p,q)
		else writeln(sum(q)-sum(p-1));
	end;
end.