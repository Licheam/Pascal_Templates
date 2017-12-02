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
    h,hash:array[1..maxm]of longint;
    dist,head:array[1..maxn]of longint;
  
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
    if (x>1)and(h[x]<h[t]) then
    begin
        swap(h[x],h[t]);
        swap(hash[x],hash[t]);
        up(t);
    end;
end;

procedure down(x:longint);
var t:longint;
begin
    t:=x shl 1;
    if t>len then exit
    else if (t<len)and(h[t]>h[t+1]) then inc(t);
    if h[t]<h[x] then
    begin
        swap(h[x],h[t]);
        swap(hash[x],hash[t]);
        down(t);
    end;
end;

procedure insert(x,y:longint);
begin
    inc(len);
    h[len]:=x;
    hash[len]:=y;
    up(len);
end;

procedure delete(x:longint);
begin
    h[x]:=h[len];
    hash[x]:=hash[len];
    dec(len);
    down(x);
end;

procedure dijkstra(p:longint);
var q:longint;
    tem:Int64;
begin
    filldword(dist,n,maxlongint);
    len:=0;
    dist[p]:=0;
    insert(0,p);
    while len>0 do
    begin
        if dist[hash[1]]>=h[1] then
        begin
            q:=head[hash[1]];//取hash1的邻接表
            while q<>0 do
            begin
                tem:=h[1]+e[q].v;
                if tem<dist[e[q].node] then 
                begin
                    //writeln('add ',hash[1],' to ',e[q].node,' to ',t);
                    dist[e[q].node]:=tem;
                    insert(tem,e[q].node);
                end;
                q:=e[q].next;
            end;
        end;
        delete(1);
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
