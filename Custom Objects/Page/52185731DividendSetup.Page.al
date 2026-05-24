page 52185731 "Dividend Setup"
{
    PageType = Card;
    SourceTable = "Dividend SetUp";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Period Filter")
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Loans)
            {
                field("Dividend Discounting"; Rec."Dividend Discounting")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Defaulter Recovery"; Rec."Defaulter Recovery")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Discounting Start Date"; Rec."Discounting Start Date")
                { }
                field("Discounting End Date"; Rec."Discounting End Date")
                { }
                field("Loan Arrears Recovery"; Rec."Loan Arrears Recovery")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Savings Arrears Period"; Rec."Savings Arrears Period")
                {

                }
                field("Dividend Instructions"; Rec."Dividend Instructions")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Savings)
            {
                field("Minimum Shares Recovery"; Rec."Minimum Shares Recovery")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Minimum Shares Account"; Rec."Minimum Shares Account")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Minimum Capitalized"; Rec."Minimum Capitalized")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            // group(Charges)
            // {
            //     Caption = 'Charges and Incentives';
            //     field("Transaction Type"; Rec."Transaction Type")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field(Incentives; Rec.Incentives)
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("Incentives G\L"; Rec."Incentives G\L")
            //     {
            //         ApplicationArea = Basic, Suite;
            //     }
            // }
            group(NoSetup)
            {
                Caption = 'No. Setup';
                field("Div Header No."; Rec."Div Header No.")
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

