#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 52187420 "Mini Std. Purchase Code Card"
{
    Caption = 'Recurring Purchase Lines Card';
    PageType = ListPlus;
    SourceTable = "Standard Purchase Code";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies a code which identifies this standard purchase code.';
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies a description of the standard purchase code.';
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the code for the currency of the amounts on the standard purchase lines.';
                }
            }
            part(StdPurchaseLines;"Mini Std. Purch. Code Subform")
            {
                SubPageLink = "Standard Purchase Code"=field(Code);
            }
        }
    }

    actions
    {
    }
}
