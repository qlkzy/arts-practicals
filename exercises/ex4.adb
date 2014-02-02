with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex4 is
   type Turn is range 0 .. 1;
   type Index is range 1 .. 10;
   
   Numbers : array (Index) of Integer;
   
   ------------------------------
   protected Turn_Controller is
      entry Take(Turn)(I : Index ; Value : Integer);
   private
      Last : Turn := 1;
      Toggle : Turn := 0;
   end Turn_Controller;
   
   protected body Turn_Controller is
      entry Take(for T in Turn)(I : Index; Value : Integer) when T /= Last is
      begin
         Numbers(I) := Value;
         if Toggle = 0 then
            Toggle := 1;
            Last := T;
         else
            Toggle := 0;
         end if;
      end Take;
   end Turn_Controller;

   ------------------------------
   procedure Writers is

      task type Setter(Value : Integer; Turn_Order: Turn);
      task body Setter is
      begin
         for I in Numbers'Range loop
            Turn_Controller.Take(Turn_Order)(I, Value);
         end loop;
      end Setter;
      
      Ones : Setter(1, 0);
      Sevens : Setter(7, 1);

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
