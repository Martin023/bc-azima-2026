#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187219 pageextension52187219 extends "Control Add-ins"
{
    layout
    {
        modify("Add-in Name")
        {
            ApplicationArea = Basic;
        }
        // modify("Public Key Token")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Version)
        {
            ApplicationArea = Basic;
        }
        modify(Category)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Resource.HASVALUE")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Resource.HASVALUE"(Control 7)".


            //Unsupported feature: Property Modification (Name) on ""Resource.HASVALUE"(Control 7)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Add-in Name"(Control 3)".

        modify("Public Key Token")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Public Key Token"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Version(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Category(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Resource.HASVALUE"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource.HASVALUE"(Control 7)".

    }
    actions
    {
        modify(Import)
        {
            ApplicationArea = Basic;
        }
        modify(Export)
        {
            ApplicationArea = Basic;
        }
        modify(Clear)
        {

            //Unsupported feature: Property Modification (Name) on "Clear(Action 12)".

            Caption = 'Remove';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Import(Action 9)".


        //Unsupported feature: Code Modification on "Export(Action 10).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT Resource.HASVALUE THEN BEGIN
          MESSAGE(NoResourceMsg);
          EXIT;
        END;

        CALCFIELDS(Resource);
        TempBlob.Blob := Resource;
        FileManagement.BLOBExport(TempBlob,"Add-in Name" + '.zip',TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        TempBlob.Blob := Resource;
        FileManagement.BLOBExport(TempBlob,"Add-in Name" + '.zip',TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Clear(Action 12)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
