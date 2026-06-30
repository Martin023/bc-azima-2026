namespace AZIMA.AZIMA;

page 52185584 "Purchase Quote Vendors"
{
    Caption = 'Purchase Quote Vendors';
    PageType = ListPart;
    SourceTable = "Purchase Quote Vendor";
    ApplicationArea = All;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        Vend: Record Microsoft.Purchases.Vendor.Vendor;
                    begin
                        if Vend.Get(Rec."Vendor No.") then
                            Rec."Vendor Name" := Vend.Name
                        else
                            Rec."Vendor Name" := '';
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}

