package body tests.callbacks is

    Function Names( Separator : String ) return String is
	Function List(Index : Natural) return String is
	  (if Index not in Registered'Range then ""
           elsif Index = Registered'Last then To_String( Registered(Index) )
           else To_String(Registered(Index)) & Separator & List(Index+1)
          );
    begin
	return List(Registered'First);
    end Names;

    Function Get_Callback_Names( X : Callback_Maps.Map ) return String_List is
	Use Callback_Maps;

	Function Get_Callback_Names( C : Cursor := X.Last ) return String_List is
	begin
	    if C /= No_Element then
		return (1 => To_Unbounded_String(Key(C)) ) &
		  Get_Callback_Names( Previous(C) );
	    else
		return (2..1 => <>);
	    end if;
	end Get_Callback_Names;

    begin
	return Get_Callback_Names;
    end Get_Callback_Names;

begin
    Registered := Get_Callback_Names( Handlers );
end tests.callbacks;
