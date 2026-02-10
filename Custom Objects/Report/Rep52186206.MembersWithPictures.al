namespace KenpipeBC.KenpipeBC;
using Microsoft.Foundation.Company;

report 52186206 "Members With Pictures"
{
    ApplicationArea = All;
    Caption = 'Members With Pictures';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Members With Pictures.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status;
            //DataItemLink = Members WHERE(Members."Status" <> CONST(Open));
            column(No; "No.")
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
            column(RecruitedByName; "Recruited By Name")
            {
            }
            column(RecruitedbyType; "Recruited by Type")
            {
            }
            column(MemberClass; "Member Class")
            {
            }
            column(Salutation; sno)
            {
            }
            column(MaritalStatus; "Marital Status")
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
            column(Delegates_Zone; "Delegates Zone")
            {
            }
            column(PicExist; PicExist)
            { }
            column(SignExist; SignExist)
            { }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                PicExist := false;
                SignExist := false;
                ImageData.reset;
                ImageData.SetRange("Member No", Members."No.");
                if ImageData.Find('-') then begin
                    ImageData.CalcFields(Picture, Signature);
                    PicExist := NOT ImageData.Picture.HasValue;
                    SignExist := NOT ImageData.Signature.HasValue;
                end;
                // if (PicExist = true) and (SignExist = true) then
                //     CurrReport.skip;
                sno += 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
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


    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ImageData: Record "Image Data";
        PicExist: Boolean;
        SignExist: Boolean;
        sno: Integer;
}
