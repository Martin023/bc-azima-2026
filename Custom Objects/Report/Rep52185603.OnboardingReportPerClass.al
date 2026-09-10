report 52185603 "Onboarding Report Per Class"
{
    ApplicationArea = All;
    Caption = 'Member Onboarding Report Per Class';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/OnboardingReportPerClass.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "Member Class", Status, Subflag;

            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }
            column(DateFilterTxt; DateFilterTxt) { }

            column(MemberClass; "Member Class") { }
            column(No; "No.") { }
            column(Name; Name) { }
            column(Gender; Gender) { }
            column(PrimaryIdentification; "Primary Identification") { }
            column(AccountType; "Account Type") { }
            column(DateApproved; Format("Date Approved", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(RegistrationDate; Format("Registration Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Status; Status) { }

            column(BOSADeposit; "BOSA Deposit") { }
            column(ShareCapital; "Share Capital") { }
            column(EntranceFeeBal; EntranceFeeBal) { }

            trigger OnPreDataItem()
            begin
                if (StartDate = 0D) and (EndDate <> 0D) then
                    SetFilter("Registration Date", '..%1', EndDate)
                else if (StartDate <> 0D) and (EndDate = 0D) then
                    SetRange("Registration Date", StartDate, Today)
                else if (StartDate <> 0D) and (EndDate <> 0D) then
                    SetRange("Registration Date", StartDate, EndDate)
                else
                    SetFilter("Registration Date", '..%1', Today);

                if BranchFilter <> '' then
                    SetRange("Global Dimension 1 Code", BranchFilter);
            end;

            trigger OnAfterGetRecord()
            var
                SavAcc: Record "Savings Accounts";
            begin
                CalcFields("BOSA Deposit", "Share Capital");

                EntranceFeeBal := 0;
                SavAcc.Reset();
                SavAcc.SetRange("Member No.", "No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Entrance Fee");
                if SavAcc.FindFirst() then begin
                    SavAcc.CalcFields("Balance (LCY)");
                    EntranceFeeBal := -SavAcc."Balance (LCY)";
                end;
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
                group(Options)
                {
                    Caption = 'Date & Branch Filters';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration End Date';
                    }
                    field(BranchFilter; BranchFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Branch';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
        CompanyAddress := 'P.O BOX ' + CompanyInformation."Post Code" + ', ' + CompanyInformation.City;
        CompanyTelephone := 'TEL: ' + CompanyInformation."Phone No." + ', ' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";

        if (StartDate = 0D) then StartDate := Today;
        if (EndDate = 0D) then EndDate := Today;
        DateFilterTxt := 'Registrations For (' + Format(StartDate, 0, '<Day,2>/<Month,2>/<Year4>') + ') To (' + Format(EndDate, 0, '<Day,2>/<Month,2>/<Year4>') + ')';
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        StartDate: Date;
        EndDate: Date;
        BranchFilter: Code[20];
        EntranceFeeBal: Decimal;
        DateFilterTxt: Text;
}