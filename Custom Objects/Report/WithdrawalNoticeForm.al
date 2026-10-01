report 52185562 "Withdrawal Notice Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Withdrawal Notice Form.rdl';
    Caption = 'Withdrawal Notice Form';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(CompanyWebsite; CompanyInfo."Home Page") { }
            
            column(PrintDate; Format(Today, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }

            column(MemName; Name) { }
            column(MemIDNo; "Primary Identification") { }
            column(MemWNo; "Payroll/Staff No.") { }
            column(MemNo; "No.") { }
            column(MemMobile; "Phone No.") { }
            column(MemDept; "Employer Name") { }

            // --- NEW CALCULATED COLUMNS ---
            column(TotalDeposits; TotalDeposits) { }
            column(ShareCapital; ShareCapital) { }
            column(NormJijJipPrin; NormJijJipPrin) { }
            column(NormJijJipInt; NormJijJipInt) { }
            column(ShortTermPrinInt; ShortTermPrinInt) { }
            column(MasomoPrinInt; MasomoPrinInt) { }
            column(DefaulterPrinInt; DefaulterPrinInt) { }
            column(PineapplePrinInt; PineapplePrinInt) { }
            column(SuperPrinInt; SuperPrinInt) { }
            column(SalAdvOkoaPrinInt; SalAdvOkoaPrinInt) { }
            column(WithdrawalCharges; WithdrawalCharges) { }
            column(InstantRefundCharge; InstantRefundCharge) { }
            column(AmountToBeRefunded; AmountToBeRefunded) { }

            trigger OnPreDataItem()
            begin
                if ReqMemberNo = '' then
                    Error('Please select a member before previewing or printing.');
                    
                SetRange("No.", ReqMemberNo);
            end;

            trigger OnAfterGetRecord()
            var
                SavAcc: Record "Savings Accounts";
                LoanRec: Record Loans;
                TotalLoanLiabilities: Decimal;
            begin
                // 1. Initialize Variables
                TotalDeposits := 0; ShareCapital := 0;
                NormJijJipPrin := 0; NormJijJipInt := 0;
                ShortTermPrinInt := 0; MasomoPrinInt := 0;
                DefaulterPrinInt := 0; PineapplePrinInt := 0;
                SuperPrinInt := 0; SalAdvOkoaPrinInt := 0;
                WithdrawalCharges := 1000; // Hardcoded or fetch from General Setup if available

                // 2. Fetch Deposits & Share Capital
                SavAcc.Reset();
                SavAcc.SetRange("Member No.", "No.");
                if SavAcc.FindSet() then begin
                    repeat
                        SavAcc.CalcFields("Balance (LCY)");
                        if SavAcc."Product Category" = SavAcc."Product Category"::"BOSA Deposits" then
                            TotalDeposits += SavAcc."Balance (LCY)"
                        else if SavAcc."Product Category" = SavAcc."Product Category"::"Share Capital" then
                            ShareCapital += SavAcc."Balance (LCY)";
                    until SavAcc.Next() = 0;
                end;

                // 3. Calculate 10% Instant Refund Charge (Penalty)
                InstantRefundCharge := TotalDeposits * 0.10;

                // 4. Fetch Outstanding Loans & Interest
                LoanRec.Reset();
                LoanRec.SetRange("Member No.", "No.");
                LoanRec.SetFilter("Outstanding Balance", '>0');
                if LoanRec.FindSet() then begin
                    repeat
                        LoanRec.CalcFields("Outstanding Balance", "Outstanding Interest");
                        
                        // Map loans according to product IDs
                        case LoanRec."Loan Product Type" of
                            '066', '065', '068', '016': // Normal, Normal B, Jijenge, Jipange
                                begin
                                    NormJijJipPrin += LoanRec."Outstanding Balance";
                                    NormJijJipInt += LoanRec."Outstanding Interest";
                                end;
                            '062': // Emergency / Short Term
                                ShortTermPrinInt += (LoanRec."Outstanding Balance" + LoanRec."Outstanding Interest");
                            '069': // Masomo
                                MasomoPrinInt += (LoanRec."Outstanding Balance" + LoanRec."Outstanding Interest");
                            '075': // Defaulters
                                DefaulterPrinInt += (LoanRec."Outstanding Balance" + LoanRec."Outstanding Interest");
                            '024': // Pineapple
                                PineapplePrinInt += (LoanRec."Outstanding Balance" + LoanRec."Outstanding Interest");
                            '019': // Super
                                SuperPrinInt += (LoanRec."Outstanding Balance" + LoanRec."Outstanding Interest");
                            '017', '014', '012': // Sal Advance, Okoa Mwezi, Azima SMS
                                SalAdvOkoaPrinInt += (LoanRec."Outstanding Balance" + LoanRec."Outstanding Interest");
                        end;
                    until LoanRec.Next() = 0;
                end;

                // 5. Calculate Final Refund
                TotalLoanLiabilities := NormJijJipPrin + NormJijJipInt + ShortTermPrinInt + MasomoPrinInt + 
                                        DefaulterPrinInt + PineapplePrinInt + SuperPrinInt + SalAdvOkoaPrinInt;
                
                // =========================================================================
                // COMMENT ON SHARE CAPITAL:
                // According to standard SACCO Society Regulatory Authority (SASRA) by-laws, 
                // Share Capital is strictly non-refundable and cannot be directly offset 
                // against loan liabilities. It can only be transferred or sold to another 
                // member. Therefore, Share Capital is EXCLUDED from the refund calculation below. 
                // If Azima SACCO rules dictate otherwise (i.e. to add it to the refund amount), 
                // simply append '+ ShareCapital' to this calculation.
                // =========================================================================
                
                AmountToBeRefunded := TotalDeposits - TotalLoanLiabilities - WithdrawalCharges - InstantRefundCharge;
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
                group(MemberSelection)
                {
                    Caption = 'Select Member to Withdraw';
                    
                    field(ReqMemberNo; ReqMemberNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '1. Member No. / Search';
                        TableRelation = Members."No.";
                        ToolTip = 'Select the member submitting the withdrawal notice.';
                        
                        trigger OnValidate()
                        var
                            MemRec: Record Members;
                        begin
                            if ReqMemberNo <> '' then begin
                                if MemRec.Get(ReqMemberNo) then begin
                                    ReqName := MemRec.Name;
                                    ReqIDNo := MemRec."Primary Identification";
                                    ReqWNo := MemRec."Payroll/Staff No.";
                                    
                                    MemRec.CalcFields("Employer Name");
                                    ReqDept := MemRec."Employer Name";
                                end;
                            end else begin
                                ReqName := ''; 
                                ReqIDNo := ''; 
                                ReqWNo := ''; 
                                ReqDept := '';
                            end;
                        end;
                    }
                    field(ReqName; ReqName)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Editable = false;
                    }
                    field(ReqIDNo; ReqIDNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ID No.';
                        Editable = false;
                    }
                    field(ReqWNo; ReqWNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'W/No (Payroll)';
                        Editable = false;
                    }
                    field(ReqDept; ReqDept)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Department/Employer';
                        Editable = false;
                    }
                }
            }
        }
        actions { }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyAddress := 'P.O BOX ' + CompanyInfo."Post Code" + ' - ' + CompanyInfo.City;
        CompanyTelephone := 'TEL: ' + CompanyInfo."Phone No." + ', ' + CompanyInfo."Phone No. 2";
        CompanyEmail := CompanyInfo."E-Mail";
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        ReqMemberNo: Code[50];
        ReqName: Text[100];
        ReqIDNo: Code[50];
        ReqWNo: Code[50];
        ReqDept: Text[100];
        
        // Calculation Variables
        TotalDeposits: Decimal;
        ShareCapital: Decimal;
        NormJijJipPrin: Decimal;
        NormJijJipInt: Decimal;
        ShortTermPrinInt: Decimal;
        MasomoPrinInt: Decimal;
        DefaulterPrinInt: Decimal;
        PineapplePrinInt: Decimal;
        SuperPrinInt: Decimal;
        SalAdvOkoaPrinInt: Decimal;
        WithdrawalCharges: Decimal;
        InstantRefundCharge: Decimal;
        AmountToBeRefunded: Decimal;
}