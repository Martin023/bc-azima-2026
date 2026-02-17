table 52186074 "Delegate Region Change"
{
    DataCaptionFields = "Code", "Delegate Region Description", "Electoral Zone";
    DrillDownPageID = "Delegate Group Change Lists";
    LookupPageID = "Delegate Group Change Lists";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; "Delegate Region Description"; Text[100])
        {
        }
        field(3; "Electoral Zone"; Code[50])
        {
            Description = 'lookup Electrol Zones/Area Svr Center (52018626) (Type=FILTER(Electral Zone))';
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = FILTER("Electral Zone"));

            trigger OnValidate()
            begin
                ElectrolZonesAreaSvrCenter.Reset;
                ElectrolZonesAreaSvrCenter.SetRange(Code, "Electoral Zone");
                ElectrolZonesAreaSvrCenter.SetRange(Type, ElectrolZonesAreaSvrCenter.Type::"Electral Zone");
                if ElectrolZonesAreaSvrCenter.Find('-') then begin
                    "Electoral Zone Name" := ElectrolZonesAreaSvrCenter.Description;
                    //"Previous Electral Zone Name":=ElectrolZonesAreaSvrCenter.Description;

                end;
            end;
        }
        field(4; "Electoral Zone Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := "Global Dimension 1 Code";
            end;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := "Global Dimension 2 Code";
            end;
        }
        field(7; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(8; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; County; Code[50])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));

            trigger OnValidate()
            begin
                SegmentCountyDividendSignat.Reset;
                SegmentCountyDividendSignat.SetRange(Code, County);
                SegmentCountyDividendSignat.SetRange(Type, SegmentCountyDividendSignat.Type::County);
                if SegmentCountyDividendSignat.Find('-') then begin
                    "County Name" := SegmentCountyDividendSignat.Description;
                    ;
                end;
            end;
        }
        field(11; "Sub-County"; Code[50])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Sub-County"));

            trigger OnValidate()
            begin
                SegmentCountyDividendSignat.Reset;
                SegmentCountyDividendSignat.SetRange(Code, "Sub-County");
                SegmentCountyDividendSignat.SetRange(Type, SegmentCountyDividendSignat.Type::"Sub-County");
                if SegmentCountyDividendSignat.Find('-') then begin
                    "Sub-County Name" := SegmentCountyDividendSignat.Description;
                    ;
                end;
            end;
        }
        field(12; "County Name"; Text[100])
        {
            Editable = false;
        }
        field(13; "Sub-County Name"; Text[100])
        {
            Editable = false;
        }
        field(14; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(17; "Global Dimension 1 Name"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code Name';
            Editable = false;
        }
        field(18; "Global Dimension 2 Name"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code Name';
            Editable = false;
        }
        field(19; "Region Code"; Code[50])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(Province));

            trigger OnValidate()
            begin
                SegmentCountyDividendSignat.Reset;
                SegmentCountyDividendSignat.SetRange(Code, "Region Code");
                SegmentCountyDividendSignat.SetRange(Type, SegmentCountyDividendSignat.Type::Province);
                if SegmentCountyDividendSignat.Find('-') then begin
                    "Region Name" := SegmentCountyDividendSignat.Description;
                    ;
                end;
            end;
        }
        field(20; "Region Name"; Code[50])
        {
            Editable = false;
        }
        field(21; Type; Option)
        {
            OptionCaption = 'Normal,ADM';
            OptionMembers = Normal,ADM;
        }
        field(22; "AGM Member No"; Code[20])
        {
            TableRelation = "Delegate Members"."Delegate MNO." WHERE(Code = FIELD(Code),
                                                                       "Attended AGM" = CONST(false));

            trigger OnValidate()
            var
                DelegateMemberss: Record "Delegate Members";
                CompInfo: Record "Company Information";
                SendSms: Codeunit SendSms;
                SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM;
                SavingsAccounts: Record "Savings Accounts";
                GeneralSetUp: Record "General Set-Up";
                EndDateSalo: Date;
                SalProc: Record "Salary Lines";
                Text009: Label 'Salary Must be through the SACCO.';
            begin
                GeneralSetUp.Get();
                EndDateSalo := CalcDate('-' + Format(GeneralSetUp."Salary Period"), Today);
                if "AGM Member No" <> '' then begin
                    SalProc.Reset;
                    SalProc.SetRange("Member No.", "AGM Member No");
                    SalProc.SetRange("Posting Date", EndDateSalo, Today);
                    SalProc.SetRange(Posted, true);
                    if not SalProc.Find('-') then begin
                        Error(Text009);
                    end;
                end;

                DelegateMemberss.Reset;
                DelegateMemberss.SetRange("Delegate MNO.", Rec."AGM Member No");
                DelegateMemberss.SetRange(Code, Rec.Code);
                if DelegateMemberss.Find('-') then begin
                    if Confirm('Are you sure you want to register ' + DelegateMemberss."Delegate Name" + '  for  ' + Rec."Delegate Region Description", true) = false then
                        exit;
                    "Member Name" := DelegateMemberss."Delegate Name";
                    Members.Reset;
                    Members.SetRange("No.", Rec."AGM Member No");
                    if Members.Find('-') then begin
                        "Member ID No" := Members."Primary Identification";
                    end;
                end;
            end;
        }
        field(23; "Member ID No"; Code[20])
        {
            Editable = false;
        }
        field(24; "Member Name"; Text[100])
        {
            Editable = false;
        }
        field(25; "Delegate Group Code"; Code[20])
        {
            TableRelation = "Delegate Region";

            trigger OnValidate()
            begin
                ClearFields;

                Region.Reset;
                Region.SetRange(Code, "Delegate Group Code");
                if Region.Find('-') then begin
                    "Delegate Region Description" := Region."Delegate Region Description";
                    "Electoral Zone" := Region."Electoral Zone";
                    "Electoral Zone Name" := Region."Electoral Zone Name";
                    "Global Dimension 1 Code" := Region."Global Dimension 1 Code";
                    "Global Dimension 1 Name" := Region."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Region."Global Dimension 2 Code";
                    "Global Dimension 2 Name" := Region."Global Dimension 2 Code";
                    County := Region.County;
                    "County Name" := Region."County Name";
                    "Sub-County" := Region."Sub-County";
                    "Sub-County Name" := Region."Sub-County Name";
                    "Region Code" := Region."Region Code";
                    "Region Name" := Region."Region Name";
                    "Previous Electral Zone Name" := Region."Delegate Region Description";


                end;
            end;
        }
        field(26; Upadated; Boolean)
        {
            Editable = false;
        }
        field(27; "Previous Electral Zone Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Delegate Region Description", "Electoral Zone")
        {
            Clustered = true;
        }
        key(Key2; "Delegate Region Description", "Electoral Zone")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(as; "Code", "Delegate Region Description", "Electoral Zone")
        {
        }
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Delega Change");
            Code := NoSeriesMgt.GetNextNo(MembNoSeries."Delega Change");
            // NoSeriesMgt.InitSeries(MembNoSeries."Delega Change", xRec."No. Series", 0D, Code, "No. Series");
            "Created By" := UserId;
            "Creation Date" := Today;
        end;
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        DimensionValue: Record "Dimension Value";
        Members: Record Members;
        Region: Record "Delegate Region";

    local procedure ClearFields()
    begin
        "Delegate Region Description" := '';
        "Electoral Zone" := '';
        "Electoral Zone Name" := '';
        "Global Dimension 1 Code" := '';
        "Global Dimension 2 Code" := '';
        County := '';
        "Sub-County" := '';
        "County Name" := '';
        "Sub-County Name" := '';
        "Global Dimension 1 Name" := '';
        "Global Dimension 2 Name" := '';
        "Region Code" := '';
        "Region Name" := '';
    end;

    // [Scope('OnPrem')]
    procedure Tracker(DRegion: Record "Delegate Region")
    var
        DelegateRegion: Record "Delegate Region Change";
    begin
        DelegateRegion.Reset;
        DelegateRegion.SetRange(DelegateRegion.Code, Code);
        if DelegateRegion.Find('-') then begin
            DRegion.Reset;
            DRegion.SetRange(Code, "Delegate Group Code");
            if DRegion.Find('-') then begin
                if xRec."Delegate Region Description" <> "Delegate Region Description" then
                    DRegion.Validate(DRegion."Delegate Region Description", "Delegate Region Description");
                if xRec."Electoral Zone" <> "Electoral Zone" then
                    DRegion.Validate(DRegion."Electoral Zone", "Electoral Zone");
                DRegion."Electoral Zone" := "Electoral Zone";
                if xRec."Electoral Zone Name" <> "Electoral Zone Name" then
                    DRegion.Validate(DRegion."Electoral Zone Name", "Electoral Zone Name");
                if xRec."Global Dimension 1 Code" <> "Global Dimension 1 Code" then
                    DRegion.Validate(DRegion."Global Dimension 1 Code", "Global Dimension 1 Code");
                if xRec."Global Dimension 1 Name" <> "Global Dimension 1 Name" then
                    DRegion.Validate(DRegion."Global Dimension 1 Name", "Global Dimension 1 Name");
                if xRec."Global Dimension 2 Code" <> "Global Dimension 2 Code" then
                    DRegion.Validate(DRegion."Global Dimension 2 Code", "Global Dimension 2 Code");
                if xRec.County <> County then
                    DRegion.Validate(DRegion.County, County);
                if xRec."County Name" <> "County Name" then
                    DRegion.Validate(DRegion."County Name", "County Name");
                if xRec."Sub-County" <> "Sub-County" then
                    DRegion.Validate(DRegion."Sub-County", "Sub-County");
                if xRec."Sub-County Name" <> "Sub-County Name" then
                    DRegion.Validate(DRegion."Sub-County Name", "Sub-County Name");
                //IF xRec."Region Code"<>"Region Code" THEN
                //  DRegion.VALIDATE(DRegion."Region Code","Region Code");
                DRegion."Region Code" := "Region Code";
                if xRec."Region Name" <> "Region Name" then
                    DRegion.Validate(DRegion."Region Name", "Region Name");
                DRegion.Modify;
            end;
            DelegateRegion.Upadated := true;
            DelegateRegion.Modify;
        end;
    end;
}

