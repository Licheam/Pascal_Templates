program small_root;
const maxn=1000000;
var len,i,v,n,c:longint;
    a:array[1..maxn]of longint;

procedure swap(var x,y:longint);
var t:longint;
begin
    t:=x;
    x:=y;
    y:=t;
end;

procedure up(x:longint);
var t:longint;
begin
    t:=x shr 1;
    if (x>1)and(a[x]<a[t]) then
    begin
        swap(a[x],a[t]);
        up(t);
    end;
end;

procedure down(x:longint);
var t:longint;
begin
    t:=x shl 1;
    if t>len then exit
    else if (t<len)and(a[t]>a[t+1]) then inc(t);
    if a[t]<a[x] then
    begin
        swap(a[x],a[t]);
        down(t);
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
            readln(v);
            insert(v);
        end;
    end;
end.