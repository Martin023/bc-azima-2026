#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187205 pageextension52187205 extends "Table Filter" 
{
    layout
    {
        modify("Field Number")
        {
            ApplicationArea = Basic;
        }
        modify("Field Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Field Filter")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""Field Number"(Control 4).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Field.SETRANGE(TableNo,"Table Number");
            Field.SETFILTER(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);
            FieldsLookup.SETTABLEVIEW(Field);
            FieldsLookup.LOOKUPMODE(TRUE);
            IF FieldsLookup.RUNMODAL = ACTION::LookupOK THEN BEGIN
            #6..9
              FillSourceRecord(Field);
              CurrPage.UPDATE(TRUE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            Field.SETRANGE(TableNo,"Table Number");
            #3..12
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Number"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Caption"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Filter"(Control 3)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetSourceTable(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "CreateTextTableFilter(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "CreateTextTableFilterWithoutTableName(PROCEDURE 17)".

}
