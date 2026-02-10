table 52185940 "SinkFund Report Information"
{
    LookupPageId = "BBF SinkFund List";
    DrilldownPageId = "BBF SinkFund List";

    fields
    {
        field(1; No; Code[20])
        {
            trigger OnValidate()
            begin
                if "No" <> xRec."No" then begin
                    SeriesSetup.Get;
                    if "Claim Type" = "Claim Type"::" " then
                        NoSeriesMgt.TestManual(SeriesSetup."Sink Fund Nos.")
                    // else if "Claim Type" = "Claim Type"::"BBF - Insurance Claim" then
                    //     NoSeriesMgt.TestManual(SeriesSetup."BBF Insurance Nos.")
                    // else
                    //     NoSeriesMgt.TestManual(SeriesSetup."BBF Report");
                    // "No. Series" := '';
                end;
            end;

        }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; "Reported By Name"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Next of KIN".Name where(Identification = field("Reported By ID No")));
        }
        field(4; "Reported By ID No"; Text[100])
        {
            TableRelation = "Next of KIN".Identification where("Record ID" = field("Member No"), Deceased = const(false),
            Removed = const(false));
            //, "Is a Beneficiary" = const(true));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                NextofKIN: Record "Next of KIN";
                RelationshipType: Record "Relationship Types";
            begin
                NextofKIN.Reset();
                NextofKIN.SetRange(Identification, "Reported By ID No");
                NextofKIN.SetRange("Record ID", Rec."Member No");
                if NextofKIN.FindFirst() then begin
                    RelationshipType.Reset();
                    RelationshipType.SetRange(Relation, NextofKIN.Relationship);
                    if RelationshipType.FindFirst() then
                        RelationshipType.TestField(Self, false);

                    "Reported By Name" := NextofKIN.Name;
                    "Reported By Relationship" := NextofKIN.Relationship;
                    "Reported By Phone No" := NextofKIN.Telephone;

                end;
            end;
        }
        field(5; "Reported By Relationship"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Next of KIN".Relationship where(Identification = field("Reported By ID No")));
        }
        field(6; "Member No"; Code[20])
        {
            TableRelation = Members."No.";//WHERE(Status = FILTER(<> Deceased));
            //Editable = false;
            trigger OnValidate()
            var
                BBFLines: Record "BBF Claim Lines";
                SinkFundRptInfo: Record "SinkFund Report Information";
                Member: Record Members;
                ErrorStatus: Label 'The status of the member is %1, and hence the application cannot be raised';
            begin
                Member.Get("Member No");
                if "Claim Type" <> "Claim Type"::"Risk Claim" then begin
                    if Member.Status = Member.Status::Deceased then
                        Error(ErrorStatus, Member.Status);
                end; /*else begin
                    Member.TestField(Subflag, Member.Subflag::"Pending Risk Claim");
                    Member.TestField(Status, Member.Status::Deceased);
                end;*/

                BBFLines.Reset();
                BBFLines.SetRange("Header No.", No);
                if BBFLines.FindSet() then BBFLines.DeleteAll();

                "Date of Death" := 0D;
                "BBF Claim Amount" := 0;
                "Reported By ID No" := '';

                if Rec."CRM Originating Branch" = '' then begin
                    "Next of KIN" := '';
                end;
                "Claim Type" := Rec."Claim Type"::" ";
                OnFillClaimType();
            end;
        }
        field(7; "Date of Death"; Date)
        {
            trigger OnValidate()
            var
                MinDateOfDeath: Date;
                Gsetup: Record "General Set-Up";
                Member: Record Members;
            begin
                if Rec."Date of Death" > Today then
                    Error('Date of death cannot be greater than today');

                Gsetup.Get;

                if Member.Get("Member No") then
                    if Member."Contribution Start Date" <> 0D then
                        if "Date of Death" < Member."Contribution Start Date" then
                            Error('The date of death cannot be less than the contribution start date');


                MinDateOfDeath := CalcDate('<-' + Format(Gsetup."BBF Max Date of Death") + '>', Today);

                if "Claim Type" <> Rec."Claim Type"::"Risk Claim" then begin
                    if MinDateOfDeath > Rec."Date of Death" then
                        Error('The minimum date of death allowed is: %1', MinDateOfDeath);
                end;

                // if "Claim Type" in [Rec."Claim Type"::"BBF - Principle Claim", Rec."Claim Type"::"BBF - Insurance Claim"] then begin
                //     BBFEntitlement.Reset();
                //     BBFEntitlement.SetFilter("Start Date", '<=%1', Rec."Date of Death");
                //     BBFEntitlement.SetFilter("End Date", '>=%1', Rec."Date of Death");
                //     BBFEntitlement.SetRange("Relationship Type", Rec.Relationship);
                //     // BBFEntitlement.SetRange("Claim Option", BBFEntitlement."Claim Option"::Member);
                //     BBFEntitlement.SetRange("Claim Type", BBFEntitlement."Claim Type"::"BBF - Principle Claim");
                //     if "Claim Type" = Rec."Claim Type"::"BBF - Insurance Claim" then
                //         BBFEntitlement.SetRange("Claim Type", BBFEntitlement."Claim Type"::"BBF - Insurance Claim");
                //     if BBFEntitlement.FindFirst() then begin
                //         Rec."BBF Claim Amount" := BBFEntitlement.Amount;
                //     end else
                //         Error('There is no BBF entitlement setup for this date of death (%2) and claim type = %1 for relationship = %3', Rec."Claim Type", Rec."Date of Death", Rec.Relationship);
                // end;

            end;
        }
        field(8; "Deceased Person"; Text[100])
        {

        }
        field(9; "Member Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No")));
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            Editable = false;
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            Editable = false;
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(12; Status; Enum "Workflow Status Main Flags")
        {
            Editable = false;
            trigger OnValidate()
            begin
                // if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Approved) then begin
                //     Comments.Reset();
                //     Comments.SetRange("Commented By", UserId);
                //     Comments.SetRange("Viewd By Somebody Else", false);
                //     Comments.SetRange("Header No.", Rec.No);
                //     if not Comments.FindFirst() then
                //         Error('Please add a comment before performing this action');
                // end;
            end;

        }
        field(13; "Responsibily Center"; Code[30])
        {
            Editable = false;
            TableRelation = "Responsibility CenterBR";
        }
        field(14; "Captured By"; Code[100])
        {
            Editable = false;
        }
        field(15; "No. Series"; Code[20])
        {
        }
        field(16; Posted; Boolean)
        {
            Editable = true;
        }
        field(17; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(300; "Time Posted"; Time)
        {
            Editable = false;
        }

        field(18; "Posted By"; Code[50])
        {
        }
        field(19; "CRM Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(119; "CRM No. Series"; Code[10])
        {

        }
        field(20; "Claim Type"; Option)
        {
            OptionMembers = " ","BBF - Dependant Claim","BBF - Principle Claim","Risk Claim","BBF - Insurance Claim";
            InitValue = " ";
            trigger OnValidate()
            var
                BBFRaised: Record "SinkFund Report Information";
                DeceasedMember: Record Members;
            begin
                // OnFillClaimType();

                // if rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then begin
                //     DeceasedMember.Reset;
                //     DeceasedMember.SetRange("No.", Rec."Member No");
                //     DeceasedMember.SetLoadFields(Status, Subflag);

                //     if DeceasedMember.FindFirst then begin
                //         if (DeceasedMember.Status <> DeceasedMember.Status::Deceased) and (DeceasedMember.Subflag <> DeceasedMember.Subflag::"Pending Risk Claim") then begin
                //             BBFRaised.Reset();
                //             BBFRaised.SetRange("Member No", Rec."Member No");
                //             BBFRaised.SetFilter(No, '<>%1', Rec.No);
                //             BBFRaised.SetRange("Claim Type", Rec."Claim Type"::"BBF - Principle Claim");
                //             if not BBFRaised.FindFirst() then
                //                 Error('This member does not have a BBF principle claim application raised, Please raise one first before proceeding');
                //         end;
                //     end;
                // end;
            end;
        }
        field(21; "Next of KIN"; Code[10])
        {
            // TableRelation = if ("Claim Type" = const("BBF - Dependant Claim"))
            TableRelation = "Next of KIN".Identification where("Record ID" = field("Member No"), Removed = const(false), Deceased = const(false));
            // else
            // "Next of KIN".Identification where("Record ID" = field("Member No"), Removed = const(false));

            trigger OnValidate()

            var
                RelationshipRec: Record "Relationship Types";
                BBFEntitlement: Record "BBF Entitlement";
                NextofKIN: Record "Next of KIN";
                SinkfundReports: Record "SinkFund Report Information";
            begin

                // NextofKIN.Reset();
                // NextofKIN.SetRange(Identification, "Next of KIN");
                // if NextofKIN.FindFirst() then begin
                //     if "Claim Type" = "Claim Type"::"BBF - Dependant Claim" then
                //         NextofKIN.TestField(Deceased, false);
                //     if "Claim Type" = "Claim Type"::"BBF - Insurance Claim" then
                //         NextofKIN.TestField("Insurance Claim Paid", false);
                // end;

                // if "Claim Type" = "Claim Type"::"BBF - Insurance Claim" then begin
                //     SinkfundReports.Reset();
                //     SinkfundReports.SetRange("Claim Type", "Claim Type"::"BBF - Dependant Claim");
                //     SinkfundReports.SetRange("Next of KIN", Rec."Next of KIN");
                //     if not SinkfundReports.FindFirst() then
                //         Error('First raise the BBF-dependant claim for this NOK beneficiary before initiating the insurance claim');
                // end;

                if "Date of Death" = 0D then
                    Error('Date of death must have a value');
                CalcFields("NOK Name", Relationship);

                // BBFEntitlement.Reset();
                // BBFEntitlement.SetRange("Relationship Type", Rec.Relationship);
                // BBFEntitlement.SetFilter("Start Date", '<=%1', Rec."Date of Death");
                // BBFEntitlement.SetRange("Claim Type", Rec."Claim Type");
                // BBFEntitlement.SetFilter("End Date", '>=%1', Rec."Date of Death");
                // if BBFEntitlement.FindFirst() then begin
                //     Rec."BBF Claim Amount" := BBFEntitlement.Amount;
                // end else
                //     Error('There is no BBF entitlement setup for this date of death (%2) and relationship = %1', Rec.Relationship, Rec."Date of Death");


                // if ("Claim Type" = Rec."Claim Type"::"BBF - Dependant Claim") or ("Claim Type" = Rec."Claim Type"::"BBF - Insurance Claim") then begin
                //     //Check if NOK Has been claimed
                //     CheckIfNOKHasBeenClaimed();
                //     //Check if Max Claim for this relationship has been reached
                //     CheckIfMaxNumberClaimed();
                // end;
            end;
        }
        field(22; "NOK Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Next of KIN".Name where(Identification = field("Next of KIN")));
        }
        field(23; "Relationship"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Next of KIN".Relationship where(Identification = field("Next of KIN")));
        }
        field(24; "BBF Claim Amount"; Decimal)
        {
            Editable = false;
        }
        field(25; "Total Savings"; Decimal)
        {
            Editable = false;
        }
        field(26; "Total Loans"; Decimal)
        {
            Editable = false;
        }
        field(27; "Net Effects"; Decimal)
        {
            Editable = false;
        }
        field(28; "Receipt Document Number"; Code[20])
        {
            Caption = 'Insurance Receipt Document Number';
            TableRelation = "Receipts Header"."No." where("Creation Doc Type" = const(Claim),
             Posted = const(true), "Member No" = field("Member No"));
            trigger OnValidate()
            var
                ReceiptsHdr: Record "Receipts Header";
                RcptLn: Record "Receipt Line";
                NextofKinPmtAlloc: Record "NextofKin Payment Allocation";
                SinkFundRptInfo: Record "SinkFund Report Information";
                ReceiptsandPmtTypes: Record "Receipts and Payment Types";
                ErrorReceiptNo: Label 'The receipt document number has already been used by sinkfund receipt %1 in the system!';
            begin
                ReceiptsHdr.Get("Receipt Document Number");
                "Receipt Amount" := 0;
                RcptLn.Reset();
                RcptLn.SetRange(No, ReceiptsHdr."No.");
                if RcptLn.FindSet() then
                    repeat
                        ReceiptsandPmtTypes.Reset();
                        ReceiptsandPmtTypes.SetRange(Code, RcptLn.Type);
                        ReceiptsandPmtTypes.SetRange(Type, ReceiptsandPmtTypes.Type::Claim);
                        if ReceiptsandPmtTypes.FindFirst() then
                            "Receipt Amount" += RcptLn.Amount;
                    until RcptLn.Next() = 0;

                SinkFundRptInfo.Reset();
                SinkFundRptInfo.SetRange("Receipt Document Number", "Receipt Document Number");
                SinkFundRptInfo.SetFilter(No, '<>%1', Rec.No);
                If SinkFundRptInfo.FindLast() then
                    Error(ErrorReceiptNo, SinkFundRptInfo.No);

                UpdateAvailableBeneficiaryAmount();

                /*NextofKinPmtAlloc.Reset();
                NextofKinPmtAlloc.SetRange("Header No.", Rec.No);
                if NextofKinPmtAlloc.FindSet() then
                    repeat
                        NextofKinPmtAlloc."Beneficiary Amount" := Round(NextofKinPmtAlloc.Allocation * 0.01 * "Available Beneficiary Amount", 0.01, '=');
                        NextofKinPmtAlloc.Modify();
                    until NextofKinPmtAlloc.Next() = 0;*/
            end;
        }
        field(29; "Receipt Amount"; Decimal)
        {
            Caption = 'Insurance Receipt Amount';
            Editable = false;
        }
        field(30; "Total Amount Allocated"; Decimal)
        {
            Caption = 'Total Amount Allocated to Loans';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("BBF Claim Lines"."Amount Allocated" where("Header No." = field(No)));
        }
        field(31; "Available Beneficiary Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Partially Posted"; Boolean)
        {
            Editable = false;
        }
        field(33; "No. Next of Kin Payments"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("NextofKin Payment Allocation" where("Header No." = field(No), "Pay Next of Kin Account" = const(true)));
        }
        field(34; "No. Next of Kin Accounts"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("NextofKin Payment Allocation" where("Header No." = field(No)));
        }
        field(35; "No. Next of Kin Paid Accounts"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("NextofKin Payment Allocation" where("Header No." = field(No), "Next of Kin Account Paid" = const(true)));
        }
        field(36; "Document Stage"; Option)
        {
            Editable = false;
            OptionMembers = " ","Account Closed",Posted,"Partially Posted","Pending Nominee Payment","Externally Paid";
        }
        field(37; "Account Closure Date"; Date)
        {
            Editable = false;
        }
        field(38; "Next of Kin Paid Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("NextofKin Payment Allocation"."Beneficiary Amount" where("Header No." = field(No), "Next of Kin Account Paid" = const(true)));
        }
        field(39; "Next of Kin Remaining Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("NextofKin Payment Allocation"."Beneficiary Amount" where("Header No." = field(No), "Next of Kin Account Paid" = const(false)));
        }
        field(40; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            ValuesAllowed = "G/L Account", Vendor;
        }
        field(41; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            WHERE("Account Type" = CONST(Posting), Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor;

        }
        field(42; "Pay Externally"; Boolean)
        {
            trigger OnValidate()
            var
                RiskExternalPmt: Record "Risk External Payment";
                HasExternalPayments: Boolean;
            begin
                RiskExternalPmt.Reset();
                RiskExternalPmt.SetRange("Risk Claim No.", Rec.No);
                HasExternalPayments := RiskExternalPmt.FindFirst();

                if not Rec."Pay Externally" then
                    if HasExternalPayments then
                        if not Confirm('This claim has external payments already, All Lines will be deleted, Do you want to continue?') then
                            RiskExternalPmt.DeleteAll();
            end;
        }
        field(43; "BOSA Loans"; Decimal)
        {
            Editable = false;
        }
        field(44; "FOSA Loans"; Decimal)
        {
            Editable = false;
        }
        field(45; "Business Loans"; Decimal)
        {
            Editable = false;
        }
        field(46; "HR Loans"; Decimal)
        {
            Editable = false;
        }
        field(47; "BOSA Savings"; Decimal)
        {
            Editable = false;
        }
        field(48; "FOSA Savings"; Decimal)
        {
            Editable = false;
        }
        field(49; "Account Closure Fee"; Decimal)
        {
            Editable = false;
        }
        field(50; "Reported By Phone No"; Code[20])
        {
        }
        field(51; "External Amount Allocated"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Risk External Payment".Amount where("Risk Claim No." = field(No)));
        }
        // CRM Details
        field(601; "CRM Created By"; Code[100])
        {
            Editable = false;
        }

        field(602; "CRM Originating Branch"; Code[50])
        {
            Editable = false;
        }

        field(603; "CRM Notes"; text[1000])
        {
            Editable = false;
        }
        field(604; "Burial Permit Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(605; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(606; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(607; "Current Department"; Code[50])
        {
            Editable = false;
        }
        field(608; "Sent Back to CRM"; Boolean)
        {
            Editable = False;
        }
        field(609; "Member Status"; Enum "Member Status")
        {
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Status where("No." = Field("Member No")));
        }
        field(610; "Primary Identification"; Code[20])
        {
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification" where("No." = Field("Member No")));
        }

        field(1000; "CRM Payload"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(1001; "Approved By"; Code[100])
        {
        }
        field(1002; "Approval Date"; Date)
        {
        }
        field(301; "Application Time"; time)
        {
        }
        field(1010; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No")));
        }
        field(1011; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No")));
        }
        field(1012; "Notice Type"; Option)
        {
            OptionMembers = "Principal Member","Next of Kin";
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, "Member No", "Member Name", "Claim Type")
        {

        }
    }



    trigger OnDelete()
    begin
        Error('Deletion is not allowed!');

    end;

    var
        Sharecaps: Record "Share Capital Transfer Buffer";
        ShaCount: Integer;

    trigger OnInsert()
    var
        theSMS: Text;
        theMember: Record Members;
        GFunc: Codeunit "Global Functions";
        SubModule: Enum "Sub Module";
        DepartMent: Enum "Responsibility Center Enum";
    begin
        // BBFRequisationHeader2.Reset;
        // BBFRequisationHeader2.SetRange(Status, BBFRequisationHeader2.Status::Open);
        // BBFRequisationHeader2.SetFilter("Member No", '=%1', '');
        // BBFRequisationHeader2.SetRange("Captured By", UserId);
        // if BBFRequisationHeader2.Find('-') then begin
        //     if BBFRequisationHeader2.Count > 2 then
        //         Error('Kindly use the open document first for you to create a new one');
        // end;

        NextofKIN.Reset();
        NextofKIN.SetRange("Record ID", Rec."Member No");
        NextofKIN.SetRange(Removed, false);
        if not NextofKIN.FindFirst() then
            if (Rec."Claim Type" = Rec."Claim Type"::"BBF - Dependant Claim") or (Rec."Claim Type" = Rec."Claim Type"::"BBF - Insurance Claim") then
                Message('Member does not have next of kin details');

        BBFRequisationHeader2.Reset;
        BBFRequisationHeader2.SetRange("Member No", Rec."Member No");
        BBFRequisationHeader2.SetFilter(No, '<>%1', Rec.No);
        BBFRequisationHeader2.SetRange("Claim Type", Rec."Claim Type");
        BBFRequisationHeader2.SetFilter(Status, '=%1|=%2', BBFRequisationHeader2.Status::Open, BBFRequisationHeader2.Status::Pending);
        if BBFRequisationHeader2.FindFirst then begin
            Error('This member already has an ongoing BBF claim application of No = %1 at status %2', BBFRequisationHeader2.No, BBFRequisationHeader2.Status);
        end;

        BBFRequisationHeader2.Reset;
        BBFRequisationHeader2.SetRange("Burial Permit Number", Rec."Burial Permit Number");
        if BBFRequisationHeader2.FindFirst then begin
            //   Error('The death certificate / burial permit number already exists in the system');
        end;

        if No = '' then begin
            SeriesSetup.Get;
            // if "Claim Type" = "Claim Type"::" " then
            SeriesSetup.TestField(SeriesSetup."Sink Fund Nos.");
            // else if "Claim Type" = "Claim Type"::"BBF - Insurance Claim" then
            //     SeriesSetup.TestField(SeriesSetup."BBF Insurance Nos.")
            // else
            //     SeriesSetup.TestField(SeriesSetup."BBF Report");

            // if "Claim Type" = "Claim Type"::"Risk Claim" then
            NoSeriesMgt.InitSeries(SeriesSetup."Sink Fund Nos.", SeriesSetup."Sink Fund Nos.", 0D, No, "No. Series")
            // else if "Claim Type" = "Claim Type"::"BBF - Insurance Claim" then
            //     NoSeriesMgt.InitSeries(SeriesSetup."BBF Insurance Nos.", SeriesSetup."BBF Insurance Nos.", 0D, No, "No. Series")
            // else
            //     NoSeriesMgt.InitSeries(SeriesSetup."BBF Report", SeriesSetup."BBF Report", 0D, No, "No. Series");

        end;
        if UserSetup.Get(UserId) then begin
            "Responsibily Center" := UserSetup."Responsibility Centre";
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            if "Global Dimension 2 Code" = '' then begin
                "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            end;

            UserSetup.TestField("Responsibility Centre");
            if "Originating Department" = '' then begin
                "Originating Department" := UserSetup."Responsibility Centre";
            end;
            if "Current Department" = '' then begin
                "Current Department" := UserSetup."Responsibility Centre";
            end;

            if "CRM Created By" <> '' then begin
                CFPage.InsertTracker(No, "Current Department", true, "CRM Created By", CurrentDateTime);
            end else begin
                CFPage.InsertTracker(No, "Current Department", true, UserId, CurrentDateTime);
            end;
        end;

        if "CRM Created By" <> '' then begin
            "Captured By" := "CRM Created By";
        end else begin
            "Captured By" := UserId;
        end;
        Date := Today;
        "Application Time" := Time;

        // Sharecaps.Reset();
        // Sharecaps.SetRange(Sharecaps."Source Member No", Rec."Member No");
        // Sharecaps.SetFilter(Status, '%1|%2', Sharecaps.Status::Open, Sharecaps.status::Pending);
        // if Sharecaps.FindFirst() then begin
        //     ShaCount := Sharecaps.Count;
        //     if ShaCount > 0 then
        //         Error('Member has a share capital transfer of card no. %1 in progress', Sharecaps."Document No");
        // end;

        // SMS to applicant
        // if "Claim Type" = "Claim Type"::"BBF - Dependant Claim" then begin
        //     theMember.Reset;
        //     theMember.SetRange("No.", Rec."Member No");

        //     if theMember.FindFirst then begin
        //         theSMS := 'Dear member, your BBF dependant claim request has been received successfully and is being processed. REF ' + No;

        //         SkySMS.SendSms(
        //             SMSSource::CRM,
        //             theMember."Phone No.",
        //             theSMS,
        //             CreateGuid(),
        //             '',
        //             false,
        //             0,
        //             false,
        //             'CBS',
        //             "No",
        //             'CBS'
        //         );

        //         // EMAIL 
        //         SkySendEmail.QueueOutgoingEmail(
        //             theMember."E-Mail",
        //             'Member Claim Application',
        //             theSMS,
        //             'TEXT',
        //             'BBF APPLICATION',
        //             'CRM'
        //         );
        //     end;
        // end;

        // Assignment of users
        // if Rec."Global Dimension 2 Code" = 'FINANCE' then begin
        //     // Digit custodian assignment
        //     GFunc.AssignDigitCustodianTask(Rec.No, Rec."Member No", SubModule::"BBF Claims");
        // end else begin
        //     GFunc.AssignUserTasks(DepartMent::FOSA, SubModule::"BBF Claims", Rec.No);
        // end;
    end;

    trigger OnModify()
    var
        thisApp: Record "SinkFund Report Information";

        theSMS: Text;
        theMember: Record Members;
    begin
        thisApp.Reset();

        thisApp.SetFilter("No", "No");
        Rec.TestField("Sent Back to CRM", false);

        if thisApp.FindFirst() then begin
            IF not (thisApp.Status = Status) then begin
                if "CRM Application No." <> '' then begin
                    // CRM API
                    // CRMIntegration.CRMClaimApplicationUpdate(
                    //     'BBF Claim',
                    //     "CRM Application No.",
                    //     Format(Status),
                    //     'Status update: ' + Format(Status),
                    //     "Global Dimension 1 Code",
                    //     ''
                    // );
                end;

                // SMS to applicant
                // if "Claim Type" = "Claim Type"::"BBF - Dependant Claim" then begin
                //     case Status of
                //         Status::Approved:
                //             begin
                //                 theSMS := 'Dear member, your BBF dependant claim request has been approved. REF ' + "No";
                //             end;
                //         Status::Rejected:
                //             begin
                //                 theSMS := 'Dear member, your BBF dependant claim request has been rejected. REF ' + "No";
                //             end;
                //     end;

                //     theMember.Reset;
                //     theMember.SetRange("No.", Rec."Member No");

                //     if theMember.FindFirst then begin
                //         if theSMS <> '' then begin
                //             SkySMS.SendSms(
                //                 SMSSource::CRM,
                //                 theMember."Phone No.",
                //                 theSMS,
                //                 CreateGuid(),
                //                 '',
                //                 false,
                //                 0,
                //                 false,
                //                 'CBS',
                //                 "No",
                //                 'CBS'
                //             );


                //             // EMAIL 
                //             SkySendEmail.QueueOutgoingEmail(
                //                 theMember."E-Mail",
                //                 'Member Claim Application',
                //                 theSMS,
                //                 'TEXT',
                //                 'BBF APPLICATION',
                //                 'CRM'
                //             );
                //         end;
                //     end;
                // end;

                if Status = Status::Approved then begin
                    "Approved By" := UserId;
                    "Approval Date" := Today;
                end;

            end;

            IF not (thisApp.Posted = Posted) then begin
                if Posted then begin
                    "Posted By" := UserId;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                end;
            end;
        end;
    end;


    trigger OnRename()
    begin
        //if Status <> Status::Open then
        //  Error('Status must be Open');
    end;


    var
        SkySMS: CodeUnit SendSms;
        SkySendEmail: CodeUnit "Sky Send Email";
        SMSSource: enum "SMS Source";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        Members: Record Members;
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        BBFRequisationHeader2: Record "SinkFund Report Information";
        Counts: Integer;
        BBFRequisationHeader: Record "SinkFund Report Information";
        ImageData: Record "Image Data";
        NextofKIN: Record "Next of KIN";
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        BBFEntitlement: Record "BBF Entitlement";
        Err0001: Label 'Member does not have next of kin details';
        SendSMS: Codeunit SendSms;
        CompanyInformation: Record "Company Information";
        Mem: Record Members;
        msg: Text;
        Source: Enum "SMS Source";
        CRMIntegration: Codeunit "CRM Integration";


    procedure OnFillClaimType()
    var
        BBFLines: Record "BBF Claim Lines";
        SinkReport: Record "SinkFund Report Information";
        SinkFundRptInfo: Record "SinkFund Report Information";
        ProductFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        NextofKinPmtAlloc: Record "NextofKin Payment Allocation";
        NextofKIN: Record "Next of KIN";
        GenSetup: Record "General Set-Up";
        i: Integer;
        ErrorSinkFund: Label 'The member has an existing %1 application no %2';
    begin
        Rec.TestField("Member No");
        // GenSetup.Get();
        // GenSetup.TestField("Risk Account Closure Fee");
        // "Account Closure Fee" := GetTransactionCharge(GenSetup."Risk Account Closure Fee", 0);
        // "Account Closure Fee" += ("Account Closure Fee" * GenSetup."Excise Duty (%)" * 0.01);

        BBFLines.Reset();
        BBFLines.SetRange("Header No.", No);
        if BBFLines.FindFirst() then
            BBFLines.DeleteAll();

        SinkFundRptInfo.Reset();
        SinkFundRptInfo.SetRange("Member No", Rec."Member No");
        SinkFundRptInfo.SetFilter(No, '<>%1', Rec.No);
        //SinkFundRptInfo.SetRange("Claim Type", Rec."Claim Type"::"Risk Claim");
        SinkFundRptInfo.SetRange("Sent Back to CRM", false);
        if SinkFundRptInfo.FindFirst() then
            Error(ErrorSinkFund, SinkFundRptInfo."Claim Type", SinkFundRptInfo.No);

        NextofKinPmtAlloc.Reset();
        NextofKinPmtAlloc.SetRange("Header No.", No);
        if NextofKinPmtAlloc.FindFirst() then
            NextofKinPmtAlloc.DeleteAll();

        // "Date of Death" := 0D;
        // "BBF Claim Amout" := 0;
        // "Reported By ID No" := '';

        // "Next of KIN" := '';
        "Total Savings" := 0;
        "Total Loans" := 0;
        "BOSA Loans" := 0;
        "FOSA Loans" := 0;
        "Business Loans" := 0;
        "HR Loans" := 0;
        "BOSA Savings" := 0;
        "FOSA Savings" := 0;
        "Net Effects" := 0;

        //if "Claim Type" = Rec."Claim Type"::"Risk Claim" then begin
        SinkReport.Reset();
        SinkReport.SetRange("Member No", Rec."Member No");
        SinkReport.SetRange("Claim Type", Rec."Claim Type"::"BBF - Principle Claim");
        if SinkReport.FindFirst() then
            "Date of Death" := SinkReport."Date of Death";

        Loans.Reset();
        Loans.SetFilter("Total Loan Balance", '>0');
        Loans.SetRange("Member No.", Rec."Member No");
        if Loans.FindSet() then begin
            repeat
                Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                if (Loans."Outstanding Balance" > 0) or (Loans."Outstanding Interest" > 0) then begin
                    if Loans."Outstanding Interest" < 0 then loans."Outstanding Interest" := 0;
                    BBFLines.Init();
                    BBFLines."Header No." := No;
                    BBFLines."Product Code" := Loans."Loan Product Type";
                    BBFLines."Outstanding Interest" := Loans."Outstanding Interest";
                    BBFLines."Outstanding Balance" := Loans."Outstanding Balance";
                    BBFLines."Total Balance" := Loans."Outstanding Balance" + Loans."Outstanding Interest";
                    BBFLines."Amount Allocated" := 0;
                    BBFLines."Product Class Type" := BBFLines."Product Class Type"::Loan;
                    BBFLines."Account No" := Loans."Loan Account";
                    BBFLines."Loan No." := Loans."Loan No.";
                    BBFLines."Amount Allocated" := BBFLines."Total Balance";
                    BBFLines.Insert();
                    case Loans."Source Unit" of
                        Loans."Source Unit"::BOSA:
                            "BOSA Loans" += BBFLines."Total Balance";
                        Loans."Source Unit"::FOSA:
                            "FOSA Loans" += BBFLines."Total Balance";
                        Loans."Source Unit"::"BUSINESS LOANS":
                            "Business Loans" += BBFLines."Total Balance";
                        Loans."Source Unit"::"HR LOANS":
                            "HR Loans" += BBFLines."Total Balance";
                    end;
                    "Total Loans" += BBFLines."Total Balance";
                end;
            until Loans.Next() = 0;
        end;

        ProductFactory.Reset();
        ProductFactory.SetRange("Exclude From Closure", false);
        ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Savings);
        ProductFactory.SetFilter("Product Category", '<>%1&<>%2', ProductFactory."Product Category"::"Share Capital", ProductFactory."Product Category"::"Transfered Share Capital");
        if ProductFactory.FindSet() then begin
            repeat
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Member No.", Rec."Member No");
                SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
                if SavingsAccounts.FindFirst() then begin
                    if SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") > 0 then begin
                        BBFLines.Init();
                        BBFLines."Header No." := No;
                        BBFLines."Product Code" := ProductFactory."Product ID";
                        BBFLines."Outstanding Interest" := 0;
                        BBFLines."Outstanding Balance" := 0;
                        BBFLines."Total Balance" := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
                        BBFLines."Amount Allocated" := 0;
                        BBFLines."Product Class Type" := ProductFactory."Product Class Type";
                        BBFLines."Account No" := SavingsAccounts."No.";
                        BBFLines."Loan No." := '';
                        BBFLines.Insert();
                        "Total Savings" += BBFLines."Total Balance";
                        case SavingsAccounts."Source Unit" of
                            SavingsAccounts."Source Unit"::BOSA:
                                "BOSA Savings" += BBFLines."Total Balance";
                            SavingsAccounts."Source Unit"::FOSA:
                                "FOSA Savings" += BBFLines."Total Balance";
                        end;
                    end;
                end;
            until ProductFactory.Next() = 0;
        end;

        "Net Effects" := "Total Savings" - "Total Loans";
        CalcFields("Total Amount Allocated");
        "Available Beneficiary Amount" := ("Receipt Amount" + "Total Savings") - "Total Amount Allocated" - "Account Closure Fee";

        //if "Claim Type" = Rec."Claim Type"::"Risk Claim" then begin
        i := 0;
        NextofKIN.Reset();
        NextofKIN.SetRange("Record ID", "Member No");
        NextofKIN.SetRange("Is Nominee", true);
        NextofKIN.SetRange(Removed, false);
        if NextofKIN.FindSet() then
            repeat
                i += 10;
                NextofKinPmtAlloc.Init();
                NextofKinPmtAlloc."Header No." := Rec.No;
                NextofKinPmtAlloc."Principal Member No." := NextofKIN."Record ID";
                NextofKinPmtAlloc.Relationship := NextofKIN.Relationship;
                NextofKinPmtAlloc."Line No." := i;
                NextofKinPmtAlloc.Allocation := NextofKIN.Allocation;
                NextofKinPmtAlloc."Identification Type" := NextofKIN."Identification Type";
                NextofKinPmtAlloc.Identification := NextofKIN.Identification;
                NextofKinPmtAlloc.Name := NextofKIN.Name;
                NextofKinPmtAlloc."Date of Birth" := NextofKIN."Date of Birth";
                NextofKinPmtAlloc.Email := NextofKIN.Email;
                NextofKinPmtAlloc."Beneficiary Amount" := Round(NextofKIN.Allocation * 0.01 * "Available Beneficiary Amount", 0.01, '=');
                NextofKinPmtAlloc.Insert();

            until NextofKIN.Next() = 0;
    end;// else
        //    Error('Member does not have any nominee details');

    //end;
    //end;


    procedure PostClaim() SuccessfullyPosted: Boolean
    var
        BankLed: Record "Cust. Ledger Entry";
        GenSetup: Record "General Set-Up";
        SaccoTrans: Codeunit "Sacco Transactions";
        DocNo: Code[50];
        PDate: Date;
        AccountType: Enum "Gen. Journal Account Type";
        TransAmt: Decimal;
        Description: Text[100];
        FOSAAccnt: Code[30];
        Dim1: Code[10];
        Dim2: Code[10];
        BalAccountType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        SystemCreated: Boolean;
        BBFLines: Record "BBF Claim Lines";
        Loan: Record Loans;
        OutInt: Decimal;
        OutBal: Decimal;
        CreditAccount: Record "Credit Accounts";
        NextofKinPmtAlloc: Record "NextofKin Payment Allocation";
        ErrorFosaAcc: Label 'The fosa account has not been found!';
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        SavingsAccount: Record "Savings Accounts";
        SavingsLedgEntry: Record "Savings Ledger Entry";
        JTemplate: Code[10];
        JBatch: Code[10];
        IsPartialPosting: Boolean;
        NetAmtToVendor: Decimal;
        RiskExternalPmt: Record "Risk External Payment";
        ClosureFee: Decimal;
        GlobalFunc: Codeunit "Global Functions";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        ChargeAmountExciseDuty: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        ExtDocNo: Code[50];
    begin
        GenSetup.Get();
        Temp.Get(UserId);

        JTemplate := Temp."Receipt Journal Template";
        JBatch := Temp."Receipt Journal Batch";

        Rec.CalcFields("No. Next of Kin Accounts", "No. Next of Kin Payments", "No. Next of Kin Paid Accounts");
        IsPartialPosting := ("No. Next of Kin Accounts" > "No. Next of Kin Payments") or Rec."Partially Posted";

        if JTemplate = '' then begin
            Error('Ensure the Receipt Journal Template is set up in Cash Office User Setup');
        end;
        if JBatch = '' then begin
            Error('Ensure the receipt Journal Batch is set up in Cash Office  User Setup')
        end;
        Members.Get(Rec."Member No");

        if not IsPartialPosting then begin
            SavingsLedgEntry.Reset();
            SavingsLedgEntry.SetRange("Member No.", Members."No.");
            SavingsLedgEntry.SetRange("Document No.", No);
            SavingsLedgEntry.SetRange(Reversed, false);
            if SavingsLedgEntry.FindFirst() then begin
                Rec.Posted := true;
                Rec."Posted By" := UserId;
                Rec."Date Posted" := Today;
                Rec."Time Posted" := Time;
                Rec.Modify(true);
                if (Rec."Claim Type" = Rec."Claim Type"::"BBF - Principle Claim") then begin
                    Members.Subflag := Members.Subflag::"Pending Risk Claim";
                    Members.Status := Members.Status::Deceased;
                    Members.Modify();
                end;
                if (Rec."Claim Type" = Rec."Claim Type"::"Risk Claim") then begin
                    if not IsPartialPosting then begin
                        Members.Subflag := Members.Subflag::"Pending Share Capital Transfer";
                        Members.Status := Members.Status::Deceased;
                        Members.Modify();
                    end;
                end;
                exit;
                Message('Document already posted!');
            end;
        end;

        SaccoTrans.InitJournal(JTemplate, JBatch);
        DocNo := Rec.No;
        PDate := Today;
        TransAmt := 0;
        SystemCreated := true;
        Dim1 := Rec."Global Dimension 1 Code";
        Dim2 := Rec."Global Dimension 2 Code";

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", Rec."Member No");
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"FOSA Account");
        if SavingsAccount.FindFirst() then begin
            FOSAAccnt := SavingsAccount."No.";
            if SavingsAccount.Blocked <> SavingsAccount.Blocked::" " then begin
                SavingsAccount."Blocked Buffer" := SavingsAccount.Blocked;
                SavingsAccount.Blocked := SavingsAccount.Blocked::" ";
                SavingsAccount.Modify();
            end;
        end;

        if FOSAAccnt = '' then Error(ErrorFosaAcc);

        if Rec."Claim Type" <> Rec."Claim Type"::"Risk Claim" then begin


            TransAmt := Rec."BBF Claim Amount";

            Description := Rec.No + ' BBF Claim For.: ' + Rec."NOK Name";
            if Rec."Claim Type" = Rec."Claim Type"::"BBF - Principle Claim" then
                Description := Rec.No + ' BBF Claim For.: ' + Members."No.";
            GenSetup.TestField("Benevolent Claim Account");

            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, FOSAAccnt, CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                            GenSetup."Benevolent Claim Account", -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

            // Charges for the rest of the claim types : bbf, etc.
            TChargeAmount := 0;
            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", GenSetup."Sink Fund Process Charge");
            if TransactionCharges.Find('-') then begin
                repeat

                    TransactionCharges.TestField("G/L Account");

                    ChargeAmount := 0;
                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                    (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin

                        if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                            ChargeAmount := (0 * TransactionCharges."Percentage of Amount") * 0.01
                        else
                            ChargeAmount := TransactionCharges."Charge Amount";

                        if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            if TariffDetails.Find('-') then begin
                                repeat
                                    if (0 >= TariffDetails."Lower Limit") and (0 <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            ChargeAmount := 0 * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            ChargeAmount := TariffDetails."Charge Amount";
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::"G/L Account", TransactionCharges."G/L Account", CopyStr(TransactionCharges.Description, 1, 50), BalAccountType::"G/L Account",
                                                '', -ChargeAmount, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, FOSAAccnt, CopyStr(TransactionCharges.Description, 1, 50), BalAccountType::"G/L Account",
                                                '', ChargeAmount, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);

                        if TransactionCharges."Recover Excise Duty" then begin
                            GenSetup.TestField("Excise Duty (%)");
                            GenSetup.TestField("Excise Duty G/L");
                            ChargeAmountExciseDuty := ChargeAmount * GenSetup."Excise Duty (%)" * 0.01;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, FOSAAccnt, CopyStr(TransactionCharges.Description + ' Excise Duty', 1, 50), BalAccountType::"G/L Account",
                                               '', ChargeAmountExciseDuty, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::"G/L Account", GenSetup."Excise Duty G/L", CopyStr(TransactionCharges.Description + ' Excise Duty', 1, 50), BalAccountType::"G/L Account",
                                                '', -ChargeAmountExciseDuty, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);

                        end;

                        // TChargeAmount += (ChargeAmount + ChargeAmountExciseDuty);

                    end;
                until TransactionCharges.Next = 0;
            end;

        end;

        if Rec."Claim Type" = Rec."Claim Type"::"Risk Claim" then begin

            if not Rec."Partially Posted" and (Rec."Document Stage" = Rec."Document Stage"::" ") then begin

                GenSetup.TestField("Risk Claim G\L");
                GenSetup.TestField("Risk Vendor Payable Acc.");
                NetAmtToVendor := 0;

                if Rec."Receipt Amount" > 0 then begin
                    TransAmt := 0;
                    TransAmt := Rec."Receipt Amount";
                    Description := Rec.No + ' Insurance Risk Claim For.: ' + Members."No.";

                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::"G/L Account", GenSetup."Risk Claim G\L", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                '', TransAmt, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);
                    NetAmtToVendor += TransAmt;
                end;

                BBFLines.Reset();
                BBFLines.SetRange("Header No.", Rec.No);
                BBFLines.SetRange("Product Class Type", BBFLines."Product Class Type"::Savings);
                // BBFLines.SetFilter("Product Category", '<>%1', BBFLines."Product Category"::"FOSA Account");
                if BBFLines.FindSet() then begin
                    repeat
                        TransAmt := 0;
                        TransAmt := BBFLines."Total Balance";
                        Description := Rec.No + ' Risk Account Transfer.: ' + Members."No.";

                        SavingsAccount.Get(BBFLines."Account No");
                        if SavingsAccount.Blocked <> SavingsAccount.Blocked::" " then begin
                            SavingsAccount."Blocked Buffer" := SavingsAccount.Blocked;
                            SavingsAccount.Blocked := SavingsAccount.Blocked::" ";
                            SavingsAccount.Modify();
                        end;

                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, BBFLines."Account No", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                    '', TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);
                        NetAmtToVendor += TransAmt;

                    // SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Vendor, GenSetup."Risk Vendor Payable Acc.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                    //                           '', -TransAmt, DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                    until BBFLines.Next() = 0;
                end;

                TChargeAmount := 0;
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", GenSetup."Risk Account Closure Fee");
                if TransactionCharges.Find('-') then begin
                    repeat

                        TransactionCharges.TestField("G/L Account");

                        ChargeAmount := 0;
                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                        (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin

                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                                ChargeAmount := (0 * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.Find('-') then begin
                                    repeat
                                        if (0 >= TariffDetails."Lower Limit") and (0 <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := 0 * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::"G/L Account", TransactionCharges."G/L Account", CopyStr(TransactionCharges.Description, 1, 50), BalAccountType::"G/L Account",
                                                    '', -ChargeAmount, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);

                            if TransactionCharges."Recover Excise Duty" then begin
                                GenSetup.TestField("Excise Duty (%)");
                                GenSetup.TestField("Excise Duty G/L");
                                ChargeAmountExciseDuty := ChargeAmount * GenSetup."Excise Duty (%)" * 0.01;
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::"G/L Account", GenSetup."Excise Duty G/L", CopyStr(TransactionCharges.Description + ' Excise Duty', 1, 50), BalAccountType::"G/L Account",
                                                    '', -ChargeAmountExciseDuty, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);

                            end;

                            TChargeAmount += (ChargeAmount + ChargeAmountExciseDuty);

                        end;
                    until TransactionCharges.Next = 0;
                end;

                NetAmtToVendor -= TChargeAmount;

                if NetAmtToVendor > 0 then begin
                    Description := Rec.No + ' Insurance Risk Claim For.: ' + Members."No.";
                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Vendor, GenSetup."Risk Vendor Payable Acc.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                '', -NetAmtToVendor, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);
                end;

                BBFLines.Reset();
                BBFLines.SetRange("Header No.", Rec.No);
                BBFLines.SetRange("Product Class Type", BBFLines."Product Class Type"::Loan);
                BBFLines.SetFilter("Amount Allocated", '>0');
                if BBFLines.FindSet() then begin
                    repeat
                        TransAmt := 0;
                        TransAmt := BBFLines."Amount Allocated";
                        Loan.Get(BBFLines."Loan No.");
                        Loan.CalcFields("Outstanding Balance", "Outstanding Interest");

                        OutBal := Loan."Outstanding Balance";
                        If OutBal > BBFLines."Amount Allocated" then
                            OutBal := BBFLines."Amount Allocated";

                        OutInt := BBFLines."Amount Allocated" - OutBal;
                        if OutInt > Loan."Outstanding Interest" then
                            OutInt := Loan."Outstanding Interest";
                        if OutInt < 0 then OutInt := 0;

                        Description := Rec.No + ' Risk Loan Payment.: ' + Members."No.";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Vendor, GenSetup."Risk Vendor Payable Acc.", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                    '', OutBal + OutInt, Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);

                        Description := Rec.No + ' Risk Principal Payment.: ' + Members."No.";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, BBFLines."Account No", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                    '', -OutBal, DocNo, Loan."Loan No.", TransType::Repayment, Dim1, Dim2, SystemCreated);

                        Description := Rec.No + ' Risk Interest Payment.: ' + Members."No.";
                        SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Credit, BBFLines."Account No", CopyStr(Description, 1, 50), BalAccountType::"G/L Account",
                                                  '', -OutInt, DocNo, Loan."Loan No.", TransType::"Interest Paid", Dim1, Dim2, SystemCreated);
                    until BBFLines.Next() = 0;
                end;
            end;

            if Rec."Document Stage" = Rec."Document Stage"::"Account Closed" then begin
                if not Rec."Pay Externally" then begin

                    NextofKinPmtAlloc.Reset();
                    NextofKinPmtAlloc.SetRange("Header No.", Rec.No);
                    NextofKinPmtAlloc.SetFilter("Beneficiary Amount", '>0');
                    NextofKinPmtAlloc.SetFilter("Disbursement Account", '<>%1', '');
                    NextofKinPmtAlloc.SetRange("Pay Next of Kin Account", true);
                    NextofKinPmtAlloc.SetRange("Next of Kin Account Paid", false);
                    if NextofKinPmtAlloc.FindSet() then begin
                        repeat
                            SavingsLedgEntry.Reset();
                            SavingsLedgEntry.SetRange(SavingsLedgEntry."Customer No.", NextofKinPmtAlloc."Disbursement Account");
                            SavingsLedgEntry.SetRange("Document No.", No);
                            SavingsLedgEntry.SetRange(Reversed, false);
                            if not SavingsLedgEntry.FindFirst() then begin
                                Description := Rec.No + ' Next of Kin Transfer.: ' + Members."No.";
                                if Rec."Partially Posted" then
                                    PDate := Today;

                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Vendor, GenSetup."Risk Vendor Payable Acc.", CopyStr(Description, 1, 100), BalAccountType::"G/L Account",
                                                            '', NextofKinPmtAlloc."Beneficiary Amount", Members."No.", '', TransType::" ", Dim1, Dim2, SystemCreated);
                                SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Savings, NextofKinPmtAlloc."Disbursement Account", CopyStr(Description, 1, 100), BalAccountType::"G/L Account",
                                                            '', -NextofKinPmtAlloc."Beneficiary Amount", DocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);

                                NextofKinPmtAlloc."Next of Kin Account Paid" := true;
                                NextofKinPmtAlloc."DateTime Paid" := CurrentDateTime;
                                NextofKinPmtAlloc.Modify();
                            end else begin
                                NextofKinPmtAlloc."Next of Kin Account Paid" := true;
                                NextofKinPmtAlloc.Modify();
                            end;
                        until NextofKinPmtAlloc.Next() = 0;
                    end
                    else
                        Error('No Next of Kin Account, has been selected to pay!');
                end else begin

                    GenSetup.Get();
                    GenSetup.TestField("Risk Vendor Payable Acc.");

                    RiskExternalPmt.Reset();
                    RiskExternalPmt.SetRange("Risk Claim No.", Rec.No);
                    if RiskExternalPmt.FindSet() then
                        repeat
                            Description := CopyStr(Rec.No + ' ' + RiskExternalPmt.Description + ' ' + Members."No.", 1, 50);
                            if RiskExternalPmt."Cheque No." <> '' then
                                ExtDocNo := RiskExternalPmt."Cheque No."
                            else
                                ExtDocNo := DocNo;

                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType::Vendor, GenSetup."Risk Vendor Payable Acc.", CopyStr(Description, 1, 100), BalAccountType::"G/L Account",
                                                                '', RiskExternalPmt.Amount, ExtDocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);
                            // case RiskExternalPmt."Account Type" of
                            //     RiskExternalPmt."Account Type"::"G/L Account":
                            //         AccountType := AccountType::"G/L Account";
                            //     RiskExternalPmt."Account Type"::Customer:
                            //         AccountType := AccountType::Customer;
                            //     RiskExternalPmt."Account Type"::Vendor:
                            //         AccountType := AccountType::Vendor;
                            // end;
                            AccountType := RiskExternalPmt."Account Type";
                            SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AccountType, RiskExternalPmt."Account No.", CopyStr(Description, 1, 100), BalAccountType::"G/L Account",
                                                '', -RiskExternalPmt.Amount, ExtDocNo, '', TransType::" ", Dim1, Dim2, SystemCreated);
                        until RiskExternalPmt.Next() = 0;
                end;
            end;
        end;



        SuccessfullyPosted := SaccoTrans.PostJournal(JTemplate, JBatch, false);

        if SuccessfullyPosted then
            if Rec."Document Stage" = Rec."Document Stage"::" " then begin
                SavingsAccount.Reset();
                SavingsAccount.SetRange("Member No.", Rec."Member No");
                if SavingsAccount.FindSet() then
                    repeat
                        // if SavingsAccount."Product Category" <> SavingsAccount."Product Category"::"FOSA Account" then
                        if Rec."Claim Type" in [Rec."Claim Type"::"BBF - Principle Claim", Rec."Claim Type"::"Risk Claim"] then begin
                            SavingsAccount.Status := SavingsAccount.Status::Closed;
                            SavingsAccount.Blocked := SavingsAccount.Blocked::All;
                        end;
                        if SavingsAccount."Blocked Buffer" <> SavingsAccount."Blocked Buffer"::" " then begin
                            SavingsAccount.Blocked := SavingsAccount."Blocked Buffer";
                            SavingsAccount."Blocked Buffer" := SavingsAccount."Blocked Buffer"::" ";
                        end;
                        SavingsAccount.Modify();

                    until SavingsAccount.Next() = 0;
            end;

    end;

    procedure UpdateAvailableBeneficiaryAmount()
    var
        NextofKinPmtAlloc: Record "NextofKin Payment Allocation";
    begin
        CalcFields("Total Amount Allocated");
        "Available Beneficiary Amount" := ("Receipt Amount" + "Total Savings") - "Total Amount Allocated" - "Account Closure Fee";
        Modify();
        NextofKinPmtAlloc.Reset();
        NextofKinPmtAlloc.SetRange("Header No.", Rec.No);
        If NextofKinPmtAlloc.FindSet() then
            repeat
                NextofKinPmtAlloc."Beneficiary Amount" := NextofKinPmtAlloc.Allocation * 0.01 * "Available Beneficiary Amount";
                NextofKinPmtAlloc.Modify();
            until NextofKinPmtAlloc.Next() = 0;
    end;

    procedure UpdateBBFLines()
    var
        BBFClaimLines: Record "BBF Claim Lines";
    begin
        BBFClaimLines.Reset();
        BBFClaimLines.SetRange("Header No.", Rec.No);
        if BBFClaimLines.FindSet() then
            repeat
                BBFClaimLines.UpdateLineBufferAmount();
            until BBFClaimLines.Next() = 0;
    end;

    procedure GetTransactionCharge(TransactionCode: Code[20]; TotalAmount: Decimal): Decimal
    var
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        GenSetup: Record "General Set-Up";
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
    begin

        GenSetup.Get();

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionCode);
        if TransactionCharges.Find('-') then begin
            repeat

                ChargeAmount := 0;
                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                        ChargeAmount := (TotalAmount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (TotalAmount >= TariffDetails."Lower Limit") and (TotalAmount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := TotalAmount * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;


                    TChargeAmount := TChargeAmount + ChargeAmount;

                    /*if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin

                         TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;

                     end;*/
                end;
            until TransactionCharges.Next = 0;
        end;
        exit(TChargeAmount);
    end;

    procedure CheckIfMaxNumberClaimed()
    var
        SinkfundReports: Record "SinkFund Report Information";
        OtherReportsCount: Integer;
        BBFEntitlement: Record "BBF Entitlement";
        MaxAllowedClaims: Integer;
    begin
        // SinkfundReports.Reset();
        // SinkfundReports.SetRange("Member No", Rec."Member No");
        // SinkfundReports.SetFilter(Status, '<>%1', Rec.Status::Rejected);
        // SinkfundReports.SetFilter(No, '<>%1', Rec.No);
        // SinkfundReports.SetRange("Claim Type", Rec."Claim Type");
        // SinkfundReports.SetRange(Relationship, Rec.Relationship);
        // if SinkfundReports.Find('-') then
        //     OtherReportsCount := SinkfundReports.Count;

        // BBFEntitlement.Reset();
        // BBFEntitlement.SetRange("Relationship Type", Rec.Relationship);
        // if BBFEntitlement.FindFirst() then
        //     MaxAllowedClaims := BBFEntitlement."SACCO Max. Allowed";

        // //if other claims + this one, are greater than the maxallowed then throw an error
        // if OtherReportsCount >= MaxAllowedClaims then
        //     Error('Maximum claims of count %1 reached. Other claims maybe underway, awaiting completion', OtherReportsCount);

    end;

    procedure CheckIfNOKHasBeenClaimed()
    var
        SinkfundReports: Record "SinkFund Report Information";
        OtherReportsCount: Integer;
        RelationTypes: Record "Relationship Types";
        MaxAllowedClaims: Integer;
        NOK: Record "Next of KIN";
    begin
        SinkfundReports.Reset();
        SinkfundReports.SetFilter(Status, '<>%1', Rec.Status::Rejected);
        SinkfundReports.SetFilter(No, '<>%1', Rec.No);
        SinkfundReports.SetRange("Claim Type", Rec."Claim Type");
        SinkfundReports.SetRange(Relationship, Rec.Relationship);
        SinkfundReports.SetRange("Next of KIN", Rec."Next of KIN");
        if SinkfundReports.FindFirst() then
            Error('This dependant''s %1 has been claimed before', Rec."Claim Type");


        if "Claim Type" = "Claim Type"::"BBF - Dependant Claim" then begin
            NOK.Reset();
            NOK.SetRange(Identification, Rec."Next of KIN");
            NOK.SetRange(Deceased, true);
            if NOK.FindFirst() then
                Error('This dependant is marked as deceased in the system');
        end;
    end;

}

