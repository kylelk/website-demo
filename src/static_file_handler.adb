with AWS.MIME;
with AWS.Services.Page_Server;
with GNAT.Directory_Operations;
with Not_Found;

package body Static_File_Handler is
   function Callback
     return AWS.Dispatchers.Callback.Handler
   is
   begin
      return AWS.Dispatchers.Callback.Create (Generate_Content'Access);
   end Callback;

   function Get_Index_File(Request : AWS.Status.Data)
                           return AWS.Response.Data is
      Request_Path : constant String := AWS.Status.URI(Request);
      File_Path : constant String :=
        GNAT.Directory_Operations.Format_Pathname("public/" & Request_Path & "/index.html");
   begin
      if DIRS.Exists(File_Path) and
        DIRS.Kind(File_Path) in DIRS.Ordinary_File | DIRS.Special_File then
         return AWS.Response.File("text/html", File_Path);
      else
         return AWS.Services.Page_Server.Callback(Request);
      end if;
   end Get_Index_File;

   function Generate_Content
     (Request : in AWS.Status.Data)
      return AWS.Response.Data
   is
      Request_Path : constant String := AWS.Status.URI(Request);
      File_Path : constant String :=
        GNAT.Directory_Operations.Format_Pathname("public/" & Request_Path);
      Content_Type : constant String := AWS.MIME.Content_Type(Request_Path);
   begin
      if DIRS.Exists(File_Path) then
         case DIRS.Kind(File_Path) is
         when DIRS.Ordinary_File =>
            return AWS.Response.File(Content_Type, File_Path);
         when DIRS.Directory =>
            return Get_Index_File(Request);
         when DIRS.Special_File =>
            return AWS.Response.File(Content_Type, File_Path);
         end case;
      else
         return Not_Found.Generate_Content(Request);
      end if;
   end Generate_Content;
end Static_File_Handler;
