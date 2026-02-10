#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186060 "Withdrawal TAT Report"
{
    Caption = 'Withdrawal TAT Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Withdrawal TAT Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Member withdrawal Notice"; "Member withdrawal Notice")
        {
            //DataItemTableView = where(Status = const(Approved));
            RequestFilterFields = "No.", "Notice Type", Status, "CRM Originating Branch";
            column(ReportForNavId_1; 1)
            {
            }
            column(NoofdaysRemaining; "No. of Days Remaining")
            {
            }
            column(Notice_Type; "Notice Type")
            {
            }
            column(No; "Member withdrawal Notice"."No.")
            {
            }
            column(Employer_Liability; "Employer Liability")
            {
            }
            column(MemberNo; "Member withdrawal Notice"."Member No.")
            {
            }
            column(CRM_Application_No_; "CRM Application No.")
            {
            }
            column(MemberName; "Member withdrawal Notice"."Name")
            {
            }
            column(Reasonforwithdrawal; "Member withdrawal Notice"."Reason for withdrawal")
            {
            }
            column(WithdrawaNoticelDate; "Member withdrawal Notice"."Withdrawal Notice Date")
            {
            }
            column(MaturityDate; "Member withdrawal Notice"."Maturity Date")
            {
            }
            column(DateApproved; DateApproved)
            {
            }
            column(ApprovedBy; ApprovedBy)
            {
            }
            column(PostedBy; PostedBy)
            {
            }
            column(PostedDate; PostedDate)
            {
            }
            column(Status; Status)
            {
            }
            column(BranchCode; "Global Dimension 1 Code")
            {
            }
            column(ClosureFees; ClosureFees)
            {
            }
            // column(EnteredBy; "Member withdrawal Notice"."Entered By")
            // {
            // }
            // column(DateEntered; "Member withdrawal Notice"."Date Entered")
            // {
            // }
            // column(TimeEntered; "Member withdrawal Notice"."Time Entered")
            // {
            // }
            // column(Status; "Member withdrawal Notice".Status)
            // {
            // }
            // column(NoSeries; "Member withdrawal Notice"."No. Series")
            // {
            // }
            column(LoansOutstandingBalance; "Member withdrawal Notice"."Loans Outstanding Balance")
            {
            }
            column(LoansOutstandingInterest; "Member withdrawal Notice"."Loans Outstanding Interest")
            {
            }
            column(TotalLoansOutstandingBalance; "Member withdrawal Notice"."Loans Outstanding Balance")
            {
            }
            column(MemberDeposit; "Member withdrawal Notice"."Member Deposit")
            {
            }
            column(ClosureDate; ClosureDate)
            {
            }
            column(Paid; Paid)
            {
            }
            column(Age; Age)
            {
            }
            column(Gender; Gender)
            {
            }
            column(PhoneNumber; PhoneNumber)
            {
            }
            column(EmployerCode; EmployerCode)
            {
            }
            column(MemberShares; MemberShares)
            {
            }
            column(MemberDeposits; MemberDeposits)
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(DatePaid; Datepaid)
            {
            }
            column(DepositRefunded; Refund)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*IF Membershipclosure.GET(Membershipclosure."Notice Number") THEN*/
                Paid := false;
                Datepaid := 0D;
                Refund := 0;
                PhoneNumber := '';
                Age := 0;
                EmployerCode := '';
                Gender := Gender::" ";
                MemberShares := 0;
                MemberDeposits := 0;
                ClosureFees := 0;
                PFNo := '';
                ClosureDate := 0D;
                DateApproved := ' ';
                ApprovedBy := '';
                PostedBy := '';
                PostedDate := '';
                TotalLoansOutstandingBalance := 0;
                //NoofdaysRemaining := 0;

                //NoofdaysRemaining := Membershipclosure."Maturity Date" - Today;
                Loans.Reset();
                Loans.SetRange(Loans."Member No.", "Member withdrawal Notice"."Member No.");
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                    TotalLoansOutstandingBalance := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                end;

                Membershipclosure.Reset;
                Membershipclosure.SetRange(Membershipclosure."Notice Number", "Member withdrawal Notice"."No.");
                if Membershipclosure.Find('-') then begin
                    repeat
                        Paid := Membershipclosure.Posted;
                        Datepaid := Membershipclosure."Closing Date";
                        Refund := Membershipclosure."Deposit Refundable";
                        ClosureFees := Membershipclosure."Closure Charges";
                        ClosureDate := Membershipclosure."Closing Date";
                        if Membershipclosure."Date Approved" <> 0D then
                            DateApproved := GlobalFunc.FormatDate(Membershipclosure."Date Approved");
                        ApprovedBy := Membershipclosure."Approved By";
                        PostedBy := Membershipclosure."Posted By";
                        if Membershipclosure."Date Posted" <> 0D then
                            PostedDate := GlobalFunc.FormatDate(Membershipclosure."Date Posted");
                    until Membershipclosure.Next = 0;
                end;

                Members.Reset();
                Members.SetRange(Members."No.", "Member withdrawal Notice"."Member No.");
                if Members.Find('-') then begin
                    PhoneNumber := Members."Phone No.";
                    //Age := Members.Age;
                    Age := Round(((Today - Members."Date of Birth") / 365), 1, '<');
                    EmployerCode := Members."Employer Code";
                    Gender := Members.Gender;
                    PFNo := Members."Payroll/Staff No.";

                    SavingAccounts.RESET;
                    SavingAccounts.SetRange("Member No.", Members."No.");
                    SavingAccounts.Setrange(SavingAccounts."Product Category", SavingAccounts."Product Category"::"BOSA Deposits");
                    if SavingAccounts.find('-') then begin
                        SavingAccounts.CalcFields("Balance (LCY)");
                        MemberDeposits := SavingAccounts."Balance (LCY)";
                    end;

                    SavingAccounts.RESET;
                    SavingAccounts.SetRange("Member No.", Members."No.");
                    SavingAccounts.Setrange(SavingAccounts."Product Category", SavingAccounts."Product Category"::"Share Capital");
                    if SavingAccounts.find('-') then begin
                        SavingAccounts.CalcFields("Balance (LCY)");
                        MemberShares := SavingAccounts."Balance (LCY)";
                    end;

                end;
            end;

            trigger OnPreDataItem()
            begin
                /*IF Membershipclosure.GET(Membershipclosure."Notice Number") THEN
                Paid:=Membershipclosure.Posted;
                Datepaid:=Membershipclosure."Closing Date";
                Refund:=Membershipclosure."Deposit Refundable";
                */

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
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;
    // begin
    //     if CI.Get() then
    //         CI.CalcFields(CI.Picture);
    // end;

    var
        Membershipclosure: Record "Membership closure";
        Paid: Boolean;
        Datepaid: Date;
        Refund: Decimal;
        Matured: Boolean;
        CompanyInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        PhoneNumber: Code[100];
        Age: Integer;
        EmployerCode: Code[100];
        Gender: Enum Gender;
        SavingAccounts: Record "Savings Accounts";
        MemberDeposits: Decimal;
        MemberShares: Decimal;
        ClosureFees: Decimal;
        PFNo: Code[100];
        ClosureDate: Date;
        DateApproved: Text;
        ApprovedBy: Code[150];
        PostedBy: Code[150];
        PostedDate: Text;
        GlobalFunc: Codeunit "Global Functions";
        NoofdaysRemaining: Integer;
        Loans: Record "Loans";
        TotalLoansOutstandingBalance: Decimal;
}
