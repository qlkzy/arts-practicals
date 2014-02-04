with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Real_Time;
use Ada.Real_Time;

procedure Ex7 is
   
   task Periodic;
   task Background;
   
   task body Periodic is
   begin
      for I in 1 .. 10 loop
         delay until Clock + Milliseconds(100);
         Put_Line("Periodic task execution " & Integer'Image(I));
      end loop;
   end Periodic;

   task body Background is
   begin
      null;
   end Background;

begin
   null;
end Ex7;
