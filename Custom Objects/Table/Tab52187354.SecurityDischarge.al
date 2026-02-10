table 52187354 "Security Discharge"
{
    Caption = 'Security Discharge';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Security Discharge No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Perfection No."; Code[20])
        {
            Caption = 'Perfection No.';
            TableRelation = "Security Perfection"."No.";
            trigger OnValidate()
            begin
                SecurityPerfection.Get(SecurityPerfection."No.");
                SecurityPerfection.SetRange(SecurityPerfection."No.", "Perfection No.");
                if SecurityPerfection."No." <> '' then begin
                    "Security No." := SecurityPerfection."Security No.";
                    "Collateral Value Sum" := SecurityPerfection."Collateral Value Sum";
                    "Property Number" := SecurityPerfection."Property Number";
                    "Member No." := SecurityPerfection."Member No.";
                    "Member Name" := SecurityPerfection."Member Name";
                    "Loan No." := SecurityPerfection."Loan No.";
                    //"Loan Type" := SecurityPerfection."Loan Type";
                    "Loan Name" := SecurityPerfection."Loan Name";
                    "Collateral Types" := SecurityPerfection."Collateral Types";
                    //"Relevant Consents" := SecurityPerfection."Relevant Consents";
                    "Charge Type" := SecurityPerfection."Charge Type";
                end;
            end;
        }
        field(4; "Security No."; Code[20])
        {
            Caption = 'Security No.';   
        }
        field(5; "Collateral Value Sum"; Decimal)
        {
        }
        field(6; "Property Number"; Code[20])
        {
            Caption = 'Property Number';
        }
        field(7; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members;
        }
        field(8; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
        }
        field(9; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = Loans."Loan No.";
        }
        field(10; "Loan Type"; Code[20])
        {
            Caption = 'Loan Type';
            //OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(11; "Loan Name"; Text[100])
        {
            Caption = 'Loan Name';
        }
        field(12; "Collateral Types"; Option)
        {
            Caption = 'Collateral Types';
            OptionMembers = " ","Immovable","Chattels Mortgage","Cash Collaterals","Guarantors";
        }
        // field(13; "Relevant Consents"; Option)
        // {
        //     Caption = 'Relevant Consents';
        //     OptionMembers = " ","Spousal Consents","Land Control Board", "Others";
        //     trigger OnValidate()
        //     begin
        //         if "Relevant Consents" = "Relevant Consents"::"Others" then begin
        //             if Others = '' then
        //                 ERROR('Please Specify the Relevant Consent');
        //         end;
        //     end;
        // }
        field(14; "Charge Type"; Option)
        {
            Caption = 'Charge Type';
            OptionMembers = " CHARGE","Further Charge","Second Further Charge","Discharge";
        }
        field(15; "Law Firm Hanlding the Matter"; Text[100])
        {
            Caption = 'Law Firm Hanlding the Matter';
        }
        field(16; "Date of Issuance Instructions"; Date)
        {
            Caption = 'Date of Issuance of Instructions';
        }
        field(17; "Fees Payable to the firm"; Decimal)
        {
            Caption = 'Fees Payable to the firm';
        }
        field(18; "Status of the Fees"; Option)
        {
            Caption = 'Status of the Fees';
            OptionMembers = " ","Unpaid","Partially Paid","Paid";
        }
        field(19; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(21; "Valuation Comments"; Text[250])
        {
            Caption = 'Valuation Comments';
        }
        field(22; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = "Open","Pending","Approved","Completed","At Credit","Rejected","Deffered",Discharged;
        }
        
        field(23; "Collateral Status"; Option)
        {
            Caption = 'Collateral Status';
            OptionMembers = " ","Updated","Substituted","Discharged";
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(25; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(26; "Created by"; Code[50])
        {
            Caption = 'Created by';
            TableRelation = User;
        }
        field(27; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(28; "Modified by"; Code[50])
        {
            Caption = 'Modified by';
            TableRelation = User;
        }
        field(29; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(30; "Perfected"; Boolean)
        {
            Caption = 'Perfected';
        }
        field(31; "Date Perfected"; Date)
        {
            Caption = 'Date Perfected';
        }
        field(32; "Perfected By"; Code[50])
        {
            Caption = 'Perfected By';
        }
        field(33; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }
        field(34; Others; Text[250])
        {
            Caption = 'Others';
        }
        field(35; "Discharged"; Boolean)
        {
            Caption ='Discharged';
        }
        field(36; "Discharged On"; DateTime)
        {
            Caption = 'Discharged On';
        }
        field(37; "Created at"; DateTime)
        {
            Caption = 'Created at';
        }
        field(38; "Discharged By"; Code[50])
        {
            Caption = 'Discharged By';
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
            SeriesSetup.TestField(SeriesSetup."Security Discharge No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Security Discharge No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;
    end;

    var
    NoSeriesMgt: Codeunit NoSeriesManagement;
    XValue: code[50];
    RecordID: Code[50];
    SeriesSetup: Record "Credit Nos. Series";
    SecurityPerfection: Record "Security Perfection";
}
