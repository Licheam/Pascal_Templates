program Khan;
const maxn=100000;
    maxm=200000;
type edge=record
    next:longint;
    node:longint;
    end;

var n,m,i,tot,f,g,cnt,top:longint;
    head,indgr,list,stack:array[1..maxn]of longint;
    e:array[1..maxm]of edge;
    flag:array[1..maxn]of boolean;

procedure add(x,y:longint);
begin
    inc(tot);
    e[tot].node:=y;
    e[tot].next:=head[x];
    head[x]:=tot;
end;

procedure khan();
var i,p,u,v:longint;
begin
    cnt:=0;
    top:=0;
    fillchar(flag,n,false);
    for i:=1 to n do
    begin
        if (flag[i])or(indgr[i]<>0) then continue;
        inc(top);
        stack[top]:=i;
        flag[i]:=true;
        while top>0 do
        begin
            u:=stack[top];
            inc(cnt);
            list[cnt]:=u;
            flag[u]:=true;
            dec(top);
            p:=head[u];
            while p<>0 do
            begin
                v:=e[p].node;
                dec(indgr[v]);
                if indgr[v]=0 then
                begin
                    inc(top);
                    stack[top]:=v;
                end;
                p:=e[p].next;
            end;
        end;
    end;
end;

begin
    readln(n,m);
    filldword(head,n,0);
    filldword(indgr,n,0);
    tot:=0;
    for i:=1 to m do
    begin
        readln(f,g);
        add(f,g);
        inc(indgr[g])
    end;
    khan;
    for i:=1 to n do
        write(list[i],' ');
end.

program Kahn;
const maxn=100;
var n,u,v,cnt,i,j,p:longint;
    e:array[1..maxn,1..maxn]of boolean;
    list,stack,indgr:array[1..maxn]of longint;
    flag:array[1..maxn]of boolean;

begin
    readln(n);
    fillchar(e,sizeof(e),false);
    filldword(indgr,n,0);
    while not(eof) do
    begin
        readln(u,v);//u>v
        e[u,v]:=true;
        inc(indgr[v]);
    end;
    cnt:=0;
    p:=0;
    fillchar(flag,n,false);
    for i:=1 to n do
    begin
        if (flag[i])or(indgr[i]<>0) then continue;
        inc(p);
        stack[p]:=i;
        while p<>0 do
        begin
            u:=stack[p];
            inc(cnt);
            list[cnt]:=u;
            dec(p);
            flag[u]:=true;
            for j:=1 to n do
                if e[u,j] then
                begin
                    dec(indgr[j]);
                    if indgr[j]=0 then
                    begin
                        inc(p);
                        stack[p]:=j;
                    end;
                end;
        end;
    end;
    if cnt<>n then writeln(-1)
    else
        for i:=1 to n do
        write(list[i],' ');
end.