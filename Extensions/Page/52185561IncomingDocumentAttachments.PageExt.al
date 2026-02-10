#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185561 pageextension52185561 extends "Incoming Document Attachments" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("File Extension")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Created Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Created By User Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""File Extension"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created Date-Time"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created By User Name"(Control 10)".

    }
    actions
    {
        modify(Export)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 9)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "LoadDataIntoPart(PROCEDURE 3)".

}
