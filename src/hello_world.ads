with AWS.Dispatchers.Callback;
with AWS.Status;
with AWS.Response;

package Hello_World is
   function Callback
     return AWS.Dispatchers.Callback.Handler;

   function Generate_Content
     (Request : in AWS.Status.Data)
      return AWS.Response.Data;
end Hello_World;
