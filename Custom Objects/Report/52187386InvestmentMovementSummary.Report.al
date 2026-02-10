Report 52187386 "Investment Movement Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Investment Movement Summary.rdl';

    dataset
    {
        dataitem("Investment Header"; "Investment Header")
        {
            DataItemTableView = where(Status = filter(Fulfilled));
            column(ReportForNavId_1; 1)
            {
            }
            column(Investment_Type_Code; "Investment Type Code")
            {
            }
            column(Investment_Type_Description; "Investment Type Description")
            {
            }
            column(Start; StartDate)
            {
            }
            column("End"; EndDate)
            {
            }
            column(Maturity_Date; "Maturity Date")
            {
            }
            column(Interest_Rate; "Interest Rate")
            {
            }
            column(Status; Status)
            {
            }
            // dataitem("Investment Lines"; "Investment Lines")
            // {
            //     column(Face_Value; "Face Value")
            //     {
            //     }
            //     column(Interest_Amount; "Interest Amount")
            //     {
            //     }
            //     column(Wht_Tax_Amount; "Wht Tax Amount")
            //     {
            //     }

            trigger OnAfterGetRecord()
            begin
                OpenBal := 0;
                CloseBal := 0;

                InvestIntHeader.SetRange(Posted, true);

                InvestIntHeader.SetRange("Posting Date");


                // TotalApproved := 0;
                // TotalIntPaid := 0;
                // totalPrincPaid := 0;

                // Loans.Reset;
                // Loans.SetRange("Loan Product Type", "Product Factory"."Product ID");
                // Loans.SetRange("Approval Date", StartDate, EndDate);
                // Loans.SetRange(Posted, true);
                // if Loans.Find('-') then begin
                //     repeat
                //         TotalApproved += Loans."Approved Amount";
                //     until Loans.Next = 0;
                // end;

                // Loans.Reset;
                // Loans.SetRange("Loan Product Type", "Product Factory"."Product ID");
                // Loans.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                // Loans.SetRange(Posted, true);
                // if Loans.Find('-') then begin
                //     repeat
                //         Loans.CalcFields("Interest Paid", "Principle Paid", "Outstanding Balance", "Outstanding Interest");
                //         //TotalApproved+=Loans."Approved Amount";
                //         TotalIntPaid += Abs(Loans."Interest Paid");
                //         totalPrincPaid += Abs(Loans."Principle Paid");
                //     until Loans.Next = 0;

                // end;
            end;
            // }



            trigger OnPreDataItem()
            begin
                if StartDate = 0D then Error('Kindly set the start date');
                if EndDate = 0D then Error('Kindly set the end date');
                Company.Get;
                Company.CalcFields(Picture);
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
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

    var
        StartDate: Date;
        EndDate: Date;
        Company: Record "Company Information";
        OpenBal: Decimal;
        CloseBal: Decimal;
        InvestLines: Record "Investment Lines";
        InvestIntLines: Record "Investment Interest Lines";
        InvestIntHeader: Record "Investment Interest Header";

}

