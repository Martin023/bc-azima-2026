// page 52185560 "HR Leave Application Comments"
// {
//     PageType = Card;
//     SourceTable = "Approval Comment Line";

//     layout
//     {
//         area(content)
//         {
//             // field(DocType; Rec.DocType)
//             // {
//             //     Editable = false;
//             //     OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Bank Slip,Grant,Grant Surrender,Employee Requisition,Leave Application,Training Application,Transport Requisition';
//             // }
//             // field(DocNo; Rec.DocNo)
//             // {
//             //     Editable = false;
//             // }
//             repeater(Control1102755000)
//             {
//                 ShowCaption = false;
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date and Time"; Rec."Date and Time")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Comment; Rec.Comment)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Approved Days"; Rec."Approved Days")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Approved Start Date"; Rec."Approved Start Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Approved Return Date"; Rec."Approved Return Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Reason; Rec.Reason)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Leave Allowance Granted"; Rec."Leave Allowance Granted")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         NewTableId: Integer;
//         NewDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
//         NewDocumentNo: Code[20];
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
//         DocNo: Code[20];

//     //[Scope('OnPrem')]
//     procedure SetUpLine(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application"; DocumentNo: Code[20])
//     begin
//         NewTableId := TableId;
//         NewDocumentType := DocumentType;
//         NewDocumentNo := DocumentNo;
//     end;

//     //[Scope('OnPrem')]
//     procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application"; DocumentNo: Code[20])
//     begin
//         if TableId <> 0 then begin
//             Rec.FilterGroup(2);
//             Rec.SetCurrentKey("Table ID", "Document Type", "Document No.");
//             Rec.SetRange("Table ID", TableId);
//             Rec.SetRange("Document Type", DocumentType);
//             if DocumentNo <> '' then
//                 Rec.SetRange("Document No.", DocumentNo);
//             Rec.FilterGroup(0);
//         end;

//         DocType := DocumentType;
//         DocNo := DocumentNo;
//     end;
// }

