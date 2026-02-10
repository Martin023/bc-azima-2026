page 52187013 "Loan Restructure List"
{
    PageType = List;
    ApplicationArea = All;
    CardPageId = "Loan Restucturing";
    UsageCategory = Lists;
    SourceTable = "Loan Rescheduling";
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Loan Restructure List")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Schedule Type"; Rec."Schedule Type")
                { ApplicationArea = All; }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = all;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = all;
                }
                field("Old Amortised"; Rec."Old Amortised")
                {
                    ApplicationArea = all;
                }
                field("New Amortised"; Rec."New Amortised")
                {
                    ApplicationArea = all;
                }

                field(Status; Rec.Status)
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

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //   Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        //  Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //  Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        //  Rec."Schedule Type" := Rec."Schedule Type"::Restructure;
    end;
}