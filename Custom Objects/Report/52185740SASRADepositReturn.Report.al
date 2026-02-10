#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185740 "SASRA Deposit Return"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/SASRA Deposit Return.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Balance (LCY)" = filter(<> 0), "SASRA Savings Category" = filter(<> " "));
            RequestFilterFields = "No.", "Employer Code", "Member No.", "Date Filter";

            column(CompanyName; CompanyName)
            {

            }
            column(BalanceCategory; BalanceCategory)
            {

            }
            column(SASRA_Savings_Category; "SASRA Savings Category")
            {

            }
            column(SrNo; SrNo)
            {

            }
            column(FinancialYear; FinancialYear)
            {

            }
            column(StartDateTxt; StartDateTxt)
            {

            }
            column(EndDateTxt; EndDateTxt)
            {

            }
            column(Balance; Balance)
            {

            }
            trigger OnPreDataItem()
            begin

                if GetFilter("Date Filter") = '' then
                    Error('Kindly specify the date filter');


                if CopyStr(GetFilter("Date Filter"), 1, 1) = '.' then
                    StartDate := 19000101D
                else
                    StartDate := GetRangeMin("Date Filter");

                EndDate := GetRangeMax("Date Filter");

                EndDateTxt := GlobalFunctions.FormatDate(EndDate);

                FinancialYear := Date2DMY(EndDate, 3);

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
                "Savings Accounts".CalcFields(Balance);

                case "Savings Accounts".Balance of
                    -999999999.99 .. 49999.99:
                        begin
                            BalanceCategory := BalanceCategory::"Less than 50000";
                            SrNo := 1;
                        end;
                    50000.00 .. 99999.99:
                        begin
                            BalanceCategory := BalanceCategory::"50000 to 100000";
                            SrNo := 2;
                        end;
                    100000.00 .. 299999.99:
                        begin
                            BalanceCategory := BalanceCategory::"100000 to 300000";
                            SrNo := 3;
                        end;
                    300000.00 .. 999999.99:
                        begin
                            BalanceCategory := BalanceCategory::"300000 to 1000000";
                            SrNo := 4;
                        end;
                    1000000.00 .. 999999999.99:
                        begin
                            BalanceCategory := BalanceCategory::"Over 1000000";
                            SrNo := 5;
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
            area(content)
            {

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        //Columns
        FinancialYear: Integer;
        StartDate: Date;
        EndDate: Date;
        StartDateTxt: Text;
        EndDateTxt: Text;
        BalanceCategory: Option "Less than 50000","50000 to 100000","100000 to 300000","300000 to 1000000","Over 1000000";
        SrNo: Integer;

        //progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

        // OtherVar
        GlobalFunctions: Codeunit "Global Functions";

}
