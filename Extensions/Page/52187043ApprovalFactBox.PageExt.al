#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187043 pageextension52187043 extends "Approval FactBox" 
{
    layout
    {
        modify(DocumentHeading)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Approver ID")
        {
            ApplicationArea = Basic;
        }
        modify("Date-Time Sent for Approval")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DocumentHeading(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approver ID"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date-Time Sent for Approval"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 2)".

    }

    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DocumentHeading := '';
        EXIT(FINDLAST);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DocumentHeading := '';

        EXIT(FIND(Which));
        */
    //end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //var
        //ApprovalEntry: Record "Approval Entry";
    //begin
        /*
        ApprovalEntry.COPY(Rec);
        IF ApprovalEntry.FINDFIRST THEN
          SETFILTER("Approver ID",'<>%1',ApprovalEntry."Sender ID");
        */
    //end;
}
