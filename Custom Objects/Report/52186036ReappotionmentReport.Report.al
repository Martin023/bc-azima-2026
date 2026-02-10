#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186036 "Reappotionment Report"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Reappotionment.rdl';

    dataset
    {
        dataitem("Loan Recovery Header"; "Loan Recovery Header")
        {
            RequestFilterFields = "Recovery Type", Action, "Header Reversed";
            DataItemTableView = where("Recovery Type" = const(Reappotionment), Action = filter(Reappotioned | Reversed));
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
            column(No_; "No.")
            {

            }
            column(HeaderMemberNo; "Member No.")
            {

            }
            column(HeaderName; Name)
            {

            }
            column(HeaderIdentifier; HeaderIdentifier)
            {

            }
            column(HeaderStaffNo; HeaderStaffNo)
            {

            }
            column(HeaderPostingDate; HeaderPostingDate)
            {

            }
            column(HeaderLoanNo; "Loan No.")
            {

            }
            column(HeaderLoanType; HeaderLoanType)
            {

            }
            column(HeaderLoanDescription; HeaderLoanDescription)
            {

            }
            column(HeaderReversed; HeaderReversed)
            {

            }
            column(TotalReappotioned; TotalReappotioned)
            {

            }
            column(SourceAccountNo; SourceAccountNo)
            {

            }
            column(SourceAccountType; SourceAccountType)
            {

            }
            column(PostedBy; PostedBy)
            {

            }
            dataitem("Loan Reapotionment Lines"; "Loan Reapotionment Lines")
            {
                DataItemLink = "Header No." = field("No.");
                column(Header_No_; "Header No.")
                {

                }
                column(LinesMemberNo; "Guarantor Member No.")
                {

                }
                column(LinesMemberName; "Guarantor Name")
                {

                }
                column(LinesIdentifier; LinesIdentifier)
                {

                }
                column(LinesStaffNo; LinesStaffNo)
                {

                }
                column(LinesLoanNo; "Guarantor Loan No.")
                {

                }
                column(LinesLoanType; LinesLoanType)
                {

                }
                column(LinesLoanDescription; LinesLoanDescription)
                {

                }
                column(LinesAppotionmentAmount; "Appotionment Amount")
                {

                }
                column(LinesInterestPortion; "Interest Portion")
                {

                }
                column(LinesPrinciplePortion; "Principle Portion")
                {

                }
                column(LinesInnitialAttachmentAmount; "Innitial Attachment Amount")
                {

                }
                column(LinesLoanBalance; "Loan Balance")
                {

                }
                column(LinesMoneyToFOSA; "Money To FOSA")
                {

                }
                column(LinesReversed; Reversed)
                {

                }

                trigger OnAfterGetRecord()
                var
                    GuarantorMember: Record Members;
                    GuarantorLoan: Record Loans;
                begin
                    LinesIdentifier := '';
                    LinesLoanType := '';
                    LinesLoanDescription := '';

                    if Members.Get("Loan Reapotionment Lines"."Guarantor Member No.") then begin
                        LinesIdentifier := Members."Primary Identification";
                        if LinesIdentifier = '' then
                            LinesIdentifier := Members."Secondary Identification";
                        LinesStaffNo := Members."Payroll/Staff No.";
                    end;

                    if Loans.Get("Loan Reapotionment Lines"."Guarantor Loan No.") then begin
                        LinesLoanType := Loans."Loan Product Type";
                        LinesLoanDescription := Loans."Loan Product Type Name";
                    end;

                end;
            }
            trigger OnAfterGetRecord()
            begin
                HeaderIdentifier := '';
                HeaderLoanType := '';
                HeaderLoanDescription := '';
                HeaderDetachedBy := '';
                HeaderReversed := false;

                if "Loan Recovery Header".Action = "Loan Recovery Header".Action::Reversed then
                    HeaderReversed := true;

                HeaderPostingDate := GlobalFunctions.FormatDate("Loan Recovery Header"."Posting Date");
                TotalReappotioned := "Amount To Use";
                SourceAccountNo := "Account Number";
                SourceAccountType := "Account Name";

                if Members.Get("Loan Recovery Header"."Member No.") then begin
                    HeaderIdentifier := Members."Primary Identification";
                    if HeaderIdentifier = '' then
                        HeaderIdentifier := Members."Secondary Identification";

                    HeaderStaffNo := Members."Payroll/Staff No.";


                    if Loans.Get("Loan Recovery Header"."Loan No.") then begin
                        Loans.CalcFields("Loans Category-SASRA");
                        HeaderLoanType := Loans."Loan Product Type";
                        HeaderLoanDescription := Loans."Loan Product Type Name";
                        HeaderDetachedBy := GlobalFunctions.FormatUserName("Loan Recovery Header"."Posted By");
                    end;
                end;

                PostedBy := GlobalFunctions.FormatUserName("Loan Recovery Header"."Posted By");
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
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
        //Header
        HeaderIdentifier: Code[50];
        HeaderLoanType: Code[20];
        HeaderLoanDescription: Text;
        HeaderDetachedBy: Code[50];
        HeaderPostingDate: Text;
        HeaderReversed: Boolean;
        HeaderStaffNo: Code[50];
        TotalReappotioned: Decimal;
        SourceAccountNo: Code[50];
        SourceAccountType: Code[50];
        PostedBy: Text;

        //Lines
        LinesIdentifier: Code[50];
        LinesLoanType: Code[20];
        LinesLoanDescription: Text;
        LinesStaffNo: Code[50];


        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";
        Loans: Record Loans;
        ProductFactory: Record "Product Factory";
        ReappotionmentLines: Record "Loan Reapotionment Lines";
}
