// page 52186596 "HR BSC Appraisal Header-Approv"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'Manage,Process,Report,Approvals,Functions,Training';
//     SourceTable = "HR Individual Targets Header";


//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Appraisal No"; Rec."Appraisal No")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         AppraisalPeriod.Reset;
//                         AppraisalPeriod.SetRange(AppraisalPeriod.Closed, false);
//                         if AppraisalPeriod.Find('-') then begin
//                             OpenPeriod := AppraisalPeriod."Appraisal Month"
//                         end;

//                         HRIndividualTargetsHeader.Reset;
//                     end;
//                 }
//                 field("Appraisal Period"; Rec."Appraisal Period")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal Date"; Rec."Appraisal Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Appraisal Type"; Rec."Appraisal Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee Name"; Rec."Employee Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Supervisor ID"; Rec."Supervisor ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Supervisor Name"; Rec."Supervisor Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Financial Targeted Score"; Rec."Financial Targeted Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Achieved Financial  Score"; Rec."Achieved Financial  Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Unachieved Targets"; Rec."Unachieved Targets")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Training Targeted Score"; Rec."Training Targeted Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Training Achieved  Score"; Rec."Training Achieved  Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Service Delivery Target Score"; Rec."Service Delivery Target Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Service Delivery Achieved"; Rec."Service Delivery Achieved")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Customer Target Score"; Rec."Customer Target Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Customer Achieved  Score"; Rec."Customer Achieved  Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Finance Rating"; Rec."Finance Rating")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
//                         IF ("Finance Rating"<>0) AND (Finance<>0)  THEN
//                         "Finance Perc Score":=("Finance Rating"*25)/(Finance*5);
//                         IF ("Customer Rating"<>0)AND(Customer<>0)THEN
//                         "Customer Perc Score":=("Customer Rating"*25)/(Customer*5);
//                         IF ("Training Rating"<>0) AND(Training<>0) THEN
//                         "Training Perc Score":=("Training Rating"*25)/(Training*5);
//                         IF ("Service Rating"<>0) AND (Service<>0)THEN
//                         "Service Perc Score":=("Service Rating"*25)/(Service*5);
//                         //MESSAGE('%1,%2,%3,%4',"Finance Perc Score","Customer Perc Score","Training Perc Score","Service Perc Score");
//                         "Overall Perc Score":="Finance Perc Score"+"Customer Perc Score"+"Training Perc Score"+"Service Perc Score";
//                         MODIFY; */

//                     end;
//                 }
//                 field("Customer Rating"; Rec."Customer Rating")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
//                         IF ("Finance Rating"<>0) AND (Finance<>0)  THEN
//                         "Finance Perc Score":=("Finance Rating"*25)/(Finance*5);
//                         IF ("Customer Rating"<>0)AND(Customer<>0)THEN
//                         "Customer Perc Score":=("Customer Rating"*25)/(Customer*5);
//                         IF ("Training Rating"<>0) AND(Training<>0) THEN
//                         "Training Perc Score":=("Training Rating"*25)/(Training*5);
//                         IF ("Service Rating"<>0) AND (Service<>0)THEN
//                         "Service Perc Score":=("Service Rating"*25)/(Service*5);
//                         //MESSAGE('%1,%2,%3,%4',"Finance Perc Score","Customer Perc Score","Training Perc Score","Service Perc Score");
//                         "Overall Perc Score":="Finance Perc Score"+"Customer Perc Score"+"Training Perc Score"+"Service Perc Score";
//                         MODIFY;*/

//                     end;
//                 }
//                 field("Training Rating"; Rec."Training Rating")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
//                         IF ("Finance Rating"<>0) AND (Finance<>0)  THEN
//                         "Finance Perc Score":=("Finance Rating"*25)/(Finance*5);
//                         IF ("Customer Rating"<>0)AND(Customer<>0)THEN
//                         "Customer Perc Score":=("Customer Rating"*25)/(Customer*5);
//                         IF ("Training Rating"<>0) AND(Training<>0) THEN
//                         "Training Perc Score":=("Training Rating"*25)/(Training*5);
//                         IF ("Service Rating"<>0) AND (Service<>0)THEN
//                         "Service Perc Score":=("Service Rating"*25)/(Service*5);
//                         //MESSAGE('%1,%2,%3,%4',"Finance Perc Score","Customer Perc Score","Training Perc Score","Service Perc Score");
//                         "Overall Perc Score":="Finance Perc Score"+"Customer Perc Score"+"Training Perc Score"+"Service Perc Score";
//                         MODIFY;*/

