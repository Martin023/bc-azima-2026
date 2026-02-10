#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186475 pageextension52186475 extends "Recurring Fixed Asset Journal" 
{
    Caption = 'Recurring Fixed Asset Journal';
    layout
    {
        modify(CurrentJnlBatchName)
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Method")
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Frequency")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Date")
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
        modify("FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Type")
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
        modify("Depr. until FA Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Maintenance Code")
        {
            ApplicationArea = Basic;
        }
        modify("Insurance No.")
        {
            ApplicationArea = Basic;
        }
        modify("Budgeted FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("Duplicate in Depreciation Book")
        {
            ApplicationArea = Basic;
        }
        modify("Use Duplication List")
        {
            ApplicationArea = Basic;
        }
        modify("FA Reclassification Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Index Entry")
        {
            ApplicationArea = Basic;
        }
        modify("FA Error Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
        }
        modify(FADescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Method"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Frequency"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Date"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA No."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Type"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 15)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. until FA Posting Date"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance No."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted FA No."(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duplicate in Depreciation Book"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Duplication List"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Reclassification Entry"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Index Entry"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Error Entry No."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 58)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "FADescription(Control 40)".


        //Unsupported feature: Property Deletion (ShowCaption) on "FADescription(Control 40)".


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
        modify("Ledger E&ntries")
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
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 51)".

    }


    //Unsupported feature: Property Modification (Length) on "FADescription(Variable 1003)".

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
          FAJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
        #6..8
        IF NOT JnlSelected THEN
          ERROR('');
        FAJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
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
