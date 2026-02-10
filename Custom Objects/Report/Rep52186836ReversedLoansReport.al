report 52186836 "Reversed Loans Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Reversed Loans Report.rdl';

    dataset
    {
        dataitem("System Reversal"; "System Reversal")
        {
            DataItemTableView = where(Reversed = const(true));
            RequestFilterFields = "Transaction Date";

            column(No_; "No.")
            {

            }
            column(Transaction_Number; "Transaction Number")
            {

            }
            column(Document_No; "Document No")
            {

            }
            column(Creation_Date; CreateDa)
            {

            }
            column(Transaction_Date; TransDa)
            {

            }
            column(Created_by_User_ID; "Created by User ID")
            {

            }
            column(Comments; Comments)
            {

            }
            column(ReversedBy; ReversedBy)
            {

            }
            column(ReversedDate; ReversedDate)
            {

            }
            column(BranchCode; BranchCode)

            {

            }
            column(TOTDays; TOTDays)
            {

            }
            column(BranchName; BranchName)
            {

            }
            column(Approved_by_User_ID; "Approved by User ID")
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyNam; CompanyNam)
            {

            }
            column(Approved_date; "Approved date")
            {

            }
            column(Picture; CompanyInformation.Picture)
            {

            }
            column(LoanNum; LoanNum)
            {

            }
            column(LoanTyname; LoanTyname)
            {

            }
            column(LoanType; LoanType)
            {

            }
            column(CrmNum; CrmNum)
            {

            }
            column(ITperAnum; ITperAnum)
            {

            }
            column(ShareBalance; ShareBalance)
            {

            }
            column(SourceUnit; SourceUnit)
            {

            }
            column(RepayStartD; RepayStartD)
            {

            }
            column(ExpDate; ExpDate)
            {

            }
            column(DisbrsDate; DisbrsDate)
            {

            }
            column(CustNum; CustNum)
            {

            }
            column(MemberName; MemberName)
            {

            }

            dataitem(Loans; Loans)
            {
                DataItemLink = "Loan No." = field("Document No");
                column(Application_Date; AppDate)
                {

                }
                column(Member_No_; "Member No.")

                {

                }
                column(Employer_Code; "Employer Code")
                {

                }
                column(Member_Name; "Member Name")
                {

                }
                column(Repayment; Repayment)
                {

                }
                column(Requested_Amount; "Requested Amount")
                {

                }
                column(Share_Boosted_Amount; "Share Boosted Amount")
                {

                }

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                RegistersRec: Record "G/L Register";
                CreditledgerEntry: Record "Credit Ledger Entry";
                LoansRec: Record Loans;
                CustomerRec: Record Customer;
            begin
                ReversedBy := '';
                ReversedDate := 0D;
                TOTDays := 0;
                BranchName := '';
                BranchCode := '';
                LoanTyname := '';
                LoanType := '';
                ShareBalance := 0;
                BranchCode := '';
                SourceUnit := '';
                ExpDate := '';
                DisbrsDate := '';
                RepayStartD := '';
                ITperAnum := 0;
                TransDa := '';
                CreateDa := '';
                CustNum := '';
                MemberName := '';
                if "System Reversal"."Transaction Date" <> 0D then begin
                    TransDa := GlobalFunc.FormatDate("System Reversal"."Transaction Date");

                end;
                if "System Reversal"."Creation Date" <> 0D then begin
                    CreateDa := GlobalFunc.FormatDate("System Reversal"."Creation Date")
                end;
                CreditledgerEntry.Reset();
                CreditledgerEntry.SetRange("Document No.", "System Reversal"."Document No");
                CreditledgerEntry.SetRange("Source Code", 'REVERSAL');
                CreditledgerEntry.SetRange(Reversed, true);
                IF CreditledgerEntry.FindFirst() then begin
                    CustNum := CreditledgerEntry."Customer No.";
                    ReversedBy := CreditledgerEntry."User ID";
                    ReversedDate := CreditledgerEntry."Posting Date";
                    if ReversedDate <> 0D then
                        TOTDays := ReversedDate - "System Reversal"."Creation Date";
                end;
                if CustNum <> '' then begin
                    MembersRec.Reset();
                    MembersRec.SetRange("No.", CustNum);
                    if MembersRec.FindFirst() then
                        MemberName := MembersRec.Name;
                end;
                LoansRec.Reset();
                LoansRec.SetRange("Loan No.", "System Reversal"."Document No");
                if LoansRec.FindFirst() then begin
                    BranchCode := LoansRec."Global Dimension 1 Code";
                    LoanTyname := LoansRec."Loan Product Type Name";
                    SourceUnit := Format(LoansRec."Source Unit");
                    LInterest := LoansRec."Loan Interest Repayment";
                    LoanType := LoansRec."Loan Product Type";
                    CrmNum := LoansRec."CRM Application No.";
                    if BranchCode <> '' then
                        if CustomerRec.get(BranchCode) then begin
                            BranchName := CustomerRec.Name;
                        end;
                    if prodfac.Get(LoansRec."Loan Product Type") then begin
                        ITperAnum := prodfac."Ordinary Default Intallments";
                    end;
                    SavingsA.Reset();
                    SavingsA.SetRange("Member No.", LoansRec."Member No.");
                    SavingsA.SetRange(SavingsA."Product Category", SavingsA."Product Category"::"Share Capital");
                    if SavingsA.FindFirst() then begin
                        SavingsA.CalcFields(Balance);
                        ShareBalance := SavingsA.Balance;
                    end;
                    if LoansRec."Repayment Start Date" <> 0D then begin
                        RepayStartD := GlobalFunc.FormatDate(LoansRec."Repayment Start Date");
                        ExpDate := GlobalFunc.FormatDate(LoansRec."Expected Date of Completion");
                        AppDate := GlobalFunc.FormatDate(LoansRec."Application Date");
                    end;
                    if LoansRec."Disbursement Date" <> 0D then begin
                        DisbrsDate := GlobalFunc.FormatDate(LoansRec."Disbursement Date");
                    end;
                end;
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        myInt: Integer;
        CustNum: Code[30];
        CreateDa: Text;
        MemberName: Text;
        MembersRec: Record Members;
        prodfac: Record "Product Factory";
        SavingsA: Record "Savings Accounts";
        GlobalFunc: Codeunit "Global Functions";
        DisbrsDate: Text;
        ExpDate: Text;
        AppDate: Text;
        CompanyNam: Text;
        ShareBalance: Decimal;
        RepayStartD: Text;
        LInterest: Decimal;
        LInterrate: Integer;
        CommunicationOnline: Text;
        SourceUnit: Text;
        CompanyAddress: Text;
        LoanNum: Code[30];
        LoanType: Code[20];
        LoanTyname: Text;
        TransDa: Text;
        CrmNum: code[20];
        CompanyTelephone: Text;
        CompanyInformation: Record "Company Information";
        ReversedBy: Text;
        TOTDays: Integer;
        ITperAnum: Integer;
        ReversedDate: Date;
        BranchCode: Code[20];
        BranchName: text;

}