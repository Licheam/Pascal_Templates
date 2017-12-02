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