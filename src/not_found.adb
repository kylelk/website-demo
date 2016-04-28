with AWS.Messages;
with AWS.MIME;

package body Not_Found is
   function Callback
     return AWS.Dispatchers.Callback.Handler
   is
   begin
      return AWS.Dispatchers.Callback.Create (Generate_Content'Access);
   end Callback;

   function Generate_Content
     (Request : in AWS.Status.Data)
      return AWS.Response.Data
   is
      Resource : constant String := AWS.Status.URI (Request);
   begin
      return AWS.Response.Build
        (Content_Type  => AWS.MIME.Text_HTML,
         Message_Body  =>
           "<h1>Not found</h1>" &
           "<p>Resource '" & Resource & "' not found</p> <br/>",
         Status_Code   => AWS.Messages.S404);
   end Generate_Content;

end Not_Found;
