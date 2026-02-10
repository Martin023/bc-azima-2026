#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187212 pageextension52187212 extends "Set Web Service Access Key" 
{
    layout
    {
        modify(somegroup)
        {
            Caption = 'Setting a new Web Service key will invalidate the old one.';
        }
        modify(NeverExpires)
        {
            ApplicationArea = Basic;
        }
        modify(ExpirationDate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "NeverExpires(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExpirationDate(Control 3)".

    }
}
