#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185447 "DMU Case Forwarded"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/DMU Case Forwarded.rdl';

    dataset
    {
        dataitem("DMU Case Forwarding"; "DMU Case Forwarding")
        {
            RequestFilterFields = "No.", "Case Intructions", "Employer Code", Period, "Current Departmrnt", "Case Closed", "Open Issues";
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
            column(ActioningOfficer; ActioningOfficer)
            {

            }

            dataitem("DMU Case Forwarding Lines"; "DMU Case Forwarding Lines")
            {
                DataItemLink = "Header No." = field("No.");
                column(MemberNo; MemberNo)
                {

                }
                column(PayrollNumber; PayrollNumber)
                {

                }
                column(MemberName; MemberName)
                {

                }
                column(LoanNumber; LoanNumber)
                {

                }
                column(ProductCode; ProductCode)
                {

                }
                column(AmountInArrears; AmountInArrears)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    MemberNo := "DMU Case Forwarding Lines"."Member Number";
                    if Members.Get(MemberNo) then begin
                        PayrollNumber := Members."Payroll/Staff No.";
                        MemberName := Members.Name;

                    end;
                    LoanNumber := "DMU Case Forwarding Lines"."Loan Number";
                    if Loans.Get(LoanNumber) then begin
                        ProductCode := Loans."Loan Product Type";
                        //Loans.CalcFields("Amount In Arreas");
                        // AmountInArrears := LoansProcess.CalculateAmountInArrears(Loans, Today, RunLoan);
                        LoansProcess.CalculateLoanArrears(Loans, AmountInArrears, Loans."Amount In Arreas SASRA", Today, True);
                    end;

                end;


            }

            trigger OnPreDataItem()
            begin
                intProgressTotal := Count;
                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnAfterGetRecord()
            begin

                CFTracker.Reset();
                CFTracker.SetRange("Header No.", "DMU Case Forwarding"."No.");
                if CFTracker.FindFirst() then begin
                    ActioningOfficer := GlobalFunctions.FormatUserName(CFTracker."Forwarded By");
                end;

                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
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

        //Line columns
        MemberNo: Text;
        PayrollNumber: Text;
        MemberName: Text;
        LoanNumber: Text;
        ProductCode: Text;
        AmountInArrears: Decimal;
        ActioningOfficer: Text;

        //Other Variables
        Members: Record Members;
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LoansProcess: Codeunit "Loans Process";
        DaysInArrears: Integer;
        RunLoan: Boolean;
        Counter: Integer;
        SASRACategory: Record "SASRA Categorization";
        LoanAge: Integer;
        AsAt: Date;
        Loans: Record Loans;
        CFTracker: Record "CF Tracker";

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
