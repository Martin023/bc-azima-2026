#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185498 pageextension52185498 extends "G/L Posting Preview" 
{
    layout
    {
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify("Table Name")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Records")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table ID"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table Name"(Control 17)".


        //Unsupported feature: Code Modification on ""No. of Records"(Control 19).OnDrillDown".

        //trigger  of Records"(Control 19)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PostingPreviewEventHandler.ShowEntries("Table ID");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GenJnlPostPreview.ShowEntries("Table ID");
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Records"(Control 19)".

    }
    actions
    {
        modify(Show)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (RunPageMode) on "Show(Action 21)".

        }


        //Unsupported feature: Code Modification on "Show(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PostingPreviewEventHandler.ShowEntries("Table ID");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            GenJnlPostPreview.ShowEntries("Table ID");
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Show(Action 21)".

    }

    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        PostingPreviewEventHandler := NewPostingPreviewEventHandler;
        IF TempDocumentEntry.FINDSET THEN
          REPEAT
            Rec := TempDocumentEntry;
            INSERT;
          UNTIL TempDocumentEntry.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #2..6
        */
    //end;

    //Unsupported feature: Deletion (ParameterCollection) on "Set(PROCEDURE 1).NewPostingPreviewEventHandler(Parameter 1001)".

}
