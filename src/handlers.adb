with Hello_World;
with Static_File_Handler;

package body Handlers is

   ----------------------
   --  Get_Dispatcher  --
   ----------------------

   function Get_Dispatcher
     return AWS.Services.Dispatchers.URI.Handler
   is
      Dispatcher : AWS.Services.Dispatchers.URI.Handler;
   begin
      Dispatcher.Register_Default_Callback (Action => Static_File_Handler.Callback);

      Dispatcher.Register (URI    => "/helloworld",
                           Action => Hello_World.Callback);
      Dispatcher.Register (URI    => "/",
                           Action => Static_File_Handler.Callback);
      return Dispatcher;
   end Get_Dispatcher;

end Handlers;
