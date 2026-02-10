codeunit 52185427 "NCBA Integration"
{
    procedure GetPensionProcessAmount(pensionNo: Text; pensionAmount: Decimal; referenceNo: Text): Text
    var
        PensionBuffer: Record "NCBA Pension Buffer";
        TheMember: Record Members;
        SalaryLine: Record "Salary Lines";
        SavingsAccounts: Record "Savings Accounts";

        MemberExists: Boolean;
        ResponseObject: JsonObject;
        Response: Text;
        FosaAccountNo: Text;

        SalaryHeaderNo: Text;
        CurrentDate: Date;
        Year: Integer;
        Month: Integer;
        Day: Integer;
    begin
        PensionBuffer.Reset();
        PensionBuffer.SetRange("referenceNumber", referenceNo);
        if PensionBuffer.FindFirst() then begin
            ResponseObject.Add('status', 'FAILED');
            ResponseObject.Add('status_description', 'Reference number already exists');
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MemberExists := false;
        TheMember.Reset();
        TheMember.SetRange("No.", pensionNo);
        if TheMember.FindFirst() then begin
            MemberExists := true;
        end;

        FosaAccountNo := SkyMbankingTrans.GetMemberFosaAcc(TheMember);

        //Clear(PensionBuffer);
        PensionBuffer.Init();
        PensionBuffer."accountNo" := FosaAccountNo;
        PensionBuffer."Name" := TheMember."Name";
        PensionBuffer."Company" := TheMember."Employer Code";
        PensionBuffer."pensionNumber" := pensionNo;
        PensionBuffer."referenceNumber" := referenceNo;
        PensionBuffer."Amount" := pensionAmount;
        PensionBuffer."dateEntered" := CurrentDateTime();
        PensionBuffer."Needs Change" := not MemberExists;

        if MemberExists then begin
            if TheMember."Employer Code" = 'KPC_RBS' then begin
                PensionBuffer."Income Type" := PensionBuffer."Income Type"::Salary;
            end else begin
                PensionBuffer."Income Type" := PensionBuffer."Income Type"::Pension;
            end;
        end else begin
            PensionBuffer."Income Type" := PensionBuffer."Income Type"::Pension;
        end;

        PensionBuffer.Insert(true);

        if MemberExists then begin
            SavingsAccounts.Reset();
            SavingsAccounts.SetRange("No.", FosaAccountNo);
            if SavingsAccounts.FindFirst() then begin
                //SalaryHeaderNo := 'NCBA' + GlobalFunctions.FormatCRBDate(Today);
                SalaryHeaderNo := referenceNo;
                SalaryLine.Init();
                SalaryLine."Account Not Found" := false;
                SalaryLine."Account No." := FosaAccountNo;
                SalaryLine."Salary Header No." := SalaryHeaderNo;
                SalaryLine."Blocked Accounts" := SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" ";
                SalaryLine."ID No." := SavingsAccounts."ID No.";
                SalaryLine.Name := TheMember."Name";
                SalaryLine.Amount := pensionAmount;
                SalaryLine."Employer Code" := SavingsAccounts."Employer Code";
                SalaryLine."Member No." := SavingsAccounts."Member No.";
                SalaryLine."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                SalaryLine."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
                SalaryLine.Status := SavingsAccounts.Status;
                SalaryLine."Income Type" := PensionBuffer."Income Type";
                SalaryLine.Posted := false;
                SalaryLine."Posting Date" := Today;
                SalaryLine."Posting Time" := Time;
                SalaryLine."Actual Date Posted" := Today;
                SalaryLine.Date := Today;
                SalaryLine.Insert(true);

                SaccoTrans.PostPensionLine(SalaryLine);

                PensionBuffer."Posted" := true;

                PensionBuffer."postingDate" := CurrentDateTime;
                PensionBuffer.Modify();
            end;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Processed Successfully');
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    procedure NCBAPostPension(): Text
    var
        PensionBuffer: Record "NCBA Pension Buffer";
        SalaryLine: Record "Salary Lines";
        SavingsAccounts: Record "Savings Accounts";
        SalaryHeaderNo: Text;
        ResponseObject: JsonObject;
        Response: Text;
    begin
        PensionBuffer.Reset();
        PensionBuffer.SetRange(Posted, false);
        PensionBuffer.SetRange("Needs Change", false);

        if PensionBuffer.FindSet() then begin
            repeat
                SalaryHeaderNo := PensionBuffer."referenceNumber";
                SalaryLine.Init();
                SalaryLine."Account Not Found" := false;
                SalaryLine."Account No." := PensionBuffer."accountNo";
                SalaryLine."Salary Header No." := SalaryHeaderNo;
                SalaryLine."Blocked Accounts" := SavingsAccounts.Blocked <> SavingsAccounts.Blocked::" ";
                SalaryLine."ID No." := SavingsAccounts."ID No.";
                SalaryLine.Name := SavingsAccounts."Name";
                SalaryLine.Amount := PensionBuffer."Amount";
                SalaryLine."Employer Code" := SavingsAccounts."Employer Code";
                SalaryLine."Member No." := SavingsAccounts."Member No.";
                SalaryLine."Global Dimension 1 Code" := SavingsAccounts."Global Dimension 1 Code";
                SalaryLine."Global Dimension 2 Code" := SavingsAccounts."Global Dimension 2 Code";
                SalaryLine.Status := SavingsAccounts.Status;
                SalaryLine."Income Type" := PensionBuffer."Income Type";
                SalaryLine.Posted := false;
                SalaryLine."Posting Date" := Today;
                SalaryLine."Posting Time" := Time;
                SalaryLine."Actual Date Posted" := Today;
                SalaryLine.Date := Today;
                SalaryLine.Insert(true);

                SaccoTrans.PostPensionLine(SalaryLine);

                PensionBuffer."Posted" := true;

                PensionBuffer."postingDate" := CurrentDateTime();
                PensionBuffer.Modify(true);

            until (PensionBuffer.Next() = 0);
        end;

        ResponseObject.Add('response_status', 'SUCCESS');
        ResponseObject.Add('response_status_description', 'Pension processed successfully');
        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime()));
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;

        RequestPayload: JsonToken;
        TokenExists: Boolean;
    begin
        RequestParser.ReadFrom(Request);
        RequestParser.SelectToken('$.action', RequestAction);
        TokenExists := RequestParser.SelectToken('$.payload', RequestPayload);

        case RequestAction.AsValue().AsText() of
            'CALL_SERVICE':
                exit(NCBAPostPension());

            'VALIDATE_PAYMASTER':
                exit(ValidatePaymaster(RequestPayload.AsObject));
            'CREATE_CONFIRM_CHECKOFF_ADVISE':
                exit(CreateCheckoffAdvise(RequestPayload.AsObject));
            'GENERATE_CHECKOFF_ADVISE':
                exit(GenerateCheckoffAdvise(RequestPayload.AsObject));
            'GET_CHECKOFF_DETAILS':
                exit(GetCheckoffDetails(RequestPayload.AsObject));
            'APPROVE_CHECKOFF':
                exit(ApproveCheckoff(RequestPayload.AsObject));
            'POST_PAYMENT_IN_BANK':
                exit(PostPaymentInBank(RequestPayload.AsObject));

            'POST_CHECKOFF':
                exit(PostCheckoff(RequestPayload.AsObject));
            else
                exit(UnsupportedAction(RequestAction.AsValue.AsText))
        end;
    end;

    local procedure ValidatePaymaster(Payload: JsonObject): Text
    var
        PaymasterCode: JsonToken;

        Employers: Record Customer;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('PaymasterCode', PaymasterCode);

        Employers.Reset;
        Employers.SetRange("No.", PaymasterCode.AsValue.AsText);
        Employers.SetRange("Account Type", Employers."Account Type"::Employer);
        Employers.SetRange(Blocked, Employers.Blocked::" "); // Not blocked

        if Employers.FindFirst then begin
            /*
            {
                "Status": "000",
                "PaymasterCode": "REGENT",
                "Name": "REGENT COLLECTORS AND REALTORS",
                "Msg": "Validated successfully"
            }
            */
            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('Status', '000');
            Datum.Add('PaymasterCode', Employers."No.");
            Datum.Add('Name', Employers.Name);
            Datum.Add('Msg', 'Validated successfully');
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('Status', '');
            Datum.Add('PaymasterCode', '');
            Datum.Add('Name', '');
            Datum.Add('Msg', 'Invalid Paymaster');
        end;


        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateCheckoffAdvise(Payload: JsonObject): Text
    var
        PaymasterCode: JsonToken;
        PayRollMonth: JsonToken;
        RequestNo: JsonToken;
        AdviceType: JsonToken;

        Employers: Record Customer;
        CheckoffDates: List of [Date];
        CheckoffAdvise: Record "Checkoff Advice Header";

        PeriodicActivities: Codeunit "Periodic Activities";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('PaymasterCode', PaymasterCode);
        Payload.Get('PayRollMonth', PayRollMonth);
        Payload.Get('RequestNo', RequestNo);
        Payload.Get('AdviceType', AdviceType); // LOAN, SAVINGS

        Employers.Reset;
        Employers.SetRange("No.", PaymasterCode.AsValue.AsText);

        if Employers.FindFirst then begin
            CheckoffAdvise.Reset;
            CheckoffAdvise.SetRange("Amali Ref", RequestNo.AsValue.AsText);
            CheckoffAdvise.SetRange("Employer Code", PaymasterCode.AsValue.AsText);
            if CheckoffAdvise.FindFirst then begin
                // ResponseObject.Add('request_status', 'FAILED');

                // Datum.Add('Status', '');
                // Datum.Add('PaymasterCode', PaymasterCode);
                // Datum.Add('AdviceNo', '');
                // Datum.Add('RequestNo', RequestNo);
                // Datum.Add('Msg', 'Checkoff advise with ref ' + RequestNo.AsValue().AsText() + ' for employer ' + PaymasterCode.AsValue.AsText + ' already exists!');

                ResponseObject.Add('request_status', 'SUCCESS');

                Datum.Add('Status', '000');
                Datum.Add('PaymasterCode', CheckoffAdvise."Employer Code");
                Datum.Add('AdviceNo', CheckoffAdvise."No.");
                Datum.Add('RequestNo', RequestNo);
                Datum.Add('CheckoffCreationStatus', 'COMPLETED');

                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                exit(Response);
            end;
            /*
            {
                "PaymasterCode": "PETROCITY",
                "PayRollMonth": "082025",
                "RequestNo": "{{guid}}",
                "AdviceType": "CAR"
            }
            */
            CheckoffDates := GlobalFunctions.GetMonthStartAndEndDate(PayRollMonth.AsValue.AsText);
            CheckoffAdvise.Reset;

            CheckoffAdvise.Init;
            CheckoffAdvise."No." := '';
            CheckoffAdvise."Employer Code" := Employers."No.";
            CheckoffAdvise.Validate("Employer Code");

            CheckoffAdvise."Start Date" := CheckoffDates.Get(1);
            CheckoffAdvise.Validate("Start Date");
            CheckoffAdvise."End Date" := CheckoffDates.Get(2);
            CheckoffAdvise.Processed := true;
            CheckoffAdvise."Loan Issue Cut OFF Date" := CheckoffDates.Get(1);
            CheckoffAdvise."Loan Interest Cut OFF Date" := CheckoffDates.Get(2);

            CheckoffAdvise."Amali Advise Type" := AdviceType.AsValue.AsText;
            CheckoffAdvise."Amali Ref" := RequestNo.AsValue.AsText;

            if CheckoffAdvise.Insert(true) then begin
                case AdviceType.AsValue.AsText.ToUpper of
                    'LOAN':
                        PeriodicActivities.MonthlyCheckoffAdviceLn(CheckoffAdvise);
                    'SAVINGS':
                        PeriodicActivities.MonthlyCheckoffAdviceSavAPI(CheckoffAdvise);
                    else begin
                        ResponseObject.Add('request_status', 'FAILED');

                        Datum.Add('Status', '');
                        Datum.Add('PaymasterCode', '');
                        Datum.Add('Name', '');
                        Datum.Add('Msg', 'Invalid advise type. Must either be LOAN or SAVINGS');

                        ResponseObject.Add('response_payload', Datum);
                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);

                        exit(Response);
                    end;
                end;
                /*
                {
                    "Status": "000",
                    "PaymasterCode": "REGENT",
                    "AdviceNo": "ADV123456789",
                    "RequestNo": "123456789",
                    "CheckoffCreationStatus": "IN_PROGRESS/COMPLETED"
                }
                */
                ResponseObject.Add('request_status', 'SUCCESS');

                Datum.Add('Status', '000');
                Datum.Add('PaymasterCode', CheckoffAdvise."Employer Code");
                Datum.Add('AdviceNo', CheckoffAdvise."No.");
                Datum.Add('RequestNo', RequestNo);
                Datum.Add('CheckoffCreationStatus', 'COMPLETED');
            end;
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('Status', '');
            Datum.Add('PaymasterCode', '');
            Datum.Add('Name', '');
            Datum.Add('Msg', 'Invalid Paymaster');
        end;


        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GenerateCheckoffAdvise(Payload: JsonObject): Text
    var
        CheckoffAdviceNo: JsonToken;

        CheckoffDates: List of [Date];
        CheckoffAdvise: Record "Checkoff Advice Header";

        PeriodicActivities: Codeunit "Periodic Activities";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        /*
        {
            "CheckoffAdviceNo": "ADV123456789"
        }
        */
        Payload.Get('CheckoffAdviceNo', CheckoffAdviceNo);

        CheckoffAdvise.Reset;
        CheckoffAdvise.SetRange("No.", CheckoffAdviceNo.AsValue.AsText);
        if CheckoffAdvise.FindFirst then begin
            // Generate Lines
            // PeriodicActivities.MonthlyCheckoffAdviceLn(CheckoffAdvise);
            // PeriodicActivities.MonthlyCheckoffAdviceSavAPI(CheckoffAdvise);

            // ResponseObject.Add('request_status', 'SUCCESS');

            // Datum.Add('Status', '000');
            // Datum.Add('CheckOffAdviseNo', CheckoffAdvise."No.");
            // Datum.Add('CheckoffGenerationStatus', 'COMPLETED');

            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('Status', '000');
            Datum.Add('CheckOffAdviseNo', CheckoffAdvise."No.");
            Datum.Add('CheckoffGenerationStatus', 'COMPLETED');

            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('Msg', 'Checkoff advise with ref ' + CheckoffAdviceNo.AsValue().AsText() + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    // local procedure GetCheckoffDetails(Payload: JsonObject): Text
    // var
    //     CheckoffAdviceNo: JsonToken;

    //     CheckoffDates: List of [Date];
    //     CheckoffAdvise: Record "Checkoff Advice Header";
    //     CheckoffAdviceLines: Record "Checkoff Advice Line";
    //     CheckoffAdviceLineList: JsonArray;
    //     CheckoffAdviceLine: JsonObject;

    //     LoopCount: Integer;
    //     CurrMemberNo: Text;
    //     CurrSavingsCount: Integer;
    //     CurrLoanAmount: Decimal;
    //     LoanAmount: JsonToken;

    //     PeriodicActivities: Codeunit "Periodic Activities";

    //     ResponseObject: JsonObject;
    //     Datum: JsonObject;
    //     Response: Text;
    // begin
    //     /*
    //     {
    //         "CheckoffAdviceNo": "ADV123456789"
    //     }
    //     */
    //     Payload.Get('CheckoffAdviceNo', CheckoffAdviceNo);

    //     CheckoffAdvise.Reset;
    //     CheckoffAdvise.SetRange("No.", CheckoffAdviceNo.AsValue.AsText);
    //     if CheckoffAdvise.FindFirst then begin
    //         ResponseObject.Add('request_status', 'SUCCESS');
    //         /*
    //         {
    //             "CheckoffAdviceNo": "ADV123456789",
    //             "PaymasterCode": "REGENT",
    //             "Period": "AUGUST 2025",
    //             "RequestNo": "123456789",
    //             "StartDate": "01082025",
    //             "EndDate": "310082025",
    //             "CheckoffAdviceLines": [
    //                 {
    //                     "MemberNo": "02133",
    //                     "StaffNo": "101",
    //                     "Names": "John Van Doe",
    //                     "LoanAmount": "350000",
    //                     "FOSASavingsAmount": "320000",
    //                     "BOSASavingsAmount": "2500000",
    //                     "TotoJuniosSavingsAmount": "250000"
    //                 }
    //             ]
    //         }
    //         */
    //         Datum.Add('CheckoffAdviceNo', CheckoffAdvise."No.");
    //         Datum.Add('PaymasterCode', CheckoffAdvise."Employer Code");
    //         Datum.Add('Period', CheckoffAdvise.Period);
    //         Datum.Add('RequestNo', CheckoffAdvise."Amali Ref");
    //         Datum.Add('StartDate', GlobalFunctions.FormatNCBACheckoffDate(CheckoffAdvise."Start Date"));
    //         Datum.Add('EndDate', GlobalFunctions.FormatNCBACheckoffDate(CheckoffAdvise."End Date"));

    //         // Checkoff advise lines
    //         CheckoffAdviceLines.Reset;
    //         CheckoffAdviceLines.SetRange("Advice Header No.", CheckoffAdvise."No.");
    //         CheckoffAdviceLines.SetCurrentKey("Member No.");
    //         CheckoffAdviceLines.SetAscending("Member No.", true);

    //         if CheckoffAdviceLines.FindSet then begin
    //             LoopCount := 0;
    //             CurrMemberNo := '';
    //             CurrSavingsCount := 0;

    //             repeat begin
    //                 if (LoopCount = 0) or (CurrMemberNo <> CheckoffAdviceLines."Member No.") then begin
    //                     if CurrMemberNo <> '' then begin
    //                         if CurrMemberNo <> CheckoffAdviceLines."Member No." then begin
    //                             // Add to array list
    //                             CheckoffAdviceLineList.Add(CheckoffAdviceLine);
    //                             LoopCount := 0;
    //                             CurrSavingsCount := 0;
    //                         end;
    //                     end;

    //                     // Create new object
    //                     Clear(CheckoffAdviceLine);
    //                     CurrMemberNo := CheckoffAdviceLines."Member No.";

    //                     CheckoffAdviceLine.Add('MemberNo', CheckoffAdviceLines."Member No.");
    //                     CheckoffAdviceLine.Add('StaffNo', CheckoffAdviceLines."Payroll No");
    //                     CheckoffAdviceLine.Add('Names', CheckoffAdviceLines.Names);

    //                     if CheckoffAdvise."Amali Advise Type".ToUpper = 'LOAN' then begin
    //                         CheckoffAdviceLine.Add('LoanAmount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                     end else begin
    //                         CheckoffAdviceLine.Add('LoanAmount', '0.00');
    //                     end;

    //                     if CheckoffAdvise."Amali Advise Type".ToUpper = 'SAVINGS' then begin
    //                         CheckoffAdviceLine.Add('Savings800Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                         CheckoffAdviceLine.Add('Savings801Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings802Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings803Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings804Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings8051Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings8052Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings806Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings807Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings808Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings809Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings813Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings814Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings815Amount', '0.00');

    //                         CurrSavingsCount += 1;
    //                     end else begin
    //                         CheckoffAdviceLine.Add('Savings800Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings801Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings802Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings803Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings804Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings8051Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings8052Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings806Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings807Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings808Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings809Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings813Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings814Amount', '0.00');
    //                         CheckoffAdviceLine.Add('Savings815Amount', '0.00');
    //                     end;

    //                     CheckoffAdviceLine.Add('AggregateAmt', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                 end;

    //                 if CurrMemberNo = CheckoffAdviceLines."Member No." then begin
    //                     if LoopCount <> 0 then begin
    //                         // Modify current object
    //                         if Checkoffadvise."Amali Advise Type".ToUpper = 'LOAN' then begin
    //                             CheckoffAdviceLine.Get('LoanAmount', LoanAmount);
    //                             CurrLoanAmount := LoanAmount.AsValue.AsDecimal;
    //                             CurrLoanAmount += CheckoffAdviceLines."Amount On";
    //                             CheckoffAdviceLine.Replace('LoanAmount', Format(CurrLoanAmount).Replace(',', ''));

    //                             Clear(LoanAmount);
    //                             CheckoffAdviceLine.Get('AggregateAmt', LoanAmount);
    //                             CurrLoanAmount := LoanAmount.AsValue.AsDecimal;
    //                             CurrLoanAmount += CheckoffAdviceLines."Amount On";
    //                             CheckoffAdviceLine.Replace('AggregateAmt', Format(CurrLoanAmount).Replace(',', ''));
    //                         end;
    //                         if Checkoffadvise."Amali Advise Type".ToUpper = 'SAVINGS' then begin
    //                             CurrSavingsCount += 1;

    //                             case CurrSavingsCount of
    //                                 2:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings801Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 3:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings802Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 4:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings803Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 5:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings804Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 6:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings8051Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 7:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings8052Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 8:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings806Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 9:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings807Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 10:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings808Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 11:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings809Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 12:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings813Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 13:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings814Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                                 14:
    //                                     begin
    //                                         CheckoffAdviceLine.Replace('Savings815Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
    //                                     end;
    //                             end;

    //                             Clear(LoanAmount);
    //                             CheckoffAdviceLine.Get('AggregateAmt', LoanAmount);
    //                             CurrLoanAmount := LoanAmount.AsValue.AsDecimal;
    //                             CurrLoanAmount += CheckoffAdviceLines."Amount On";
    //                             CheckoffAdviceLine.Replace('AggregateAmt', Format(CurrLoanAmount).Replace(',', ''));
    //                         end;
    //                     end;
    //                 end;

    //                 LoopCount += 1;
    //             end until CheckoffAdviceLines.Next = 0;
    //         end;
    //         Datum.Add('CheckoffAdviceLines', CheckoffAdviceLineList);
    //     end else begin
    //         ResponseObject.Add('request_status', 'FAILED');

    //         Datum.Add('Msg', 'Checkoff advise with ref ' + CheckoffAdviceNo.AsValue().AsText() + ' NOT found!');
    //     end;

    //     ResponseObject.Add('response_payload', Datum);
    //     AddDateTimeToResponse(ResponseObject);

    //     ResponseObject.WriteTo(Response);

    //     exit(Response);
    // end;
    local procedure GetCheckoffDetails(Payload: JsonObject): Text
    var
        CheckoffAdviceNo: JsonToken;

        CheckoffDates: List of [Date];
        CheckoffAdvise: Record "Checkoff Advice Header";
        CheckoffAdviceLines: Record "Checkoff Advice Line";
        CheckoffAdviceLineList: JsonArray;
        CheckoffAdviceLine: JsonObject;

        LoopCount: Integer;
        CurrMemberNo: Text;
        CurrLoanAmount: Decimal;
        LoanAmount: JsonToken;

        Loans: JsonArray;
        Loan: JsonObject;
        SavAccs: JsonArray;
        SavAcc: JsonObject;

        PeriodicActivities: Codeunit "Periodic Activities";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        /*
        {
            "CheckoffAdviceNo": "ADV123456789"
        }
        */
        Payload.Get('CheckoffAdviceNo', CheckoffAdviceNo);

        CheckoffAdvise.Reset;
        CheckoffAdvise.SetRange("No.", CheckoffAdviceNo.AsValue.AsText);
        if CheckoffAdvise.FindFirst then begin
            ResponseObject.Add('request_status', 'SUCCESS');
            /*
            {
                "CheckoffAdviceNo": "ADV123456789",
                "PaymasterCode": "REGENT",
                "Period": "AUGUST 2025",
                "RequestNo": "123456789",
                "StartDate": "01082025",
                "EndDate": "310082025",
                "CheckoffAdviceLines": [
                    {
                        "MemberNo": "02133",
                        "StaffNo": "101",
                        "Names": "John Van Doe",
                        "LoanAmount": "350000",
                        "FOSASavingsAmount": "320000",
                        "BOSASavingsAmount": "2500000",
                        "TotoJuniosSavingsAmount": "250000"
                    }
                ]
            }
            */
            Datum.Add('CheckoffAdviceNo', CheckoffAdvise."No.");
            Datum.Add('PaymasterCode', CheckoffAdvise."Employer Code");
            Datum.Add('Period', CheckoffAdvise.Period);
            Datum.Add('RequestNo', CheckoffAdvise."Amali Ref");
            Datum.Add('StartDate', GlobalFunctions.FormatNCBACheckoffDate(CheckoffAdvise."Start Date"));
            Datum.Add('EndDate', GlobalFunctions.FormatNCBACheckoffDate(CheckoffAdvise."End Date"));

            // Checkoff advise lines
            CheckoffAdviceLines.Reset;
            CheckoffAdviceLines.SetRange("Advice Header No.", CheckoffAdvise."No.");
            CheckoffAdviceLines.SetCurrentKey("Member No.");
            CheckoffAdviceLines.SetAscending("Member No.", true);

            if CheckoffAdviceLines.FindSet then begin
                LoopCount := 0;
                CurrMemberNo := '';

                repeat begin
                    /*
                    {
                        "Loans": [
                            {
                            "LoanAmount": "72718",
                            "LoanAccountNo": "LB018883",
                            "LoanAccountType": "Bosa Guarantor Loan"
                            },
                            {
                            "LoanAmount": "8455",
                            "LoanAccountNo": "LB018884",
                            "LoanAccountType": "Fosa Guarantor Loan"
                            }
                        ],
                        "SavingsAccounts": [
                            {
                            "SavingsAccountNo": "1234758320",
                            "SavingsAccountType": "Business Savings Account",
                            "SavingsAccountAmount": "10000"
                            },
                            {
                            "SavingsAccountNo": "1234758321",
                            "SavingsAccountType": "Holiday Savings Account",
                            "SavingsAccountAmount": "2500"
                            }
                        ],
                    }
                    */
                    if (LoopCount = 0) or (CurrMemberNo <> CheckoffAdviceLines."Member No.") then begin
                        if CurrMemberNo <> '' then begin
                            if CurrMemberNo <> CheckoffAdviceLines."Member No." then begin
                                CheckoffAdviceLine.Add('Loans', Loans);
                                CheckoffAdviceLine.Add('SavingsAccounts', SavAccs);
                                // Add to array list
                                CheckoffAdviceLineList.Add(CheckoffAdviceLine);
                                LoopCount := 0;
                            end;
                        end;

                        // Create new object
                        Clear(CheckoffAdviceLine);
                        Clear(Loans);
                        Clear(Loan);
                        Clear(SavAccs);
                        Clear(SavAcc);
                        CurrMemberNo := CheckoffAdviceLines."Member No.";
                        CurrLoanAmount := 0;

                        CheckoffAdviceLine.Add('MemberNo', CheckoffAdviceLines."Member No.");
                        CheckoffAdviceLine.Add('StaffNo', CheckoffAdviceLines."Payroll No");
                        CheckoffAdviceLine.Add('Names', CheckoffAdviceLines.Names);

                        if CheckoffAdvise."Amali Advise Type".ToUpper = 'LOAN' then begin
                            // CheckoffAdviceLine.Add('LoanAmount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
                            CurrLoanAmount += CheckoffAdviceLines."Amount On";

                            Loan.Add('LoanAmount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
                            Loan.Add('LoanAccountNo', CheckoffAdviceLines."Loan No.");
                            Loan.Add('LoanAccountType', CheckoffAdviceLines."Product Name");
                            Loans.Add(Loan);
                        end;

                        if CheckoffAdvise."Amali Advise Type".ToUpper = 'SAVINGS' then begin
                            // CheckoffAdviceLine.Add('Savings800Amount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));

                            SavAcc.Add('SavingsAccountAmount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
                            SavAcc.Add('SavingsAccountNo', CheckoffAdviceLines."Account No.");
                            SavAcc.Add('SavingsAccountType', CheckoffAdviceLines."Product Name");
                            SavAccs.Add(SavAcc);
                        end;

                        CheckoffAdviceLine.Add('Comments', '');
                        CheckoffAdviceLine.Add('Additional Notes', '');
                        CheckoffAdviceLine.Add('Branch Number', '');
                        CheckoffAdviceLine.Add('Inputter', '');
                        CheckoffAdviceLine.Add('LoanBalance', Format(CheckoffAdviceLines."Balance Off").Replace(',', ''));
                        CheckoffAdviceLine.Add('EmailAddress', '');
                        CheckoffAdviceLine.Add('MobileNumber', '');
                        CheckoffAdviceLine.Add('AggregateAmt', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
                    end;

                    if CurrMemberNo = CheckoffAdviceLines."Member No." then begin
                        if LoopCount <> 0 then begin
                            // Modify current object
                            if Checkoffadvise."Amali Advise Type".ToUpper = 'LOAN' then begin
                                Clear(Loan);

                                Loan.Add('LoanAmount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
                                Loan.Add('LoanAccountNo', CheckoffAdviceLines."Loan No.");
                                Loan.Add('LoanAccountType', CheckoffAdviceLines."Product Name");
                                Loans.Add(Loan);

                                CheckoffAdviceLine.Get('LoanBalance', LoanAmount);
                                CurrLoanAmount := LoanAmount.AsValue.AsDecimal;
                                CurrLoanAmount += CheckoffAdviceLines."Balance Off";
                                CheckoffAdviceLine.Replace('LoanBalance', Format(CurrLoanAmount).Replace(',', ''));

                                Clear(LoanAmount);
                                CheckoffAdviceLine.Get('AggregateAmt', LoanAmount);
                                CurrLoanAmount := LoanAmount.AsValue.AsDecimal;
                                CurrLoanAmount += CheckoffAdviceLines."Amount On";
                                CheckoffAdviceLine.Replace('AggregateAmt', Format(CurrLoanAmount).Replace(',', ''));
                            end;
                            if Checkoffadvise."Amali Advise Type".ToUpper = 'SAVINGS' then begin
                                Clear(SavAcc);

                                SavAcc.Add('SavingsAccountAmount', Format(CheckoffAdviceLines."Amount On").Replace(',', ''));
                                SavAcc.Add('SavingsAccountNo', CheckoffAdviceLines."Account No.");
                                SavAcc.Add('SavingsAccountType', CheckoffAdviceLines."Product Name");
                                SavAccs.Add(SavAcc);

                                Clear(LoanAmount);
                                CheckoffAdviceLine.Get('AggregateAmt', LoanAmount);
                                CurrLoanAmount := LoanAmount.AsValue.AsDecimal;
                                CurrLoanAmount += CheckoffAdviceLines."Amount On";
                                CheckoffAdviceLine.Replace('AggregateAmt', Format(CurrLoanAmount).Replace(',', ''));
                            end;
                        end;
                    end;

                    LoopCount += 1;
                end until CheckoffAdviceLines.Next = 0;
            end;
            Datum.Add('CheckoffAdviceLines', CheckoffAdviceLineList);
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('Msg', 'Checkoff advise with ref ' + CheckoffAdviceNo.AsValue().AsText() + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure PostPaymentInBank(Payload: JsonObject): Text
    var
        CheckoffAdviceNo: JsonToken;
        BankReferenceNo: JsonToken;
        Name: JsonToken;
        Narration: JsonToken;
        Amount: JsonToken;

        CheckoffDates: List of [Date];
        CheckoffAdvise: Record "Checkoff Advice Header";

        PeriodicActivities: Codeunit "Periodic Activities";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        /*
        {
            "InvoiceNo": "ADV123456789", //This is the CheckoffAdviceNo
            "BankReferenceNo": "FT1121223444",
            "Name": "REGENT", This is the PaymasterCode
            "Narration": "KICD",
            "Amount": "2500000"
        }
        */
        Payload.Get('InvoiceNo', CheckoffAdviceNo);
        Payload.Get('BankReferenceNo', BankReferenceNo);
        Payload.Get('Name', Name);
        Payload.Get('Narration', Narration);
        Payload.Get('Amount', Amount);

        CheckoffAdvise.Reset;
        CheckoffAdvise.SetRange("No.", CheckoffAdviceNo.AsValue.AsText);
        if CheckoffAdvise.FindFirst then begin
            // ...
            /*
            {
                "Status": "000",
                "InvoiceNo": "ADV123456789",
                "BankReferenceNo": "FT1121223444",
                "Msg": "COMPLETED"
            }
            */

            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('Status', '000');
            Datum.Add('InvoiceNo', CheckoffAdviceNo);
            Datum.Add('BankReferenceNo', BankReferenceNo);
            Datum.Add('Msg', 'COMPLETED');
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('Msg', 'Checkoff advise with ref ' + CheckoffAdviceNo.AsValue().AsText() + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ApproveCheckoff(Payload: JsonObject): Text
    var
        CheckoffAdviceNo: JsonToken;

        CheckoffDates: List of [Date];
        CheckoffAdvise: Record "Checkoff Advice Header";
        Checkoff: Record "Checkoff Header";
        InterestPeriod: Record "Interest Due Period";
        CheckoffAdviseLines: Record "Checkoff Advice Line";
        CheckoffBuffer: Record "Checkoff Buffer";

        PeriodicActivities: Codeunit "Periodic Activities";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;

        i: Integer;
    begin
        /*
        {
            "CheckoffAdviceNo": "ADV123456789"
        }
        */
        Payload.Get('CheckoffAdviceNo', CheckoffAdviceNo);

        CheckoffAdvise.Reset;
        CheckoffAdvise.SetRange("No.", CheckoffAdviceNo.AsValue.AsText);
        CheckoffAdvise.SetRange("Amali Posted", false);
        if CheckoffAdvise.FindFirst then begin
            // Create checkoff
            Checkoff.Init;

            Checkoff."No." := '';
            if CheckoffAdvise."Amali Advise Type".ToUpper = 'LOAN' then begin
                Checkoff."CheckOff Type" := Checkoff."CheckOff Type"::Loans;
            end;
            if CheckoffAdvise."Amali Advise Type".ToUpper = 'SAVINGS' then begin
                Checkoff."CheckOff Type" := Checkoff."CheckOff Type"::Savings;
            end;
            Checkoff."Posting Date" := Today;
            Checkoff."Account Type" := Checkoff."Account Type"::Customer;
            Checkoff."Account No." := CheckoffAdvise."Employer Code";
            Checkoff.Validate("Account No.");

            InterestPeriod.Reset;
            InterestPeriod.SetRange(Closed, false);
            InterestPeriod.SetRange("Interest Calcuation Date", CheckoffAdvise."Start Date");
            InterestPeriod.SetRange("Period End Date", CheckoffAdvise."End Date");

            if InterestPeriod.FindFirst then begin
                Checkoff."Posting Period" := InterestPeriod."Interest Due Date";
                Checkoff.Validate("Posting Period");
            end;

            Checkoff."Loan Cutoff Date" := CheckoffAdvise."Loan Issue Cut OFF Date";

            CheckoffAdviseLines.Reset;
            CheckoffAdviseLines.SetRange("Advice Header No.", CheckoffAdvise."No.");
            CheckoffAdviseLines.Calcsums("Amount On");

            Checkoff.Amount := CheckoffAdviseLines."Amount On";
            Checkoff."Scheduled Amount" := Checkoff.Amount;

            Checkoff.Posted := false;
            Checkoff.Status := Checkoff.Status::Approved;
            Checkoff.Source := Checkoff.Source::"Amali NCBA";

            if Checkoff.Insert(true) then begin
                Checkoff."Document No." := Checkoff."No.";
                Checkoff.Modify(true);

                // Create checkoff lines
                CheckoffAdviseLines.Reset;
                CheckoffAdviseLines.SetRange("Advice Header No.", CheckoffAdvise."No.");
                if CheckoffAdviseLines.Findset then begin
                    i := 0;
                    repeat begin
                        i += 1;

                        CheckoffBuffer.Reset;
                        CheckoffBuffer.SetRange("Checkoff No", Checkoff."No.");
                        CheckoffBuffer.SetRange(No, i);
                        if CheckoffBuffer.FindFirst then begin
                            CheckoffBuffer.Delete;
                        end;

                        CheckoffBuffer.Reset;
                        CheckoffBuffer.Init;

                        CheckoffBuffer.No := i;
                        CheckoffBuffer."Checkoff No" := Checkoff."No.";
                        CheckoffBuffer."Upload No." := CheckoffAdviseLines."Member No.";
                        CheckoffBuffer.Amount := CheckoffAdviseLines."Amount On";
                        CheckoffBuffer."Employer Code" := Checkoff."Account No.";
                        CheckoffBuffer.Remarks := Checkoff.Description;
                        CheckoffBuffer."Member No." := CheckoffAdviseLines."Member No.";
                        CheckoffBuffer."Product Code" := CheckoffAdviseLines."Product Type";
                        CheckoffBuffer."Upload Response" := 2;

                        // if CheckoffAdviseLines."Payroll No" <> '' then begin
                        CheckoffBuffer.Insert;

                        Clear(CheckoffBuffer);
                        // end;
                    end until CheckoffAdviseLines.Next = 0;
                end;

                // Validate
                PeriodicActivities.NewCheckoffValidate(Checkoff);
                // Generate Lines
                PeriodicActivities.GenerateCheckoff(Checkoff);

                CheckoffAdvise."Amali Posted" := true;
                CheckoffAdvise.Modify;

                ResponseObject.Add('request_status', 'SUCCESS');
                /*
                {
                    "Status": "000",
                    "AdviceNo": "ADV123456789",
                    "Msg": "COMPLETED"
                }
                */
                Datum.Add('Status', '000');
                Datum.Add('AdviceNo', CheckoffAdvise."No.");
                Datum.Add('Msg', 'COMPLETED');
            end else begin
                ResponseObject.Add('request_status', 'FAILED');
                Datum.Add('Status', '');
                Datum.Add('AdviceNo', CheckoffAdvise."No.");
                Datum.Add('Msg', 'ERROR');
            end;
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('Msg', 'Checkoff advise with ref ' + CheckoffAdviceNo.AsValue().AsText() + ' NOT found or has been posted!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure PostCheckoff(Payload: JsonObject): Text
    var
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        Datum: JsonObject;
        Response: Text;

        Message: Text;

        // To be removed
        Checkoff: Record "Checkoff Header";
        PeriodicActivities: Codeunit "Periodic Activities";
        UserSetup: Record "User Setup";
    begin
        Message := 'No pending checkoffs to be processed';

        if not UserSetup.get(UserId) then begin
            Error('User ID = %1  not setup in UserSetup', UserId);
        end;

        if UserSetup."Allow Posting From" <> Today then begin
            UserSetup."Allow Posting From" := CalcDate('-1Y', Today);
            UserSetup.Modify;
            Commit;
        end;
        if UserSetup."Allow Posting To" <> Today then begin
            UserSetup."Allow Posting To" := CalcDate('1Y', Today);
            UserSetup.Modify;
            Commit;
        end;

        // Post Pending Amali
        Checkoff.Reset;
        Checkoff.SetRange(Source, Checkoff.Source::"Amali NCBA");
        Checkoff.SetRange(Posted, false);
        Checkoff.SetRange(Status, Checkoff.Status::Approved);
        if Checkoff.FindFirst() then begin
            PeriodicActivities.NewPostCheckoffAPI(Checkoff, false);

            Message := 'Checkoff ' + Checkoff."No." + ' has been processed successfully';
        end;

        ResponseObject.Add('response_status', 'SUCCESS');
        ResponseObject.Add('response_status_description', Message);
        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
        ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
        ResponseObject.Add('payload', ResponsePayload);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // Common utils

    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        ResponseObject.Add('status', 'ERROR');
        ResponseObject.Add('description', 'The requested action ' + RequestAction + ' is NOT supported.');
        ResponseObject.Add('errors', Errors);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
    end;

    var
        GlobalFunctions: Codeunit "Global Functions";
        SkyMbankingTrans: Codeunit "Sky M-Banking Transactions";
        SaccoTrans: Codeunit "Sacco Transactions";
}
