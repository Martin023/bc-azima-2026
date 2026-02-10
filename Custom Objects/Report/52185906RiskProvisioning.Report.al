#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185906 "Risk Provisioning"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Risks Provisioning.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Total Balance";
            DataItemTableView = where("Total Balance" = filter(<> 0));
            RequestFilterFields = "Employer Code", "Member No.", "Disbursement Date", "Date Filter";

            column(CompanyName; CompanyName)
            {

            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {

            }
            column(SrNo; SrNo)
            {

            }
            column(TotalBal; TotalBal)
            {

            }
            column(Loan_Rescheduled; "Loan Rescheduled")
            {

            }
            column(Loan_No_; "Loan No.")
            {

            }
            column(RequiredProvision; RequiredProvision)
            {

            }
            column(RequiredProvisionAmt; RequiredProvisionAmt)
            {

            }
            column(Outstanding_Balance; "Outstanding Balance")
            {

            }

            trigger OnPreDataItem()
            begin

                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnAfterGetRecord()
            begin
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

                Loans.CalcFields("Loans Category-SASRA", "Outstanding Balance", "Outstanding Interest");
                TotalBal := 0;
                RequiredProvisionAmt := 0;
                OutBal := 0;
                outBal := Loans."Outstanding Balance";
                //RecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);
                TotalBal := Loans."Outstanding Balance" + "Outstanding Interest";

                case Loans."Loans Category-SASRA" of
                    Loans."Loans Category-SASRA"::Perfoming:
                        begin
                            SrNo := 1;
                            RequiredProvision := 0.01;
                            RequiredProvisionAmt := OutBal * RequiredProvision

                        end;
                    Loans."Loans Category-SASRA"::Watch:
                        begin
                            SrNo := 2;
                            RequiredProvision := 0.05;
                            RequiredProvisionAmt := OutBal * RequiredProvision
                        end;
                    Loans."Loans Category-SASRA"::Substandard:
                        begin
                            SrNo := 3;
                            RequiredProvision := 0.25;
                            RequiredProvisionAmt := OutBal * RequiredProvision
                        end;
                    Loans."Loans Category-SASRA"::Doubtful:
                        begin
                            SrNo := 4;
                            RequiredProvision := 0.5;
                            RequiredProvisionAmt := OutBal * RequiredProvision
                        end;
                    Loans."Loans Category-SASRA"::Loss:
                        begin
                            SrNo := 5;
                            RequiredProvision := 1;
                            RequiredProvisionAmt := OutBal * RequiredProvision
                        end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.CLOSE;
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

    end;

    var
        SrNo: Integer;
        RecoveryHeader: Record "Loan Recovery Header";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        RequiredProvision: Decimal;
        RequiredProvisionAmt: Decimal;


        //Task Progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;
}
