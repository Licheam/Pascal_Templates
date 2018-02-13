const maxn;
    maxm;
type edge=record
    node:longint;
    next:longint;
    end;
var dfn_i,scc_i,top:longint;
    dfn,low,scc,head,stack:array[1..maxn]of longint;//dfn时间戳，low最早的circle时间戳
    e:array[1..maxm]of edge;
    flag:array[1..maxn]of boolean;

procedure tarjan(x:longint);//scc
var p,u:longint;
begin
    inc(dfn_i);
    dfn[x]:=dfn_i;
    low[x]:=dfn_i;
    flag[x]:=true;
    inc(top);
    stack[top]:=x;
    p:=head[x];
    while p<>0 do
    begin
        u:=e[p].node;
        if dfn[u]=0 then
        begin
            tarjan(u);
            if low[u]<low[x] then
                low[x]:=low[u];
        end
        else if (flag[u])and(dfn[u]<low[x]) then //cross or back
            low[x]:=dfn[u];
        p:=e[p].next;
    end;
    if low[x]=dfn[x] then
    begin
        inc(scc_i);
        u:=0;
        while u<>x do
        begin
            u:=stack[st];
            scc[u]:=scc_i;
            flag[u]:=false;
            dec(st);
        end;
    end;
end;