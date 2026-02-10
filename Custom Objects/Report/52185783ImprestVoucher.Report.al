#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185783 "Imprest Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Imprest Voucher.rdl';

    dataset
    {
        dataitem("Imprest Header"; "Imprest Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_6437; 6437)
            {
            }
            column(Project_Dept; "Imprest Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Date; "Imprest Header"."Date Posted")
            {
            }
            dataitem("Imprest Lines"; "Imprest Lines")
            {
                DataItemLink = No = field("No.");
                DataItemTableView = sorting("Line No.", No) order(ascending);
                column(ReportForNavId_3474; 3474)
                {
                }
                column(Destination; "Imprest Lines"."Destination Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                objLogos.Get;
                objLogos.CalcFields(objLogos.Picture);
                /*
                objLogos.RESET;
                objLogos.SETRANGE(objLogos.Code,"Imprest Header"."Global Dimension 1 Code");
               IF objLogos.FIND('-') THEN BEGIN
                   objLogos.CALCFIELDS(objLogos.Picture);
                   //MESSAGE('FOUND PICTURE');
               END ELSE BEGIN
                   objLogos.SETRANGE(objLogos.Default,TRUE);
                   objLogos.CALCFIELDS(objLogos.Picture);
                   //MESSAGE('DEFAULT PICTURE');
               END;
                 */

                DimVal.Reset;
                DimVal.SetRange(DimVal.Code, "Imprest Header"."Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    Project := DimVal.Name;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        STAFF_TRAVEL_ADVANCE_REQUESTCaptionLbl: label 'STAFF TRAVEL ADVANCE REQUEST';
        PAYEMENT_DETAILSCaptionLbl: label 'PAYEMENT DETAILS';
        AmountCaptionLbl: label 'Amount';
        Document_No__CaptionLbl: label 'Document No.:';
        Currency_CaptionLbl: label 'Currency:';
        Payment_To_CaptionLbl: label 'Payment To:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        PURPOSECaptionLbl: label 'PURPOSE';
        Payee_CaptionLbl: label 'Payee:';
        Purpose_CaptionLbl: label 'Purpose:';
        TotalCaptionLbl: label 'Total';
        Printed_By_CaptionLbl: label 'Printed By:';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        RecipientCaptionLbl: label 'Recipient';
        Name_CaptionLbl: label 'Name:';
        Date_CaptionLbl: label 'Date:';
        Signature_CaptionLbl: label 'Signature:';
        objLogos: Record "Company Information";
        CompanyInfo: Record "Company Information";
        DimVal: Record "Dimension Value";
        Project: Text;
}
