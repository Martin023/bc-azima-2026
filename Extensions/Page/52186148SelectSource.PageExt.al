#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186148 pageextension52186148 extends "Select Source" 
{
    layout
    {

        //Unsupported feature: Property Modification (IndentationControls) on "Group(Control 2)".

        modify(Name)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Name(Control 3)".


            //Unsupported feature: Property Modification (Name) on "Name(Control 3)".

        }
        modify(Value)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Value(Control 4)".

    }

    //Unsupported feature: Code Modification on "SetStyle(PROCEDURE 1)".

    //procedure SetStyle();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF HasChildNodes THEN
          StyleText := 'Strong'
        ELSE
          StyleText := '';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF "Is Parent" OR "Has Attributes" THEN
        #2..4
        */
    //end;
}
