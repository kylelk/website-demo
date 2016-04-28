with AWS.Messages;
with AWS.MIME;
with AWS.Response;
with AWS.Status;

package body Hello_World is

   ----------------
   --  Callback  --
   ----------------

   function Callback
     return AWS.Dispatchers.Callback.Handler
   is
   begin
      return AWS.Dispatchers.Callback.Create (Generate_Content'Access);
   end Callback;

   ------------------------
   --  Generate_Content  --
   ------------------------

   function Generate_Content
     (Request : in AWS.Status.Data)
      return AWS.Response.Data
   is
      Browser : constant String := AWS.Status.User_Agent (Request);
   begin
      return AWS.Response.Build
        (Content_Type  => AWS.MIME.Text_HTML,
         Message_Body  =>
           "<h1>Hello World!</h1>" &
           "<p>Browser used : " & Browser & "</p>",
         Status_Code   => AWS.Messages.S200);
   end Generate_Content;

end Hello_World;
