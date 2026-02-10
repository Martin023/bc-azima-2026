#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185839 "Case Status Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Case Status Report.rdl';
    Caption = 'Case Status Report';

    dataset
    {
        dataitem(Legal; Legal)
        {

            column(CaseNumber_Legal; Legal."Case Number")
            {
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(DateofComplaint_Legal; Legal."Date of Filing the suit")
            {
            }
            column(TypeComplaint_Legal; Legal."Type of Complainant")
            {
            }
            column(RecommendedAction_Legal; Legal."Recommended Action")
            {
            }
            column(DescriptionofComplaint_Legal; Legal."Description of Complaint")
            {
            }
            column(Reporter_Legal; Legal.Reporter)
            {
            }
            column(Witness1_Legal; Legal.Witness)
            {
            }
            column(Witness2_Legal; Legal."Witness #2")
            {
            }
            column(ActionTaken_Legal; Legal."Action Taken")
            {
            }
            column(DateToDiscussCase_Legal; Legal."Date To Discuss Case")
            {
            }
            column(DisciplinaryRemarks_Legal; Legal."Disciplinary Remarks")
            {
            }
            column(Comments_Legal; Legal.Comments)
            {
            }
            column(CaseDiscussion_Legal; Legal."Case Discussion")
            {
            }
            column(BodyHandlingTheComplaint_Legal; Legal."Body Handling The Complaint")
            {
            }
            column(Recomendations_Legal; Legal.Recomendations)
            {
            }
            column(NoSeries_Legal; Legal."No. Series")
            {
            }
            column(AccusedEmployee_Legal; Legal."Accused Employee")
            {
            }
            column(PolicyDescription_Legal; Legal."Policy Description")
            {
            }
            column(TakenActionDescription_Legal; Legal."Taken Action Description")
            {
            }
            column(ResponsibilityCenter_Legal; Legal."Responsibility Center")
            {
            }
            column(ReporterName_Legal; Legal."Reporter Name")
            {
            }
            column(Witness1Name_Legal; Legal."Witness #1 Name")
            {
            }
            column(Witness2Name_Legal; Legal."Witness #2  Name")
            {
            }
            column(DocumentType_Legal; Legal."Legal Type")
            {
            }
            column(UserID_Legal; Legal."User ID")
            {
            }
            column(AccusedEmployeeName_Legal; Legal."Accused Name")
            {
            }
            column(ActionDurationStartDate_Legal; Legal."Action Duration Start Date")
            {
            }
            column(ActionDurationEndDate_Legal; Legal."Action Duration End  Date")
            {
            }
            column(Status_Legal; Legal.Status)
            {
            }
            column(PlaintiffType_Legal; Legal."Plaintiff Type")
            {
            }
            column(Plaintiff_Legal; Legal.Plaintiff)
            {
            }
            column(Name_Legal; Legal.Name)
            {
            }
            column(AccusedType_Legal; Legal."Accused Type")
            {
            }
            column(TotalCost_Legal; Legal."Total Cost")
            {
            }
            column(CaseLevel_Legal; Legal."Case Status")
            {
            }
            column(Appealed_Legal; Legal.Appealed)
            {
            }
            // column(CaseVerdict_Legal; Legal."Case Verdict")
            // {
            // }
            column(ReporterType_Legal; Legal."Reporter Type")
            {
            }
            column(BodyName_Legal; Legal."Body Name")
            {
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
}
