#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186002 "Salary Agreement List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Salary Agreement List.rdl';

    dataset
    {
        dataitem("Salary Agreement"; "Salary Agreement")
        {
            DataItemTableView = where(Status = filter(<> Rejected));
            RequestFilterFields = "Member No", "Payroll No", "Date Captured", Category;

            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(MemberNo; "Salary Agreement"."Member No")
            {
            }
            column(MemberName; "Salary Agreement"."Member Name")
            {
            }
            column(IDNo; "Salary Agreement"."ID No")
            {
            }
            column(PayrollNo; "Salary Agreement"."Payroll No")
            {
            }
            column(Department; "Salary Agreement".Department)
            {
            }
            column(Ministry; "Salary Agreement".Ministry)
            {
            }
            column(FosaAccountNo; "Salary Agreement"."Fosa Account No")
            {
            }
            column(WithEffectFrom; "Salary Agreement"."With Effect From")
            {
            }
            column(Category; "Salary Agreement".Category)
            {
            }
            column(DateCaptured; "Salary Agreement"."Date Captured")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(Adopted; Adopted)
            {
            }
            column(period; period)
            {
            }
            column(DateCapturedF; DateCapturedF)
            {
            }
            column(FormattedPeriod; FormattedPeriod)
            {
            }
            column(WithEffectFro; WithEffectFrom)
            {
            }
            column(FirstDate; FirstDate)
            {
            }
            column(LastDate; LastDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("No.", "Salary Agreement"."Fosa Account No");
                if SavingsAccounts.Find('-') then
                    Adopted := SavingsAccounts."Salary Through FOSA";
                DateCapturedF := Format(Date2dmy("Salary Agreement"."Date Captured", 1)) + '/' + Format(Date2dmy("Salary Agreement"."Date Captured", 2))
                + '/' + Format(Date2dmy("Salary Agreement"."Date Captured", 3));
                //WithEffectFrom := SkyHarambeePortal.FormatDate("Salary Agreement"."With Effect From");
            end;

            trigger OnPreDataItem()
            begin
                // IF period=0D THEN ERROR('You must specify the period');
                // "Salary Agreement".SETRANGE("Salary Agreement"."With Effect From",period);
                // FormattedPeriod := FORMAT(DATE2DMY(period,1))+'/'+FORMAT(DATE2DMY(period,2))+'/'+FORMAT(DATE2DMY(period,3));
                "Salary Agreement".FindFirst;
                // FirstDate := SkyHarambeePortal.FormatDate("Salary Agreement"."Date Captured");
                // "Salary Agreement".FindLast;
                // LastDate := SkyHarambeePortal.FormatDate("Salary Agreement"."Date Captured");
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
        WithEffectFrom: Text;
        FirstDate: Text;
        LastDate: Text;
}
