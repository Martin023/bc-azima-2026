#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185946 pageextension52185946 extends "Standard Gen. Journal Subform" 
{
    layout
    {
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Business Unit Code")
        {
            ApplicationArea = Basic;
        }
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Posting Type")
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
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Gen. Posting Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to/Pay-to No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to/Order Address Code")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("On Hold")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Payment Type")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        // modify("ShortcutDimCode[5]")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""ShortcutDimCode[5]"(Control 12)".

        //     CaptionClass = '1,2,3';

        //     //Unsupported feature: Property Modification (TableRelation) on ""ShortcutDimCode[5]"(Control 12)".


            //Unsupported feature: Property Modification (Visible) on ""ShortcutDimCode[5]"(Control 12)".


            //Unsupported feature: Property Modification (Name) on ""ShortcutDimCode[5]"(Control 12)".

       // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Business Unit Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Posting Type"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 8)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Difference"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Amount"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Difference"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Gen. Posting Type"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Gen. Bus. Posting Group"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Gen. Prod. Posting Group"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Bus. Posting Group"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. VAT Prod. Posting Group"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to/Pay-to No."(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to/Order Address Code"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""On Hold"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Payment Type"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 76)".

        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        modify("ShortcutDimCode[3]")
        {
            Visible = false;
        }
        // modify("ShortcutDimCode[4]")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Code Modification on ""ShortcutDimCode[5]"(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ValidateShortcutDimCode(5,ShortcutDimCode[5]);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ValidateShortcutDimCode(3,ShortcutDimCode[3]);
            */
        //end;
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
        addafter("Ship-to/Order Address Code")
        {
            // field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            // field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
        }
//         addafter("ShortcutDimCode[5]")
//         {
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
//         moveafter("Ship-to/Order Address Code";"ShortcutDimCode[5]")
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
