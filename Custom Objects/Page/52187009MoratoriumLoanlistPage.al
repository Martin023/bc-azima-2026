page 52187009 "Moratorium Loan List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Moratorium Loan";
    CardPageId = "Moratorium Loan Card";


    layout
    {
        area(Content)
        {
            repeater("Moratorium loan List")
            {
                field("M-Num"; Rec."M-Num")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Moratorium No.';

                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = all;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = all;
                }
                field("Start Date Moratorium"; Rec."Start Date Moratorium")
                {
                    ApplicationArea = all;
                }
                field("End Date Moratorium"; Rec."End Date Moratorium")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}