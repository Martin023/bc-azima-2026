#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186012 "Pre Dividend Checks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Pre Dividend Checks.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            // DataItemTableView = where("Dividend Action" = const(Pay), Status = const(Active));
            column(ReportForNavId_1; 1)
            {
            }
            column(TopUpAmt; TopUpAmt)
            {
            }
            column(SaccoAmount; SaccoAmount)
            {
            }
            column(VendorAmt; VendorAmt)
            {
            }
            column(UpfrontInterest; UpfrontInterest)
            {
            }
            column(MaxQual; MaxQual)
            {
            }
            column(TotalDefaulted; TotalDefaulted)
            {
            }
            column(ExciseDuty; ExciseDuty)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(NetTakeHome; NetTakeHome)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalDefaulted := 0;
                TopUpAmt := 0;
                SaccoAmount := 0;
                VendorAmt := 0;
                UpfrontInterest := 0;
                NetTakeHome := 0;
                if not HasDefaulted2(Members."No.") then CurrReport.Skip;



                WorkerT2.Init;
                WorkerT2."Member No" := Members."No.";
                WorkerT2.Name := Members.Name;
                WorkerT2.Insert;
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
        WorkerT2.Reset;
        WorkerT2.DeleteAll;
    end;

    var
        TopUpAmt: Decimal;
        SaccoAmount: Decimal;
        VendorAmt: Decimal;
        MinQual: Decimal;
        MaxQual: Decimal;
        CanApply: Boolean;
        msg: Text;
        UpfrontInterest: Decimal;
        NetTakeHome: Decimal;
        TotalDefaulted: Decimal;
        ExciseDuty: Decimal;
        WorkerT2: Record "Worker T 2";


    procedure DividendAdvanceChecks(MemberNo: Code[30]; var MinimumQualification: Decimal; var MaximumQualification: Decimal; UserCanApply: Boolean; var Msg: Text)
    var
        Continue: Boolean;
        Members: Record "Members";
        Loans: Record Loans;
        LoanRep: Decimal;
        ProductFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        FOSAAcc: Code[30];
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        // SkyMbanking: Codeunit "Sky Mbanking";
        LoanBal: Decimal;
    begin
        Continue := true;
        if Members.Get(MemberNo) then begin

            ProductFactory.Get('136');

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", Members."No.");
            SavingsAccounts.SetRange("Product Type", '505');
            if SavingsAccounts.FindFirst then begin
                FOSAAcc := SavingsAccounts."No.";
            end;

            MaximumQualification := 0;
            MinimumQualification := 0;
            //MaximumQualification := SkyMbanking.GetDividendLoanQualifiedAmount(FOSAAcc, ProductFactory."Product ID");
            if MaximumQualification > ProductFactory."Mobile Max. Loan Amount" then
                MaximumQualification := ProductFactory."Mobile Max. Loan Amount";

            MinimumQualification := ProductFactory."Mobile Min. Loan Amount";
            if MaximumQualification < ProductFactory."Mobile Min. Loan Amount" then begin
                MinimumQualification := 0;
                MaximumQualification := 0;
                Continue := false;
                MaximumQualification := 0;
                MinimumQualification := 0;
                Msg := 'You are not eligible for this loan';
            end;

            Loans.Reset;
            Loans.SetRange("Member No.", MemberNo);
            Loans.SetRange("Loan Product Type", '136');
            Loans.SetFilter("Outstanding Balance", '>0');
            if Loans.FindFirst then begin
                Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                LoanBal := Loans."Outstanding Interest" + Loans."Outstanding Balance";
            end;

            MaximumQualification -= LoanBal;
        end;
    end;

    local procedure HasDefaulted(MemberNo: Code[30]; var TotalDefaulted: Decimal; var TopUpCharge: Decimal; var SaccoFee: Decimal; var VendorFee: Decimal; var TotalExcise: Decimal) HasDefaulted: Boolean
    var
        Loans: Record Loans;
        CoopSetup: Record "Sky Mobile Setup";
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        ExciseDuty: Decimal;
        Amt: Decimal;
        ExciseDuty1: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        PCharges: Record "Loan Product Charges";
        TopUpAmt: Decimal;
        ExciseDutyRate: Decimal;
    // SkyMbanking: Codeunit "Sky Mbanking";
    begin
        HasDefaulted := false;
        TotalDefaulted := 0;
        ExciseDuty1 := 0;
        Amt := 0;
        VendorCommission := 0;
        SaccoFee := 0;
        ExciseDuty := 0;

        Loans.Reset;
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Loans Category-SASRA", '%1|%2|%3|%4', Loans."loans category-sasra"::Watch, Loans."loans category-sasra"::Substandard,
                Loans."loans category-sasra"::Doubtful, Loans."loans category-sasra"::Loss);
        Loans.SetFilter("Outstanding Balance", '>0');
        if Loans.FindFirst then begin
            HasDefaulted := true;
            repeat
                TopUpAmt := 0;
                Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                TotalDefaulted += Loans."Outstanding Balance" + Loans."Outstanding Interest";
                TopUpAmt := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                if PCharges.Find('-') then begin
                    repeat
                        if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                            Amt += (TopUpAmt * (PCharges.Percentage / 100))
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                                Amt += PCharges."Charge Amount"
                            else
                                if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                    PCharges.TestField(PCharges."Staggered Charge Code");

                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                    if TariffDetails.Find('-') then begin
                                        repeat
                                            if (TopUpAmt >= TariffDetails."Lower Limit") and (TopUpAmt <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    Amt += TopUpAmt * TariffDetails.Percentage * 0.01;
                                                end
                                                else begin
                                                    Amt += TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;

                        if PCharges.Maximum > 0 then
                            if Amt > PCharges.Maximum then
                                Amt := PCharges.Maximum;

                        //If excise duty involved
                        if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin

                            //ExciseDutyRate := SkyMbanking.GetExciseRate();
                            ExciseDuty += Amt * ExciseDutyRate / 100;
                        end;
                    until PCharges.Next = 0;
                end;
            until Loans.Next = 0;
        end else
            HasDefaulted := false;


        CoopSetup.Reset;
        CoopSetup.SetRange("Transaction Type", CoopSetup."transaction type"::"Loan Disbursement");
        if CoopSetup.FindFirst then begin
            SaccoFee := CoopSetup."Sacco Fee";
            VendorCommission := CoopSetup."Vendor Commission";

            TotalCharge := SaccoFee + VendorCommission;
            ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
        end
        else begin
            Error('Setup Missing for %1', CoopSetup."transaction type"::"Loan Disbursement");
        end;

        TotalExcise := ExciseDuty + ExciseDuty1;
    end;

    local procedure HasDefaulted2(MemberNo: Code[30]) HasDefaulted: Boolean
    var
        Loans: Record Loans;
        CoopSetup: Record "Sky Mobile Setup";
        VendorCommission: Decimal;
        TotalCharge: Decimal;
        ExciseDuty: Decimal;
        Amt: Decimal;
        ExciseDuty1: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        PCharges: Record "Loan Product Charges";
        TopUpAmt: Decimal;
        ExciseDutyRate: Decimal;
    // SkyMbanking: Codeunit "Sky Mbanking";
    begin
        Loans.Reset;
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Loans Category-SASRA", '%1|%2|%3|%4', Loans."loans category-sasra"::Watch, Loans."loans category-sasra"::Substandard,
                Loans."loans category-sasra"::Doubtful, Loans."loans category-sasra"::Loss);
        Loans.SetFilter("Outstanding Balance", '>0');
        if Loans.FindFirst then begin
            HasDefaulted := true;
        end else
            HasDefaulted := false;
    end;
}
