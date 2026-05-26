report 52185657 "Member Application Channels"
{
    ApplicationArea = All;
    Caption = 'Member Application Channels';
    UsageCategory = ReportsAndAnalysis;
    DeFaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Application Channels.rdl';
    dataset
    {
        dataitem(CompanyHeader; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");
            MaxIteration = 1;
 
            column(CompanyInformation_Name; Name)
            {
            }
            column(CompanyInformation_Picture; Picture)
            {
            }
 
            trigger OnPreDataItem()
            begin
                CalcFields(Picture);  // load BLOB here, once
            end;
        }
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status,"Source Aplication";
            //DataItemTableView =  WHERE 
            column(No; "No.")
            {
            }
            column(Source_Aplication; "Source Aplication")
            {
            }
            column(Name; Name)
            {
            }
            column(Status; Status)
            {
            }
            column(Subflag; Subflag)
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(CurrentAddress; "Current Address")
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(RecruitedBy; "Recruited By")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(RecruitedByName; "Recruited By Name")
            {
            }
            column(RecruitedbyType; "Recruited by Type")
            {
            }
            column(MemberClass; "Member Class")
            {
            }
            column(Salutation; Salutation)
            {
            }
            column(MaritalStatus; "Marital Status")
            {
            }
            column(Date_Approved; "Date Approved")
            {
            }
            column(MemberAge; Age)
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
            column(Delegates_Zone; "Delegates Zone")
            {
            }
            column(RiskBalance; RiskBalance)
            {
            }
            column(RiskMonthlyContribution; RiskMonthlyContribution)
            {
            }
            column(RegistrationFee; RegistrationFee)
            {
            }
            column(FOSABalance; FOSABalance)
            {
            }
            column(BusinessDeposits; BusinessDeposits)
            {
            }
            column(BOSADepositBalance; BOSADepositBalance)
            {
            }
            column(BOSADepositsMonthlyContribution; BOSADepositsMonthlyContribution)
            {
            }
            column(BBFMonthlyContribution; BBFMonthlyContribution)
            {
            }
            trigger OnAfterGetRecord()
            begin
                RiskBalance := 0;
                BOSADepositBalance := 0;
                BOSADepositsMonthlyContribution := 0;
                FOSABalance := 0;
                BusinessDeposits := 0;
                RegistrationFee := 0;
                RiskMonthlyContribution := 0;
                BBFMonthlyContribution := 0;
                Age := 0;
                Days := 0;

                if Members."Date of Birth" <> 0D then begin
                    Days := Today - Members."Date of Birth";
                    Age := ROUND((Days / 365.2364), 1, '<') //Takes into Account Leap Years
                end
                else
                    Age := 0;
                Evaluate(FromDate, Format(StartDate));
                Evaluate(ToDate, Format(EndDate));
                DateFilter := FromDate + '..' + ToDate;

                DateFilter := Members.GetFilter("Date Filter");

                //EntranceFee
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    RegistrationFee := SavingsAccount."Balance (LCY)";
                end;

                //Risk
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::Risk);
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    RiskBalance := SavingsAccount."Balance (LCY)";
                    RiskMonthlyContribution := SavingsAccount."Monthly Contribution";
                end;

                //Deposits
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"BOSA Deposits");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    DepositBalance := SavingsAccount."Balance (LCY)";
                    DepositsMonthlyContribution := SavingsAccount."Monthly Contribution";
                end;
                //FOSA A/C
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"FOSA Account");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    FOSABalance := SavingsAccount."Balance (LCY)";
                end;

                //BusinessDeposits
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Business Deposits");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BusinessDeposits := SavingsAccount."Balance (LCY)";
                end;

                //bbf
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SetFilter("Date Filter", DateFilter);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Benevolent (BBF)");
                if SavingsAccount.Find('-') then begin
                    //SavingsAccount.CalcFields("Monthly Contribution");
                    BBFMonthlyContribution := SavingsAccount."Monthly Contribution";
                end;
            end;

            // trigger OnPreDataItem()
            // begin
            //     CompanyInformation.Get;
            //     CompanyInformation.CalcFields(Picture);
            // end;

            // trigger OnAfterGetRecord()
            // begin
            //     StartDate := 0D;
            //     EndDate := 0D;

            // end;
            //}
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then begin
            CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
            CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
            CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        end;
    end;


    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;
        Member: Record Members;
        RiskBalance: Decimal;
        DepositBalance: Decimal;
        BOSADepositBalance: Decimal;
        FOSABalance: Decimal;
        BusinessDeposits: Decimal;
        RegistrationFee: Decimal;
        RiskMonthlyContribution: Decimal;
        BBFMonthlyContribution: Decimal;
        DepositsMonthlyContribution: Decimal;
        BOSADepositsMonthlyContribution: Decimal;
        Days: Integer;
        Age: Integer;
        FromDate: Text[30];
        ToDate: Text[30];
        DateFilter: Text[100];
        SavingsAccount: Record "Savings Accounts";

}
