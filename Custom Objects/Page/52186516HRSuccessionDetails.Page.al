// page 52186516 "HR Succession Details"
// {
//     PageType = Card;
//     SourceTable = "HR Jobs to Succeed";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Job ID"; Rec."Job ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Position Reporting to"; Rec."Position Reporting to")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Comment; Rec.Comment)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Vacant Positions"; Rec."Vacant Positions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Grade; Rec.Grade)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 // field(DesiredScore; Rec.DesiredScore)
//                 // {
//                 //     Caption = 'Desired Score';
//                 // }
//             }
//             group(Dimensions)
//             {
//                 field("Dimension 1"; Rec."Dimension 1")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Department; Rec.Department)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part(Control11; "HR Successor")
//             {
//                 ApplicationArea = Basic;
//                 SubPageLink = "Position to Succeed" = FIELD("Job ID");
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action(Approvals)
//             {
//                 ApplicationArea = Basic;
//                 Image = Approvals;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     DocumentType := DocumentType::SuccDetails;
//                     ApprovalEntries.SetRecordFilters(DATABASE::"HR Jobs to Succeed", DocumentType, Rec."Job ID");
//                     ApprovalEntries.Run;
//                 end;
//             }
//             action("Send Approval Request")
//             {
//                 ApplicationArea = Basic;
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     //TESTFIELDS;

//                     if Confirm('Send this Application for Approval?', true) = false then exit;
//                     //ApprovalMgt.SendSuccessionDetailsApproval(Rec);
//                 end;
//             }
//             action("Cancel Approvals")
//             {
//                 ApplicationArea = Basic;
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     //ApprovalMgt.CancelSuccessionDetailsApproval(Rec,TRUE,TRUE);
//                 end;
//             }
//             action("Suggest Successors")
//             {
//                 ApplicationArea = Basic;
//                 Image = SelectEntries;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     countcompetence := 0;
//                     sumcompetence := 0;
//                     countqulify := 0;
//                     sumqulify := 0;
//                     Resqulify := 0;
//                     Rescompetence := 0;
//                     countjreq := 0;
//                     sumjreq := 0;
//                     resjreq := 0;


//                     HRSuccessionEmployee.Reset;
//                     HRSuccessionEmployee.SetRange(HRSuccessionEmployee."Position to Succeed", Rec."Job ID");
//                     if HRSuccessionEmployee.Find('-') then begin
//                         HRSuccessionEmployee.DeleteAll;
//                         LNo := 0;
//                     end;
//                     HRSuccessionEmployee."Position to Succeed" := Rec."Job ID";


//                     HREmp.Reset;
//                     //   HREmp.SETRANGE(HREmp.Status, HREmp.Status::"0");
//                     if HREmp.Find('-') then begin
//                         repeat
//                             //competency
//                             HREmployeeCompetency.Reset;
//                             HREmployeeCompetency.SetRange(HREmployeeCompetency."Employee No", HREmp."No.");
//                             if HREmployeeCompetency.Find('-') then
//                                 countcompetence := HREmployeeCompetency.Count;
//                             begin
//                                 repeat
//                                     sumcompetence := sumcompetence + HREmployeeCompetency."Competency Score";
//                                 until HREmployeeCompetency.Next = 0;

//                             end;

//                             //check for averAGE
//                             Rescompetence := ((sumcompetence / countcompetence) / 100) * 33.3;

//                             //qualification
//                             HREmployeeQualifications_2.Reset;
//                             HREmployeeQualifications_2.SetRange(HREmployeeQualifications_2."Employee No.", HREmp."No.");
//                             if HREmployeeQualifications_2.Find('-') then
//                                 countqulify := HREmployeeQualifications_2.Count;
//                             begin
//                                 repeat
//                                     sumqulify := sumqulify + HREmployeeQualifications_2.Score;
//                                 until HREmployeeQualifications_2.Next = 0;
//                             end;
//                             Resqulify := ((sumqulify / countqulify) / 100) * 33.3;

