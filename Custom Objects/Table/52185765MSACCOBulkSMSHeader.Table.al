table 52185765 "Bulk SMS Header"
{
    DrillDownPageId = "Bulk SMS Header";
    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = false;
        }
        field(2; "Date Entered"; Date)
        {
        }
        field(3; "Time Entered"; Time)
        {
        }
        field(4; "Entered By"; Code[40])
        {
        }
        field(5; "SMS Type"; Option)
        {
            OptionMembers = "Selected Members",Everyone;
            OptionCaption = 'Selected Members, Everyone';
            trigger OnValidate()
            var
                Members: Record "Members";
                SendSMS: Codeunit SendSms;
            begin
                if "SMS Type" = "SMS Type"::Everyone then begin
                    if Confirm('Are you sure you want to send this message to everyone?') then begin
                        Members.reset;
                        Members.Setfilter(Status, '<>%1', Members.Status::Deceased);
                        Members.Setfilter(subflag, '<>%1', Members.subflag::Closed);

                        if Members.FindFirst() then begin
                            repeat
                                BulkSMSLine.INIT;
                                BulkSMSLine.No := Rec.No;
                                BulkSMSLine."Member No" := Members."No.";
                                BulkSMSLine.Description := Members.Name;
                                if Members."Phone No." <> '' then
                                    BulkSMSLine.Code := Members."Phone No.";
                                BulkSMSLine.Sent := false;
                                BulkSMSLine.INSERT;
                            until members.next = 0;
                        end;

                    end;
                end;
            end;
        }
        field(6; "SMS Status"; Option)
        {
            Caption = 'SMS/Email Status';
            OptionMembers = Pending,Sent,Cancelled;
        }
        field(7; "Status Date"; Date)
        {
        }
        field(8; "Status Time"; Time)
        {
        }
        field(9; "Status By"; Code[40])
        {
        }
        field(10; Message_; Text[900])
        {
            trigger OnValidate()
            begin

                // if "SMS Type" = "SMS Type"::Everyone then begin
                //     if Confirm('Are you sure you want to send this message to everyone?') then
                //         Report.RunModal(Report::"Generate Bulk SMS Lines", true, true, Rec);
                // end;
            end;
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Use Line Message"; Boolean)
        {

        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(14; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
        }
        field(5701; "SMS Source"; Enum "SMS Source")
        {
            Caption = 'SMS Source';
            InitValue = BULK_SMS;
        }
        field(5702; "Email Subject"; Code[200])
        {
        }

    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(Key2; "Date Entered", "Time Entered", No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."BULK SMS Nos");
            No := NoSeriesMgt.GetNextNo(NoSetup."BULK SMS Nos");
            // NoSeriesMgt.InitSeries(NoSetup."BULK SMS Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        "SMS Type" := "SMS Type"::"Selected Members";
    end;

    var
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        BulkSMSLine: Record "Bulk SMS Lines";
}

