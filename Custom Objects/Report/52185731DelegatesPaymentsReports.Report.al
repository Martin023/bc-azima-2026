#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185731 "Delegates Payments Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Delegates Payments Reports.rdl';

    dataset
    {
        //dataitem(52186067;52186067)
        dataitem("Delegates Payment"; "Delegates Payment")
        {
            DataItemTableView = where(Posted = const(True), "Total Payment" = filter(<> 0));
            RequestFilterFields = "Posted By", "Date Posted", "Transaction Type";
            column(ReportForNavId_1; 1)
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
            column(SNo; "SNo.")
            {
            }
            column("Code"; "Delegates Payment".Code)
            {
            }

            column(ElectoralZone; "Delegates Payment"."Electoral Zone")
            {
            }
            column(ElectoralZoneName; "Delegates Payment"."Electoral Zone Name")
            {
            }
            column(DatePosted; "Delegates Payment"."Date Posted")
            {
            }
            column(PostedBy; "Delegates Payment"."Posted By")
            {
            }

            column(TotalPayment; "Delegates Payment"."Total Payment")
            {
            }
            column(TransactionType; "Delegates Payment"."Transaction Type")
            {
            }

            column(MinuteNo; "Delegates Payment"."Minute No.")
            {
            }

            dataitem("Delegate Payment Line"; "Delegate Payment Line")
            {
                DataItemLink = Code = field(Code);
                column(ReportForNavId_7; 7)
                {
                }
                column(DelegateMNo; "Delegate Payment Line"."Delegate MNO.")
                {
                }
                column(DelegateName; "Delegate Payment Line"."Delegate Name")
                {
                }
                column(TariffCode; Tarrif)
                {
                }
                column(AmountPayable; "Delegate Payment Line"."Amount Payable")
                {
                }


            }

            trigger OnAfterGetRecord()
            begin
                "SNo." += 1;
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        "SNo.": Integer;
        RegionDelegatesTariff: Record "Region Delegates Tariff";
        Tarrif: Text;
}
