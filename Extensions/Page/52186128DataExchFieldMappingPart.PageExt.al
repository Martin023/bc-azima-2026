#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186128 pageextension52186128 extends "Data Exch Field Mapping Part" 
{
    layout
    {
        modify("Column No.")
        {
            ApplicationArea = Basic;
        }
        modify(ColumnCaptionText)
        {
            ApplicationArea = Basic;
        }
        modify("Field ID")
        {
            ApplicationArea = Basic;
        }
        modify(FieldCaptionText)
        {
            ApplicationArea = Basic;
        }
        modify(Optional)
        {
            ApplicationArea = Basic;
        }
        modify(Multiplier)
        {
            ApplicationArea = Basic;
        }
        modify("Transformation Rule")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Column No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnCaptionText(Control 9)".


        //Unsupported feature: Code Modification on ""Field ID"(Control 4).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Field.SETRANGE(TableNo,"Table ID");
            Field.SETFILTER(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);
            FieldsLookup.SETTABLEVIEW(Field);
            FieldsLookup.LOOKUPMODE(TRUE);

            #6..10
              FillSourceRecord(Field);
              FieldCaptionText := GetFieldCaption;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            Field.SETRANGE(TableNo,"Table ID");
            #3..13
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Field ID"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FieldCaptionText(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Optional(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transformation Rule"(Control 7)".

        modify("Overwrite Value")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
    }
}
