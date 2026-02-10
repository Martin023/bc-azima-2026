table 52186062 "Delegate Region"
{
    DataCaptionFields = "Code", "Delegate Region Description", "Electoral Zone";
    DrillDownPageID = "Delegate Group Lists";
    LookupPageID = "Delegate Group Lists";

    fields
    {
        field(1; "Code"; Code[50])
        {
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
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
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
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
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
            MembNoSeries.TestField(MembNoSeries."Delegate Nos.");
            NoSeriesMgt.InitSeries(MembNoSeries."Delegate Nos.", xRec."No. Series", 0D, Code, "No. Series");
            "Created By" := UserId;
            "Creation Date" := Today;
        end;
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        DimensionValue: Record "Dimension Value";
        Members: Record Members;
}

