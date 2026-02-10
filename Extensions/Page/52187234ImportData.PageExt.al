#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187234 pageextension52187234 extends "Import Data" 
{
    Caption = 'Import Data';
    InstructionalText = '';
    layout
    {
        modify(FileName)
        {
            ApplicationArea = Basic;
        }
        modify(TenantId)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(ExportDate)
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
        modify(Selected)
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "FileName(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TenantId(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExportDate(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeAllCompanies(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeGlobalData(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeApplicationData(Control 4)".


        //Unsupported feature: Property Deletion (Visible) on "IncludeApplicationData(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Selected(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 9)".

    }

    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OriginalTenantId := '';
        ContainsApplication := FALSE;
        ContainsApplicationData := FALSE;
        ContainsGlobalData := FALSE;
        IncludeApplicationDataVisible := NOT PermissionManager.SoftwareAsAService;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        */
    //end;

    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (ApplicationArea).

}
