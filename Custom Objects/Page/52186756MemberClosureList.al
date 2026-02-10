namespace MNSProject.MNSProject;

page 52186756 "Member Closure List All"
{
    ApplicationArea = All;
    Caption = 'Member Closure List';
    PageType = List;
    SourceTable = "Membership Closure";
    PromotedActionCategories = 'New,Process,Reports,Document Comments';
    UsageCategory = Lists;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                // field(Digit; Rec.Digit)
                // {
                //     Editable = false;
                // }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'specifies the employercode';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                // field("Send/Forward to"; Rec."Send/Forward to")
                // {
                //     ToolTip = 'Specifies the value of the Send/Forward to field.';
                // }
                field("Originating Department"; Rec."Originating Department")
                {
                    ToolTip = 'Specifies the value of the Originating Department field.';
                }
                field("Previous Department"; Rec."Previous Department")
                {
                    ToolTip = 'Specifies the value of the Previous Department field.';
                }
                field("Checked By"; Rec."Checked By")
                {
                    Caption = 'Checked by (Previous Department)';
                    ToolTip = 'Specifies the value of the Checked By field.';
                }
                field("Date Time Checked"; Rec."Date Time Checked")
                {
                    ToolTip = 'Specifies the value of the Date Time Checked field.';
                }

                field("Current Department"; Rec."Current Department")
                {
                    ToolTip = 'Specifies the value of the Current Department field.';
                }


                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                // field("Responsible Officer Finance"; Rec."Responsible Officer")
                // {
                //     ToolTip = 'Specifies the value of the response field.';
                //     Caption = 'Responsible Officer Finance';
                // }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Closure Comments")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                Caption = 'Comment';
                PromotedCategory = Category4;
                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("No.");
                RunPageView = where(Types = CONST(comment));

                trigger OnAction()
                begin

                end;
            }
        }
    }

}

