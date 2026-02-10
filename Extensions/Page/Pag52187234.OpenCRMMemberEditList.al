page 52187234 "Open CRM Member Edits"
{
    CardPageID = "CRM Member Edit";
    PageType = List;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Activities, ,Category7_caption,Category8_caption,Category9_caption,Approvals';
    SourceTable = "CRM Member Edit";
    // SourceTableView = WHERE("Change Complete" = Const(False));  

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Type of Edit"; Rec."Type of Edit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Edit Information"; Rec."Edit Information")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("CRM Created By"; Rec."CRM Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("CRM Branch"; Rec."CRM Branch")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Change Complete"; Rec."Change Complete")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sent Back to CRM"; Rec."Sent Back to CRM")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        // exit;

        Rec.CalcFields("Responsible Officer", "Supervisor ID");

        // Rec.FilterGroup := -1;
        Rec.SetFilter("Responsible Officer", UserId);
        // Rec.SetFilter("Supervisor ID", UserId);

        // if Rec.FindSet() then
        //     repeat
        //         if (Rec."Responsible Officer" = UserId) or (Rec."Supervisor ID" = UserId) then begin
        //             if Rec."Supervisor ID" = UserId then begin
        //                 Rec.SetFilter("Supervisor ID", UserId);
        //                 exit;
        //             end;

        //             if Rec."Responsible Officer" = UserId then begin
        //                 Rec.SetFilter("Responsible Officer", UserId);
        //                 exit;
        //             end;
        //         end // else
        //             // Rec.SetFilter("No.", '1');
        //     until Rec.Next() = 0;

    end;
}