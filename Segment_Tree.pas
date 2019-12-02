program Segment_Tree;
const maxn=100000;
    maxt=262145;
type
    node=record
    left:longint;
    right:longint;
    sum:longint;
    delta:longint;
    multi:longint;
    end;

var n,m,c,le,ri,k,i,j,p:longint;
    a:array[1..maxt]of node;
    b:array[1..maxn]of longint;

procedure update(cur:longint);
var left,right:longint;
begin
    left:=cur shl 1;
    right:=left+1;

    a[left].sum:=a[left].sum*a[cur].multi mod p;
    a[right].sum:=a[right].sum*a[cur].multi mod p;
    a[left].multi:=a[left].multi*a[cur].multi mod p;
    a[right].multi:=a[right].multi*a[cur].multi mod p;
    a[left].delta:=a[left].delta*a[cur].multi mod p;
    a[right].delta:=a[right].delta*a[cur].multi mod p;
    a[cur].multi:=1;

    a[left].sum:=a[left].sum+a[cur].delta*(a[left].right-a[left].left) mod p;
    a[right].sum:=a[right].sum+a[cur].delta*(a[right].right-a[right].left) mod p;
    a[left].delta:=a[left].delta+a[cur].delta mod p;
    a[right].delta:=a[right].delta+a[cur].delta mod p;
    a[cur].delta:=0;
end;

procedure plus(cur,l,r,delta:longint);
var left,right,mid:longint;
begin
    if (l<=a[cur].left)and(a[cur].right<=r) then
    begin
        a[cur].sum:=(a[cur].sum+delta*(a[cur].right-a[cur].left))mod p;
        a[cur].delta:=(a[cur].delta+delta) mod p;
    end
    else
    begin
        left:=cur shl 1;
        right:=left+1;
        mid:=(a[cur].left+a[cur].right)shr 1;
        if (a[cur].multi<>1)or(a[cur].delta<>0) then
        update(cur);
        if l<mid then
        plus(left,l,r,delta);
        if r>mid then
        plus(right,l,r,delta);
        a[cur].sum:=a[left].sum+a[right].sum;
    end;
end;

procedure multiply(cur,l,r,multi:longint);
var left,right,mid:longint;
begin
    if (l<=a[cur].left)and(a[cur].right<=r) then
    begin
        a[cur].sum:=a[cur].sum*multi mod p;
        a[cur].delta:=a[cur].delta*multi mod p;
        a[cur].multi:=a[cur].multi*multi mod p;
    end
    else
    begin
        left:=cur shl 1;
        right:=left+1;
        mid:=(a[cur].left+a[cur].right)shr 1;
        if (a[cur].multi<>1)or(a[cur].delta<>0) then
        update(cur);
        if l<mid then
        multiply(left,l,r,multi);
        if r>mid then
        multiply(right,l,r,multi);
        a[cur].sum:=a[left].sum+a[right].sum;
    end;
end;

function query(cur,l,r:longint):longint;
var left,right,mid:longint;
begin
    if (l<=a[cur].left)and(a[cur].right<=r) then
    exit(a[cur].sum)
    else
    begin
        left:=cur shl 1;
        right:=left+1;
        mid:=(a[cur].left+a[cur].right)shr 1;
        if (a[cur].multi<>1)or(a[cur].delta<>0) then
        update(cur);
        query:=0;
        if l<mid then
        query:=(query+query(left,l,r)) mod p;
        if r>mid then
        query:=(query+query(right,l,r)) mod p;
    end;
end;

procedure built(cur,l,r:longint);
var left,right:longint;
begin
    a[cur].left:=l;
    a[cur].right:=r;
    a[cur].delta:=0;
    a[cur].multi:=1;
    if l+1<r then
    begin
        left:=cur shl 1;
        right:=left+1;
        built(left,l,(l+r)shr 1);
        built(right,(l+r)shr 1,r);
        a[cur].sum:=a[left].sum+a[right].sum;
    end
    else
    a[cur].sum:=b[l];
end;

begin
    readln(n,m,p);
    for i:=1 to n do read(b[i]);
    built(1,1,n+1);
    for i:=1 to m do
    begin
        read(c);
        if c=1 then
        begin
            readln(le,ri,k);
            multiply(1,le,ri+1,k);
        end
        else if c=2 then
        begin
            readln(le,ri,k);
            plus(1,le,ri+1,k);
        end
        else if c=3 then
        begin
            readln(le,ri);
            writeln(query(1,le,ri+1)mod p);
        end;
    end;
end.