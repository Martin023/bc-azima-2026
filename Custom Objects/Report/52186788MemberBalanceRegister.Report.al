#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186788 "Member Balance Register"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Member Balance Register.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status, "Employer Code", "Registration Date", "Account Type", "Global Dimension 1 Code", "Global Dimension 2 Code", Nationality;

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
            column(No_Members; Members."No.")
            {
            }

            column(Name_Members; Members.Name)
            {
            }
            column(GlobalDimension1Code_Members; Members."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Members; Members."Global Dimension 2 Code")
            {
            }
            column(RegistrationDate_Members; Members."Registration Date")
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(Nationality_Members; Members.Nationality)
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            column(IDNumber_Members; Members."Primary Identification")
            {
            }

            column(GroupAccountNo_Members; Members."Group Account No.")
            {
            }
            column(SalespersonCode_Members; Members."Recruited By")
            {
            }
            column(MemberSegment_Members; Members."Member Segment")
            {
            }
            column(CreatedBy_Members; Members."Created By")
            {
            }

            column(Status_Members; Members.Status)
            {
            }
            column(SCount; SNo)
            {
            }
            column(MemberClass_Members; Members."Member Class")
            {
            }
            column(AplhaDeposit; AplhaDeposit)
            {
            }
            column(SharesCapital; SharesCapital)
            {
            }
            column(RegFees; RegFees)
            {
            }
            column(BBF; BBF)
            {
            }
            column(Risk; Risk)
            {
            }
            column(ShortTLoans; ShortTLoans)
            {
            }
            column(LongTLoans; LongTLoans)
            {
            }
            column(TotalLoans; TotalLoans)
            {
            }
            column(BranchCode_Members; Members."Branch Code")
            {
            }
            column(CreatedBy; CreatedBy)
            {
            }
            column(HASImage; HASImage)
            {
            }
            column(HASNextKin; HASNextKin)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                column(Loan_No_; "Loan No.")
                {
                }
                column(Loan_Principle_Repayment; "Loan Principle Repayment")
                {

                }
                column(LastPrRep; LastPrRep)
                {

                }
                column(LastInPaid; LastInPaid)
                {

                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    Creditledger: Record "Credit Ledger Entry";
                begin
                    Creditledger.Reset();
                    Creditledger.SetRange("Loan No", Loans."Loan No.");
                    Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::Repayment);
                    if Creditledger.FindLast() then begin
                        LatPaydate := Creditledger."Posting Date";
                        LastPrRep := Creditledger.Amount;
                        if LatPaydate <> 0D then
                            lastP := GlobalFunc.FormatDate(LatPaydate);

                    end;
                    Creditledger.Reset();
                    Creditledger.SetRange("Loan No", Loans."Loan No.");
                    Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::"Interest Paid");
                    if Creditledger.FindLast() then begin
                        LastInPaid := Creditledger.Amount;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                HASImage := false;
                HASNextKin := false;
                ShortTLoans := 0;
                LongTLoans := 0;
                SharesCapital := 0;
                BBF := 0;
                Risk := 0;
                AplhaDeposit := 0;
                RegFees := 0;
                TotalLoans := 0;
                CreatedBy := '';
                User.Reset;
                User.SetRange("User Name", Members."Created By");
                if User.Find('-') then begin
                    CreatedBy := User."Full Name";
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Share Capital");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    SharesCapital := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Entrance Fee");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    RegFees := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Benevolent (BBF)");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    BBF := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::Risk);
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    Risk := SavingAcc.Balance;
                end;

                LoanAcc.Reset;
                LoanAcc.SetRange("Member No.", "No.");
                if LoanAcc.Find('-') then begin
                    repeat
                        LoanAcc.CalcFields("Outstanding Balance");
                        TotalLoans := TotalLoans + LoanAcc."Outstanding Balance";
                    until LoanAcc.Next = 0;
                end;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;


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
        SNo: Integer;
        SavingAcc: Record "Savings Accounts";
        CreditAcc: Record "Credit Accounts";
        LatPaydate: Date;
        LoanAcc: Record Loans;
        AplhaDeposit: Decimal;
        SharesCapital: Decimal;
        RegFees: Decimal;
        CreditLoans: Decimal;
        BankingLoans: Decimal;
        AlphaDepositProduct: Code[10];
        SharesCapitalProduct: Code[10];
        RegFeesProduct: Code[10];
        ShortTLoans: Decimal;
        LongTLoans: Decimal;
        TotalLoans: Decimal;
        CreatedBy: Text;
        BBF: Decimal;
        Risk: Decimal;
        User: Record User;
        NextofKIN: Record "Next of KIN";
        ImageData: Record "Image Data";
        HASNextKin: Boolean;
        HASImage: Boolean;
        ShowNextofKin: Boolean;
        ShowImage: Boolean;
        LoanreX: Record loans;
        LNInterest: Decimal;
        OutstnBal: Decimal;
        MemberBiodata: Text;
        // SavingAcc: Record "Savings Accounts";
        ApprovedDate: Text;
        Appdate: Text;
        lastP: Text;

        GlobalFunc: Codeunit "Global Functions";
        LastPrRep: Decimal;

        LastInPaid: Decimal;

}
