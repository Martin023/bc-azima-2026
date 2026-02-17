table 52185828 "Guarantors Substitution"
{
    DrillDownPageID = "Guarantor Subsitution List";
    LookupPageID = "Guarantor Subsitution List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if xRec."No." <> xRec."No." then begin
                    CreditNosSeries.Get;
                    NoSeriesMgt.TestManual(CreditNosSeries."Guarantors Substitution");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Loan Account No."; Code[20])
        {
            TableRelation = "Credit Accounts";
            Editable = false;
        }
        field(3; Name; Text[50])
        {
            Editable = false;
        }
        field(4; "Account Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Apportioned,Suspended,Awaiting Verdict';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Apportioned,Suspended,"Awaiting Verdict";
        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected,Deffered,Posted,Cancelled';
            OptionMembers = Open,Pending,Approved,Rejected,Deffered,Posted,Cancelled;
        }
        field(6; "Current Savings"; Decimal)
        {
            Editable = false;
        }
        field(7; "FOSA Account"; Code[20])
        {
            Editable = false;
            Enabled = false;
        }
        field(8; "Business Loan No."; Code[20])
        {
            Editable = false;
            Enabled = false;
        }
        field(9; "Business Loan Shares"; Decimal)
        {
            Editable = false;
        }
        field(10; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(11; "Captured By"; Code[50])
        {
            Editable = false;
        }
        field(12; "Responsibility Centre"; Code[20])
        {
            Editable = false;
            TableRelation = "Responsibility CenterBR";
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Document No."; Code[20])
        {
        }
        field(16; Date; Date)
        {
            Editable = false;
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; "ID/Passport"; Code[10])
        {
        }
        field(19; "Loan No."; Code[20])
        {
            TableRelation = Loans."Loan No." where("Member No." = field("Member No."), "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                AppraisaComm: Record "Loan Appraisal Comments";
                GuaranotrSub: Record "Guarantors Substitution";
                SubCount: Integer;
            begin
                // AppraisaComm.Reset();
                // AppraisaComm.SetRange("Loan No.", Rec."Loan No.");
                // if AppraisaComm.Find('-') then
                //     AppraisaComm.DeleteAll();
                // ;
                GuaranotrSub.Reset();
                GuaranotrSub.SetRange("Loan No.", Rec."Loan No.");
                GuaranotrSub.SetRange(Posted, false);
                GuaranotrSub.SetRange("Rejected By", '');
                if GuaranotrSub.Find('-') then begin
                    SubCount := GuaranotrSub.Count;
                    if SubCount > 1 then
                        Error('Member  %1 has a Loan Guarantor substitution that has not been posted', rec."Member No.");
                end;
                if Loan.Get("Loan No.") then begin
                    Loan.CalcFields(Loan."Outstanding Balance");
                    if Loan."Outstanding Balance" <= 0 then
                        Error(Txt001);
                    "Loan Account No." := Loan."Loan Account";
                    Name := Loan."Member Name";
                    GenerateGuarantors();
                end;
            end;
        }
        field(20; Posted; Boolean)
        {
        }

        field(21; "CRM Application No."; Text[50])
        {
        }

        field(121; "CRM No. Series"; Code[10])
        {

        }



        field(22; "CRM Created By"; Code[150])
        {
            Editable = false;
        }

        field(23; "CRM Originating Branch"; Code[50])
        {
            Editable = false;
        }

        field(24; "CRM Notes"; text[1000])
        {
            Editable = false;
        }
        field(25; "Member No."; Code[20])
        {
            TableRelation = Members."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                MemberRec: Record Members;

            begin
                "Loan No." := '';
                "Loan Account No." := '';
                "Captured By" := UserId;
                LGuarant.Reset();
                LGuarant.SetRange("No.", Rec."No.");
                LGuarant.DeleteAll();
                MemberRec.Reset();
                MemberRec.SetRange("No.", Rec."Member No.");
                if MemberRec.FindFirst() then begin
                    Rec.Name := MemberRec.Name;
                end;




            end;
        }
        field(26; "Sent Back to CRM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Rejected By"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Narration"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(31; "Responsible Officer"; Code[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(32; "Supervisor ID"; Code[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }

        field(33; "Member Status"; Enum "Member Status")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Status where("No." = FIELD("Member No.")));
        }

        field(34; "Loan Product Type"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Product Type Name" where("Loan No." = FIELD("Loan No.")));
        }
        field(35; "Approved By"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Approved Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(37; "AppLication Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(38; "Approval Time"; Time)
        {
            Editable = false;
        }
        field(50; "Source Application"; Option)
        {
            OptionMembers = "BC",CRM,"Mwalimu Smart","Member Portal","Mbanking - APP","Mbanking - USSD";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        theSMS: Text;
        theMember: record members;
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";
        DepartMent: Enum "Responsibility Center Enum";

        MemberLoaningDetails: JsonObject;
        TheLoanProduct: Record "Product Factory";
        TheLoan: record Loans;

        MajorLoansCount: JsonToken;
        MinorLoansCount: JsonToken;
        MaxMajorLoansCount: JsonToken;
        MaxMinorLoansCount: JsonToken;
    begin

        if "No." = '' then begin
            CreditNosSeries.Get;
            CreditNosSeries.TestField(CreditNosSeries."Guarantors Substitution");
            "No." := NoSeriesMgt.GetNextNo(CreditNosSeries."Guarantors Substitution");
            // NoSeriesMgt.InitSeries(CreditNosSeries."Guarantors Substitution", xRec."No. Series", 0D, "No.", "No. Series");

        end;
        GlobalFunctions.AssignUserTasks(DepartMent::BOSA, SubDepartments::"Guarantor Substitution", Rec."No.");
        "Captured By" := UserId;
        Date := Today;
        "AppLication Time" := Time;
        UserSetup.Get(UserId);
        //BEGIN
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Responsibility Centre");


        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Responsibility Centre" := UserSetup."Responsibility Centre";


        // SMS to loanee
        theSMS := 'Dear member, a loan guarantor substitution request for loan ' + Rec."Loan No." + ' has been received successfully and is being processed. REF ' + Rec."No.";

        theMember.Reset;
        theMember.SetRange("No.", Rec."Member No.");

        if theMember.findfirst then begin
            if theSMS <> '' then begin
                SkySMS.SendSms(
                SMSSource::CRM,
                theMember."Phone No.",
                theSMS,
                CreateGuid(),
                '',
                false,
                0,
                false,
                'CBS',
                Rec."No.",
                'CBS'
            );

                // EMAIL 
                SkySendEmail.QueueOutgoingEmail(
                    theMember."E-Mail",
                    'Loan Guarantor Substitution',
                    theSMS,
                    'TEXT',
                    'LGS APPLICATION',
                    'CRM'
                );
            end;
        end;
    end;

    trigger OnModify()
    var
        thisApp: Record "Guarantors Substitution";
        theSMS: Text;
        theMember: record members;

        GlobalFunctions: Codeunit "Global Functions";

        MemberLoaningDetails: JsonObject;
        TheLoanProduct: Record "Product Factory";
        TheLoan: record Loans;

        MajorLoansCount: JsonToken;
        MinorLoansCount: JsonToken;
        MaxMajorLoansCount: JsonToken;
        MaxMinorLoansCount: JsonToken;
    begin
        thisApp.Reset();
        thisApp.SetFilter("No.", Rec."No.");

        if thisApp.FindFirst then begin
            if thisApp.Status <> Status then begin

                case Status of
                    Status::Approved:
                        begin
                            theSMS := 'Dear member, a loan guarantor substitution request for loan ' + Rec."Loan No." + ' has been approved. REF ' + Rec."No.";
                        end;
                    Status::Rejected:
                        begin
                            theSMS := 'Dear member, a loan guarantor substitution request for loan ' + Rec."Loan No." + ' has been rejected. REF ' + Rec."No.";
                        end;
                end;

                theMember.Reset;
                theMember.SetRange("No.", Rec."Member No.");

                if theMember.findfirst then begin
                    if theSMS <> '' then begin
                        SkySMS.SendSms(
                            SMSSource::CRM,
                            theMember."Phone No.",
                            theSMS,
                            CreateGuid(),
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            Rec."Loan No.",
                            'CBS'
                        );

                        // EMAIL 
                        SkySendEmail.QueueOutgoingEmail(
                            theMember."E-Mail",
                            'Loan Guarantor Substitution',
                            theSMS,
                            'TEXT',
                            'LGS APPLICATION',
                            'CRM'
                        );
                    end;
                end;

            end;
        end;
    end;

    var
        SkySMS: CodeUnit SendSms;
        SkySendEmail: CodeUnit "Sky Send Email";
        SMSSource: Enum "SMS Source";
        CreditNosSeries: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        LGuarant: Record "Loan Guarantors Sub";
        Lguarantx: Record "Loan Guarantors and Security";
        Loan: Record Loans;
        Txt001: Label 'This loan does not have a balance';
        UserSetup: Record "User Setup";
        SaVingAc: Record "Savings Accounts";

    // [Scope('OnPrem')]
    procedure GenerateGuarantors()
    begin
        if Rec."Loan No." <> '' then begin
            LGuarant.Reset();
            LGuarant.SetRange(LGuarant."No.", Rec."No.");

            LGuarant.DeleteAll();
        end;
        Lguarantx.Reset;
        Lguarantx.SetRange(Lguarantx."Loan No", Rec."Loan No.");
        //Lguarantx.SetRange(Lguarantx.Substituted, false);
        if Lguarantx.Find('-') then
            repeat

                LGuarant.Init;
                LGuarant."No." := "No.";
                LGuarant."Entry No" := LGuarant."Entry No" + 1;
                LGuarant."Guarantor Type" := Lguarantx."Guarantor Type";
                LGuarant."Collateral Reg. No." := Lguarantx."Collateral Reg. No.";
                LGuarant."Loan No" := Lguarantx."Loan No";
                LGuarant."Member No" := Lguarantx."Member No";
                //get deposit contribution no
                // SaVingAc.Get(LGuarant."Member No"); 
                SaVingAc.Reset;
                SaVingAc.SetRange("Member No.", LGuarant."Member No");
                SaVingAc.SetRange("Product Type", 'DCS');
                if SaVingAc.FindFirst then begin
                    LGuarant."Savings Account No." := SaVingAc."No.";
                end;
                LGuarant.Shares := Lguarantx."Deposits/Shares";
                LGuarant."Loan Balance" := Lguarantx."Loan Balance";
                LGuarant.Name := Lguarantx.Name;
                LGuarant.Substituted := Lguarantx.Substituted;
                LGuarant.Date := Lguarantx.Date;
                LGuarant."Amount Guaranteed" := Lguarantx."Amount Guaranteed";
                LGuarant."Staff/Payroll No." := Lguarantx."Staff/Payroll No.";
                LGuarant."Proportion Guaranteed" := Lguarantx."Proportion Guaranteed";
                //LGuarant."Account No.":=Lguarantx."Account No.";
                LGuarant."Self Guarantee" := Lguarantx."Self Guarantee";
                LGuarant.PercentageGur := Lguarantx.PercentageGur;
                LGuarant."ID No." := Lguarantx."ID No.";
                LGuarant."Member Guaranteed" := Lguarantx."Member Guaranteed";
                //LGuarant."Group Account No.":=Lguarantx."Group Account No.";
                //LGuarant."Loan Product Type":=Lguarantx."Loan Product Type";
                LGuarant."Outstanding Balance" := Lguarantx."Outstanding Balance";
                LGuarant."SMS Sent" := Lguarantx."SMS Sent";
                LGuarant.Insert;

            until Lguarantx.Next = 0;
    end;
}

