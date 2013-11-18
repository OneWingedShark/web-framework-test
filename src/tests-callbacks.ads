with
Ada.Strings.Unbounded,
tests.get_callbacks;

use
Ada.Strings.Unbounded;

package tests.callbacks is

    Type String_List is array(positive range <>) of Unbounded_String;

    Handlers   : constant Callback_Maps.Map:= tests.get_callbacks;

    -- Returns the names of the handlers.
    Function Names return String_List;
    Function Names( Separator : String ) return String;

private
    Registered : String_List:= ( 1..Integer(Handlers.Length) => <> );
    Function Names return String_List is ( Registered );
end tests.callbacks;
