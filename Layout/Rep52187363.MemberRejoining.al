report 52187363 "Member Rejoining"
{
    ApplicationArea = All;
    Caption = 'Member Rejoining';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Rejoining.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {

        dataitem(Members; Members)
        {
            RequestFilterFields = Status, Subflag, "No.";
            DataItemTableView = WHERE(Status = Filter(Active), Subflag = Filter(Rejoined));
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(BOSAAcc; BOSAAcc)
            {
            }
            column(PINNumber; "P.I.N Number")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(RecruitedBy; "Recruited By")
            {
            }
            column(RecruitedByName; "Recruited By Name")
            {
            }
            column(RecruitedbyType; "Recruited by Type")
            {
            }
            column(DelegatesZone; "Delegates Zone")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Status; Status)
            {
            }
            column(Subflag; Subflag)
            {
            }
            column(TypeofApplication; "Type of Application")
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(RejoinigDate; "Rejoinig Date")
            {
            }
            column(Date_of_Birth; "Date of Birth")
            {
            }
            column(Age; Age)
            {
            }
            column(Shares; Shares)
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(ClosureDate; ClosureDate)
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
                Age := 0;
                Days := 0;
                Shares := 0;
                Deposits := 0;
                StartDate := 0D;
                EndDate := 0D;
                BOSAAcc := '';
                ClosureDate := 0D;

                if Members."Date of Birth" <> 0D then
                    Days := Today - Members."Date of Birth";
                Age := ROUND((Days / 365.2364), 1, '<');

                //ShareCapital
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"Share Capital");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    Shares := SavingsAccounts."Balance (LCY)";
                end;

                //Deposits
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", Members."No.");
                SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                if SavingsAccounts.Find('-') then begin
                    BOSAAcc := SavingsAccounts."No.";
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    Deposits := SavingsAccounts."Balance (LCY)";
                end;


                MemberClosure.Reset();
                MemberClosure.SetRange("Member No.", Members."No.");
                if MemberClosure.Find('-') then begin
                    ClosureDate := MemberClosure."Closing Date";
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        Age: Integer;
        Days: Integer;
        Shares: Decimal;
        Deposits: Decimal;
        FOSAAcc: Code[20];
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;
        SavingsAccounts: Record "Savings Accounts";
        BOSAAcc: Code[20];
        MemberClosure: Record "Membership Closure";
        ClosureDate: Date;
}
