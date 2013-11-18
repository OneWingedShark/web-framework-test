with
Mneson.Structures,
Ada.Text_IO,
Ada.Task_Termination,
Ada.Task_Identification,
Ada.Exceptions;

use
Ada.Exceptions,
Ada.Task_Termination,
Ada.Task_Identification;

package body tests.database is

    -- Login credentials.
    Server	: constant String:= "FRAMEWORK_TEST";
    User	: constant String:= "SYSDBA";
    Password	: constant String:= "masterkey";

    -- Subtype Renames
    subtype EO  is Exception_Occurrence;
    subtype COT is Cause_Of_Termination;


    protected Grim_Reaper is
	procedure Finalize(C: COT; T: Task_Id; X: EO);
    end Grim_Reaper;

    protected body Grim_Reaper is
	procedure Finalize(C: COT; T: Task_Id; X: EO) is
	    Use Ada.Text_IO;
	begin
	    -- We merely call the finalization procedure.
	    Ada.Text_IO.Put_Line( "--DB-Logout Stub--" );
	end Finalize;
    end Grim_Reaper;


    -- The implementation for the database-task.
    Task body DB_Interface is
    begin
	loop
	    select
		accept Get_Record(ID : Positive; Rec : out World) do
		    Ada.Text_IO.Put_Line("Record"&
			     Integer'Image(ID)&" requested.");
		    pragma Unreferenced(Rec);
		    null;
		end Get_Record;
	    or
		accept Get_Record (ID : Positive; Rec : out Fortune) do
		    pragma Unreferenced(Rec);
		    null;
		end Get_Record;
	    or
		terminate;
	    end select;
	end loop;
    end;

begin
    -- To ensure the DB is logged out properly, we assign the
    -- finalize function of Grim_Reaper to be the termination-handler.
    Set_Specific_Handler(
		T       =>  DB_Interface'Identity,
		Handler =>  Grim_Reaper.Finalize'Access
	);
end tests.database;
