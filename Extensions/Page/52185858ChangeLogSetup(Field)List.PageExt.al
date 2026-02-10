#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185858 pageextension52185858 extends "Change Log Setup (Field) List"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Field Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Log Insertion")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Log Insertion"(Control 6)".

        }
        modify("Log Modification")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Log Modification"(Control 8)".

        }
        modify("Log Deletion")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Log Deletion"(Control 10)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Caption"(Control 4)".


        //Unsupported feature: Code Modification on ""Log Insertion"(Control 6).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT InsVisible THEN BEGIN
          LogInsertionVisible := FALSE;
          ERROR(CannotChangeColumnErr);
        END;
        UpdateRec;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT InsVisible THEN BEGIN
          "Log InsertionVisible" := FALSE;
        #3..5
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Log Insertion"(Control 6)".


        //Unsupported feature: Property Deletion (Enabled) on ""Log Insertion"(Control 6)".


        //Unsupported feature: Property Deletion (Editable) on ""Log Insertion"(Control 6)".



        //Unsupported feature: Code Modification on ""Log Modification"(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT ModVisible THEN BEGIN
          LogModificationVisible := FALSE;
          ERROR(CannotChangeColumnErr);
        END;
        UpdateRec;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT ModVisible THEN BEGIN
          "Log ModificationVisible" := FALSE;
        #3..5
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Log Modification"(Control 8)".


        //Unsupported feature: Property Deletion (Enabled) on ""Log Modification"(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on ""Log Modification"(Control 8)".



        //Unsupported feature: Code Modification on ""Log Deletion"(Control 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT DelVisible THEN BEGIN
          LogDeletionVisible := FALSE;
          ERROR(CannotChangeColumnErr);
        END;
        UpdateRec;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT DelVisible THEN BEGIN
          "Log DeletionVisible" := FALSE;
        #3..5
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Log Deletion"(Control 10)".


        //Unsupported feature: Property Deletion (Enabled) on ""Log Deletion"(Control 10)".


        //Unsupported feature: Property Deletion (Editable) on ""Log Deletion"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    var

        "Log InsertionVisible": Boolean;

        "Log ModificationVisible": Boolean;

        "Log DeletionVisible": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PageIsEditable := CurrPage.EDITABLE;
    GetRec;
    TransFromRec;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetRec;
    TransFromRec;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LogDeletionVisible := TRUE;
    LogModificationVisible := TRUE;
    LogInsertionVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Log DeletionVisible" := TRUE;
    "Log ModificationVisible" := TRUE;
    "Log InsertionVisible" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SelectColumn(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SelectColumn(PROCEDURE 1)".

    //procedure SelectColumn();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsVisible := NewInsVisible;
    ModVisible := NewModVisible;
    DelVisible := NewDelVisible;

    LogInsertionVisible := InsVisible;
    LogModificationVisible := ModVisible;
    LogDeletionVisible := DelVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    "Log InsertionVisible" := InsVisible;
    "Log ModificationVisible" := ModVisible;
    "Log DeletionVisible" := DelVisible;
    */
    //end;
}
