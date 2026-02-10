#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186004 "Sectoral Lending"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Sector Lending.rdl';

    dataset
    {
        dataitem("Sectoral Classification"; "Sectoral Classification")
        {
            DataItemTableView = where("Sector Level" = const("Main Sector"));
            column("Sector_code"; "Sector Code")
            {

            }
            column(Main_sector_Description; "Sector Description")
            {

            }
            column(CompanyName;
            CompanyName)
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
            dataitem("Sectoral Classification II"; "Sectoral Classification")
            {
                DataItemTableView = where("Sector Level" = const("Sub Sector Level 1"));
                DataItemLink = "Parent Sector" = field("Sector Code");

                column(Sub_Sector_Level1;
                "Sectoral Classification II"."Sector Code")
                {
                }
                column(Sub_Sector_Level1_Description; "Sectoral Classification II"."Sector Description")
                {
                }
                dataitem("Sectoral Classification III"; "Sectoral Classification")
                {
                    DataItemTableView = where("Sector Level" = const("Sub Sector Level 2"));

                    DataItemLink = "Parent Sector" = field("Sector Code");

                    column(Sub_Sector_Level2_Description; "Sectoral Classification III"."Sector Description")
                    {

                    }
                    column(Sub_Sector_Level2; "Sectoral Classification III"."Sector Code")
                    {

                    }
                    column(TotalBal; TotalBal)
                    {

                    }

                    trigger OnAfterGetRecord()
                    begin
                        TotalBal := 0;
                        loans.reset;
                        loans.SetFilter("Disbursement Date", '%1..%2', StartDate, Enddate);
                        loans.SetRange("Sub Sector Level2", "Sectoral Classification III"."Sector Code");
                        if loans.FindSet() then begin
                            repeat
                                if loans."Net Amount" > 0 then
                                    TotalBal += Loans."Net Amount"
                                else
                                    TotalBal += Loans."Approved Amount";
                            until loans.Next() = 0;
                        end;
                    end;

                    trigger OnPostDataItem()
                    begin
                        //diaProgress.CLOSE;
                    end;
                }


                trigger OnPostDataItem()
                begin

                end;

                // dataitem(Loans; Loans)
                // {
                //     CalcFields = "Total Balance";
                //     DataItemTableView = where("Total Balance" = filter(<> 0));
                //     RequestFilterFields = "Employer Code", "Member No.", "Source Unit";

                //     column(CompanyName; CompanyName)
                //     {

                //     }
                //     column(Main_Sector; "Main Sector")
                //     {

                //     }
                //     column(Main_Sector_Description; "Main Sector Description")
                //     {

                //     }
                //     column(Sub_Sector_Level1; "Sub Sector Level1")
                //     {

                //     }
                //     column(Sub_Sector_Level1_Description; "Sub Sector Level1 Description")
                //     {

                //     }
                //     column(Sub_Sector_Level2; "Sub Sector Level2")
                //     {

                //     }
                //     column(Sub_Sector_Level2_Description; "Sub Sector Level2 Description")
                //     {

                //     }
                //     column(TotalBal; TotalBal)
                //     {

                //     }
                //     column(FinancialYear; FinancialYear)
                //     {

                //     }
                //     column(StartDateTxt; StartDateTxt)
                //     {

                //     }
                //     column(EndDateTxt; EndDateTxt)
                //     {

                //     }
                //     trigger OnPreDataItem()
                //     begin
                //         loans.SetFilter("Disbursement Date", '%1..%2', StartDate, Enddate);
                //         loans.SetFilter("Date Filter", '..%1', Enddate);

                //         // if GetFilter("Date Filter") = '' then
                //         //     Error('Kindly specify the date filter');

                //         // if CopyStr(GetFilter("Date Filter"), 1, 1) = '.' then
                //         //     StartDate := 19000101D
                //         // else
                //         //     StartDate := GetRangeMin("Date Filter");

                //         // EndDate := GetRangeMax("Date Filter");

                //         // EndDateTxt := GlobalFunctions.FormatDate(EndDate);

                //         FinancialYear := Date2DMY(Enddate, 3);

                //         intProgressTotal := COUNT;

                //         intProgressI := 0;
                //         TimeProgress := TIME;
                //         NoOfRecsProgress := intProgressTotal DIV 100;
                //         NoOfProgressed := 0;

                //         diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
                //     end;

                //     trigger OnAfterGetRecord()
                //     begin
                //         //Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                //         // TotalBal := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                //         if loans."Net Amount" > 0 then
                //             TotalBal := Loans."Net Amount"
                //         else
                //             TotalBal := Loans."Approved Amount";

                //         intProgressI += 1;
                //         if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                //             NoOfProgressed := NoOfProgressed + intProgressI;
                //             diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                //             intProgressI := 0;
                //             TimeProgress := TIME;
                //         end;
                //     end;

                //     trigger OnPostDataItem()
                //     begin
                //         diaProgress.CLOSE;
                //     end;
            }

            trigger OnAfterGetRecord()
            begin
                FinancialYear := Date2DMY(Enddate, 3);
                EndDateTxt := GlobalFunctions.FormatDate(EndDate);
                StartDateTxt := GlobalFunctions.FormatDate(StartDate);
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
                group(DateFilters)
                {
                    field(startDate; startDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the start date for the report.';
                        Caption = 'Disbursement Start Date';
                        ShowMandatory = true;
                    }
                    field(Enddate; Enddate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the end date for the report.';
                        Caption = 'Disbursement End Date';
                        ShowMandatory = true;
                    }
                }
            }
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
        if Enddate = 0D then Error('Please select the Disbursement End Date for the report.');
    end;

    var

        //Columns
        TotalBal: Decimal;
        FinancialYear: Integer;
        StartDate: Date;
        Enddate: date;
        StartDateTxt: Text;
        EndDateTxt: Text;


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
        Loans: record loans;

}

