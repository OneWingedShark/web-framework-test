with
tests.callbacks,
AWS.URL;

use
tests.Callback_Maps,
tests.callbacks;

function tests.master_callback(Request : Status.Data) return Data is
    use tests.callbacks;
    URL    : constant AWS.URL.Object:= AWS.Status.URI(Request);
    Path   : constant String:= AWS.URL.Path(URL);
    File   : constant String:= AWS.URL.File(URL);

    Handle : Cursor:= Handlers.Find( File );
    BR     : constant string:= "<br />";
begin
    return Result : Data do
	if Handle = No_Element then
	    declare
		function List return string is ( Names(BR) );
	    begin
		Result:= Response.Build
		  (MIME.Text_HTML, "<h1>Invalid URI</h1>"& BR &
			"<tt>"& AWS.Status.URL(Request) &"</tt>" & BR &
			"Path: " & Path & BR &
			"File: " & File & BR &
			"<hr />" & "Acceptable URLs:" & HTML_Tag( "PRE", List )
		  );
	    end;
	else
	    Result := Element(Handle)(Request);
	end if;
    end return;
end tests.master_callback;
