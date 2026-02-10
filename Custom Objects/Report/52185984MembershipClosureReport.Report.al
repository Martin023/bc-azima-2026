#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

Report 52185984 "Membership Closure Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Membership Closure Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        //dataitem(52185824;52185824)
        dataitem("Membership Closure"; "Membership Closure")
        {
            RequestFilterFields = "Member No.", Status, "Maturity Date", "Closure Type";

            column(ReportForNavId_1; 1)
            {
            }
            column(No; "Membership closure"."No.")
            {
            }
            column(MemberNo; "Membership closure"."Member No.")
            {
            }
            column(MemberName; "Membership closure"."Member Name")
            {
            }
            column(mp; "Membership Closure"."Staff No.")
            {

            }
            column(ClosingDate; "Membership closure"."Closing Date")
            {
            }
            column(TotalLoan; "Membership closure"."Total Loan")
            {
            }
            column(TotalInterest; "Membership closure"."Total Interest")
            {
            }
            column(MemberSavings; "Membership closure"."Member Savings")
            {
            }
            column(ClosureType; "Membership closure"."Closure Type")
            {
            }
            column(RefundableDeposit; "Membership closure"."Deposit Refundable")
            {
            }
            column(NoticeDate; NoticeDate)
            {
            }
            column(WithdrawalReasons; WithdrawalReasons)
            {
            }
            column(BOSAAcc; BOSAAcc)
            {
            }
            column(BOSAAccStatus; BOSAAccStatus)
            {
            }
            column(DepositBalance; BOSADepositBalance)
            {
            }
            column(FOSAAcc; FOSAAcc)
            {
            }
            column(FOSAAccStatus; FOSAAccStatus)
            {
            }
            column(FOSAAccBalance; FOSAAccBalance)
            {
            }
            column(BusinessAcc; BusinessAcc)
            {
            }
            column(BusinessAccStatus; BusinessAccStatus)
            {
            }
            column(BusinessAccBalance; BusinessAccBalance)
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

            dataitem(Members; Members)
            {
                DataItemLinkReference = "Membership Closure";
                DataItemLink = "No." = field("Member No.");

                column(Member_No; "No.")
                {
                }
                column(Member_Payroll; "Payroll/Staff No.")
                {

                }
                column(Gender; Gender)
                {
                }
                column(Employer_Code; "Employer Code")
                {
                }
                column(Employer_Name; "Employer Name")
                {
                }
                column(PhoneNo; "Phone No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                NoticeDate := 0D;
                WithdrawalReasons := '';
                BOSAAcc := '';
                BOSAAccStatus := '';
                BOSADepositBalance := 0;
                FOSAAcc := '';
                FOSAAccStatus := '';
                FOSAAccBalance := 0;
                BusinessAcc := '';
                BusinessAccStatus := '';
                BusinessAccBalance := 0;

                Notice.Reset;
                Notice.SetRange("No.", "Membership closure"."Notice Number");
                if Notice.Find('-') then
                    NoticeDate := Notice."Withdrawal Notice Date";
                WithdrawalReasons := MemberWithdrawal."Reason for withdrawal";

                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                //SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"BOSA Deposits");
                if SavingsAccount.Find('-') then begin
                    BOSAAcc := SavingsAccount."No.";
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BOSADepositBalance := SavingsAccount."Balance (LCY)";
                    BOSAAccStatus := Format(SavingsAccount.Status);


                end;
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                //SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Business Deposits");
                if SavingsAccount.Find('-') then begin
                    BusinessAcc := SavingsAccount."No.";
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BusinessAccBalance := SavingsAccount."Balance (LCY)";
                    BusinessAccStatus := Format(SavingsAccount.Status);
                end;
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                //SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"FOSA Account");
                if SavingsAccount.Find('-') then begin
                    FOSAAcc := SavingsAccount."No.";
                    SavingsAccount.CalcFields("Balance (LCY)");
                    FOSAAccBalance := SavingsAccount."Balance (LCY)";
                    FOSAAccStatus := Format(SavingsAccount.Status);
                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
        Notice: Record "Member withdrawal Notice";
        NoticeDate: Date;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavingsAccount: Record "Savings Accounts";
        DepositsMonthlyContribution: Decimal;
        MemberWithdrawal: Record "Member withdrawal Notice";
        WithdrawalReasons: Text;
        BOSAAcc: Code[20];
        BOSAAccStatus: Text[100];
        BOSADepositBalance: Decimal;
        BusinessAcc: Code[20];
        BusinessAccStatus: Code[20];
        BusinessAccBalance: Decimal;
        FOSAAcc: Code[20];
        FOSAAccStatus: Code[20];
        FOSAAccBalance: Decimal;
}
