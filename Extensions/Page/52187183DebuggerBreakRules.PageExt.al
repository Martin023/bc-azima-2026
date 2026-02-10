// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187183 pageextension52187183 extends "Debugger Break Rules" 
// {
//     layout
//     {
//         modify(BreakOnError)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(BreakOnRecordChanges)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(SkipSystemTriggers)
//         {
//             Caption = 'Skip Codeunit 1';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "SkipSystemTriggers(Control 4)".


//             //Unsupported feature: Property Modification (Name) on "SkipSystemTriggers(Control 4)".

//         }
//     }
//     var
//         SkipCodeunit1: Boolean;

//     //Unsupported feature: Property Deletion (Attributes) on "SetBreakOnError(PROCEDURE 51)".


//     //Unsupported feature: Property Deletion (Attributes) on "GetBreakOnError(PROCEDURE 1)".


//     //Unsupported feature: Property Deletion (Attributes) on "SetBreakOnRecordChanges(PROCEDURE 52)".


//     //Unsupported feature: Property Deletion (Attributes) on "GetBreakOnRecordChanges(PROCEDURE 2)".


//     //Unsupported feature: Property Deletion (Attributes) on "SetSkipSystemTriggers(PROCEDURE 3)".


//     //Unsupported feature: Property Modification (Name) on "SetSkipSystemTriggers(PROCEDURE 3)".



//     //Unsupported feature: Code Modification on "SetSkipSystemTriggers(PROCEDURE 3)".

//     //procedure SetSkipSystemTriggers();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         SkipSystemTriggers := Value;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         SkipCodeunit1 := Value;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "GetSkipSystemTriggers(PROCEDURE 4)".


//     //Unsupported feature: Property Modification (Name) on "GetSkipSystemTriggers(PROCEDURE 4)".



//     //Unsupported feature: Code Modification on "GetSkipSystemTriggers(PROCEDURE 4)".

//     //procedure GetSkipSystemTriggers();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         EXIT(SkipSystemTriggers);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         EXIT(SkipCodeunit1);
//         */
//     //end;
// }
