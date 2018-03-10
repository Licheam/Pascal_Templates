program Radix_Sort;
const maxn=100000;
var n,i,dgt,p,tot:longint;
    fsh:boolean;
    fa,a,b,idx:array[1..maxn]of longint;
    head:array[0..9]of longint;

begin
    readln(n);
    for i:=1 to n do
    begin
        read(a[i]);
        b[i]:=a[i];
        idx[i]:=i;
    end;
    repeat
        fsh:=true;
        filldword(head,10,0);
        for i:=1 to n do
        begin
            dgt:=b[idx[i]] mod 10;
            b[idx[i]]:=b[idx[i]] div 10;
            if b[idx[i]]>0 then
                fsh:=false;
            fa[idx[i]]:=head[dgt];
            head[dgt]:=idx[i];
        end;
        tot:=n;
        for i:=9 downto 0 do
        begin
            p:=head[i];
            while p<>0 do
            begin
                idx[tot]:=p;
                dec(tot);
                p:=fa[p];
            end;
        end;
    {for i:=1 to n do
        write(b[idx[i]],' ');
    writeln;}
    until fsh;
    for i:=1 to n do
        write(a[idx[i]],' ');
end.