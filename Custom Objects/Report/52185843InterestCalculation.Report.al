#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185843 "Interest Calculation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Outstanding Interest" = filter(< 0));

            column(ReportForNavId_1; 1)
            {
            }
            column(No_; "No.")
            {
            }
            column(Balance; Balance)
            {
            }
            column(Balance__LCY_; "Balance (LCY)")
            {
            }
            column(Balance_Due; "Balance Due")
            {
            }
            column(Balance_Due__LCY_; "Balance Due (LCY)")
            {
            }
            column(Name; Name)
            {
            }
            column(Date_Filter; "Date Filter")
            {
            }
            column(Outstanding_Interest; "Outstanding Interest")
            {
            }
            column(Member_No_; "Member No.")
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;
    // begin
    //     CI.Get;
    //     CI.CalcFields(Picture);
    // end;

    var
        CI: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
