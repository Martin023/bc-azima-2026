#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185819 "Standing Order II"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Standing Order II.rdl';

    dataset
    {
        dataitem("Standing Order Header"; "Standing Order Header")
        {
            RequestFilterFields = Status;
            column(ReportForNavId_22; 22)
            {
            }
            column(Status; "Standing Order Header".Status)
            {
            }
            dataitem("Standing Order Lines"; "Standing Order Lines")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_1; 1)
                {
                }
                column(DocumentNo; "Standing Order Lines"."Document No.")
                {
                }
                column(DestinationAccountType; "Standing Order Lines"."Destination Account Type")
                {
                }
                column(DestinationAccountNo; "Standing Order Lines"."Destination Account No.")
                {
                }
                column(DestinationAccountName; "Standing Order Lines"."Destination Account Name")
                {
                }
                column(LoanNo; "Standing Order Lines"."Loan No.")
                {
                }
                column(Amount; "Standing Order Lines".Amount)
                {
                }
                column(Balance; "Standing Order Lines".Balance)
                {
                }
                column(MemberNo; "Standing Order Lines"."Member No")
                {
                }
                column(Picture; Company.Picture)
                {
                }
                column(Address; Company.Address)
                {
                }
                column(Company_Name; Company.Name)
                {
                }
                column(LoanBalance; LoanBal)
                {
                }
                column(InterestBalance; IntBal)
                {
                }
                column(SasraStatus; LoanStatus)
                {
                }
                column(SourceAccount; SourceAcc)
                {
                }
                column(EndDate; EndDate)
                {
                }
                column(MbrNo; MbrNo)
                {
                }
                column(EffectiveDate; EffectiveDate)
                {
                }
                column(LoanType; LoanType)
                {
                }
                column(EmployerCode; EmployerName)
                {
                }
                column(LoanProductName; LoanProductName)
                {
                }
                column(ApprovedAmount; ApprovedAmount)
                {
                }
                column(Installments; Installments)
                {
                }
                column(DisbursementDate; DisbursementDate)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    StoNo := '';
                    SourceAcc := '';
                    EndDate := 0D;
                    LoanType := '';
                    EmployerCode := '';
                    MbrNo := '';
                    EffectiveDate := 0D;
                    EmployerName := '';
                    LoanProductName := '';


                    Header.Reset;
                    Header.SetRange("No.", "Standing Order Lines"."Document No.");
                    //Header.SETFILTER(Status,'%1',Header.Status::Approved);
                    if Header.FindFirst then begin

                        SourceAcc := Header."Source Account No.";
                        EndDate := Header."End Date";
                        EffectiveDate := Header."Effective/Start Date";
                        MbrNo := Header."Member No.";
                        Members.Reset;
                        Members.SetRange("No.", Header."Member No.");
                        if Members.Find('-') then begin
                            EmployerCode := Members."Employer Code";
                            Customer.Reset;
                            Customer.SetRange("No.", EmployerCode);
                            Customer.SetFilter("Account Type", '%1', Customer."account type"::Employer);
                            if Customer.FindFirst then begin
                                EmployerName := Customer.Name;

                            end;
                        end;
                        LoanBal := 0;
                        IntBal := 0;
                        if "Standing Order Lines"."Destination Account Type" = "Standing Order Lines"."destination account type"::Credit then begin
                            Loans.Reset;
                            Loans.SetRange("Loan No.", "Standing Order Lines"."Loan No.");
                            if Loans.FindFirst then begin
                                Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Loans Category-SASRA");
                                LoanStatus := Loans."Loans Category-SASRA";
                                LoanBal := Loans."Outstanding Balance";
                                IntBal := Loans."Outstanding Interest";
                                LoanType := Loans."Loan Product Type Name";
                                ApprovedAmount := Loans."Approved Amount";
                                DisbursementDate := Loans."Disbursement Date";
                                Installments := Loans.Installments;

                            end;
                        end;
                    end else
                        CurrReport.Skip;
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
        if Company.Get() then
            Company.CalcFields(Company.Picture);
    end;

    var
        Loans: Record Loans;
        LoanBal: Decimal;
        IntBal: Decimal;
        LoanStatus: Enum "Loan Sasra categories";//Option Perfoming,Watch,Substandard,Doubtful,Loss;
        Header: Record "Standing Order Header";
        StoNo: Code[20];
        SourceAcc: Code[20];
        EndDate: Date;
        Company: Record "Company Information";
        MbrNo: Code[10];
        EmployerCode: Code[10];
        EffectiveDate: Date;
        LoanType: Text;
        Members: Record "Members";
        Customer: Record Customer;
        EmployerName: Text;
        LoanProductName: Text;
        ApprovedAmount: Decimal;
        Installments: Decimal;
        DisbursementDate: Date;
}
