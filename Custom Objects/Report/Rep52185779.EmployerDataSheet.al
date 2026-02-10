namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185779 "Employer Data Sheet"
{
    ApplicationArea = All;
    Caption = 'Employer Data Sheet';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Employer Data Sheet.rdl';

    dataset
    {
        dataitem(Members; "Members")
        {
            RequestFilterFields = "No.", "Employer Code", "Employer Name";
            column(MemberNo; "No.")
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
            column(MemberName; Name)
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(Payroll_No; "Payroll/Staff No.")
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
            dataitem(Checkoff_Advice_Line; "Checkoff Advice Line")
            {
                column(Entry_No; "Entry No")
                {
                }
                column(CheckoffMemberNo; "Member No.")
                {
                }
                column(CheckoffMemberName; Names)
                {
                }
                column(Period; Period)
                {
                }
                column(EmployerCode; "Employer Code")
                {
                }
                column(AccountType; Type)
                {
                }
                column(Amount_On; "Amount On")
                {
                }
                column(Amount_Off; "Amount Off")
                {
                }
                // column(Remarks; "Advice Type")
                // {
                // }
                column(Balance_On; "Balance On")
                {
                }
                column(Balance_Off; "Balance Off")
                {
                }
                column(Product_Type; "Product Type")
                {
                }
                column(Product_Name; "Product Name")
                {
                }
                column(Advice_Type; "Advice Type")
                {
                }
                column(Advice_Method; "Advice Method")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin



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
        ProductFactory: Record "Product Factory";
        DigitalSignatures: Record "Digital Signature";


        Member1: Record "Image Data";
        Member2: Record "Image Data";
        MembersTable: Record Members;
        MemberName1: Text;
        MemberName2: Text;

}
