namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186199 "Loan Monthly Receipt Report"
{
    ApplicationArea = All;
    Caption = 'Loan Monthly Receipt Report';
    RDLCLayout = './bc-azima-2026/Layout/Loans Monthly Receipt Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(posted = filter(true));
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
            column(No_; "Member No.")
            {
            }
            column(Name; "Member Name")
            {
            }
            column(Primary_Identification; PrimaryIdentification)
            {
            }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Repayment; Repayment)
            { }
            column(ExpectedInt; ExpectedInt)
            { }
            column(memStatus; memStatus)
            { }
            column(Loan_No_; "Loan No.")
            {
            }
            column(ReceivedPri; ReceivedPri)
            { }
            column(ReceivedInt; ReceivedInt) { }

            column(TotalExpected; TotalExpected)
            { }
            column(TotalReceived; TotalReceived)
            { }
            //column()
            trigger OnAfterGetRecord()
            begin
                ExpectedInt := 0;
                ReceivedPri := 0;

                if Members.get("Member No.")
                then begin
                    PrimaryIdentification := members."Primary Identification";
                    memStatus := Members.Status;
                end;
                Creditledger.SetRange("Loan No", "Loan No.");
                Creditledger.SetRange(Reversed, false);
                Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::"Repayment");
                Creditledger.CalcSums("Credit Amount (LCY)");
                ReceivedPri := Creditledger."Credit Amount (LCY)";

                Creditledger.SetRange("Loan No", "Loan No.");
                Creditledger.SetRange(Reversed, false);
                Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::"Interest Paid");
                Creditledger.CalcSums("Credit Amount (LCY)");
                ReceivedInt := Creditledger."Credit Amount (LCY)";

                TotalReceived := ReceivedPri + ReceivedInt;


                // Expected
                LoanRepaySchedule.reset;
                LoanRepaySchedule.SetRange("Loan No.", "Loan No.");
                LoanRepaySchedule.SetRange("Repayment Date", StartDate, EndDate);
                if LoanRepaySchedule.FindFirst() then
                    ExpectedInt := LoanRepaySchedule."Monthly Interest";

                TotalExpected := ExpectedInt + Loans.Repayment;
            end;

            trigger OnpreDataItem()
            begin
                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('Please select the start date and end date');

                TotalExpected := 0;
                TotalReceived := 0;

                // loans.Reset();
                // Loans.CalcFields("Total Loan Balance");
                // if loans."Total Loan Balance" < 0 then begin

                //     end;
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
                    field("Start Date"; StartDate) { }
                    field("End date"; EndDate) { }
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
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowTotoDetail: Boolean;
        Amount: decimal;
        CreditAcc: Record "Credit Accounts";
        CreatedBy: Text;
        Members: Record Members;
        BosaDep: Decimal;
        ProdFact: Record "Product Factory";
        Creditledger: Record "Credit Ledger Entry";
        LatPaydate: Date;
        SavLatPaydate: Date;
        GlobalFunc: Codeunit "Global Functions";
        LastPrRep: Decimal;
        lastP: Text;
        LastInPaid: Decimal;
        CreLedgerEntry: Record "Credit Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        PrimaryIdentification: code[50];
        LoanRepaySchedule: record "Ideal Repayment Schedule";
        ExpectedInt: Decimal;
        ReceivedPri: Decimal;
        Loanz: record loans;
        memStatus: enum "Member Status";
        ReceivedInt: Decimal;

        TotalExpected: Decimal;
        TotalReceived: Decimal;
}