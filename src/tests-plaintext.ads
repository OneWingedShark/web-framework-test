-- Test type 6: Plaintext
--
--	This test is an exercise of the request-routing fundamentals only,
--	designed to demonstrate the capacity of high-performance platforms
--	in particular. The response payload is still small, meaning good
--	performance is still necessary in order to saturate the gigabit
--	Ethernet of the test environment.
function tests.plaintext(Request : Status.Data) return Data;
