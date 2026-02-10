report 52185559 "Online M Application Report"
{
    ApplicationArea = All;
    Caption = 'Online Member Application Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/onlineMemberApplication.rdl';
    dataset
    {
        dataitem("Member Application"; "Member Application")
        {
            DataItemTableView = where("Source Aplication" = filter(= "Members Portal"));
            CalcFields = "ID Card Back", "ID Card Front", Picture, Signature;
            RequestFilterFields = "No.";

            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyName; CompanyName) { }
            column(BuildingName; BuldingName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintingDate; Today) { }
            column(PrintingTime; Time) { }
            column(PrintedBy; UserId) { }

            // Member Details Section
            column("Applicant_Application_No"; "No.") { }
            column(Applicant_Salutation; Salutation) { }
            column(Applicant_Firt_Name; "First Name") { }
            column(Applicant_Middle_Name; "Middle Name") { }
            column(Applicant_Other_Names; "Other Names") { }
            column(Applicant_Name; Name) { }
            column(Applicant_Primary_Identification_Type; "Primary Identification Type") { }
            column(Applicant_Identification; "Primary Identification") { }
            column(Applicant_Kra_PIN; "P.I.N Number") { }
            column(Applicant_Date_Of_Birth; "Date of Birth") { }
            column(Applicant_Gender; Gender) { }
            column(Applicant_Marital_Status; "Marital Status") { }
            column(Applicant_Religion; Religion) { }
            column(Applicant_Nationality; Nationality) { }
            column(Applicant_County; County) { }
            column(Applicant_Member_Class; "Member Class") { }
            column(Applicant_Contribution_Amount; "Contribution Amount") { }
            column(Contribution_Start_Date; "Contribution Start Date") { }
            column(Applicant_PhoneNo; "Phone No.") { }
            column(Applicant_EMail; "E-Mail") { }
            column(Applicant_CurrentAddress; "Current Address") { }
            column(Applicant_Home_Address; "Home Address") { }
            column(Applicant_EmployerCode; "Employer Code") { }
            column(Applicant_ID_Card_Front; "ID Card Front") { }
            column(Applicant_ID_Card_Back; "ID Card Back") { }
            column(Signature; Signature) { }
            column(Picture; Picture) { }
            column(Contribution_Mode; "Contribution Mode") { }

            dataitem("Next of KIN Application"; "Next of KIN Application")
            {
                DataItemLink = "Record ID" = field("No.");
                column(Nominee_Id_No; "Identification") { }
                column(Nominee_Name; "Name") { }
                column(Relationship; Relationship) { }
                column(Date_of_Birth; "Date of Birth") { }
                column(Nominee_Phone_No; "Telephone") { }
                column(Allocation; Allocation) { }
                column(Is_Nominee; "Is Nominee") { }
                column(Is_Contact_Person; "Is Contact Person") { }
            }
        }
    }
    requestpage
    {
        //SaveValues = true;
        layout
        {
            area(Content)
            {
            }
        }
    }

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
        CompanyInformation: Record "Company Information";
        GlobalFunctions: Codeunit "Global Functions";
}
