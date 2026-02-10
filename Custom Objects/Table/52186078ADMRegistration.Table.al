table 52186078 "ADM Registration"
{
    DataCaptionFields = "Code", "Delegate Region Description", "Electoral Zone";
    DrillDownPageID = "ADM Registration List";
    LookupPageID = "ADM Registration List";

    fields
    {
        field(1; "Reg No"; Code[50])
        {
            Editable = false;
        }
        field(2; "Code"; Code[50])
        {
            TableRelation = "Delegate Region" WHERE("Electoral Zone" = CONST('ALL'));

            trigger OnValidate()
            begin
                "Delegate Region Description" := '';
                "Electoral Zone" := '';
                "Electoral Zone Name" := '';
                "Global Dimension 1 Code" := '';
                "Global Dimension 1 Name" := '';
                "Global Dimension 2 Code" := '';
                "Global Dimension 2 Name" := '';
                County := '';
                "County Name" := '';
                "Sub-County" := '';
                "Sub-County Name" := '';
                "Region Code" := '';
                "Region Name" := '';


                DelegateRegion.Reset;
                DelegateRegion.SetRange(Code, Rec.Code);
                DelegateRegion.SetFilter("Electoral Zone", 'ALL');
                if DelegateRegion.FindFirst then begin
                    "Delegate Region Description" := DelegateRegion."Delegate Region Description";
                    "Electoral Zone" := DelegateRegion."Electoral Zone";
                    "Electoral Zone Name" := DelegateRegion."Electoral Zone Name";
                    "Global Dimension 1 Code" := DelegateRegion."Global Dimension 1 Code";
                    "Global Dimension 1 Name" := DelegateRegion."Global Dimension 1 Name";
                    "Global Dimension 2 Code" := DelegateRegion."Global Dimension 1 Name";
                    "Global Dimension 2 Name" := DelegateRegion."Global Dimension 2 Name";
                    County := DelegateRegion.County;
                    "County Name" := DelegateRegion."County Name";
                    "Sub-County" := DelegateRegion."Sub-County";
                    "Sub-County Name" := "Sub-County Name";
                    "Region Code" := DelegateRegion."Region Code";
                    "Region Name" := DelegateRegion."Region Name";

                end;
            end;
        }
        field(3; "Delegate Region Description"; Text[100])
        {
            Editable = false;
        }
        field(4; "Electoral Zone"; Code[50])
        {
            Description = 'lookup Electrol Zones/Area Svr Center (52018626) (Type=FILTER(Electral Zone))';
            Editable = false;
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = FILTER("Electral Zone"));

            trigger OnValidate()
            begin
                ElectrolZonesAreaSvrCenter.Reset;
                ElectrolZonesAreaSvrCenter.SetRange(Code, "Electoral Zone");
                ElectrolZonesAreaSvrCenter.SetRange(Type, ElectrolZonesAreaSvrCenter.Type::"Electral Zone");
                if ElectrolZonesAreaSvrCenter.Find('-') then begin
                    "Electoral Zone Name" := ElectrolZonesAreaSvrCenter.Description;
                end;
            end;
        }
        field(5; "Electoral Zone Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(9; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(10; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(11; County; Code[50])
        {
            Editable = false;
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
        field(12; "Sub-County"; Code[50])
        {
            Editable = false;
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
        field(13; "County Name"; Text[100])
        {
            Editable = false;
        }
        field(14; "Sub-County Name"; Text[100])
        {
            Editable = false;
        }
        field(15; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(16; "Global Dimension 1 Name"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code Name';
            Editable = false;
        }
        field(17; "Global Dimension 2 Name"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code Name';
            Editable = false;
        }
        field(18; "Region Code"; Code[50])
        {
            Editable = false;
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
        field(19; "Region Name"; Code[50])
        {
            Editable = false;
        }
        field(20; Type; Option)
        {
            OptionCaption = ' ADM';
            OptionMembers = " ADM";
        }
        field(21; "AGM Member No"; Code[20])
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
        field(22; "Member ID No"; Code[20])
        {
            Editable = false;
        }
        field(23; "Member Name"; Text[100])
        {
            Editable = false;
        }
        field(24; "AGM Year"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Reg No", "AGM Year")
        {
            Clustered = true;
        }
        // key(Key2;'')
        // {
        //     Enabled = false;
        // }
    }

    fieldgroups
    {
        fieldgroup(as; "Reg No", "Code", "Delegate Region Description")
        {
        }
    }

    trigger OnInsert()
    begin
        /*IF Code = '' THEN BEGIN
          MembNoSeries.GET;
          MembNoSeries.TESTFIELD(MembNoSeries."Delegate Nos.");
          NoSeriesMgt.InitSeries(MembNoSeries."Delegate Nos.",xRec."No. Series",0D,Code,"No. Series");
        "Created By":=USERID;
        "Creation Date":=TODAY;
        END;*/



        "Created By" := UserId;
        "Creation Date" := Today;
        "AGM Year" := Date2DMY("Creation Date", 3);
        "Reg No" := UserId;
        Rec.Reset;
        Rec.SetRange(Rec."Reg No", UserId);
        Rec.SetRange(Rec."AGM Year", Date2DMY("Creation Date", 3));
        if Rec.Find then begin
            Error('There is already another record under the same AGM Year');
        end;

    end;

    trigger OnModify()
    begin

        if UserId <> "Reg No" then Error('You can not edit this record');
        if "AGM Year" = 0 then "AGM Year" := Date2DMY("Creation Date", 3);
        if "AGM Year" <> Date2DMY(Today, 3) then Error('This card is for the year %1', "AGM Year");
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        DimensionValue: Record "Dimension Value";
        Members: Record Members;
        DelegateRegion: Record "Delegate Region";
}

