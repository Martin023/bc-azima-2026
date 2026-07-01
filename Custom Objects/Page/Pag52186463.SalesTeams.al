namespace AzimaCBS.AzimaCBS;

page 52186490 "Sales Teams"
{
    ApplicationArea = All;
    Caption = 'Sales Card';
    PageType = Card;
    SourceTable = "Marketing Teams Header";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec."Payroll No.")
                {
                    ToolTip = 'Specifies the value of the Payroll No field.', Comment = '%';
                    Editable = NOT Rec.Created;
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                    Editable = false;
                }
                field(Phone; Rec.Phone)
                {
                    ToolTip = 'Specifies the value of the Phone field.', Comment = '%';
                    Editable = false;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.', Comment = '%';
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.', Comment = '%';
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
                field("Registered By"; Rec."Registered By")
                {
                    ToolTip = 'Specifies the value of the Registered By field.', Comment = '%';
                    Editable = false;
                }
                field(Retainer; rec.Retainer)
                {

                }
                field("Membership Target"; rec."Membership Target")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateSalesRep)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Rep';
                Image = Post;
                Enabled = NOT Rec.Created;
                ToolTip = 'Creates the sales representative and locks the record from further editing.';

                trigger OnAction()
                begin
                    Rec.Validate(Created, true);
                    Rec.Modify(true);
                    Message('Sales rep added successfully.');
                end;
            }
        }

    }
}