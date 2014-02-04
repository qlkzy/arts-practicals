
with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex10 is
   
   procedure Infinite_Work is
      F : Duration := 0.0;
   begin
      Put_Line("Working");
      loop
         for J in 1 .. 10000000 loop
            F := F + Duration(J * 10.0);
         end loop;
         Put_Line("Still Working");
      end loop;
   end Infinite_Work;
   
   task Worker;
   
   task body Worker is
   begin
      select
         delay 1.0;
      then abort
         Infinite_Work;
      end select;
   end Worker;
   
begin
   null;
end Ex10;
