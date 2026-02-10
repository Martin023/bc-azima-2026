page 52186121 "Approved Surety Management"
{
    CardPageID = "ApprovedSurety Management Card";
    PageType = List;
    SourceTable = "Surety Management";
    SourceTableView = WHERE(Status = FILTER(Approved));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Surety No"; Rec."Surety No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type Of Account"; Rec."Type Of Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Refference No"; Rec."Refference No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Refference Details"; Rec."Refference Details")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Surety Letter Issue")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Surety Letter Issue';

                trigger OnAction()
                begin
                    Member.Reset;
                    Member.SetRange(Member."No.", rec."Member Account No");
                    // if Member.Find('-') then
                    //     Member."Surety Letter Issued" := true;
                    Member.Modify;
                    rec."Stopped USER ID" := UserId;
                    rec."Stopped Date" := Today;
                    rec."Stopped Time" := Time;
                end;
            }
            

        }   
    }

    var
        Member: Record Members;
}

