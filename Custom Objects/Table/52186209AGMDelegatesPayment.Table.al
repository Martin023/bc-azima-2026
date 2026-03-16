table 52186209 "AGM Delegates Payment"
{
    DrillDownPageID = "Delegates Payment List";
    LookupPageID = "Delegates Payment List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; "Delegate Region"; Code[20])
        {
            Description = 'Lookup to 52018551';
            TableRelation = "Delegate Region".Code;

            trigger OnValidate()
            begin
                DelegateGroup.Reset;
                DelegateGroup.SetRange(Code, "Delegate Region");
                if DelegateGroup.Find('-') then begin
                    "Delegate Region Description" := DelegateGroup."Delegate Region Description";
                    if DelegateGroup.Type = DelegateGroup.Type::ADM then begin
                        "Payment Made To" := DelegateGroup."Delegate Region Description";
                        "Payment Frequency" := "Payment Frequency"::Annual;
                    end else
                        "Payment Frequency" := "Payment Frequency"::Monthly;
                end;
                "Posting Date" := 0D;
                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(Code, "Delegate Code");
                if DelegateMemberss.Find('-') then begin
                    "Delegate Code" := DelegateMemberss."Delegate Code";
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
            TableRelation = "Electoral Zones".Code WHERE(Status = FILTER(Approved));

            trigger OnValidate()
            begin
                ElectoralZone.Reset;
                ElectoralZone.SetRange(Code, "Electoral Zone");
                if ElectoralZone.Find('-') then begin
                    "Electoral Zone Name" := ElectoralZone."Electoral Zone Name";
                    "Global Dimension 1 Code" := ElectoralZone."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := ElectoralZone."Global Dimension 2 Code";

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
        field(16; "Amount To Pay"; Decimal)
        {
        }
        field(17; Posted; Boolean)
        {
            Editable = false;
        }
        field(18; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(19; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(20; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                // "Payment Description" := Format("Posting Date", 0, '<Month Text>') + ' - ' + Format(Date2DMY("Posting Date", 3));

                // TestField("Payment Frequency");
                // TestField("Delegate Region");
                // if "Payment Frequency" = "Payment Frequency"::Weekly then
                //     "Period Ending Date" := CalcDate('CW', "Posting Date") else
                //     if "Payment Frequency" = "Payment Frequency"::Monthly then
                //         "Period Ending Date" := CalcDate('CM', "Posting Date") else
                //         if "Payment Frequency" = "Payment Frequency"::Quartely then
                //             "Period Ending Date" := CalcDate('CQ', "Posting Date") else
                //             if "Payment Frequency" = "Payment Frequency"::"Semi Annual" then
                //                 "Period Ending Date" := CalcDate('-6M', (CalcDate('CY', "Posting Date"))) else
                //                 if "Payment Frequency" = "Payment Frequency"::Annual then
                //                     "Period Ending Date" := CalcDate('CY', "Posting Date") else
                //                     "Period Ending Date" := CalcDate('CM', "Posting Date");
                // DelegateGroupss.Reset;
                // DelegateGroupss.SetRange(Code, "Delegate Region");
                // if DelegateGroupss.Find('-') then
                // //IF DelegateGroupss.GET("Delegate Group") THEN
                // begin
                //     "Delegate Region Description" := DelegateGroupss."Delegate Region Description";
                //     "Electoral Zone" := DelegateGroupss."Electoral Zone";
                //     Validate("Electoral Zone");
                //     "Global Dimension 1 Code" := DelegateGroupss."Global Dimension 1 Code";
                //     "Global Dimension 2 Code" := DelegateGroupss."Global Dimension 2 Code";
                //     "Created By" := UserId;
                //     "Creation Date" := Today;
                //     County := DelegateGroupss.County;
                //     Validate(County);
                //     "Sub-County" := DelegateGroupss."Sub-County";
                //     Validate("Sub-County");
                //     //Delete existing Lines
                //     DelegatePaymentLines.Reset;
                //     DelegatePaymentLines.SetRange(Code, Code);
                //     DelegatePaymentLines.SetRange(Posted, false);
                //     if DelegatePaymentLines.Find('-') then begin
                //         repeat
                //             DelegatePaymentLines.Delete;
                //         until DelegatePaymentLines.Next = 0;
                //     end;
                //     //Insert Payment Lines with the members
                //     MyRec2.Reset;
                //     if MyRec2.Find('-') then
                //         LineNo := MyRec2."Entry No" + 1
                //     else
                //         LineNo := 1;
                //     DelegateMemberss.Reset;
                //     DelegateMemberss.SetRange(Code, "Delegate Region");
                //     DelegateMemberss.SetRange(DelegateMemberss.Retired, false);
                //     DelegateMemberss.SetRange(Type, DelegateMemberss.Type::Normal);
                //     if DelegateMemberss.Find('-') then begin
                //         repeat
                //             LineNo += 1;
                //             DelegatePaymentLine.Init;
                //             DelegatePaymentLine."Entry No" := LineNo + 1;
                //             DelegatePaymentLine.Code := Code;
                //             DelegatePaymentLine."Delegate Region" := "Delegate Region";
                //             DelegatePaymentLine."Delegate MNO." := DelegateMemberss."Delegate MNO.";
                //             DelegatePaymentLine."Delegate Name" := DelegateMemberss."Delegate Name";
                //             DelegatePaymentLine.Position := DelegateMemberss.Position;
                //             DelegatePaymentLine."Job Tittle" := DelegateMemberss."Job Tittle";
                //             DelegatePaymentLine."Service Period" := DelegateMemberss."Service Period";
                //             DelegatePaymentLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                //             DelegatePaymentLine."Global Dimension 2 Code" := "Global Dimension 2 Code";
                //             DelegatePaymentLine."Electoral Zone" := DelegateGroupss."Electoral Zone";
                //             DelegatePaymentLine."Electoral Zone Name" := DelegateGroupss."Electoral Zone Name";
                //             DelegatePaymentLine."Period Ending Date" := "Period Ending Date";
                //             DelegatePaymentLine.Validate("Delegate MNO.");
                //         //DelegatePaymentLine.INSERT;
                //         until DelegateMemberss.Next = 0;
                //     end;
               // end;
               // Validate("Period Ending Date");
            end;
        }
        field(21; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(22; "Payment Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(23; "Total Payment"; Decimal)
        {
            CalcFormula = Sum("AGM Delegate Payment Line"."Amount Payable" WHERE(Code = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Transaction Type"; Code[20])
        {
            // TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Delegates Payment" | "Delegates Special"));

            // trigger OnValidate()
            // begin
            //     "Posting Date" := Today;
            //     "Period Ending Date" := 0D;
            //     Validate("Posting Date");


            //     DelegatePaymentLines.Reset;
            //     DelegatePaymentLines.SetRange(Code, Rec.Code);
            //     if DelegatePaymentLines.Find('-') then
            //         DelegatePaymentLines.DeleteAll;
            // end;
        }
        field(25; "Payment Frequency"; Option)
        {
            OptionCaption = ' ,Weekly,Monthly,Quartely,Semi Annual,Annual';
            OptionMembers = " ",Weekly,Monthly,Quartely,"Semi Annual",Annual;
        }
        field(26; "Period Ending Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                // DelegatesPayments.Reset;
                // DelegatesPayments.SetFilter("Payment Frequency", '<>%1', DelegatesPayments."Payment Frequency"::Annual);
                // DelegatesPayments.SetRange("Period Ending Date", "Period Ending Date");
                // DelegatesPayments.SetRange(DelegatesPayments."Delegate Region", "Delegate Region");
                // DelegatesPayments.SetRange("Transaction Type", "Transaction Type");
                // DelegatesPayments.SetFilter(Code, '<>%1', Code);
                // if DelegatesPayments.Find('-') then begin
                //     Error('payment to has already been done using document %1', DelegatesPayments.Code);
                // end;
            end;
        }
        field(27; "Payment Made To"; Text[50])
        {
        }
        field(28; "Minute No."; Code[30])
        {
            TableRelation = "Delegates Minutes Header".Code;
            trigger OnValidate()
            var
                EntryNo: Integer;
            begin
                DelegateLines.reset();
                DelegateLines.setrange(Code, rec.Code);
                if DelegateLines.Find('-') then DelegateLines.DeleteAll();

                //Get into transaction types table and loop
                TransactionTypes.reset();
                TransactionTypes.Setrange(type, TransactionTypes.type::"Delegates Payment");
                if TransactionTypes.find('-') then begin
                repeat
                    Transactioncharges.reset();
                    Transactioncharges.setrange("Transaction Type", TransactionTypes.Code);
                    if Transactioncharges.FindFirst() then begin
                        //Get into delegates meeting attendees and loop
                        DelegatesMeetingAttendees.reset();
                        DelegatesMeetingAttendees.SetRange("Header No", rec."Minute No.");
                        if DelegatesMeetingAttendees.FindSet() then begin

                            repeat
                                //Get their account no//Amount to be paid
                                //insert into payment lines
                                DelegateLines.Reset();
                                if DelegateLines.FindLast() then
                                    EntryNo := DelegateLines."Entry No" + 1;
                                DelegateLines.Init();
                                DelegateLines."Entry No" := EntryNo;
                                DelegateLines.Code := rec.Code;
                                DelegateLines."Delegate MNO." := DelegatesMeetingAttendees."Delegate No.";
                                DelegateLines."Delegate Name" := DelegatesMeetingAttendees."Delegate Name";
                                DelegateLines."Amount Payable" := Transactioncharges."Charge Amount";
                                DelegateLines."Account No":=Transactioncharges."G/L Account";

                                DelegateLines.Insert(true);
                            until DelegatesMeetingAttendees.Next() = 0;

                        end;
                    end;
               
                //Get into delegates meeting attendees end loop
                until TransactionTypes.Next() = 0;
                //Get into transaction types table end loop
                end;

            end;
        }
        field(29; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(30; "Delegate Code"; Code[20])
        {
        }
        field(31; Type; Option)
        {
            OptionCaption = 'Normal,ADM';
            OptionMembers = Normal,ADM;
        }
        field(32; "Transaction Code"; Code[20])
        {
            //TableRelation = "Transaction Types".Code;
        }
        field(33; "Claim Type"; Option)
        {
            OptionMembers = "Sitting Allowance","Transport Allowance";
        }
        field(34; quarter; Option)
        {
            OptionMembers = first,second,third,fourth;
        }
    }

    keys
    {
        key(Key1; "Code", "Payment Frequency")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Delegate Payment Nos.");
            Code := NoSeriesMgt.GetNextNo(MembNoSeries."Delegate Payment Nos.");
            // NoSeriesMgt.InitSeries(MembNoSeries."Delegate Payment Nos.", xRec."No. Series", 0D, Code, "No. Series");
            "Created By" := UserId;
            "Creation Date" := Today;
            "Document No." := Code;
        end;
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        DelegateGroupss: Record "Delegate Region";
        DelegateMemberss: Record "Delegate Members";
        DelegatePaymentLine: Record "Delegate Payment Line";
        DelegatePaymentLines: Record "Delegate Payment Line";
        MyRec2: Record "Delegate Payment Line";
        LineNo: Integer;
        DelegateGroups: Record "Delegate Region";
        DelegatesPayments: Record "Delegates Payment";
        DelegateGroup: Record "Delegate Region";
        ElectoralZone: Record "Electoral Zones";
        Minutes: Record "Delegates Minutes Header";
        DelegateLines: Record "AGM Delegate Payment Line";
        DelegatesMeetingAttendees: Record "Delegates Meeting Attendees";
        TransactionTypes: Record "Transaction Types";
        Transactioncharges: Record "Transaction Charges";
}

