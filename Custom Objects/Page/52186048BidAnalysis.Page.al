page 52186048 "Bid Analysis"
{
    PageType = Document;
    SourceTable = "Purchase Quote Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                //here
                // field(ItemNoFilter; Rec.ItemNoFilter)
                // {
                //     Caption = 'Item No.';

                //     trigger OnLookup(var Text: Text): Boolean
                //     var
                //         ItemList: Page "Item List";
                //     begin
                //         ItemList.LookupMode := true;
                //         if ItemList.RunModal = ACTION::LookupOK then
                //             Text := ItemList.GetSelectionFilter
                //         else
                //             exit(false);

                //         exit(true);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         //ItemNoFilterOnAfterValidate;
                //     end;
                // }
            }
            part(Control1102755004; "Bid Analysis SubForm")
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Vendor Quotations")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Get Vendor Quotations';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    InsertBidAnalysisLines;
                end;
            }
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
        ItemNoFilter: Text[250];
        RFQNoFilter: Text[250];
        InsertCount: Integer;

    //[Scope('OnPrem')]
    procedure InsertBidAnalysisLines()
    var
        BidAnalysisLines: Record "Bid Analysis";
    begin
        //insert the quotes from vendors
        //IF RFQNoFilter = '' THEN ERROR('Specify the RFQ No.');

        PurchHeader.SetRange(PurchHeader."No.", Rec."No.");
        PurchHeader.FindSet;
        repeat
            PurchLines.Reset;
            PurchLines.SetRange("Document No.", PurchHeader."No.");
            if PurchLines.FindSet then
                repeat
                    Rec.Init;
                    BidAnalysisLines."RFQ No." := PurchHeader."No.";
                    BidAnalysisLines."RFQ Line No." := PurchLines."Line No.";
                    BidAnalysisLines."Quote No." := PurchLines."Document No.";
                    BidAnalysisLines."Vendor No." := PurchLines."Buy-from Vendor No.";
                    BidAnalysisLines."Item No." := PurchLines."No.";
                    BidAnalysisLines.Description := PurchLines.Description;
                    BidAnalysisLines.Quantity := PurchLines.Quantity;
                    BidAnalysisLines."Unit Of Measure" := PurchLines."Unit of Measure";
                    BidAnalysisLines.Amount := PurchLines."Direct Unit Cost";
                    BidAnalysisLines."Line Amount" := BidAnalysisLines.Quantity * BidAnalysisLines.Amount;
                    BidAnalysisLines.Insert(true);
                    InsertCount := +1;
                until PurchLines.Next = 0;
        until PurchHeader.Next = 0;
    end;
}

