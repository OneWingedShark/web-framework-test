with
Ada.Numerics.Discrete_Random,
tests.database;

use
Ada.Numerics,
tests.database;

function tests.db(Request : Status.Data) return Data is

    subtype ID_Range is Positive range 1..10_000;
    Package Randoms is New Discrete_Random( ID_Range );

    RNG : Randoms.Generator;

    use Randoms;
begin
    Randoms.Reset( RNG );
    return Result : Data do
	declare
	    temp : World;
	begin
	    DB_Interface.Get_Record( Random(RNG), temp );
	end;

	raise program_error with "Not Implemented";
    end return;
end tests.db;
