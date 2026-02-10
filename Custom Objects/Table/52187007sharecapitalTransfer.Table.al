table 52187007 "Share Capital Transfer Buffer"
{
    DrillDownPageId = "Share Capital Transfer List";
    LookupPageId = "Share Capital Transfer List";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                SeriesSetup: Record "Credit Nos. Series";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "Document No" <> xRec."Document No" then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Share Capital Transfer No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Source Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Savings Accounts" where("Product Type" = filter(2));
            TableRelation = "Savings Accounts" where("Product Category" = const("Share Capital"));
            trigger OnValidate()
            var
                myInt: Integer;
                Loans: Record Loans;
                SavvingsAcc: Record "Savings Accounts";
                members: Record Members;
                Sharelines: Record "Share Capital Transfer Lines";
                Sharecaps: Record "Share Capital Transfer Buffer";
                ShaCount: Integer;
            begin
                Sharelines.Reset();
                Sharelines.SetRange("Document No.", Rec."Document No");
                if Sharelines.FindFirst() then
                    Sharelines.DeleteAll();

                Sharecaps.Reset();
                Sharecaps.SetRange("Source Member No", Rec."Source Account No");
                Sharecaps.SetFilter(Status, '%1|%2', Sharecaps.Status::Open, Sharecaps.status::Pending);
                if Sharecaps.FindFirst() then begin
                    ShaCount := Sharecaps.Count;
                    if ShaCount > 1 then
                        Error('Member has a share capital transfer of card no. %1 in progress', Sharecaps."Document No");
                end;
                SavvingsAcc.Reset();
                SavvingsAcc.SetRange("No.", Rec."Source Account No");
                if SavvingsAcc.FindFirst() then begin
                    if members.Get(SavvingsAcc."Member No.") then begin
                        if (members.Status <> members.Status::Withdrawn) and (members.Status <> members.Status::Deceased) then
                            Error(
                                'Share transfer is not eligible to this member. Current member status is: %1. Allowed member statuses for share transfers are %2 or %3',
                                Format(members.status),
                                Format(members.status::Withdrawn),
                                Format(members.status::Deceased)
                            );
                    end;

                    SavvingsAcc.Reset();
                    SavvingsAcc.SetRange("No.", Rec."Source Account No");
                    if SavvingsAcc.FindFirst() then begin
                        if members.Get(SavvingsAcc."Member No.") then begin
                            if ((members.Subflag <> members.Subflag::Withdrawal) and (members.Subflag <> members.Subflag::"Pending Share Capital Transfer")) and ((members.Subflag <> members.Subflag::"Pending Insurance Claim")) then
                                Error(
                                     'Share transfer is only eligible to members of sub status is ' + Format(members.Subflag::Withdrawal) + ' or ' + Format(members.Subflag::"Pending Share Capital Transfer") + ' or ' + Format(members.Subflag::"Pending Insurance Claim"));
                        end;
                    end;

                    SavvingsAcc.CalcFields("Balance (LCY)");
                    Rec."Source Member Name" := SavvingsAcc.Name;
                    Rec."Book Balance" := SavvingsAcc."Balance (LCY)";
                    Rec."Source Balance" := Rec."Book Balance";

                    Rec."Source ID No." := SavvingsAcc."ID No.";
                    Rec."Source Member No" := SavvingsAcc."Member No.";
                    Rec."Global Dimension 1 Code" := SavvingsAcc."Global Dimension 1 Code";
                    Rec."Global Dimension 2 Code" := SavvingsAcc."Global Dimension 2 Code";
                end;
            end;
        }
        field(3; "Source Member No"; code[30])
        {
            editable = false;
            // DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     GlobalFunctions: Codeunit "Global Functions";
            // begin
            //     GlobalFunctions.AssignDigitCustodianTask(Rec."Document No", Rec."Source Member No", "Sub Module"::"Share Capital Transfer");
            // end;
        }

        field(4; "Source Member Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Source Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(21; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            var
                GlobalFunctions: Codeunit "Global Functions";
            begin
                // if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Approved) then
                //     GlobalFunctions.CommentsManagement(Rec."Document No");
            end;
        }
        field(8; "Source Mobile Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Source ID No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Destination Member No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(11; "Destinaton Acc No"; code[30])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
                members: Record Members;
                SavvingsAcc: Record "Savings Accounts";
            begin
                Rec."Receipt Amount" := 0;
                Rec."Reference No" := '';
                SavvingsAcc.Reset();
                SavvingsAcc.SetRange("Member No.", Rec."Destination Member No.");
                SavvingsAcc.SetRange("Product Type", '2');
                if SavvingsAcc.FindFirst() then begin
                    SavvingsAcc.CalcFields("Balance (LCY)");
                    Rec."Book Balance" := SavvingsAcc."Balance (LCY)";
                    Rec."Destination Member Name" := SavvingsAcc.Name;
                    Rec."Destination Employer Code" := SavvingsAcc."Employer Code";
                    "Destination Member No." := SavvingsAcc."Member No.";
                end;

                if Rec."Source Account No" = Rec."Destinaton Acc No" then
                    Error('You cannot transfer Shares  to yourself');
            end;


        }
        field(12; "Destination Member Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Destination Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Destination Employer Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; code[30])
        {
            DataClassification = ToBeClassified;
        }



        field(16; Transfered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Transfer Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code where(Type = const("Share Capital Transfer"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //if "Transaction Type" <> '' then error('Transaction Type Should not be inserted in this process');
                Rec.Description := Format("Transaction Type");
            end;

        }

        field(40; "CRM Application No."; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(140; "CRM No. Series"; Code[10])
        {

        }

        field(41; "CRM Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(42; "CRM Originating Branch"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "CRM Created By"; Code[100])
        {
            Editable = false;
        }
        field(43; "Book Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Reference No"; Code[40])
        {
            //TableRelation = "Receipt Line".No where(Posted = const(true), "Account Type" = FILTER("G/L Account"));
            TableRelation = "Cashier Transactions".No where("Posted" = const(true), Type = const("Credit Receipt"));
            DataClassification = ToBeClassified;
            Caption = 'Reference No';
            trigger OnValidate()
            var
                myInt: Integer;
                CashTans: Record "Cashier Transactions";
                ShareCapitalTransBuf: Record "Share Capital Transfer Buffer";
            begin
                Rec."Receipt Amount" := 0;
                CashTans.Reset();
                CashTans.SetRange(No, Rec."Reference No");
                CashTans.Setrange(Posted, true);
                if CashTans.FindFirst() then begin
                    Rec."Receipt Amount" := CashTans.Amount;
                end
                else
                    error('Reference No. %1 does not exist in credit cashier receipts!', Rec."Reference No");

                ShareCapitalTransBuf.Reset();
                ShareCapitalTransBuf.SetRange("Reference No", "Reference No");
                ShareCapitalTransBuf.SetFilter("Document No", '<>%1', Rec."Document No");
                if ShareCapitalTransBuf.FindFirst() then begin
                    Error('Reference No. %1 has already been used in another share capital transfer application', Rec."Reference No");
                end;
            end;
        }
        field(46; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = ' Doc Description';
        }
        field(100; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = ' Application Date';
        }
        field(101; "Receipt Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("Document No")));
        }
        field(104; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("Document No")));
        }
        field(103; "Sent Back to CRM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(801; "Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(802; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(803; "Application Time"; Time)
        {

        }
        field(804; "Posting Time"; Time)
        {

        }
        field(805; "Posting Date"; Date)
        {

        }
        field(806; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(807; "Amount to transfer"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if rec."Amount to transfer" > "Book Balance" then Error('Amount to transfer Cannot be more than the book balance of  %1 ' + Format(rec."Book Balance"));
            end;
        }

    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        UserSet: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Sharecaps: Record "Share Capital Transfer Buffer";
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";

        theSMS: Text;
        theMember: Record Members;
    begin
        if "Document No" = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Share Capital Transfer No");
            NoSeriesMgt.InitSeries(SeriesSetup."Share Capital Transfer No", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        // if "Reference No" = '' then
        //     Error('Reference No. is required');
        rec.

        "Application Date" := Today;
        "Application Time" := Time;

        Sharecaps.Reset();
        Sharecaps.SetRange("Source Member No", Rec."Source Member No");
        Sharecaps.SetFilter(Status, '=%1|%2', Sharecaps.Status::Open, Sharecaps.status::Pending);
        if Sharecaps.FindFirst() then begin
            Error('Member already has a share capital transfer of application no. %1 in progress', Sharecaps."Document No");
        end;

        // SMS to applicant
        theMember.Reset;
        theMember.SetRange("No.", Rec."Source Member No");

        if theMember.FindFirst then begin
            theSMS := 'Dear member, your institutional capital transfer request has been received successfully and is being processed. REF ' + "Document No";

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
                "Document No",
                'CBS'
            );

            // EMAIL
            SkySendEmail.QueueOutgoingEmail(
                        theMember."E-Mail",
                        'Share Capital Transfer',
                        theSMS,
                        'TEXT',
                        'SCT APPLICATION',
                        'CRM'
                    );
        end;

        // if Rec."Source Member No" <> '' then
        //     GlobalFunctions.AssignDigitCustodianTask(Rec."Document No", Rec."Source Member No", "Sub Module"::"Share Capital Transfer");
    end;

    trigger OnModify()
    var
        myInt: Integer;
        thisApp: Record "Share Capital Transfer Buffer";

        theSMS: Text;
        theMember: Record Members;
    begin
        thisApp.Reset();

        thisApp.SetFilter("Document No", "Document No");

        if thisApp.FindFirst() then begin
            // Track Status changes
            IF not (thisApp.Status = Status) then begin
                if "CRM Application No." <> '' then begin
                    // CRM API
                    // CRMIntegration.CRMShareTransferRequestUpdate(
                    //     "CRM Application No.",
                    //     Format(Status),
                    //     ''
                    // );
                end;

                if Status = Status::Approved then begin
                    "Approved By" := UserId;
                    "Approval Date" := Today;
                end;

                // SMS to applicant
                case Status of
                    Status::Approved:
                        begin
                            theSMS := 'Dear member, your institutional capital transfer request has been approved. REF ' + "Document No";
                        end;
                    Status::Rejected:
                        begin
                            theSMS := 'Dear member, your institutional capital transfer request has been rejected. REF ' + "Document No";
                        end;
                end;

                theMember.Reset;
                theMember.SetRange("No.", Rec."Source Member No");

                if theMember.FindFirst then begin
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
                            "Document No",
                            'CBS'
                        );

                        // EMAIL
                        // SkySendEmail.QueueOutgoingEmail(
                        //             theMember."E-Mail",
                        //             'Share Capital Transfer',
                        //             theSMS,
                        //             'TEXT',
                        //             'SCT APPLICATION',
                        //             'CRM'
                        //         );
                    end;
                end;
            end;
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        SkySMS: CodeUnit SendSms;
        SkySendEmail: Codeunit "Sky Send Email";
        SMSSource: enum "SMS Source";
        CRMIntegration: Codeunit "CRM Integration";
        DepartMent: Enum "Responsibility Center Enum";

}