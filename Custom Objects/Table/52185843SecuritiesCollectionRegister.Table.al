table 52185843 "Securities Collection Register"
{
    DrillDownPageId = "Collateral Collection - List";
    LookupPageId = "Collateral Collection - List";
    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Security Collection Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(3; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(4; "Loan No."; Code[20])
        {
            //Editable = false;
            TableRelation = "Loans"."Loan No.";
            //WHERE (Status = CONST(Approved), Posted = CONST(true)) "Outstanding Balance" = FILTER(<= 0));

            trigger OnValidate()
            begin
                Loans.Reset();
                Loans.Setrange("Loan No.", Rec."Loan No.");
                if Loans.Find('-') then begin
                    // if Loans.GET("Loan No.") then//--Commented
                    //     if Loans.Status <> Loans.Status::Approved then
                    //         Error('The loan is not approved.')
                    //else
                    // if Loans.Posted = false then
                    //     Error('The loan is not posted.')
                    // else
                    Loans.CalcFields("Outstanding Balance");
                    if Loans."Outstanding Balance" <= 0 then begin
                        Rec."Loan Amount" := Loans."Approved Amount";
                        Rec."Loan Type" := Loans."Loan Product Type";
                        Rec."Loan Type Name" := Loans."Loan Product Type Name";
                        Rec."Member No." := Loans."Member No.";
                        Rec."Member Name" := Loans."Member Name";
                        Rec."Outstanding Balance" := Loans."Outstanding Balance";
                        InsertSecurities();
                    end
                    else
                        if Loans."Outstanding Balance" > 0 then begin

                            Rec."Loan Amount" := Loans."Approved Amount";
                            Rec."Loan Type" := Loans."Loan Product Type";
                            Rec."Loan Type Name" := Loans."Loan Product Type Name";
                            Rec."Member No." := Loans."Member No.";
                            Rec."Member Name" := Loans."Member Name";
                            Rec."Outstanding Balance" := Loans."Outstanding Balance";
                            InsertSubstitutedSecurities();


                            // SecuritiesRegister.RESET;
                            // SecuritiesRegister.SETRANGE("Loan No.", "Loan No.");
                            // SecuritiesRegister.SetRange("Collateral Substituted", true);
                            // if SecuritiesRegister.Find('-') then begin
                            //     Rec."Loan Amount" := Loans."Approved Amount";
                            //     Rec."Loan Type" := Loans."Loan Product Type";
                            //     Rec."Loan Type Name" := Loans."Loan Product Type Name";
                            //     Rec."Member No." := Loans."Member No.";
                            //     Rec."Member Name" := Loans."Member Name";
                            //     Rec."Outstanding Balance" := Loans."Outstanding Balance";
                            // end
                            // end
                            // else if Not SecuritiesRegister.Find('-') then

                            //else if Loans."Outstanding Balance" > 0 then
                            //begin
                            //Error('The loan has an outstanding balance of %1', Loans."Outstanding Balance")
                            //end  

                            //else
                            //begin

                            //end;

                            // if CollSec.Get("Collateral Register No.") then begin
                            // LoanGua.Reset;
                            // //LoanGua.SetRange("Collateral Reg. No.", "Collateral Register No.");
                            // LoanGua.SetRange("Loan No", Rec."Loan No.");
                            // LoanGua.SetRange(Substituted, true);
                            // if NOT LoanGua.Find('-') then begin
                            //     LoanGua.CalcFields("Outstanding Balance");
                            //     if LoanGua."Outstanding Balance" > 0 then
                            //         Error(Text006, LoanGua."Outstanding Balance");
                            // end;
                            // Rec."Loan Amount" := Loans."Approved Amount";
                            // Rec."Loan Type" := Loans."Loan Product Type";
                            // Rec."Loan Type Name" := Loans."Loan Product Type Name";
                            // Rec."Member No." := Loans."Member No.";
                            // Rec."Member Name" := Loans."Member Name";
                            // Rec."Outstanding Balance" := Loans."Outstanding Balance";


                            // LoanGuarantorsSub.RESET;
                            // LoanGuarantorsSub.SetRange("Loan No", Rec."Loan No.");
                            // LoanGuarantorsSub.SetRange("Substituted", true);
                            // if LoanGuarantorsSub.Find('-') then begin


                            // end;


                            // SecurityPerfection.RESET;
                            // SecurityPerfection.SetRange("Loan No.", "Loan No.");
                            // SecurityPerfection.SetRange(Status, Status::Approved);
                            // if SecurityPerfection.Find('-') then begin
                            //     repeat
                            //         if SecurityPerfection.Perfected = false then
                            //             Error(Text007)
                            //         else
                            //             if SecurityPerfection.Discharged = true then
                            //                 Error('The collateral has already been discharged.');
                            //     until SecurityPerfection.Next = 0;
                            // end;
                        end;
                end;
                //InsertSecurities();
                concatenatepropertyforSMS();
            end;

        }
        field(5; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(6; "Originating Department"; Code[50])
        {
        }
        field(7; "Current Department"; Code[50])
        {
        }
        field(8; "Loan Amount"; Decimal)
        {
        }
        field(9; "Loan Type"; Code[20])
        {
        }
        field(10; "Member No."; Code[20])
        {
            TableRelation = "Members"."No.";
        }
        field(11; "Member Name"; Text[300])
        {
        }
        field(12; "Loan Type Name"; Text[100])
        {
        }
        field(13; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Responsibility CenterBR"."Global Dimension 1 Code";
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Responsibility CenterBR"."Global Dimension 2 Code";
        }
        field(16; "Created By"; Code[100])
        {
            Editable = false;
        }
        field(17; "Date Created"; DateTime)
        {
            Editable = false;
        }
        field(18; "User ID"; Code[100])
        {
            Editable = false;
        }
        field(19; "Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(20; "SMS Sent"; Boolean)
        {
        }
        field(21; "Email Sent"; Boolean)
        {
        }
        field(22; "Date of External Discharge"; Date)
        {
        }
        field(23; "Discharged By"; Code[100])
        {
        }
        field(24; Discharged; Boolean)
        {
            Caption = 'Discharged';
        }
        field(25; "Date of Internal Discharge"; Date)
        {
        }
        field(26; "Concatenated Property"; Text[2000])
        {
        }
        field(27; "Document Attachments"; Text[2000])
        {
        }
        field(28; "Reviewed By Legal Department"; Boolean)
        {
        }
        field(29; "Reviewed By"; Code[100])
        {
        }
        field(30; "SMS Body"; Blob)
        {

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
        fieldgroup(DropDown; "No.", "Loan No.", "Loan Type", "Member No.", "Member Name")
        {
        }
    }
    procedure GetRichText(SecurityDischarge: record "Securities Collection Register"): Text
    var
        InStream: Instream;
        TypeHelper: Codeunit "Type Helper";
    begin
        Rec.CalcFields("SMS Body");
        Rec."SMS Body".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("SMS Body")));
        // SecurityPerfect.CalcFields(SecurityPerfect."Perfection Summary");
        // SecurityPerfect."Perfection Summary".CreateInStream(InStream, TextEncoding::UTF8);
        // exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(Instream, TypeHelper.LFSeparator(), SecurityPerfect.FieldName(SecurityPerfect."Perfection Summary")));
        Message('Rich Text: %1', TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("SMS Body")));
    end;

    procedure SaveRichText(RichText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."SMS Body");
        Rec."SMS Body".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(RichText);
        Rec.Modify();
        Message('SMS Body: %1', RichText);
        Message('SMS Body: %1', Rec."SMS Body");
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Security Nos.");
            "No." := NoSeriesMgt.GetNextNo(SalesSetup."Loan Security Nos.");
            // NoSeriesMgt.InitSeries(SalesSetup."Loan Security Collection Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Date Created" := CURRENTDATETIME;
        Rec."Created By" := UserId;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Department" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end;
    end;



    // trigger OnModify()
    // begin
    //     if (Status = Status::Approved) or (Status = Status::Pending) then
    //         Error(Text002, Status);
    // end;

    var
        SalesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        CusMembr: Record Members;
        SecurityRegSetUp: Record "Loan Securities Set-up";
        Text001: Label 'This collateral is blocked thus not avaialable for use.';
        Text002: Label 'This application is %1 thus cannot modify.';
        GenSetup: Record "General Set-Up";
        Text003: Label 'The last valuation day is more than %1 hence is invalid';
        Text004: Label 'Last valuation date cannot be greater than today';
        Text005: Label 'The forced sale value cannot be greater than collateral maximum limit of %1';
        CollSec: Record "Securities Register";
        LoanGua: Record "Loan Guarantors and Security";
        Text006: Label 'The loan which was guaranteed using the collateral has a balance of %1';
        Text007: Label 'The collateral is not perfected';
        PerfectionLines: Record "Perfection Lines";
        SecurityPerfection: Record "Security Perfection";
        Loans: Record "Loans";
        UserSetup: Record "User Setup";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        SecuritiesRegister: Record "Securities Register";
        SMSBody: BigText;
        LoanGuarantorsSub: Record "Loan Guarantors Sub";

    local procedure InsertSubstitutedSecurities();
    var
        SecurityCollection: Record "Securities Collection Register";
        SecurityRegister: Record "Securities Register";
        LoanGua: Record "Loan Guarantors and Security";
    begin

        LoanGuarantorsSub.Reset();
        LoanGuarantorsSub.SetRange("Loan No", Rec."Loan No.");
        LoanGuarantorsSub.SetRange(Substituted, true);
        if LoanGuarantorsSub.Find('-') then begin
            repeat
                SecurityRegister.Reset();
                SecurityRegister.SetRange("No.", LoanGuarantorsSub."Collateral Reg. No.");
                if SecurityRegister.Find('-') then begin
                    PerfectionLines.DeleteAll();
                    PerfectionLines.Init();
                    PerfectionLines."Loan No." := SecurityRegister."Loan No.";
                    PerfectionLines."Security No." := SecurityRegister."No.";
                    PerfectionLines."Property No." := SecurityRegister."Collateral Ref No.";
                    PerfectionLines."Collateral Value Sum" := SecurityRegister."Total Market Value";
                    PerfectionLines."Spousal Consent" := SecurityRegister."Spousal Consent";
                    PerfectionLines."Land Control Board Consent" := SecurityRegister."Land Control Board Consent";
                    PerfectionLines."Fees Payable to the firm" := SecurityRegister."Fees Payable to the Firm";
                    PerfectionLines."Status of the Fees" := SecurityRegister."Status of the Fees";
                    PerfectionLines."Amount To Charge" := SecurityRegister."Amount To Be Charged";
                    PerfectionLines."Market Value" := SecurityRegister."Market Value"; //---
                    PerfectionLines."Forced Sale Value" := SecurityRegister."Forced Sale Value"; //---
                    PerfectionLines."Collateral Types" := SecurityRegister."Collateral Type";
                    PerfectionLines."Chargor Name" := SecurityRegister."Chargor/Owner Name";
                    PerfectionLines."Chargor/Owner Name" := SecurityRegister."Chargor/Owner Name";
                    PerfectionLines."Chargor/Owner KRA PIN" := SecurityRegister."Chargor/Owner KRA PIN";
                    PerfectionLines."Charge Type" := format(SecurityRegister."Charge Type");
                    PerfectionLines.iNSERT;
                end;
            until LoanGuarantorsSub.Next() = 0;
        end
        else
            Error('The loan has no collateral substituted.');

    end;


    local procedure InsertSecurities();
    var
        SecurityCollection: Record "Securities Collection Register";
        SecurityRegister: Record "Securities Register";
        LoanGua: Record "Loan Guarantors and Security";

    begin

        SecurityRegister.RESET;
        SecurityRegister.SetRange(SecurityRegister."Loan No.", Rec."Loan No.");
        SecurityRegister.SetRange(Status, SecurityRegister.Status::Approved);
        SecurityRegister.Setrange("Collateral Perfected", false);
        SecurityRegister.Setrange("Collateral Discharged", false);
        if SecurityRegister.Find('-') then begin
            repeat
                //PerfectionLines.Reset();
                //PerfectionLines.SetRange("Loan No.", SecurityRegister."Loan No.");
                ///PerfectionLines.SetRange("Security No.", SecurityRegister."No.");
                //if not PerfectionLines.FindFirst() then begin
                PerfectionLines.DeleteAll();
                PerfectionLines.init;
                PerfectionLines."Loan No." := SecurityRegister."Loan No.";
                PerfectionLines."Security No." := SecurityRegister."No.";
                PerfectionLines."Property No." := SecurityRegister."Collateral Ref No.";
                PerfectionLines."Collateral Value Sum" := SecurityRegister."Total Market Value";
                PerfectionLines."Spousal Consent" := SecurityRegister."Spousal Consent";
                PerfectionLines."Land Control Board Consent" := SecurityRegister."Land Control Board Consent";
                PerfectionLines."Fees Payable to the firm" := SecurityRegister."Fees Payable to the Firm";
                PerfectionLines."Status of the Fees" := SecurityRegister."Status of the Fees";
                PerfectionLines."Amount To Charge" := SecurityRegister."Amount To Be Charged";
                PerfectionLines."Market Value" := SecurityRegister."Market Value"; //---
                PerfectionLines."Forced Sale Value" := SecurityRegister."Forced Sale Value"; //---
                PerfectionLines."Collateral Types" := SecurityRegister."Collateral Type";
                PerfectionLines."Chargor Name" := SecurityRegister."Chargor/Owner Name";
                PerfectionLines."Chargor/Owner Name" := SecurityRegister."Chargor/Owner Name";
                PerfectionLines."Chargor/Owner KRA PIN" := SecurityRegister."Chargor/Owner KRA PIN";
                PerfectionLines."Charge Type" := format(SecurityRegister."Charge Type");
                PerfectionLines.Insert();
            //end;
            until SecurityRegister.Next = 0;
        end;
    end;


    local procedure concatenatepropertyforSMS()
    var
        myInt: Integer;
        HeaderRec: Record "Security Perfection";
        LinesRec: Record "Perfection Lines";
        Concatenatedproperty: Text;
        LineCount: Integer;
        i: Integer;
        Property: Text;
        SMSBody: BigText;
    begin
        HeaderRec.RESET;
        HeaderRec.SETRANGE("Loan No.", Rec."Loan No.");
        if HeaderRec.FINDFIRST() then begin
            LinesRec.RESET;
            LinesRec.SETRANGE("Loan No.", Rec."Loan No.");
            LineCount := LinesRec.COUNT;
            if LinesRec.FINDSET() then begin
                i := 1;
                repeat
                    Property := LinesRec."Charge Type" + ' over Property No. ' + LinesRec."Property No." + ' ' + 'was charged KES. ' + FORMAT(LinesRec."Amount to Charge") + '.00' + '.';
                    if i = LineCount then
                        Concatenatedproperty += Property
                    else
                        Concatenatedproperty += Property + 'and,' + ' ';
                    i += 1;
                until LinesRec.NEXT = 0;
            end;
        end;
        Message('Concatenated Property: %1', Concatenatedproperty);
        Rec."Concatenated Property" := Concatenatedproperty;
        //Rec."SMS Body" := Concatenatedproperty;
        Rec.MODIFY;
    end;
}


