report 52187421 "Nominee Register"
{
    ApplicationArea = All;
    Caption = 'Nominee Register/BBF Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Nominee Register.rdl';
    dataset
    {
        dataitem(Next_of_KIN; "Next of KIN")
        {
            // DataItemLink = "Record ID" = field("No.");
            // DataItemTableView = WHERE("Is Nominee" = CONST(TRUE));
            RequestFilterFields = "Record ID", "Is Nominee", "Is a Beneficiary", "Employer Code";
            column(Record_ID; "Record ID")
            {
            }
            column(MemberName; MemberName) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(MemberDeposits; MemberDeposits)
            {
            }
            column(IsNominee; "Is Nominee")
            {
            }
            column(NomineeName; Name)
            {
            }
            column(Relationship; Relationship)
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(Email; Email)
            {
            }
            column(Phone; Telephone)
            {
            }
            column(Address; Address)
            {
            }
            column(Identification_Type; "Identification Type")
            {
            }
            column(Identification_Number; "Identification")
            {
            }
            column(Allocation; Allocation)
            {
            }
            Column(Deceased; Deceased)
            {
            }
            column(Removed; Removed)
            {
            }
            column(DateCaptured; "Date Captured")
            {
            }
            column(DateApproved; "Date Approved")
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
            begin
                MemberDeposits := 0;
                MemberName := ' ';

                SavingAccounts.RESET;
                SavingAccounts.SetRange("Member No.", Next_of_KIN."Record ID");
                SavingAccounts.Setrange(SavingAccounts."Product Category", SavingAccounts."Product Category"::"BOSA Deposits");
                if SavingAccounts.find('-') then begin
                    SavingAccounts.CalcFields("Balance (LCY)");
                    MemberDeposits := SavingAccounts."Balance (LCY)";
                    MemberName := SavingAccounts.Name;
                end;

                // Members.RESET;
                // Members.SETRANGE("No.", Next_of_KIN."Record ID");
                // if Members.FIND('-') then begin
                //     MemberName := Members.Name;
                // end;

                // Nextofkin.RESET;
                // Nextofkin.SetRange(Nextofkin."Record ID", Members."No.");
                // Nextofkin.SetRange("Is Nominee", true);
                // //Nextofkin.SETRANGE(NextofKin."Date Captured", StartDate, EndDate);
                // if Nextofkin.Find('-') then begin
                //     repeat
                //         Allocation := 0;
                //         NomineeName := Nextofkin.Name;
                //         Identification_Type := Nextofkin."Identification Type";
                //         Identification_Number := Nextofkin."Identification";
                //         Allocation := Nextofkin.Allocation;
                //         Deceased := Nextofkin.Deceased;
                //         Relationships := Nextofkin.Relationship;
                //         DateofBirth := Nextofkin."Date of Birth";
                //         Email := Nextofkin.Email;
                //         Phone := Nextofkin.Telephone;
                //         Address := Nextofkin.Address;
                //         DateCaptured := Nextofkin."Date Captured";
                //         DateApproved := Nextofkin."Date Approved";
                //         Removed := Nextofkin.Removed;
                //     until Nextofkin.NEXT = 0;
                // end
                // else
                //     if not Nextofkin.Find('-') then
                //         CurrReport.Skip;
                //until Members.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                // if Startdate = 0D then
                //     Startdate := 19740101D;
                // if Enddate = 0D then
                //     Enddate := Today;

                // Members.RESET;
                // Members.SetRange("No.", Next_of_KIN."Record ID");
                // if Members.Find('-') then begin
                //     Members.Setfilter(Members."Registration Date", '%1..%2', StartDate, EndDate);
                //     CompanyInformation.Get;
                //     CompanyInformation.CalcFields(Picture);
                // end;
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
                // field(StartDate; StartDate)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Start Date';
                // }
                // field(EndDate; EndDate)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'End Date';
                // }
            }
        }
    }
    trigger OnPreReport()
    begin
        // if StartDate = 0D then Error('Kindly set the start date');
        // if EndDate = 0D then Error('Kindly set the end date');
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
        Nextofkin: Record "Next of KIN";
        Allocation: Decimal;
        Deceased: Boolean;
        Removed: Boolean;
        NomineeName: Text;
        Identification_Type: Enum "Identification Type";
        Identification_Number: Text;
        Address: Text;
        Phone: Text;
        Email: Text;
        DateofBirth: Date;
        Relationships: Text;
        DateCaptured: Date;
        DateApproved: Date;
        // PeriodStartDate: Date;
        // PeriodEndDate: Date;
        StartDate: Date;
        EndDate: Date;
        SavingAccounts: Record "Savings Accounts";
        MemberDeposits: Decimal;
        Members: Record "Members";
        MemberName: Text;
}
