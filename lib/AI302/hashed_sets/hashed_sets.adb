with System;  use type System.Address;

package body Hashed_Sets is

   use type AI302.Containers.Size_Type;

   function Hash_Node
     (Node : Node_Access) return AI302.Containers.Hash_Type is
   begin
      return Hash (Node.Element);
   end;


   function Next
     (Node : Node_Access) return Node_Access is
   begin
      return Node.Next;
   end;


   procedure Set_Next
     (Node : Node_Access;
      Next : Node_Access) is
   begin
      Node.Next := Next;
   end;


   function Is_Equal_Key_Element_Node
     (Element : Element_Type;
      Node    : Node_Access) return Boolean is
   begin
      return Is_Equal_Key (Element, Node.Element);
   end;


   function New_Node
     (Node : Node_Access) return Node_Access is

      Result : constant Node_Access :=
        new Node_Type'(Element => Node.Element,
                       Next    => null);
   begin
      return Result;
   end;


   procedure Adjust (Set : in out Set_Type) is
   begin
      Adjust (Set.HT);
   end;


   procedure Finalize (Set : in out Set_Type) is
   begin
      Finalize (Set.HT);
   end;


   procedure Write
     (Stream : access Ada.Streams.Root_Stream_Type'Class;
      Node   : in     Node_Access) is
   begin
      Element_Type'Write (Stream, Node.Element);
   end;

   procedure Write is
      new Hash_Table_Types.Generic_Write (Write);

   procedure Write
     (Stream : access Ada.Streams.Root_Stream_Type'Class;
      Set    : in     Set_Type) is
   begin
      Write (Stream, Set.HT);
   end;


   function New_Node (Stream : access Ada.Streams.Root_Stream_Type'Class)
     return Node_Access is

      Node : Node_Access := new Node_Type;
   begin
      Element_Type'Read (Stream, Node.Element);
      return Node;
   exception
      when others =>
         Free (Node);
         raise;

   end New_Node;

   procedure Read is
      new Hash_Table_Types.Generic_Read (New_Node);

   procedure Read
     (Stream : access Ada.Streams.Root_Stream_Type'Class;
      Set    :    out Set_Type) is
   begin
      Read (Stream, Set.HT);
   end;


   function Is_Equal_Element_Node_Node
     (L, R : Node_Access) return Boolean is

      pragma Inline (Is_Equal_Element_Node_Node);
   begin
      return L.Element = R.Element;
   end;

   function Is_Equal is
      new Hash_Table_Types.Generic_Equal (Is_Equal_Element_Node_Node);

   function "=" (Left, Right : Set_Type) return Boolean is
   begin

      if Left'Address = Right'Address then
         return True;
      end if;

      return Is_Equal (Left.HT, Right.HT);

   end "=";



   function Length (Set : Set_Type) return AI302.Containers.Size_Type is
   begin
      return Set.HT.Length;
   end;


   function Is_Empty (Set : Set_Type) return Boolean is
   begin
      return Length (Set) = 0;
   end;


   procedure Clear (Set : in out Set_Type) is
   begin
      Clear (Set.HT);
   end;


   procedure Swap (Left, Right : in out Set_Type) is
   begin
      Swap (Left.HT, Right.HT);
   end;



   procedure Insert (Set      : in out Set_Type;
                     New_Item : in     Element_Type;
                     Cursor   :    out Cursor_Type;
                     Success  :    out Boolean) is

      function New_Node
        (Next : Node_Access) return Node_Access is

         Node : constant Node_Access :=
            new Node_Type'(New_Item, Next);
      begin
         return Node;
      end;

      procedure Insert is
        new Hash_Table_Types.Generic_Conditional_Insert (New_Node);

      HT : Hash_Table_Type renames Set.HT;

   begin -- Insert

      Resize (HT, HT.Length + 1);

      Insert (HT, New_Item, Cursor.Node, Success);

   end Insert;



   procedure Delete (Set  : in out Set_Type;
                     Item : in     Element_Type) is

      HT : Hash_Table_Type renames Set.HT;

   begin

      if HT.Length = 0 then
         return;
      end if;

      Delete (HT, Item);

   end Delete;


   procedure Delete (Set    : in out Set_Type;
                     Cursor : in out Cursor_Type) is
   begin

      if Cursor = Null_Cursor then
         return;
      end if;

      Delete (Set.HT, Cursor.Node);

   end Delete;



   function Find (Set  : Set_Type;
                  Item : Element_Type) return Cursor_Type is

      HT : Hash_Table_Type renames Set.HT;

   begin

      if HT.Length = 0 then
         return Null_Cursor;
      end if;

      return (Node => Find (HT, Item));

   end Find;


   function Is_In (Item : Element_Type;
                   Set  : Set_Type) return Boolean is
   begin
      return Find (Set, Item) /= Null_Cursor;
   end;



   function First (Set : Set_Type) return Cursor_Type is
   begin
      return (Node => First (Set.HT));
   end;


   function Back (Set : Set_Type) return Cursor_Type is
      pragma Warnings (Off, Set);
   begin
      return Null_Cursor;
   end;


   function Succ
     (Set    : Set_Type;
      Cursor : Cursor_Type) return Cursor_Type is
   begin
      return (Node => Succ (Set.HT, Cursor.Node));
   end;


   procedure Increment
     (Set    : in     Set_Type;
      Cursor : in out Cursor_Type) is
   begin
      Cursor := Succ (Set, Cursor);
   end;



   function Element (Cursor : Cursor_Type) return Element_Type is
   begin
      return Cursor.Node.Element;
   end;


   function Generic_Element
     (Cursor : Cursor_Type) return Element_Access is
   begin
      return Cursor.Node.Element'Access;
   end;


   procedure Generic_Iteration (Set : in Set_Type) is

      procedure Process (Node : in Node_Access) is
         pragma Inline (Process);
      begin
         Process (Cursor => Cursor_Type'(Node => Node));
      end;

      procedure Iterate is
         new Hash_Table_Types.Generic_Iteration (Process);

   begin -- Generic_Iteration

      Iterate (Set.HT);

   end Generic_Iteration;


   function Size (Set : Set_Type) return AI302.Containers.Size_Type is
   begin
      if Set.HT.Buckets = null then
         return 0;
      end if;

      return Set.HT.Buckets'Length;
   end;


   procedure Resize (Set  : in out Set_Type;
                     Size : in     AI302.Containers.Size_Type) is
   begin
      Resize (Set.HT, Size);
   end;



   function Is_Equal_Key (Left, Right : Cursor_Type)
      return Boolean is
   begin
      return Is_Equal_Key (Left.Node.Element, Right.Node.Element);
   end;


   function Is_Equal_Key (Left  : Cursor_Type;
                          Right : Element_Type)
     return Boolean is
   begin
      return Is_Equal_Key (Left.Node.Element, Right);
   end;


   function Is_Equal_Key (Left  : Element_Type;
                          Right : Cursor_Type)
     return Boolean is
   begin
      return Is_Equal_Key (Left, Right.Node.Element);
   end;



end Hashed_Sets;

