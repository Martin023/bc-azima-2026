page 52185803 "Banking No Setup"
{
    SourceTable = "Banking No Setup";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Banking No Setup")
            {
                Caption = 'Banking No Setup';
                field("Cashier Transaction Nos."; Rec."Cashier Transaction Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Treasury & Teller Trans Nos."; Rec."Treasury & Teller Trans Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Standing Order Nos."; Rec."Standing Order Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Standing Order Reg. Nos."; Rec."Standing Order Reg. Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Standing Order Control Nos."; Rec."Standing Order Control Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("EFT Nos."; Rec."RTGS Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("EFT Line Nos"; Rec."EFT Line Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Nos."; Rec."Salary Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Receipts Nos"; Rec."Cheque Receipts Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Application Nos"; Rec."Cheque Application Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Treasury Control No."; Rec."Treasury Control No.")
                {

                }
                field("Bankers Cheque Application Nos"; Rec."Bankers Cheque Application Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Overdraft Nos"; Rec."Overdraft Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Transfer Nos"; Rec."Account Transfer Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Application Nos"; Rec."ATM Application Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Linking Application Nos"; Rec."ATM Linking Application Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Repin"; Rec."ATM Repin")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mobile Banking No."; Rec."Mobile Banking No.")
                {

                }
                field("FOSA Interest Nos"; Rec."FOSA Interest Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Apprvls."; Rec."Document Apprvls.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Nos."; Rec."Delegate Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Sub Nos."; Rec."Delegate Sub Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Application Nos."; Rec."Delegate Application Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Payment Nos."; Rec."Delegate Payment Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Minutes Nos."; Rec."Delegate Minutes Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delega Change"; Rec."Delega Change")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Change M-SACCO PIN Nos"; Rec."Change M-SACCO PIN Nos")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("M-SACCO Change Nos"; Rec."M-SACCO Change Nos")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("BULK SMS Nos"; Rec."BULK SMS Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Closure"; Rec."Account Closure")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Activation"; Rec."Account Activation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FOSA Account Activation';
                }

                field("M-SACCO Application Nos"; Rec."M-SACCO Application Nos")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Agency Update Nos."; Rec."Agency Update Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dispatch ATM Header No"; Rec."Dispatch ATM Header No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Return No."; Rec."ATM Return No.")
                {

                }

            }
            group("Finance No. Setup")
            {
                field("Refunds No."; Rec."Refunds No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Refund No."; Rec."Loan Refund No.") { }
                field("BOSA Account Activation"; Rec."BOSA Account Activation")
                {

                }
            }
            group("Treasury No Setup")
            {
                Caption = 'Treasury No Setup';
                field("Investment Nos"; Rec."Investment Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Investment Interest Nos"; Rec."Investment Interest Nos")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        // OnAccesRestrictView();
    end;

    //[Scope('OnPrem')]
    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
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

