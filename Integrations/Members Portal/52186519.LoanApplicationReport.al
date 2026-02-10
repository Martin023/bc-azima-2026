report 52186519 "Loan Application Report"
{
    ApplicationArea = All;
    Caption = 'Loan Application Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/LoanApplicationReport.rdl';
    //RDLCLayout = './MPortalApi/test.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
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
            // Loan columns
            column(Loan_No_; "Loan No.") { }
            column(MemberNo; "Member No.") { }
            column(MemberName; "Member Name") { }
            column(National_ID; "National ID") { }
            column(ApplicationDate; "Application Date") { }
            column(LoanProductTypeName; "Loan Product Type Name") { }
            column(LoanAmount; "Loan Amount") { }
            column(RecoveryMode; "Recovery Mode") { }
            column(ApprovedAmount; "Approved Amount") { }
            column(AmountToDisburse; "Amount To Disburse") { }
            column(DisbursementDate; "Disbursement Date") { }
            column(SourceApplication; "Source Aplication") { }
            column(LoanPurpose; "Purpose of Loan") { }
            column(RequestedAmount; "Requested Amount") { }
            column(Installment_Period; "Installment Period") { }
            column(Installments; Installments) { }
            column(Source_Unit; "Source Unit") { }
            column(Main_Sector; "Main Sector") { }
            column(Main_Sector_Description; "Main Sector Description") { }
            column(Sub_Sector_Level1_Description; "Sub Sector Level1 Description") { }
            column(Sub_Sector_Level2_Description; "Sub Sector Level2 Description") { }
            column(TSC_Number; TSC_Number) { }
            column(Home_Address; Home_Address) { }
            column(Primary_Identification; Primary_Identification) { }
            column(Member_Name; Member_Name) { }
            column(Member_Employer_Name; Member_Employer_Name) { }
            column(Member_Email; Member_Email) { }
            column(Member_Phone; Member_Phone) { }
            column(Member_Nationality; Member_Nationality) { }
            column(Member_signature; MemberImages.Signature) { }
            column(Member_Picture; MemberImages.Picture) { }
            //Section B: Loan Guarantors
            dataitem(LoanGuarantors; "Loan Guarantors and Security")
            {
                DataItemLink = "Loan No" = field("Loan No.");
                column(Guarantor_Member_No; "Member No") { }
                column(Guarantor_Name; "Name") { }
                column(Guarantor_Phone_Number; "Phone No.") { }
                column(Guarantor_Primary_Identification; Guarantor_Primary_Identification) { }
                column(Amount_Guaranteed; "Amount Guaranteed") { }
                column(Guarantor_TSC_Number; Guarantor_TSC_Number) { }
                column(Guarantor_Home_Address; Guarantor_Home_Address) { }
                column(Guarantor_Picture; GuarantorImages.Picture) { }
                column(Guarantor_Signature; GuarantorImages.Signature) { }
                trigger OnAfterGetRecord()
                begin
                    Clear(GuarantorMembers);
                    CLEAR(GuarantorImages.Picture);
                    CLEAR(GuarantorImages.Signature);

                    GuarantorMembers.Reset();
                    GuarantorMembers.SetRange("No.", LoanGuarantors."Member No");
                    if GuarantorMembers.FindFirst() then begin
                        Guarantor_Primary_Identification := GuarantorMembers."Primary Identification";
                        Guarantor_TSC_Number := GuarantorMembers."TSC Number";
                        Guarantor_Home_Address := GuarantorMembers."Home Address";
                    end else begin
                        Clear(GuarantorMembers."TSC Number");
                        Clear(GuarantorMembers."Home Address");
                        clear(GuarantorMembers."Primary Identification");
                    end;

                    Clear(GuarantorImages);

                    GuarantorImages.Reset();
                    GuarantorImages.SetRange("Member No", LoanGuarantors."Member No");
                    if GuarantorImages.FindFirst() then begin
                        CLEAR(GuarantorImages.Picture);
                        CLEAR(GuarantorImages.Signature);
                        GuarantorImages.CalcFields(GuarantorImages.Picture);
                        GuarantorImages.CalcFields(GuarantorImages.Signature);
                    end
                    else begin
                        CLEAR(GuarantorImages.Picture);
                        CLEAR(GuarantorImages.Signature);
                    end;
                end;
            }

            //Section C: Loan Top-ups
            dataitem("Loans Top up"; "Loans Top up")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(Loan_Top_Up; "Loan Top Up") { }
                column(Loan_Type; "Loan Type") { }
                column(Loan_Product_Type_Name; "Loan Product Type Name") { }
                column(Outstanding_Balance; "Outstanding Balance") { }

                // trigger OnAfterGetRecord()
                // begin
                //     if "Loan Top Up" = '' then
                //         CLEAR("Loan Top Up");
                // end;

                // trigger OnPreDataItem()
                // begin
                //     LoanTopupRec.Reset();  // test case 
                //     SetRange("Loan No.", Loans."Loan No.");
                // end;
            }


            trigger OnAfterGetRecord()
            begin
                Clear(MembersRec);
                Clear(MemberImages);

                MembersRec.Reset();
                MembersRec.SetRange("No.", Loans."Member No.");
                if MembersRec.FindFirst() then begin
                    MembersRec.CalcFields("Employer Name");
                    Member_Employer_Name := MembersRec."Employer Name";
                    TSC_Number := MembersRec."TSC Number";
                    Home_Address := MembersRec."Home Address";
                    Primary_Identification := MembersRec."Primary Identification";
                    Member_Nationality := MembersRec."Nationality";
                    Member_Name := MembersRec."Name";
                    Member_Email := MembersRec."E-Mail";
                    Member_Phone := MembersRec."Phone No.";

                    MemberImages.Reset();
                    MemberImages.SetRange("Member No", Loans."Member No.");
                    if MemberImages.FindFirst() then begin
                        MemberImages.CalcFields(Picture);
                        MemberImages.CalcFields(Signature);
                    end else begin
                        CLEAR(MemberImages.Picture); // Reset if no record found
                        CLEAR(MemberImages.Signature);
                    end;
                end else begin
                    Clear(MembersRec."Employer Name");
                    Clear(MembersRec."TSC Number");
                    Clear(MembersRec."Home Address");
                    Clear(MembersRec."Primary Identification");
                    Clear(MembersRec."Nationality");
                    Clear(MembersRec."Name");
                    Clear(MembersRec."E-Mail");
                    Clear(MembersRec."Phone No.");
                end;
            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group("Loan Filters")
    //             {
    //                 field(LoanNo; LoanNoFilter)
    //                 {
    //                     ApplicationArea = All;
    //                 }
    //             }
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
