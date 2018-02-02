program Second_Best_Minimum_Spanning_Tree;
const maxn=15000;
    maxm=30000;
    maxlogn=14;
    maxedge=1000000000;
type edge=record
    w:longint;
    node:longint;
    next:longint;
    end;
var n,m,i,tot,mst,sbmst,tem:longint;
    head,fa,depth:array[1..maxn]of longint;
    f,g,w:array[1..maxm]of longint;
    e:array[1..2*maxn]of edge;
    dist,bneck:array[1..maxn,0..maxlogn]of longint;
    flag:array[1..maxm]of boolean;

procedure add(x,y,z:longint);
begin
    //writeln('add ',x,' ',y,' ',z);
    inc(tot);
    e[tot].w:=z;
    e[tot].node:=y;
    e[tot].next:=head[x];
    head[x]:=tot;
end;

function max(x,y:longint):longint;
begin
    if x>y then exit(x)
    else exit(y);
end;

procedure swap(var x,y:longint);
var t:longint;
begin
    t:=x;
    x:=y;
    y:=t;
end;

procedure qs(l,r:longint);//ascend
var x,y,key:longint;
begin
    x:=l;y:=r;
    key:=w[(l+r)shr 1];
    repeat
        while w[x]<key do inc(x);
        while w[y]>key do dec(y);
        if x<=y then
        begin
            swap(w[x],w[y]);
            swap(f[x],f[y]);
            swap(g[x],g[y]);
            inc(x);
            dec(y);
        end;
    until x>y;
    if x<r then qs(x,r);
    if y>l then qs(l,y);
end;

function find(x:longint):longint;
begin
    if fa[x]=x then
        exit(x);
    fa[x]:=find(fa[x]);
    exit(fa[x]);
end;

procedure kruskal();
var i,rx,ry:longint;
begin
    mst:=0;
    for i:=1 to n do
        fa[i]:=i;
    filldword(head,n,0);
    tot:=0;
    for i:=1 to m do
    begin
        rx:=find(f[i]);
        ry:=find(g[i]);
        if rx=ry then
            continue;
        fa[rx]:=ry;
        inc(mst,w[i]);
        flag[i]:=true;
        add(f[i],g[i],w[i]);
        add(g[i],f[i],w[i]);//建树
    end;
end;

procedure dfs(x,last,w:longint);
var i:longint;
begin
    //writeln('dfsing:',x,' from ',last,' with ',w);
    depth[x]:=depth[last]+1;
    dist[x,0]:=last;
    bneck[x,0]:=w;
    i:=1;
    while (1 shl i)<=depth[x] do
    begin
        dist[x,i]:=dist[dist[x,i-1],i-1];
        bneck[x,i]:=max(bneck[x,i-1],bneck[dist[x,i-1],i-1]);
        inc(i);
    end;
    i:=head[x];
    while i<>0 do
    begin
        if e[i].node<>last then
            dfs(e[i].node,x,e[i].w);
        i:=e[i].next;
    end;
end;

function get_bneck(x,y:longint):longint;//最长瓶颈路
var ans,d,i,maxl:longint;
begin
    ans:=0;
    if depth[x]<depth[y] then
        swap(x,y);
    d:=depth[x]-depth[y];
    i:=0;
    while d>0 do
    begin
        if (d and 1)=1 then
        begin
            ans:=max(ans,bneck[x,i]);
            x:=dist[x,i];
        end;
        d:=d shr 1;
        inc(i);
    end;
    maxl:=trunc(ln(depth[x])/ln(2));
    for i:=maxl downto 0 do
    begin
        if dist[x,i]<>dist[y,i] then
        begin
            ans:=max(ans,bneck[x,i]);
            ans:=max(ans,bneck[y,i]);
            x:=dist[x,i];
            y:=dist[y,i];
        end;
    end;
    if x<>y then
        ans:=max(max(ans,bneck[x,0]),bneck[y,0]);
    exit(ans);
end;

begin
    readln(n,m);
    for i:=1 to m do
        readln(f[i],g[i],w[i]);
    fillchar(flag,m,false);
    qs(1,m);
    kruskal;
    //writeln('kruskal finish');
    filldword(depth,n,0);
    for i:=1 to n do
        if depth[i]=0 then
            dfs(i,i,0);
    //writeln('dfs finish');
    sbmst:=maxedge;
    for i:=1 to m do
        if not(flag[i]) then
        begin
            tem:=mst+w[i]-get_bneck(f[i],g[i]);
            if tem<sbmst then
                sbmst:=tem;
        end;
    writeln(mst,' ',sbmst);
end.