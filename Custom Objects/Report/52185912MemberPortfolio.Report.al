#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185912 "Member Portfolio"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Portfolio.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "member class", Status, "Employer Code", "Registration Date", "Global Dimension 1 Code", "Global Dimension 2 Code", Nationality;
            column(ReportForNavId_1; 1)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(GlobalDimension1Code_Members; Members."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Members; Members."Global Dimension 2 Code")
            {
            }
            column(RegistrationDate_Members; Members."Registration Date")
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(Nationality_Members; Members.Nationality)
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            column(IDNumber_Members; Members."Primary Identification")
            {
            }

            column(GroupAccountNo_Members; Members."Group Account No.")
            {
            }
            column(SalespersonCode_Members; Members."Recruited By")
            {
            }
            column(MemberSegment_Members; Members."Member Segment")
            {
            }
            column(CreatedBy_Members; Members."Created By")
            {
            }

            column(Status_Members; Members.Status)
            {
            }
            column(SCount; SNo)
            {
            }
            column(MemberClass_Members; Members."Member Class")
            {
            }
            column(BOSA; BOSA)
            {
            }
            column(SharesCapital; SharesCapital)
            {
            }
            column(RegFees; RegFees)
            {
            }
            column(Unallocated; Unallocated)
            {
            }
            column(Transferred; Transferred)
            {
            }
            column(Dividend; Dividend)
            {
            }
            column(BBF; BBF)
            {
            }
            column(Fosa; Fosa)
            {
            }
            column(BranchCode_Members; Members."Branch Code")
            {
            }
            column(CreatedBy; CreatedBy)
            {
            }
            // column(Invest; Invest)
            // {
            // }
            // column(Premier; Premier)
            // {
            // }
            column(Employer_Name; Members."Employer Name")
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
                SNo += 1;
                SharesCapital := 0;
                Fosa := 0;
                RegFees := 0;
                BBF := 0;
                Unallocated := 0;
                Transferred := 0;
                Dividend := 0;
                BOSA := 0;
                //AplhaDeposit := 0;
                //Invest := 0;
                //Premier := 0;
                //Fixed := 0;
                CreatedBy := '';
                User.Reset;
                User.SetRange("User Name", Members."Created By");
                if User.Find('-') then begin
                    CreatedBy := User."Full Name";
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    BOSA := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."product category"::"Share Capital");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    SharesCapital := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."product category"::"Entrance Fee");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    RegFees := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."product category"::"Benevolent (BBF)");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    BBF := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"FOSA Account");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    Fosa := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."product category"::"Unallocated Fund");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    Unallocated := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."product category"::"Transfered Share Capital");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    Transferred := SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "No.");
                SavingAcc.SetRange("Product Category", SavingAcc."product category"::"Dividend Account");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields(Balance);
                    Dividend := SavingAcc.Balance;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        SavingAcc: Record "Savings Accounts";
        CreditAcc: Record "Credit Accounts";
        LoanAcc: Record Loans;
        BOSA: Decimal;
        SharesCapital: Decimal;
        RegFees: Decimal;
        CreditLoans: Decimal;
        BankingLoans: Decimal;
        ShortTLoans: Decimal;
        LongTLoans: Decimal;
        TotalLoans: Decimal;
        CreatedBy: Text;
        User: Record User;
        NextofKIN: Record "Next of KIN";
        ImageData: Record "Image Data";
        HASNextKin: Boolean;
        HASImage: Boolean;
        ShowNextofKin: Boolean;
        ShowImage: Boolean;
        Fosa: Decimal;
        "Fixed": Decimal;
        BBF: Decimal;
        Unallocated: Decimal;
        Dividend: Decimal;
        Transferred: Decimal;
}
