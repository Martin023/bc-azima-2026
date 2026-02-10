#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186223 pageextension52186223 extends "Restricted Records" 
{
    layout
    {
        modify(ID)
        {
            ApplicationArea = Basic;
        }
        modify(RecordDetails)
        {
            ApplicationArea = Basic;
        }
        modify(Details)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ID(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecordDetails(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Details(Control 4)".

    }
    actions
    {
        modify("Record")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Record(Action 7)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
