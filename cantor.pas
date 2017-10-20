program cantor;
var s:string;
	fac:array[0..9]of longint;
	i,n:longint;
	
function cantor(st:string):longint;
var j,k,temp,num:longint;
begin
	num:=1;
	for j:=1 to 8 do
	begin
		temp:=0;
		for k:=j+1 to 9 do
		if st[k]<st[j] then inc(temp);
		inc(num,fac[9-j]*temp);
	end;
	exit(num);
end;

function revcantor(x:longint):string;
var j,k,q,r:longint;
	st:string;
	temb:array[0..8]of boolean;
begin
	for j:=0 to 8 do temb[j]:=true;
	st:='000000000';
	r:=x-1;
	for j:=9 downto 1 do
	begin
		q:=r div fac[j-1];
		dec(r,q*fac[j-1]);
		for k:=0 to 8 do
		if temb[k] then
		begin
			if q=0 then break;
			dec(q);
		end;
		temb[k]:=false;
		inc(st[10-j],k);
	end;
	exit(st);
end;

begin
	fac[0]:=1;
	for i:=1 to 8 do fac[i]:=fac[i-1]*i;
	readln(n);
	writeln(revcantor(n));
	writeln(cantor(revcantor(n)));
	readln(s);
	writeln(cantor(s));
	writeln(revcantor(cantor(s)));
end.