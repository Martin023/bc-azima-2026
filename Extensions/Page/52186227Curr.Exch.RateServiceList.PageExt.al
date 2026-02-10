#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186227 pageextension52186227 extends "Curr. Exch. Rate Service List" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Enabled)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Enabled(Control 7)".

    }
    actions
    {
        modify(Enable)
        {
            ApplicationArea = Basic;
        }
        modify(TestUpdate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Enable(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestUpdate(Action 11)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetupService;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ISEMPTY THEN
          CODEUNIT.RUN(CODEUNIT::"Set Up Curr Exch Rate Service");
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
