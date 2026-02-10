page 52186737 "ATM Inventory Card"
{
    Caption = 'ATM Inventory Card';
    // Editable = true;
    DeleteAllowed = false;
    // InsertAllowed = true;
    // ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    SourceTable = "ATM Inventory";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = true;
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Card Number"; Rec."Card Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Dispatch"; Rec."Date Of Dispatch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Appl. No"; rec."ATM Appl. No")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
        }

    }
    actions
    {
        area(processing)
        {
            action("Import ATM Cards")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import ATM Cards';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = XMLport "ATM Inventory Xml";
            }
            action("Charge Card Fee")
            {
                ApplicationArea = Basic, Suite;
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TrCharges: Record "Transaction Charges";
                    TrType: Record "Transaction Types";
                    Trch: Decimal;
                    AvAl: Decimal;
                    PeriodicActivities: Codeunit "Periodic Activities";
                begin
                    PeriodicActivities.PostATMApplicationCharges(Rec);
                end;
            }
            action("Already Charged ATM")
            {
                ApplicationArea = Basic, Suite;
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TrCharges: Record "Transaction Charges";
                    TrType: Record "Transaction Types";
                    Trch: Decimal;
                    AvAl: Decimal;
                    PeriodicActivities: Codeunit "Periodic Activities";
                begin
                    Message('Kindly note this option is only for charged cards');
                    rec.Status := Rec.Status::Pending;
                    rec.Modify;
                    Message('Status changed to Pending');
                end;
            }

        }
    }

    var
        Members: Record Members;
}


