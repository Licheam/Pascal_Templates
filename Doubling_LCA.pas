program Doubling_LCA;
const maxn=500000;
    maxlogn=19;
type edge=record
    node:longint;
    next:longint;
    end;
var n,m,i,root,f,g,tot:longint;
    head,depth:array[1..maxn]of longint;
    dist:array[1..maxn,0..maxlogn]of longint;
    e:array[1..2*maxn]of edge;

procedure add(x,y:longint);
begin
    inc(tot);
    e[tot].node:=y;
    e[tot].next:=head[x];
    head[x]:=tot;
end;

procedure swap(var x,y:longint);
var t:longint;
begin
    t:=x;
    x:=y;
    y:=t;
end;

procedure dfs(x,last:longint);
var i,p:longint;
begin
    depth[x]:=depth[last]+1;
    dist[x,0]:=last;
    i:=1;
    while (1 shl i)<=depth[x] do
    begin
        dist[x,i]:=dist[dist[x,i-1],i-1];
        inc(i);
    end;
    p:=head[x];
    while p<>0 do
    begin
        if e[p].node<>last then
            dfs(e[p].node,x);
        p:=e[p].next;
    end;
end;

function get_lca(x,y:longint):longint;
var d,i,maxl:longint;
begin
    //使depth[x]=depth[y];
    if depth[x]<depth[y] then
        swap(x,y);
    d:=depth[x]-depth[y];
    i:=0;
    while d>0 do
    begin
        if (d and 1)=1 then
            x:=dist[x,i];
        inc(i);
        d:=d shr 1;
    end;
    //end
    maxl:=trunc(ln(depth[x])/ln(2));
    for i:=maxl downto 0 do
        if dist[x,i]<>dist[y,i] then
        begin
            x:=dist[x,i];
            y:=dist[y,i];
        end;
    if x<>y then
        x:=dist[x,0];
    exit(x);
end;

begin
    readln(n,m,root);
    filldword(head,n,0);
    for i:=1 to n-1 do
    begin
        readln(f,g);
        add(f,g);
        add(g,f);
    end;
    depth[root]:=0;
    dfs(root,root);
    for i:=1 to m do
    begin
        readln(f,g);
        writeln(get_lca(f,g));
    end;
end.