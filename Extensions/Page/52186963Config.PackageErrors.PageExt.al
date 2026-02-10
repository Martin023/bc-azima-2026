#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186963 pageextension52186963 extends "Config. Package Errors" 
{

    //Unsupported feature: Property Modification (DataCaptionExpr) on ""Config. Package Errors"(Page 8616)".

    layout
    {
        modify("Error Text")
        {
            ApplicationArea = Basic;
        }
        modify("Field Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Field Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Error Text"(Control 4)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Field Caption"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Caption"(Control 6)".


        //Unsupported feature: Property Deletion (DrillDown) on ""Field Name"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Name"(Control 2)".

        modify("Table ID")
        {
            Visible = false;
        }
        modify("Table Caption")
        {
            Visible = false;
        }
        modify(RecordIDValue)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    local procedure FormCaption(): Text[1024]
    var
        ConfigPackageTable: Record "Config. Package Table";
    begin
        ConfigPackageTable.SetRange("Package Code",Rec."Package Code");
        ConfigPackageTable.SetRange("Table ID",Rec."Table ID");
        if ConfigPackageTable.FindFirst then
          ConfigPackageTable.CalcFields("Table Caption");

        exit(ConfigPackageTable."Table Caption");
    end;
}
