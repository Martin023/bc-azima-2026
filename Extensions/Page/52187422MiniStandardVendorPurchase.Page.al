#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 52187422 "Mini Standard Vendor Purchase"
{
    Caption = 'Recurring Purchase Lines';
    DataCaptionFields = "Vendor No.";
    PageType = List;
    SourceTable = "Standard Vendor Purchase Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Vendor No.";Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the vendor number of the vendor to which the standard purchase code is assigned.';
                    Visible = false;
                }
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies a standard purchase code from the Standard Purchase Code table.';

                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     StdPurchaseCode: Record "Standard Purchase Code";
                    // begin
                    //     // if Rec.Code <> '' then
                    //     //   StdPurchaseCode.Get(Rec.Code);

                    //     // if Page.RunModal(Page::"Mini Standard Purchase Codes",StdPurchaseCode) = Action::LookupOK then begin
                    //     //   Rec.Validate(Rec.Code,StdPurchaseCode.Code);
                    //     //   Text := Rec.Code;
                    //    // end;

                    //     //exit(true);
                    // end;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies a description of the standard purchase code. When you fill in the Code field, the program automatically copies the description from the Standard Purchase Code table.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Purchase")
            {
                Caption = '&Purchase';
                Image = Purchasing;
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Mini Std. Purchase Code Card";
                    RunPageLink = Code=field(Code);
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}
