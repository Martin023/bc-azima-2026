#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185431 pageextension52185431 extends "Countries/Regions"
{
    layout
    {
        addafter("VAT Scheme")
        {
            field("County Phone Code";Rec."County Phone Code")
            {
                ApplicationArea = all;
            }
        }
    
        modify(Control8)
        {
            Visible = false;
        }
    }
    actions
    {
        modify("VAT Reg. No. Formats")
        {
            ApplicationArea = Basic;
        }
        modify(CustomAddressFormat)
        {
            Visible = false;
        }
    }
}
