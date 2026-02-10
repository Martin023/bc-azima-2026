report 52186053 "Deposits Arreas Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Deposit Arrears Report.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {

        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = Filter("Risk" | "Benevolent (BBF)"));

            column(ReportForNavId_1; 1)
            {
            }
            column(No_SavingsAccounts; "Savings Accounts"."No.")
            {
            }
            column(Name_SavingsAccounts; "Savings Accounts".Name)
            {
            }
            column(PhoneNo_SavingsAccounts; "Savings Accounts"."Phone No.")
            {
            }
            column(GlobalDimension1Code_SavingsAccounts; "Savings Accounts"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SavingsAccounts; "Savings Accounts"."Global Dimension 2 Code")
            {
            }
            column(Balance_SavingsAccounts; "Savings Accounts".Balance)
            {
            }

            column(Member_No_; "Savings Accounts"."Member No.")
            {
            }
            column(Product_Type; "Savings Accounts"."Product Type")
            {
            }
            column(Product_Name; "Savings Accounts"."Product Name")
            {
            }
            column(Status; "Savings Accounts".Status)
            {
            }
            column(Last_Transaction_Date; "Savings Accounts"."Last Transaction Date")
            {
            }
            column(BalanceLCY_SavingsAccounts; "Savings Accounts"."Balance (LCY)")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; "Savings Accounts"."Payroll/Staff No.")
            {
            }
            column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
            {
            }
            column(ATMTransactions_SavingsAccounts; "Savings Accounts"."ATM Transactions")
            {
            }
            column(ATMNo_SavingsAccounts; "Savings Accounts"."ATM No.")
            {
            }

            column(AccNo; "Savings Accounts".Balance)
            {
            }
            column(sno; SNo)
            {
            }
            column(Amount; Amount)
            {

            }
            column(Monthly_Contribution; "Monthly Contribution")
            {

            }
            dataitem(Members; Members)
            {
                DataItemLink = "No." = field("Member No.");
                //DataItemTableView=where(Status=filter(Dormant|Deceased));
                column(Employer_Code; "Employer Code")
                {

                }
                column(Employer_Name; "Employer Name")
                {

                }
                column(Date_of_Birth; "Date of Birth")
                {

                }
                column(Variance; Variance)
                {

                }
                column(Payroll_Staff_No_; "Payroll/Staff No.")
                {

                }
                column(P_I_N_Number; "P.I.N Number")
                {

                }
                column(E_Mail; "E-Mail")
                {

                }

                column(Primary_Identification_Type; "Primary Identification Type")
                {

                }
                column(Primary_Identification; "Primary Identification")
                {

                }
                column(MemberNo; Members."No.")
                {

                }
                Column(Name; Name)
                {

                }


                dataitem(Loans; Loans)
                {
                    DataItemLink = "Member No." = field("No.");
                    column(LoanNo; Loans."Loan Product Type")
                    {

                    }
                    column(LoanName; Loans."Loan Product Type Name")
                    {

                    }
                }
            }



            column(ShowTotoDetail; ShowTotoDetail)
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


            trigger OnAfterGetRecord()
            var
                SavingsLedger: Record "Savings Ledger Entry";


            begin
                SNo += 1;
                // if ("Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"BOSA Deposits") then begin
                //     repeat
                //         "Savings Accounts".Reset();
                //         "Savings Accounts".SetRange("Member No.", "Savings Accounts"."Member No.");
                //         "Savings Accounts".SetCurrentKey("Last Date Modified");
                //         "Savings Accounts".Ascending(true);
                //         if "Savings Accounts".FindLast() then begin
                //             Amount := "Savings Accounts"."Monthly Contribution";

                //         end else
                // SavingsLedger.Reset();
                // SavingsLedger.SetRange("Customer No.", "No.");
                // SavingsLedger.SetCurrentKey("Posting Date");
                // SavingsLedger.Ascending(true);
                // if SavingsLedger.FindLast() then begin
                //     Amount := SavingsLedger.Amount;
                // end;
                //until "Savings Accounts".Next = 0;

                case
                    "Savings Accounts"."Product Category" of
                    "Savings Accounts"."Product Category"::"Benevolent (BBF)", "Savings Accounts"."Product Category"::"Risk":
                        begin
                            Variance := ProductFactory.GetRiskBBfArrears("Savings Accounts"."No.");
                        end;
                end;



            end;


            //end;
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
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowTotoDetail: Boolean;
        Amount: decimal;
        TotalAmount: decimal;
        Nosav: Code[30];
        Prorata: record "Member Prorata_Contractual Dep";
        Variance: decimal;
        ProductFactory: Record "Product Factory";
}
