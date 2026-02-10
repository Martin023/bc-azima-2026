report 52186210 "Member Portal Dependancy App"
{
    ApplicationArea = All;
    Caption = 'Member Portal Dependancy App';
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = './bc-azima-2026/Layout/Member Portal Dependancy App.rdl';

    dataset
    {
        dataitem(DependanciesApplications; "Dependancies Applications")
        {
            RequestFilterFields = "No.";
            // Company info columns
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyName; CompanyName) { }
            column(BuldingName; BuldingName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy; PrintedBy) { }

            column(No; "No.")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ApplicationTime; "Application Time")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Description; Description)
            {
            }
            column(Status; Status)
            {
            }
            column(SourceApplication; "Source Application")
            {
            }

            dataitem(NOK; "Next of KIN Application")
            {
                DataItemLink = "Record ID" = field("No.");

                column(NOKIdentificationType; "Identification Type") { }
                column(NOKIdentification; "Identification") { }
                column(NOKName; "Name") { }
                column(NOKRelationship; "Relationship") { }
                column(NOKDateOfBirth; "Date of Birth") { }
                column(NOKAddress; "Address") { }
                column(NOKTelephone; "Telephone") { }
                column(NOKEmail; "Email") { }

                column(NOKIsNextOfKin; "Is Next of Kin") { }
                column(NOKIsBeneficiary; "Is a Beneficiary") { }
                column(NOKIsContactPerson; "Is Contact Person") { }
                column(NOKIsNominee; "Is Nominee") { }
                column(NOKAllocation; "Allocation") { }
                column(NOKIsToBeDeleted; Removed) { }
            }
        }
    }
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(Processing)
    //         {
    //         }
    //     }
    // }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
            CompanyName := CompanyInformation.Name;
            BuldingName := CompanyInformation."Building Name";
            CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City: ' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
            CompanyTelephone := CompanyInformation."Phone No." + ', ' + CompanyInformation."Phone No. 2";
            CompanyEmail := CompanyInformation."E-Mail";
            PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
            PrintingTime := Format(Time);
            PrintedBy := GlobalFunctions.FormatUserName(UserId);
        end;


    end;

    var
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];
        // LoanNoFilter: Code[20];

        CompanyInformation: Record "Company Information"; // table

        GuarantorMembers: Record "Members"; // table

        MembersRec: Record "Members"; // rep table
        GuarantorImages: Record "Image Data"; //gurantor images tt
        LoanTopupRec: Record "Loans Top up";
        MemberImages: Record "Image Data";
        Guarantor_TSC_Number: Code[50];
        TSC_Number: code[50];
        Home_Address: Text;
        Primary_Identification: Code[20];
        Member_Nationality: code[10];
        Member_Name: Text;
        Member_Employer_Name: Text;
        Member_Email: Text;
        Member_Phone: Text;
        Guarantor_Home_Address: Text;
        Guarantor_Primary_Identification: code[20];
        GlobalFunctions: Codeunit "Global Functions";  // CodeUnit
}
