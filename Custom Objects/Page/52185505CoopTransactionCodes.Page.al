page 52185505 "Coop Transaction Codes"
{
    PageType = List;
    SourceTable = "Coop Transaction Codes";
    ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Terminal; Rec.Terminal)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        /*
                        IF Terminal <> '' THEN
                            IF Code <> '0011' THEN
                                  IF Code <> '0027' THEN
                                      IF Code <> '0014' THEN
                                            IF Code <> '0016' THEN
                                                ERROR('Not Applicable to this Code');
                                                */

                    end;
                }
                field(Channel; Rec.Channel)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        /*
                        IF Channel <> '' THEN
                            IF Code <> '0011' THEN
                                  IF Code <> '0027' THEN
                                      IF Code <> '0014' THEN
                                            IF Code <> '0016' THEN
                                                ERROR('Not Applicable to this Code');
                                                */

                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Daily Limit"; Rec."Daily Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Coop Bank Account"; Rec."Coop Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Description"; Rec."Posting Description")
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
            // action(Charges)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     RunObject = Page "Coop ATM Charges";
            //     RunPageLink = Code = FIELD(Code),
            //                   Terminal = FIELD(Terminal),
            //                   Channel = FIELD(Channel);
            // }
        }
    }

    trigger OnInit()
    begin
        SkyPermissions.Reset;
        SkyPermissions.SetRange("User ID", UserId);
        SkyPermissions.SetRange("ATM Setups", false);
        if SkyPermissions.FindFirst then Error('You do nto have permission ATM Setups in MBanking Permissions');
    end;

    var
        SkyPermissions: Record "Sky Permissions";
}

