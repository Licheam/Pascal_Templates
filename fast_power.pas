var a,b,n:Int64;

function binpow(x,y,m:Int64):Int64;
var r:Int64;
begin
    r:=1;
    while y<>0 do
    begin
        if (y and 1)=1 then r:=r*x mod n;//当i位为1时,r*=x^(2^i)
        x:=x*x mod n;//x^(2^i)*x^(2^i)=x^(2^(i+1)); same as i++ for x;
        y:=y shr 1;//i++ for y
    end;
    exit(r);
end;

function decpow(x,y,m:Int64):Int64;//用二进制优化过但还是比二进制慢的十进制快速幂
var r:Int64;
begin
    r:=1;
    while y<>0 do
    begin
        r:=r*binpow(x,y mod 10,m) mod m;
        x:=binpow(x,10,m);
        y:=y div 10;
    end;
    exit(r);
end;

begin
    readln(a,b,n);
    writeln(a,'^',b,' mod ',n,'=',binpow(a,b,n));//还是用二进制的吧，十进制太蠢了
end.