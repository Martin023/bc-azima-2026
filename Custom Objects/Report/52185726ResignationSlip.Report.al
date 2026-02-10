#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185726 "Resignation Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Closure Slip.rdl';
    Caption = 'Closure Slip';

    dataset
    {
        dataitem("Membership closure"; "Membership closure")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_7301; 7301)
            {
            }
            column(NoticeDate; AppDate)
            {
            }
            column(MaturityDate; MaturityDate)
            {
            }
            column(No_Membershipclosure; "Membership closure"."No.")
            {
            }
            column(UserName; UserName)
            {
            }
            column(No_; "Membership closure"."No.")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(MemberAge; MemberAge)
            {

            }
            column(CompanyInfo__Address_2_; Company."Address 2")
            {
            }
            column(CompanyInfo_Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Members__No__; "Membership closure"."Member No.")
            {
            }
            column(Members_Name; "Membership closure"."Member Name")
            {
            }
            column(Members_PrimaryIdentificatonType; "Membership closure"."Primary Identification Type")
            {
            }
            column(Members_ID; "Membership closure"."Primary Identification No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(product; Product)
            {
            }
            column(Interests; "Membership closure"."Total Interest")
            {
            }
            column(Loan; "Membership closure"."Total Loan")
            {
            }
            column(Refund; Refund)
            {
            }
            column(WithdrawalFee; WithdrawalFee)
            {
            }
            column(ExciseDuty; ExciseDuty)
            {
            }
            column(ChargeAmount; ChargeAmount)
            {
            }
            column(StaffNo; StaffNo)
            {
            }
            column(WithDrawalCharge; WithDrawalCharge)
            {
            }
            column(WithDrawalChargeExciseDuty; WithDrawalChargeExciseDuty)
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(ReasonsForWithdrawal; WithDrawalReasons)
            {
            }
            column(EarlyWithrawalFee; EarlyWithrawalFee)
            {
            }
            column(EarlyWithrawalFeeExcise; EarlyWithrawalFeeExcise)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(StaffNo_Membershipclosure; "Staff No.")
            {
            }
            column(ClosingDate_Membershipclosure; "Closing Date")
            {
            }
            column(WithDrawalAppDate; MemberwithdrawalNotice."Withdrawal Notice Date")
            {
            }
            column(ClosureType_Membershipclosure; "Closure Type")
            {
            }

            column(ReasonForWithDrawing; MemberwithdrawalNotice."Reason for withdrawal")
            {

            }
            column(MemberSavings_Membershipclosure; "Member Savings")
            {
            }
            column(DepositRefundable_Membershipclosure; "Deposit Refundable")
            {
            }
            column(PartialDepositRefundable_Membershipclosure; "Partial Deposit Refundable")
            {
            }
            column(ofRefunds_Membershipclosure; "% of Refunds")
            {
            }
            column(TSCClearance_Membershipclosure; "TSC Clearance")
            {
            }
            column(MobileNumber; Members."Phone No.")
            {

            }
            column(ClosureCharges_Membershipclosure; "Closure Charges")
            {
            }

            dataitem("Account Closure Line"; "Account Closure Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = where("Product Type" = filter(02 | 05));
                column(ReportForNavId_3; 3)
                {
                }
                column(No_AccountClosureLine; "Account Closure Line"."No.")
                {
                }
                column(AccountNo_AccountClosureLine; "Account Closure Line"."Account No.")
                {
                }
                column(Name_AccountClosureLine; "Account Closure Line".Name)
                {
                }
                column(ProductType_AccountClosureLine; "Account Closure Line"."Product Type")
                {
                }
                column(Balance_AccountClosureLine; "Account Closure Line".Balance)
                {
                }
                column(Close_AccountClosureLine; "Account Closure Line".Close)
                {
                }
                column(MemberNo_AccountClosureLine; "Account Closure Line"."Member No.")
                {
                }
                column(ProductName; ProductName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ProductFactory.Get("Account Closure Line"."Product Type") then
                        ProductName := ProductFactory."Product Description"
                    else
                        ProductName := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                WithdrawalFee := 0;
                NetPayable := 0;
                FWithdrawal := 0;
                UBFRefund := 0;
                GenSetUp.Get();

                "Deposit Refundable" -= (WithdrawalFee + ExciseDuty);

                if Members.Get("Membership closure"."Member No.") then begin
                    StaffNo := Members."Payroll/Staff No.";
                    EmployerName := Members."Employer Code";
                    MemberAge := Round(((Today - Members."Date of Birth") / 365), 1, '=');

                end else begin
                    StaffNo := '';
                    EmployerName := '';
                end;

                MemberwithdrawalNotice.Reset;
                MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice."Member No.", "Member No.");
                MemberwithdrawalNotice.SetRange("No.", "Notice Number");
                MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice.Status, MemberwithdrawalNotice.Status::Approved);
                if MemberwithdrawalNotice.Find('+') then begin
                    AppDate := MemberwithdrawalNotice."Withdrawal Notice Date";
                    MaturityDate := MemberwithdrawalNotice."Maturity Date";
                end;


                FWithdrawal := GenSetUp."Withdrawal Fee";
                AccountClosure.Reset;
                AccountClosure.SetRange(AccountClosure."Member No.", "Membership closure"."Member No.");
                if AccountClosure.Find('-') then begin
                    repeat
                        NetPayable := NetPayable + (AccountClosure.Balance * -1);
                        Product := AccountClosure."Product Type";
                        Amount := AccountClosure.Balance;
                    until AccountClosure.Next = 0;
                end;

                //*********************Premature Withdrawal
                MemberwithdrawalNotice.Reset;
                MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice."Member No.", "Member No.");
                MemberwithdrawalNotice.SetRange(MemberwithdrawalNotice.Status, MemberwithdrawalNotice.Status::Approved);
                MemberwithdrawalNotice.SetRange("No.", "Notice Number");
                if MemberwithdrawalNotice.Find('+') then begin
                    WithDrawalApplicationDate := MemberwithdrawalNotice."Withdrawal Notice Date";
                    if MemberwithdrawalNotice."Maturity Date" > "Closing Date" then begin
                        TransactionTypes.Reset;
                        TransactionTypes.SetRange(TransactionTypes.Type, TransactionTypes.Type::"Member Withdrawal");
                        if TransactionTypes.Find('-') then begin
                        end;

                        //Charges
                        TCharges := 0;

                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionTypes.Code);
                        if TransactionCharges.Find('-') then begin
                            repeat
                                ChargeAmount := 0;
                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                    ChargeAmount := ("Member Savings" * TransactionCharges."Percentage of Amount") * 0.01
                                else
                                    ChargeAmount := TransactionCharges."Charge Amount";

                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if ("Member Savings" >= TariffDetails."Lower Limit") and ("Member Savings" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    ChargeAmount := "Membership closure"."Member Savings" * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    ChargeAmount := TariffDetails."Charge Amount"
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;
                            until TransactionCharges.Next = 0;
                        end;
                    end;
                end else begin
                    TransactionTypes.Reset;
                    TransactionTypes.SetRange(TransactionTypes.Type, TransactionTypes.Type::"Member Withdrawal");
                    if TransactionTypes.Find('-') then begin
                    end;

                    //Charges
                    TCharges := 0;

                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionTypes.Code);
                    if TransactionCharges.Find('-') then begin
                        repeat
                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                ChargeAmount := ("Member Savings" * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if ("Member Savings" >= TariffDetails."Lower Limit") and ("Member Savings" <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := "Membership closure"."Member Savings" * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount"
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;

                WithDrawalCharge := 0;
                WithDrawalChargeExciseDuty := 0;
                WithDrawalCharge := ("Deposit Refundable" - WithdrawalFee - ChargeAmount) * 0.01;
                WithDrawalChargeExciseDuty := WithDrawalCharge * 0.2;
                // MESSAGE(FORMAT(FWithdrawal));
                Refund := "Deposit Refundable" - (WithdrawalFee + ChargeAmount + WithDrawalCharge + WithDrawalChargeExciseDuty + (FWithdrawal * 0.2));

                //Early Withdrawal Fee //Denis
                if "Membership closure"."Closure Type" = "Membership closure"."closure type"::"Withdrawal - Normal" then begin
                    Account.Reset;
                    Account.SetRange(Account."Member No.", "Member No.");
                    Account.SetRange("Product Category", Account."Product Category"::"BOSA Deposits");
                    if Account.FindFirst then begin
                        Account.CalcFields("Balance (LCY)");
                        EarlyWithrawalFee := 0;
                        EarlyWithrawalFeeExcise := 0;
                        MemberwithdrawalNotice.Reset;
                        MemberwithdrawalNotice.SetRange("No.", "Notice Number");
                        if MemberwithdrawalNotice.Find('-') then begin
                            if MemberwithdrawalNotice."Early Withdrawal" = true then begin
                                EarlyWithrawalFee := (GenSetUp."Early Withdrawal %" / 100) * (Account."Balance (LCY)");
                                EarlyWithrawalFeeExcise := (GenSetUp."Early Withdrawal %" / 100) * EarlyWithrawalFee;
                            end;
                        end;
                    end;
                end;


                ExciseDuty := FWithdrawal * GenSetUp."Excise Duty (%)" * 0.01;
                Refund := Refund - (EarlyWithrawalFee + EarlyWithrawalFeeExcise);
                //end of early with drawal Fee

                TotalDeductions := (WithdrawalFee + ChargeAmount + WithDrawalCharge + WithDrawalChargeExciseDuty + ExciseDuty + EarlyWithrawalFee + EarlyWithrawalFeeExcise);
                if Refund < 0 then
                    Refund := 0;

                UserName := '';
                UserSetup.Reset;
                UserSetup.SetRange("User ID", "Membership closure"."Entered By");
                if UserSetup.Find('-') then begin
                    UserName := UserSetup."Full Name";
                end;

                //get withDrawal Reasons
                MemberwithdrawalNotice.Reset;
                MemberwithdrawalNotice.SetRange("No.", "Membership closure"."Notice Number");
                if MemberwithdrawalNotice.FindFirst then
                    WithDrawalReasons := MemberwithdrawalNotice."Reason for withdrawal";
            end;

            trigger OnPreDataItem()
            begin
                if Company.Get() then
                    Company.CalcFields(Company.Picture);

                GenSetUp.Get();
            end;
        }
    }

    requestpage
    {
        //SaveValues = true;

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

    var
        WithdrawalFee: Decimal;
        MemberAge: Integer;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        NetPayable: Decimal;
        FOSAInterest: Decimal;
        FExpenses: Decimal;
        CICLoan: Decimal;
        InsFund: Decimal;
        UnpaidDividends: Decimal;
        Account: Record "Savings Accounts";
        Company: Record "Company Information";
        UBFRefund: Decimal;
        GenSetUp: Record "General Set-Up";
        Vend: Record Vendor;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        ACCOUNT_CLOSURE_SLIPCaptionLbl: label 'ACCOUNT CLOSURE SLIP';
        Member_No_CaptionLbl: label 'Member No.';
        Current_Oustanding_LoanCaptionLbl: label 'Current Oustanding Loan';
        Deposit_ContributionCaptionLbl: label 'Deposit Contribution';
        Other_DeductionsCaptionLbl: label 'Other Deductions';
        Insurance_Fund_CaptionLbl: label 'Insurance Fund ';
        ADD__Unpaid_DividendsCaptionLbl: label 'ADD: Unpaid Dividends';
        LESS_CaptionLbl: label 'LESS:';
        ADD_CaptionLbl: label 'ADD:';
        Net_RefundCaptionLbl: label 'Net Refund';
        Withdrawal_FeesCaptionLbl: label 'Withdrawal Fees';
        Batch_No_CaptionLbl: label 'Batch No.';
        Prepared_ByLbl: label 'Prepared By: ....................................................................................................................................................................';
        Approved_ByLbl: label 'Approved By: ....................................................................................................................................................................';
        Signature_Date_Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Signature_Date000Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Member_StatusCaptionLbl: label 'Member Status';
        FOSA_Accrued_InterestCaptionLbl: label 'FOSA Accrued Interest';
        FOSA_Current_Oustanding_LoanCaptionLbl: label 'FOSA Current Oustanding Loan';
        Shares_CapitalCaptionLbl: label 'Shares Capital';
        Funeral_ExpensesCaptionLbl: label 'Funeral Expenses';
        Under_Excess_InsuranceCaptionLbl: label 'Under/Excess Insurance';
        Capital_ReserveCaptionLbl: label 'Capital Reserve';
        Insurance__CIC_CaptionLbl: label 'Insurance (CIC)';
        TotalCaptionLbl: label 'Total';
        TotalCaption_Control1102760055Lbl: label 'Total';
        UBF_Refund_CaptionLbl: label 'UBF Refund ';
        AccountClosure: Record 52185825;
        Product: Code[20];
        Amount: Decimal;
        MemberwithdrawalNotice: Record 52185826;
        TransactionTypes: Record 52185773;
        TransactionCharges: Record 52185774;
        TCharges: Decimal;
        ChargeAmount: Decimal;
        TariffDetails: Record 52185777;
        Refund: Decimal;
        Members: Record "Members";
        EmployerName: Text;
        StaffNo: Code[20];
        ProductFactory: Record "Product Factory";
        ProductName: Text;
        WithDrawalCharge: Decimal;
        WithDrawalChargeExciseDuty: Decimal;
        UserSetup: Record "User Setup";
        UserName: Text;
        AppDate: Date;
        MaturityDate: Date;
        WithDrawalReasons: Text;
        EarlyWithrawalFee: Decimal;
        EarlyWithrawalFeeExcise: Decimal;
        TotalDeductions: Decimal;
        ExciseDuty: Decimal;
        WithDrawalApplicationDate: Date;
}

