#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186441 pageextension52186441 extends "Production Journal"
{
    layout
    {
        modify(PostingDate)
        {
            ApplicationArea = Basic;
        }
        modify(FlushingFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order Line No.")
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
        modify("Operation No.")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            OptionCaption = 'Work Center,Machine Center';
            ApplicationArea = Basic;
        }
        modify("Flushing Method")
        {
            ApplicationArea = Basic;
        }
        modify("No.")
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
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
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
        modify("Work Shift Code")
        {
            ApplicationArea = Basic;
            Editable = "Work Shift CodeEditable";
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Time")
        {
            ApplicationArea = Basic;
            Editable = "Starting TimeEditable";
        }
        modify("Ending Time")
        {
            ApplicationArea = Basic;
            Editable = "Ending TimeEditable";
        }
        modify("Concurrent Capacity")
        {
            ApplicationArea = Basic;
            Editable = "Concurrent CapacityEditable";
        }
        modify("Setup Time")
        {
            ApplicationArea = Basic;
            Editable = "Setup TimeEditable";
            HideValue = "Setup TimeHideValue";
        }
        modify("Run Time")
        {
            ApplicationArea = Basic;
            Editable = "Run TimeEditable";
            HideValue = "Run TimeHideValue";
        }
        modify("Cap. Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Scrap Code")
        {
            ApplicationArea = Basic;
            Editable = "Scrap CodeEditable";
        }
        modify("Output Quantity")
        {
            ApplicationArea = Basic;
            Editable = "Output QuantityEditable";
            HideValue = "Output QuantityHideValue";
        }
        modify("Scrap Quantity")
        {
            ApplicationArea = Basic;
            Editable = "Scrap QuantityEditable";
            HideValue = "Scrap QuantityHideValue";
        }
        modify(Finished)
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
            Editable = "Applies-from EntryEditable";
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(ActualConsumpQty)
        {
            ApplicationArea = Basic;
        }
        modify(ActualSetupTime)
        {
            ApplicationArea = Basic;
        }
        modify(ActualRunTime)
        {
            ApplicationArea = Basic;
        }
        modify(ActualOutputQty)
        {
            ApplicationArea = Basic;
        }
        modify(ActualScrapQty)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PostingDate(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FlushingFilter(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Line No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Operation No."(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Flushing Method"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Shift Code"(Control 114)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Time"(Control 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Concurrent Capacity"(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Setup Time"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run Time"(Control 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cap. Unit of Measure Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scrap Code"(Control 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Output Quantity"(Control 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Scrap Quantity"(Control 128)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Finished(Control 122)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Entry"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-from Entry"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 134)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 136)".

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

        //Unsupported feature: Property Deletion (ShowCaption) on "ActualConsumpQty(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActualSetupTime(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActualRunTime(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActualOutputQty(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActualScrapQty(Control 58)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Work Shift Code")
        {
            // field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
        }
        addafter("Gen. Prod. Posting Group")
        {
            // field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
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
        }
        modify(ItemTrackingLines)
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
        modify("Item Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Capacity Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Value Entries")
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

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 56)".

        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Post and &Print"(Action 57)".

        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 31)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 44)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 44)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 45)".


        //Unsupported feature: Property Deletion (Promoted) on "ItemTrackingLines(Action 45)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ItemTrackingLines(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 46)".


        //Unsupported feature: Property Deletion (Promoted) on ""Bin Contents"(Action 46)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Bin Contents"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 19)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 19)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Ledger E&ntries"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Capacity Ledger Entries"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Value Entries"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 31)".

    }

    var

        "Setup TimeHideValue": Boolean;

        "Run TimeHideValue": Boolean;

        "Output QuantityHideValue": Boolean;

        "Scrap QuantityHideValue": Boolean;

    var

        "Starting TimeEditable": Boolean;

        "Ending TimeEditable": Boolean;

        "Concurrent CapacityEditable": Boolean;

    var

        "Setup TimeEditable": Boolean;

        "Run TimeEditable": Boolean;

        "Work Shift CodeEditable": Boolean;

    var

        "Scrap CodeEditable": Boolean;

        "Scrap QuantityEditable": Boolean;

        "Output QuantityEditable": Boolean;

    var

        "Applies-from EntryEditable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActualScrapQtyHideValue := FALSE;
    ActualOutputQtyHideValue := FALSE;
    ActualRunTimeHideValue := FALSE;
    ActualSetupTimeHideValue := FALSE;
    ActualConsumpQtyHideValue := FALSE;
    ScrapQuantityHideValue := FALSE;
    OutputQuantityHideValue := FALSE;
    RunTimeHideValue := FALSE;
    SetupTimeHideValue := FALSE;
    QuantityHideValue := FALSE;
    DescriptionIndent := 0;
    ShowShortcutDimCode(ShortcutDimCode);
    #13..20
    ActualRunTimeOnFormat;
    ActualOutputQtyOnFormat;
    ActualScrapQtyOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    "Scrap QuantityHideValue" := FALSE;
    "Output QuantityHideValue" := FALSE;
    "Run TimeHideValue" := FALSE;
    "Setup TimeHideValue" := FALSE;
    #10..23
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AppliesFromEntryEditable := TRUE;
    QuantityEditable := TRUE;
    OutputQuantityEditable := TRUE;
    ScrapQuantityEditable := TRUE;
    ScrapCodeEditable := TRUE;
    FinishedEditable := TRUE;
    WorkShiftCodeEditable := TRUE;
    RunTimeEditable := TRUE;
    SetupTimeEditable := TRUE;
    CapUnitofMeasureCodeEditable := TRUE;
    ConcurrentCapacityEditable := TRUE;
    EndingTimeEditable := TRUE;
    StartingTimeEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Applies-from EntryEditable" := TRUE;
    QuantityEditable := TRUE;
    "Output QuantityEditable" := TRUE;
    "Scrap QuantityEditable" := TRUE;
    "Scrap CodeEditable" := TRUE;
    FinishedEditable := TRUE;
    "Work Shift CodeEditable" := TRUE;
    "Run TimeEditable" := TRUE;
    "Setup TimeEditable" := TRUE;
    CapUnitofMeasureCodeEditable := TRUE;
    "Concurrent CapacityEditable" := TRUE;
    "Ending TimeEditable" := TRUE;
    "Starting TimeEditable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetFilterGroup;

    IF ProdOrderLineNo <> 0 THEN
      ProdOrderLine.GET(ProdOrder.Status,ProdOrder."No.",ProdOrderLineNo);

    SetDimensionsVisibility;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Setup(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "GetActTimeAndQtyBase(PROCEDURE 4)".

    //procedure GetActTimeAndQtyBase();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActualSetupTime := 0;
    ActualRunTime := 0;
    ActualOutputQty := 0;
    #4..21
            ActualConsumpQty :=
              ProdOrderComp."Act. Consumption (Qty)" / "Qty. per Unit of Measure";
            IF Item."Rounding Precision" > 0 THEN
              ActualConsumpQty := UOMMgt.RoundToItemRndPrecision(ActualConsumpQty,Item."Rounding Precision")
            ELSE
              ActualConsumpQty := ROUND(ActualConsumpQty,UOMMgt.QtyRndPrecision);
          END;
        "Entry Type"::Output:
          BEGIN
    #31..34
              CostCalcMgt.CalcActTimeAndQtyBase(
                ProdOrderLine,"Operation No.",ActualRunTime,ActualSetupTime,ActualOutputQty,ActualScrapQty);
              ActualSetupTime :=
                ROUND(ActualSetupTime / "Qty. per Cap. Unit of Measure",UOMMgt.TimeRndPrecision);
              ActualRunTime :=
                ROUND(ActualRunTime / "Qty. per Cap. Unit of Measure",UOMMgt.TimeRndPrecision);

              ActualOutputQty := ActualOutputQty / "Qty. per Unit of Measure";
              ActualScrapQty := ActualScrapQty / "Qty. per Unit of Measure";
              IF Item."Rounding Precision" > 0 THEN BEGIN
                ActualOutputQty := UOMMgt.RoundToItemRndPrecision(ActualOutputQty,Item."Rounding Precision");
                ActualScrapQty := UOMMgt.RoundToItemRndPrecision(ActualScrapQty,Item."Rounding Precision");
              END ELSE BEGIN
                ActualOutputQty := ROUND(ActualOutputQty,UOMMgt.QtyRndPrecision);
                ActualScrapQty := ROUND(ActualScrapQty,UOMMgt.QtyRndPrecision);
              END;
            END;
          END;
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24
              ActualConsumpQty := ROUND(ActualConsumpQty,Item."Rounding Precision",'>')
            ELSE
              ActualConsumpQty := ROUND(ActualConsumpQty,0.00001);
    #28..37
                ROUND(ActualSetupTime / "Qty. per Cap. Unit of Measure",0.00001);
              ActualRunTime :=
                ROUND(ActualRunTime / "Qty. per Cap. Unit of Measure",0.00001);
    #41..44
                ActualOutputQty := ROUND(ActualOutputQty,Item."Rounding Precision",'>');
                ActualScrapQty := ROUND(ActualScrapQty,Item."Rounding Precision",'>');
              END ELSE BEGIN
                ActualOutputQty := ROUND(ActualOutputQty,0.00001);
                ActualScrapQty := ROUND(ActualScrapQty,0.00001);
    #50..53
    */
    //end;


    //Unsupported feature: Code Modification on "ControlsMngt(PROCEDURE 1)".

    //procedure ControlsMngt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Output) AND
       ("Operation No." <> '')
    THEN
      OperationExist := TRUE
    ELSE
      OperationExist := FALSE;

    StartingTimeEditable := OperationExist;
    EndingTimeEditable := OperationExist;
    ConcurrentCapacityEditable := OperationExist;
    CapUnitofMeasureCodeEditable := OperationExist;
    SetupTimeEditable := OperationExist;
    RunTimeEditable := OperationExist;
    WorkShiftCodeEditable := OperationExist;

    FinishedEditable := "Entry Type" = "Entry Type"::Output;
    ScrapCodeEditable := "Entry Type" = "Entry Type"::Output;
    ScrapQuantityEditable := "Entry Type" = "Entry Type"::Output;
    OutputQuantityEditable := "Entry Type" = "Entry Type"::Output;

    QuantityEditable := "Entry Type" = "Entry Type"::Consumption;
    AppliesFromEntryEditable := "Entry Type" = "Entry Type"::Consumption;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    "Starting TimeEditable" := OperationExist;
    "Ending TimeEditable" := OperationExist;
    "Concurrent CapacityEditable" := OperationExist;
    CapUnitofMeasureCodeEditable := OperationExist;
    "Setup TimeEditable" := OperationExist;
    "Run TimeEditable" := OperationExist;
    "Work Shift CodeEditable" := OperationExist;

    FinishedEditable := "Entry Type" = "Entry Type"::Output;
    "Scrap CodeEditable" := "Entry Type" = "Entry Type"::Output;
    "Scrap QuantityEditable" := "Entry Type" = "Entry Type"::Output;
    "Output QuantityEditable" := "Entry Type" = "Entry Type"::Output;

    QuantityEditable := "Entry Type" = "Entry Type"::Consumption;
    "Applies-from EntryEditable" := "Entry Type" = "Entry Type"::Consumption;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetFilterGroup(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "SetFilterGroup(PROCEDURE 5)".

    //procedure SetFilterGroup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FILTERGROUP(2);
    SETRANGE("Journal Template Name",ToTemplateName);
    SETRANGE("Journal Batch Name",ToBatchName);
    SETRANGE("Order Type","Order Type"::Production);
    SETRANGE("Order No.",ProdOrder."No.");
    IF ProdOrderLineNo <> 0 THEN
      SETRANGE("Order Line No.",ProdOrderLineNo);
    SetFlushingFilter;
    OnAfterSetFilterGroup(Rec,ProdOrder,ProdOrderLineNo);
    FILTERGROUP(0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    FILTERGROUP(0);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetFlushingFilter(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "SetupTimeOnFormat(PROCEDURE 19007490)".

    //procedure SetupTimeOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Consumption) OR
       ("Operation No." = '')
    THEN
      SetupTimeHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      "Setup TimeHideValue" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "RunTimeOnFormat(PROCEDURE 19059514)".

    //procedure RunTimeOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Consumption) OR
       ("Operation No." = '')
    THEN
      RunTimeHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      "Run TimeHideValue" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OutputQuantityOnFormat(PROCEDURE 19003029)".

    //procedure OutputQuantityOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Consumption THEN
      OutputQuantityHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Consumption THEN
      "Output QuantityHideValue" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "ScrapQuantityOnFormat(PROCEDURE 19017313)".

    //procedure ScrapQuantityOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Consumption THEN
      ScrapQuantityHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Consumption THEN
      "Scrap QuantityHideValue" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
