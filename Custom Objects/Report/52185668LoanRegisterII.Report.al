#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185668 "Loan Register II"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Register II.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.", "Member Category";
            column(ReportForNavId_1; 1)
            {
            }
            column(memberstatus; memberstatus)
            {
            }
            column(TotalLoanBalance; Loans."Total Loan Balance")
            {
            }
            column(Unallocated; Unallocated)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(Email; Email)
            {
            }
            column(AddressMbr; Address)
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(Installemnt; Loans.Installments)
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(OutBal; Loans."Outstanding Balance")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(OutBill; Loans."Outstanding Bills")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(EmployerLoanNo; Loans."Employer Loan No.")
            {
            }
            column(BatchNo_Loans; Loans."Batch No.")
            {
            }
            column(ShareBoostedAmount; Loans."Share Boosted Amount")
            {
            }
            column(ShareBoostedAmount1; Loans."Loans - Deposit Purchase")
            {
            }
            column(EmployerCode; Loans."Employer Code")
            {
            }
            column(AmntTp; AmntTp)
            {
            }
            column(StaffNo; Loans."Staff No")
            {
            }
            column(Days; Days)
            {
            }
            column(ProductType; ProductType)
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(MaturityDate; Loans."Expected Date of Completion")
            {
            }
            column(LatestDatePaid; LatestDatePaid)
            {
            }
            column(LatestAmount; LatestAmount)
            {
            }
            column(LoanClassification; Loans."Loans Category-SASRA")
            {
            }
            column(Frequecy; Loans."Repayment Frequency")
            {
            }
            column(Interest; Loans.Interest)
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(RepayMode; Loans."Recovery Mode")
            {
            }
            column(FirstRepaymentDate; Loans."Repayment Start Date")
            {
            }
            column(DaysArreas; DaysArreas)
            {
            }
            column(InterestCalculationMethod; Loans."Interest Calculation Method")
            {
            }
            column(DisbursementDate; Loans."Disbursement Date")
            {
            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(TotalComputedCharges; TotalComputedCharges + boostingcharge + ExtclearanceCharge)
            {
            }
            column(SalaryProcessing; SalaryProcessing)
            {
            }

            trigger OnAfterGetRecord()
            begin
                GeneralSetUp.Get();
                AmntTp := 0;
                ExtclearanceCharge := 0;
                DaysArreas := 0;
                LatestAmount := 0;
                LatestDatePaid := 0D;
                TotalComputedCharges := 0;
                EmployerName := '';
                ProductType := '';
                Unallocated := 0;
                LoansTopup.Reset;
                LoansTopup.SetRange("Loan No.", "Loan No.");
                if LoansTopup.Find('-') then begin
                    LoansTopup.CalcSums("Total Top Up");
                    AmntTp := LoansTopup."Total Top Up";
                end;

                OtherCommitementsClearance.Reset;
                OtherCommitementsClearance.SetRange("Loan No.", Loans."Loan No.");
                if OtherCommitementsClearance.Find('-') then begin
                    OtherCommitementsClearance.CalcSums(Amount);
                    AmntTp := AmntTp + OtherCommitementsClearance.Amount;
                    ExtclearanceCharge := (OtherCommitementsClearance.Amount * 0.1) + (OtherCommitementsClearance.Amount * 0.1) * GeneralSetUp."Excise Duty (%)" * 0.01;
                end;



                boostingcharge := 0;


                Days := 0;
                if Loans."Disbursement Date" <> 0D then
                    Days := Today - Loans."Disbursement Date";
                if ProductFactory.Get(Loans."Loan Product Type") then
                    ProductType := ProductFactory."Product Description";
                if Customer.Get(Loans."Employer Code") then
                    EmployerName := Customer.Name;

                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."transaction type"::Repayment);
                if CreditLedgerEntry.Find('+') then begin
                    LatestDatePaid := CreditLedgerEntry."Posting Date";
                    LatestAmount := Abs(CreditLedgerEntry.Amount);
                end;
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
                if PCharges.Find('-') then begin
                    repeat
                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                            TotalComputedCharges := TotalComputedCharges + (Loans."Approved Amount" * PCharges.Percentage / 100)
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                    PCharges.TestField(PCharges."Staggered Charge Code");

                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (Loans."Approved Amount" >= TariffDetails."Lower Limit") and (Loans."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    TotalComputedCharges := TotalComputedCharges + Loans."Approved Amount" * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    TotalComputedCharges := TotalComputedCharges + TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;
                    until PCharges.Next = 0;
                end;




                //End of general charges

                TotalCleared := 0;
                //Pass loan clearance principle and interest
                TopUp.Reset;
                TopUp.SetRange(TopUp."Loan No.", Loans."Loan No.");
                if TopUp.Find('-') then begin
                    repeat
                        //TopUp.CALCSUMS(TopUp."Principle Top Up",TopUp."Interest Top Up");
                        TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";

                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                        if PCharges.Find('-') then begin
                            repeat

                                if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                                    if ChargeExtraComms = true then
                                        TotalComputedCharges := TotalComputedCharges + (Loans."Approved Amount" * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                    else
                                        TotalComputedCharges := TotalComputedCharges + (Loans."Approved Amount" * (PCharges.Percentage / 100))
                                end else
                                    if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                                        if ChargeExtraComms = true then
                                            TotalComputedCharges := TotalComputedCharges + ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                        else
                                            TotalComputedCharges := TotalComputedCharges + ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * (PCharges.Percentage / 100))
                                    end else
                                        TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";

                            until PCharges.Next = 0;
                        end;
                    until TopUp.Next = 0;
                end;
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::Boosting);
                if PCharges.Find('-') then begin
                    repeat
                        boostingcharge := Loans."Loans - Deposit Purchase" * (PCharges.Percentage / 100);
                    until PCharges.Next = 0;
                end;

                if Loans."Loans Category-SASRA" <> Loans."loans category-sasra"::Perfoming then begin
                    if LatestDatePaid <> 0D then
                        DaysArreas := Today - LatestDatePaid;
                end;




                PhoneNo := '';
                Email := '';
                Address := '';
                memberstatus := Memberstatus::" ";
                Members.Reset;
                Members.SetRange("No.", Loans."Member No.");
                if Members.Find('-') then begin
                    memberstatus := Members.Status;
                    PhoneNo := Members."Phone No.";
                    if PhoneNo = '' then PhoneNo := Members."Phone No.";
                    Email := Members."E-Mail";
                    Address := Members."Current Address" + ' ' + Members."Post Code" + ' ' + Members.City;

                end;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                SavingsAccounts.SetRange("Product Type", '05');
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    Unallocated := SavingsAccounts."Balance (LCY)";
                end;
                SalaryProcessing := false;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                SavingsAccounts.SetRange("Product Type", '505');
                if SavingsAccounts.Find('-') then begin
                    if SavingsAccounts."Salary Through FOSA" then
                        SalaryProcessing := true;
                end;
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
        Company.Get;
        //Company.CALCFIELDS(Company.Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        AmntTp: Decimal;
        Days: Integer;
        OtherCommitementsClearance: Record "Other Commitements Clearance";
        Customer: Record Customer;
        EmployerName: Text;
        ProductFactory: Record "Product Factory";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LatestDatePaid: Date;
        LatestAmount: Decimal;
        DaysArreas: Integer;
        PCharges: Record "Loan Product Charges";
        TotalComputedCharges: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TotalCleared: Decimal;
        TopUp: Record "Loans Top up";
        ChargeExtraComms: Boolean;
        ExtclearanceCharge: Decimal;
        GeneralSetUp: Record "General Set-Up";
        boostingcharge: Decimal;
        PhoneNo: Code[20];
        Email: Text;
        Address: Text;
        Members: Record "Members";
        memberstatus: Option " ",New,Active,Dormant,Frozen,"Withdrawal Applicant",Withdrawn,Deceased,Defaulter,Closed,"Withdrawn Shareholder";
        SavingsAccounts: Record "Savings Accounts";
        Unallocated: Decimal;
        SalaryProcessing: Boolean;
}
