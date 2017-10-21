program link_queue;
type
	node=^queue;
	queue=record
	data:longint;
	next:node;
	end;
	
var t:longint;
	rear:^node;
	head,q:node;
	com:string;
	
procedure queini();//head node means nothing but front pointer.
var p:node;
begin
	new(p);
	p^.next:=nil;
	head:=p;
	rear:=@head;
end;

procedure push(x:longint);//push x 入队
var p:node;
begin
	new(p);
	p^.next:=nil;
	p^.data:=x;
	rear^^.next:=p;
	rear:=@rear^^.next;
end;

procedure pop();
var p:node;
begin
	p:=head^.next;
	head^.next:=p^.next;
	dispose(p);
	if rear^=nil then//对于只有两个node的linked list，pop会使得rear指向nil..此为特判。
	rear:=@head^.next;
end;

begin
	queini;
	readln(com);
	while com<>'end' do
	begin
		if copy(com,1,4)='push' then
		begin
			val(copy(com,6,length(com)-5),t);
			push(t);
		end
		else if copy(com,1,3)='pop' then pop;
		q:=head^.next;
		while q<>nil do
		begin
			writeln(q^.data);
			q:=q^.next;
		end;
		readln(com);
	end;
end.