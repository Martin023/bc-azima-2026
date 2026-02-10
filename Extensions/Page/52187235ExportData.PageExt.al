#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187235 pageextension52187235 extends "Export Data" 
{
    Caption = 'Export Data';
    layout
    {
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(IncludeAllCompanies)
        {
            ApplicationArea = Basic;
        }
        modify(IncludeGlobalData)
        {
            ApplicationArea = Basic;
        }
        modify(IncludeApplicationData)
        {
            ApplicationArea = Basic;
        }
        modify(IncludeApplication)
        {
            ApplicationArea = Basic;
        }
        modify(Selected)
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeAllCompanies(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeGlobalData(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeApplicationData(Control 4)".


        //Unsupported feature: Property Deletion (Visible) on "IncludeApplicationData(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeApplication(Control 5)".


        //Unsupported feature: Property Deletion (Visible) on "IncludeApplication(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Selected(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 9)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IncludeApplication := FALSE;
        IncludeApplicationData := FALSE;
        IncludeGlobalData := TRUE;
        IncludeAllCompanies := TRUE;

        IncludeApplicationVisible := NOT PermissionManager.SoftwareAsAService;
        IncludeApplicationDataVisible := IncludeApplicationVisible;

        IF Company.FINDSET THEN
          REPEAT
            Rec := Company;
            INSERT;
          UNTIL Company.NEXT = 0;

        MarkAll;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        #9..15
        */
    //end;

    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (ApplicationArea).

}
