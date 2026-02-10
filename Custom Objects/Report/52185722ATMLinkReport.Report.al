#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185722 "ATM Link Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/ATM Link Report.rdl';

    dataset
    {
        dataitem("ATM Linking Applications"; "ATM Linking Applications")
        {
            RequestFilterFields = "Account No", "Card Issued", "Card Issued By", "Card No";
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
            column(No; "ATM Linking Applications"."No.")
            {
            }
            column(CardIssued; "ATM Linking Applications"."Card Issued")
            {
            }
            column(RequestType; "ATM Linking Applications"."Request Type")
            {
            }
            column(CardType_ATMLinkingApplications; "ATM Linking Applications"."Card Type")
            {
            }
            column(ApplicationDate; "ATM Linking Applications"."Application Date")
            {
            }
            column(CustomerID; "ATM Linking Applications"."Customer ID")
            {
            }
            column(AccountNo; "ATM Linking Applications"."Account No")
            {
            }
            column(BranchCode; "ATM Linking Applications"."Branch Code")
            {
            }
            column(AccountType; "ATM Linking Applications"."Account Type")
            {
            }
            column(AccountName; "ATM Linking Applications"."Account Name")
            {
            }
            column(CardIssuedBy; "ATM Linking Applications"."Card Issued By")
            {
            }
            column(PINIssued; "ATM Linking Applications"."PIN Issued")
            {
            }
            column(LinkedBy; "ATM Linking Applications"."Linked By")
            {
            }
            column(DelinkedBy; "ATM Linking Applications"."Delinked By")
            {
            }
            column(PostedBy; "ATM Linking Applications"."Posted By.")
            {
            }
            column(CardType; "ATM Linking Applications"."Card Type")
            {
            }
            column(CardNo; "ATM Linking Applications"."Card No")
            {
            }
            column(ReplacementForCardNo; "ATM Linking Applications"."Replacement For Card No")
            {
            }
            column(CardIssuedDate; "ATM Linking Applications"."Card Issued Date")
            {
            }
            column(PINIssuedDate; "ATM Linking Applications"."PIN Issued Date")
            {
            }
            column(CapturedBy; "ATM Linking Applications"."Captured By")
            {
            }
            column(PINIssuedBy; "ATM Linking Applications"."PIN Issued By")
            {
            }
            column(LinkedDate; "ATM Linking Applications"."Linked Date")
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
