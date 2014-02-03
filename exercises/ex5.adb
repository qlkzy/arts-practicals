with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex5 is
   
   type Client_Id is range 1 .. 8;
   
   Releaser : Client_Id := 3;
   
   protected Controller is
      entry Call(Id : Client_Id);
   private
      entry Wait;
      Barrier_Open : Boolean := False;
   end Controller;
   
   protected body Controller is
      entry Call(Id : Client_Id) when True is
      begin
         if Id = Releaser then
            Barrier_Open := True;
         else
            requeue Wait with abort;
         end if;
      end Call;
      
      entry Wait when Barrier_Open is
      begin
         if Wait'Count = 0 then
            Barrier_Open := False;
         end if;
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
   
   C1 : Client(1);
   C2 : Client(2);
   C3 : Client(3);
   C4 : Client(4);
   C5 : Client(5);
   C6 : Client(6);
   C7 : Client(7);
   C8 : Client(8);
   
begin
   null;
end Ex5;
