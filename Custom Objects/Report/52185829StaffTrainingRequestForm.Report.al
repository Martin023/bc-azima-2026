#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185829 "Staff Training Request Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Staff Training Request Form.rdl';

    dataset
    {
        dataitem("HR Training App Header"; "HR Training App Header")
        {
            DataItemTableView = sorting("Application No");
            RequestFilterFields = "Application No";
            column(ReportForNavId_1; 1)
            {
            }
            column(ApplicationNo_HRTrainingAppHeader; "HR Training App Header"."Application No")
            {
            }
            column(Createdby_HRTrainingAppHeader; "HR Training App Header"."Created by")
            {
            }
            column(NoSeries_HRTrainingAppHeader; "HR Training App Header"."No. Series")
            {
            }
            column(ApplicationDate_HRTrainingAppHeader; "HR Training App Header"."Application Date")
            {
            }
            column(CourseTitle_HRTrainingAppHeader; "HR Training App Header"."Course Title")
            {
            }
            column(CourseDescription_HRTrainingAppHeader; "HR Training App Header"."Course Description")
            {
            }
            column(NoofParticipants_HRTrainingAppHeader; "HR Training App Header"."No. of Participants")
            {
            }
            column(StartDate_HRTrainingAppHeader; "HR Training App Header"."Start Date")
            {
            }
            column(EndDate_HRTrainingAppHeader; "HR Training App Header"."End Date")
            {
            }
            column(Duration_HRTrainingAppHeader; "HR Training App Header".Duration)
            {
            }
            column(ResponsibilityCenter_HRTrainingAppHeader; "HR Training App Header"."Responsibility Center")
            {
            }
            column(Status_HRTrainingAppHeader; "HR Training App Header".Status)
            {
            }
            column(TrainingInstitution_HRTrainingAppHeader; "HR Training App Header"."Training Institution")
            {
            }
            column(TrainingVenue_HRTrainingAppHeaders; "HR Training App Header"."Training Venue")
            {
            }
            column(TrainingCostCstimated_HRTrainingAppHeader; "HR Training App Header"."Training Cost Cstimated")
            {
            }
            column(BondedTraining_HRTrainingAppHeader; "HR Training App Header"."Bonded Training?")
            {
            }
            column(GlobalDimension1Code_HRTrainingAppHeader; "HR Training App Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRTrainingAppHeader; "HR Training App Header"."Global Dimension 2 Code")
            {
            }
            column(TrainingStatus_HRTrainingAppHeader; "HR Training App Header"."Training Status")
            {
            }
            column(ActualStartDate_HRTrainingAppHeader; "HR Training App Header"."Actual Start Date")
            {
            }
            column(ActualDuration_HRTrainingAppHeader; "HR Training App Header"."Actual Duration")
            {
            }
            column(ActualEndDate_HRTrainingAppHeader; "HR Training App Header"."Actual End Date")
            {
            }
            column(Courseapplying_HRTrainingAppHeader; "HR Training App Header"."Course applying")
            {
            }
            column(Justification_HRTrainingAppHeader; "HR Training App Header".Justification)
            {
            }
            // column(Picture;CI.Picture)
            // {
            // }
            dataitem("HR Training App Lines"; "HR Training App Lines")
            {
                DataItemLink = "Application No." = field("Application No");
                column(ReportForNavId_32; 32)
                {
                }
                column(LineNo; HRTrainingAppLines."Line No.")
                {
                }
                column(AppNo; HRTrainingAppLines."Application No.")
                {
                }
                column(EmpNo; HRTrainingAppLines."Employee No.")
                {
                }
                column(Names; HRTrainingAppLines.Name)
                {
                }
                column(Title; HRTrainingAppLines."Job Title")
                {
                }
                column(Email; HRTrainingAppLines."Participant Email")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("Application No");
                DataItemTableView = sorting("Table ID", "Document Type", "Document No.", "Sequence No.");
                column(ReportForNavId_46; 46)
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = field("Approver ID");
                    DataItemTableView = sorting("User ID");
                    column(ReportForNavId_43; 43)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    "Approval Entry".SetRange("Approval Entry".Status, "Approval Entry".Status::Approved)
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HRTrainingAppLines: Record "HR Training App Lines";
}
