#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185884 "Member application Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Member application Report.rdl';

    dataset
    {
        //dataitem(52185691;52185691)
        dataitem("Member Application"; "Member Application")
        {
            DataItemTableView = where(Status = filter(<> Open & <> Rejected));
            RequestFilterFields = "Employer Code", "Application Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CreatedByName; CreatedByName)
            {
            }
            column(PreviewDate; PreviewDate)
            {
            }
            column(PrintUser; PrintUser)
            {
            }
            column(PrintDate; PrintDate)
            {
            }
            column(CreatedBy_MemberApplication; "Member Application"."Created By")
            {
            }
            column(EmployerName_MemberApplication; "Member Application"."Employer Name")
            {
            }
            column(EmployerCode_MemberApplication; "Member Application"."Employer Code")
            {
            }
            column(IDNo_MemberApplication; "Member Application"."Primary Identification")
            {
            }
            column(ApplicationDate_MemberApplication; "Member Application"."Application Date")
            {
            }
            column(PayrollStaffNo_MemberApplication; "Member Application"."Payroll/Staff No.")
            {
            }
            column(GlobalDimension1Code_MemberApplication; "Member Application"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_MemberApplication; "Member Application"."Global Dimension 2 Code")
            {
            }
            column(Name_MemberApplication; "Member Application".Name)
            {
            }
            column(Status_MemberApplication; "Member Application".Status)
            {
            }
            //dataitem(52185692;52185692)
            dataitem("Next of KIN Application"; "Next of KIN Application")
            {
                DataItemLink = "Record ID" = field("No.");
                column(ReportForNavId_11; 11)
                {
                }
                column(Name_NextofKINApplication; "Next of KIN Application".Name)
                {
                }
                column(Relationship_NextofKINApplication; "Next of KIN Application".Relationship)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CreatedByName := CopyStr("Member Application"."Created By", StrPos("Member Application"."Created By", '\') + 1, 50);
                if "Member Application"."Application Date" <> 0D then
                    PreviewDate := Format(Date2dmy("Member Application"."Application Date", 1)) + '/' + Format(Date2dmy("Member Application"."Application Date", 2)) + '/' + Format(Date2dmy("Member Application"."Application Date", 3));
                PrintDate := Format(Date2dmy(Today, 1)) + '/' + Format(Date2dmy(Today, 2)) + '/' + Format(Date2dmy(Today, 3));
                PrintUser := UserId;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        VATCaptionLbl: label 'VAT';
        PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: label 'AMOUNT';
        NET_AMOUNTCaptionLbl: label 'AMOUNT';
        W_TAXCaptionLbl: label 'W/TAX';
        Document_No___CaptionLbl: label 'Document No. :';
        Currency_CaptionLbl: label 'Currency:';
        Payment_To_CaptionLbl: label 'Payment To:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        R_CENTERCaptionLbl: label 'R.CENTER CODE';
        PROJECTCaptionLbl: label 'PROJECT CODE';
        TotalCaptionLbl: label 'Total';
        Printed_By_CaptionLbl: label 'Printed By:';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
        TotalCaption_Control1102755033Lbl: label 'Total';
        Signature_CaptionLbl: label 'Signature:';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: label 'Budget';
        UserSetup: Record "User Setup";
        SavingsAccounts: Record "Savings Accounts";
        Adopted: Boolean;
        period: Date;
        FormattedPeriod: Text;
        DateCapturedF: Text;
        PreviewUserid: Code[50];
        PreviewDate: Text;
        CreatedByName: Text;
        PrintUser: Code[50];
        PrintDate: Text;
}
