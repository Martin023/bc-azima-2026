page 52185864 "Signatories List"
{
    AutoSplitKey = true;
    Caption = 'Signatory List';
    CardPageID = "Signatories Card";
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = false;
    LinksAllowed = true;
    PageType = List;
    SourceTable = "Account Signatories";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control9)
            {
                ShowCaption = false;
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff/Payroll"; Rec."Staff/Payroll")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff/Payroll No';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Designation';
                }
                field(TotalBalances; TotalBalances)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Loan Balance';
                }
                field(TotalSavings;TotalSavings)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Loan Balance';
                }
            }
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                ApplicationArea = Basic;

                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }
            part("Member FactBox"; "Member FactBox")
            {
                ApplicationArea = Basic;
                Caption = 'Member FactBox';
                SubPageLink = "Member No." = field("Member No.");
                Visible = not HideAccount;
            }
            

        }
    }

    actions
    {
    }
    var
        TotalBalances: Decimal;
        TotalSavings: Decimal;
        
        GlobalFunctions: Codeunit "Global Functions";
        HideAccount: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        UpdateControl;
        HideAccount := GlobalFunctions.HideAccount(Rec."Member No.");
    end;

    trigger OnAfterGetRecord()
    var
        LOANSpR: Codeunit "Loans Process";
    begin
        TotalBalances := LOANSpR.GetTotalMemberLoanBalancePerUnit(Rec."Member No.", 3, Today);
        TotalSavings := GesavingsBalance();
    end;
    //[Scope('OnPrem')]
    procedure UpdateControl()
    var
        MemberAppl: Record "Member Application";
    begin

        if MemberAppl.Get(Rec."Account No") then begin
            case MemberAppl.Status of
                MemberAppl.Status::Pending, MemberAppl.Status::Approved, MemberAppl.Status::Rejected:
                    begin
                        CurrPage.Editable := false;
                    end;

                MemberAppl.Status::Open:
                    begin
                        CurrPage.Editable := true;
                    end;
            end;
        end;
    end;

    local procedure GesavingsBalance(): Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
    begin
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Product Category",SavingsAccounts."Product Category"::"Business Deposits");
        SavingsAccounts.SetRange("Member No.",Rec."Member No.");
        if SavingsAccounts.FindFirst() then begin
            TotalSavings := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
        end;
    end;
}

