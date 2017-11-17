program Sparse_Table;//maximum
const maxn=100000;
var n,m,i,j,le,ri,p:longint;
    st:array[1..maxn,0..16]of longint;

function max(x,y:longint):longint;
begin
    if x>y then exit(x)
    else exit(y);
end;

begin
    readln(n,m);
    for i:=1 to n do
    read(st[i,0]);
    for j:=1 to trunc(ln(n)/ln(2)) do//st[i,j]:=max(st[i,j-1],st[i+2^(j-1),j-1]);
        for i:=1 to n-(1 shl j)+1 do
            st[i,j]:=max(st[i,j-1],st[i+(1 shl (j-1)),j-1]);
    for i:=1 to m do
    begin
        readln(le,ri);
        p:=trunc(ln(ri-le+1)/ln(2));
        writeln(max(st[le,p],st[ri-(1 shl p)+1,p]));
    end;
end.