// page 52186490 "HR Training App. Card - Approv"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Functions,Show';
//     SourceTable = "HR Training App Header";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Application No"; Rec."Application No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Course Title"; Rec."Course Title")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Bonded Training?"; Rec."Bonded Training?")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Course Description"; Rec."Course Description")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("No. of Participants"; Rec."No. of Participants")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("End Date"; Rec."End Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Duration; Rec.Duration)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Actual Start Date"; Rec."Actual Start Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Actual Duration"; Rec."Actual Duration")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Actual End Date"; Rec."Actual End Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     ShowMandatory = true;
//                 }
//                 field("Training Status"; Rec."Training Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//             part(Control3; "HR Training Application Lines")
//             {
//                 ApplicationArea = Basic;
//                 SubPageLink = "Application No." = FIELD("Application No");
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control14; Outlook)
//             {
//                 ApplicationArea = Basic;
//             }
//             systempart(Control15; Notes)
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Show")
//             {
//                 Caption = '&Show';
//                 action("&Approvals")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = '&Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category5;

//                     trigger OnAction()
//                     var
//                         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
//                         //ApprovalEntries: Page "Approval Entries";
//                     begin
//                         DocumentType := DocumentType::"Training App";
//                         ApprovalEntries.SetRecordFilters(DATABASE::"HR Training App Header", DocumentType, Rec."Application No");
//                         ApprovalEntries.Run;
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 action("Close / Re-Open")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Close / Re-Open';
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     begin
//                         if Rec."Training Status" = Rec."Training Status"::Ongoing then begin
//                             if not Confirm('Close Training?', false) then exit;
//                             Rec."Training Status" := Rec."Training Status"::Closed;
//                             Rec.TestField("Actual Duration");
//                             Rec.TestField("Actual End Date");
//                             Rec.Modify;
//                             exit;
//                         end;

//                         if Rec."Training Status" = Rec."Training Status"::Closed then begin
//                             if not Confirm('Re-Open Training?', false) then exit;
//                             Rec.TestField("Actual Start Date");
//                             Rec."Training Status" := Rec."Training Status"::Ongoing;
//                             Rec.Modify;
//                             exit;
//                         end;
//                     end;
//                 }
//                 action("Mark as Ongoing")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Mark as Ongoing';
//                     Image = Register;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     begin

//                         //IF "Training Status" = "Training Status"::" "  THEN
//                         //BEGIN
//                         if not Confirm('Mark training as ongoing ?', false) then exit;
//                         Rec."Training Status" := Rec."Training Status"::Ongoing;
//                         Rec.TestField("Actual Start Date");
//                         Rec.Modify;
//                         //END;
//                     end;
//                 }
//                 action("Notify Participants")
//                 {
//                     ApplicationArea = Basic;
//                     Image = SendMail;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     begin

//                         HRTrainingAppLines.Reset;
//                         HRTrainingAppLines.SetRange(HRTrainingAppLines."Application No.", Rec."Application No");
//                         if HRTrainingAppLines.Find('-') then begin
//                             repeat
//                                 if Rec.Status = Rec.Status::New then
//                                     Error('You Cannot notify a participant when the application is not approved');

//                                 // smtp.CreateMessage('Training Notification', HRTrainingAppLines."Participant Email", HRTrainingAppLines."Participant Email",
//                                 //    'Transport Notification', 'Your Training application No:,' + "Application No" + '  ' + 'has been fully approved. Your training on' + "Course Description" + ' ' + 'starts on' + ' ' +
//                                 //   Format("Actual Start Date") + ' ' + 'for a period of' + ' ' + Format("Actual Duration") + ' ' + 'and ends on' + ' ' + Format("Actual End Date") + ' ' +
//                                 //     HRTrainingAppLines."Employee No." + '   ' + HRTrainingAppLines.Name + '   ', true);//"Drop Off Point"+'  '+"Pickup Point"+'  '+FORMAT("Transport Type")+'   '+'Days Applied'+'   '+FORMAT("Days Applied")+'   '+'   '+'Start Time'+'   ',TRUE)
//                                 //                                                                                        // '  '+FORMAT(Time)+'   '+'Start Date'+FORMAT("Start Date")+'   '+'   '+'Return Date'+'   '+ FORMAT("Return Date")+'  ''Driver Name'+'  '+"Driver Name"+'  '+'Vehicle'+'  '+Vehicle+'  '+"Name Vehicle",TRUE);
//                                 //smtp.Send();
//                                 Message('Training participants notified');
//                                 HRTrainingAppLines.Notified := true;
//                                 HRTrainingAppLines.Modify;
//                             until HRTrainingAppLines.Next = 0;

//                         end
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin

//         if Rec.Status = Rec.Status::New then begin
//             "Responsibility CenterEditable" := true;
//             "Application NoEditable" := true;
//             "Employee No.Editable" := true;
//             "Employee NameEditable" := true;
//             "Employee DepartmentEditable" := true;
//             "Purpose of TrainingEditable" := true;
//             "Course TitleEditable" := true;
//         end else begin
//             "Responsibility CenterEditable" := false;
//             "Application NoEditable" := false;
//             "Employee No.Editable" := false;
//             "Employee NameEditable" := false;
//             "Employee DepartmentEditable" := false;
//             "Purpose of TrainingEditable" := false;
//             "Course TitleEditable" := false;
//         end;
//     end;

//     trigger OnInit()
//     begin
//         "Course TitleEditable" := true;
//         "Purpose of TrainingEditable" := true;
//         "Employee DepartmentEditable" := true;
//         "Employee NameEditable" := true;
//         "Employee No.Editable" := true;
//         "Application NoEditable" := true;
//         "Responsibility CenterEditable" := true;
//     end;

//     var
//         HREmp: Record "HR Employees";
//         EmpNames: Text[40];
//         sDate: Date;
//         HRTrainingApplications: Record "HR Training App Header";
//         // ApprovalMgt: Codeunit "Approvals Mgmt.";
//         ApprovalComments: Page "Approval Comments";
//         
//         "Responsibility CenterEditable": Boolean;
//         
//         "Application NoEditable": Boolean;
//         
//         "Employee No.Editable": Boolean;
//         
//         "Employee NameEditable": Boolean;
//         
//         "Employee DepartmentEditable": Boolean;
//         
//         "Purpose of TrainingEditable": Boolean;
//         
//         "Course TitleEditable": Boolean;
//         HRExitTrainingBond: Record "HR Exit Training Bonding";
//         HRTrainingAppLines: Record "HR Training App Lines";
//         HRTrainingNeeds: Record "HR Training Needs";
//         HRActivityApprovalEntry: Record "HR Training App Lines";
//         HREmailParameters: Record "HR E-Mail Parameters";
//     // smtp: Codeunit "SMTP Mail";

//     //[Scope('OnPrem')]
//     procedure TESTFIELDS()
//     begin
//     end;

//     local procedure get_LastLineNo() LastLineNo: Integer
//     var
//         HRExitTrainingBonding2: Record "HR Exit Training Bonding";
//     begin
//         HRExitTrainingBonding2.Reset;
//         if HRExitTrainingBonding2.Find('+') then begin
//             Rec.Status := Rec.Status::Approved;
//             LastLineNo := HRExitTrainingBonding2."Line No.";
//         end else begin
//             Rec.Status := Rec.Status::Approved;
//             LastLineNo := 1;
//         end;
//     end;
// }

