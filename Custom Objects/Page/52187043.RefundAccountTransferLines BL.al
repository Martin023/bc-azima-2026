page 52187043 "Bulk Account Transfers BL"
{

    Caption = 'Refund Account Transfers';
    PageType = ListPart;
    SourceTable = "refund,Account Transfer lines";
    //Editable = false;
    //InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.Name := '';
                        Rec."Source Account" := '';
                        Rec."Source Loan No." := '';
                        Rec.Amount := 0;
                        Rec."Destination Account" := '';
                        Rec."Loan No." := '';
                    end;

                }

                field("Source Account"; Rec."Source Account")
                {
                    ToolTip = 'Specifies the value of the Debit Account No. field.';
                    TableRelation = "Savings Accounts"."No." WHERE("Member No." = field("Member No."), "Product Type" = filter('002|011'));
                }
                field("Destination Account"; Rec."Destination Account")
                {
                    ToolTip = 'Specifies the value of the Credit Account.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of Loan No.';
                }

                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Source Name"; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    Caption = 'Source Account Name';
                }

                field("Destination Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Destination Account Name field.';
                    Visible = true;
                    Caption = 'Destination Account Name';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of Description.';
                }




            }
        }
    }
}
