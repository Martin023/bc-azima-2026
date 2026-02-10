page 52185456 "Sky Agent Transactions"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky Agents Transactions";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction ID"; Rec."Transaction ID")
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
                field("Member Account"; Rec."Member Account")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Member ID"; Rec."Paybill Member ID")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Commission"; Rec."Vendor Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Fee"; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Commision Account"; Rec."Agent Commision Account")
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
                field(Control31; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Account Number"; Rec."Agent Account Number")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Old Transaction Date"; Rec."Old Transaction Date")
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
                field("Time Reversed"; Rec."Time Reversed")
                {
                    ApplicationArea = Basic;
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    ApplicationArea = Basic;
                }
                field("Reversal ID"; Rec."Reversal ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Keyword; Rec.Keyword)
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Max Rows"; Rec."Statement Max Rows")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Start Date"; Rec."Statement Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Statement End Date"; Rec."Statement End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account to Check"; Rec."Account to Check")
                {
                    ApplicationArea = Basic;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Account Type"; Rec."Debit Account Type")
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
            action("Update Paybill")
            {
                ApplicationArea = Basic;
                //here
                // RunObject = Page Page52017717;
                // RunPageLink = Field40 = FIELD("Entry No.");
            }
            action("Needs Change")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Status Change Permissions.";
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    //StatusChangePermissions.SETRANGE("Update Rejoining Member",TRUE);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to mark this transaction as needs change?') then begin
                        Rec."Needs Change" := true;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }
}