//                     end;
//                 }
//                 field("Service Rating"; Rec."Service Rating")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         /*CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
//                         IF ("Finance Rating"<>0) AND (Finance<>0)  THEN
//                         "Finance Perc Score":=("Finance Rating"*25)/(Finance*5);
//                         IF ("Customer Rating"<>0)AND(Customer<>0)THEN
//                         "Customer Perc Score":=("Customer Rating"*25)/(Customer*5);
//                         IF ("Training Rating"<>0) AND(Training<>0) THEN
//                         "Training Perc Score":=("Training Rating"*25)/(Training*5);
//                         IF ("Service Rating"<>0) AND (Service<>0)THEN
//                         "Service Perc Score":=("Service Rating"*25)/(Service*5);
//                         //MESSAGE('%1,%2,%3,%4',"Finance Perc Score","Customer Perc Score","Training Perc Score","Service Perc Score");
//                         "Overall Perc Score":="Finance Perc Score"+"Customer Perc Score"+"Training Perc Score"+"Service Perc Score";
//                         MODIFY;*/

//                     end;
//                 }
//                 field("Overall Perc Score"; Rec."Overall Perc Score")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Lock appraisal"; Rec."Lock appraisal")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part("Financial Targets"; "HR Financial BSC Lines")
//             {
//                 Caption = 'Financial Targets';
//                 SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
//                               "Perspective Code" = CONST(1);
//             }
//             part("Internal Processes Targets"; "HR Service BSC Lines")
//             {
//                 Caption = 'Internal Processes Targets';
//                 SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
//                               "Perspective Code" = CONST(4);
//             }
//             part("Customer Targets"; "HR Customer BSC Lines")
//             {
//                 Caption = 'Customer Targets';
//                 SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
//                               "Perspective Code" = CONST(2);
//             }
//             part("Learning and Growth Targets"; "HR Training Target Lines")
//             {
//                 Caption = 'Learning and Growth Targets';
//                 SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
//                               "Perspective Code" = CONST(3);
//             }
//             part("Mid Year Review"; "Mid Year Review")
//             {
//                 SubPageLink = "Appraisal No" = FIELD("Appraisal No");
//             }
//             part("End Year Review"; "End Year Review")
//             {
//                 SubPageLink = "Appraisal No" = FIELD("Appraisal No");
//             }
//             part(Control4; "Performance Attributes Sheet")
//             {
//                 SubPageLink = "Appraisal No" = FIELD("Appraisal No");
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("Return to Appraissee")
//             {
//                 Caption = 'Return to Appraissee';
//                 Image = SendTo;
//                 Promoted = true;
//                 PromotedCategory = Category5;

//                 trigger OnAction()
//                 begin
//                     if Confirm('Do you want to return this Appraisal to the Appraisee?', true) = false then exit;

//                     Rec.Status := Rec.Status::Open;
//                     Rec.Modify;
//                 end;
//             }
//             action("Close Appraisal")
//             {
//                 Caption = 'Close Appraisal';
//                 Image = Close;
//                 Promoted = true;
//                 PromotedCategory = Category5;

//                 trigger OnAction()
//                 begin
//                     if Confirm('Do you want to approve this Document?', true) = false then exit;

//                     Rec.Status := Rec.Status::Approved;
//                     Rec.Modify;
//                 end;
//             }
//             action("Return to Appraissee and Lock")
//             {
//                 Caption = 'Return to Appraissee and Lock';
//                 Image = ReOpen;
//                 Promoted = true;
//                 PromotedCategory = Category5;

//                 trigger OnAction()
//                 begin

//                     if Confirm('Send this Appraisal back to Appraisee and Lock?', true) = false then exit;

