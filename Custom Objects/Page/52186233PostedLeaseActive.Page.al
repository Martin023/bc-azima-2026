page 52186233 "Posted Lease-Active"
{
    Editable = false;
    PageType = Card;
    SourceTable = Lease;
    SourceTableView = WHERE(Blocked = CONST(false),
                            Commenced = CONST(true));

    layout
    {
        area(content)
        {
            group(Genera)
            {
                Caption = 'Genera';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("L.R. No."; Rec."L.R. No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Floor No."; Rec."Floor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Floor Name"; Rec."Floor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Type Description"; Rec."Unit Type Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Sub Type"; Rec."Unit Sub Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Sub Type Description"; Rec."Unit Sub Type Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Landlord No."; Rec."Landlord No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Tenant No."; Rec."Tenant No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tenant Name"; Rec."Tenant Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control1102755026; "Lease Line")
            {
                SubPageLink = "Lease No." = FIELD("No.");
                ApplicationArea = Basic, Suite;
            }
            group(Billing)
            {
                Caption = 'Billing';
                field("Lease Commence Date"; Rec."Lease Commence Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Duration Type"; Rec."Duration Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Duration Value"; Rec."Duration Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Billing Frequency"; Rec."Billing Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Billing Frequency Value"; Rec."Billing Frequency Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Bill Date"; Rec."Last Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Next Bill Date"; Rec."Next Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("Letter Of Offer"; Rec."Letter Of Offer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lease Agreement Ref. No."; Rec."Lease Agreement Ref. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Commenced; Rec.Commenced)
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
            action("Print Preview")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Preview';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Lease.Reset;
                    Lease.SetRange(Lease."No.", Rec."No.");
                    //if Lease.Find('-') then
                    //REPORT.Run(52186035, true, true, Lease)
                end;
            }
        }
    }

    var
        Lease: Record Lease;
}

