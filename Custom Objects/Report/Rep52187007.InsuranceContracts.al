report 52187007 "Insurance Contracts"
{
    ApplicationArea = All;
    Caption = 'Insurance Contracts';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Insurance Details Per Vehicle.rdl';
    dataset
    {
        dataitem(Insurance; Insurance)
        {
            RequestFilterFields = "FA Class Code", "FA Location Code", "FA Subclass Code", "Insurance Type";
            //DataItemTableView = WHERE ("FA Class Code" = FILTER('VEHICLE'));
            column(AnnualPremium; "Annual Premium")
            {
            }
            column(Insurer; Insurer)
            {
            }
            column(Insurer_Name; "Insurer Name")
            {
            }
            column(Fixed_Asset_No_; "Fixed Asset No.")
            {
            }
            // column(Blocked; Blocked)
            // {
            // }
            // column(Comment; Comment)
            // {
            // }
            column(Description; Description)
            {
            }
            column(EffectiveDate; "Effective Date")
            {
            }
            column(ExpirationDate; "Expiration Date")
            {
            }
            column(FAClassCode; "FA Class Code")
            {
            }
            column(FALocationCode; "FA Location Code")
            {
            }
            column(FASubclassCode; "FA Subclass Code")
            {
            }
            // column(Effective_Date;"Effective Date")
            // {
            // }
            column(Expiration_Date; "Expiration Date")
            {
            }
            column(Renewal_Date; "Renewal Date")
            {
            }
            column(Policy_Coverage; "Policy Coverage")
            {
            }
            column(Policy_No_; "Policy No.")
            {
            }
            COLUMN(Book_Value; BookValue)
            {
            }
            COLUMN(Annual_Premium; "Annual Premium")
            {
            }
            // column(GlobalDimension1Code; "Global Dimension 1 Code")
            // {
            // }
            // column(GlobalDimension2Code; "Global Dimension 2 Code")
            // {
            // }
            column(InsuranceType; "Insurance Type")
            {
            }
            // column(InsuranceVendorNo; "Insurance Vendor No.")
            // {
            // }
            // column(LastDateModified; "Last Date Modified")
            // {
            // }
            column(LocationCode; "Location Code")
            {
            }
            column(No; "No.")
            {
            }

            column(PolicyCoverage; "Policy Coverage")
            {
            }
            column(PolicyNo; "Policy No.")
            {
            }
            column(TotalValueInsured; "Total Value Insured")
            {
            }
            column(OverUnderInsruance; OverUnderInsruance)
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
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                OverUnderInsruance := 0;
                BookValue := 0;

                if Insurance."Total Value Insured" > 0 then
                    OverUnderInsruance := Insurance."Annual Premium" - Insurance."Book Value";


                FADepBook.RESET;
                FADepBook.SETRANGE("FA No.", Insurance."Fixed Asset No.");
                IF FADepBook.find('-') then begin
                    FADepBook.CALCFIELDS("Book Value");
                    BookValue := FADepBook."Book Value";
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
        Days: Integer;
        Age: Integer;
        AgeBracket: Text;
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        OverUnderInsruance: Decimal;
        FADepBook: Record "FA Depreciation Book";
        BookValue: Decimal;
}
