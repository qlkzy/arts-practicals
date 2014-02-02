with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex2 is
   task Numbers;
   task Letters;
   
   task body Numbers is
   begin
      for I in 1 .. 100 loop
         Put_Line(Integer'Image(I));
      end loop;
   end Numbers;
   
   task body Letters is
   begin
      for C in Character'('a') .. Character'('z') loop
         Put_Line(Character'Image(C));
      end loop;
      for C in Character'('A') .. Character'('Z') loop
         Put_Line(Character'Image(C));
      end loop;
   end Letters;
   
begin
   null;
end Ex2;
