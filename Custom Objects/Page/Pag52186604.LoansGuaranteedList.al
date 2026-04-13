namespace MNS.MNS;

page 52186604 "Loans Guaranteed List"
{
    Caption = 'Loans Guaranteed List';
    PageType = List;
    SourceTable = "Loan Guarantors and Security";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = SORTING("Loan No")
                      ORDER(Ascending);
    ApplicationArea = Basic, Suite;
    //Sorting = "Loanee Name";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member Guaranteed"; Rec."Member Guaranteed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Guaranteed field.';

                    trigger OnDrillDown()
                    var
                        Members: Record "Members";
                    begin
                        if Members.get(Rec."Loanee Name") then
                            page.run(page::"Member Single", Members);
                    end;
                }
                field("Loanee Name"; Rec."Loanee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loanee Name field.';
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No field.';
                    trigger OnDrillDown()
                    var
                        Loans: Record "Loans";
                    begin
                        if Loans.get(Rec."Loan No") then
                            page.run(page::"Loans Posted", Loans);
                    end;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Type field.';
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Name field.', Comment = '%';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Outstanding Principle';
                }

                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    Caption = 'Total Loan Balance(P+I)';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Loan Balance field.', Comment = '%';
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Guaranteed field.';
                }
                field("Percentage Guaranteed"; Rec.PercentageGur)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percentage Guaranteed field.', Comment = '%';
                }
             
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Savings Account No./Member No."; Rec."Savings Account No./Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Account No./Member No. field.', Comment = '%';
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Substituted field.', Comment = '%';
                }
            }
        }
    }
}
