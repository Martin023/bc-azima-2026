#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185830 pageextension52185830 extends "Dimension Value List" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Dimension Value Type")
        {
            ApplicationArea = Basic;
        }
        modify(Totaling)
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify("Consolidation Code")
        {
            ApplicationArea = Basic;
        }
  

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Value Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Totaling(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consolidation Code"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Blocked)
        {
            field("Global Dimension No.";Rec."Global Dimension No.")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSelection(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "GetFormCaption(PROCEDURE 1)".

    //procedure GetFormCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GETFILTER("Dimension Code") <> '' THEN
          EXIT(GETFILTER("Dimension Code"));

        IF GETFILTER("Global Dimension No.") = '1' THEN
          EXIT(GLSetup."Global Dimension 1 Code");

        IF GETFILTER("Global Dimension No.") = '2' THEN
          EXIT(GLSetup."Global Dimension 2 Code");

        IF GETFILTER("Global Dimension No.") = '3' THEN
          EXIT(GLSetup."Shortcut Dimension 3 Code");

        IF GETFILTER("Global Dimension No.") = '4' THEN
          EXIT(GLSetup."Shortcut Dimension 4 Code");

        IF GETFILTER("Global Dimension No.") = '5' THEN
          EXIT(GLSetup."Shortcut Dimension 5 Code");

        IF GETFILTER("Global Dimension No.") = '6' THEN
          EXIT(GLSetup."Shortcut Dimension 6 Code");

        IF GETFILTER("Global Dimension No.") = '7' THEN
          EXIT(GLSetup."Shortcut Dimension 7 Code");

        IF GETFILTER("Global Dimension No.") = '8' THEN
          EXIT(GLSetup."Shortcut Dimension 8 Code");

        EXIT(STRSUBSTNO(Text000,"Global Dimension No."));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        EXIT(STRSUBSTNO(Text000,"Global Dimension No."));
        */
    //end;
}
