table 52186056 "Delegates Minutes Header"
{

    fields
    {

        field(1; "Code"; Code[50])
        {
            Editable = false;
        }
        field(2; Venue; Text[30])
        {
        }
        field(3; "Start Time"; Time)
        {
        }
        field(4; "End Time"; Time)
        {
        }
        field(5; Month; Integer)
        {
            MinValue = 1;
            MaxValue = 12;
            trigger OnValidate()
            begin
                Year := Date2DMY(Today, 3);
            end;
        }
        
        field(6; Year; Integer)
        {
            MinValue = 1900;
            MaxValue = 2050;
            trigger OnValidate()
            var
                Meetings: Record "Delegates Minutes Header";
            begin
                Meetings.Reset();
                // Meetings.SetRange(Year, Year);
                // Meetings.SetRange("Electoral Region", Rec."Electoral Region");
                // Meetings.SetFilter(Code, '<>%1', Rec.Code);
                // Meetings.SetFilter(Status, '<>%1', Rec.Status::Rejected);
                // if Meetings.FindFirst() then
                //     Dialog.Message('There is another meeting for this period for this zone that has been created');
            end;
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; "Electoral Region"; Code[50])
        {
            TableRelation = "Electoral Zones".Code;

            trigger OnValidate()
            var
                Members: Record Members;
                MeetingTypes: Record "Meeting Types";
                OfficialsOnly: Boolean;
                MemberPosition: Code[50];
                SalutationTitle: Record "Salutation Tittles";
                AllowedAllowances: Record "Allowed Allowances";
                Positions: list of [Code[100]];
                Position: Code[100];
            begin
                OfficialsOnly := false;
                "Electoral Name" := '';
                Branch := '';
                Quarter := Rec.Quarter::" ";
                Year := 0;
                Venue := '';
                "Meeting Date" := 0D;
                "Delegate Member No" := '';

                if Code = '' then begin
                    MembNoSeries.Get;
                    MembNoSeries.TestField(MembNoSeries."Delegate Minutes Nos.");
                    Code := NoSeriesMgt.GetNextNo(MembNoSeries."Delegate Minutes Nos.");
                    
                    // NoSeriesMgt.InitSeries(MembNoSeries."Delegate Minutes Nos.", xRec."No. Series", 0D, Code, "No. Series");
                    "Created By" := UserId;
                    "Created Date" := Today;
                end;

                ElectZones.reset();
                ElectZones.SetRange(Code, "Electoral Region");
                If ElectZones.FindFirst() then begin
                    "Electoral Name" := ElectZones."Electoral Zone Name";
                    Branch := ElectZones."Global Dimension 1 Code";
                end;
                DelegatesMeetingAttendees.Reset();
                DelegatesMeetingAttendees.SetRange("Header No", Rec.Code);
                if DelegatesMeetingAttendees.FindSet() then DelegatesMeetingAttendees.DeleteAll();

                if "Meeting Type" = '' then Error('Meeting type must have a value');

                MeetingTypes.Reset();
                MeetingTypes.SetRange(Code, "Meeting Type");
                if MeetingTypes.FindFirst() then begin
                    AllowedAllowances.Reset();
                    AllowedAllowances.SetRange("Meeting Type Code", MeetingTypes.Code);
                    if AllowedAllowances.Find('-') then begin
                        repeat
                            if not Positions.Contains(AllowedAllowances.Position) then
                                Positions.Add(AllowedAllowances.Position);
                        until AllowedAllowances.Next() = 0;
                    end;
                end;


                foreach Position in Positions do begin
                    DelegateOfficials.Reset();
                    DelegateOfficials.SetRange(Position, Position);
                    // if MeetingTypes.Intervals = MeetingTypes.Intervals::Quarterly then
                    //     DelegateOfficials.SetRange("Electoral Zone", "Electoral Region");
                    DelegateOfficials.SetRange(DelegateOfficials.Status, DelegateOfficials.Status::Approved);
                    DelegateOfficials.SetRange(Retired, false);
                    if DelegateOfficials.FindSet() then begin
                        repeat
                            DelegateOfficials.CalcFields("Delegate Official Name");
                            Members.Get(DelegateOfficials."Member Number");
                            DelegatesMeetingAttendees.init();
                            DelegatesMeetingAttendees."Header No" := Code;
                            DelegatesMeetingAttendees."Delegate No." := DelegateOfficials."Member Number";
                            DelegatesMeetingAttendees."Delegate Name" := DelegateOfficials."Delegate Official Name";
                            DelegatesMeetingAttendees."Delegate Position" := DelegateOfficials.Position;
                            DelegatesMeetingAttendees."Delegate Email" := Members."E-Mail";
                            DelegatesMeetingAttendees."Delegate Phone" := Members."Phone No.";
                            DelegatesMeetingAttendees.Insert(true);
                        until DelegateOfficials.Next() = 0;
                    end;
                end;



            end;
        }
        field(11; "Created By"; Code[50])
        {
        }
        field(12; "Created Date"; Date)
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; "Meeting Date Time"; DateTime)
        {
        }
        field(15; "Meeting Paid"; Boolean)
        {

        }

        field(16; "Posted By"; Code[50])
        {
        }
        field(17; "Posted Date"; DateTime)
        {
        }
        field(18; "Electoral Name"; Code[50])
        {
        }
        field(19; "Meeting Type"; Code[30])
        {
            TableRelation = "Meeting Types";

            trigger OnValidate()
            var
                Members: Record Members;
                MeetingType: Record "Meeting Types";
                AllowedAllowances: Record "Allowed Allowances";
                Positions: list of [Code[100]];
                Position: Code[100];
            begin
                Clear(Positions);
                if MeetingType.Get("Meeting Type") then begin
                    "Electoral Region" := '';
                    "Electoral Name" := '';
                    Branch := '';
                    Quarter := Quarter::" ";

                    if Code = '' then begin
                        MembNoSeries.Get;
                        MembNoSeries.TestField(MembNoSeries."Delegate Minutes Nos.");
                        Code := NoSeriesMgt.GetNextNo(MembNoSeries."Delegate Minutes Nos.");
                        // NoSeriesMgt.InitSeries(MembNoSeries."Delegate Minutes Nos.", xRec."No. Series", 0D, Code, "No. Series");
                        "Created By" := UserId;
                        "Created Date" := Today;
                    end;

                    DelegatesMeetingAttendees.Reset();
                    DelegatesMeetingAttendees.SetRange("Header No", Rec.Code);
                    if DelegatesMeetingAttendees.Find('-') then
                        DelegatesMeetingAttendees.DeleteAll();

                    AllowedAllowances.Reset();
                    AllowedAllowances.SetRange("Meeting Type Code", MeetingType.Code);
                    if AllowedAllowances.Find('-') then begin
                        repeat
                            if not Positions.Contains(AllowedAllowances.Position) then
                                Positions.Add(AllowedAllowances.Position);
                        until AllowedAllowances.Next() = 0;
                    end;

                    foreach Position in Positions do begin
                        DelegateOfficials.Reset();
                        DelegateOfficials.SetRange(Position, AllowedAllowances.Position);
                        // if MeetingType.Intervals = MeetingType.Intervals::Quarterly then
                        //     DelegateOfficials.SetRange("Electoral Zone", "Electoral Region");
                        DelegateOfficials.SetRange(DelegateOfficials.Status, DelegateOfficials.Status::Approved);
                        DelegateOfficials.SetRange(Retired, false);
                        if DelegateOfficials.Find('-') then begin
                            repeat
                                DelegateOfficials.CalcFields("Delegate Official Name");
                                Members.Get(DelegateOfficials."Member Number");

                                DelegatesMeetingAttendees.Reset();
                                DelegatesMeetingAttendees.SetRange("Header No", Rec.Code);
                                DelegatesMeetingAttendees.SetRange("Delegate No.", Members."No.");
                                if not DelegatesMeetingAttendees.FindFirst() then begin
                                    DelegatesMeetingAttendees.init();
                                    DelegatesMeetingAttendees."Header No" := Code;
                                    DelegatesMeetingAttendees."Delegate No." := DelegateOfficials."Member Number";
                                    DelegatesMeetingAttendees."Delegate Name" := DelegateOfficials."Delegate Official Name";
                                    DelegatesMeetingAttendees."Delegate Position" := DelegateOfficials.Position;
                                    DelegatesMeetingAttendees."Delegate Email" := Members."E-Mail";
                                    DelegatesMeetingAttendees."Delegate Phone" := Members."Phone No.";
                                    DelegatesMeetingAttendees.Insert(true);
                                end;
                            until DelegateOfficials.Next() = 0;
                        end;
                    end;
                end;
            end;
        }
        field(21; "Delegate Member No"; Code[30])
        {
            TableRelation = "Delegate Officials"."Member Number" where("Electoral Zone" = field("Electoral Region"), Retired = filter(false));
            trigger OnValidate()
            var
            begin
                CalcFields("Delegate Name");
            end;
        }
        field(22; "Delegate Name"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Delegate Member No")));
        }
        field(23; "Total Branch Members"; Integer)
        {
            CalcFormula = Lookup("Delegates Monthly Returns"."Total Branch Members" WHERE("Header No" = FIELD(Code),
                                                                                           "Caption Type" = CONST('TOTAL_BRANCH_MEMBERS')));
            FieldClass = FlowField;
        }
        field(24; "Meeting Venue"; Text[100])
        {
        }
        field(25; "Meeting Date"; Date)
        {
        }
        field(26; "CRM NO"; Code[20])
        {
            Editable = false;
        }
        field(29; "Quarter"; Option)
        {
            OptionMembers = " ","First Quarter","Second Quarter","Third Quarter","Fourth Quarter";
        }
        field(30; Branch; code[50])
        {

            Editable = false;
        }
        field(31; "Status"; enum "Workflow Status Main Flags")
        {

        }

        field(32; "CRM Created By"; Code[100])
        {
            Editable = false;
        }

        field(33; "CRM Originating Branch"; Code[50])
        {
            Editable = false;
        }

        field(34; "CRM Notes"; text[1000])
        {
            Editable = false;
        }

        field(35; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
            end;
        }
        field(36; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
            end;
        }
        field(37; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; code, "Electoral Name", "Electoral Name", Branch, "Delegate Name")
        {

        }
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Delegate Minutes Nos.");
            Code := NoSeriesMgt.GetNextNo(MembNoSeries."Delegate Minutes Nos.");
            // NoSeriesMgt.InitSeries(MembNoSeries."Delegate Minutes Nos.", xRec."No. Series", 0D, Code, "No. Series");
            "Created By" := UserId;
            "Created Date" := Today;
        end;

        "Created By" := UserId;

        "Created Date" := Today;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            UserSetup.TestField("Responsibility Centre");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end else
            Error('You must be set up in user setup');

        if "CRM NO" <> '' then begin
            // CRM Update API
            // CRMIntegration.CRMClaimApplicationUpdate(
            //     'Delegate Claim',
            //     "CRM NO",
            //     Format(Status),
            //     '',
            //     Format(Branch),
            //     ''
            // );
        end;
    end;

    trigger OnModify()
    var
        myInt: Integer;
        thisApp: Record "Delegates Minutes Header";
    begin
        thisApp.Reset();

        thisApp.SetFilter(Code, Code);

        if thisApp.FindFirst() then begin
            if not (thisApp.Status = Status) then begin
                if "CRM NO" <> '' then begin
                    // CRM Update API
                    // CRMIntegration.CRMClaimApplicationUpdate(
                    //     'Delegate Claim',
                    //     "CRM NO",
                    //     Format(Status),
                    //     '',
                    //     Format(Branch),
                    //     ''
                    // );
                end;
            end;
        end;
    end;

    var
        MembNoSeries: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        DelegateRegion: Record "Delegate Region";
        Err0001: Label 'You cannot make payment for a month in future.';
        DelegatesMeetingAttendees: Record "Delegates Meeting Attendees";
        StatusChangePermissions: Record "Status Change Permissions.";
        ElectZones: Record "Electoral Zones";
        DelegateOfficials: Record "Delegate Officials";
        CRMIntegration: Codeunit "CRM Integration";
        UserSetup: Record "User Setup";
}

