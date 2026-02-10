page 52186223 "Active Properties-Edit"
{
    Editable = true;
    PageType = Card;
    SourceTable = "Property Details";
    SourceTableView = WHERE("Agreement Status" = CONST(Active));

    layout
    {
        area(content)
        {
            group("Property Information")
            {
                Caption = 'Property Information';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("L.R. No."; Rec."L.R. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord No."; Rec."Landlord No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Property Name';
                    ApplicationArea = Basic, Suite;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Street; Rec.Street)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Property Type"; Rec."Property Type")
                {
                    LookupPageID = "Property Category";
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if rec."Property Type" = 'RESIDENTIAL' then
                            "Total Area sq ftVisible" := false;
                    end;
                }
                field("Property Code"; Rec."Property Code")
                {
                    Caption = 'Department Code';
                    ApplicationArea = Basic, Suite;
                }
                field("Department name"; Rec."Department name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Area sq ft"; Rec."Total Area sq ft")
                {
                    Visible = "Total Area sq ftVisible";
                    ApplicationArea = Basic, Suite;
                }
                field("total Units"; Rec."total Units")
                {
                    Caption = 'Total Units';
                    ApplicationArea = Basic, Suite;
                }
                field("Property Manager[Staff]"; Rec."Property Manager[Staff]")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1102755008; Floor)
            {
                SubPageLink = "No." = FIELD("No.");
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("File Ref No."; Rec."File Ref No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Commence Date"; Rec."Commence Date")
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
                }
                field("Agreement Status"; Rec."Agreement Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Management Fees")
            {
                Caption = 'Management Fees';
                field("Commission Rate"; Rec."Commission Rate")
                {
                    Caption = 'Management Fee Rate';
                    ApplicationArea = Basic, Suite;
                }
                field("Commision Flat Amount"; Rec."Commision Flat Amount")
                {
                    Caption = 'Management Fee Amount';
                    ApplicationArea = Basic, Suite;
                }
                field("Letting Fee Rate(%)"; Rec."Letting Fee Rate(%)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Letting Flat Amount"; Rec."Letting Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reletting Fee Rate(%)"; Rec."Reletting Fee Rate(%)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reletting Flat Amount"; Rec."Reletting Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Property)
            {
                Caption = 'Property';
                Visible = true;
                // action(Caretakers)
                // {
                //     Caption = 'Caretakers';
                //     RunObject = Page "Caretaker List";
                //    // RunPageLink = "Property No" = FIELD("No.");
                // }
                // action(Charges)
                // {
                //     Caption = 'Charges';
                //     RunObject = Page "Property Charges";
                //     RunPageLink = "Property Code" = FIELD("No.");
                // }
            }
        }
    }

    trigger OnInit()
    begin
        "Total Area sq ftVisible" := true;
    end;

    var

        "Total Area sq ftVisible": Boolean;
}

