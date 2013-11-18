package tests.database with Elaborate_Body is

    -- This Package is to centralize the database interface.
    --
    -- Its elaboration should cause the proper log-in to be executed, via
    -- the interface/access task. Furthermore, terminating the task will
    -- handle the logout.


    -- DB record types; for interfacing with the DB.
    Type World is null record;
    Type Fortune is null record;

    Task DB_Interface is
	entry Get_Record(ID : Positive; Rec : out World);
	entry Get_Record(ID : Positive; Rec : out Fortune);
    end;

    -- NOTE:	See tests.fortunes.adb for ecample of how to
    --		pass data to the template-parser.

end tests.database;
