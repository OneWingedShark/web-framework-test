function tests.plaintext(Request : Status.Data) return Data is
begin
    return Result : Data do
	Result:= Response.Build(
			 Content_Type  => Text_Plain,
			 Message_Body  => "Hello, World!"
			);
    end return;
end tests.plaintext;
