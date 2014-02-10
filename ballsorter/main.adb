with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Calendar;
use Ada.Calendar;

with Chute;
use Chute;

procedure Main is
   Ball : Ball_Sensed;
   T : Time;
begin
   Put_Line("Starting...");
   loop
      loop
         Put_Line("Sorting ball");
         Hopper_Load;
         delay 0.5;
         Hopper_Unload;
         select
            delay 5.0;
         then abort
            Get_Next_Sensed_Ball(Ball, T);
            if Ball = Metal then
               Sorter_Metal;
               Get_Next_Sensed_Ball(Ball, T);
            else
               Sorter_Glass;
            end if;
            delay 2.0;
         end select;
      end loop;
   end loop;
end Main;
