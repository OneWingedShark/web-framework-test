with
tests.JSON,	-- Test 1: JSON serialization
tests.db,	-- Test 2: Single database query
tests.queries,	-- Test 3: Multiple database queries
tests.fortunes,	-- Test 4: Fortunes
tests.updates,	-- Test 5: Database updates
tests.plaintext	-- Test 6: Plaintext
;

function tests.get_callbacks return Callback_Maps.Map is
begin
    return Result : Callback_Maps.Map do
	Result.Include( "json",		JSON'Access	);
	Result.Include( "db",		db'Access	);
	Result.Include( "queries",	queries'Access	);
	Result.Include( "fortunes",	fortunes'Access	);
	Result.Include( "updates",	updates'Access	);
	Result.Include( "plaintext",	plaintext'access);
    end return;
end tests.get_callbacks;
