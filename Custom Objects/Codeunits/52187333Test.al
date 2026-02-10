// codeunit 52187333 Test
// {
//     procedure TestFunction(Mangoes: Integer; Oranges: integer; Children: Integer; var Share: Decimal) : Boolean
//     var
//         Subtraction: Integer;
//         Product: Integer;

//     begin
//         // Addition := Mangoes+Oranges;
        
//         // Subtraction := 3-1;

//         // Product := Subtraction * Addition;

//         // Share := Addition/Children;
//         if Mangoes = 0 then
//         exit(false)
//         else
//         exit(true);
        
//     end;

//     trigger OnRun()
//     Var
//     Addition: Integer;
//     Mangoes: Integer;
//     Oranges: Integer;
//     Children: Integer;
//     Share: Decimal;
//     LastError: Text;
//     begin
//         Mangoes := 0;
//         Oranges := 10;
//         Children := 3;
//         Share := 0;
//         if not TestFunction(Mangoes,Oranges,Children,Share) then
//             Message('Please give me mangoes');

//         Message(Format(Mangoes));
//     end;

// }