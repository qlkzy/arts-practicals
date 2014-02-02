with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex5 is
   
   type Client_Id is range 1 .. 10;
   
   Releaser : Client_Id := 3;
   
   protected Controller is
      entry Wait(Id : Client_Id);
   end Controller;
   
   task type Client(Id : Client_Id);
   
   task body Client is
   begin
      Controller.Wait(Id);
   end Client;

begin
   null;
end Ex5;
