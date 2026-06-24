namespace KenpipeCBS.KenpipeCBS;
using System.Security.User;
using Microsoft.Foundation.NoSeries;
using System.Utilities;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Company;
using System.Environment;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Purchases.Vendor;
using System.Automation;
using MNSProjectMwanga.MNSProjectMwanga;

page 52186773 "Loans card"
{
    Caption = 'Loans card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,History,Loan File,Cancellation,Category7_caption,Reopen Document,Approval request,EDMS,CRB - Metropol';
    SourceTable = Loans;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Span"; Rec."Loan Span")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("New Interest Rate"; Rec."New Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("New No. of Installment"; Rec."New No. of Installment")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Rescheduled"; Rec."Loan Rescheduled")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Disbursement Account No"; Rec."Disbursement Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("CRM Captured by"; Rec."CRM Captured by")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Appraised By"; Rec."Loan Appraised By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = all;
                }
                field("Reversed"; Rec."Reversed")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Activity';
                    Editable = false;
                }
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Source Unit';
                    Editable = false;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Amount In Arreas SACCO"; Rec."Amount In Arreas SACCO")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount In Arreas SASRA"; Rec."Amount In Arreas SASRA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Installments FallOff"; Rec."Installments FallOff")
                {
                    Editable = false;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Transferred"; Rec."Loan Transferred")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Principal';
                    Editable = false;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Variated Amount"; Rec."Variated Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Variated By"; Rec."Variated By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    Editable = false;
                }
                field("Employer Loan No."; Rec."Employer Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Balance"; Rec."Employer Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Sub Sector Level2"; Rec."Sub Sector Level2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Purpose';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Moratorium Loan"; Rec."Moratorium Loan")
                {
                    ApplicationArea = all;
                    Editable = false;

                }

                field("Moratorium Start Date"; Rec."Moratorium Start Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Moratorium Date date"; Rec."Moratorium End date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    Editable = false;
                }

            }
            group("Sectoral Classification")
            {
                Caption = 'Sectoral Classification';
                Editable = false;
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Sector Level1"; Rec."Sub Sector Level1")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(SubSectorLevel2; Rec.SubSectorLevel2)
                // {
                //     Caption = 'Sub Sector Level2';

                //     trigger OnValidate()
                //     begin
                //         SubSectorLevel2 := "Sub Sector Level2";
                //     end;
                // }
                field("Main Sector Description"; Rec."Main Sector Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Sector Level1 Description"; Rec."Sub Sector Level1 Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Sector Level2 Description"; Rec."Sub Sector Level2 Description")
                {
                    ApplicationArea = Basic, Suite;
                }
            }


            group("Hybrid Details")
            {
                Caption = 'Hybrid Details';
                Editable = False;


                field("Salary Amount"; Rec."Salary Amount")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Checkoff Amount"; Rec."Checkoff Amount")
                {
                    ApplicationArea = Basic, Suite;

                }
            }
            group("Trail Information")
            {
                Caption = 'Trail Information';
                Editable = false;
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Application Time"; Rec."Application Time")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Approval Date."; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Approval Time"; Rec."Approval Time")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Disbursement Date."; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("disbursement time"; Rec."disbursement time")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
            }
            group("External STO Details")
            {
                Caption = 'External STO Details';
                Editable = false;
                field("Client Bank Code"; Rec."Client Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("Client Bank Name"; Rec."Client Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Client Account No"; Rec."Client Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("External STO  Amount"; Rec."External STO  Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External STO Effective Date"; Rec."External STO Effective Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ShowMandatory = true;
                }
            }
            group("Shamba Loan Mandatory Requirements")
            {
                Caption = 'Shamba Loan Mandatory Requirements';
                Editable = false;
                Visible = IsShambaLoan;
                field("Sale Agreement"; Rec."Sale Agreement")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("20% Payment Slip"; Rec."20% Payment Slip")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Land Valuation Done"; Rec."Land Valuation Done")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Title Deed"; Rec."Title Deed")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Default and Recovery")
            {
                Caption = 'Default and Recovery';
                Editable = false;
                field("Recovered Loan"; Rec."Recovered Loan")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the loan where this loan came from, i.e if this loan is a guarantor defaulter loan';
                }
                field("Recovery Level"; Rec."Recovery Level")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of times a loan has been defaulted and recovered';
                }
                field(Defaulted; Rec.Defaulted)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether a loan has been defaulted and recovered';
                }
                field("Loan Recovery No."; Rec."Loan Recovery No.")
                {

                }
                field("Principle With Guarantors"; Rec."Principle With Guarantors")
                {
                    Editable = false;
                }
                field("Interest With Guarantors"; Rec."Interest With Guarantors")
                {
                    Editable = false;
                }
                field("Attachmnet Reversed"; Rec."Attachmnet Reversed")
                {
                    Editable = false;
                }

            }
            // part(Control38; "Loans Approval Entries")
            // {
            //     SubPageLink = "Primary Rec" = FIELD("Loan No.");
            //     ApplicationArea = Basic, Suite;
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generate Repayment  Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                    LoanProcess: Codeunit "Loans Process";
                begin
                    //Delete schedule



                    // LoanRescheduling.Reset;
                    // LoanRescheduling.SetRange(LoanRescheduling."Loan No.", Rec."Loan No.");
                    // LoanRescheduling.SetRange(LoanRescheduling.Rescheduled, true);
                    // if not LoanRescheduling.Find('-') then begin
                    LRepaymentSchedule.Reset;
                    LRepaymentSchedule.SetRange(LRepaymentSchedule."Loan No.", Rec."Loan No.");
                    if LRepaymentSchedule.Find('-') then LRepaymentSchedule.DeleteAll;
                    LoanProcess.GenerateSchedule(Rec, True);
                    // end;
                    //Check if Ever Rescheduled.
                    LoanRescheduling.Reset;
                    LoanRescheduling.SetRange(LoanRescheduling."Loan No.", Rec."Loan No.");
                    LoanRescheduling.SetRange(LoanRescheduling.Rescheduled, true);
                    if LoanRescheduling.Find('-') then begin
                        LRepaymentSchedule.Reset;
                        LRepaymentSchedule.SetRange(LRepaymentSchedule."Loan No.", LoanRescheduling."Loan No.");
                        LRepaymentSchedule.SetRange("Repayment Date", CalcDate('<CM-1M+1D>', LoanRescheduling."Rescheduling Date"), 99991230D);
                        if LRepaymentSchedule.Find('-') then LRepaymentSchedule.DeleteAll;
                        repeat
                            LoanProcess.GenerateSchedule(Rec, True);
                        // GetNewRepayment(LoanRescheduling."No.");
                        until LoanRescheduling.Next = 0;
                    end;

                    Commit;

                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        REPORT.Run(Report::"Ideal Repayment Schedule", true, true, LoanApp);
                end;
            }

            action("View  Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewWorksheet;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                    LoanProcess: Codeunit "Loans Process";
                    Rschedule: Record "Ideal Repayment Schedule";
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        REPORT.Run(Report::"Ideal Repayment Schedule", true, true, LoanApp);
                end;
            }
            action("Update Actual Schedule")
            {
                ApplicationArea = all;
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ActualSchedule: Codeunit ActualLoanSchedule;
                begin
                    ActualSchedule.GenerateLoanSchedule(Rec);
                    Message('Actual Schedule updated successfully');
                    // LoanApp.Reset;
                    // LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    // if LoanApp.Find('-') then
                    //     REPORT.Run(Report::"Actual Loan Schedule", true, true, LoanApp);
                end;
            }
            action("View Actual Schedule")
            {
                ApplicationArea = all;
                Image = ViewPage;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ActualSchedule: Codeunit ActualLoanSchedule;
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        REPORT.Run(Report::"Actual Loan Schedule", true, true, LoanApp);
                end;
            }
            // action("Capitalize Interest")
            // {
            //     ApplicationArea = all;
            //     Image = SuggestFinancialCharge;
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //         LoansProcessing: Codeunit "Loans Process";
            //     begin
            //         if not Confirm('Are you sure you want to capitalize this interest?') then exit;
            //         LoansProcessing.PostCapitalizedInterestDMU(Rec."Loan No.", Rec."Loan No.");
            //         message('Entries Capitalized Succesfully.');

            //     end;
            // }

            action(UpdateRepayMode)
            {
                ApplicationArea = Basic, Suite;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Update Repayment Mode';

                trigger OnAction()
                begin
                    report.run(Report::"Update Loan Repayment Mode", true, false, Rec);
                end;
            }
            action("Repayment Method")
            {
                ApplicationArea = Basic, Suite;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Payment Method";
                RunPageLink = "Loan No." = FIELD("Loan No."),
                              "Member No." = FIELD("Member No.");

                trigger OnAction()
                begin
                    /*
                    IF "Appraisal Parameter Type"="Appraisal Parameter Type"::"Check Off" THEN BEGIN
                      RepMethods.RESET;
                      RepMethods.SETRANGE("Loan No.","Loan No.");
                        IF NOT RepMethods.FIND('-') THEN BEGIN
                           RepMethods."Loan No.":="Loan No.";
                           RepMethods.Amount:=Repayment;
                           RepMethods."Member No.":="Member No.";
                           RepMethods."Payment Method":=RepMethods."Payment Method"::Checkoff;
                           RepMethods.INSERT;
                        END;
                    END;
                    */

                end;
            }
            separator(Action29)
            {
            }
            action("Guarantors & Security")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Guarantors& Security';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Guarantors and Security";
                RunPageLink = "Loan No" = FIELD("Loan No.");
            }
            action("Other Commitments Clearance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Other Commitments/Loan Takeoff.';
                Image = Cost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan No." = FIELD("Loan No.");
            }

            action("Loan [File]")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                var
                    DMS: Record EDMS;
                begin
                    DMS.Reset;
                    DMS.SetRange(DMS.Key, DMS.Key::"Loan File");
                    if DMS.Find('-') then begin
                        HyperLink(DMS."url path" + Rec."Loan No.");
                    end;
                end;
            }
            // action("Prorata")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = PaymentForecast;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Member Prorata";
            //     RunPageLink = "Loan No" = FIELD("Loan No.");
            // }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    //ApprovalEntries: Page "Approval Entries";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Loans Topped Up")
            {
                ApplicationArea = Basic, Suite;
                Image = Archive;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Loan Top Up";
                RunPageLink = "Loan No." = FIELD("Loan No."),
                              "Client Code" = FIELD("Member No.");

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    //if LoanApp.Find('-') then
                    //REPORT.Run(52185995, true, true, LoanApp);
                end;
            }
            action("Loan Appraisal Comments")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageLink = "Loan No." = FIELD("Loan No.");
                RunObject = Page "52187231Loan Appr. Comments";
            }

            action("Charge Excemptions.")
            {
                ApplicationArea = all;
                Image = Note;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Excempted Product Charges";
                RunPageLink = "Loan No." = field("Loan No.");//, "Product Code" = field("Loan Product Type");
                RunPageMode = View;
            }


            action("External Loans Cleared")
            {
                ApplicationArea = Basic, Suite;
                Image = Archive;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    //if LoanApp.Find('-') then
                    //REPORT.Run(52185996, true, true, LoanApp);
                end;
            }

            action("Capitalize Daily Interest")
            {
                ApplicationArea = Basic, Suite;
                Image = CalculateRemainingUsage;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LoanApp: Record Loans;
                    LoansProcess: Codeunit "Loans Process";
                begin
                    Rec.CalcFields("Daily Interest");
                    IF NOT CONFIRM('Are you sure you want to capitalized daily interest of ' + Format(Rec."Daily Interest") + ' for this loan?') then exit;
                    LoansProcess.CapitalizeDailyInterest(Rec."Loan No.");
                end;
            }
            action("Salary Details")
            {
                ApplicationArea = Basic, Suite;
                Image = StatisticsGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Appraisal Salary Details.";
                RunPageLink = "Loan No" = FIELD("Loan No."),
                              "Client Code" = FIELD("Member No.");
                RunPageMode = View;

                trigger OnAction()
                begin
                    /*//Load defaults
                    AppraisalDetailsSetup.RESET;
                    IF AppraisalDetailsSetup.FIND('-') THEN BEGIN
                      REPEAT
                        AppraisalSalDetails.RESET;
                        AppraisalSalDetails.SETRANGE(AppraisalSalDetails."Loan No","Loan No.");
                        AppraisalSalDetails.SETRANGE(AppraisalSalDetails.Type,AppraisalDetailsSetup.Type);
                        AppraisalSalDetails.SETRANGE(Code,AppraisalDetailsSetup.Code);
                    
                        IF AppraisalSalDetails.FIND('-') THEN
                          EXIT;
                        AppraisalSalDetails.INIT;
                        AppraisalSalDetails."Loan No":="Loan No.";
                        AppraisalSalDetails."Client Code":="Member No.";
                        AppraisalSalDetails.Code:=AppraisalDetailsSetup.Code;
                        AppraisalSalDetails.Description:=AppraisalDetailsSetup.Description;
                        AppraisalSalDetails.Type:=AppraisalDetailsSetup.Type;
                        AppraisalSalDetails.INSERT;
                      UNTIL AppraisalDetailsSetup.NEXT=0;
                    END;
                    */

                end;
            }
            separator(Action56)
            {
            }
            action("Partial Loan Disbursement Schedule")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Partial Loan Disbursement Schedule';
                Image = PutAwayWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Partial Disbursement Schedule";
                RunPageLink = "Loan No." = FIELD("Loan No.");
            }
            action("Download Appraisal Used")
            {
                ApplicationArea = Basic, Suite;
                Image = Download;
                Promoted = true;

                trigger OnAction()
                var
                    EDMS: Record EDMS;
                    Name: Text;
                    url: Text;
                    FromFile: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                    LoanNo: Text;
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    AppraisalRec: Record "Loan Appraisal";
                    PdfMimeType: Text[30];
                    InStreamVar: InStream;
                    ReportBlob: Codeunit "Temp Blob";

                begin
                    LoanNo := Rec."Loan No.";
                    //##############3
                    AppraisalRec.Get(LoanNo);
                    AppraisalRec.SetRange("Loan No.", LoanNo);
                    recRef.GetTable(AppraisalRec);
                    TempBlob.CreateOutStream(OutStr);
                    Report.SaveAs(
                        Report::"Appraisal Loan Report",
                        '',
                        ReportFormat::Pdf,
                        OutStr,
                        recRef);
                    FileName := LoanNo + ' Appraisal_Report_' + '.pdf';
                    // download the report
                    PdfMimeType := 'application/pdf';
                    TempBlob.CreateInStream(InStreamVar);
                    DownloadFromStream(InStreamVar, '', '', FileName, FileName);
                    // ##############################33

                end;
            }
            group("EDMS Integration")
            {
                Caption = 'EDMS Documents';
                // action("Import")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Import File';
                //     Promoted = true;
                //     PromotedCategory = New;
                //     Image = Import;

                //     trigger OnAction()
                //     var
                //         Base64Convert: Codeunit "Base64 Convert";
                //         TempBlob: Codeunit "Temp Blob";
                //         InStr: InStream;
                //         ApplicantMember: Record Members;

                //         EDMSFunctions: Codeunit "EDMS Functions";
                //         FileName: Text;
                //         FileContentsB64: Text;

                //         IDNumber: Text;
                //         ApplicationType: Label 'LA'; // Loan Application
                //         PFNumber: Text;
                //     begin
                //         if Rec."Loan No." <> '' then begin
                //             FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                //             TempBlob.CreateInStream(InStr);
                //             FileContentsB64 := Base64Convert.ToBase64(InStr);

                //             if FileContentsB64 <> '' then begin
                //                 ApplicantMember.Reset;

                //                 ApplicantMember.SetRange("No.", Rec."Member No.");

                //                 if ApplicantMember.FindFirst then begin
                //                     if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                //                         IDNumber := ApplicantMember."Primary Identification";
                //                     end else
                //                         if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                //                             IDNumber := ApplicantMember."Secondary Identification";
                //                         end else begin
                //                             IDNumber := ApplicantMember."Primary Identification";
                //                         end;

                //                     if ApplicantMember."Payroll/Staff No." <> '' then begin
                //                         PFNumber := ApplicantMember."Payroll/Staff No.";
                //                     end else begin
                //                         PFNumber := IDNumber;
                //                     end;

                //                     EDMSFunctions.EDMSLoanFileUpload(
                //                       IDNumber,
                //                         ApplicantMember.Name,
                //                         Rec."Loan Product Type Name",
                //                         PfNumber,
                //                         ApplicantMember."No.",
                //                         Rec."Loan No.",
                //                         Rec."Loan No.",
                //                         FileName,
                //                         FileContentsB64,
                //                         false
                //                     );
                //                 end;
                //             end;
                //         end else begin
                //             Error('Application No. is required for EDMS document upload');
                //         end;
                //     end;
                // }

                // DO NOT comment out this!
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = New;

                    RunObject = page "Channel Application Documents";
                    RunPageLink = "Application No." = field("Loan No.");
                }
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        SubSectorLevel2 := Rec."Sub Sector Level2";
    end;

    trigger OnOpenPage()
    var

    begin
        /*IF Posted=TRUE THEN
        CurrPage.EDITABLE:=FALSE;
        */
        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Shamba Loan" = true then
                IsShambaLoan := true
            else
                IsShambaLoan := false;
        end;

        CalculateLoanWithGuarantors();

    end;

    var
        LRepaymentSchedule: Record "Ideal Repayment Schedule";
        LoanRescheduling: Record "Loan Rescheduling";
        LoanProcess: Codeunit "Loans Process";
        UpdateMember: Codeunit "DCS Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GetScore: Codeunit "DCS Management";
        LoansR: Record Loans;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        RSchedule: Record "Ideal Repayment Schedule";
        LoanApp: Record Loans;
        PartialSched: Record "Partial Disbursement Schedule";
        AppraisalDetailsSetup: Record "Appraisal Salary Set-up";
        AppraisalSalDetails: Record "Appraisal Salary Details";
        LReq: Record "Loan Mandatory Requirements";
        LoanGua: Record "Loan Guarantors and Security";
        Coll: Record "Loan Collateral";
        Found: Boolean;
        SavAcc: Record "Savings Accounts";
        ApplDocs: Record "Product Documents";
        LoanReqDocs: Record "Loan Required Documents";
        BusinessIncome: Record "Business Income";
        SendSMS: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        Members: Record Members;
        LoansTopup: Record "Loans Top up";
        ExternalComm: Record "Other Commitements Clearance";
        TotalOffset: Decimal;
        ProdFac: Record "Product Factory";
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        PaymentMethods: Record "Payment Methods";
        LoanRepay: Decimal;
        RepMethods: Record "Payment Methods";
        CompInfo: Record "Company Information";
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        SubSectorLevel2: Code[10];
        GenSetup: Record "General Set-Up";
        IsShambaLoan: Boolean;


    local procedure GetNewRepayment(ReScheduleNo: Text)
    var
        ReschedulingList: Record "Loan Rescheduling";
        Loans: Record Loans;
        GeneralSetUp: Record "General Set-Up";
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        CreditAccounts: Record "Credit Accounts";
        ProdF: Record "Product Factory";
        Text0003: Label 'You can not reschedule more than the initial insatllment';
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
    begin
        //Check if Ever Rescheduled.
        ReschedulingList.Reset;
        ReschedulingList.SetRange(ReschedulingList."No.", ReScheduleNo);
        ReschedulingList.SetRange(ReschedulingList.Rescheduled, true);
        if ReschedulingList.Find('-') then begin
            Loans.Reset;
            Loans.SetRange(Loans."Loan No.", ReschedulingList."Loan No.");
            if Loans.Find('-') then begin
                GeneralSetUp.Get;

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                LoanRepaymentSchedule.SetRange("Repayment Date", CalcDate('<CM-1M+1D>', ReschedulingList."Rescheduling Date"), 99991230D);
                if LoanRepaymentSchedule.Find('-') then LoanRepaymentSchedule.DeleteAll;

                //Loans.CALCFIELDS("Outstanding Balance","Outstanding Interest");

                InterestRate := Loans.Interest;

                RepayPeriod := ReschedulingList."New Installments";
                LoanAmount := ReschedulingList."Outstanding Balance";
                LBalance := ReschedulingList."Outstanding Balance";
                RunDate := CalcDate('<CM>', ReschedulingList."Rescheduling Date");

                repeat
                    InstalNo := InstalNo + 1;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                        TotalMRepay := Round((InterestRate / 1200) / (1 - Power((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := Round(LBalance / 1200 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                        Loans.Repayment := LInterest + LPrincipal;
                    end;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 1200) * LoanAmount;
                        Loans.Repayment := LPrincipal;
                    end;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 1200) * LBalance;
                        Loans.Repayment := LPrincipal;
                    end;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" then begin
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                        LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                        Loans.Repayment := LPrincipal + LInterest;

                    end;
                    //Decrement the Balance
                    LBalance := LBalance - LPrincipal;

                    Evaluate(RepayCode, Format(InstalNo));

                    LoanRepaymentSchedule.Init;
                    LoanRepaymentSchedule."Repayment Code" := RepayCode;
                    LoanRepaymentSchedule."Loan No." := Loans."Loan No.";
                    LoanRepaymentSchedule."Loan Amount" := ReschedulingList."Outstanding Balance";
                    LoanRepaymentSchedule."Instalment No" := InstalNo;
                    LoanRepaymentSchedule."Repayment Date" := RunDate;
                    LoanRepaymentSchedule."Member No." := Rec."Member No.";
                    LoanRepaymentSchedule."Loan Category" := Loans."Loan Product Type";
                    LoanRepaymentSchedule."Monthly Repayment" := Round((LInterest + LPrincipal), 1, '>');
                    ;
                    LoanRepaymentSchedule."Monthly Interest" := LInterest;
                    LoanRepaymentSchedule."Principal Repayment" := LPrincipal;
                    LoanRepaymentSchedule."Reset Doc No." := ReschedulingList."No.";
                    LoanRepaymentSchedule."Reset Schedule" := true;
                    LoanRepaymentSchedule.Insert;

                    //Repayment Frequency
                    if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Quarterly then
                                    RunDate := CalcDate('1Q', RunDate);
                //Repayment Frequency

                until InstalNo = ReschedulingList."New Installments";

                if CreditAccounts.Get(Loans."Loan Account") then begin
                    if ProdF.Get(CreditAccounts."Product Type") then begin
                        if (ProdF."Nature of Loan Type" <> ProdF."Nature of Loan Type"::Defaulter) and
                           (ReschedulingList."Original Installments" < InstalNo) then
                            Error(Text0003);
                    end;
                end;
            end;
        end;
    end;

    local procedure CalculateLoanWithGuarantors()
    var
        GuarantorLoans: Record Loans;
        RecoveryHeader: Record "Loan Recovery Header";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
    begin
        GuarantorLoans.Reset();
        GuarantorLoans.SetRange("Recovered Loan", Rec."Loan No.");
        if GuarantorLoans.Find('-') then begin
            repeat
                RecoveryHeader.GetLoanBalances(GuarantorLoans."Loan No.", OutInt, OutBal, TotalBal);
                Rec."Interest With Guarantors" += OutInt;
                Rec."Principle With Guarantors" += OutBal;
            until GuarantorLoans.Next() = 0;
        end;

        if (Rec."Interest With Guarantors" + Rec."Principle With Guarantors") > 0 then
            Rec.Modify();
    end;
}

