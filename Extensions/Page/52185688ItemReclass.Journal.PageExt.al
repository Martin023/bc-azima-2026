#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185688 pageextension52185688 extends "Item Reclass. Journal" 
{
    Caption = 'Item Reclass. Journal';
    layout
    {
        modify(CurrentJnlBatchName)
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

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 37)".

        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("New Location Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""New Location Code"(Control 39)".

        }
        modify("New Bin Code")
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
        modify("Applies-to Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        // modify("New Shortcut Dimension 1 Code")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""New Shortcut Dimension 1 Code"(Control 41)".


        //     //Unsupported feature: Property Modification (Visible) on ""New Shortcut Dimension 1 Code"(Control 41)".


        //     //Unsupported feature: Property Modification (Name) on ""New Shortcut Dimension 1 Code"(Control 41)".

        // }
        modify(ItemDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Location Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Bin Code"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 61)".

        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""New Shortcut Dimension 1 Code"(Control 41)".

        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        // modify("New Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(NewShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(NewShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(NewShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(NewShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(NewShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }
        modify(NewShortcutDimCode8)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ShowCaption) on "ItemDescription(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

         addafter("New Shortcut Dimension 1 Code")
         {
        // {
        //     field("New Shortcut Dimension 1 Code";Rec."New Shortcut Dimension 1 Code")
        //     {
        //         ApplicationArea = Basic;
        //         Visible = false;
        //     }
        //     field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
        //     {
        //         ApplicationArea = Basic;
        //         Visible = false;
        //     }
        //     field("New Shortcut Dimension 2 Code";Rec."New Shortcut Dimension 2 Code")
        //     {
        //         ApplicationArea = Basic;
        //         Visible = false;
        //     }
            field("ShortcutDimCode[3]";ShortcutDimCode[3])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3),
                                                              "Dimension Value Type"=const(Standard),
                                                              Blocked=const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                end;
            }
            field("NewShortcutDimCode[3]";NewShortcutDimCode[3])
            {
                ApplicationArea = Basic;
                //CaptionClass = Text000;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupNewShortcutDimCode(3,NewShortcutDimCode[3]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Rec."Entry Type",Rec."entry type"::Transfer);
                    Rec.ValidateNewShortcutDimCode(3,NewShortcutDimCode[3]);
                end;
            }
            field("ShortcutDimCode[4]";ShortcutDimCode[4])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4),
                                                              "Dimension Value Type"=const(Standard),
                                                              Blocked=const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                end;
            }
            field("NewShortcutDimCode[4]";NewShortcutDimCode[4])
            {
                ApplicationArea = Basic;
                //CaptionClass = Text001;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupNewShortcutDimCode(4,NewShortcutDimCode[4]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Rec."Entry Type",Rec."entry type"::Transfer);
                    Rec.ValidateNewShortcutDimCode(4,NewShortcutDimCode[4]);
                end;
            }
            field("ShortcutDimCode[5]";ShortcutDimCode[5])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(5),
                                                              "Dimension Value Type"=const(Standard),
                                                              Blocked=const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(5,ShortcutDimCode[5]);
                end;
            }
            field("NewShortcutDimCode[5]";NewShortcutDimCode[5])
            {
                ApplicationArea = Basic;
               //CaptionClass = Text002;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupNewShortcutDimCode(5,NewShortcutDimCode[5]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Rec."Entry Type",Rec."entry type"::Transfer);
                    Rec.ValidateNewShortcutDimCode(5,NewShortcutDimCode[5]);
                end;
            }
            field("ShortcutDimCode[6]";ShortcutDimCode[6])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(6),
                                                              "Dimension Value Type"=const(Standard),
                                                              Blocked=const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(6,ShortcutDimCode[6]);
                end;
            }
            field("NewShortcutDimCode[6]";NewShortcutDimCode[6])
            {
                ApplicationArea = Basic;
                //CaptionClass = Text003;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupNewShortcutDimCode(6,NewShortcutDimCode[6]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Rec."Entry Type",Rec."entry type"::Transfer);
                    Rec.ValidateNewShortcutDimCode(6,NewShortcutDimCode[6]);
                end;
            }
            field("ShortcutDimCode[7]";ShortcutDimCode[7])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(7),
                                                              "Dimension Value Type"=const(Standard),
                                                              Blocked=const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(7,ShortcutDimCode[7]);
                end;
            }
            field("NewShortcutDimCode[7]";NewShortcutDimCode[7])
            {
                ApplicationArea = Basic;
                //CaptionClass = Text004;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupNewShortcutDimCode(7,NewShortcutDimCode[7]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Rec."Entry Type",Rec."entry type"::Transfer);
                    Rec.ValidateNewShortcutDimCode(7,NewShortcutDimCode[7]);
                end;
            }
            field("ShortcutDimCode[8]";ShortcutDimCode[8])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(8),
                                                              "Dimension Value Type"=const(Standard),
                                                              Blocked=const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(8,ShortcutDimCode[8]);
                end;
            }
            field("NewShortcutDimCode[8]";NewShortcutDimCode[8])
            {
                ApplicationArea = Basic;
               // CaptionClass = Text005;
                Visible = false;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.LookupNewShortcutDimCode(8,NewShortcutDimCode[8]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Rec."Entry Type",Rec."entry type"::Transfer);
                    Rec.ValidateNewShortcutDimCode(8,NewShortcutDimCode[8]);
                end;
            }
        }
        moveafter(Description;"New Shortcut Dimension 1 Code")
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Contents")
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on ""Ledger E&ntries"(Action 31)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 31)".

        }
        modify("Event")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }
        modify("E&xplode BOM")
        {
            ApplicationArea = Basic;
        }
        modify("Get Bin Content")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 34)".

        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Post and &Print"(Action 35)".

        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 60)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 86)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 86)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 6500)".


        //Unsupported feature: Property Deletion (Promoted) on ""Item &Tracking Lines"(Action 6500)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Item &Tracking Lines"(Action 6500)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 51)".


        //Unsupported feature: Property Deletion (Promoted) on ""Bin Contents"(Action 51)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Bin Contents"(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 79)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 3)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""E&xplode BOM"(Action 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Bin Content"(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 60)".

    }


    //Unsupported feature: Property Modification (Length) on "ItemDescription(Variable 1009)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemDescription : 50;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetDimensionsVisibility;

        IF IsOpenedFromBatch THEN BEGIN
          CurrentJnlBatchName := "Journal Batch Name";
          ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
        #6..8
        IF NOT JnlSelected THEN
          ERROR('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..11
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
