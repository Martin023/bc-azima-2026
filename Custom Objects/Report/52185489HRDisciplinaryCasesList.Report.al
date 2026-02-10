#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185489 "HR Disciplinary Cases List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Disciplinary Cases List.rdl';

    dataset
    {
        dataitem("HR Disciplinary Cases NCA"; "HR Disciplinary Cases NCA")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Case Number", "Disciplinary Stage Status";
            column(ReportForNavId_6666; 6666)
            {
            }

            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(IDNo; IDNo)
            {

            }
            column(Name; Name)
            {

            }
            column(DisciplinaryRemarks_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Disciplinary Remarks")
            {
            }
            column(DisciplinaryStageStatus_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Disciplinary Stage Status")
            {
            }
            column(TakenActionDescription_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Taken Action Description")
            {
            }
            column(RecommendedActionDescription_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Recommended Action Description")
            {
            }
            // column(PolicyDescription_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Policy Description")
            // {
            // }
            column(BodyHandlingName_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Body Handling Name")
            {
            }
            column(DescriptionofComplaint_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Description of Complaint")
            {
            }
            column(TypeComplaint_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Type Complaint")
            {
            }
            column(AccusedEmployeeName_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Accused Employee Name")
            {
            }
            column(AccussedBy_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Accussed By")
            {
            }
            column(AccusedEmployee_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Accused Employee")
            {
            }
            column(CaseNumber_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Case Number")
            {
            }
            column(AccuserName_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Reporter Name")
            {
            }
            column(Accuser_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA".Reporter)
            {
            }
            column(Witness1Name_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #1 Name")
            {
            }
            column(Witness2Name_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #2  Name")
            {
            }
            column(Witness1_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #1")
            {
            }
            column(Witness2_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #2")
            {
            }
            column(Date_of_Complaint; "Date of Complaint")
            {

            }
            column(Status; Status)
            {

            }

            trigger OnAfterGetRecord()
            begin
                No := No + 1;
                hremp.reset();
                hremp.SetRange("No.", "HR Disciplinary Cases NCA"."Accused Employee");
                if hremp.find('-') then begin
                    IDNo := hremp."ID Number";
                    Name := hremp.fullname;

                end;
            end;
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Int: Integer;
        HR_Transport_RequisitionsCaptionLbl: label 'HR Transport Requisitions';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        TRANSPORT_REQUESTCaptionLbl: label 'TRANSPORT REQUEST';
        Travelling_Staff_DetailsCaptionLbl: label 'Travelling Staff Details';
        No: Integer;
        hremp: record "HR Employees";
        IDNo: integer;
        Name: text[150];
}
