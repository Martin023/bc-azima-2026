#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185826 "Quotation Analysis Weighing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Quotation Analysis Weighing.rdl';

    dataset
    {
        dataitem("Purchase Quote Header"; "Purchase Quote Header")
        {
            DataItemTableView = sorting("Document Type", "No.");
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("Purchase Quote Line"; "Purchase Quote Line")
            {
                //DataItemLink = "Document Type"=field("Document Type"),"Document No."=field("No.");
                column(ReportForNavId_2; 2)
                {
                }
                dataitem("Purchase Quote Params"; "Purchase Quote Params")
                {
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No.");
                    column(ReportForNavId_3; 3)
                    {
                    }
                    dataitem("Quotation Specification Lines"; "Quotation Specification Lines")
                    {
                        column(ReportForNavId_4; 4)
                        {
                        }
                    }
                }
            }

            trigger OnPreDataItem()
            begin
                //LastFieldNo := UnknownTable52185926.FieldNo("No.");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Vend: Record Vendor;
}