//                     Rec.Status := Rec.Status::Open;
//                     Rec."Lock appraisal" := true;
//                     Rec.Modify;
//                 end;
//             }
//             action(Unlock)
//             {

//                 trigger OnAction()
//                 begin
//                     if Confirm('Send this Appraisal back to Appraisee UnLocked?', true) = false then exit;

//                     Rec.Status := Rec.Status::Open;
//                     Rec."Lock appraisal" := false;
//                     Rec.Modify;
//                 end;
//             }
//             action(Post)
//             {
//                 Caption = 'Post';
//                 Image = Post;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 Visible = false;

//                 trigger OnAction()
//                 begin
//                     if Rec."Appraisal Type" = Rec."Appraisal Type"::"Quarter 1" then begin
//                         Rec.TestField(Status, Rec.Status::Discussed);
//                     end;

//                     if Rec."Appraisal Type" = Rec."Appraisal Type"::"Target Setting" then begin
//                         Rec.TestField(Status, Rec.Status::Approved);
//                     end;

//                     if Confirm('Are you sure you want to post?', false) = true then begin
//                         Testfields;
//                         //post
//                         HRIndividualTargetsHeader.Reset;
//                         HRIndividualTargetsHeader.SetRange(HRIndividualTargetsHeader."Appraisal No", Rec."Appraisal No");
//                         if HRIndividualTargetsHeader.Find('-') then begin
//                             HRIndividualTargetsHeader.CreateLedgerEntries;
//                         end;
//                     end;
//                 end;
//             }
//             action("Training needs")
//             {
//                 Image = List;
//                 Promoted = true;
//                 PromotedCategory = Category6;
//                 RunObject = Page "M-SACCO Other Services";
//                 //RunPageLink = Field29 = FIELD("Employee No");
//                 Visible = false;
//             }
//             action(Print)
//             {
//                 Caption = 'Print';
//                 Image = PrintForm;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         /* CALCFIELDS("Finance Rating","Customer Rating","Training Rating","Service Rating",Customer,Training,Service,Finance);
//          IF ("Finance Rating"<>0) AND (Finance<>0)  THEN
//          "Finance Perc Score":=("Finance Rating"*25)/(Finance*5);
//          IF ("Customer Rating"<>0)AND(Customer<>0)THEN
//          "Customer Perc Score":=("Customer Rating"*25)/(Customer*5);
//          IF ("Training Rating"<>0) AND(Training<>0) THEN
//          "Training Perc Score":=("Training Rating"*25)/(Training*5);
//          IF ("Service Rating"<>0) AND (Service<>0)THEN
//          "Service Perc Score":=("Service Rating"*25)/(Service*5);
//          //MESSAGE('%1,%2,%3,%4',"Finance Perc Score","Customer Perc Score","Training Perc Score","Service Perc Score");
//          "Overall Perc Score":="Finance Perc Score"+"Customer Perc Score"+"Training Perc Score"+"Service Perc Score";
//          MODIFY;*/

//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     begin
//         //IndividualTarget.VALIDATE(IndividualTarget."Finance Perc Score");
//     end;

//     trigger OnOpenPage()
//     begin
//         /*
//         IF Status=Status::Approved THEN
//         CurrPage.EDITABLE:=FALSE
//         */

//     end;

//     var
//         //// //ApprovalEntries: Page "Approval Entries";
//         HRIndividualTargetsHeader: Record "HR Individual Targets Header";
//         OpenPeriod: Integer;
//         AppraisalPeriod: Record "HR Appraisal Period";
//         Editpage: Boolean;

//     //[Scope('OnPrem')]
//     procedure Testfields()
//     begin
//         Rec.TestField("Appraisal Period");
//         Rec.TestField("Appraisal No");
//         Rec.TestField("Appraisal Period");
//         Rec.TestField("Appraisal Date");
//         Rec.TestField("Employee No");
//     end;

//     //[Scope('OnPrem')]
//     procedure EditFields()
//     begin
//         if Rec.Status <> Rec.Status::Open then
//             Editpage := false else
//             Editpage := true;
//     end;
// }

