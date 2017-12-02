program Bipartite_Matching;
const maxn=2000;

var n,m,u,v,i:longint;
    color:array[1..maxn]of longint;
    e:array[1..maxn,1..maxn]of boolean;

function dye(x:longint):boolean;
var i,col:longint;
begin
    if color[x]=1 then col:=2
    else col:=1;
    for i:=1 to n do
    if e[x,i] then
    begin
        if color[i]=0 then
        begin
            color[i]:=col;
            if not(dye(i)) then
            exit(false);
        end
        else if color[i]<>col then
        exit(false);
    end;
    exit(true);
end;

begin
    readln(n,m);
    fillchar(e,sizeof(e),false);
    filldword(color,n,0);//1,2
    for i:=1 to m do
    begin
        readln(u,v);
        e[u,v]:=true;
        e[v,u]:=true;
    end;
    for i:=1 to n do
    begin
        if color[i]=0 then
        begin
            color[i]:=1;
            if not(dye(i)) then
            begin
                writeln('NO');
                halt;
            end;
        end;
    end;
    writeln('YES');
end.