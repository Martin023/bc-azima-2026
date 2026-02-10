namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185812 "Perfection Template II"
{
    ApplicationArea = All;
    Caption = 'Perfection Template II';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './bc-azima-2026/Layout/Perfection Template II.docx';
    dataset
    {
        dataitem(SecurityPerfection; "Security Perfection")
        {
            column(CollateralStatus; "Collateral Status")
            {
            }
            column(Collateral_Value_Sum; "Collateral Value Sum")
            {
            }
            column(Amount_To_Charge; "Amount To Charge")
            {
            }
            column(Loan_Offer_Letter_Date; "Loan Offer Letter Date")
            {
            }
            column(Charge_Type; "Charge Type")
            {
            }
            column(Security_No_; "Security No.")
            {
            }
            column(Property_Number; "Property Number")
            {
            }
            column(CollateralTypes; "Collateral Types")
            {
            }
            column(DateofIssuanceInstructions; "Date of Issuance Instructions")
            {
            }
            column(Discharged; Discharged)
            {
            }
            column(LawFirmHanldingtheMatter; "Law Firm Hanlding the Matter")
            {
            }
            column(LoanName; "Loan Name")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            // column(LoanType; "Loan Type")
            // {
            // }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }

            column(PerfectedBy; "Perfected By")
            {

            }
            column(SecurityNo; "Security No.")
            {
            }
            column(Status; Status)
            {
            }
            column(StatusoftheFees; "Status of the Fees")
            {
            }
            column(Perfection_Summary; SecurityPerfection.GetRichText(SecurityPerfection))
            {
            }
            column(Perfection_Attachements; "Perfection Attachements")
            {
            }
            column(ValuationComments; "Valuation Comments")
            {
            }
            column(MemberTelephone; Telephone)
            {
            }
            column(MemberEmail; Email)
            {
            }
            column(MemberAddress; Address)
            {
            }
            column(MemberTown; Town)
            {
            }
            column(LinesSeurityNo; SecurityNo)
            {
            }
            column(LinesPropertyNo; PropertyNo)
            {
            }
            column(LegalOfficer; CompanyInformation."Legal Officer Name")
            {
            }
            column(LegalOfficerTitle; CompanyInformation."Legal Officer Title")
            {
            }
            column(LegalOfficerSiganature; CompanyInformation."Legal Officer Signature")
            {
            }
            column(Law_Firm_Address; "Law Firm Address")
            {
            }
            column(Law_Firm_Physical_Address; "Law Firm Physical Address")
            {
            }
            dataitem(MembTable; Members)
            {
                DataItemLink = "No." = FIELD("Member No.");
                column(MembNumber; "No.")
                {
                }
                column(MembName; "Name")
                {
                }
                column(MembAddress; "Current Address")
                {
                }
                column(MembTown; "City")
                {
                }
                column(MembTelephone; "Phone No.")
                {
                }
                column(MembEmail; "E-Mail")
                {
                }
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
                CompanyInformation.CalcFields("Legal Officer Signature");
                CompanyInformation.CalcFields("CEO Signature");
            end;

            trigger OnAfterGetRecord()
            begin

                Members.RESET;
                Members.Setrange(Members."No.", SecurityPerfection."Member No.");
                if Members.FIND('-') then begin
                    Telephone := Members."Phone No.";
                    Email := Members."E-Mail";
                    Address := Members."Home Address";
                    Town := Members."City";
                end;

                SecurityRegister.RESET;
                SecurityRegister.SETRANGE("Loan No.", SecurityPerfection."Loan No.");
                if SecurityRegister.FIND('-') then begin
                    SecurityNo := '';
                    PropertyNo := '';

                    repeat
                        SecurityNo := SecurityRegister."No.";
                        PropertyNo := SecurityRegister."Collateral Ref No.";

                    until SecurityRegister.NEXT = 0;
                end;

                // Perfection.RESET;
                // Perfection.SETRANGE("Security No.",SecurityPerfection."Security No.");
                // if Perfection.FIND ('-') then
                // begin
                //     if "Chargor" <> '' then
                //     Chargor:= "Chargor";
                //     else
                //     Chargor := Perfection."Member Name";
                // end;
            end;
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyInformation.CalcFields("Legal Officer Signature");
        // CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        // CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        LegalOfficer := CompanyInformation."Legal Officer Name";
        LegalOfficerTitle := CompanyInformation."Legal Officer Title";
    end;


    var
        Adress: Text[50];
        City: Text[30];
        CompanyInformation: Record "Company Information";
        Members: Record "Members";
        Town: Text[30];
        Telephone: Code[20];
        Email: Code[100];
        Address: Text[50];
        LegalOfficer: Text;
        LegalOfficerTitle: Text;
        Perfection: Record "Security Perfection";
        SecurityRegister: Record "Securities Register";
        SecurityNo: Text;
        PropertyNo: Text;


}
