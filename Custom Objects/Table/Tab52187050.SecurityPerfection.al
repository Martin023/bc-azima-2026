table 52187050 "Security Perfection"
{
    Caption = 'Security Perfection';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Security Perfection Card";
    LookupPageId = "Security Perfection List";

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Security Perfection No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(31; "Security No."; Code[50])
        {
            Caption = 'Security No.';
            TableRelation = "Securities Register"."No." where(Status = CONST(Approved), "Security Stage" = CONST("At Legal"));
            trigger OnValidate()
            begin
                // SecurityRegister.RESET;
                // SecurityRegister.SetRange("No.", Rec."Security No.");

                // if SecurityRegister.Find('-') then begin
                //     Rec."Security No." := SecurityRegister."No.";
                //     Rec."Member Name" := SecurityRegister."Account Name";
                //     Rec."Member No." := SecurityRegister."Account No.";
                //     Rec."Property Number" := SecurityRegister."Collateral Ref No.";
                //     Rec."Collateral Value Sum" := SecurityRegister."Collateral Value";
                //     Rec."Spousal Consent" := SecurityRegister."Spousal Consent";
                //     Rec."Land Control Board Consent" := SecurityRegister."Land Control Board Consent";
                //     Rec."Law Firm Hanlding the Matter" := SecurityRegister."Law Firm Hanlding the Matter";
                //     Rec."Fees Payable to the Firm" := SecurityRegister."Fees Payable to the Firm";
                //     Rec."Status of the Fees" := SecurityRegister."Status of the Fees";
                //     Rec.Amount := SecurityRegister."Loan Amount";
                //     Rec."Amount To Charge" := SecurityRegister."Amount To Be Charged";
                //     Rec."Market Value" := SecurityRegister."Market Value";
                //     Rec."Force Sale Value" := SecurityRegister."Forced Sale Value";
                //     Rec."Loan No." := SecurityRegister."Loan No.";
                //     Rec."Loan Name" := SecurityRegister."Loan Name";
                //     Rec."Lending Unit" := SecurityRegister."Lending Unit";
                //     Rec."Collateral Types" := SecurityRegister."Collateral Type";
                //     Rec."Law Firm Address" := SecurityRegister."Law Firm Address";
                //     Rec."Law Firm Physical Address" := SecurityRegister."Law Firm Physical Address";
                //     Rec."Loan Offer Letter Date" := SecurityRegister."Loan Offer Letter Date";
                // end;
            end;
        }
        field(33; "Collateral Value Sum"; Decimal)
        {

        }
        field(32; "Property Number"; Code[50])
        {
            Caption = 'Property Number';
        }
        field(2; "Member No."; Code[50])
        {
            Caption = 'Member No.';
            TableRelation = Members;
        }
        field(3; "Member Name"; Text[350])
        {
            Caption = 'Member Name';
        }
        field(21; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
            TableRelation = Loans."Loan No.";
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                SecurityRegister.RESET;
                SecurityRegister.SetRange(SecurityRegister."Loan No.", Rec."Loan No.");
                //SecurityRegister.SetRange("Status", SecurityRegister.Status::Approved);
                if SecurityRegister.Find('-') then begin
                    //Perfection.Init();
                    Rec.Amount := SecurityRegister."Loan Amount";
                    Rec."Loan Name" := SecurityRegister."Loan Name";
                    Rec."Lending Unit" := SecurityRegister."Lending Unit";
                    Rec."Member No." := SecurityRegister."Account No.";
                    Rec."Member Name" := SecurityRegister."Account Name";
                    Rec."Loan Offer Letter Date" := SecurityRegister."Loan Offer Letter Date";
                    Rec."Law Firm Hanlding the Matter" := SecurityRegister."Law Firm Hanlding the Matter";
                    Rec."Fees Payable to the firm" := SecurityRegister."Fees Payable to the Firm";
                    Rec."Status of the Fees" := SecurityRegister."Status of the Fees";
                    Rec."Security Category" := SecurityRegister."Security Category";
                    Rec."Chargor/Owner Name" := SecurityRegister."Chargor/Owner Name";
                    Rec."Chargor/Owner KRA PIN" := SecurityRegister."Chargor/Owner KRA PIN";
                    Rec."Chargor/Owner ID No" := SecurityRegister."Chargor/Owner ID No";
                    REc."Date of Coll. registration" := SecurityRegister."Date of registration";
                    Rec."Collateral Description" := SecurityRegister."Collateral Description";
                    Rec."Lease/Ownership Exp. Date" := SecurityRegister."Lease/Ownership Exp. Date";
                    Rec."Property Location" := SecurityRegister."Property Location";
                    Rec."Date of Manufucture" := SecurityRegister."Date of Manufucture";
                    Rec."Chargor Phone No." := SecurityRegister."Chargor Phone No.";
                    Rec."Collateral Owner" := SecurityRegister."Collateral Owner";
                    Rec."Law Firm Address" := SecurityRegister."Law Firm Address";
                    Rec."Law Firm Physical Address" := SecurityRegister."Law Firm Physical Address";

                    //Perfection.Insert();
                    //InsertSecurities();
                end;
                PerfectionLines.RESET();
                PerfectionLines.SetRange("Loan No.", rec."Loan No.");
                PerfectionLines.Deleteall();
                InsertSecurities();
                concatenatepropertyforSMS();
            end;
        }
        // field(4; "Loan Type"; CODE[20])
        // {
        //     Caption = 'Loan Type';
        //     //OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        // }
        field(5; "Loan Name"; Text[100])
        {
            Caption = 'Loan Name';
        }
        field(6; "Collateral Types"; Option)
        {
            Caption = 'Collateral Types';
            OptionMembers = " ","Immovable","Chattels Mortgage","Cash Collaterals","Guarantors";
        }
        field(7; "Relevant Consents"; Option)
        {
            Caption = 'Relevant Consents';
            OptionMembers = " ","Spousal Consents","Land Control Board","Others";
            trigger OnValidate()
            begin
                if "Relevant Consents" = "Relevant Consents"::"Others" then begin
                    if Others = '' then
                        ERROR('Please Specify the Relevant Consent');
                end;
            end;
        }
        field(111; "Charge Type"; Option)
        {
            Caption = 'Charge Type';
            OptionMembers = "Charge","Further Charge","Second Further Charge","Discharge";
        }
        field(8; "Law Firm Hanlding the Matter"; Text[100])
        {
            Caption = 'Law Firm Hanlding the Matter';
        }
        field(9; "Date of Issuance Instructions"; Date)
        {
            Caption = 'Date of Issuance of Instructions';
        }
        field(10; "Fees Payable to the firm"; Decimal)
        {
            Caption = 'Fees Payable to the firm';
        }
        field(11; "Status of the Fees"; Option)
        {
            Caption = 'Status of the Fees';
            OptionMembers = " ","Unpaid","Partially Paid","Paid";
        }
        // field(12; Remarks; Text[250])
        // {
        //     Caption = 'Remarks';
        // }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(14; "Valuation Comments"; Text[250])
        {
            Caption = 'Valuation Comments';
        }
        field(15; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = "Open","Pending","Approved","Completed","At Credit","Rejected","Deffered",Canceled;
        }

        field(16; "Collateral Status"; Option)
        {
            Caption = 'Collateral Status';
            OptionMembers = " ","Updated","Substituted","Discharged";
            TableRelation = "Loan Guarantors and Security"."Guarantor Type";
            trigger OnValidate()
            Var
                LoanGua: Record "Loan Guarantors and Security";

            begin
                ;
                LoanGua.Get("Loan No.");

                if LoanGua.Find('-') then begin
                    if LoanGua."Guarantor Type" = LoanGua."Guarantor Type"::"Collateral" then begin
                        if LoanGua.Substituted = true then begin
                            "Collateral Status" := "Collateral Status"::"Substituted";
                        end;
                    end;
                end;
                // SecurityCollection.Get("Loan No.");
                // SecurityCollection.SetRange("Collateral Register No.", "Security No.");
                // if SecurityCollection.Find('-') then begin
                //     if SecurityCollection."Inward/Outward" = SecurityCollection."Inward/Outward"::"Returned" then
                //         "Collateral Status" := "Collateral Status"::"Discharged";
                // end;
            end;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(20; "Created by"; Code[50])
        {
            Caption = 'Created by';
            TableRelation = User;
        }
        field(22; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(23; "Modified by"; Code[50])
        {
            Caption = 'Modified by';
            TableRelation = User;
        }
        field(24; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(25; "Perfected"; Boolean)
        {
            Caption = 'Perfected';
        }
        field(26; "Date Perfected"; Date)
        {
            Caption = 'Date Perfected';
        }
        field(27; "Perfected By"; Code[50])
        {
            Caption = 'Perfected By';
        }
        field(28; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }
        field(30; Others; Text[250])
        {
            Caption = 'Others';
        }
        field(42; "Discharged"; Boolean)
        {
            Caption = 'Discharged';
        }
        field(43; "Discharged On"; DateTime)
        {
            Caption = 'Discharged On';
        }
        field(44; "Created at"; DateTime)
        {
            Caption = 'Created at';
        }
        field(45; "Discharged By"; Code[50])
        {
            Caption = 'Discharged By';
        }
        field(46; "User ID"; Code[50])
        {
        }
        field(47; "Spousal Consent"; Boolean)
        {
            Caption = 'Spousal Consent';
        }
        field(49; "Land Control Board Consent"; Boolean)
        {
            Caption = 'Land Control Board';
        }
        field(50; "Next Valuation Date"; Date)
        {
            Editable = false;
        }
        field(51; "Perfection Stage"; Enum "Perfection Stages")
        {
            Caption = 'Perfection Stage';
        }
        field(52; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(53; "Amount To Charge"; Decimal)
        {
            Caption = 'Amount To Charge';
        }
        field(54; "Market Value"; Decimal)
        {
            Caption = 'Market Value';
        }
        field(55; "Force Sale Value"; Decimal)
        {
            Caption = 'Force Sale Value';
        }
        field(56; "Date of External Registration"; Date)
        {
            Caption = 'Date of Registration';
        }
        // field(57; "Loan Name"; Text[100])
        // {
        //     Caption = 'Loan Name';
        // }
        FIELD(57; "Return Comments"; Text[250])
        {
            Caption = 'Return Comments';

        }
        //field(58; "Perfection Summary"; Text[2048])
        field(58; "Perfection Summary"; Blob)
        {
            Caption = 'Perfection Summary';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //SaveRichText("Perfection Summary");
            end;
            // Multiline = true;
            // ExtendedDatatype = RichContent;
        }
        field(59; "Perfection Attachements"; Text[2048])
        {
            // Caption = 'Perfection Summary 2';
        }
        field(60; "Law Firm Address"; Code[50])
        {
            Caption = 'Law Firm Address';
        }
        field(61; "Law Firm Physical Address"; Text[250])
        {
            Caption = 'Law Firm Physical Address';
        }
        field(62; "Discharge Date"; Date)
        {
            Caption = 'Discharge Date';
        }
        field(63; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(64; "Lending Unit"; Enum "Source Unit")
        {
            Caption = 'Lending Unit';
            // OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            // OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(66; "Loan Offer Letter Date"; Date)
        {
            Caption = 'Loan Offer Letter Date';
        }
        field(67; "Security Category"; Text[10])
        {
            Caption = 'Security Category';
            TableRelation = "Property Category";
        }

        field(68; "Chargor/Owner Name"; Text[50])
        {
            Caption = 'Chargor/Owner Name';
        }

        field(69; "Chargor/Owner KRA PIN"; Code[50])
        {
            Caption = 'Chargor/Owner KRA PIN';
        }
        field(70; "Chargor/Owner ID No"; Code[50])
        {
            Caption = 'Chargor/Owner ID No.';
        }
        field(71; "Date of Coll. registration"; Date)
        {
            Caption = 'Date of registration';
        }
        field(72; "Date of Manufucture"; Date)
        {
            Caption = 'Date of Manufucture';
        }
        field(73; "Property Location"; text[30])
        {
            Caption = 'Property Location';

        }
        field(74; "Storage No"; Code[50])
        {
            Caption = 'Storage No.';

        }
        field(75; "Collateral Description"; Text[50])
        {
            Caption = 'Collateral Description';
        }
        field(76; "Lease/Ownership Exp. Date"; Date)
        {
            Caption = 'Lease/Ownership Expiry. Date';

        }
        field(77; "Collateral Owner"; Option)
        {
            Caption = 'Collateral Owner';
            OptionMembers = " ",Loanee,Chargor;
        }
        field(78; "Chargor Phone No."; Code[50])
        {
            Caption = 'Chargor Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(79; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
        }
        field(80; "Concatenated Property"; Text[2048])
        {
            Caption = 'Concatenated Property';
        }
        field(81; "Law Firm E-Mail"; Code[50])
        {
            Caption = 'Law Firm E-Mail';
            ExtendedDatatype = EMail;
        }
        field(82; "Law Firm E-Mail Sent"; Boolean)
        {
            Caption = 'Law Firm E-Mail Sent';
        }
        field(83; "Valuation Report"; Text[2048])
        {
            Caption = 'Valuation Report';
        }
        field(84; "Large Lext"; Blob)
        {
            Caption = 'Large Lext';
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    Var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Security Perfection No.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Security Perfection No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Security Perfection No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    local procedure concatenatepropertyforSMS()
    var
        myInt: Integer;
        HeaderRec: Record "Security Perfection";
        //LinesRec: Record "Perfection Lines";
        LinesRec: Record "Securities Register";
        Concatenatedproperty: Text[2048];
        LineCount: Integer;
        i: Integer;
        Property: Text;
    begin
        //HeaderRec.RESET;
        //HeaderRec.SETRANGE("Loan No.", Rec."Loan No.");
        //if HeaderRec.FINDFIRST() then begin
        LinesRec.RESET;
        LinesRec.SETRANGE("Loan No.", Rec."Loan No.");
        LinesRec.SetRange(Status, LinesRec.Status::Approved);
        LinesRec.Setrange("Collateral Discharged", false);
        LinesRec.Setrange("Collateral Perfected", false);
        LineCount := LinesRec.COUNT;
        if LinesRec.FIND('-') then begin
            i := 1;
            repeat
                Property := LinesRec."Charge Type" + ' over Property No. ' + LinesRec."Collateral Ref No." + ' ' + 'whose amount to charge was KES. ' + FORMAT(LinesRec."Amount to be Charged") + '.00' + ' ';
                if i = LineCount then
                    Concatenatedproperty += Property
                else
                    Concatenatedproperty += Property + 'and,' + ' ';
                i += 1;
            until LinesRec.NEXT = 0;
            Message('SMS Body: %1', Concatenatedproperty);
            Rec."Concatenated Property" := Concatenatedproperty;

            Rec.MODIFY;
        end
        else
            Error('No Collateral Found!');
        //end;
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
                PerfectionLines.Reset();
                PerfectionLines.SetRange("Loan No.", SecurityRegister."Loan No.");
                PerfectionLines.SetRange("Security No.", SecurityRegister."No.");
                if not PerfectionLines.FindFirst() then begin
                    PerfectionLines.init;
                    PerfectionLines."Loan No." := SecurityRegister."Loan No.";
                    PerfectionLines."Loan Name" := SecurityRegister."Loan Name";
                    PerfectionLines."Security No." := SecurityRegister."No.";
                    PerfectionLines."Property No." := SecurityRegister."Collateral Ref No.";
                    PerfectionLines."Collateral Value Sum" := SecurityRegister."Total Market Value";
                    PerfectionLines."Spousal Consent" := SecurityRegister."Spousal Consent";
                    PerfectionLines."Land Control Board Consent" := SecurityRegister."Land Control Board Consent";
                    PerfectionLines."Fees Payable to the firm" := SecurityRegister."Fees Payable to the Firm";
                    PerfectionLines."Status of the Fees" := SecurityRegister."Status of the Fees";
                    PerfectionLines."Amount To Charge" := SecurityRegister."Amount To Be Charged";
                    PerfectionLines."Market Value" := SecurityRegister."Market Value";
                    PerfectionLines."Forced Sale Value" := SecurityRegister."Forced Sale Value";
                    PerfectionLines."Collateral Types" := SecurityRegister."Collateral Type";
                    PerfectionLines."Chargor Name" := SecurityRegister."Chargor/Owner Name";
                    PerfectionLines."Chargor/Owner Name" := SecurityRegister."Chargor/Owner Name";
                    PerfectionLines."Chargor/Owner KRA PIN" := SecurityRegister."Chargor/Owner KRA PIN";
                    PerfectionLines."Charge Type" := format(Rec."Charge Type");
                    PerfectionLines."Collateral Owner" := Rec."Collateral Owner";
                    PerfectionLines."Chargor Phone No." := SecurityRegister."Chargor Phone No.";
                    PerfectionLines."Member No." := SecurityRegister."Account No.";
                    PerfectionLines.Insert();
                end;
            until SecurityRegister.Next = 0;
        end;
    end;

    procedure GetRichText(SecurityPerfect: record "Security Perfection"): Text
    var
        InStream: Instream;
        TypeHelper: Codeunit "Type Helper";
    begin
        Rec.CalcFields("Perfection Summary");
        Rec."Perfection Summary".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Perfection Summary")));
        // SecurityPerfect.CalcFields(SecurityPerfect."Perfection Summary");
        // SecurityPerfect."Perfection Summary".CreateInStream(InStream, TextEncoding::UTF8);
        // exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(Instream, TypeHelper.LFSeparator(), SecurityPerfect.FieldName(SecurityPerfect."Perfection Summary")));
        Message('Rich Text: %1', TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Perfection Summary")));
    end;

    procedure SaveRichText(RichText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."Perfection Summary");
        Rec."Perfection Summary".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(RichText);
        Rec.Modify();
        //Message('Rich Text: %1', RichText);
        //Message('Perfection Summary: %1', Rec."Perfection Summary");
    end;


    //procedure GetBlobContentAsText(): Text;
    // var
    //     InStream: InStream;
    //     TextValue: Text;
    //     BigTexTSummary: Text;
    // begin
    //     Rec.CalcFields(Rec."Perfection Summary");
    //     Rec."Perfection Summary".CreateInStream(InStream, TextEncoding::UTF8);
    //     InStream.ReadText(TextValue);
    //     exit(TextValue);
    // end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        XValue: code[50];
        RecordID: Code[50];
        SeriesSetup: Record "Credit Nos. Series";
        Members: Record Members;
        Loans: Record Loans;
        LoanGua: Record "Loan Guarantors and Security";
        SecurityCollection: Record "Securities Collection Register";
        SecurityRegister: Record "Securities Register";
        UserSetup: Record "User Setup";
        PerfectionLines: Record "Perfection Lines";
        Perfection: Record "Security Perfection";
}
