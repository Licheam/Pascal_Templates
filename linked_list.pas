type
	node=^link;
	link=record
	data:longint;
	prev:node;
	next:node;
	end;
	
var n,m,i,t,l:longint;
	head:node;

procedure ini();
var p,q:node;
begin
	new(p);
	p^.next:=p;
	p^.prev:=p;
	head:=p;
	new(q);
	q^.data:=1;
	q^.next:=head;
	q^.prev:=head;
	head^.next:=q;
	head^.prev:=q;
end;

function search(x:longint):node;
var p:node;
begin
	p:=head;
	while p^.next<>head do
	begin
		p:=p^.next;
		if p^.data=x then exit(p);
	end;
	exit(head);
end;

procedure insert(x,y:longint;left:boolean);//insert x to y's left/right
var p,q:node;
begin
	p:=search(y);
	if p=head then exit;
	new(q);
	q^.data:=x;
	if left then
	begin
		p^.prev^.next:=q;
		q^.prev:=p^.prev;
		p^.prev:=q;
		q^.next:=p;
	end
	else
	begin
		p^.next^.prev:=q;
		q^.next:=p^.next;
		p^.next:=q;
		q^.prev:=p;
	end;
end;

procedure delete(x:longint);
var p:node;
begin
	p:=search(x);
	if p=head then exit;
	p^.prev^.next:=p^.next;
	p^.next^.prev:=p^.prev;
	dispose(p);
end;

procedure print();
var p:node;
begin
	p:=head;
	while p^.next<>head do
	begin
		p:=p^.next;
		write(p^.data,' ');
	end;
	writeln;
end;

begin
	readln(n);
	ini;
	for i:=2 to n do
	begin
		readln(t,l);
		insert(i,t,l=0);
	end;
	readln(m);
	for i:=1 to m do
	begin
		readln(t);
		delete(t);
	end;
	print;
end.