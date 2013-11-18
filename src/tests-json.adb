function tests.JSON(Request : Status.Data) return Data is
begin
    return Result : Data do
	Result:= Response.Build(
			 Content_Type  => Application_JSON,
			 Message_Body  =>
			   Enclose( quote("message") &':'& quote("Hello, World!") , '{','}')
			);
    end return;
end tests.JSON;
