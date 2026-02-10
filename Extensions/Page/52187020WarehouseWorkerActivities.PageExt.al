#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187020 pageextension52187020 extends "Warehouse Worker Activities"
{
    layout
    {
        modify("Unassigned Picks")
        {
            ApplicationArea = Basic;
        }
        modify("My Picks")
        {
            ApplicationArea = Basic;
        }
        modify("Unassigned Put-aways")
        {
            ApplicationArea = Basic;
        }
        modify("My Put-aways")
        {
            ApplicationArea = Basic;
        }
        modify("Unassigned Movements")
        {
            ApplicationArea = Basic;
        }
        modify("My Movements")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unassigned Picks"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""My Picks"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unassigned Put-aways"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""My Put-aways"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unassigned Movements"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""My Movements"(Control 19)".

        // modify("My User Tasks")
        // {
        //     Visible = false;
        // }
        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Visible = false;
        // }
    }
    actions
    {
        // modify("Outbound(Control 3).""Edit Pick Worksheet""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Inbound(Control 8).""Edit Put-away Worksheet""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 9).""Edit Movement Worksheet""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 9).""Edit Warehouse Item Journal""")
        // {
        //     Caption = 'Edit Whse. Item Journal';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on "Internal(Control 9)."Edit Warehouse Item Journal"(Action 22)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Outbound(Control 3)."Edit Pick Worksheet"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Inbound(Control 8)."Edit Put-away Worksheet"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 9)."Edit Movement Worksheet"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 9)."Edit Warehouse Item Journal"(Action 22)".

    }

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
