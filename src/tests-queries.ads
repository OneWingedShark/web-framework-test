-- Test type 3: Multiple database queries
--
--	This test is a variation of Test #2 and also uses the World table.
--	Multiple rows are fetched to more dramatically punish the database
--	driver and connection pool. At the highest queries-per-request tested
--	(20), this test demonstrates all frameworks' convergence toward zero
--	requests-per-second as database activity increases.
function tests.queries(Request : Status.Data) return Data;
