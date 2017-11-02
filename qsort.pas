program ascend_qs;
const maxn=100000;
var n,i:longint;
	a:array[1..maxn]of longint;

procedure swap(var x,y:longint);
var t:longint;
begin	
	t:=x;
	x:=y;
	y:=t;
end;

procedure qs(l,r:longint);//ascend
var x,y,k:longint;
begin
	x:=l;y:=r;
	k:=a[(l+r)shr 1];
	repeat
		while a[x]<k do inc(x);
		while a[y]>k do dec(y);
		if x<=y then
		begin
			swap(a[x],a[y]);
			inc(x);
			dec(y);
		end;
	until x>y;
	if l<y then qs(l,y);
	if r>x then qs(x,r);
end;

begin
	readln(n);
	for i:=1 to n do read(a[i]);
	qs(1,n);
	for i:=1 to n do
	write(a[i],' ');
end.