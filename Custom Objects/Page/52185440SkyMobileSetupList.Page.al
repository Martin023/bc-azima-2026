page 52185440 "Sky Mobile Setup List"
{
    CardPageID = "Sky Mobile Setup Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Sky Mobile Setup";
    UsageCategory = Administration;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Commission Account"; Rec."Vendor Commission Account")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Commission"; Rec."Vendor Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Fee Account"; Rec."Sacco Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Fee"; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Safaricom Account"; Rec."Safaricom Account")
                {
                    ApplicationArea = Basic;
                }
                field("Safaricom Fee"; Rec."Safaricom Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Pre-Payment Account"; Rec."Pre-Payment Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("SMS Charge"; Rec."SMS Charge")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("SMS Account"; Rec."SMS Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Transaction Limit"; Rec."Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Non-Member Debit Account"; Rec."Non-Member Debit Account")
                {
                    ApplicationArea = Basic;
                }
                field("Daily Limit"; Rec."Daily Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Weekly Limit"; Rec."Weekly Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Limit"; Rec."Monthly Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field("Staggered Charge Code"; Rec."Staggered Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field("Restrict to Employer"; Rec."Restrict to Employer")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Agents"; Rec."Charge Agents")
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
            action("Update MPESA")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    Acc: Code[20];
                    Phone: Code[20];
                begin

                    Acc := '5000017665000';
                    Phone := '+254722346758';

                    Savings.Get(Acc);
                    Savings."Transactional Mobile No" := Phone;
                    Savings.Status := Savings.Status::" ";
                    Savings.Blocked := Savings.Blocked::" ";
                    Savings.Modify;

                    if not Auth.Get(Phone) then begin
                        Auth.Init;
                        Auth."Mobile No." := Phone;
                        Auth."Account No." := Acc;
                        Auth.Insert;
                    end;

                    Auth.Reset;
                    Auth.SetRange("Account No.", Savings."No.");
                    if Auth.FindFirst then begin
                        //Auth."Mobile No." := Savings."Transactional Mobile No";
                        //Auth.MODIFY;
                        Auth.Rename(Savings."Transactional Mobile No");
                        //SkyMbanking.GenerateNewPin(CopyStr(Savings."Transactional Mobile No", 2, 12));
                    end;
                    Message('Updated');
                end;
            }
            action("Reset Pin")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    Savings.Get('5000000127000');
                    Savings."Transactional Mobile No" := '+254706405989';
                    Savings.Status := Savings.Status::" ";
                    Savings.Blocked := Savings.Blocked::" ";
                    Savings.Modify;

                    Auth.Reset;
                    Auth.SetRange("Account No.", Savings."No.");
                    if Auth.FindFirst then begin
                        //Auth."Mobile No." := Savings."Transactional Mobile No";
                        //Auth.MODIFY;
                        Auth.Rename(Savings."Transactional Mobile No");
                        Auth."Reset PIN" := true;
                        Auth.Modify;

                        //SkyMbanking.PinReset;
                    end;
                    Message('Updated');
                end;
            }
            action(UnblockVendor)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    Vendor.Get(Rec."Vendor Commission Account");
                    Vendor.Blocked := Vendor.Blocked::" ";
                    Vendor.Modify;
                    Message('Updated');
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Permission.Reset;
        Permission.SetRange("User ID", UserId);
        Permission.SetRange("Sky Mobile Setups", true);
        if not Permission.FindFirst then
            Error('You do not have the following permission: "Sky Mobile Setups"');
    end;

    var
        Savings: Record "Savings Accounts";
        Auth: Record "Sky USSD Auth";
        //SkyMbanking: Codeunit "Sky Mbanking";
        Permission: Record "Sky Permissions";
        Vendor: Record Vendor;
}

