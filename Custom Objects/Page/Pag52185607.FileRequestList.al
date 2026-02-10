namespace MNSProjectMwanga.MNSProjectMwanga;
using System.Security.User;

page 52185607 "File Request List"
{
    ApplicationArea = All;
    Caption = 'File Request List';
    PageType = List;
    SourceTable = "File Requests";
    UsageCategory = Lists;
    CardPageID = "File Request Card";
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request Number"; Rec."Request Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Request Number';
                }
                field("File Type"; Rec."File Type")
                {

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
                field("File Request Remarks"; Rec."File Request Remarks")
                {

                }
                field(Status; Rec.Status)
                { }

                field("Responsibility Centre"; Rec."Responsibility Centre")
                {

                }
                field("Current Responsibility Centre"; Rec."Current Responsibility Centre")
                {

                }

                field("Staff No"; Rec."Staff No")
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

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter(Rec."Current Responsibility Centre", UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}


