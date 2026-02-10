#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185905 "Loan Approved Schedule Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Approved Schedule Details.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Status = filter(Approved), "Approved Amount" = filter(<> 0), "Dummy Appraisal" = filter(False));
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(LoanType; Loans."Loan Product Type")
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(DisbursementDate; Loans."Disbursement Date")
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
            column(TopUpComm; TopUpComm)
            {
            }
            column(BridgedAmt; BridgedAmt)
            {
            }
            column(SmsCost; SmsCost)
            {
            }
            column(RMFCharge; RMFCharge)
            {
            }
            column(RTGSFee; RTGSFee)
            {
            }
            column(TibaBoost; TibaBoost)
            {
            }
            column(CRBCharges; CRBCharges)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(ProductType; ProductType)
            {
            }
            column(BankAccNo; BankAccNo)
            {
            }
            column(ChequeAmt; ChequeAmt)
            {
            }
            column(InvestAmt; InvestAmt)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(NetAmount_Loans; Loans."Net Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin

                GeneralSetUp.Get();
                NetAmount := 0;
                ApprovedAmt := 0;
                BridgedAmt := 0;
                TopUpComm := 0;
                RMFCharge := 0;
                BridgedComm := 0;
                SmsCost := 0;
                RTGSFee := 0;
                TibaBoost := 0;
                InvestAmt := 0;
                ChequeAmt := 0;
                CRBCharges := 0;

                if Loans.Get("Loan No.") then begin
                    ApprovedAmt := Loans."Approved Amount";
                    StaffNo := Loans."Staff No";
                    ProductType := Loans."Loan Product Type Name";

                    //RMFCharge:=Loans."RMF Charged Amount";
                    TibaBoost := ROUND(Loans."Loans - Deposit Purchase", 1, '=');

                    PCharges.Reset;
                    PCharges.SetRange("Charge Code", '001');
                    PCharges.SetRange("Product Code", Loans."Loan Product Type");
                    PCharges.SetRange("Charge Type", PCharges."charge type"::General);
                    if PCharges.Find('-') then begin
                        repeat
                            if PCharges."Use Percentage" = true then
                                CRBCharges := ROUND(Loans."Approved Amount" * (PCharges.Percentage / 100), 1, '=')
                            else
                                CRBCharges := ROUND(PCharges."Charge Amount", 1, '=');
                        until PCharges.Next = 0;
                    end;

                    PCharges.Reset;
                    PCharges.SetRange("Charge Code", '002');
                    PCharges.SetRange("Product Code", Loans."Loan Product Type");
                    PCharges.SetRange("Charge Type", PCharges."charge type"::General);
                    if PCharges.Find('-') then begin
                        repeat
                            if PCharges."Use Percentage" = true then
                                RMFCharge := ROUND(Loans."Approved Amount" * (PCharges.Percentage / 100), 1, '=')
                            else
                                RMFCharge := ROUND(PCharges."Charge Amount", 1, '=');
                        until PCharges.Next = 0;
                    end;






                    Loans.CalcFields("Total TopUp");
                    if Loans."Total TopUp" > 0 then begin
                        BridgedL.Reset;
                        BridgedL.SetRange("Loan No.", Loans."Loan No.");
                        BridgedL.SetRange("Client Code", Loans."Member No.");
                        if BridgedL.FindSet() then begin
                            BridgedL.CalcSums("Total Top Up", "Principle Top Up");
                            BridgedAmt := ROUND(BridgedL."Total Top Up", 1, '=');
                            BridgedComm := ROUND(BridgedL."Principle Top Up", 1, '=');


                            PCharges.Reset;
                            PCharges.SetRange("Product Code", Loans."Loan Product Type");
                            PCharges.SetRange("Charge Type", PCharges."charge type"::"Top up");
                            if PCharges.Find('-') then begin
                                TopUpComm := ROUND((BridgedComm * (PCharges.Percentage / 100)), 1, '=');
                            end;
                        end;
                    end;

                    OtherCommit.Reset;
                    OtherCommit.SetRange("Loan No.", Loans."Loan No.");
                    if OtherCommit.FindSet(false, false) then begin
                        OtherCommit.CalcSums(Amount);
                        InvestAmt := ROUND(OtherCommit.Amount, 1, '=');
                    end;

                    OtherCommit.Reset;
                    OtherCommit.SetRange("Loan No.", Loans."Loan No.");
                    if OtherCommit.FindSet(false, false) then begin
                        OtherCommit.CalcSums(Amount);
                        ChequeAmt := ROUND(OtherCommit.Amount, 1, '=');
                    end;
                end;

                NetAmount := (ApprovedAmt - (TibaBoost + CRBCharges + SmsCost + RTGSFee + RMFCharge + TopUpComm + BridgedAmt + ChequeAmt + InvestAmt));


                NetAmount := ROUND((ApprovedAmt - (TibaBoost + CRBCharges + SmsCost + RTGSFee + RMFCharge + TopUpComm + BridgedAmt + ChequeAmt + InvestAmt)), 1, '=');
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
        if Company.Get() then
            Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        ApprovedAmt: Decimal;
        StaffNo: Code[50];
        BridgedAmt: Decimal;
        BridgedL: Record "Loans Top up";
        TopUpComm: Decimal;
        PCharges: Record "Loan Product Charges";
        RMFCharge: Decimal;
        SmsCost: Decimal;
        GeneralSetUp: Record "General Set-Up";
        RTGSFee: Decimal;
        TibaBoost: Decimal;
        CRBCharges: Decimal;
        BankCode: Code[50];
        ProductType: Code[50];
        BankAccNo: Code[20];
        ChequeAmt: Decimal;
        InvestAmt: Decimal;
        OtherCommit: Record "Other Commitements Clearance";
        BridgedComm: Decimal;
        NetAmount: Decimal;
        TotNetAmount: Decimal;
        BatchHeader: Record "Loan Disbursement Header";
        TotalNet: Decimal;
}
