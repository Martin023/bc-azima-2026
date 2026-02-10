#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185823 pageextension52185823 extends "VAT Rate Change Log Entries" 
{
    layout
    {
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify("Table Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Record Identifier")
        {
            ApplicationArea = Basic;
        }
        modify("Old Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("New Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Old VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("New VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Converted)
        {
            ApplicationArea = Basic;
        }
        modify("Converted Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table ID"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table Caption"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Record Identifier"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Old Gen. Prod. Posting Group"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Gen. Prod. Posting Group"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Old VAT Prod. Posting Group"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New VAT Prod. Posting Group"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Converted(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Converted Date"(Control 13)".

    }
    actions
    {
        modify(Show)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "Show(Action 14).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF FORMAT("Record ID") = '' THEN
              EXIT;
            IF NOT RecRef.GET("Record ID") THEN
              ERROR(Text0002);

            CASE "Table ID" OF
              DATABASE::"Sales Header",
              DATABASE::"Purchase Header",
            #9..30
                  ServiceHeader.GET(ServiceLine."Document Type",ServiceLine."Document No.");
                  PageManagement.PageRunModal(ServiceHeader);
                END;
              ELSE BEGIN
                IsHandled := FALSE;
                OnAfterShow(Rec,IsHandled);
                IF NOT IsHandled THEN
                  MESSAGE(Text0001);
              END;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            #6..33
              ELSE
                MESSAGE(Text0001);
            END;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Show(Action 14)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Show(Action 14)".

    }
}
