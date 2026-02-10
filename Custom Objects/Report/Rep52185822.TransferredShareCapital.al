namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185822 "Transferred Share Capital Cert"

{
    ApplicationArea = All;
    Caption = 'Transferred Share Capital';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './bc-azima-2026/Layout/Transferred Share Capital.docx';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            DataItemTableView = where(Status = filter(<> Deceased));
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            // column(TodaysDay;TodaysDay)
            // {
            // }
            // column(TodaysMonth;TodaysMonth)
            // {
            // }
            column(ShareCapBalance; ShareCapBalance)
            {
            }
            column(NoofShares; NoofShares)
            {
            }
            column(PrintingDate; PrintingDate)
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(SharePrice; SharePrice)
            {
            }
            column(DirectorName; CompanyInformation."Director")
            {
            }
            column(CEOName; CompanyInformation."CEO")
            {
            }
            column(CEO_Signature; CompanyInformation."CEO Signature")
            {
            }
            column(Director_Signature; CompanyInformation."Director Signature")
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }

            column(CompanyName; CompanyInformation."Name")
            {
            }
            column(ISOCertification; CompanyInformation."ISO Certification")
            {
            }
            column(PostOfficeAddress; CompanyInformation."Address")
            {
            }
            column(SACCOName; CompanyInformation."Name")
            {
            }
            column(Telephone; CompanyInformation."Phone No.")
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(Website; CompanyInformation."Website")
            {
            }
            column(PhysicalAddress; CompanyInformation."Address 2")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //PrintingDate := '';
                CertNo := 0;
                TodaysDay := 0;
                TodaysMonth := 0;
                TodaysYear := 0;


                GenSetups.Get;
                SavingsAccounts.Reset();
                SavingsAccounts.SETRANGE("Member No.", Members."No.");
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Share Capital");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    ShareCapBalance := SavingsAccounts."Balance (LCY)";

                    SharePrice := GenSetups."Shares Price";
                    NoofShares := ROUND((ShareCapBalance / GenSetups."Shares Price"), 1, '<');
                    PrintingDate := GlobalFunctions.FormatDateFullMonth(Today);
                    // TodaysDay := (Date2DMY(PrintingDate, 1));
                    // TodaysMonth := (Date2DMY(PrintingDate, 2));
                    // TodaysYear := (Date2DMY(PrintingDate, 3));

                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
            CompanyInformation.CalcFields(CompanyInformation."CEO Signature");
            CompanyInformation.CalcFields(CompanyInformation."Director Signature");
            CompanyAddress := CompanyInformation.Address;
            Telephone := CompanyInformation."Phone No.";
            EMail := CompanyInformation."E-Mail";
            Website := CompanyInformation."Website";
            PhysicalAddress := CompanyInformation."Address 2";
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        Website: Text;
        Email: Code[250];
        Telephone: Code[250];
        SACCOName: Code[250];
        CompanyAddress: Code[250];
        ISOCertification: Code[250];
        PhysicalAddress: Code[250];
        PostOfficeAddress: Code[250];
        SavingsAccounts: Record "Savings Accounts";
        Product_Category: Code[250];
        ShareCapBalance: Decimal;
        Member_No: Code[250];
        GenSetups: Record "General Set-up";
        ShareCertBuffer: Record "Share Certificate Buffer";
        ShareCapTranserBuffer: Record "Share Capital Transfer Buffer";
        ShareCapTranferLines: Record "Share Capital Transfer Lines";
        NoofShares: Decimal;
        PrintingDate: Text;
        SharePrice: Decimal;
        CertNo: Integer;
        TodaysDay: Integer;
        TodaysMonth: Integer;
        TodaysYear: Integer;
        GlobalFunctions: Codeunit "Global Functions";
}
