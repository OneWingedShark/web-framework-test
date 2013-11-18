Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
tests.database,
tests.master_callback,
AWS.Config,
AWS.Server,
Ada.Text_IO;

Procedure aws_test is
   use AWS, tests;

   Web_Server : Server.HTTP;
   Web_Config : Config.Object;
Begin
    aws.Server.Start(
		     Web_Server => Web_Server,
		     Callback   => master_callback'access,
		     Config     => Web_Config
		    );

    --  Wait for the Q key
    Server.Wait (Server.Q_Key_Pressed);

    --  Stop the server
    Server.Shutdown (Web_Server);
End aws_test;
