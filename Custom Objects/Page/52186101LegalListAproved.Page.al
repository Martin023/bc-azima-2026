page 52186101 "Legal List Aproved"
{
    CardPageID = "Legal Card Approved";
    PageType = List;
    SourceTable = Legal;
    SourceTableView = WHERE(Status = CONST(Approved));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    //ModifyAllowed = false;
    DeleteAllowed = false;
    //Editable = false;
    //InsertAllowed = false;
    

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case Type"; Rec."Matter Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date of filing the Suit"; Rec."Date of Filing the suit")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Type of Complainant"; Rec."Type of Complainant")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Date To Discuss Case"; Rec."Date To Discuss Case")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Description of Complaint"; Rec."Description of Complaint")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Reporter; Rec.Reporter)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Witness; Rec.Witness)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Witness #2"; Rec."Witness #2")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Accused Name"; Rec."Accused Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Action Duration Start Date"; Rec."Action Duration Start Date")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Action Duration End  Date"; Rec."Action Duration End  Date")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Action Taken"; Rec."Action Taken")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Comments; Rec.Comments)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Case Discussion"; Rec."Case Discussion")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(""; Rec."Body Handling The Complaint")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Recommended Action"; Rec."Recommended Action")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Recomendations; Rec.Recomendations)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("No. Series"; Rec."No. Series")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Policy Description"; Rec."Policy Description")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Taken Action Description"; Rec."Taken Action Description")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Responsibility Center"; Rec."Responsibility Center")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Reporter Name"; Rec."Reporter Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Witness #1 Name"; Rec."Witness #1 Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Witness #2  Name"; Rec."Witness #2  Name")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Legal Type"; Rec."Legal Type")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("User ID"; Rec."User ID")
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

