page 52187333 "Membership Activity cue"
{

    PageType = CardPart;
    SourceTable = "Membership Activities cue";
    Caption = 'Activities';

    layout
    {
        area(content)
        {
            cuegroup("Membership")
            {
                cuegroup("Membership Applications")
                {
                    Caption = 'Applications';
                    // CuegroupLayout = Wide;
                    field("Open Member Applications"; Rec."Open Member Applications")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Open Member Applications field.';
                    }
                    field("Open Member Edits"; Rec."Open Member Edits")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Open Member Edits field.';
                    }
                    field("Open Dependancy Applications"; Rec."Open Dependancy Applications")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Nominee and Next of Kin Applications';
                    }
                }
            }
            cuegroup("Current Members")
            {
                cuegroup("Current Members Applications")
                {
                    // CuegroupLayout = Wide;
                    Caption = 'Members';
                    field("Members Created Today"; Rec."Members Created Today")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Members Created Today field.';
                        trigger OnDrillDown()
                        var
                            CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                        begin
                            CustomCuesCodeunit.DrillDownMembersCreatedToday();
                        end;
                    }
                    field("Total Members"; Rec."Total Members")
                    {
                        Caption = 'Active Members';
                        Image = Funnel;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of Active Members.';
                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                        begin
                            CustomCuesCodeunit.DrillDownTotalMembers();

                        end;
                    }
                    field("Dormant Members"; DormantMembers)
                    {

                        ApplicationArea = Basic, Suite;
                        DecimalPlaces = 0 : 0;
                        Style = Favorable;
                        trigger OnDrillDown()
                        var
                            MemberRec: Record Members;
                        begin
                            MemberRec.SetRange(Status, MemberRec.status::Dormant);
                            PAGE.Run(PAGE::"Member List", MemberRec);
                        end;
                    }

                    field("Withdrawn Members"; WithdrawnMembers)
                    {

                        ApplicationArea = Basic, Suite;
                        DecimalPlaces = 0 : 0;
                        Style = Unfavorable;
                        trigger OnDrillDown()
                        var
                            MemberRec: Record Members;
                        begin
                            MemberRec.SetRange(Subflag, MemberRec.Subflag::Withdrawal);
                            PAGE.Run(PAGE::"Member List", MemberRec);
                        end;
                    }

                    field("Deceased Members"; DeceasedMembers)
                    {
                        ApplicationArea = Basic, Suite;
                        DecimalPlaces = 0 : 0;
                        Style = Favorable;
                        trigger OnDrillDown()
                        var
                            MemberRec: Record Members;
                        begin
                            MemberRec.SetRange(Status, MemberRec.status::Deceased);
                            PAGE.Run(PAGE::"Member List", MemberRec);
                        end;
                    }


                }
            }
            cuegroup("Members Portal")
            {
                cuegroup("Member Application")
                {
                    Caption = 'Members Applications List(Portal)';
                    field("Open Members Portal Applications"; Rec."Open Portal Applications")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number of open member applications from the Members Portal.';

                    }
                }
                cuegroup("Depedancy Application")
                {
                    Caption = 'Depedancy Applications List';
                    field("Open Depedancy Applications"; Rec."Open Depedancy Applications")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number of open Depedancy applications from the Members Portal.';

                    }
                }

                cuegroup("Member Edits")
                {
                    Caption = 'Member Edit Requests';
                    field("Signature Edit Requests"; Rec."Open Signature Edits")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number of open Signature Edit Requests from the Members Portal.';
                    }
                }
            }

            // cuegroup(Channels)
            // {
            //     cuegroup(CRM)
            //     {
            //         Caption = 'CRM';

            //         field("Open CRM Member Edits"; Rec."Open CRM Member Edits")
            //         {
            //             ApplicationArea = All;
            //         }
            //     }
            //     cuegroup("M-Smart")
            //     {
            //         Caption = 'M-Smart';

            //         field("Open M-Smart Member Edits"; Rec."Open M-Smart Member Edits")
            //         {
            //             ApplicationArea = All;
            //         }
            //         field("Open M-Smart Documents"; Rec."Open M-Smart Documents")
            //         {
            //             ApplicationArea = All;
            //         }
            //     }
            //}
        }
    }
    actions
    {
        area(Processing)
        {
            action("Cues SetUp")
            {
                ApplicationArea = Basic;
                Caption = 'Set up Cues';
                Image = Setup;
                ToolTip = 'Set up Cues related to the role';
                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecoredref: RecordRef;
                begin
                    CueRecoredref.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecoredref.Number);
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        MemberRec: Record Members;
    begin
        // CalculateCues();
        MemberRec.Reset();
        MemberRec.SetCurrentKey(Status);
        MemberRec.SetRange(Status, MemberRec.Status::Dormant);
        DormantMembers := MemberRec.Count();

        MemberRec.Reset();
        MemberRec.SetCurrentKey(Status);
        MemberRec.SetRange(Status, MemberRec.Status::Deceased);
        DeceasedMembers := MemberRec.Count();

        MemberRec.Reset();
        MemberRec.SetCurrentKey(Subflag);
        MemberRec.SetRange(Subflag, MemberRec.Subflag::Withdrawal);
        WithdrawnMembers := MemberRec.Count();
    end;

    // local procedure CalculateCues()
    // var
    //     CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
    // begin
    //     //rec."Members Created Today" := CustomCuesCodeunit.calculatememberscreatedtoday();
    // end;
    var
        DormantMembers: Decimal;
        DeceasedMembers: Decimal;
        WithdrawnMembers: Decimal;

}
