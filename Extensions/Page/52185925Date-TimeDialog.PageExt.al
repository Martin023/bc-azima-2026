// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185925 pageextension52185925 extends "Date-Time Dialog" 
// {
//     layout
//     {
//         modify(Date)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "Date(Control 2)".

//         }
//         modify(Time)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "Time(Control 3)".

//         }

//         //Unsupported feature: Code Modification on "Date(Control 2).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IF TimeValue = 0T THEN
//               TimeValue := 000000T;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             IF Time0 = 0T THEN
//               Time0 := 000000T;
//             */
//         //end;
//     }

//     var
//         Date0: Date;
//         Time0: Time;

//     //Unsupported feature: Property Deletion (Attributes) on "SetDateTime(PROCEDURE 1)".



//     //Unsupported feature: Code Modification on "SetDateTime(PROCEDURE 1)".

//     //procedure SetDateTime();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         // Setter method to initialize the Date and Time fields on the page

//         DateValue := DT2DATE(DateTime);
//         TimeValue := DT2TIME(DateTime);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         Date0 := DT2DATE(DateTime);
//         Time0 := DT2TIME(DateTime);
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "GetDateTime(PROCEDURE 2)".



//     //Unsupported feature: Code Modification on "GetDateTime(PROCEDURE 2)".

//     //procedure GetDateTime();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         // Getter method for the entered datatime value

//         EXIT(CREATEDATETIME(DateValue,TimeValue));
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         EXIT(CREATEDATETIME(Date0,Time0));
//         */
//     //end;
// }
