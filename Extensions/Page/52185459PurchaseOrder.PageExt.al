// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185459 pageextension52185459 extends "Purchase Order"
{





    layout
    {
       
        modify("Vendor Invoice No.")
        {
            ApplicationArea = Basic;
            ShowMandatory = false;
        }

      
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
            visible = true;
        }
       
        addafter(Control83)
        {
            field("Receiving No. Series"; Rec."Receiving No. Series")
            {
                ApplicationArea = Basic;
            }
        }
       
    }

    actions
    {
        modify("&Print")
        {
            trigger OnBeforeAction()
            var
                PurchaseHeader: Record "Purchase Header";
            begin
                // Apply filter to current record
                PurchaseHeader := Rec;
                CurrPage.SetSelectionFilter(PurchaseHeader);

                // Example: Custom logic before printing
                if PurchaseHeader.FindFirst() then begin
                    REPORT.RUN(Report::"Purchase Order", true, true, PurchaseHeader);
                end;
            end;
        }
    }

   



















    //     local procedure BuyfromVendorNoOnAfterValidate()
    //     begin
    //         if Rec.GetFilter(Rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
    //             if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
    //                 Rec.SetRange(Rec."Buy-from Vendor No.");
    //         CurrPage.Update;
    //     end;

    //     local procedure PurchaserCodeOnAfterValidate()
    //     begin
    //         CurrPage.PurchLines.Page.UpdateForm(true);
    //     end;

    //     local procedure PaytoVendorNoOnAfterValidate()
    //     begin
    //         CurrPage.Update;
    //     end;

    //     local procedure ShortcutDimension1CodeOnAfterV()
    //     begin
    //         CurrPage.Update;
    //     end;

    //     local procedure ShortcutDimension2CodeOnAfterV()
    //     begin
    //         CurrPage.Update;
    //     end;

    //     local procedure PricesIncludingVATOnAfterValid()
    //     begin
    //         CurrPage.Update;
    //     end;

    //     local procedure Prepayment37OnAfterValidate()
    //     begin
    //         CurrPage.Update;
    //     end;

    //     procedure LinesCommitted() Exists: Boolean
    //     var
    //         PurchLines: Record "Purchase Line";
    //     begin
    //         if BCSetup.Get() then begin
    //             if not BCSetup.Mandatory then begin
    //                 Exists := false;
    //                 exit;
    //             end;
    //         end else begin
    //             Exists := false;
    //             exit;
    //         end;
    //         if BCSetup.Get then begin
    //             Exists := false;
    //             PurchLines.Reset;
    //             PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
    //             PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
    //             PurchLines.SetRange(PurchLines.Committed, false);
    //             if PurchLines.Find('-') then
    //                 Exists := true;
    //         end else
    //             Exists := false;
    //     end;

    //     procedure SomeLinesCommitted() Exists: Boolean
    //     var
    //         PurchLines: Record "Purchase Line";
    //     begin
    //         if BCSetup.Get then begin
    //             Exists := false;
    //             PurchLines.Reset;
    //             PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
    //             PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
    //             PurchLines.SetRange(PurchLines.Committed, true);
    //             if PurchLines.Find('-') then
    //                 Exists := true;
    //         end else
    //             Exists := false;
    //     end;


}
