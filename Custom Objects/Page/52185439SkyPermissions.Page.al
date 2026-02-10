page 52185439 "Sky Permissions"
{
    PageType = List;
    SourceTable = "Sky Permissions";
    ApplicationArea = Basic;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Reset Mpesa Pin"; Rec."Reset Mpesa Pin")
                {
                    ApplicationArea = Basic;
                }
                field("Update Paybill Transaction"; Rec."Update Paybill Transaction")
                {
                    ApplicationArea = Basic;
                }
                field("Sky Mobile Setups"; Rec."Sky Mobile Setups")
                {
                    ApplicationArea = Basic;
                }
                field("Reverse Sky Transactions"; Rec."Reverse Sky Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Black-List Accounts"; Rec."Black-List Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("View BlackListed Accounts"; Rec."View BlackListed Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Update MPESA Withdrawal"; Rec."Update MPESA Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field("Update Transactional Mobile No"; Rec."Update Transactional Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("Clear Transactional Mobile"; Rec."Clear Transactional Mobile")
                {
                    ApplicationArea = Basic;
                }
                field(IMSI_IMEI_Suspension; Rec.IMSI_IMEI_Suspension)
                {
                    ApplicationArea = Basic;
                }
                field("Activate_Deactivate Account"; Rec."Activate_Deactivate Account")
                {
                    ApplicationArea = Basic;
                }
                field("Initiate Service Change"; Rec."Initiate Service Change")
                {
                    ApplicationArea = Basic;
                }
                field("Approve Service Change"; Rec."Approve Service Change")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Setups"; Rec."ATM Setups")
                {
                    ApplicationArea = Basic;
                }
                field("Release ATM Transactions"; Rec."Release ATM Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Return Loans to Appraisal"; Rec."Return Loans to Appraisal")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        // Permission.RESET;
        // Permission.SETRANGE("User ID",USERID);
        // Permission.SETRANGE("Sky Mobile Setups",TRUE);
        // IF NOT Permission.FINDFIRST THEN
        //  ERROR('You do not have the following permission: "Sky Mobile Setups"');
    end;

    trigger OnOpenPage()
    begin
        //RestrictAccess(USERID);
    end;

    var
        Permission: Record "Sky Permissions";

    //[Scope('OnPrem')]
    procedure RestrictAccess(UserNo: Code[100])
    var
        StatusPermission: Record "User Setup";
        ErrorOnRestrictViewTxt: Label 'You do not have permissions to EDIT this Page. Contact your system administrator for further details';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserNo);
        StatusPermission.SetRange("Approval Administrator", true);
        if not StatusPermission.Find('-') then begin
            Error('You do not have permission to access this page');
        end;
    end;
}

