with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex6 is

   type Client_Id is range 1 .. 8;
   type Client_Flags is array (Client_Id) of Boolean;

   Releaser : Client_Id := 3;

   protected Controller is
      entry Call(Id : Client_Id);
   private
      entry Wait(Client_Id);
      Barrier_Open : Boolean := False;
      Release : Client_Flags := (others => False);
      Count : Integer := 0;
   end Controller;

   protected body Controller is
      entry Call(Id : Client_Id) when True is
      begin
         Count := Count + 1;
         if Count = Client_Flags'Length then
            Release(1) := True;
         end if;
         requeue Wait(Id);
      end Call;

      entry Wait(for Id in Client_Id) when Release(Id) is
         Next_Id : Client_Id := Id + 1;
      begin
         if Next_Id'Valid then
            Release(Next_Id) := True;
         end if;
         Put_Line("Released task " & Client_Id'Image(Id));
      end Wait;
   end Controller;

   task type Client(Id : Client_Id);

   task body Client is
   begin
      Put_Line("Task " & Client_Id'Image(Id) & " waiting at barrier");
      select
         Controller.Call(Id);
         Put_Line("Task " & Client_Id'Image(Id) & " passed barrier");
      or
         delay 5.0;
         Put_Line("Task " & Client_Id'Image(Id) & " aborted");
      end select;
   end Client;

   C4 : Client(4);
   C1 : Client(1);
   C2 : Client(2);
   C3 : Client(3);
   C6 : Client(6);
   C5 : Client(5);
   C7 : Client(7);
   C8 : Client(8);

begin
   null;
end Ex6;