//                             //job requirements
//                             HRJobRequirements.Reset;
//                             HRJobRequirements.SetRange(HRJobRequirements."Job ID", Rec."Job ID");
//                             if HRJobRequirements.Find('-') then begin
//                                 repeat
//                                     //for each JR compare with Emp qlfction
//                                     HREmployeeQualifications.Reset;
//                                     HREmployeeQualifications.SetRange(HREmployeeQualifications."Employee No.", HREmp."No.");
//                                     HREmployeeQualifications.SetRange(HREmployeeQualifications."Qualification Code", HRJobRequirements."Qualification Code");
//                                     if HREmployeeQualifications.FindFirst then begin

//                                         countjreq := countjreq + 1;
//                                         sumjreq := sumjreq + HREmployeeQualifications.Score;

//                                     end;
//                                 until HRJobRequirements.Next = 0;
//                                 resjreq := ((sumjreq / countjreq) / 100) * 33.3;

//                             end;

//                             //message(format(resjreq));
//                             //message(format(Resqulify));


//                             //if true insert into hr successors
//                             TotalScore := Rescompetence + Resqulify + resjreq;
//                             //check if emp has met the threshold (Desired score)
//                             if TotalScore >= DesiredScore then begin
//                                 //insert into HR Successor
//                                 /*
//                                  MESSAGE(FORMAT(TotalScore));
//                                 MESSAGE(FORMAT(HREmp."No."));
//                                 */

//                                 HRSuccessionEmployee.Init;
//                                 HRSuccessionEmployee."Line No.2" += 1;
//                                 HRSuccessionEmployee."Position to Succeed" := Rec."Job ID";
//                                 HRSuccessionEmployee."Staff No." := HREmp."No.";
//                                 HRSuccessionEmployee."Position Description" := HREmp.Position;
//                                 HRSuccessionEmployee."Job Title" := HREmp.Position;
//                                 HRSuccessionEmployee."Staff Names" := HREmp."Job Title";
//                                 HRSuccessionEmployee."Dimension 1 Code" := HREmp."Department Code";
//                                 HRSuccessionEmployee."Date of Join" := HREmp."Date Of Join";
//                                 HRSuccessionEmployee.Insert;

//                             end;


//                         until HREmp.Next = 0;


//                     end;








//                     /*
//                  //Clear entries in  HR Succesor Lines before re populating
//                  HRSuccessionEmployee.RESET;
//                  HRSuccessionEmployee.SETRANGE(HRSuccessionEmployee."Position to Succeed","Job ID");
//                  IF HRSuccessionEmployee.FIND('-') THEN HRSuccessionEmployee.DELETEALL;

//                  //Get job requirements
//                  HRJobRequirements.RESET;
//                  HRJobRequirements.SETRANGE(HRJobRequirements."Job ID","Job ID");
//                  HRJobRequirements.SETRANGE(HRJobRequirements.Mandatory,TRUE);
//                  IF HRJobRequirements.FIND('-') THEN
//                  BEGIN
//                      REPEAT
//                          //Check if employee qualifications match jus the Job requirements without the score
//                          HREmployeeQualifications.RESET;
//                          HREmployeeQualifications.SETRANGE(HREmployeeQualifications."Qualification Code",HRJobRequirements."Qualification Code");
//                          IF HREmployeeQualifications.FIND('-') THEN
//                          BEGIN
//                              //REPEAT
//                                  //Insert into HR Succesor Lines
//                                  HRSuccessionEmployee.RESET;

//                                  HRSuccessionEmployee.INIT;

//                                  HRSuccessionEmployee."Line No.":=fnGetLastLineNo;
//                                  HRSuccessionEmployee."Staff No.":=HREmployeeQualifications."Employee No.";
//                                  HRSuccessionEmployee.VALIDATE(HRSuccessionEmployee."Staff No.");
//                                  HRSuccessionEmployee."Position to Succeed":="Job ID";

//                                  HRSuccessionEmployee.INSERT;

//                             // UNTIL HREmployeeQualifications.NEXT =0;
//                          END;
//                      UNTIL HRJobRequirements.NEXT =0;
//                      MESSAGE('Process Complete');
//                  END;

