#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185611 "G/L Update Consolidation"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            RequestFilterFields = "No.", "Account Type";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                GL.Reset;
                GL.SetRange(GL."No.", "G/L Account"."No.");
                if GL.Find('-') then begin
                    GL."Consol. Debit Acc." := "G/L Account"."No.";
                    GL."Consol. Credit Acc." := "G/L Account"."No.";
                    GL.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message(Txt001);
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
        GL: Record "G/L Account";
        Txt001: label 'Process Complete';
}
