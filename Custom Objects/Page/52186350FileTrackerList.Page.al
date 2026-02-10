page 52186350 "File Tracker List"
{
    CardPageID = "File Tracker Card";
    DeleteAllowed = false;
    // Editable = false;
    PageType = List;
    InsertAllowed = true;
    SourceTable = "File Tracker";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request Number"; Rec."Request Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Creation No.';
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Folio Number"; Rec."Folio Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File Request Status"; Rec."File Request Status")
                {

                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent To"; Rec."Sent To")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Current Location';
                }
                field("Office Name"; Rec."Office Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {

                }
                field("Current Responsibility Centre"; Rec."Current Responsibility Centre")
                {

                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Other  Doc  No"; Rec."Other  Doc  No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File  Forwarded"; Rec."File  Forwarded")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Create; Rec.Create)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'File Created';
                }
            }
        }
    }

    actions
    {
    }

    // trigger OnOpenPage()
    // var
    //     UserSetup: Record "User Setup";
    // begin
    //     if UserSetup.Get(UserId) then begin
    //         UserSetup.TestField("Responsibility Centre");
    //         Rec.SetFilter(Rec."Current Responsibility Centre", UserSetup."Responsibility Centre");
    //     end else
    //         Error('You must be set up in user setup');
    // end;
}

