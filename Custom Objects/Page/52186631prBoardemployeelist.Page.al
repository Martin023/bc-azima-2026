page 52186631 "prBoard employee list"
{
    CardPageID = "prBoard Employees Card";
    PageType = List;
    SourceTable = "Board members";
    ApplicationArea = Basic, Suite;    
    Caption = 'Board Member Payroll List';
    PromotedActionCategories = 'New,Process,Reports,Assign Earning/Deductions';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Mail; Rec.Mail)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Board Member"; Rec."Board Member")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("P.I.N"; Rec."P.I.N")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}