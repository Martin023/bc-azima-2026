// page 52185504 "Coop ATM Transactions"
// {
//     Editable = true;
//     PageType = List;
//     SourceTable = "Coop ATM Transaction";
//     ApplicationArea = Basic, Suite;
//     // UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Trace ID"; Rec."Document No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Date Posted"; Rec."Date Posted")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Member Account"; Rec."Member Account")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Description; Rec."Posting Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Transaction Type"; Rec."Transaction Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;

//                     trigger OnValidate()
//                     begin
//                         // IF (Reversed) THEN ERROR('Transaction has already been reversed');
//                         // IF "Transaction Type" <> '1420' THEN ERROR('Transaction type must be 1420');
//                         //
//                         // SkyPermissions.RESET;
//                         // SkyPermissions.SETRANGE("User ID",USERID);
//                         // SkyPermissions.SETRANGE("Release ATM Transactions",TRUE);
//                         // IF NOT SkyPermissions.FINDFIRST THEN ERROR('You must have permission Realease ATM Transactions in Sky Permissions');
//                     end;
//                 }
//                 field("Time Posted"; Rec."Time Posted")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Posted By"; Rec."Posted By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Transaction Time"; Rec."Transaction Time")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Transaction Date"; Rec."Transaction Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Reversed; Rec.Reversed)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Date Reversed"; Rec."Date Reversed")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Time Reversed"; Rec."Time Reversed")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Reversed By"; Rec."Reversed By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Reversal ID"; Rec."Reversal ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Description 1"; Rec."Description 1")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Description 2"; Rec."Description 2")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Skipped; Rec.Skipped)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Service Name"; Rec."Service Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("ATM No."; Rec."ATM No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Location; Rec.Location)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Transaction Name"; Rec."Transaction Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Activity; Rec.Activity)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Original Transaction ID"; Rec."Original Transaction ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Channel Code"; Rec."Channel Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Terminal Code"; Rec."Terminal Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Account Debit"; Rec."Total Account Debit")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Charges"; Rec."Total Charges")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Coop Fee"; Rec."Coop Fee")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Sacco Fee"; Rec."Sacco Fee")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Sacco Excise Duty"; Rec."Sacco Excise Duty")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Transaction ID"; Rec."Transaction ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         CoopProcessing: Codeunit "Coop Processing";
//         SkyPermissions: Record "Sky Permissions";
//         CoopATMTransaction: Record "Coop ATM Transaction";
// }

