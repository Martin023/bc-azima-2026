#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186142 pageextension52186142 extends "Text-to-Account Mapping" 
{
    layout
    {
        modify("Mapping Text")
        {
            ApplicationArea = Basic;
        }
        modify("Debit Acc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Acc. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Source No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Mapping Text"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Acc. No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Acc. No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Source Type"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Source No."(Control 7)".

    }

    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(CheckEntriesAreConsistent);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF CloseAction <> ACTION::OK THEN
          EXIT(TRUE);

        CheckEntriesAreConsistent;
        */
    //end;
}
