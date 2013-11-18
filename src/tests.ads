With
AWS.MIME,
AWS.Status,
AWS.Response,
Ada.Strings.Less_Case_Insensitive,
Ada.Strings.Equal_Case_Insensitive,
Ada.Containers.Indefinite_Ordered_Maps;

Use
AWS,
AWS.MIME,
AWS.Response,
Ada.Containers;


Package tests is

    -- Delete the parameter for "<" to make the URL-detection case-sensitive.
    package Callback_Maps is new Indefinite_Ordered_Maps(
	Key_Type	=> String,
	Element_Type	=> Callback,
	"<"		=> Ada.Strings.Less_Case_Insensitive
	);

    -- Additional MIME types.
    Application_JSON : constant String:= "application/json";

    -- Helper functions.
    function Enclose( Text, Start, Stop : String ) return String
    with Pure_Function, Inline;
    function Enclose( Text : String; Start, Stop : Character ) return String
    with Pure_Function, Inline;

    function Quote(S : String) return String
    with Pure_Function, Inline;
    function HTML_Tag(Name, Inner_HTML : String; Self_Closing : Boolean:= False)
		  return String
    with Pure_Function, Inline;

private
    function Enclose( Text, Start, Stop : String ) return String is
      ( Start & Text & Stop );
    function Enclose( Text : String; Start, Stop : Character ) return String is
      ( Start & Text & Stop );


    function Quote(S : String) return String is       ( Enclose(S, '"',  '"') );
    function Start_Tag( S : String ) return String is ( Enclose(S, '<',  '>') );
    function Stop_Tag ( S : String ) return String is ( Enclose(S, "</", ">") );


    function HTML_Tag(Name, Inner_HTML : String; Self_Closing : Boolean:= False)
		 return String is
      (if Self_Closing then Enclose(Name&' '&Inner_HTML, "<", " />")
       else Start_Tag(Name) & Inner_HTML & Stop_Tag(Name)
      );

end tests;
