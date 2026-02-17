// page 52186203 "Posted Nairobi water Bill"
// {
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Nairobi Water Bill";
//     SourceTableView = WHERE("billed tenants" = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             group("Water billing")
//             {
//                 Caption = 'Water billing';
//                 label(Control1102755046)
//                 {
//                     CaptionClass = Text19029898;
//                     ShowCaption = false;
//                 }
//                 field("Property No."; Rec."Property No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Billing No.';
//                     Editable = false;
//                 }
//                 field("Meter Category"; Rec."Meter Category")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("L/R No."; Rec."L/R No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Water; Rec.Water)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sewer charge"; Rec."Sewer charge")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Meter No."; Rec."Meter No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Meter No';
//                 }
//                 field("Previous Reading"; Rec."Previous Reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Previous Meter reading';
//                     Editable = false;
//                 }
//                 field("Current[Present] reading"; Rec."Current[Present] reading")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Current Meter Reading';
//                 }
//                 field(Consumption; Rec.Consumption)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Consumption';
//                 }
//                 field("Total Sewer Due"; Rec."Total Sewer Due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Water due"; Rec."Total Water due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Due"; Rec."Total Due")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Bill No."; Rec."Bill No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Property Sequence"; Rec."Property Sequence")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Meter Reading Date"; Rec."Meter Reading Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Account No.[Bill Account]"; Rec."Account No.[Bill Account]")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total No Of Units"; Rec."Total No Of Units")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Total No. Units[Occupied]';
//                     Editable = false;
//                 }
//                 field("Billing date"; Rec."Billing date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Units Total [Water]"; Rec."Units Total [Water]")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Units total [Sewer]"; Rec."Units total [Sewer]")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("billed tenants"; Rec."billed tenants")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             part(Control1102755053; "Units Meter Rating")
//             {
//                 SubPageLink = "Property No" = FIELD("Property No."),
//                               "Nairobi Water Bill No" = FIELD("No.");
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Functions)
//             {
//                 Caption = 'Functions';
//                 Visible = false;
//                 action("Bill Tenant[Water]")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Bill Tenant[Water]';

//                     trigger OnAction()
//                     begin
//                         if Confirm('Do you want to Bill Tenants?', false) = false then begin
//                             Error('Tenant Bills Not Processed')
//                         end;
//                         UnitMeterReading.Reset;
//                         UnitMeterReading.SetRange(UnitMeterReading."Property No", Rec."Property No.");
//                         // UnitMeterReading.GET(UnitMeterReading."Property No");
//                         if UnitMeterReading.Find('-') then begin
//                             repeat
//                                 // BillTenant.RESET;
//                                 BillTenant.Init;
//                                 BillTenant."Property No" := UnitMeterReading."Property No";
//                                 BillTenant."Floor Code" := UnitMeterReading."Floor Code";
//                                 BillTenant."Unit Code" := UnitMeterReading."Unit Code";
//                                 BillTenant."Meter No" := UnitMeterReading."Meter No";
//                                 BillTenant."Previous Reading" := UnitMeterReading."Previous Reading";
//                                 BillTenant."Current Reading" := UnitMeterReading."Current Reading";
//                                 BillTenant.Consumption := UnitMeterReading.Consumption;
//                                 BillTenant."Global Dimension 1 Code" := UnitMeterReading."Global Dimension 1 Code";
//                                 BillTenant."Global Dimension 2 Code" := UnitMeterReading."Global Dimension 2 Code";
//                                 BillTenant."Total Water due" := UnitMeterReading."Total Water due";
//                                 BillTenant."Total Sewer Due" := UnitMeterReading."Total Sewer Due";
//                                 BillTenant."Date Of Billing" := UnitMeterReading."Date Of Billing";
//                                 BillTenant."Tenant No." := UnitMeterReading."Tenant No.";
//                                 BillTenant."Total Due" := UnitMeterReading."Total Due";
//                                 BillTenant.Insert;
//                             until UnitMeterReading.Next = 0;
//                         end;
//                         Message('Tenants have been Billed');
//                         Rec."billed tenants" := true;
//                         Rec.Modify;
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         UnitMeterReading: Record "Units meter Ratings";
//         BillTenant: Record "Bill Units meter Ratings";
//         Text19029898: Label 'Sewer reading';
// }

