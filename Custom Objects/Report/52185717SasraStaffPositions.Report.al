#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185717 "Sasra Staff Positions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sasra Staff Positions.rdl';

    dataset
    {
        dataitem("User Setup"; "User Setup")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(UserID_UserSetup; "User Setup"."User ID")
            {
            }
            column(UserBranchID; "User Setup"."Global Dimension 2 Code")
            {
            }
            column(UserName; UserName)
            {
            }
            column(UserPosition; UserPosition)
            {
            }
            column(UserBranchName; UserBranchName)
            {
            }
            column(UserDepartment; "User Setup"."Responsibility Centre")
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
            column(SNo; "SNo.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "SNo." += 1;
                UserName := '';
                UserBranchName := '';
                UserPosition := '';
                HREmployees.Reset;
                HREmployees.SetRange("User ID", "User Setup"."User ID");
                if HREmployees.Find('-') then begin
                    UserName := HREmployees."Full Name";
                    UserPosition := HREmployees."Job Title";
                end;

                DimensionValue.Reset;
                DimensionValue.SetRange(Code, "User Setup"."Global Dimension 2 Code");
                if DimensionValue.Find('-') then begin
                    UserBranchName := DimensionValue.Name;
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
        UserName: Text;
        UserPosition: Text;
        UserBranchName: Text;
        HREmployees: Record "HR Employees";
        DimensionValue: Record "Dimension Value";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        "SNo.": Integer;
}
