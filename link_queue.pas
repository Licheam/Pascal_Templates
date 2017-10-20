program link_queue;
type
	node=^queue;
	queue=record
	data:longint;
	next:node;
	end;
	
var n,i,t:longint;
	rear:^node;
	head,q:node;
	
procedure push(x:longint);//push x 入队
var p:node;
begin
	new(p);
	p^.next:=nil;
	p^.data:=x;
	if head=nil then head:=p
	else 
	begin
		rear^^.next:=p;
		rear:=@rear^^.next;
	end;
end;

procedure pop();
var p:node;
begin
	if head<>nil then
	begin
		p:=head;
		head:=head^.next;
		dispose(p);
	end;
end;

begin
	readln(n);
	head:=nil;
	rear:=@head;
	for i:=1 to n do
	begin
		readln(t);
		if t=1 then push(i)
		else if t=2 then pop
		else 
		begin
			q:=head;
			while q<>nil do
			begin
				writeln(q^.data);
				q:=q^.next;
			end;
		end;
	end;
end.