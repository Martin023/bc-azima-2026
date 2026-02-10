page 52185444 "Sky Mobile Withdrawal Buffer"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Mobile Withdrawals Buffer";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trace ID"; Rec."Trace ID")
                {

                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {

                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {

                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {

                    ApplicationArea = Basic;
                }
                field("Withdrawal Type"; Rec."Withdrawal Type")
                {

                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {

                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {

                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {

                    ApplicationArea = Basic;
                }
                field("Date Reversed"; Rec."Date Reversed")
                {

                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {

                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {

                    ApplicationArea = Basic;
                }
                field("Session ID"; Rec."Session ID")
                {

                    ApplicationArea = Basic;
                }
                field("Reversed By"; Rec."Reversed By")
                {

                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reverse Transaction")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange("Reverse Sky Transactions", true);
                    StatusPermissions.SetRange("User ID", UserId);
                    if not StatusPermissions.FindFirst then
                        Error('You do not have the following permission: "Reverse Sky Transactions"');

                    Rec.TestField(Posted, false);
                    Rec.TestField(Reversed, false);

                    //if SkyMbanking.ReverseWithdrawalRequest("Trace ID") then
                    //     Message('Reversed Successfully')
                    // else
                    //     Message('Not Reversed');
                end;
            }
            action("Insert MPESA Withdrawal")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    Withdrawals.Reset;
                    Withdrawals.SetRange("Trace ID", Rec."Trace ID");
                    //if Withdrawals.FindFirst then
                    //REPORT.Run(50060, true, false, Withdrawals);
                end;
            }
        }
    }

    var
        // SkyMbanking: Codeunit "Sky Mbanking";
        StatusPermissions: Record "Sky Permissions";
        Withdrawals: Record "Mobile Withdrawals Buffer";
}

