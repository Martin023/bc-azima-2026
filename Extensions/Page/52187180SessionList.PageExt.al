// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187180 pageextension52187180 extends "Session List" 
// {
//     layout
//     {
//         modify(SessionIdText)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("User ID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(IsSQLTracing)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Client Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Login Datetime")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Server Computer Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Server Instance Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(IsDebugging)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(IsDebugged)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "SessionIdText(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 4)".


//         //Unsupported feature: Code Modification on "IsSQLTracing(Control 15).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             IsSQLTracing := DEBUGGER.ENABLESQLTRACE("Session ID",IsSQLTracing);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             DEBUGGER.ENABLESQLTRACE("Session ID",IsSQLTracing);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "IsSQLTracing(Control 15)".


//         //Unsupported feature: Property Deletion (Editable) on "IsSQLTracing(Control 15)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Client Type"(Control 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Login Datetime"(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Server Computer Name"(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Server Instance Name"(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "IsDebugging(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "IsDebugged(Control 16)".

//     }
//     actions
//     {
//         modify("Debug Selected Session")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Debug Next Session")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Start Full SQL Tracing")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Stop Full SQL Tracing")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Subscriptions)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Start Full SQL Tracing"(Action 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Stop Full SQL Tracing"(Action 21)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Subscriptions(Action 18)".

//     }


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IsDebugging := DEBUGGER.ISACTIVE AND ("Session ID" = DEBUGGER.DEBUGGINGSESSIONID);
//         IsDebugged := DEBUGGER.ISATTACHED AND ("Session ID" = DEBUGGER.DEBUGGEDSESSIONID);
//         IsSQLTracing := DEBUGGER.ENABLESQLTRACE("Session ID");
//         IsRowSessionActive := ISSESSIONACTIVE("Session ID");

//         // If this is the empty row, clear the Session ID and Client Type
//         IF "Session ID" = 0 THEN BEGIN
//         #8..10
//           SessionIdText := FORMAT("Session ID");
//           ClientTypeText := FORMAT("Client Type");
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..3
//         #5..13
//         */
//     //end;
// }
