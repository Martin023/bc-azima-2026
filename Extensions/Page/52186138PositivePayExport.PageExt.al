#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186138 pageextension52186138 extends "Positive Pay Export" 
{
    layout
    {
        modify(LastUploadDateEntered)
        {
            ApplicationArea = Basic;
        }
        modify(LastUploadTime)
        {
            ApplicationArea = Basic;
        }
        modify(CutoffUploadDate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "LastUploadDateEntered(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastUploadTime(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CutoffUploadDate(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PosPayExportDetail(Control 6)".

    }
    actions
    {
        modify(Export)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 8)".

    }
}
