table 52185483 "Contract Templates"
{
    Caption = 'Contract Templates';
    DataClassification = ToBeClassified;
    LookupPageId = "Word Template Creation Wizard";

    fields
    {
        field(1; "Template No."; Code[50])
        {
            Caption = 'Template No.';
        }
        field(2; "Template Type"; Option)
        {
            Caption = 'Template Type';
            OptionMembers = " ","Service Contract","Maintenance Contract","Rental Contract","Lease Contract","Insurance Contract","Other Contract";
            OptionCaption = 'Service Contract, Maintenance Contract, Rental Contract, Lease Contract, Insurance Contract, Other Contract';
        }
        field(3; "Template Description"; Text[100])
        {
            Caption = 'Template Description';
        }
        field(4; "No. Series"; Code[50])
        {

        }
        field(5; "Created Date"; DateTime)
        {
            Caption = 'Captured At';
        }
        field(6; "Created By"; Code[20])
        {
            Caption = 'Captured By';
        }
        field(7; "Global Dimension 1 Code" ; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(8; "Global Dimension 2 Code" ; Code[20])
        {
            Caption = 'Activity Code';
        }
        field(9; "Responsibility Centre"; Code[20])
        {
            Caption = 'Responsibility';
        }
        field(10; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(11; "Template Content"; Blob)
        {
            Caption = 'Template Content';
        }
    }
    keys
    {
        key(PK; "Template No.")
        {
            Clustered = true;
        }
    }

    procedure GetRichText(ContractTemplates: record "Contract Templates"): Text
    var
        InStream: Instream;
        TypeHelper: Codeunit "Type Helper";
    begin
        Rec.CalcFields("Template Content");
        Rec."Template Content".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Template Content")));
        // SecurityPerfect.CalcFields(SecurityPerfect."Perfection Summary");
        // SecurityPerfect."Perfection Summary".CreateInStream(InStream, TextEncoding::UTF8);
        // exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(Instream, TypeHelper.LFSeparator(), SecurityPerfect.FieldName(SecurityPerfect."Perfection Summary")));
        Message('Rich Text: %1', TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Template Content")));
    end;

    procedure SaveRichText(RichText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."Template Content");
        Rec."Template Content".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(RichText);
        Rec.Modify();
        //Message('Rich Text: %1', RichText);
        //Message('Perfection Summary: %1', Rec."Perfection Summary");
    end;


    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
        CreditNosSeries: Record "Credit Nos. Series";
    begin
        if "Template No." = '' then begin
            CreditNosSeries.Get;
            CreditNosSeries.TestField(CreditNosSeries."Template No.");
            NoSeriesMgt.InitSeries(CreditNosSeries."Template No.", xRec."No. Series", 0D, "Template No.", "No. Series");
        end;
        
        Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        Rec."Responsibility Centre" := UserSetup."Responsibility Centre";
        "Created By" := USERID;
        "Created Date" := CURRENTDATETIME;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Centre" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
