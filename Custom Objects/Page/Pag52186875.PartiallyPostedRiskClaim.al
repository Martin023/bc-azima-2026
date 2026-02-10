page 52186875 "Partially Posted Risk Claim"
{
    Caption = 'Partially Posted Risk Claim';
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "SinkFund Report Information";
    CardPageID = "Risk Claim Notice";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Approved), Posted = const(false),
    "Claim Type" = filter("Risk Claim"), "Partially Posted" = const(true));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Date of Death"; Rec."Date of Death")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Claim Type"; Rec."Claim Type")
                {

                }
                field("Deceased Person"; Rec."Deceased Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Captured By"; Rec."Captured By")
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




