table 52186519 "Sky Loan Guarantor Requests"
{
    Caption = 'Sky Loan Guarantor Requests';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(4; "Member Name"; Text[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Accepted","Rejected";
        }
        field(7; "Status Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Loan Application No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sky Channels Loan Applications"."Application No.";
        }
    }
    keys
    {
        key(PK; "Entry No.", "Member No.", "Loan Application No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        TheLoanApplication: Record "Sky Channels Loan Applications";
        TheGuarantor: Record Members;
        TheLoanApplicant: Record Members;
        TheLoanProduct: Record "Product Factory";
        TheLoanGuarantorRequests: Record "Sky Loan Guarantor Requests";
        theSMS: Text;

        TheGuarantorSavingsAccount: Record "Savings Accounts";
    begin
        if "Status Date Time" = 0DT then begin
            "Status Date Time" := CurrentDateTime;
        end;

        TheLoanGuarantorRequests.Reset();
        TheLoanGuarantorRequests.SetRange("Member No.", "Member No.");
        TheLoanGuarantorRequests.SetRange("Loan Application No.", "Loan Application No.");
        TheLoanGuarantorRequests.SetFilter(Status, '=%1|%2', TheLoanGuarantorRequests.Status::Open, TheLoanGuarantorRequests.Status::Accepted);

        if TheLoanGuarantorRequests.FindFirst then begin
            Error('There is already an existing loan guarantorship request for this application at status %1', Format(TheLoanGuarantorRequests.Status));
        end;

        TheLoanApplication.Get("Loan Application No.");
        if TheLoanApplication."Member No." = "Member No." then begin
            Status := Status::Accepted;
            TheGuarantor.Get("Member No.");

            // Update eligible amount
            TheGuarantorSavingsAccount.Reset;

            TheGuarantorSavingsAccount.SetRange("Member No.", TheGuarantor."No.");
            if GlobalFunctions.IsBusinessLoanProduct(TheLoanApplication."Loan Product Type") then begin
                TheGuarantorSavingsAccount.SetRange("Product Category", TheGuarantorSavingsAccount."Product Category"::"Business Deposits");
            end else begin
                TheGuarantorSavingsAccount.SetRange("Product Category", TheGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
            end;

            if TheGuarantorSavingsAccount.FindFirst then begin
                TheLoanApplication."Eligible Amount" += GlobalFunctions.GetSavingsAccountAvailableGuarantorshipBalance(TheGuarantorSavingsAccount, true);
                Rec.Insert;

                TheLoanApplication.Modify(true);
            end;
        end else begin
            Status := Status::Open;
            TheGuarantor.Get("Member No.");

            // Validations
            if GlobalFunctions.IsBusinessLoanProduct(TheLoanApplication."Loan Product Type") then begin
                // Check if guarantor has business deposits account
                if not GlobalFunctions.CheckMemberHasActiveBusinessDepositsAccount("Member No.") then begin
                    Error('The guarantor %1 does not have an active business deposits account.', TheGuarantor.Name)
                end;
            end else begin
                // Check if guarantor has bosa deposits account
                if not GlobalFunctions.CheckMemberHasActiveBosaDepositsAccount("Member No.") then begin
                    Error('The guarantor %1 does not have an active BOSA deposits account.', TheGuarantor.Name)
                end;
            end;

            TheGuarantorSavingsAccount.Reset;

            TheGuarantorSavingsAccount.SetRange("Member No.", TheGuarantor."No.");
            if GlobalFunctions.IsBusinessLoanProduct(TheLoanApplication."Loan Product Type") then begin
                TheGuarantorSavingsAccount.SetRange("Product Category", TheGuarantorSavingsAccount."Product Category"::"Business Deposits");
            end else begin
                TheGuarantorSavingsAccount.SetRange("Product Category", TheGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
            end;

            if TheGuarantorSavingsAccount.FindFirst then begin
                if GlobalFunctions.GetSavingsAccountAvailableGuarantorshipBalance(TheGuarantorSavingsAccount, true) = 0 then begin
                    Error('The guarantor %1 does not have sufficient BOSA deposits to guarantee the loan.', TheGuarantor.Name)
                end;
            end;

            TheLoanApplicant.Get(TheLoanApplication."Member No.");
            // Send SMS...
            theSMS := 'Dear ' + TheGuarantor."First Name" +
            ', you have been included as a guarantor for the loan application request of ' + TheLoanApplicant.Name +
            //'. For further information, log into the member portal or dial ' + theUSSDCode + ' to accept or reject this request.';
            '. For further information, log into the member portal or iPesa app to accept or reject this request. Ref: ' + "Loan Application No.";
            SkySMS.SendSms(
                SMSSource::LOAN_APPLICATION,
                TheGuarantor."Phone No.",
                theSMS,
                CreateGuid(),
                '',
                false,
                0,
                false,
                'CBS',
                "Loan Application No.",
                'CBS'
            );
        end;
    end;

    trigger OnModify()
    var
        thisApp: Record "Sky Loan Guarantor Requests";
        TheLoanApplication: Record "Sky Channels Loan Applications";
        TheGuarantor: Record Members;
        TheLoanApplicant: Record Members;
        theSMS: Text;
        TheGuarantorSavingsAccount: Record "Savings Accounts";
        TheLoanProduct: Record "Product Factory";
    begin
        thisApp.Get("Entry No.", "Member No.", "Loan Application No.");

        if thisApp.Status <> Status then begin
            TheLoanApplication.Get("Loan Application No.");
            TheGuarantor.Get("Member No.");
            TheLoanApplicant.Get(TheLoanApplication."Member No.");

            // SMS
            case Status of
                Status::Accepted:
                    begin
                        // Guarantor SMS
                        theSMS := 'Dear ' + TheGuarantor."First Name" +
            ', you have ' + Format(Status).ToUpper + ' the guarantorship request for the loan application of ' + TheLoanApplicant.Name + '. Ref: ' + "Loan Application No.";
                        SkySMS.SendSms(
                            SMSSource::LOAN_APPLICATION,
                            TheGuarantor."Phone No.",
                            theSMS,
                            CreateGuid(),
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            "Loan Application No.",
                            'CBS'
                        );

                        // Applicant SMS
                        theSMS := 'Dear ' + TheLoanApplicant."First Name" + ', ' +
                        TheGuarantor.Name + ' has ' + Format(Status).ToUpper + ' your request for loan guarantorship. Ref: ' + "Loan Application No.";
                        SkySMS.SendSms(
                            SMSSource::LOAN_APPLICATION,
                            TheLoanApplicant."Phone No.",
                            theSMS,
                            CreateGuid(),
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            "Loan Application No.",
                            'CBS'
                        );

                        // Update eligible amount
                        TheGuarantorSavingsAccount.Reset;

                        TheGuarantorSavingsAccount.SetRange("Member No.", TheGuarantor."No.");
                        if GlobalFunctions.IsBusinessLoanProduct(TheLoanApplication."Loan Product Type") then begin
                            TheGuarantorSavingsAccount.SetRange("Product Category", TheGuarantorSavingsAccount."Product Category"::"Business Deposits");
                        end else begin
                            TheGuarantorSavingsAccount.SetRange("Product Category", TheGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
                        end;

                        if TheGuarantorSavingsAccount.FindFirst then begin
                            TheLoanApplication."Eligible Amount" += GlobalFunctions.GetSavingsAccountAvailableGuarantorshipBalance(TheGuarantorSavingsAccount, true);
                            Rec.Modify;

                            TheLoanApplication.Modify(true);
                        end;

                    end;
                Status::Rejected:
                    begin
                        // Guarantor SMS
                        theSMS := 'Dear ' + TheGuarantor."First Name" +
            ', you have ' + Format(Status).ToUpper + ' the guarantorship request for the loan application of ' + TheLoanApplicant.Name + '. Ref: ' + "Loan Application No.";
                        SkySMS.SendSms(
                            SMSSource::LOAN_APPLICATION,
                            TheGuarantor."Phone No.",
                            theSMS,
                            CreateGuid(),
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            "Loan Application No.",
                            'CBS'
                        );

                        // Applicant SMS
                        theSMS := 'Dear ' + TheLoanApplicant."First Name" + ', ' +
                        TheGuarantor.Name + ' has ' + Format(Status).ToUpper + ' your request for loan guarantorship' + '. ' +
            'Log into the member portal or dial ' + theUSSDCode + ' to add more guarantors. Ref: ' + "Loan Application No.";
                        SkySMS.SendSms(
                            SMSSource::LOAN_APPLICATION,
                            TheLoanApplicant."Phone No.",
                            theSMS,
                            CreateGuid(),
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            "Loan Application No.",
                            'CBS'
                        );

                        if TheLoanApplication."Eligible Amount" >= TheLoanApplication."Requested Amount" then begin
                            Rec.Modify;
                            
                            TheLoanApplication.CreateLoanApplication(true);
                        end;
                    end;
            end;

            "Status Date Time" := CurrentDateTime;
        end;
    end;

    var
        SkySMS: Codeunit SendSms;
        SMSSource: Enum "SMS Source";
        // theUSSDCode: Label '*882*1#';
        theUSSDCode: Label '*882#';
        GlobalFunctions: Codeunit "Global Functions";
}
