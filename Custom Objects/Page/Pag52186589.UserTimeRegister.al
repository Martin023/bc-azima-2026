namespace MNSProjectMwanga.MNSProjectMwanga;

using Microsoft.Projects.TimeSheet;

page 52186589 "User Time Register"
{
    ApplicationArea = All;
    Caption = 'User Time Register';
    PageType = List;
    SourceTable = "User Time Register";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the date.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = '1st Login Date';
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Login Date';
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(Minutes; Rec.Minutes)
                {
                    ToolTip = 'Specifies how many minutes an individual user works on the accounts.';
                }
            }
        }
    }
}
