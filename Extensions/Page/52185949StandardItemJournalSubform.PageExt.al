#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185949 pageextension52185949 extends "Standard Item Journal Subform"
{
    layout
    {
        modify("Entry Type")
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
        modify("Bin Code")
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
        modify("Transaction Type")
        {
            ApplicationArea = Basic;
        }
        modify("Transport Method")
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 54)".

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
            //             field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
            //             {
            //                 ApplicationArea = Basic;
            //                 Visible = false;
            //             }
            //             field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
            //             {
            //                 ApplicationArea = Basic;
            //                 Visible = false;
            //             }
            //             field("ShortcutDimCode[3]";ShortcutDimCode[3])
            //             {
            //                 ApplicationArea = Basic;
            //                 CaptionClass = '1,2,3';
            //                 TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3),
            //                                                               "Dimension Value Type"=const(Standard),
            //                                                               Blocked=const(false));
            //                 Visible = false;

            //                 trigger OnValidate()
            //                 begin
            //                     Rec.ValidateShortcutDimCode(3,ShortcutDimCode[3]);
            //                 end;
            //             }
            //             field("ShortcutDimCode[4]";ShortcutDimCode[4])
            //             {
            //                 ApplicationArea = Basic;
            //                 CaptionClass = '1,2,4';
            //                 TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4),
            //                                                               "Dimension Value Type"=const(Standard),
            //                                                               Blocked=const(false));
            //                 Visible = false;

            //                 trigger OnValidate()
            //                 begin
            //                     Rec.ValidateShortcutDimCode(4,ShortcutDimCode[4]);
            //                 end;
            //             }
            //             field("ShortcutDimCode[5]";ShortcutDimCode[5])
            //             {
            //                 ApplicationArea = Basic;
            //                 CaptionClass = '1,2,5';
            //                 TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(5),
            //                                                               "Dimension Value Type"=const(Standard),
            //                                                               Blocked=const(false));
            //                 Visible = false;

            //                 trigger OnValidate()
            //                 begin
            //                     Rec.ValidateShortcutDimCode(5,ShortcutDimCode[5]);
            //                 end;
            //             }
            //             field("ShortcutDimCode[6]";ShortcutDimCode[6])
            //             {
            //                 ApplicationArea = Basic;
            //                 CaptionClass = '1,2,6';
            //                 TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(6),
            //                                                               "Dimension Value Type"=const(Standard),
            //                                                               Blocked=const(false));
            //                 Visible = false;

            //                 trigger OnValidate()
            //                 begin
            //                     Rec.ValidateShortcutDimCode(6,ShortcutDimCode[6]);
            //                 end;
            //             }
            //             field("ShortcutDimCode[7]";ShortcutDimCode[7])
            //             {
            //                 ApplicationArea = Basic;
            //                 CaptionClass = '1,2,7';
            //                 TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(7),
            //                                                               "Dimension Value Type"=const(Standard),
            //                                                               Blocked=const(false));
            //                 Visible = false;

            //                 trigger OnValidate()
            //                 begin
            //                     Rec.ValidateShortcutDimCode(7,ShortcutDimCode[7]);
            //                 end;
            //             }
            //             field("ShortcutDimCode[8]";ShortcutDimCode[8])
            //             {
            //                 ApplicationArea = Basic;
            //                 CaptionClass = '1,2,8';
            //                 TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(8),
            //                                                               "Dimension Value Type"=const(Standard),
            //                                                               Blocked=const(false));
            //                 Visible = false;

            //                 trigger OnValidate()
            //                 begin
            //                     Rec.ValidateShortcutDimCode(8,ShortcutDimCode[8]);
            //                 end;
            //             }
            //         }
            //     }
            //     actions
            //     {
            //         modify(Dimensions)
            //         {
            //             ApplicationArea = Basic;
            //         }

            //         //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1900206304)".

        }
    }
}