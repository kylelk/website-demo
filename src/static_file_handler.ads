with AWS.Dispatchers.Callback;
with AWS.Status;
with AWS.Response;
with Ada.Directories;

package Static_File_Handler is
   function Get_Index_File(Request : AWS.Status.Data)
                           return AWS.Response.Data;
   function Generate_Content
     (Request : in AWS.Status.Data)
      return AWS.Response.Data;

   function Callback
     return AWS.Dispatchers.Callback.Handler;

private
   package DIRS renames Ada.Directories;

end Static_File_Handler;
