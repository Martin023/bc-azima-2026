#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186411 pageextension52186411 extends "Exchange Folders" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(FullPath)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FullPath(Control 4)".

    }
    actions
    {
        modify(GetChildren)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (RunPageMode) on "GetChildren(Action 2)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "GetChildren(Action 2)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 1)".

}
