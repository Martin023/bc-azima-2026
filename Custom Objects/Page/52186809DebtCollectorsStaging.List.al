page 52186809 "Debt Collectors Staging"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Debt Collectors Staging";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    Editable = false;
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    Editable = false;
                }
                field("Principle Balance"; Rec."Principle Balance")
                {
                    Editable = false;
                }
                field("Days In Arreas"; Rec."Days In Arreas")
                {
                    Editable = false;
                }
                field("SASRA Categorisation"; Rec."SASRA Categorisation")
                {
                    Editable = false;
                }
                field("Installments In Falloff"; Rec."Installments In Falloff")
                {
                    Editable = false;
                }
                field(Validated; Rec.Validated)
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
                field("Entry Time"; Rec."Entry Time")
                {
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                {
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Upload Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                begin
                    Message('Upload successful');
                end;
            }

            action("Validate Loans")
            {
                ApplicationArea = Basic, Suite;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                begin
                    Message('Validatoin successfull');
                end;
            }


            action("Assign Loans To Debt Collectors")
            {
                ApplicationArea = Basic, Suite;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Message('Loans have been assigned to debt collectors successfully');
                end;
            }
        }
    }
}
