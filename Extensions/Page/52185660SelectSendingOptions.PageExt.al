#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185660 pageextension52185660 extends "Select Sending Options"
{
    layout
    {
        modify(Printer)
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Visible) on "Control12(Control 12)".

        modify("E-Mail Attachment")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Visible) on "Control14(Control 14)".

        modify("E-Mail Format")
        {
            ApplicationArea = Basic;
        }
        modify(Disk)
        {
            ApplicationArea = Basic;
        }
        modify("Disk Format")
        {
            ApplicationArea = Basic;
        }
        modify("Electronic Document")
        {
            ApplicationArea = Basic;
        }
        modify("Electronic Format")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Printer(Control 3)".


        //Unsupported feature: Property Deletion (Visible) on "Printer(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail Attachment"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail Format"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Disk(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Disk Format"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Electronic Document"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Electronic Format"(Control 6)".

        addafter(Control2)
        {
            group(Control8)
            {
                //Visible = "One Related Party Selected";
                field(SetDefualt; SetDefaultLbl)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;

                    trigger OnDrillDown()
                    var
                        DocumentSendingProfile: Record "Document Sending Profile";
                    begin
                        if DocumentSendingProfile.Get(DefaultCode) then
                            Rec.Copy(DocumentSendingProfile);
                    end;
                }
            }
        }
    }

    var
        SetDefaultLbl: label 'Use the customer''s default Sending Profile', Comment = 'Used as a label for link on the page. There is no terminating period or other characters.';
        DefaultCode: Code[20];


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SendElectronicallyVisible := NOT ElectronicDocumentFormat.ISEMPTY AND "One Related Party Selected";

    IF DocumentSendingProfile.GET(Code) THEN
      COPY(DocumentSendingProfile);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SendElectronicallyVisible := NOT ElectronicDocumentFormat.ISEMPTY AND "One Related Party Selected";
    IF DefaultCode = '' THEN
      DefaultCode := Code;
    */
    //end;
}
