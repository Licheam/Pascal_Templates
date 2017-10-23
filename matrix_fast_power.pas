const maxn=100;
	p=1000000007;
type
	matrix=array[1..maxn,1..maxn]of Int64;
	
var n,i,j:longint;
	k:Int64;
	m:matrix;
	
function cross(x,y:matrix):matrix;
var t:matrix;
	i,j,k:longint;
begin
	for i:=1 to n do
	for j:=1 to n do
	begin
		t[i,j]:=0;
		for k:=1 to n do
		t[i,j]:=(t[i,j]+x[i,k]*y[k,j]) mod p;
	end;
	exit(t);
end;

function fpow(x:matrix;y:Int64):matrix;
var r:matrix;
	i,j:longint;
begin
	for i:=1 to n do
	for j:=1 to n do
	if i=j then r[i,j]:=1
	else r[i,j]:=0;
	while y<>0 do
	begin
		if (y and 1)=1 then r:=cross(r,x);
		x:=cross(x,x);
		y:=y shr 1;
	end;
	exit(r);
end;

begin
	readln(n,k);
	for i:=1 to n do
	for j:=1 to n do
	read(m[i,j]);
	m:=fpow(m,k);
	for i:=1 to n do
	begin
		for j:=1 to n-1 do
		write(m[i,j],' ');
		writeln(m[i,n]);
	end;
end.