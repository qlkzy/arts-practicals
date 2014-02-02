with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex4 is
   Numbers : array (1 .. 10) of Integer;
   
   ------------------------------
   type Turn is range 1 .. 2;

   protected Turn_Controller is
      entry Take(Turn);
   private
      Last : Turn := 1;
   end Turn_Controller;
   
   protected body Turn_Controller is
      entry Take(for I in Turn) when Last /= I is
      begin
         Last := I;
      end Take;
   end Turn_Controller;

   ------------------------------
   procedure Writers is

      task type Setter(Value : Integer; Turn_Order: Turn);
      task body Setter is
      begin
         for I in Numbers'Range loop
            Turn_Controller.Take(Turn_Order);
            Numbers(I) := Value;
         end loop;
      end Setter;
      
      Ones : Setter(1, 1);
      Sevens : Setter(7, 2);

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
end Ex4;
