// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187175 pageextension52187175 extends Debugger 
// {
//     layout
//     {

//         //Unsupported feature: Property Deletion (ApplicationArea) on "CodeViewer(Control 2)".

//         modify("FinishTime - StartTime")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ApplicationArea) on "Watches(Control 5)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Callstack(Control 10)".

//     }
//     actions
//     {
//         modify("Step Into")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Step Over")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Step Out")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Continue)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Break")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Stop)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Toggle)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Set/Clear Condition")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Disable All")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Breakpoints)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Break Rules")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Variables)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(LastErrorMessage)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Code Modification on ""Step Into"(Action 8).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             StartTime := CURRENTDATETIME;
//             WaitingForBreak;
//             DebuggerManagement.SetCodeTrackingAction;
//             DEBUGGER.STEPINTO;
//             FinishTime := CURRENTDATETIME;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #2..4
//             */
//         //end;


//         //Unsupported feature: Code Modification on ""Step Over"(Action 7).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             StartTime := CURRENTDATETIME;
//             WaitingForBreak;
//             DebuggerManagement.SetCodeTrackingAction;
//             DEBUGGER.STEPOVER;
//             FinishTime := CURRENTDATETIME;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #2..4
//             */
//         //end;


//         //Unsupported feature: Code Modification on ""Step Out"(Action 9).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             StartTime := CURRENTDATETIME;
//             WaitingForBreak;
//             DebuggerManagement.SetCodeTrackingAction;
//             DEBUGGER.STEPOUT;
//             FinishTime := CURRENTDATETIME;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #2..4
//             */
//         //end;


//         //Unsupported feature: Code Modification on "Continue(Action 12).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             StartTime := CURRENTDATETIME;
//             WaitingForBreak;
//             DebuggerManagement.SetRunningCodeAction;
//             DEBUGGER.CONTINUE;
//             FinishTime := CURRENTDATETIME;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #2..4
//             */
//         //end;


//         //Unsupported feature: Code Modification on "Break(Action 31).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             BreakEnabled := FALSE;
//             DebuggerManagement.SetRunningCodeAction;
//             DEBUGGER."BREAK";
//             FinishTime := CURRENTDATETIME;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #1..3
//             */
//         //end;


//         //Unsupported feature: Code Modification on "Stop(Action 15).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             WaitingForBreak;
//             DebuggerManagement.SetRunningCodeAction;
//             DEBUGGER.STOP;
//             FinishTime := CURRENTDATETIME;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #1..3
//             */
//         //end;


//         //Unsupported feature: Code Modification on ""Break Rules"(Action 35).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DebuggerBreakRulesPage.SetBreakOnError(BreakOnError);
//             DebuggerBreakRulesPage.SetBreakOnRecordChanges(BreakOnRecordChanges);
//             DebuggerBreakRulesPage.SetSkipSystemTriggers(SkipSystemTriggers);

//             IF DebuggerBreakRulesPage.RUNMODAL = ACTION::OK THEN BEGIN
//               BreakOnError := DebuggerBreakRulesPage.GetBreakOnError;
//               DEBUGGER.BREAKONERROR(BreakOnError);
//               BreakOnRecordChanges := DebuggerBreakRulesPage.GetBreakOnRecordChanges;
//               DEBUGGER.BREAKONRECORDCHANGES(BreakOnRecordChanges);
//               SkipSystemTriggers := DebuggerBreakRulesPage.GetSkipSystemTriggers;
//               DEBUGGER.SKIPSYSTEMTRIGGERS(SkipSystemTriggers);

//               SaveConfiguration;
//             END;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             DebuggerBreakRulesPage.SetBreakOnError(BreakOnError);
//             DebuggerBreakRulesPage.SetBreakOnRecordChanges(BreakOnRecordChanges);
//             DebuggerBreakRulesPage.SetSkipCodeunit1(SkipCodeunit1);
//             #4..9
//               SkipCodeunit1 := DebuggerBreakRulesPage.GetSkipCodeunit1;
//               DEBUGGER.SKIPSYSTEMTRIGGERS(SkipCodeunit1);
//             #12..14
//             */
//         //end;
//         modify(BreakOnErrorIsOn)
//         {
//             Visible = false;
//         }
//         modify(BreakOnErrorIsOff)
//         {
//             Visible = false;
//         }
//     }

//     var
//         SkipCodeunit1: Boolean;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF BreakpointHit THEN BEGIN
//           CurrPage.Callstack.PAGE.GetCurrentCallstack(DebuggerCallstack);
//           WITH DebuggerCallstack DO BEGIN
//             IF ID <> 0 THEN
//               DataCaption := STRSUBSTNO(Text003Cap,"Object Type","Object ID","Object Name")
//             ELSE
//               DataCaption := Text004Cap;
//           END;
//           FinishTime := CURRENTDATETIME;
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..8
//         END;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         StartTime := CURRENTDATETIME;
//         FinishTime := StartTime;
//         DebuggerManagement.GetDebuggedSession(DebuggedSession);
//         IF DebuggedSession."Session ID" = 0 THEN
//           DEBUGGER.ACTIVATE
//         #6..10
//         IF UserPersonalization.GET(USERSECURITYID) THEN BEGIN
//           BreakOnError := UserPersonalization."Debugger Break On Error";
//           BreakOnRecordChanges := UserPersonalization."Debugger Break On Rec Changes";
//           SkipSystemTriggers := UserPersonalization."Debugger Skip System Triggers";
//         END;

//         IF BreakOnError THEN
//           DEBUGGER.BREAKONERROR(TRUE);
//         IF BreakOnRecordChanges THEN
//           DEBUGGER.BREAKONRECORDCHANGES(TRUE);
//         IF SkipSystemTriggers THEN
//           DEBUGGER.SKIPSYSTEMTRIGGERS(TRUE);

//         DebuggerManagement.ResetActionState;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #3..13
//           SkipCodeunit1 := UserPersonalization."Debugger Skip System Triggers";
//         #15..20
//         IF SkipCodeunit1 THEN
//         #22..24
//         */
//     //end;


//     //Unsupported feature: Code Modification on "SaveConfiguration(PROCEDURE 1)".

//     //procedure SaveConfiguration();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF UserPersonalization.GET(USERSECURITYID) THEN BEGIN
//           UserPersonalization."Debugger Break On Error" := BreakOnError;
//           UserPersonalization."Debugger Break On Rec Changes" := BreakOnRecordChanges;
//           UserPersonalization."Debugger Skip System Triggers" := SkipSystemTriggers;
//           UserPersonalization.MODIFY;
//         END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..3
//           UserPersonalization."Debugger Skip System Triggers" := SkipCodeunit1;
//           UserPersonalization.MODIFY;
//         END;
//         */
//     //end;
// }
