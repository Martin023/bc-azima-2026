namespace KenpipeCBS.KenpipeCBS;

page 52186767 "Matured withdrwal Notices"
{
    ApplicationArea = All;
    Caption = 'Matured withdrwal Notices';
    PageType = List;
    SourceTable = "Member withdrawal Notice";
    UsageCategory = Lists;
    CardPageID = "Member withdrawal Notice";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Status field.', Comment = '%';
                }
                field("Member Deposit"; Rec."Member Deposit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Deposit field.', Comment = '%';
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notice Type field.', Comment = '%';
                }
                field("Total Partial Withdrawn Amount"; Rec."Total Partial Withdrawn Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Partial Withdrawn Amount field.', Comment = '%';
                }
                field("Deposit At First Withdrwal"; Rec."Deposit At First Withdrwal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit At First Withdrwal field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    BEGIN
        MemberWithNotice.reset;
        MemberWithNotice.setrange("Status", MemberWithNotice."Status"::Approved);
        MemberWithNotice.setfilter("Maturity Date", '<=%1', Today);
        MemberWithNotice.setfilter("Withdrawal Notice Date", '<=%1', Today);
        MemberWithNotice.SetRange("Clossure Created", false);
    END;

    var
        MemberWithNotice: Record "Member withdrawal Notice";
}
