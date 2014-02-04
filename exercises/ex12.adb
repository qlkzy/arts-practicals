with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Execution_Time;
use Ada.Execution_Time;
with Ada.Execution_Time.Timers;
use Ada.Execution_Time.Timers;

procedure Ex12 is   
   type Timer is new Integer;
   
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
   
   protected Timeout is
      entry Wait;
      procedure Start;
   private
      procedure Handler(T : in out Timer);
      Event : aliased Timer;
      Allow : Boolean := False;
   end Timeout;
   
   protected body Timeout is
      entry Wait when Allow is
      begin
         Allow := False;
      end Wait;
      
      procedure Start is
      begin
         Timer.Set_Handler(Milliseconds(200), Handler'Unrestricted_Access);
      end Start;
      
      procedure Handler(T : in out Timer) is
      begin
         Allow := True;
      end Handler;
   end Timeout;
   
   task Worker;
   
   task body Worker is
      Start : CPU_Time;
   begin
      Start := Ada.Execution_Time.Clock;
      Timeout.Start;
      select
         Timeout.Wait;
      then abort
         Finite_Work(10);
      end select;
      Put_Line(Duration'Image(To_Duration(Ada.Execution_Time.Clock - Start))
                 & " seconds");
   end;
   
begin
   null;
end Ex12;
