with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex3 is
   Numbers : array (1 .. 10) of Integer;
   
   procedure Writers is
      
      task type Setter(Value : Integer);
      
      task body Setter is
      begin
         for I in Numbers'Range loop
            if Numbers(I) = 0 then
               Numbers(I) := Value;
               delay 0.1;
            else
               Numbers(I) := Value;
            end if;
         end loop;
      end Setter;
      
      Ones : Setter(1);
      Sevens : Setter(7);
   begin
      null;
   end Writers;
begin
   for I in Numbers'Range loop
      Numbers(I) := 0;
   end loop;
   
   Writers;
   
   for I in Numbers'Range loop
      Put_Line(Integer'Image(Numbers(I)));
   end loop;
end Ex3;
