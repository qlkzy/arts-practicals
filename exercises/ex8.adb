pragma Task_Dispatching_Policy(FIFO_Within_Priorities);

with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time.Timing_Events;
with System;
use System;


procedure Ex8 is

   Start_Time : Time := Clock + Seconds(1);
 
   protected Timer is
      pragma Interrupt_Priority (Interrupt_Priority'Last);
      entry Wait;
      procedure Start;
   private
      Event : aliased Timing_Event;
      Allow : Boolean := False;
      Interval : Time_Span := Milliseconds(100);
   end Timer;
   
   protected body Timer is

      entry Wait when Allow is
      begin
         Allow := False;
      end Wait;
      
      procedure Call(Event : in out Timing_Event) is
      begin
         Allow := True;
         Event.Set_Handler(Interval, Call'Unrestricted_Access);
      end Call;
      
      procedure Start is
      begin
         Event.Set_Handler(Interval, Call'Unrestricted_Access);
      end Start;
   end Timer;
   
   task Periodic is
      pragma Priority(System.Priority'First + 5);
   end Periodic;

   task Background is
      pragma Priority(System.Priority'First);
   end;   
   
   task body Periodic is
      Count : Integer := 0;
      
   begin
      delay until Start_Time;
      Timer.Start;
      loop
         Timer.Wait;
         Count := Count + 1;
         Put_Line("Periodic task execution " & Integer'Image(Count));
         exit when Count >= 100;
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
end Ex8;
