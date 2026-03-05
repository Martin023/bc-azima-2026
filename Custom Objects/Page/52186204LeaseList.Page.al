page 52186204 "Lease-List"
{
    CardPageID = Lease;
    DeleteAllowed = false;
    Editable = false;
    PageType = ListPart;
    SourceTable = Lease;
    //SourceTableView = WHERE(Commenced = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = All;
    
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Tenant No."; Rec."Tenant No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Tenant Name"; Rec."Tenant Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease Status"; Rec."Lease Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Next Bill Date"; Rec."Next Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Bill Date"; Rec."Last Bill Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Area square ft"; Rec."Area square ft")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Amount Excl. VAT"; Rec."Total Amount Excl. VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Blocked; Rec.Blocked)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                    Editable = false;
                }
                field("Floor Name"; Rec."Floor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                // field("Unit Sub Type"; Rec."Unit Sub Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("Unit Sub Type Description"; Rec."Unit Sub Type Description")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
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
                field("Letter Of Offer"; Rec."Letter Of Offer")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease Agreement Ref. No."; Rec."Lease Agreement Ref. No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease Commence Date"; Rec."Lease Commence Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Billing Frequency"; Rec."Billing Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Billing Frequency Value"; Rec."Billing Frequency Value")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Duration Type"; Rec."Duration Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Duration Value"; Rec."Duration Value")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Terminated;Rec.Terminated)
                {
                    ApplicationArea = Basic, Suite;  
                }
                field("Lease TAT"; Rec."Lease TAT")
                {
                    Caption = 'Lease TAT(Days)';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

}

