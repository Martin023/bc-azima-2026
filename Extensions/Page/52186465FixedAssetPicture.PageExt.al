#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186465 pageextension52186465 extends "Fixed Asset Picture"
{

    //Unsupported feature: Property Modification (PageType) on ""Fixed Asset Picture"(Page 5620)".

    layout
    {
        modify(Image)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Image(Control 1)".


            //Unsupported feature: Property Modification (Name) on "Image(Control 1)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Image(Control 1)".


        //Unsupported feature: Property Deletion (ShowCaption) on "Image(Control 1)".

    }
    actions
    {
        // modify(ActionContainer2)
        // {
        //     Visible = false;
        // }
        modify(TakePicture)
        {
            Visible = false;
        }
        modify(ImportPicture)
        {
            Visible = false;
        }
        modify(ExportFile)
        {
            Visible = false;
        }
        modify(DeletePicture)
        {
            Visible = false;
        }
    }
}
