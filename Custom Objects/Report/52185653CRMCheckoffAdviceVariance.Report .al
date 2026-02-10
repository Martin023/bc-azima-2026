#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186083 "CRM Checkoff Advice Variance"

{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CRM Checkoff Advice Variance.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'CRM Checkoff Advice Variance';

    dataset
    {
        dataitem("Checkoff Header"; "Checkoff Header")
        {
            //RequestFilterFields = "No.";
            column(ReportForNavId_2; 2)
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
            column(No_; "No.")
            {
            }
            dataitem("Checkoff Advice Line"; "Checkoff Advice Line")
            {
                DataItemLink = "Advice Header No." = field("No.");
                RequestFilterFields = "Member No.";
                column(ReportForNavId_1; 1)
                {
                }
                column(MemberNo; "Checkoff Advice Line"."Member No.")
                {
                }
                column(PayrollNo; "Checkoff Advice Line"."Payroll No")
                {
                }
                column(Name; Name)
                {
                }
                column(Amount; Amount)
                {
                }
                column(Interest; "Checkoff Advice Line".Interest)
                {
                }
                column(ProductFactory; "Checkoff Advice Line"."Product Search Code")
                {
                }
                column(CompanyName; Company.Name)
                {
                }
                // column(CompanyAddress; Company.Address)
                // {
                // }
                column(ComapnyPicture; Company.Picture)
                {
                }
                column(Period; "Checkoff Header"."Posting Period")
                {
                }
                column(EmployerName; "Checkoff Header"."Employer Name")
                {
                }
                column(PostedInterest; PostedInterest)
                {
                }
                column(PostedAmount; PostedAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Members.Get("Checkoff Advice Line"."Member No.") then begin
                        Amount := "Checkoff Advice Line"."Amount On"
                    end else
                        Loans.Reset;
                    Loans.SetRange("Loan No.", "Checkoff Advice Line"."Loan No.");
                    Loans.SetFilter("Document No. Filter", "Checkoff Advice Line".GetFilter("Checkoff Advice Line"."Document No. Filter"));
                    if Loans.Find('-') then begin
                        Amount := Loans.repayment;

                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");

                        PostedAmount := Loans."Outstanding Balance";
                        PostedInterest := Loans."Outstanding Interest";
                    end;

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("No.", "Checkoff Advice Line"."Account No.");
                    SavingsAccounts.SetFilter("Document No. Filter", "Checkoff Advice Line".GetFilter("Checkoff Advice Line"."Document No. Filter"));
                    if SavingsAccounts.Find('-') then begin
                        SavingsAccounts.CalcFields("Balance (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                        PostedAmount := SavingsAccounts."Credit Amount (LCY)";
                        PostedInterest := 0;
                    end;
                    CheckoffAdviceLine.Reset;
                    CheckoffAdviceLine.SetCurrentkey("Member No.");
                    CheckoffAdviceLine.SetRange("Advice Header No.", "Checkoff Header"."No.");
                    CheckoffAdviceLine.SetRange("Member No.", Members."No.");
                    if CheckoffAdviceLine.Find('-') then begin
                        repeat
                            MemberNo := CheckoffAdviceLine."Member No.";
                            Name := CheckoffAdviceLine.Names;
                        until CheckoffAdviceLine.Next = 0;
                    end;
                end;

                //IF Turn=2 THEN CurrReport.SKIP


                trigger OnPreDataItem()
                begin
                    i := 1;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                PeriodDate := Format("Checkoff Header"."Date Entered") + '..' + Format("Checkoff Header"."Posting Date");
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
        Company.Get;
        Company.CalcFields(Picture);


        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;





    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ProductFactory: Record "Product Factory";
        Loans: Record Loans;
        Members: Record "Members";
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
        Interest: Decimal;
        Amount: Decimal;
        CheckoffAdviceLine: Record "Checkoff Advice Line";
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        Company: Record "Company Information";
        i: Integer;
        PeriodDate: Text;
        CreditAccounts: Record "Credit Accounts";
        SavingsAccounts: Record "Savings Accounts";
        PostedAmount: Decimal;
        PostedInterest: Decimal;
}
