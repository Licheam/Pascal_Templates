program small_root;
const maxn=1000000;
var len,i,t,n,c:longint;
    a:array[1..maxn]of longint;

function min(x,y:longint):longint;
begin
    if a[x]>a[y] then exit(y)
    else exit(x);
end;

procedure swap(var x,y:longint);
var k:longint;
begin
    k:=x;
    x:=y;
    y:=k;
end;

procedure up(x:longint);
var k:longint;
begin
    k:=x shr 1;
    if (x>1)and(a[x]<a[k]) then
    begin
        swap(a[x],a[k]);
        up(k);
    end;
end;

procedure down(x:longint);
var k,tem:longint;
begin
    k:=x shl 1;
    tem:=min(k,k+1);
    if (k<=len)and(a[tem]<a[x]) then
    begin
        swap(a[x],a[tem]);
        down(tem);
    end;
end;

procedure insert(x:longint);
begin
    inc(len);
    a[len]:=x;
    up(len);
end;

procedure delete(x:longint);
begin
    a[x]:=a[len];
    dec(len);
    down(x);
end;

begin
    readln(n);
    len:=0;
    for i:=1 to n do
    begin
        read(c);
        if c=2 then writeln(a[1])
        else if c=3 then delete(1)
        else if c=1 then
        begin
            readln(t);
            insert(t);
        end;
    end;
end.