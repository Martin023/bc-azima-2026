page 52185447 "Black-Listed Phone Nos"
{
    // 
    // StatusPermission.RESET;
    // StatusPermission.SETRANGE("User ID",USERID);
    // StatusPermission.SETRANGE("Black-List Accounts",TRUE);
    // IF NOT StatusPermission.FIND('-') THEN BEGIN
    //     ERROR('You do not have the following permission: "Black-List Accounts"');
    // END;

    PageType = List;
    SourceTable = "Sky Black-Listed Phone Nos";
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transactional Phone No."; Rec."Transactional Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Black-Listed"; Rec."Black-Listed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Black-Listed By"; Rec."Black-Listed By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Black-Listed"; Rec."Date Black-Listed")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;
                ////RunObject = XMLport XMLport50056;
            }
        }
    }

    trigger OnInit()
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("View BlackListed Accounts", true);
        if not StatusPermission.Find('-') then begin
            Error('You do not have the following permission: "Black-List Accounts"');
        end;
    end;

    var
        StatusPermission: Record "Sky Permissions";
}

