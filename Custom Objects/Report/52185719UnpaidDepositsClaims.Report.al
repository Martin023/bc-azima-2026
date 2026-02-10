#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185719 "Unpaid Deposits Claims"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Unpaid Deposits Claims.rdl';

    dataset
    {
        dataitem("Member withdrawal Notice"; "Member withdrawal Notice")
        {
            DataItemTableView = where(Status = const(Approved));
            RequestFilterFields = "Maturity Date", "Withdrawal Notice Date";
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
            column(NoticeType; "Member withdrawal Notice"."Notice Type")
            {
            }
            column(LoansOutstandingBalance; "Member withdrawal Notice"."Loans Outstanding Balance")
            {
            }
            column(LoansOutstandingInterest; "Member withdrawal Notice"."Loans Outstanding Interest")
            {
            }
            column(MemberDeposit; "Member withdrawal Notice"."Member Deposit")
            {
            }
            column(Name; "Member withdrawal Notice".Name)
            {
            }
            column(WithdrawaNoticelDate; "Member withdrawal Notice"."Withdrawal Notice Date")
            {
            }
            column(MaturityDate; "Member withdrawal Notice"."Maturity Date")
            {
            }
            column(No; "Member withdrawal Notice"."No.")
            {
            }
            column(MemberNo; "Member withdrawal Notice"."Member No.")
            {
            }
            column(Refundable; Refundable)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "SNo." += 1;
                Refundable := 0;
                Membershipclosure."No." := '';
                Membershipclosure.Reset;
                Membershipclosure.SetRange("Notice Number", "Member withdrawal Notice"."No.");
                Membershipclosure.SetRange(Posted, true);
                if Membershipclosure.Find('-') then
                    CurrReport.Skip;
                Refundable := "Member withdrawal Notice"."Member Deposit" - ("Member withdrawal Notice"."Loans Outstanding Balance" + "Member withdrawal Notice"."Loans Outstanding Interest");
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
        Membershipclosure: Record "Membership closure";
        Refundable: Decimal;
}
