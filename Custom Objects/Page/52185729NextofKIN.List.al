page 52185729 "Next of KIN"
{
    Caption = 'Next of Kin List';
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Next of KIN";
    //SourceTableView = where(Removed = filter(<> true),"Is Nominee" = filter(<> true));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is a Beneficiary"; Rec."Is a Beneficiary")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Next of Kin"; Rec."Is Next of Kin")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Nominee"; Rec."Is Nominee")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Contact Person"; Rec."Is Contact Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is A WitNess"; Rec."Is A WitNess")
                {

                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec.Identification)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Allocation; Rec.Allocation)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Deceased; Rec.Deceased)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Claim Paid"; Rec."Insurance Claim Paid")
                {
                    ToolTip = 'Specifies the value of the Insurance Claim Paid field.';
                }
                field("Date Created"; Rec."Date Captured")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

