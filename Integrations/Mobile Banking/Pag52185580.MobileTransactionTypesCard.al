page 52185580 "Mobile Transaction Types Card"
{
    Caption = 'Mobile Transaction Types Card';
    PageType = Card;
    SourceTable = "Mobile Transaction Types";
    SourceTableView = where("Channel Type" = const(Mobile));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }

                // field("Upper Limit"; Rec."Upper Limit")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Int. Vendor Account No."; Rec."Loan Int. Vendor Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Updated At"; Rec.SystemModifiedAt)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1; "Mobile Transaction types Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Transaction Type" = FIELD(Code);
            }
        }
    }

    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Channel type" := Rec."Channel type"::Mobile;
    end;

    trigger OnOpenPage()
    begin
        OnAccesRestrictView();
    end;

    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1 - %2';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Edit Setup", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::Administrator);
        if not ChangePermission.Find('-') then begin
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end;
    end;
}


