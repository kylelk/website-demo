with AWS.Dispatchers.Callback;
with AWS.Status;
with AWS.Response;

package Not_Found is
   function Callback
     return AWS.Dispatchers.Callback.Handler;

   function Generate_Content
     (Request : in AWS.Status.Data)
      return AWS.Response.Data;
end Not_Found;
