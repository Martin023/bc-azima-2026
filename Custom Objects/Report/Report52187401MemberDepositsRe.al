Report 52187401 "Member Deposits Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Member Deposits Report';
    RDLCLayout = './bc-azima-2026/Layout/Member Deposits resport.rdl';



    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(Status = filter(New | Active | Deceased | Dormant));
            column(ReportForNavId_20; 20)
            {
            }
            dataitem("Savings Accounts"; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where("Product Category" = filter("BOSA Deposits"));
                RequestFilterFields = "Date Filter", "Employer Code";
                column(ReportForNavId_1; 1)
                {
                }
                column(CompanyNam; CompanyNam)
                {
                }
                column(CompanyAddress; CompanyAddress)
                {
                }
                column(CompanyTelephone; CompanyTelephone)
                {
                }
                column(Picture; CompanyInformation.Picture)
                {
                }
                column(Name_SavingsAccounts; "Savings Accounts".Name)
                {
                }
                column(Gender_SavingsAccounts; "Savings Accounts".Gender)
                {
                }
                column(DateofBirth_SavingsAccounts; "Savings Accounts"."Date of Birth")
                {
                }
                column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
                {
                }
                column(MemberNo_SavingsAccounts; "Savings Accounts"."Member No.")
                {
                }
                column(Status_SavingsAccounts; "Savings Accounts".Status)
                {
                }
                column(DepositsCont; DepositsCont)
                {
                }
                column(CountN; CountN)
                {
                }
                column(StartDateText; StartDateText)
                {
                }
                column(EndDateText; EndDateText)
                {
                }
                column(Dob; Dob)
                {
                }
                column(PhoneNo_SavingsAccounts; "Savings Accounts"."Phone No.")
                {
                }
                column(Gender; Genders)
                {
                }
                column(Status; MemberStatus)
                {
                }
                column(Paidamount; Paidamount)
                {

                }
                column(Monthly_Contribution; "Monthly Contribution")
                {

                }
                column(VarAmount; VarAmount)
                { }

                trigger OnAfterGetRecord()
                var
                    Savings: Record "Savings Accounts";
                    Members: Record Members;
                    savingsLedger: Record "Savings Ledger Entry";


                begin
                    DepositsCont := 0;
                    Dob := '';
                    Genders := '';
                    MemberStatus := '';
                    "Savings Accounts".CalcFields("Balance (LCY)");
                    DepositsCont := "Savings Accounts"."Balance (LCY)";
                    savingsLedger.Reset();
                    savingsLedger.SetRange("Customer No.", "Savings Accounts"."No.");
                    savingsLedger.SetRange("Posting Date", "Date Filter");
                    if savingsLedger.FindFirst() then begin
                        savingsLedger.CalcSums(Amount);
                        Paidamount := savingsLedger.Amount;
                    end;
                    if "Savings Accounts"."Monthly Contribution" <> 0 then
                        VarAmount := Paidamount - "Savings Accounts"."Monthly Contribution";
                    //IF DepositsCont>0 THEN
                    CountN += 1;
                    if Members.Get("Savings Accounts"."Member No.") then begin
                        Dob := SkyHarambee.FormatDate(Members."Date of Birth");
                        "Savings Accounts"."ID No." := Members."Primary Identification";
                        Genders := Format(Members.Gender);
                        MemberStatus := Format(Members.Status);
                    end;
                end;

                trigger OnPreDataItem()
                var
                    Members: Record Members;
                begin
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
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
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);

        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // IF (StartDate = 0D) OR (StartDate = 0D) THEN ERROR('Start date or End date must have a value!');
        // StartDateText := SkyHarambee.FormatDate(StartDate);
        // EndDateText := SkyHarambee.FormatDate(EndDate);
    end;

    var
        DepositsCont: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyNam: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CountN: Integer;
        VarAmount: Decimal;
        StartDate: Date;
        SkyHarambee: Codeunit "Global Functions";
        EndDate: Date;
        StartDateText: Text;
        Paidamount: Decimal;
        EndDateText: Text;

        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Dob: Text;
        Genders: Text;
        MemberStatus: Text;
}

