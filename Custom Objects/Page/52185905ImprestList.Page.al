page 52185905 "Imprest List"
{
    CardPageID = "Imprest Request Header";
    Editable = false;
    PageType = List;
    DeleteAllowed = true;
    SourceTable = "Imprest Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                    editable = false;
                }
            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Print/Preview")
    //         {
    //             ApplicationArea = Basic, Suite;
    //             Image = Print;
    //             Promoted = true;
    //             PromotedCategory = "Report";
    //             PromotedIsBig = true;

    //             trigger OnAction()
    //             begin
    //                 ImprestHeader.Reset;
    //                 ImprestHeader.SetRange(ImprestHeader."No.", Rec."No.");
    //                 //REPORT.Run(39005885, true, false, ImprestHeader);
    //             end;
    //         }
    //     }
    // }

    var
        ImprestHeader: Record "Imprest Header";
}

