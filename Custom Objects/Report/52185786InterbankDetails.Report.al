#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185786 "Interbank Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Interbank Detail New.rdl';

    dataset
    {
        dataitem("InterBank Transfers"; "InterBank Transfers")
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(InterBank_Transfers_Date; Date)
            {
            }
            column(InterBank_Transfers_No; No)
            {
            }
            column(InterBank_Transfers_Status; Status)
            {
            }
            // column(InterBank_Transfers__Receipt_Resp_Centre_; "Receipt Resp Centre")
            // {
            // }
            column(RecvAccName; "Receiving Account" + ':' + "Receiving Bank Account Name")
            {
            }
            // column(InterBank_Transfers__Currency_Code_Destination_; "Currency Code Destination")
            // {
            // }
            column(InterBank_Transfers__Amount_2_; "Amount 2")
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
            // column(InterBank_Transfers__Exch__Rate_Destination_; "Exch. Rate Destination")
            // {
            // }
            // column(InterBank_Transfers__Request_Amt_LCY_; "Request Amt LCY")
            // {
            // }
            // column(InterBank_Transfers__Sending_Resp_Centre_; "Sending Resp Centre")
            // {
            // }
            column(PayAccName; "Paying Account" + ':' + "Paying  Bank Account Name")
            {
            }
            column(Transfer_Release_Date; "Transfer Release Date")
            {
            }
            column(Cheque_No; "Cheque No")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(InterBank_Transfers_Amount; Amount)
            {
            }
            column(Receiving_BankCaption; Receiving_BankCaptionLbl)
            {
            }

            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Transferred_Amt_LCYCaption; Transferred_Amt_LCYCaptionLbl)
            {
            }
            column(Request_DetailsCaption; Request_DetailsCaptionLbl)
            {
            }
            column(Source_DetailsCaption; Source_DetailsCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Name_Caption_Control1102756018; Name_Caption_Control1102756018Lbl)
            {
            }
            column(Date_Caption_Control1102756019; Date_Caption_Control1102756019Lbl)
            {
            }
            column(Signature_Caption_Control1102756022; Signature_Caption_Control1102756022Lbl)
            {
            }
            column(AuthorisationsCaption; AuthorisationsCaptionLbl)
            {
            }
            column(AuthorisationsCaption_Control1102756028; AuthorisationsCaption_Control1102756028Lbl)
            {
            }
            column(Signature_Caption_Control1102756031; Signature_Caption_Control1102756031Lbl)
            {
            }
            column(Date_Caption_Control1102756034; Date_Caption_Control1102756034Lbl)
            {
            }
            column(Name_Caption_Control1102756037; Name_Caption_Control1102756037Lbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102756003; EmptyStringCaption_Control1102756003Lbl)
            {
            }
            column(EmptyStringCaption_Control1102756043; EmptyStringCaption_Control1102756043Lbl)
            {
            }
            column(CompanyINfoName; CompanyINfo.Name)
            {
            }
            column(CompanyINfoPicture; CompanyINfo.Picture)
            {
            }
            column(External_Doc_No_; "External Doc No.")
            {
            }
            column(No; No)
            { }
            column(Date; Date)
            { }
            column(Amount_in_wordsCaptionLbl; Amount_in_wordsCaptionLbl)
            { }
            column(SourceAmount; NumberText[1])
            { }
            column(DestinationAmount; NumberText2[1])
            { }
            column(Approved_By; "Approved By")
            { }
            column(Created_By; "Created By")
            { }

            trigger OnAfterGetRecord()
            begin
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, (Amount), '');
                CheckReport.FormatNoText(NumberText2, ("Amount 2"), '');

                if "Approved By" <> '' then begin
                    UserSetUp.get("Approved By");
                    //Name:= UserSetUp."Full Name";
                end
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        Bank_and_Cash_TransferCaptionLbl: label 'Bank and Cash Transfer';
        EmptyStringCaptionLbl: label '===============================================================================================================================================';
        Receiving_BankCaptionLbl: label 'Receiving Bank';
        Currency_CodeCaptionLbl: label 'Currency Code';
        AmountCaptionLbl: label 'Amount';
        Paying_BankCaptionLbl: label 'Paying Bank';
        Currency_CodeCaption_Control1102756045Lbl: label 'Currency Code';
        Transferred_Amt_LCYCaptionLbl: label 'Transferred Amt LCY';
        Request_DetailsCaptionLbl: label 'Request Details';
        Source_DetailsCaptionLbl: label 'Source Details';
        Signature_CaptionLbl: label 'Signature:';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        Name_Caption_Control1102756018Lbl: label 'Name:';
        Date_Caption_Control1102756019Lbl: label 'Date:';
        Signature_Caption_Control1102756022Lbl: label 'Signature:';
        AuthorisationsCaptionLbl: label 'Authorisations';
        AuthorisationsCaption_Control1102756028Lbl: label 'Authorisations';
        Signature_Caption_Control1102756031Lbl: label 'Signature:';
        Date_Caption_Control1102756034Lbl: label 'Date:';
        Name_Caption_Control1102756037Lbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        EmptyStringCaption_Control1102756003Lbl: label '===============================================================================================================================================';
        EmptyStringCaption_Control1102756043Lbl: label '===============================================================================================================================================';
        CompanyINfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        NumberText: array[2] of Text[80];
        CheckReport: Report Check;
        NumberText2: array[2] of Text[80];
        UserSetUp: Record "User Setup";
}
