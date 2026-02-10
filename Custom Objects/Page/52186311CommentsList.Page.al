page 52186311 "Comments List"
{
    // CardPageID = "Comments Card";
    DeleteAllowed = true;
    PageType = List;
    SourceTable = Comments;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Types; Rec.Types)
                {

                }

                field(Comment; Rec.Comment)
                {
                    trigger OnValidate()
                    begin
                        if Rec."Commented By" <> '' then begin
                            if Rec."Commented By" <> UserId then Error('You are not the owner of this comment');

                            if Rec."Viewd By Somebody Else" then Error('You cannot edit this comment because it has already been viewed');
                        end;
                    end;
                }

                field("Commented By"; Rec."Commented By")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Disable Flag"; Rec."Disable Flag")
                {
                    Visible = FlagBooleanVisible;
                }
                field("Last Modified At";Rec."Last Modified At")
                {
                    Editable = false;
                }
                field("Last Modified By";Rec."Last Modified By")
                {
                    Editable = true;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    begin
        if Rec.Types = Rec.Types::"Member Flagging" then
            FlagBooleanVisible := true
        else
            FlagBooleanVisible := false;
    end;

    trigger OnAfterGetRecord()
    var
    begin
        if Rec.Types = Rec.Types::"Member Flagging" then
            FlagBooleanVisible := true
        else
            FlagBooleanVisible := false;
    end;

    trigger OnOpenPage()
    var
    begin
        if Rec.Types = Rec.Types::History then
            CurrPage.Editable := false;

        repeat
            if (Rec."Commented By" <> UserId) and (Rec."Commented By" <> '') and (Rec.Comment <> '') then begin
                Rec."Viewd By Somebody Else" := true;
                Rec.Modify();
            end;
        until Rec.Next() = 0;

        if Rec.Types = Rec.Types::"Member Flagging" then
            FlagBooleanVisible := true
        else
            FlagBooleanVisible := false;
    end;

    var
        FlagBooleanVisible: Boolean;


}

