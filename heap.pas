program small_root;
const maxn=1000000;
type 
	arr=array[1..maxn]of longint;
var len,i,t,n:longint;
	heap:arr;

procedure swap(x,y:longint;var a:arr);
var k:longint;
begin
	k:=a[x];
	a[x]:=a[y];
	a[y]:=k;
end;

procedure up(x:longint;var a:arr);
begin
	if(x>1)and(a[x div 2]>a[x])then
	begin 
		swap(x div 2,x,a);
		up(x div 2,a);
	end;
end;

procedure down(x:longint;var a:arr);
begin
	if(2*x<=len)and(a[2*x]<a[x])and(a[2*x+1]>=a[2*x]) then
	begin
		swap(2*x,x,a);
		down(2*x,a);
	end
	else if(2*x+1<=len)and(a[2*x+1]<a[x])and(a[2*x+1]<a[2*x]) then
	begin
		swap(2*x+1,x,a);
		down(2*x+1,a);
	end;
end;

procedure insert(x:longint;var a:arr);
begin
	inc(len);
	a[len]:=x;
	up(len,a);
end;

procedure delete(x:longint;var a:arr);
begin
	a[x]:=a[len];
	dec(len);
	down(x,a);
end;

begin
	readln(n);
	len:=0;
	for i:=1 to n do
	begin
		read(t);
		if t=2 then writeln(heap[1])
		else if t=3 then delete(1,heap)
		else if t=1 then
		begin
			readln(t);
			insert(t,heap);
		end;
	end;
end.