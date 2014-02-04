with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Execution_Time;
use Ada.Execution_Time;

procedure Ex12 is
   
   procedure Finite_Work(Cycles : Integer) is
      F : Duration := 0.0;
      I : Integer := 0;
   begin
      Put_Line("Working");
      loop
         I := I + 1;
         for J in 1 .. 10000000 loop
            F := F + Duration(J * 10.0);
         end loop;
         Put_Line("Still Working");
         exit when I = Cycles;
      end loop;
   end Finite_Work;
   
   task Worker;
   
   task body Worker is
      Start : CPU_Time;
   begin
      Start := Ada.Execution_Time.Clock;
      select
         delay 0.2;
      then abort
         Finite_Work(10);
      end select;
      Put_Line(Duration'Image(To_Duration(Ada.Execution_Time.Clock - Start))
                 & " seconds");
   end;
   
begin
   null;
end Ex12;
