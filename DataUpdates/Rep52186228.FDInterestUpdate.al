namespace KenpipeCBS.KenpipeCBS;

report 52186228 "FD Interest Update"
{
    ApplicationArea = All;
    Caption = 'FD Interest Update';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(FixedDepositContract; "Fixed Deposit Contract")
        {
            column(No; "No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                FDSetup.Reset();
                FDSetup.SetRange(FDSetup.Code, FixedDepositContract."Fixed Deposit Type");
                if FDSetup.Find('-') then begin
                    FDCalculation.Reset();
                    FDCalculation.SetRange(Code, FDSetup.Code);
                    if FDCalculation.FindFirst() then begin
                        //repeat
                        case
                            FixedDepositContract."Fixed Deposit Amount" of
                            FDCalculation."Minimum Amount" .. FDCalculation."Maximum Amount":
                                begin
                                    FixedDepositContract."Interest Rate" := FDCalculation."Interest Rate";
                                end;

                        end;
                        if FixedDepositContract."Application Date" <> 0D then begin
                            NoOfDays := Abs(FixedDepositContract."FD Maturity Date" - FixedDepositContract."Application Date");
                            FixedDepositContract."Forecasted Interest" := FixedDepositContract."Fixed Deposit Amount" * (FixedDepositContract."Interest Rate" / 100) * (NoOfDays / 365);
                        end;
                        FixedDepositContract.Modify;
                        //until FDCalculation.Next() = 0;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        FDSetup: Record "Fixed Deposit Type";
        FDCalculation: Record "FD Interest Calculation Rules";
        NoOfDays: Integer;
}
