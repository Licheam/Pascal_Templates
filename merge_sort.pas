program ascend_mergesory;
const maxn=100000;
var n,i:longint;
	a,t:array[1..maxn]of longint;

procedure ms(l,r:longint);
var mid,e,x,y:longint;
begin
	if l=r then exit;
	mid:=(l+r)div 2;
	ms(l,mid);ms(mid+1,r);
	e:=r;x:=mid;y:=r;
	repeat
		if a[x]>a[y] then
		begin
			t[e]:=a[x];
			dec(x);
		end
		else
		begin
			t[e]:=a[y];
			dec(y);
		end;
		dec(e);
	until(x<l)or(y=mid);
	while x>=l do
	begin
		t[e]:=a[x];
		dec(e);
		dec(x);
	end;
	while y>mid do
	begin
		t[e]:=a[y];
		dec(e);
		dec(y);
	end;
	for x:=l to r do
	a[x]:=t[x];
end;

begin
	readln(n);
	for i:=1 to n do read(a[i]);
	ms(1,n);
	for i:=1 to n do
	write(a[i],' ');
end.