#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185452 pageextension52185452 extends "Item Journal"
{
    Caption = 'Item Journal';
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
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
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
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
            visible=true;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
            visible=true;
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
        modify("Discount Amount")
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
        modify("Applies-from Entry")
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
        modify(ItemDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Code Modification on ""Location Code"(Control 37).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Location Code" <> '' THEN
          IF Item.GET("Item No.") THEN
            Item.TESTFIELD(Type,Item.Type::Inventory);
        WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Discount Amount"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-from Entry"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Type"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transport Method"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 61)".

        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemDescription(Control 23)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ItemDescription(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1903326807(Control 1903326807)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

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
            field("ShortcutDimCode[3]"; ShortcutDimCode[3])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field("ShortcutDimCode[4]"; ShortcutDimCode[4])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field("ShortcutDimCode[5]"; ShortcutDimCode[5])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field("ShortcutDimCode[6]"; ShortcutDimCode[6])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field("ShortcutDimCode[7]"; ShortcutDimCode[7])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field("ShortcutDimCode[8]"; ShortcutDimCode[8])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                              "Dimension Value Type" = const(Standard),
                                                              Blocked = const(false));
                Visible = false;

                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
        }
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Dimensions(Action 82)".

        }
        modify(ItemTrackingLines)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "ItemTrackingLines(Action 6500)".

        }
        modify("Bin Contents")
        {
            ApplicationArea = Basic;
        }
        modify("&Recalculate Unit Amount")
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
        modify("&Calculate Warehouse Adjustment")
        {
            Caption = '&Calculate Whse. Adjustment';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""&Calculate Warehouse Adjustment"(Action 7300)".

        }
        modify("&Get Standard Journals")
        {
            ApplicationArea = Basic;
        }
        modify("&Save as Standard Journal")
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

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 70)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 6500)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 69)".


        //Unsupported feature: Property Deletion (Promoted) on ""Bin Contents"(Action 69)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Bin Contents"(Action 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Recalculate Unit Amount"(Action 83)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Recalculate Unit Amount"(Action 83)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Recalculate Unit Amount"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 76)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 5)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""E&xplode BOM"(Action 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Calculate Warehouse Adjustment"(Action 7300)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Get Standard Journals"(Action 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Save as Standard Journal"(Action 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 70)".

        modify("Page")
        {
            Visible = false;
        }
        modify(EditInExcel)
        {
            Visible = false;
        }
        addafter("Bin Contents")
        {
            separator(Action80)
            {
                Caption = '-';
            }
        }
        addafter("&Calculate Warehouse Adjustment")
        {
            separator(Action73)
            {
                Caption = '-';
            }
        }
    }


    //Unsupported feature: Property Modification (Length) on "ItemDescription(Variable 1004)".

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
    IsSaasExcelAddinEnabled := ServerConfigSettingHandler.GetIsSaasExcelAddinEnabled;
    IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::ODataV4 THEN
      EXIT;

    SetDimensionsVisibility;

    IF IsOpenedFromBatch THEN BEGIN
      CurrentJnlBatchName := "Journal Batch Name";
      ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    #10..12
    IF NOT JnlSelected THEN
      ERROR('');
    ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #7..15
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
