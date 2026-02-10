#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185698 "Standing Order Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Standing Order Register.rdl';

    dataset
    {
        dataitem("Standing Order Register"; "Standing Order Register")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "Standing Order Register"."No.")
            {
            }
            column(STONo; "Standing Order Register"."Document No.")
            {
            }
            column(SourceAccount; "Standing Order Register"."Source Account No.")
            {
            }
            column(AccName; "Standing Order Register"."Source Account Name")
            {
            }
            column(Status; "Standing Order Register"."Deduction Status")
            {
            }
            column(Amount; "Standing Order Register".Amount)
            {
            }
            column(AmountDeducted; "Standing Order Register"."Amount Deducted")
            {
            }
            column(DateProcessed; "Standing Order Register"."Date Processed")
            {
            }
            // column(Picture;Company.Picture)
            // {
            // }
            // column(Address;Company.Address)
            // {
            // }
            // column(Company_Name;Company.Name)
            // {
            // }
            dataitem("Standing Order Lines"; "Standing Order Lines")
            {
                DataItemLink = "Document No." = field("Document No.");
                column(ReportForNavId_10; 10)
                {
                }
                column(Type; "Standing Order Lines"."Destination Account Type")
                {
                }
                column(DAcc; "Standing Order Lines"."Destination Account No.")
                {
                }
                column(DName; "Standing Order Lines"."Destination Account Name")
                {
                }
                column(DAmount; "Standing Order Lines".Amount)
                {
                }
            }
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
        if Company.Get() then
            Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
}
