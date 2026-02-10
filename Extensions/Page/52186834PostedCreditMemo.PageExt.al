PageExtension 52187236 pageextension52187236 extends "Posted Sales Credit Memo"
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Sales Credit Memos"(Page 9302)".

    layout
    {
        addafter("No. Printed")
        {
            field("Refund Type"; Rec."Refund Type")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            field("Waiver Start Date"; Rec."Waiver Start Date")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            field("Waiver End Date"; Rec."Waiver End Date")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
        }
    }
}