//                  //HRSuccessionEmployee.RESET;
//                  //HRSuccessionEmployee.SETRANGE(HRSuccessionEmployee."Position to Succeed","Job ID");
//                  //IF HRSuccessionEmployee.FIND('-') THEN HRSuccessionEmployee.DELETEALL;

//                  //HREmployeeQualifications.RESET;
//                  //IF HREmployeeQualifications.FIND('-') THEN
//                  //BEGIN
//                  //    REPEAT
//                  //        //Searh Job Requirments for this qualification
//                  //        HRJobRequirements.RESET;
//                  //        HRJobRequirements.SETRANGE(HRJobRequirements."Qualification Code",HREmployeeQualifications."Qualification Code");
//                  //        //HRJobRequirements.SETRANGE(HRJobRequirements.Mandatory,true);
//                  //        HRJobRequirements.SETRANGE(HRJobRequirements."Job ID","Job ID");
//                  //        IF HRJobRequirements.FIND('-') THEN
//                  //        BEGIN
//                  //            HREmployeeQualifications_2.reset;
//                  //            HREmployeeQualifications_2.setrange();
//                  //            //Insert into HR Succesor Lines
//                  //            HRSuccessionEmployee.RESET;
//                  //
//                  //            HRSuccessionEmployee.INIT;

//                  //            HRSuccessionEmployee."Line No.":=fnGetLastLineNo;
//                  //            HRSuccessionEmployee."Staff No.":=HREmployeeQualifications."Employee No.";
//                  //            HRSuccessionEmployee.VALIDATE(HRSuccessionEmployee."Staff No.");
//                  //            HRSuccessionEmployee."Position to Succeed":="Job ID";

//                  //            HRSuccessionEmployee.INSERT;
//                  //        END;
//                  //     UNTIL HREmployeeQualifications.NEXT =0;
//                  //     MESSAGE('Process Complete');
//                  //END;
//                       */

//                 end;
//             }
//         }
//     }

//     var
//         HREmp: Record "HR Employees";
//         EmpJobDesc: Text[50];
//         HRJobs: Record "HR Jobs";
//         SupervisorName: Text[60];
//         //SMTP: Codeunit "SMTP Mail";
//         URL: Text[500];
//         HRSetup: Record "HR Setup";
//         EmpDept: Text[30];
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,Contract,Project,MR,Inves,PB,Prom,Ind,Conf,BSC,OT,Jobsucc,SuccDetails;
//         //ApprovalEntries: Page "Approval Entries";
//         HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
//         EmpName: Text[70];
//         ApprovalComments: Page "Approval Comments";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         UserSetup: Record "User Setup";
//         varDaysApplied: Integer;
//         ReturnDateLoop: Boolean;
//         mSubject: Text[250];
//         ApplicantsEmail: Text[30];
//         "LineNo.": Integer;
//         sDate: Record Date;
//         Customized: Record "HR Leave Calendar";
//         HREmailParameters: Record "HR E-Mail Parameters";
//         HRJournalBatch: Record "HR Leave Journal Batch";
//         HRJobRequirements: Record "HR Job Requirements";
//         HREmployeeQualifications: Record "HR Employee Qualifications";
//         HRSuccessionEmployee: Record "HR Succession Employee";
//         HREmployeeQualifications_2: Record "HR Employee Qualifications";
//         DesiredScore: Decimal;
//         HREmployeeCompetency: Record "HR Employee Competence";
//         countcompetence: Integer;
//         sumcompetence: Decimal;
//         Rescompetence: Decimal;
//         countqulify: Integer;
//         sumqulify: Decimal;
//         Resqulify: Decimal;
//         countjreq: Integer;
//         sumjreq: Decimal;
//         resjreq: Decimal;
//         TotalScore: Decimal;
//         LNo: Integer;

//     local procedure fnGetLastLineNo() LastLineNum: Integer
//     var
//         HRSuccessionEmployee_2: Record "HR Succession Employee";
//     begin
//         HRSuccessionEmployee_2.Reset;
//         if HRSuccessionEmployee_2.Find('+') then begin
//             LastLineNum := HRSuccessionEmployee_2."Line No." + 1;
//         end else begin
//             LastLineNum := 1000;
//         end;
//     end;
// }

