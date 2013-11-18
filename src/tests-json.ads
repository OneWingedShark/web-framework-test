-- Test type 1: JSON serialization
--
--	This test exercises the framework fundamentals including keep-alive
--	support, request routing, request header parsing, object instantiation,
--	JSON serialization, response header generation, and request count
--	throughput.
function tests.JSON(Request : Status.Data) return Data;
