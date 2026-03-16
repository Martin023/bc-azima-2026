// page 52186221 "Units Meter Rating"
// {
//     PageType = ListPart;
//     SourceTable = "Units meter Ratings";

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 ShowCaption = false;
//                 field("Property No"; Rec."Property No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Floor Code"; Rec."Floor Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Code"; Rec."Unit Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(No; Rec.No)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Water; Rec.Water)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Meter No"; Rec."Meter No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(InvoiceNo; Rec.InvoiceNo)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Nairobi Water Bill No"; Rec."Nairobi Water Bill No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sewer charge"; Rec."Sewer charge")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Tenant No."; Rec."Tenant No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Date Of Billing"; Rec."Date Of Billing")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnLookup(var Text: Text): Boolean
//                     begin
//                         /*
//                         //is obsolete in 2015
//                         FrmCalendar.SetDate("Date Of Billing");
//                         FrmCalendar.RUNMODAL;
//                         D := FrmCalendar.GetDate;
//                         CLEAR(FrmCalendar);
//                         IF D <> 0D THEN
//                           "Date Of Billing":= D;
//                          */

//                     end;
//                 }
//                 field("Meter Rent"; Rec."Meter Rent")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("C/Area Fixed Charge"; Rec."C/Area Fixed Charge")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Previous Reading"; Rec."Previous Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Current Reading"; Rec."Current Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Consumption; Rec.Consumption)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Water due"; Rec."Total Water due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Sewer Due"; Rec."Total Sewer Due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Due"; Rec."Total Due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Comments; Rec.Comments)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Discrepancy(Units)"; Rec."Discrepancy(Units)")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Discrepancy(Amount)"; Rec."Discrepancy(Amount)")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         BillTenant: Record "Bill Units meter Ratings";
//         NairobiWater: Record "Nairobi Water Bill";
//         FrmCalendar: Page "Units Meter Rating";
//         D: Date;
// }

