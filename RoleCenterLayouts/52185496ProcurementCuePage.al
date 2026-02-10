page 52185496 "Procurement Cue Page"
{
    Caption = 'Procurement Cue Page';
    PageType = CardPart;
    SourceTable = "Procurement Cue Table";

    layout
    {
        area(content)
        {

            cuegroup("Purchases")
            {
                ShowCaption = false;
                CuegroupLayout = Wide;

                field("Purchase Invoices"; Rec."Purchase Invoices")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Invoices field.';
                    DrillDownPageId = "Purchase Invoices";
                }
                field("Purchase Quotes"; Rec."Purchase Quotes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Quotes field.';
                    DrillDownPageId = "Purchase Quotes";
                }
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Orders field.';
                    DrillDownPageId = "Purchase Orders";
                }
                field("Purchase Credit Memos"; Rec."Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Credit Memos field.';
                    DrillDownPageId = "Purchase Credit Memos";
                }
            }
            cuegroup("Sales")
            {
                ShowCaption = True;
                field("Sales Invoice"; Rec."Sales Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Invoice field.';
                    DrillDownPageId = "Sales List";
                }
            }
            cuegroup("Orders")
            {
                ShowCaption = true;
                field("Transfer Orders"; Rec."Transfer Orders")
                {
                    Caption = 'Released Transfer Orders';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer Orders.';
                    DrillDownPageId = "Transfer Orders";
                }


            }
            cuegroup("Requisitions")
            {
                ShowCaption = true;
                field("HR Employee Requisition"; Rec."Employee Requisition")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the hr Requisitions.';
                }
                field("Store Requisitions"; rec."Store Requisitions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RFQ field.';
                }
            }

            cuegroup("Stock")
            {
                ShowCaption = true;
                field("Nonstcok Items"; Rec."Nonstock Items")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nonstcok Items field.';
                }
                field("Stock Keeping Units"; Rec."Stock Keeping Units")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stock Keeping Units field.';
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Cues SetUp")
            {
                ApplicationArea = Basic;
                Caption = 'Set up Cues';
                Image = Setup;
                ToolTip = 'Set up Cues related to the role';
                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecoredref: RecordRef;
                begin
                    CueRecoredref.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecoredref.Number);
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}

