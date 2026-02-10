page 52186991 "E-Channels Transaction Setup"
{
    ApplicationArea = All;
    Caption = 'E-Channels Transaction Setup';
    PageType = Card;
    SourceTable = "E-Channels Transaction Setup";

    layout
    {
        area(Content)
        {
            group(ATM)
            {
                Caption = 'ATM';

                field("ATM Transaction Limit"; Rec."ATM Withdrawal Limit")
                {
                    ToolTip = 'Specifies the value of the ATM Withdrawal Limit Value (Per Transaction) field.', Comment = '%';
                }
                field("ATM Daily Transactions Limit"; Rec."ATM Daily Withdrawals Limit")
                {
                    ToolTip = 'Specifies the value of the ATM Daily Withdrawals Limit Value field.', Comment = '%';
                }
            }
            group("Mobile Banking")
            {
                Caption = 'Mobile Banking';

                field("Mobile Transaction Limit"; Rec."Mobile Withdrawal Limit")
                {
                    ToolTip = 'Specifies the value of the Mobile Withdrawal Limit Value (Per Transaction) field.', Comment = '%';
                }
                field("Mobile Daily Trans. Limit"; Rec."Mobile Daily Withdrawal Limit")
                {
                    ToolTip = 'Specifies the value of the Mobile Daily Transaction Limit field.', Comment = '%';
                }
            }

            field("Created By"; Rec."Created By")
            {

            }
            field("Created At"; Rec.SystemCreatedAt)
            {

            }
            field("Last Updated By"; Rec."Last Updated By")
            {

            }
            field("Last Updated At"; Rec.SystemModifiedAt)
            {

            }
        }
    }

    trigger OnOpenPage()
    begin
        FnRestrictAccess
    end;

    var
        StatusPermission: Record "Status Change Permissions.";

    //[Scope('OnPrem')]
    procedure FnRestrictAccess()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do not have permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1 - %2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", DATABASE.UserId);
        StatusPermission.SetRange("Edit Setup", true);
        StatusPermission.SetRange("Function Extended", StatusPermission."Function Extended"::Administrator);

        if not StatusPermission.Find('-') then begin
            // CurrPage.Editable := false;
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end
        // else begin
        //     CurrPage.Editable := true;
        // end;
    end;
}
