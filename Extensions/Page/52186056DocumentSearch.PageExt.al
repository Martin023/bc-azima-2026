#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186056 pageextension52186056 extends "Document Search" 
{
    layout
    {
        modify(DocumentNo)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify(AmountTolerance)
        {
            ApplicationArea = Basic;
        }
        modify(Warning)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DocumentNo(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountTolerance(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Warning(Control 11)".


        //Unsupported feature: Property Deletion (ShowCaption) on "Warning(Control 11)".

    }
    actions
    {
        modify(Search)
        {
            ApplicationArea = Basic;
        }
    }
}
