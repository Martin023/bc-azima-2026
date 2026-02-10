#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185423 "Posted Loans Checkoff"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Posted Loans Checkoff.rdl';

    dataset
    {
        dataitem("Checkoff Header"; "Checkoff Header")
        {
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = "No.", "Posting Date", "Account No.";
            column(No_; "No.")
            {
            }
            column(CheckOff_Type; "CheckOff Type")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Account_Type; "Account Type")
            {
            }
            column(Account_No_Head; "Account No.")
            {
            }
            column(Posting_Period; "Posting Period")
            {
            }
            column(Entered_By; "Entered By")
            {

            }
            column(PostedHead; Posted)
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

            dataitem("Checkoff Lines"; "Checkoff Lines")
            {
                DataItemLink = "Checkoff Header" = field("No.");

                column(Repayment; Repayment)
                {

                }
                column(Loan_No_; "Loan No.")
                {

                }
                column(Account_No_; "Account No.")
                {

                }
                column(MemName; MemName)
                {

                }
                column(MemNo; MemNo)
                {

                }
                column(Payroll; Payroll)
                {

                }
                column(EmpCode; EmpCode)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    if Loans.get("Checkoff Lines"."Account No.") then begin
                        Members.Get(Loans."Member No.");
                        MemName := Members.Name;
                        MemNo := Members."No.";
                        EmpCode := Members."Employer Code";
                        Payroll := Members."Payroll/Staff No.";
                        Repayment := 0;

                    end;

                    repeat
                        Loans.Reset();
                        Loans.SetRange("Loan No.", "Checkoff Lines"."Loan No.");
                        if Loans.FindFirst() then begin
                            CreditLedgerEntry.Reset();
                            CreditLedgerEntry.SetRange("Customer No.", "Checkoff Lines"."Account No.");
                            CreditLedgerEntry.SetRange("Document No.", "Checkoff Lines"."Checkoff Header");
                            if CreditLedgerEntry.FindFirst() then begin
                                Repayment := CreditLedgerEntry."Credit Amount";
                            end;
                        end;
                    until "Checkoff Lines".Next() = 0;

                end;

            }
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

    var

        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MemName: Text[100];
        EmpCode: Code[100];
        Payroll: Code[100];
        MemNo: Code[100];
        CreditLedgerEntry: Record "Credit Ledger Entry";
        Loans: Record Loans;
        Members: Record Members;
        Repayment: Decimal;
}
