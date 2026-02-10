#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185860 "Reimburse Recalled Leave Days"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Reimburse Recalled Leave Days.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Application Code";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "HR Leave Application".DetermineIfIsNonWorking(NewReturnDate) then Error('Return date is not a working date');

                if NewReturnDate >= "HR Leave Application"."Return Date" then Error('New Return date must be less than the return date');

                if NewReturnDate <= "HR Leave Application"."Start Date" then Error('New Return date must be greater than the start date');
                RemainingDays := 0;
                while "HR Leave Application"."End Date" >= NewReturnDate do begin
                    if not "HR Leave Application".DetermineIfIsNonWorking(NewReturnDate) then
                        RemainingDays += 1;
                    NewReturnDate := CalcDate('1D', NewReturnDate);
                end;

                "HR Leave Application"."Days Applied" -= RemainingDays;

                "HR Leave Application"."Recall Date" := NewReturnDate;
                "HR Leave Application"."End Date" := NewReturnDate;
                "HR Leave Application"."Return Date" := NewReturnDate;
                "HR Leave Application".Validate("Days Applied");
                "HR Leave Application".Modify;

                HRLeaveCal.Reset;
                HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                if not HRLeaveCal.Find('-') then
                    Error('Leave Calendar not setup')
                else
                    CalenderCode := HRLeaveCal."Calendar Code";


                Message(Format(RemainingDays));


                JBatch := 'POSITIVE';
                JTemplate := 'LEAVE';


                LeaveGjline.SetRange("Journal Batch Name", JBatch);
                LeaveGjline.SetRange("Journal Template Name", JTemplate);
                if LeaveGjline.Find('-') then LeaveGjline.DeleteAll;

                LeaveGjline.Reset;
                LeaveGjline.SetRange("Journal Batch Name", JBatch);
                LeaveGjline.SetRange("Journal Template Name", JTemplate);
                if LeaveGjline.FindLast then
                    EntryNo := LeaveGjline."Line No." + 1;

                LeaveGjline.Init;
                LeaveGjline."Journal Template Name" := JTemplate;
                LeaveGjline."Journal Batch Name" := JBatch;
                LeaveGjline.Validate("Journal Batch Name");
                LeaveGjline."Line No." := EntryNo;
                LeaveGjline."Leave Calendar Code" := CalenderCode;
                LeaveGjline."Staff No." := "Applicant Staff No.";
                LeaveGjline."Staff Name" := Names;
                LeaveGjline."Leave Type" := "Leave Type";
                LeaveGjline."Leave Entry Type" := LeaveGjline."leave entry type"::Reimbursement;
                LeaveGjline."No. of Days" := RemainingDays;
                LeaveGjline.Description := 'Reimbursment of Recalled days [' + "HR Leave Application"."Application Code" + ']';
                LeaveGjline."Document No." := "Applicant Staff No.";
                LeaveGjline."Posting Date" := Today;
                LeaveGjline."Global Dimension 1 Code" := "Global Dimension 1 Code";
                LeaveGjline."Global Dimension 2 Code" := "Global Dimension 2 Code";
                LeaveGjline.Insert;

                LeaveGjline.Reset;
                LeaveGjline.SetRange("Journal Batch Name", JBatch);
                LeaveGjline.SetRange("Journal Template Name", JTemplate);
                if LeaveGjline.Find('-') then begin
                    Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveGjline);
                    Post := false;
                    Post := JournlPosted.PostedSuccessfully();
                    if Post then begin
                        //:=NewReturnDate;
                    end;
                    //"Recall Date":=RecallDate;
                    // "HR Leave Application"."New End Date":=NewEndDate;
                    // "HR Leave Application".MODIFY;
                    //MESSAGE('Successfully Transfered To Template %1 and Batch  %2 ',JTemplate,JBatch);



                    //Datesubtraction:=TODAY-"Start Date";
                    //RemainingDays:=DATE2DMY(TODAY-"Start Date",1);
                end;
            end;

            trigger OnPreDataItem()
            begin
                if (NewReturnDate) = 0D then Error('New return date must have a value');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(NewReturnDate; NewReturnDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'New Return Date';
                }

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LeaveGjline: Record "HR Leave Journal Line";
        JBatch: Code[10];
        JTemplate: Code[10];
        EntryNo: Integer;
        RemainingDays: Integer;
        NewReturnDate: Date;
        ApplicationCode: Code[30];
        HRLeaveApplication: Record "HR Leave Application";
        EndDate: Date;
        CalenderCode: Code[30];
        HRLeaveCal: Record "HR Leave Calendar";
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";
}
