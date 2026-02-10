page 52186695 "Portal Endpoints"
{
    PageType = List;
    SourceTable = "Portal Endpoints";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Password Verification"; Rec."Password Verification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("OTP Verification"; Rec."OTP Verification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Change Status Stats"; Rec."Change Status Stats")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        UserEndPoint: Record "Portal Endpoints";
        UserNm: Record "Log Endpoint  Entiries";
    begin
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserEndPoint: Record "Portal Endpoints";
        UserNm: Record "Log Endpoint  Entiries";
    begin

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserEndPoint: Record "Portal Endpoints";
        UserNm: Record "Log Endpoint  Entiries";
    begin


    end;

    trigger OnModifyRecord(): Boolean
    var
        UserEndPoint: Record "Portal Endpoints";
        UserNm: Record "Log Endpoint  Entiries";
    begin

    end;
}

