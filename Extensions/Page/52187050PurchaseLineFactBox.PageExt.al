#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187050 pageextension52187050 extends "Purchase Line FactBox"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Availability)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (DecimalPlaces) on "Availability(Control 3)".


            //Unsupported feature: Property Modification (SourceExpr) on "Availability(Control 3)".

        }
        modify(PurchasePrices)
        {

            //Unsupported feature: Property Modification (Name) on "PurchasePrices(Control 5)".

            ApplicationArea = Basic;
        }
        modify(PurchaseLineDiscounts)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseLineDiscounts(Control 11)".

            ApplicationArea = Basic;
        }
        // modify(Attachments)
        // {

        //     //Unsupported feature: Property Modification (ControlType) on "Attachments(Control 1)".

        //     Caption = 'Budgeted Amount';

        //     //Unsupported feature: Property Modification (Name) on "Attachments(Control 1)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on "Attachments(Control 1)".

        //     ApplicationArea = Basic;
        // }
        // modify("Attached Doc Count")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Attached Doc Count"(Control 2)".

        //     Caption = 'Committed Amount';
        //     ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Attached Doc Count"(Control 2)".


            //Unsupported feature: Property Modification (Name) on ""Attached Doc Count"(Control 2)".

        //}

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Availability(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchasePrices(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseLineDiscounts(Control 11)".


        //Unsupported feature: Property Deletion (GroupType) on "Attachments(Control 1)".

        // modify("Attached Doc Count")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""Attached Doc Count"(Control 2)".

        addafter(Attachments)
        {
            field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,1))"; StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 1)))
            {
                ApplicationArea = Basic;
                Caption = 'Actual Amounts';
            }
            field("STRSUBSTNO('%1',BudgetaryControl.PaneMgt(Rec,0)-BudgetaryControl.PaneMgt(Rec,2)-BudgetaryControl.PaneMgt(Rec,1))"; StrSubstNo('%1', BudgetaryControl.PaneMgt(Rec, 0) - BudgetaryControl.PaneMgt(Rec, 2) - BudgetaryControl.PaneMgt(Rec, 1)))
            {
                ApplicationArea = Basic;
                Caption = 'Balance';
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = Basic;
                Caption = 'Line Amount';
            }
        }
    }

    var
        BudgetaryControl: Codeunit 52185483;
}
