program small_root;
const maxn=1000000;
var len,i,t,n:longint;
	heap:array[1..maxn]of longint;

procedure swap(x,y:longint);
var k:longint;
begin
	k:=heap[x];
	heap[x]:=heap[y];
	heap[y]:=k;
end;

procedure up(x:longint);
begin
	if(x>1)and(heap[x div 2]>heap[x])then
	begin 
		swap(x div 2,x);
		up(x div 2);
	end;
end;

procedure down(x:longint);
begin
	if(2*x<=len)and(heap[2*x]<heap[x])and(heap[2*x+1]>=heap[2*x]) then
	begin
		swap(2*x,x);
		down(2*x);
	end
	else if(2*x+1<=len)and(heap[2*x+1]<heap[x])and(heap[2*x+1]<heap[2*x]) then
	begin
		swap(2*x+1,x);
		down(2*x+1);
	end;
end;

procedure insert(x:longint);
begin
	inc(len);
	heap[len]:=x;
	up(len);
end;

procedure delete(x:longint);
begin
	heap[x]:=heap[len];
	dec(len);
	down(x);
end;

begin
	readln(n);
	len:=0;
	for i:=1 to n do
	begin
		read(t);
		if t=2 then writeln(heap[1])
		else if t=3 then delete(1)
		else if t=1 then
		begin
			readln(t);
			insert(t);
		end;
	end;
end.