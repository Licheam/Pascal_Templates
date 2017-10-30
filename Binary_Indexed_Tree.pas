program Binary_Indexed_Tree;//单点修改 区间查询
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

program Binary_Indexed_Tree;//区间修改 单点查询
const maxn=500000;
var n,m,i,c,l,r,p,q:longint;
	a,t:array[0..maxn]of longint;

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
	t[0]:=0;
	for i:=1 to n do
	begin
		read(t[i]);
		change(i,t[i]-t[i-1]);
	end;
	for i:=1 to m do
	begin
		read(c);
		if c=1 then
		begin
			readln(l,r,q);
			change(l,q);
			change(r+1,-q);
		end
		else
		begin
			readln(p);
			writeln(sum(p));
		end;
	end;
end.

program Binary_Indexed_Tree;//区间修改 区间查询
const maxn=500000;
type arr=array[0..maxn]of longint;
var n,m,i,c,l,r,q:longint;
	a1,a2,t:arr;

function lowbit(x:longint):longint;
begin
	exit(x and (-x));
end;

procedure change(x,y:longint;var a:arr);
begin
	while x<=n do
	begin
		inc(a[x],y);
		inc(x,lowbit(x));
	end;
end;

function sum(x:longint;var a:arr):longint;
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
	fillchar(a1,4*n,0);
	fillchar(a2,4*n,0);
	t[0]:=0;
	for i:=1 to n do
	begin
		read(t[i]);
		change(i,t[i]-t[i-1],a1);
		change(i,(t[i]-t[i-1])*i,a2);
	end;
	for i:=1 to m do
	begin
		read(c);
		if c=1 then
		begin
			readln(l,r,q);
			change(l,q,a1);
			change(r+1,-q,a1);
			change(l,q*l,a2);
			change(r+1,-q*(r+1),a2);
		end
		else
		begin
			readln(l,r);
			writeln((r+1)*sum(r,a1)-sum(r,a2)-l*sum(l-1,a1)+sum(l-1,a2));
		end;
	end;
end.