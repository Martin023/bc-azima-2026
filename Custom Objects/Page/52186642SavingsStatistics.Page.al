page 52186642 "Savings Statistics"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Savings Accounts";
    // SourceTableView = WHERE("Product Category" = FILTER(<> "Unallocated Fund"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin
                        Page.Run(Page::"Savings Account Card", Rec);
                    end;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance (LCY)';
                    Visible = ShowS;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Prorata; Rec."Prorata")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = Cash;
                //     ToolTip = 'Specifies prorata amount';
                //     trigger OnDrillDown()
                //     var
                //         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                //     begin
                //         CustomCuesCodeunit.DrillDownProrataRecs(Rec."Member No.", Rec."Product Type");
                //     end;
                // }
                // field(Name; Rec.Name)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Interest Earned"; Rec."Interest Earned")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }

                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }


                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;

                }


                field("Lien Placed"; Rec."Lien Placed")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lien Placed';
                    Visible = ShowS;
                }

                field("Available Balalnce"; Rec.GetAvailableBalance(Rec."No."))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Balalnce';
                    Visible = ShowS;
                }
                field("Salary Received"; Rec."Salary Received")
                {
                    // Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ShowS := true;
        CalculateCues;
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", Rec."Member No.");
        SavingsAccounts.SetRange("Loan Disbursement Account", true);
        if SavingsAccounts.Find('-') then begin
            if SavingsAccounts.Hide = true then begin
                ShowS := false;
            end;
        end;

        Rec.CalcFields("Balance (LCY)");
        Evaluate(HideBal, Format(Rec."Balance (LCY)"));

        if UserSetup.Get(UserId) then begin
            if UserSetup."Show Hidden Balance" = false then begin
                if Rec."Product Category" = Rec."Product Category"::"Unallocated Fund" then begin
                    //MESSAGE('u');
                    ShowS := false;
                end;

            end;
        end;
    end;

    var
        UserSetup: Record "User Setup";
        ShowS: Boolean;
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        HideBal: Text;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        GlobalFunctions: Codeunit "Global Functions";

    local procedure CalculateCues()
    begin


        rec.Prorata := CustomCuesCodeunit.Prorata(Rec."Member No.", Rec."Product Type");
    end;

}

