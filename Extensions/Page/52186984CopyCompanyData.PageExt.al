#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186984 pageextension52186984 extends "Copy Company Data" 
{
    layout
    {
        modify(NewCompanyName)
        {
            ApplicationArea = Basic;
        }
        modify("Package Code")
        {
            ApplicationArea = Basic;
        }
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfRecordsSourceTable)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "NewCompanyName(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Package Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table ID"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfRecordsSourceTable(Control 4)".

    }
    actions
    {
        modify("Copy Data")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Data"(Action 3)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetCompanyFilter(PROCEDURE 3)".

}
