#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185643 pageextension52185643 extends Reconciliation 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Net Change in Jnl.")
        {
            ApplicationArea = Basic;
        }
        modify("Balance after Posting")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change in Jnl."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance after Posting"(Control 11)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetGenJnlLine(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "InsertGLAccNetChange(PROCEDURE 6)".

    //procedure InsertGLAccNetChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLAcc.CALCFIELDS("Balance at Date");
        INIT;
        "No." := GLAcc."No.";
        Name := GLAcc.Name;
        "Balance after Posting" := GLAcc."Balance at Date";
        OnBeforeGLAccNetChangeInsert(Rec);
        INSERT;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        INSERT;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ReturnGLAccountNetChange(PROCEDURE 25)".

}
