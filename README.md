Benchmark for AWS (Ada Web Server)
==================================

This is an entry for the benchmark suit of the tests run by 
[TechEmpower][1], using the AWS framework.

Structure
---------

The structure is simple: the URL is taken and parsed and the page portion is used to look up and execute a callback that has been associated with that string. If there is no such association, then the error-page displays the submitted URL's page and the registered pages.

Generally, the tests are of the form `tests.PAGE_NAME` –both `ads` and `adb` files– with three exceptions:  
**`tests.get_callbacks`** — The function returning the associated callbacks.  
**`tests.callbacks`**  — The package containing the callbacks and listing functions (`get_callbacks` is used to initialize the constant used by the system).  
**`tests.database`** — The package for interfacing into the database; interface is intended to be accomplished via `task DB_Interface`.

Requirements
------------

* An [Ada compiler][2].
* [AWS][3].


Tests
-----
☑ `1:` JSON serialization  
☐ `2:` Single database query  
☐ `3:` Multiple database queries  
☐ `4:` Fortunes  
☐ `5:` Database updates  
☑ `6:` Plaintext  


Notes
-----

I could not get any database interfacing working acceptably on my home machine, I was going to use InterBase/ODBC but the ODBC manager itself seemed unable to associate with the `FRAMEWORK_TEST.IB` file except under odd circumstances.



  [1]:http://www.techempower.com/benchmarks
  [2]:http://libre.adacore.com/download/
  [3]:http://libre.adacore.com/tools/aws/
