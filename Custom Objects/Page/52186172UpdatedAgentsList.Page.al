page 52186172 "Updated Agents List"
{
    CardPageID = "Update Agent Applications";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Update Agent Application";
    SourceTableView = WHERE(Updated = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Update No"; Rec."Update No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Comm Account"; Rec."Comm Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Serial No"; Rec."Document Serial No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer ID No"; Rec."Customer ID No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Approved"; Rec."Time Approved")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Rejected"; Rec."Date Rejected")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Rejected"; Rec."Time Rejected")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent To Server"; Rec."Sent To Server")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("1st Approval By"; Rec."1st Approval By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date 1st Approval"; Rec."Date 1st Approval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time First Approval"; Rec."Time First Approval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Limit Code"; Rec."Withdrawal Limit Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Limit Amount"; Rec."Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Name of the Proposed Agent"; Rec."Name of the Proposed Agent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Business/Work Experience"; Rec."Business/Work Experience")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Name of Banker"; Rec."Name of Banker")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN(KRA)"; Rec."PIN(KRA)")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

