namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185784 Datasheet
{
    ApplicationArea = All;
    Caption = 'Datasheet';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/DataSheet.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            column(MemberNo; "No.")
            {
            }
            column(MemberID; "Primary Identification")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            Column(Employer_Code; "Employer Code")
            {
            }
            column(Member1; Member1.Signature)
            {

            }
            column(Member2; Member2.Signature)
            {

            }
            column(MemberName1; MemberName1)
            {

            }
            column(MemberName2; MemberName2)
            {

            }
            column(RiskAmount; RiskAmount)
            {
            }
            column(BBFAmount; BBFAmount)
            {
            }
            column(EntranceFee; EntranceFee)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(BOSAAmount; BOSAAmount)
            {
            }
            column(MemberName; Name)
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
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
                myInt: Integer;

            begin
                BBFAmount := 0;
                EntranceFee := 0;
                ShareCapital := 0;
                RiskAmount := 0;
                BosaAmount := 0;

                // Members.Reset();
                // Members.SetRange("No.", CheckoffAdviceLines."Member No.");
                // if Members.Find('-') then
                //     MemberID := Members."Primary Identification";
                // EmployerName := Members."Employer Name";

                // SavingsAccounts.RESET;
                // SavingsAccounts.Setrange("Member No.", CheckoffAdviceLines."Member No.");
                // //SavingsAccounts.Setrange(SavingsAccounts."Product Category", 'Benevolent (BBF)');
                // if SavingsAccounts.Find('-') then
                //     BBFAmount := CheckoffAdviceLines."Amount On";
                // ProdFact.Reset();
                // ProdFact.SetRange("Product Category", ProdFact."Product Category"::"Share Capital");
                // if ProdFact.FindFirst() then begin
                //     ShareCapital := ProdFact."Minimum Contribution";
                // end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::"Entrance Fee");
                if ProdFact.FindFirst() then begin
                    EntranceFee := ProdFact."Minimum Contribution";
                end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::"Benevolent (BBF)");
                if ProdFact.FindFirst() then begin
                    BBFAmount := ProdFact."Minimum Contribution";
                end;
                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::Risk);
                if ProdFact.FindFirst() then begin
                    RiskAmount := ProdFact."Minimum Contribution";
                end;
                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::"BOSA Deposits");
                if ProdFact.FindFirst() then begin
                    BOSAAmount := ProdFact."Minimum Contribution";
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

        DigitalSignatures.Reset();
        DigitalSignatures.SetRange("Signature Process", DigitalSignatures."Signature Process"::"Employer Datasheet");
        DigitalSignatures.SetFilter("Signature Name", '%1|%2', DigitalSignatures."Signature Name"::"Confirmed By", DigitalSignatures."Signature Name"::"Prepared By");
        if DigitalSignatures.Find('-') then begin
            repeat
                if DigitalSignatures."Signature Name" = DigitalSignatures."Signature Name"::"Prepared By" then begin
                    if MembersTable.Get(DigitalSignatures."Member No.") then begin
                        MemberName1 := MembersTable.Name;
                        Member1.Reset();
                        Member1.SetRange("Member No", MembersTable."No.");
                        if Member1.FindFirst() then
                            Member1.CalcFields(Member1.Signature);
                    end;

                end;
                if DigitalSignatures."Signature Name" = DigitalSignatures."Signature Name"::"Confirmed By" then begin
                    if MembersTable.Get(DigitalSignatures."Member No.") then begin
                        MemberName2 := MembersTable.Name;
                        Member2.Reset();
                        Member2.SetRange("Member No", MembersTable."No.");
                        if Member2.FindFirst() then
                            Member2.CalcFields(Member2.Signature);
                    end;
                end;
            until DigitalSignatures.Next() = 0;
        end else
            Error('There are no digital sinatures set up for this report');

    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        //Members: Record Members;
        MemberID: Code[20];
        EmployerName: Text[50];
        SavingsAccounts: Record "Savings Accounts";
        RiskAmount: Decimal;
        BBFAmount: Decimal;
        EntranceFee: Decimal;
        ShareCapital: Decimal;
        ProdFact: Record "Product Factory";
        BOSAAmount: Decimal;
        Member1: Record "Image Data";
        Member2: Record "Image Data";
        MembersTable: Record Members;
        MemberName1: Text;
        MemberName2: Text;
        DigitalSignatures: Record "Digital Signature";
}
