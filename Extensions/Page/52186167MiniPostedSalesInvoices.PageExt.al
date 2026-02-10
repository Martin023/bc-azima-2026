// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186167 pageextension52186167 extends "O365 Getting Started" 
// {

//     //Unsupported feature: Property Modification (Name) on ""O365 Getting Started"(Page 1309)".

//     Caption = 'Posted Sales Invoices';

//     //Unsupported feature: Property Modification (SourceTable) on ""O365 Getting Started"(Page 1309)".


//     //Unsupported feature: Property Modification (PageType) on ""O365 Getting Started"(Page 1309)".

//     Editable = false;

//     //Unsupported feature: Property Insertion (CardPageID) on ""O365 Getting Started"(Page 1309)".


//     //Unsupported feature: Property Insertion (PromotedActionCategoriesML) on ""O365 Getting Started"(Page 1309)".

//     layout
//     {

//         //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


//         //Unsupported feature: Property Insertion (Level) on "Control1(Control 1)".


//         //Unsupported feature: Property Insertion (GroupType) on "Control1(Control 1)".

//         modify(WelcomeWizard)
//         {

//             //Unsupported feature: Property Modification (Level) on "WelcomeWizard(Control 2)".


//             //Unsupported feature: Property Modification (Name) on "WelcomeWizard(Control 2)".

//             ApplicationArea = Basic;
//             ToolTip = 'Specifies the posted invoice number.';

//             //Unsupported feature: Property Insertion (SourceExpr) on "WelcomeWizard(Control 2)".

//         }

//         //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".

//         modify(Control3)
//         {
//             Visible = false;
//         }
//         modify(Control4)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ControlAddIn) on "WelcomeWizard(Control 2)".

//         addfirst(content)
//         {
//         }
//         addfirst(WelcomeWizard)
//         {
//             field("Sell-to Customer Name";"Sell-to Customer Name")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Customer Name';
//                 ToolTip = 'Specifies the name of the customer that you shipped the items on the invoice to.';
//             }
//             field("Due Date";"Due Date")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the date on which the invoice is due for payment. The program calculates the date using the Payment Terms Code and Posting Date fields on the sales header.';
//             }
//             field(Amount;Amount)
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the total, in the currency of the invoice, of the amounts on all the invoice lines. The amount does not include VAT.';

//                 trigger OnDrillDown()
//                 begin
//                     Rec.SetRange("No.");
//                     Page.RunModal(Page::"Mini Posted Sales Invoice",Rec)
//                 end;
//             }
//             field("Amount Including VAT";"Amount Including VAT")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the total of the amounts in all the amount fields on the invoice, in the currency of the invoice. The amount includes VAT.';

//                 trigger OnDrillDown()
//                 begin
//                     Rec.SetRange("No.");
//                     Page.RunModal(Page::"Mini Posted Sales Invoice",Rec)
//                 end;
//             }
//             field("Remaining Amount";"Remaining Amount")
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the amount that remains to be paid for the posted sales invoice.';
//             }
//             field(Paid;Paid)
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies if the posted sales invoice is paid. The Paid check box will also be selected if a credit memo for the remaining amount has been applied to the posted sales invoice. In that situation, the customer has not actually paid the remaining amount, but the sales invoice is still marked as Paid, because the remaining amount is zero.';
//             }
//             field(Canceled;Canceled)
//             {
//                 ApplicationArea = Basic;
//                 DrillDownPageID = "Mini Posted Sales Credit Memos";
//                 HideValue = not Canceled;
//                 LookupPageID = "Mini Posted Sales Credit Memos";
//                 Style = Unfavorable;
//                 StyleExpr = Canceled;
//                 ToolTip = 'Specifies if the posted sales invoice has been either corrected or canceled.';
//             }
//             field("Document Exchange Status";"Document Exchange Status")
//             {
//                 ApplicationArea = Basic;
//                 StyleExpr = DocExchStatusStyle;
//                 ToolTip = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.';

//                 trigger OnDrillDown()
//                 begin
//                     DocExchStatusDrillDown;
//                 end;
//             }
//         }
//     }
//     actions
//     {
//         modify(ActionContainer6)
//         {
//             Visible = false;
//         }
//         modify("Get Started")
//         {
//             Visible = false;
//         }

//         addfirst(processing)
//         {
//             group(Correct)
//             {
//                 Caption = 'Correct';
//                 action(CorrectInvoice)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Correct';
//                     Image = Undo;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Scope = Repeater;
//                     ToolTip = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.';
//                 }
//                 action(CancelInvoice)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cancel';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Scope = Repeater;
//                     ToolTip = 'Create and post a sales credit memo that reverses this posted sales invoice. This posted sales invoice will be canceled.';
//                 }
//                 action(CreateCreditMemo)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Create Corrective Credit Memo';
//                     Image = CreateCreditMemo;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Scope = Repeater;
//                     ToolTip = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.';
//                 }
//             }
//             group(Send)
//             {
//                 Caption = 'Send';
//                 action(SendCustom)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Send';
//                     Ellipsis = true;
//                     Image = SendToMultiple;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     Scope = Repeater;
//                     ToolTip = 'Send the selected posted sales document.';
//                 }
//                 action("&Print")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = '&Print';
//                     Ellipsis = true;
//                     Image = Print;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = true;
//                     Scope = Repeater;
//                     ToolTip = 'Print the selected posted sales document.';
//                 }
//                 action(Email)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Email';
//                     Ellipsis = true;
//                     Image = Email;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Process;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = true;
//                     Scope = Repeater;
//                     ToolTip = 'Attach the selected posted sales document to an email to the customer.';
//                 }
//             }
//             action(ActivityLog)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Activity Log';
//                 Image = Log;
//             }
//             group(Invoice)
//             {
//                 Caption = 'Invoice';
//                 Image = Invoice;
//                 action(Customer)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Customer';
//                     Image = Customer;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
//                     RunObject = Page "Mini Customer Card";
//                     RunPageLink = "No."=field("Sell-to Customer No.");
//                     Scope = Repeater;
//                     ShortCutKey = 'Shift+F7';
//                     ToolTip = 'View or edit detailed information about the customer on the selected posted sales document.';
//                 }
//                 action(ShowCreditMemo)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Show Corrective Credit Memo';
//                     Enabled = Canceled;
//                     Image = CreditMemo;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
//                     RunObject = Page "Mini Posted Sales Credit Memo";
//                     RunPageLink = "No."=field("Canceled By");
//                     Scope = Repeater;
//                     ToolTip = 'Open the posted sales credit memo that was created when you canceled the selected posted sales invoice.';
//                 }
//                 action("&Navigate")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = '&Navigate';
//                     Image = Navigate;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
//                     Scope = Repeater;
//                     ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected posted sales document.';
//                 }
//             }
//         }
//     }

//     var
//         DocExchStatusStyle: Text;


//     //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

//     //trigger OnAfterGetCurrRecord()
//     //begin
//         /*
//         DocExchStatusStyle := GetDocExchStatusStyle;
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //begin
//         /*
//         DocExchStatusStyle := GetDocExchStatusStyle;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF NOT AlreadyShown THEN
//           MarkAsShown;

//         CurrentPage := TRUE;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         SetSecurityFilterOnRespCenter;
//         */
//     //end;
// }
