page 52185465 "Agent Transfer Page"
{
    PageType = Card;
    SourceTable = "Sky Agent Transfer";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Debit Account Type"; Rec."Debit Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            // group("Rejection reason")
            // {
            //     Editable = RejectedEditable;
            //     field("Rejection Reason"; Rec."Rejection Reason")
            //     {
            //     }
            //     field(Rejected; Rec.Rejected)
            //     {
            //     }
            //     field("Rejected By"; Rec."Rejected By")
            //     {
            //     }
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin
                    if rec.Posted then Error('The transaction has already been posted');
                    if rec.Rejected then Error('You cannot post a rejected transaction');
                    //MESSAGE("Transaction ID");
                    //SkyAgencyBanking.PostAgentTransaction(rec."Transaction ID");
                    Message('Posted Sucsessfully');
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic, Suite;
                Image = Reject;
                Promoted = true;

                trigger OnAction()
                begin
                    if rec.Posted then Error('You cannot rejected a posted transaction');
                    if rec.Rejected then Error('The transaction has already been rejected');
                    if rec."Rejection Reason" = '' then Error('Rejection reason must have a value');
                    rec.Rejected := true;
                    rec."Rejected By" := UserId;
                    rec.Modify;
                    //Send SMS;
                    AgentApplications.Get(rec."Agent Code");
                    msg := 'Dear Agent your Utility to FOSA transfer of amount KES ' + Format(rec.Amount) + ' has been rejected, Reason: ' + rec."Rejection Reason";
                    MobileNo := AgentApplications."Mobile No";
                    // SkyAgencyBanking.SendSmsWithID(Source::Agency, MobileNo, msg, Format(rec."Transaction ID"), '', true, 220, false, 'AGENT', rec."Session ID", 'AGENT');
                    Message('Rejected Successfully');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        RejectedEditable := true;
        if rec.Posted then
            RejectedEditable := false;
    end;

    var
        //SkyAgencyBanking: Codeunit "Sky Agency Banking";
        RejectedEditable: Boolean;
        Source: Option ,Agency;
        msg: Text;
        MobileNo: Text;
        AgentApplications: Record "Agent Applications";
}

