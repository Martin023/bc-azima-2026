page 52185785 "Change MPESA PIN List"
{
    CardPageID = "MBanking Change MPESA PIN No";
    PageType = List;
    SourceTable = "M-SACCO Change PIN No";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
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
                field("MPESA Application No"; Rec."MPESA Application No")
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
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MPESA Mobile No"; Rec."MPESA Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MPESA Corporate No"; Rec."MPESA Corporate No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
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
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Sent"; Rec."Time Sent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent By"; Rec."Sent By")
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
            }
        }
    }

    actions
    {
    }
}

