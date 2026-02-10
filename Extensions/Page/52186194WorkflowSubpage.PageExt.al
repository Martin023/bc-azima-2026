#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186194 pageextension52186194 extends "Workflow Subpage" 
{
    layout
    {
        modify(Indent)
        {
            ApplicationArea = Basic;
        }
        modify("Event Description")
        {
            ApplicationArea = Basic;
        }
        modify(Condition)
        {
            ApplicationArea = Basic;
        }
        modify("Entry Point")
        {
            ApplicationArea = Basic;
        }
        modify("Response Description")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Indent(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Event Description"(Control 3)".


        //Unsupported feature: Code Modification on "Condition(Control 4).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF CurrPage.EDITABLE THEN BEGIN
              OpenEventConditions;
              CurrPage.UPDATE(TRUE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            OpenEventConditions;
            CurrPage.UPDATE(TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Condition(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Point"(Control 6)".



        //Unsupported feature: Code Modification on ""Response Description"(Control 5).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF CurrPage.EDITABLE THEN BEGIN
              OpenEventResponses;
              CurrPage.UPDATE(FALSE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            OpenEventResponses;
            CurrPage.UPDATE(FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Response Description"(Control 5)".

    }
    actions
    {
        modify(DecreaseIndent)
        {
            ApplicationArea = Basic;
        }
        modify(IncreaseIndent)
        {
            ApplicationArea = Basic;
        }
        modify(DeleteEventConditions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DecreaseIndent(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncreaseIndent(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DeleteEventConditions(Action 8)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "RefreshBuffer(PROCEDURE 2)".

}
