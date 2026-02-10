#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185943 "Sinkfund not paid"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sinkfund not paid.rdl';

    dataset
    {
        dataitem(Sinkfund; "SinkFund Report Information")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Notice_Number; SinkFund.No)
            {
            }
            column(Member_No; SinkFund."Member No")
            {
            }
            column(Member_Name; SinkFund."Member Name")
            {
            }
            column(Notice_Date; SinkFund.Date)
            {
            }
            column(Death_Date; SinkFund."Date of Death")
            {
            }

            column(Deceased_Person; SinkFund."Deceased Person")
            {
            }

            column(Name; Company.Name)
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(PhoneNo; Company."Phone No.")
            {
            }
            column(Address; Company.Address)
            {
            }
            dataitem("BBF Claim Lines"; "BBF Claim Lines")
            {
                DataItemLink = "Header No." = field(No);
                column(Outstanding_Balance; "Outstanding Balance")
                {

                }

            }

            trigger OnAfterGetRecord()
            begin
                BBFheader.Reset;
                BBFheader.SetRange("Report Notice No", SinkFund.No);
                if BBFheader.FindFirst then
                    if BBFheader.Posted = true then
                        CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
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
                field("Claim Type:"; Sinkfund."Claim Type")
                {

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Company: Record "Company Information";
        BBFheader: Record "BBF Requisation Header";
}
