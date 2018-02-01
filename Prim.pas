program prim;
const maxn=5000;
    maxm=200000;
type edge=record
    w:longint;
    node:longint;
    next:longint;
    end;
var n,m,i,tot,f,g,w,len,ans:longint;
    head:array[1..maxn]of longint;
    h,a:array[1..2*maxm]of longint;
    e:array[1..2*maxm]of edge;
    flag:array[1..maxn]of boolean;

procedure add(x,y,z:longint);
begin
    inc(tot);
    e[tot].w:=z;
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

procedure up(x:longint);
var t:longint;
begin
    t:=x shr 1;
    if (x>1)and(h[x]<h[t]) then
    begin
        swap(h[x],h[t]);
        swap(a[x],a[t]);
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
        swap(a[x],a[t]);
        down(t);
    end;
end;

procedure insert(x,w:longint);
begin
    inc(len);
    h[len]:=w;
    a[len]:=x;
    up(len);
end;

procedure delete(x:longint);
begin
    h[x]:=h[len];
    a[x]:=a[len];
    dec(len);
    down(x);
end;

procedure prim();
var i,p,v:longint;
begin
    fillchar(flag,n,false);
    len:=0;
    flag[1]:=true;
    p:=head[1];
    while p<>0 do
    begin
        insert(e[p].node,e[p].w);
        p:=e[p].next;
    end;
    for i:=1 to n-1 do
    begin
        while flag[a[1]] do
        begin
            delete(1);
            if len=0 then
            begin
                writeln('orz');
                halt;
            end;
        end;
        inc(ans,h[1]);
        v:=a[1];
        delete(1);
        flag[v]:=true;
        p:=head[v];
        while p<>0 do
        begin
            if not(flag[e[p].node]) then
                insert(e[p].node,e[p].w);
            p:=e[p].next;
        end;
    end;
end;

begin
    readln(n,m);
    filldword(head,n,0);
    tot:=0;
    for i:=1 to m do
    begin
        readln(f,g,w);
        add(f,g,w);
        add(g,f,w);
    end;
    ans:=0;
    prim;
    writeln(ans);
end.