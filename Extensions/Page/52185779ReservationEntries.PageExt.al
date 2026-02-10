#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185779 pageextension52185779 extends "Reservation Entries" 
{
    layout
    {
        modify("Reservation Status")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("ReservEngineMgt.CreateForText(Rec)")
        {
            ApplicationArea = Basic;
        }
        modify(ReservedFrom)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Source Type")
        {
            ApplicationArea = Basic;
        }
        modify("Source Subtype")
        {
            ApplicationArea = Basic;
        }
        modify("Source ID")
        {
            ApplicationArea = Basic;
        }
        modify("Source Batch Name")
        {
            ApplicationArea = Basic;
        }
        modify("Source Ref. No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Creation Date")
        {
            ApplicationArea = Basic;
        }
        modify("Transferred from Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Status"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity (Base)"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ReservEngineMgt.CreateForText(Rec)"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedFrom(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Subtype"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source ID"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Batch Name"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Ref. No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transferred from Entry No."(Control 36)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(CancelReservation)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CancelReservation(Action 64)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "LookupReserved(PROCEDURE 1)".


    //Unsupported feature: Property Insertion (Local) on "LookupReserved(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "LookupReserved(PROCEDURE 1)".

    //procedure LookupReserved();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH ReservEntry DO
          CASE "Source Type" OF
            DATABASE::"Sales Line":
        #4..100
                PAGE.RUNMODAL(0,AssemblyLine);
              END;
          END;

        OnAfterLookupReserved(ReservEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..103
        */
    //end;

    local procedure QuantityBaseOnAfterValidate()
    begin
        CurrPage.Update;
    end;
}
