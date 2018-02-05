program Dijkstra;
const maxn=10000;
    maxm=500000;

type edge=record
    v:longint;
    next:longint;
    node:longint;
    end;

var n,m,p,i,f,g,w,len,tot:longint;
    e:array[1..maxm]of edge;
    dist,head,h,po:array[1..maxn]of longint;
    flag:array[1..maxn]of boolean;
  
procedure swap(var x,y:longint);
var t:longint;
begin
    t:=x;
    x:=y;
    y:=t;
end;

procedure add(x,y,z:longint);
begin
    inc(tot);
    e[tot].v:=z;
    e[tot].next:=head[x];
    e[tot].node:=y;
    head[x]:=tot;
end;

procedure up(x:longint);//small root.
var t:longint;
begin
    t:=x shr 1;
    if (x>1)and(dist[h[x]]<dist[h[t]]) then
    begin
        swap(po[h[x]],po[h[t]]);
        swap(h[x],h[t]);
        up(t);
    end;
end;

procedure down(x:longint);
var t:longint;
begin
    t:=x shl 1;
    if t>len then exit
    else if (t<len)and(dist[h[t]]>dist[h[t+1]]) then inc(t);
    if dist[h[t]]<dist[h[x]] then
    begin
        swap(po[h[x]],po[h[t]]);
        swap(h[x],h[t]);
        down(t);
    end;
end;

procedure delete(x:longint);
begin
    po[h[x]]:=0;
    po[h[len]]:=x;
    h[x]:=h[len];
    dec(len);
    down(x);
end;

procedure dijkstra(x:longint);
var q,u,i:longint;
    tem:Int64;
begin
    filldword(dist,n,maxlongint);
    //fillchar(flag,n,false);
    for i:=1 to n do
    begin
        h[i]:=i;
        po[i]:=i;
    end;
    len:=n;
    dist[x]:=0;
    up(x);
    while len>0 do
    begin
        u:=h[1];
        delete(1);
        //writeln('start:',u);
        q:=head[u];//取hash1的邻接表
        while q<>0 do
        begin
            tem:=dist[u]+e[q].v;
            if (po[e[q].node]<>0)and(tem<dist[e[q].node]) then
            begin
                //writeln('add ',u,' to ',e[q].node,' to ',tem);
                dist[e[q].node]:=tem;
                up(po[e[q].node]);
            end;
            q:=e[q].next;
        end;
    end;
end;
    
begin
    readln(n,m,p);
    tot:=0;
    filldword(head,n,0);
    for i:=1 to m do
    begin
        readln(f,g,w);
        add(f,g,w);
    end;
    dijkstra(p);
    for i:=1 to n do
    write(dist[i],' ');
end.