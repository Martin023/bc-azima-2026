namespace ALProject.ALProject;

using Microsoft.Sales.History;
using Microsoft.Sales.Document;

pageextension 52185453 SalesLineSubform extends "Sales Invoice Subform"
{
    layout
    {
        addAfter(Description)
        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = basic;

            }

            field("Disposal Expiry"; Rec."Disposal Expiry")
            {
                ApplicationArea = BASIC;

            }
            field("Disposal Reason"; Rec."Disposal Reason")
            {
                ApplicationArea = basic;
            }
        }
        modify("VAT Bus. Posting Group")
        {
            visible = TRUE;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        moveafter("Line Amount"; "VAT Bus. Posting Group", "VAT Prod. Posting Group")
    }
}
