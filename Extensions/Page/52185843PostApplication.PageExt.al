#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185843 pageextension52185843 extends "Post Application" 
{
    layout
    {
        modify(DocNo)
        {
            ApplicationArea = Basic;
        }
        modify(PostingDate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DocNo(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostingDate(Control 7)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetValues(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetValues(PROCEDURE 2)".

}
