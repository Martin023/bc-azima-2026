page 52187086 "Business Clossure List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Business Loan Clossure";
    CardPageId = "Business Loan Clossure Card";
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    Caption = 'Exit and Transfer';
    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {

                }
                field("Clossure Type"; Rec."Clossure Type")
                {

                }

                field("Member No."; Rec."Member No.")
                {

                }

                field(Name; Rec.Name)
                {

                }

                field(Identification; Rec.Identification)
                {

                }

                field("Employer Name"; Rec."Employer Name")
                {

                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }

                field(Status; Rec.Status)
                {

                }
            }
        }
    }
}
