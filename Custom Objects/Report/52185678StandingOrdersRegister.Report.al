#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185678 "Standing Orders Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Standing Orders Register.rdl';

    dataset
    {
        dataitem("Standing Order Register"; "Standing Order Register")
        {
            RequestFilterFields = "Source Account No.", "Standing Order No.", "No.";
            column(ReportForNavId_1; 1)
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
            column(No; "Standing Order Register"."Document No.")
            {
            }
            column(SourceAccount; "Standing Order Register"."Source Account No.")
            {
            }
            column(SourceName; "Standing Order Register"."Source Account Name")
            {
            }
            column(StaffNo; "Standing Order Register"."Staff/Payroll No.")
            {
            }
            column(MemberNo; "Standing Order Register"."Member No")
            {
            }
            column(DeductionStatus; "Standing Order Register"."Deduction Status")
            {
            }
            column(Amount; "Standing Order Register".Amount)
            {
            }
            column(AmountDeducted; "Standing Order Register"."Amount Deducted")
            {
            }
            column(EfectiveStartDate; "Standing Order Register"."Effective/Start Date")
            {
            }
            column(Duration; "Standing Order Register".Duration)
            {
            }
            column(EndDate; "Standing Order Register"."End Date")
            {
            }
            column(DestinationType; "Standing Order Register"."Destination Account Type")
            {
            }
            column(Remarks; "Standing Order Register".Remarks)
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CAddress; CompanyInformation.Address)
            {
            }
            column(CPicture; CompanyInformation.Picture)
            {
            }
            column(DateProcessed; "Standing Order Register"."Date Processed")
            {
            }
            column(Branch; "Standing Order Register"."Branch Code")
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

    // trigger OnPreReport()
    // begin
    //     CompanyInformation.Get;
    //     CompanyInformation.CalcFields(Picture);
    // end;
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var

        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
