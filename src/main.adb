with Ada.Text_IO;
with AWS.Config;
with AWS.Default;
with AWS.Server;

with Handlers;

procedure Main is
   Web_Server : AWS.Server.HTTP;
begin
   Ada.Text_IO.Put_Line
  ("I'm available at localhost port"
      & Positive'Image (AWS.Default.Server_Port)
      & ". Press q to kill me.");

   Ada.Text_IO.Put_Line ("http://localhost:8080/helloworld");

   AWS.Server.Start (Web_Server => Web_Server,
                     Dispatcher => Handlers.Get_Dispatcher,
                     Config     => AWS.Config.Get_Current);

   AWS.Server.Wait (AWS.Server.Q_Key_Pressed);

   AWS.Server.Shutdown (Web_Server);
end Main;
