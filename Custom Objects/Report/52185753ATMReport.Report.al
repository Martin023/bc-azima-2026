#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185753 "ATM Activation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/ATM Activation Report.rdl';

    dataset
    {
        dataitem("ATM Linking Applications"; "ATM Linking Applications")
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
            column(SNO; sno)
            {
            }
            column(ATMApplicationNo; "ATM Linking Applications"."No.")
            {
            }
            column(AccountNo; "ATM Linking Applications"."Account No")
            {
            }
            column(BranchCode; "ATM Linking Applications"."Branch Code")
            {
            }
            column(AccountTyp; "ATM Linking Applications"."Account Type")
            {
            }
            column(AccountName; "ATM Linking Applications"."Account Name")
            {
            }
            column(Address; "ATM Linking Applications".Address)
            {
            }
            column(CustomerId; "ATM Linking Applications"."Customer ID")
            {
            }
            column(RelationIndicator_ATMApplications; "ATM Linking Applications"."Relation Indicator")
            {
            }
            column(CardType; "ATM Linking Applications"."Card Type")
            {
            }
            column(RequestType; "ATM Linking Applications"."Request Type")
            {
            }
            column(ApplicationDate; "ATM Linking Applications"."Application Date")
            {
            }
            column(CardNo; "ATM Linking Applications"."Card No")
            {
            }
            column(DateIssued; "ATM Linking Applications"."Date Issued")
            {
            }
            column(Limit_ATMApplications; "ATM Linking Applications".Limit)
            {
            }
            column(TermsReadandUnderstood_ATMApplications; "ATM Linking Applications"."Terms Read and Understood")
            {
            }
            column(CardIssued; "ATM Linking Applications"."Card Issued")
            {
            }
            column(FormNo; "ATM Linking Applications"."Form No")
            {
            }
            column(SentToExternalFile_ATMApplications; "ATM Linking Applications"."Sent To External File")
            {
            }
            column(CardStatus; "ATM Linking Applications"."Card Status")
            {
            }
            column(DateActivated; "ATM Linking Applications"."Date Activated")
            {
            }
            column(DateFrozen; "ATM Linking Applications"."Date Frozen")
            {
            }
            column(ReplacementForCardNo; "ATM Linking Applications"."Replacement For Card No")
            {
            }
            column(PhoneNo; "ATM Linking Applications"."Phone No.")
            {
            }
            column(Collected; "ATM Linking Applications".Collected)
            {
            }
            column(DateCollected; "ATM Linking Applications"."Date Collected")
            {
            }
            column(CardIssuedBy; "ATM Linking Applications"."Card Issued By")
            {
            }
            column(Status; "ATM Linking Applications".Status)
            {
            }
            column(CardExpiryDate; "ATM Linking Applications"."Card Expiry Date")
            {
            }
            column(ResponsibilityCenter; "ATM Linking Applications"."Responsibility Center")
            {
            }
            column(ShortcutDimension1Code; "ATM Linking Applications"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "ATM Linking Applications"."Shortcut Dimension 2 Code")
            {
            }
            column(CardIssuedDate_ATMApplications; "ATM Linking Applications"."Card Issued Date")
            {
            }
            column(PINIssuedDate; "ATM Linking Applications"."PIN Issued Date")
            {
            }
            column(PINIssuedBy; "ATM Linking Applications"."PIN Issued By")
            {
            }
            column(LinkedDate; "ATM Linking Applications"."Linked Date")
            {
            }
            column(ATMLinked; "ATM Linking Applications"."ATM Linked")
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
            column(ATMDelinked; "ATM Linking Applications"."ATM Delinked")
            {
            }
            column(ATMDelinkedDate; "ATM Linking Applications"."ATM Delinked Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
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
        sno: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
