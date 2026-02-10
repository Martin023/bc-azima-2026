Report 52186021 "Insider Lending Report"
{

    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Insider Lending Report.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Account Category" = filter("Staff Member" | "Board Member"), Status = filter(<> Deceased));
            RequestFilterFields = "No.", "Employer Code";

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
            dataitem(NewLoans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where(Posted = const(true));
                RequestFilterFields = "Disbursement Date", "Date Filter";

                column(NewLoanNumnber; "Loan No.")
                {

                }
                column(NewBorrowerName; NewBorrowerName)
                {

                }
                column(NewMemberNumber; NewMemberNumber)
                {

                }
                column(NewPositionHeld; NewPositionHeld)
                {

                }
                column(NewLoanTypeName; NewLoanTypeName)
                {

                }
                column(NewAmmountAppliedFor; NewAmmountAppliedFor)
                {

                }
                column(NewAmountGranted; NewAmountGranted)
                {

                }
                column(NewDateApproved; NewDateApproved)
                {

                }
                column(NewBosaDeposits; NewBosaDeposits)
                {

                }
                column(NewNatureOfSecurity; NewNatureOfSecurity)
                {

                }
                column(NewRepaymentCommDate; NewRepaymentCommDate)
                {

                }
                column(NewRepaymentPeriod; NewRepaymentPeriod)
                {

                }
                column(NewOtherRemarks; NewOtherRemarks)
                {

                }
                column(NewSn; NewSn)
                {

                }
                trigger OnPreDataItem()
                begin
                    //NewLoans.Reset();
                    NewLoans.SetFilter("Disbursement Date", '%1..%2', startDate, endDate);
                    NewLoans.SetFilter("Date Filter", '..%1', endDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    NewNatureOfSecurity := '';
                    NewSn += 1;
                    i := 0;

                    NewLoanTypeName := NewLoans."Loan Product Type Name";
                    NewAmmountAppliedFor := NewLoans."Requested Amount";
                    NewAmountGranted := NewLoans."Approved Amount";
                    if NewLoans."Disbursement Date" <> 0D then
                        NewDateApproved := GlobalFunctions.DMUDateFormatDate(NewLoans."Disbursement Date");

                    if NewLoans."Repayment Start Date" <> 0D then
                        NewRepaymentCommDate := GlobalFunctions.DMUDateFormatDate(NewLoans."Repayment Start Date");
                    NewRepaymentPeriod := NewLoans.Installments;
                    NewOtherRemarks := '';




                    if Securities.Count > 0 then
                        Securities.RemoveRange(1, Securities.Count);

                    LoanGuarantors.Reset;
                    LoanGuarantors.SetRange("Loan No", NewLoans."Loan No.");
                    if LoanGuarantors.Find('-') then begin
                        repeat
                            if not Securities.Contains(Format(LoanGuarantors."Guarantor Type")) then
                                Securities.Add(Format(LoanGuarantors."Guarantor Type"));
                        until LoanGuarantors.Next() = 0;
                    end else
                        NewNatureOfSecurity := 'None';

                    Security := '';
                    foreach Security in Securities do begin
                        i += 1;
                        if i = Securities.Count then
                            NewNatureOfSecurity += Security + '.'
                        else
                            NewNatureOfSecurity += Security + ' ,';
                    end;

                    NewPositionHeld := Format(Members."Account Category");

                end;
            }
            dataitem(OldLoans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where(Posted = const(true));
                RequestFilterFields = "Disbursement Date", "Date Filter";
                CalcFields = "Total Balance";

                column(OldLoanNumnber; "Loan No.")
                {

                }
                column(OldBorrowerName; OldBorrowerName)
                {

                }
                column(OldMemberNumber; OldMemberNumber)
                {

                }
                column(OldPositionHeld; OldPositionHeld)
                {

                }
                column(OldLoanTypeName; OldLoanTypeName)
                {

                }
                column(OldAmmountAppliedFor; OldAmmountAppliedFor)
                {

                }
                column(OldAmountGranted; OldAmountGranted)
                {

                }
                column(OldDateApproved; OldDateApproved)
                {

                }
                column(OldBosaDeposits; OldBosaDeposits)
                {

                }
                column(OldNatureOfSecurity; OldNatureOfSecurity)
                {

                }
                column(OldRepaymentCommDate; OldRepaymentCommDate)
                {

                }
                column(OldRepaymentPeriod; OldRepaymentPeriod)
                {

                }
                column(OldOutstandingAmount; OldOutstandingAmount)
                {

                }
                column(OldPerfomanceCategory; OldPerfomanceCategory)
                {

                }
                column(OldNo; OldNo)
                {

                }

                trigger OnPreDataItem()
                begin
                    OldLoans.SetFilter("Disbursement Date", '<%1', startDate);
                    OldLoans.SetFilter("Date Filter", '..%1', endDate);
                    OldLoans.setfilter("Total Balance", '<>0');
                end;

                trigger OnAfterGetRecord()
                begin
                    OldNatureOfSecurity := '';
                    OldNo += 1;
                    OldLoanTypeName := OldLoans."Loan Product Type Name";
                    OldAmmountAppliedFor := OldLoans."Requested Amount";
                    OldAmountGranted := OldLoans."Approved Amount";
                    if OldLoans."Disbursement Date" <> 0D then
                        OldDateApproved := GlobalFunctions.DMUDateFormatDate(OldLoans."Disbursement Date");


                    if OldLoans."Repayment Start Date" <> 0D then
                        OldRepaymentCommDate := GlobalFunctions.DMUDateFormatDate(OldLoans."Repayment Start Date");
                    OldRepaymentPeriod := OldLoans.Installments;

                    //RecoveryHeader.GetLoanBalances(OldLoans."Loan No.", OutInt, OutBal, OldOutstandingAmount);

                    OldLoans.CalcFields("Loans Category-SASRA", "Outstanding Balance", "Outstanding Interest");
                    OldOutstandingAmount := OldLoans."Outstanding Balance" + OldLoans."Outstanding Interest";
                    OldPerfomanceCategory := Format(OldLoans."Loans Category-SASRA");

                    if Securities.Count > 0 then
                        Securities.RemoveRange(1, Securities.Count);

                    LoanGuarantors.Reset;
                    LoanGuarantors.SetRange("Loan No", OldLoans."Loan No.");
                    if LoanGuarantors.Find('-') then begin
                        repeat
                            if not Securities.Contains(Format(LoanGuarantors."Guarantor Type")) then
                                Securities.Add(Format(LoanGuarantors."Guarantor Type"));
                        until LoanGuarantors.Next() = 0;
                    end else
                        OldNatureOfSecurity := 'None';

                    Security := '';
                    i := 0;
                    foreach Security in Securities do begin
                        i += 1;
                        if i = Securities.Count then
                            OldNatureOfSecurity += Security + '.'
                        else
                            OldNatureOfSecurity += Security + ' ,';
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
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

                NewBorrowerName := Members.Name;
                OldBorrowerName := Members.Name;

                NewMemberNumber := Members."No.";
                OldMemberNumber := Members."No.";

                // Officials.Reset();
                // Officials.SetRange("Member Number", Members."No.");
                // Officials.SetRange(Retired, false);
                // if Officials.FindFirst() then begin
                //     NewPositionHeld := Officials.Position;
                //     OldPositionHeld := Officials.Position;
                // end;

                // if NewPositionHeld = '' then begin
                //     NewPositionHeld := Format(Members."Account Category");
                //     OldPositionHeld := Format(Members."Account Category");
                // end;

                OldPositionHeld := Format(Members."Account Category");

                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                SavingsAccounts.SetFilter("Date Filter", '..%1', endDate);
                if SavingsAccounts.FindFirst() then begin
                    SavingsAccounts.CalcFields(Balance);
                    NewBosaDeposits := SavingsAccounts.Balance;
                    OldBosaDeposits := SavingsAccounts.Balance;
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
                group(DateFilters)
                {
                    field(startDate; startDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the start date for the report.';
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the end date for the report.';
                        Caption = 'End Date';
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


        if startDate = 0D then Error('Please select the start date for the report.');
        if endDate = 0D then Error('Please select the end date for the report.');
    end;

    var

        //Colums
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;


        //New Loans Columns
        NewBorrowerName: Text;
        NewMemberNumber: Text;
        NewPositionHeld: Text;
        NewLoanTypeName: Text;
        NewAmmountAppliedFor: Decimal;
        NewAmountGranted: Decimal;
        NewDateApproved: Text;
        NewBosaDeposits: Decimal;
        NewNatureOfSecurity: Text;
        NewRepaymentCommDate: Text;
        NewRepaymentPeriod: Integer;
        NewOtherRemarks: Text;
        NewSn: Integer;


        //Old Loans Columns
        OldBorrowerName: Text;
        OldMemberNumber: Text;
        OldPositionHeld: Text;
        OldLoanTypeName: Text;
        OldAmmountAppliedFor: Decimal;
        OldAmountGranted: Decimal;
        OldDateApproved: Text;
        OldBosaDeposits: Decimal;
        OldNatureOfSecurity: Text;
        OldRepaymentCommDate: Text;
        OldRepaymentPeriod: Integer;
        OldOutstandingAmount: Decimal;
        OldPerfomanceCategory: Text;
        OldNo: Integer;

        //Request Fields
        // UpdateInsiders: Boolean;

        //Other Variable
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
        RecoveryHeader: Record "Loan Recovery Header";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        Officials: Record "Delegate Officials";
        SavingsAccounts: Record "Savings Accounts";
        LoanGuarantors: Record "Loan Guarantors and Security";
        i: Integer;
        Securities: list of [Text];
        Security: Text;

        //progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

        startDate: Date;
        endDate: Date;
}

