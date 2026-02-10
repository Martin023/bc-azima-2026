#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 52185710 "Property General Setup"
{
    PageType = Card;
    SourceTable = "General Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Landlord Dues G/L";rec."Landlord Dues G/L")
                {
                    ApplicationArea = Basic;
                }
                field("Commission Template";rec."Commission Template")
                {
                    ApplicationArea = Basic;
                }
                field("Commission Batch";rec."Commission Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Management Account";rec."Management Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Management Fee Account';
                }
                field("Prepayment Account";rec."Prepayment Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Property Nos.";rec."Property Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Lease Nos.";rec."Lease Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Code";rec."Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field("Water billing No.";rec."Water billing No.")
                {
                    ApplicationArea = Basic;
                }
                field("B/Hole W/B Nos.";rec."B/Hole W/B Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Bill Batch No.";rec."Bill Batch No.")
                {
                    ApplicationArea = Basic;
                }
                // field(NairobiInv;rec.NairobiInv)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(BHoleInv;rec.BHoleInv)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Landlord Nos.";rec."Landlord Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Nos.";rec."Tenant Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("VAT % for Rent";rec."VAT Rate %")
                {
                    ApplicationArea = Basic;
                }
                field("Deadline Notification"; Rec."Deadline Notification")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
    
}

