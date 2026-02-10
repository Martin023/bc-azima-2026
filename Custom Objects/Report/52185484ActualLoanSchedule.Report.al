#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185484 "Actual Loan Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Actual RepaymentSchedule.rdl';
    UsageCategory = ReportsAndAnalysis;
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
            column(Disbursement_Date; Format("Disbursement Date", 0, 4))
            {

            }
            column(PPlusIAmount; PPlusIAmount)
            {

            }
            column(PrincipleBalance; PrincipleBalance)
            {

            }
            column(FutureInterest; FutureInterest)
            {

            }
            dataitem("Actual Loan Schedule"; "Actual Loan Schedule")
            {
                DataItemLink = "Loan Number" = field("Loan No.");
                DataItemTableView = sorting("Loan Number", "Repayment Date");
                column(No_; "No.")
                {
                }
                column(Repayment_Date; Format("Repayment Date", 0, 4))
                {
                }
                column(Expected_Interest; "Expected Interest")
                {

                }
                column(Interest_Payments; "Interest Payments")
                {
                }
                column(InterestBalance; InterestBalance)
                {

                }
                column(Expected_Principle; "Expected Principle")
                {

                }
                column(Principle_Payments; "Principle Payments")
                {
                }
                column(Principle_Balance; "Principle Balance")
                {
                }
                column("TotalExpectedPayments"; ("Expected Interest" + "Expected Principle"))
                {
                }
                column(Total_Actual_Repayment; ("Interest Payments" + "Principle Payments"))
                {
                }

                column(PPlusIBalance; (InterestBalance + "Principle Balance"))
                {
                }
                column(P___Future_Interest; "P + Future Interest")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    InterestBalance -= "Interest Payments";
                end;
            }
            trigger OnAfterGetRecord()
            var
                ActualLoanSchedule: Record "Actual Loan Schedule";
                IdealSchedule: Record "Ideal Repayment Schedule";
                NextPeriodDate: Date;
            begin
                ActualLoanSchedule.Reset();
                ActualLoanSchedule.SetRange("Loan Number", Loans."Loan No.");
                if ActualLoanSchedule.Find('-') then begin
                    ActualLoanSchedule.CalcSums("Principle Payments", "Total Actual Repayment", "Expected Interest");
                    TotalInterest := ActualLoanSchedule."Expected Interest";
                    InterestBalance := TotalInterest;
                end;

                Loans.CalcFields("Outstanding Balance", "Interest Paid");

                if Loans."Source Aplication" = Loans."Source Aplication"::BC then begin
                    PrincipleBalance := Loans."Outstanding Balance";
                    FutureInterest := ActualScheduleCodeunit.GenerateFutureInterest(Loans);
                    PPlusIAmount := Loans."Approved Amount" + FutureInterest;
                end else begin
                    PrincipleBalance := Loans."Outstanding Balance";
                    FutureInterest := ActualScheduleCodeunit.GenerateFutureInterest(Loans);
                    PPlusIAmount := Loans."Approved Amount" + FutureInterest;
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

        //Other Variables
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        Rshedule: Record "Ideal Repayment Schedule";
        TotalInterest: Decimal;
        PPlusIAmount: Decimal;
        PrincipleBalance: Decimal;
        InterestBalance: Decimal;
        FutureInterest: Decimal;
        ActualScheduleCodeunit: Codeunit ActualLoanSchedule;


}
