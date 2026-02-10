#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185798 pageextension52185798 extends "Item Journal Lines"
{
    layout
    {
        modify("Journal Template Name")
        {
            ApplicationArea = Basic;
        }
        modify("Journal Batch Name")
        {
            ApplicationArea = Basic;
        }
        modify("Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Indirect Cost %")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Journal Template Name"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Journal Batch Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Qty. (Base)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Amount"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 59)".

        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[3]")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[4]")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[5]")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[6]")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[7]")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[8]")
        // {
        //     Visible = false;
        // }
        addafter(Description)
        {
            // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            // field("ShortcutDimCode[3]"; ShortcutDimCode[3])
            // {
            //     ApplicationArea = Basic;
            //     CaptionClass = '1,2,3';
            //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
            //                                                   "Dimension Value Type" = const(Standard),
            //                                                   Blocked = const(false));
            //     Visible = false;
            // }
            // field("ShortcutDimCode[4]"; ShortcutDimCode[4])
            // {
            //     ApplicationArea = Basic;
            //     CaptionClass = '1,2,4';
            //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
            //                                                   "Dimension Value Type" = const(Standard),
            //                                                   Blocked = const(false));
            //     Visible = false;
            // }
            // field("ShortcutDimCode[5]"; ShortcutDimCode[5])
            // {
            //     ApplicationArea = Basic;
            //     CaptionClass = '1,2,5';
            //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
            //                                                   "Dimension Value Type" = const(Standard),
            //                                                   Blocked = const(false));
            //     Visible = false;
            // }
            // field("ShortcutDimCode[6]"; ShortcutDimCode[6])
            // {
            //     ApplicationArea = Basic;
            //     CaptionClass = '1,2,6';
            //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
            //                                                   "Dimension Value Type" = const(Standard),
            //                                                   Blocked = const(false));
            //     Visible = false;
            // }
            // field("ShortcutDimCode[7]"; ShortcutDimCode[7])
            // {
            //     ApplicationArea = Basic;
            //     CaptionClass = '1,2,7';
            //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
            //                                                   "Dimension Value Type" = const(Standard),
            //                                                   Blocked = const(false));
            //     Visible = false;
            // }
            // field("ShortcutDimCode[8]"; ShortcutDimCode[8])
            // {
            //     ApplicationArea = Basic;
            //     CaptionClass = '1,2,8';
            //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
            //                                                   "Dimension Value Type" = const(Standard),
            //                                                   Blocked = const(false));
            //     Visible = false;
            // }
        }
    }
    actions
    {
        modify("Show Batch")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Batch"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 6500)".

    }
}
