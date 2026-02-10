#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186490 pageextension52186490 extends "Insurance Journal" 
{
    Caption = 'Insurance Journal';
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
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Insurance No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA Description")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Index Entry")
        {
            ApplicationArea = Basic;
        }
        modify(InsuranceDescription)
        {
            ApplicationArea = Basic;
        }
        modify(FADescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Description"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Index Entry"(Control 20)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "InsuranceDescription(Control 3)".


        //Unsupported feature: Property Deletion (ShowCaption) on "InsuranceDescription(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FADescription(Control 16)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Amount)
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
        }
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Coverage Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify("P&ost")
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Coverage Ledger E&ntries"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 39)".

    }


    //Unsupported feature: Property Modification (Length) on "InsuranceDescription(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //InsuranceDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //InsuranceDescription : 30;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "FADescription(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //FADescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FADescription : 30;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetDimensionsVisibility;

        IF IsOpenedFromBatch THEN BEGIN
          CurrentJnlBatchName := "Journal Batch Name";
          InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
        #6..8
        IF NOT JnlSelected THEN
          ERROR('');
        InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
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

}
