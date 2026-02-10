page 52186990 "Sky Background Process Manager"
{
    ApplicationArea = All;
    Caption = 'Sky Background Process Manager';
    PageType = Card;
    SourceTable = "Sky Background Process Manager";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Div. Records Pause Count"; Rec."Records Pause Count")
                {
                    ToolTip = 'Specifies the value of the Records Pause Count field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                }
                field("Div. Threads Count"; Rec."Threads Count")
                {
                    ToolTip = 'Specifies the value of the Threads Count field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Mbanking)
            {
                Caption = 'Mobile Banking';

                field("Disable Mob. Loan Disb."; Rec."Disable Mob. Loan Disb.")
                {
                    ToolTip = 'Specifies the value of the Disable Mob. Loan Disb. field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                }
                field("Disable Mob. Dep. Post"; Rec."Disable Mob. Dep. Post")
                {
                    ToolTip = 'Specifies the value of the Disable Mob. Dep. Post field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                }
                field("Disable Mob. Wtd. Post"; Rec."Disable Mob. Wtd. Post")
                {
                    ToolTip = 'Specifies the value of the Disable Mob. Wtd. Post field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                }
                field("Disable Mob. Internal Post"; Rec."Disable Mob. Internal Post")
                {
                    ToolTip = 'Specifies the value of the Disable Mob. Internal Post field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(ATM)
            {
                Caption = 'ATM Banking';

                field("Disable ATM. Post"; Rec."Disable ATM. Post")
                {
                    ToolTip = 'Specifies the value of the Disable ATM. Post field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Other)
            {
                Caption = 'Other';

                field("Created At"; Rec.SystemCreatedAt) { }
                field("Modified At"; Rec.SystemModifiedAt) { }
                field("Last Modified By"; Rec."Last Modified By") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //OnAccesRestrictView();
    end;

    //[Scope('OnPrem')]
    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do not have permission on view,read,modify on this page. Contact system administrator for assistance. %1 - %2';
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
