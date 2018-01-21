const maxn=1000;
var n,m,i,w:longint;
    a:array[1..maxn,1..maxn]of longint;

procedure floyd();
var i,j,k:longint;
begin
    for i:=1 to n do//中间点
        for j:=1 to n do
            for k:=1 to n do
            begin
                if a[j,k]>a[j,i]+a[i,k] then
                a[j,k]:=a[j,i]+a[i,k];
            end;
end;

begin
    readln(n,m);

    for i:=1 to n do
        for j:=1 to n do
            if i=j then a[i,j]:=0
            else
            a[i,j]:=maxlongint;

    for i:=1 to m do
    begin
        readln(f,g,w);
        a[f,g]:=w;
    end;

    floyd;
    //没写输出
end.