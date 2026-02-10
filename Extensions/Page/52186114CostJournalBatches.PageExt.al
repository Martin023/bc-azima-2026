#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186114 pageextension52186114 extends "Cost Journal Batches" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Cost Type No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Cost Center Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Cost Object Code")
        {
            ApplicationArea = Basic;
        }
        modify("Delete after Posting")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Cost Type No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Cost Center Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Cost Object Code"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete after Posting"(Control 16)".

    }
    actions
    {
        modify("Edit Journal")
        {
            ApplicationArea = Basic;
        }
        modify("P&ost")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Edit Journal"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 15)".

    }
}
