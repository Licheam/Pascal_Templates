program Tarjan_Shink_Point;
const maxn=10000;
    maxm=100000;
type edge=record
    node:longint;
    next:longint;
    end;
var n,m,i,tot,dfn_i,scc_i,top,ans:longint;
    dfn,low,scc,head,stack,w,sum,dp:array[1..maxn]of longint;//dfn时间戳，low最早的circle时间戳
    f,g:array[1..maxm]of longint;
    e:array[1..maxm]of edge;
    instack:array[1..maxn]of boolean;

procedure add(x,y:longint);
begin
    inc(tot);
    e[tot].next:=head[x];
    e[tot].node:=y;
    head[x]:=tot;
end;

procedure tarjan(x:longint);//scc
var p,v:longint;
begin
    inc(dfn_i);
    dfn[x]:=dfn_i;
    low[x]:=dfn_i;
    instack[x]:=true;
    inc(top);
    stack[top]:=x;
    p:=head[x];
    while p<>0 do
    begin
        v:=e[p].node;
        if dfn[v]=0 then
        begin
            tarjan(v);
            if low[v]<low[x] then
                low[x]:=low[v];
        end
        else if (instack[v])and(dfn[v]<low[x]) then //cross or back
            low[x]:=dfn[v];
        p:=e[p].next;
    end;
    if low[x]=dfn[x] then
    begin
        inc(scc_i);
        sum[scc_i]:=0;
        v:=0;
        while v<>x do
        begin
            v:=stack[top];
            scc[v]:=scc_i;
            inc(sum[scc_i],w[v]);
            instack[v]:=false;
            dec(top);
        end;
    end;
end;

procedure dfs(x:longint);
var max,p,v:longint;
begin
    max:=0;
    p:=head[x];
    while p<>0 do
    begin
        v:=e[p].node;
        if dp[v]=0 then
            dfs(v);
        if dp[v]>max then
            max:=dp[v];
        p:=e[p].next;
    end;
    dp[x]:=sum[x]+max;
    if ans<dp[x] then
        ans:=dp[x];
end;

begin
    readln(n,m);
    for i:=1 to n do
        read(w[i]);
    filldword(head,n,0);
    tot:=0;
    for i:=1 to m do
    begin
        readln(f[i],g[i]);
        add(f[i],g[i]);
    end;
    fillchar(instack,n,false);
    filldword(dfn,n,0);
    dfn_i:=0;
    scc_i:=0;
    top:=0;
    for i:=1 to n do
        if dfn[i]=0 then
            tarjan(i);
    tot:=0;
    filldword(head,n,0);
    for i:=1 to m do
        if scc[f[i]]<>scc[g[i]] then
            add(scc[f[i]],scc[g[i]]);
    filldword(dp,scc_i,0);
    ans:=0;
    for i:=1 to scc_i do
        if dp[i]=0 then
            dfs(i);
    writeln(ans);
end.