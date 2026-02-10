page 52185445 "Sky Update Paybill ID"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Sky Transactions";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone/Acc. No"; Rec."Member Account")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    var
                        MemberNo: Code[20];
                        AccountNo: Code[20];
                        LoanNo: Code[20];
                        "Key": Text;
                        LBal: Decimal;
                    begin

                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Retry)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to retry posting this transaction') then begin
                        Rec."Needs Change" := false;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        StatusChangePermissions.Reset;
        StatusChangePermissions.SetRange("User ID", UserId);
        StatusChangePermissions.SetRange("Update Paybill Transaction", true);
        if not StatusChangePermissions.FindFirst then
            Error('You do not have the following permission: "Update Paybill Transaction"');
    end;

    var
        StatusChangePermissions: Record "Sky Permissions";
        Savings: Record "Savings Accounts";
    //SkyMbanking: Codeunit "Sky Mbanking";
}

