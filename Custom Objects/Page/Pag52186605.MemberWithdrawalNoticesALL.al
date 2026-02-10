namespace MNS.MNS;

page 52186605 "Member Withdrawal Notices ALL"
{
    ApplicationArea = All;
    Caption = 'Member Withdrawal Notices ALL';
    PageType = List;
    SourceTable = "Member withdrawal Notice";
    UsageCategory = Lists;
    //CardPageID = "Member withdrawal Notice";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec."Date Entered" := Today;
                        Rec."Date Modified" := Today;
                        Rec.Modify;
                    end;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason for withdrawal"; Rec."Reason for withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Notice Date"; Rec."Withdrawal Notice Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Liability"; Rec."Employer Liability")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actioning Department"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Actioning Department';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent Back to CRM"; Rec."Sent Back to CRM")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
