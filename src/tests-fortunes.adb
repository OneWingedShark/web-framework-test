with
Templates_Parser;

function tests.fortunes(Request : Status.Data) return Data is
    use Templates_Parser;

    Record_Set	: Matrix_Tag;
    Data_Set	: Translate_Set;
begin
    return Result : Data do

--  	SIMULATE_DATA:
--  	For Index in 1..10 loop
--  	    declare
--  		Field_1 : Tag renames Tag'(+Index);
--  		Field_2	: Tag:= +Boolean'Image(Index mod 2 = 0);
--  		Rec_1	: Tag:=  Field_1 & Field_2;
--  	    begin
--  		Append(Record_Set,	Rec_1);
--  	    end;
--  	end loop SIMULATE_DATA;
--
--  	-- Insert Record_Set into the data we will pass to the template-parser
--  	-- under the name "RECORDS".
--  	Insert(Data_Set, Assoc("RECORDS", Record_Set));
--
--  	Result:= Response.Build(
--  		Content_Type  => Text_HTML,
--  		Message_Body  => Parse(
--  			Filename          => "templates/Fortunes.thtml",
--  			Translations      => Data_Set,
--  			Cached            => False
--  			)
--  		);
	raise program_error with "Not Implemented";
    end return;
end tests.fortunes;
