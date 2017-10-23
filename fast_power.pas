var a,b,n:Int64;

function fpow(x,y,m:Int64):Int64;
var r,base:Int64;
begin
	r:=1;base:=x;
	while y<>0 do
	begin
		if (y and 1)=1 then r:=r*base mod n;//当i位为1时,r*=x^(2^i)
		base:=base*base mod n;//x^(2^i)*x^(2^i)=x^(2^(i+1)); same as i++ for base;
		y:=y shr 1;//i++ for y
	end;
	exit(r);
end;

begin
	readln(a,b,n);
	writeln(a,'^',b,' mod ',n,'=',fpow(a,b,n));
end.