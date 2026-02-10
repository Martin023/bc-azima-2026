Report 52186239 "Recovered Arrears"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Recovered Arrears Report';
    RDLCLayout = './bc-azima-2026/Layout/Recovered Arrears.rdl';

    dataset
    {


        dataitem(RefundHeader; "Refund,Account Transfer Header")
        {
            DataItemTableView = where(Posted = const(true));
            // RequestFilterFields = "Employer Code", "Source Unit";

            column(CompanyTelephone; CompanyTelephone)
            {
            }

            column(CompanyNam; CompanyNam)
            {
            }


            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(picture; CompanyInformation.Picture)
            {
            }
            column(StartingDate; StartingDate)
            {

            }

            column(EndingDate; EndingDate)
            {

            }


            trigger OnPreDataItem()
            var
                StartingDate: Date;
            begin
                if RefundHeader."Posting date" <> 0D then
                    RefundHeader.SetFilter(RefundHeader."Posting date", '%1..%2', Sdate, Edate);
            end;

            trigger OnAfterGetRecord()
            var
                memberss: Record Members;
                SavingsAccounts: Record "Savings Accounts";

            begin
                Loan2Num := '';
                DisburseD := '';
                memberN := '';
                StaffNO := '';
                EmplCode := '';
                BranchCode := '';
                OUtstBal := 0;
                Recovery := '';
                Install := 0;
                ApprovedAmt := 0;
                MemberName := '';



                // if memberN = '' then
                //     CurrReport.Skip();



            end;

        }
        dataitem(RefundLines; "Refund,Account Transfer lines")
        {
            // DataItemLink = No= field("Refund Header No.");
            DataItemLink = "Refund Header No." = field(No);
            DataItemLinkReference = RefundHeader;
            DataItemTableView = where("Recover Arrears" = const(true));

            // RequestFilterFields = "Member Type";

            column(memberN; memberN)
            {
            }


            column(Loan2Num; RefundLines."Loan No.")
            {
            }


            column(ApprovedAmt; RefundLines.Amount)
            {
            }

            column(TBal; RefundLines."Total Destination Loan Balance")
            {
            }


            column(Member_Name; MemberName)
            {

            }



            trigger OnAfterGetRecord()
            var
                memberss: Record Members;
                SavingsAccounts: Record "Savings Accounts";

            begin
                Loan2Num := '';
                DisburseD := '';
                memberN := '';
                StaffNO := '';
                EmplCode := '';
                BranchCode := '';
                OUtstBal := 0;
                Recovery := '';
                Install := 0;
                ApprovedAmt := 0;
                MemberName := '';

                SavingsAccounts.get(RefundLines."Source Account");
                memberN := SavingsAccounts."Member No.";
                MemberName := SavingsAccounts.Name;

                // if memberN = '' then
                //     CurrReport.Skip();



            end;

        }



    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(StartingDate; StartingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';

                }
            }

        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        StartingDate: Date;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        Sdate := StartingDate;
        Edate := EndingDate;

    end;

    var
        DisbursementDate: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        Sdate: Date;
        EmplCode: Code[30];
        OUtstBal: Decimal;
        TBal: Decimal;
        Edate: Date;
        CompanyNam: Text;
        CompanyAddress: Text;
        memberN: Code[30];
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        GlobalsFunc: Codeunit "Global Functions";

        StartingDate: Date;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        StaffNO: Code[30];
        Recovery: Text;
        CreditLedgerEntry2: Record "Credit Ledger Entry";
        Loan2Num: Code[30];
        FormatedDisbursementDate: Text;
        DisbursementMonth: Text;
        PrintedBy: Text;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Endmonthdate: Integer;
        StartDD: Date;
        DisburseD: Text;
        EndingDate: Date;
        Disburse: Integer;
        LoansREcc: Record Loans;
        Brthdate: Text;
        PaidAmount: Decimal;
        SelectYear: Integer;
        TestCase: Text;
        BranchCode: Code[30];
        Install: Integer;
        MemberName: Text;
        ApprovedAmt: Decimal;
        ApprovedDate: Text;
        RPayAmt: Decimal;
}

