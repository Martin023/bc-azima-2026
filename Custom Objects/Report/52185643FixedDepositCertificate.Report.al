#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185643 "Fixed Deposit Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Fixed Deposit Certificate.rdl';

    dataset
    {
        dataitem("Fixed Deposit Contract"; "Fixed Deposit Contract")
        {
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
            column(SNo; "SNo.")
            {
            }
            column(CurrDate; Format(Today, 0, 4))
            {
            }
            column(FfixedDepositStatus; "Fixed Deposit Contract"."Fixed Deposit Status")
            {
            }
            column(Fixed_Deposit_Account_No_; "Fixed Deposit Contract"."Fixed Deposit Account No.")
            {
            }
            column(Fixed_Deposit_Amount; "Fixed Deposit Contract"."Fixed Deposit Amount")
            {
            }
            column(No_; "Fixed Deposit Contract"."No.")
            {
            }
            column(Expected_Maturity_Date; "Fixed Deposit Contract"."Expected Maturity Date")
            {
            }
            // column(BalanceLCY_SavingsAccounts; "Fixed Deposit Contract"."No.")
            // {
            // }
            column(Status; "Fixed Deposit Contract".Status)
            {
            }
            column(FD_Maturity_Date; "Fixed Deposit Contract"."FD Maturity Date")
            {
            }
            column(Fixed_Deposit_Type; "Fixed Deposit Contract"."Fixed Deposit Type")
            {
            }
            column(Fixed_Deposit_cert__no; "Fixed Deposit Contract"."Fixed Deposit cert. no")
            {
            }
            column(Neg__Interest_Rate; "Fixed Deposit Contract"."Neg. Interest Rate")
            {
            }
            column(Application_Date; "Fixed Deposit Contract"."Application Date")
            {
            }
            column(Name; "Fixed Deposit Contract".Name)
            {
            }
            column(Member_No_; "Fixed Deposit Contract"."Member No.")
            {
            }



            trigger OnAfterGetRecord()
            begin
                "SNo." += 1;
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        "SNo.": Integer;
}
