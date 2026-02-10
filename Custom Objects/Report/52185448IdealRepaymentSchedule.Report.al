#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185448 "Ideal Repayment Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Ideal Repayment Schedule.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {

            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(Member_No; "Member No.")
            {
            }
            column(Loan_No; "Loan No.")
            {
            }
            column(Member_Name; "Member Name")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(TotalInterest; TotalInterest)
            {

            }
            column(PPlusIAmount; PPlusIAmount)
            {

            }
            column(Disbursement_Date; Format("Disbursement Date", 0, 4))
            {

            }


            dataitem("Ideal Repayment Schedule"; "Ideal Repayment Schedule")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Loan No.", "Member No.", "Repayment Date");


                column(Monthly_Repayment; ROUND("Monthly Repayment"))
                {
                }
                column(Repayment_Date; Format("Repayment Date", 0, 4))
                {
                }
                column(Principal_Repayment; ROUND("Principal Repayment"))
                {
                }
                column(Monthly_Interest; ROUND("Monthly Interest"))
                {
                }
                column(LoanBalance; ROUND("Ideal Loan Bal"))
                {
                }
                column(Repayment_Code; "Repayment Code")
                {
                }
                column(Monthly_Repayment_10; ROUND("Monthly Repayment"))
                {
                }
                column(Principal_Repayment_10; ROUND("Principal Repayment"))
                {
                }
                column(Monthly_Interest_10; ROUND("Monthly Interest"))
                {
                }
                column(InterestBal; ROUND(InterestBal))
                {
                }
                column(PPlusIBalance; ROUND(PPlusIBalance))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // i := i + 1;

                    // TotalPrincipalRepayment := TotalPrincipalRepayment + "Ideal Repayment Schedule"."Principal Repayment";
                    // if "Ideal Repayment Schedule"."Reset Schedule" then begin

                    //     if "Ideal Repayment Schedule"."Reset Doc No." = PreviousDocNo then begin
                    //         //MESSAGE('%1',TotalPrincipalRepayment);
                    //         TotalPrincipalRepayment2 := TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                    //         i2 := i2 + 1;
                    //         if i2 = 1 then
                    //             IdealLoanBalance := "Ideal Repayment Schedule"."Loan Amount"
                    //         else
                    //             IdealLoanBalance := "Ideal Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                    //     end else begin
                    //         i2 := 1;
                    //         //TotalPrincipalRepayment2:="Ideal Repayment Schedule"."Principal Repayment";
                    //         TotalPrincipalRepayment2 := TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                    //         IdealLoanBalance := "Ideal Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                    //         //MESSAGE('%1',PreviousDocNO);
                    //     end;
                    // end else begin
                    //     // if i = 1 then
                    //     //     IdealLoanBalance := "Ideal Repayment Schedule"."Loan Amount"
                    //     // else
                    //         IdealLoanBalance := "Ideal Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment ;//+ "Ideal Repayment Schedule"."Principal Repayment";
                    // end;

                    InterestBal -= "Ideal Repayment Schedule"."Monthly Interest";
                    PPlusIBalance -= "Ideal Repayment Schedule"."Principal Repayment" + "Ideal Repayment Schedule"."Monthly Interest";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Rshedule.Reset();
                Rshedule.SetRange("Loan No.", Loans."Loan No.");
                if Rshedule.Find('-') then begin
                    Rshedule.CalcSums("Monthly Interest");
                    TotalInterest := Round(Rshedule."Monthly Interest", 0.01, '>');
                    InterestBal := TotalInterest;
                end;

                PPlusIBalance := Loans."Approved Amount" + TotalInterest;
                PPlusIAmount := PPlusIBalance;
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);


    end;

    var
        //columns 
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        IdealLoanBalance: Decimal;
        i: Integer;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        TotalPrincipalRepayment: Decimal;
        i2: Integer;
        TotalPrincipalRepayment2: Decimal;
        PreviousDocNo: Code[10];
        TotalInterest: Decimal;
        InterestBal: Decimal;
        PPlusIBalance: Decimal;
        PPlusIAmount: Decimal;

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        Rshedule: Record "Ideal Repayment Schedule";

}
