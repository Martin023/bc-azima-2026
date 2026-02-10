page 52185856 "Guarantor Subsitution List"
{
    CardPageID = "Guarantor Substitution";
    Editable = false;
    PageType = List;
    SourceTable = "Guarantors Substitution";
    // SourceTableView = WHERE("Sent Back to CRM" = CONST(false));//Show all entries(Credit Request)
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("CRM Application No."; Rec."CRM Application No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    // ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Account No."; Rec."Loan Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                }
                field("Current Savings"; Rec."Current Savings")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Business Loan No."; Rec."Business Loan No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Business Loan Shares"; Rec."Business Loan Shares")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("CRM Originating Branch"; Rec."CRM Originating Branch")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Sent Back to CRM"; Rec."Sent Back to CRM")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
    }

    actions
    {
    }
}

