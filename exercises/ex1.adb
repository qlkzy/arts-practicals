with Ada.Text_Io;
use Ada.Text_Io;

procedure Ex1 is
   task Say_Hello;
   task body Say_Hello is
   begin
      Put_Line("Hello, world");
   end Say_Hello;
begin
   null;
end Ex1;
