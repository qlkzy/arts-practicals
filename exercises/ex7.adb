pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Real_Time;
use Ada.Real_Time;
with System;
use System;


procedure Ex7 is

   Start_Time : Time := Clock + Seconds(1);

   task Periodic is
      pragma Priority(System.Priority'First + 5);
   end Periodic;

   task Background is
      pragma Priority(System.Priority'First);
   end;

   task body Periodic is
   begin
      delay until Start_Time;
      for I in 1 .. 10 loop
         delay until Clock + Milliseconds(100);
         Put_Line("Periodic task execution " & Integer'Image(I));
      end loop;
   end Periodic;

   task body Background is
      F : Duration := 0.0;
   begin
      delay until Start_Time;
      Put_Line("Starting background computation");
      for I in 1 .. 60 loop
         Put_Line("Executing background computation");
         for J in 1 .. 10000000 loop
            F := F + Duration(J * 10.0);
         end loop;
      end loop;
   end Background;

begin
   null;
end Ex7;
