page 52186426 "Collateral Collection - List"
{
    CardPageID = "Collateral Collection Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Securities Collection Register";
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;
    Caption = 'Collateral Discharge';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                Field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        // area(factboxes)
        // {
        //     systempart(Control5; Notes)
        //     {
        //         ApplicationArea = Basic, Suite;
        //     }
        //     systempart(Control6; MyNotes)
        //     {
        //         ApplicationArea = Basic, Suite;
        //     }
        //     systempart(Control7; Links)
        //     {
        //         ApplicationArea = Basic, Suite;
        //     }
        // }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
    UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter("Current Department",UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}

