table 52186524 "Sky Guarantor Sub Requests"
{
    Caption = 'Sky Channels Guarantor Substitution Requests';
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
        field(8; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sky Guarantor Sub Applications"."No.";
        }
        field(9; "Savings Account No."; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts"."No.";
        }
        field(10; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
        }
        field(11; "Substituted Member No."; Code[20])
        {
            Caption = 'Substituted Member No.';
        }
        field(12; "Amount Guaranteed"; Decimal)
        {
            Caption = 'Amount Guaranteed';
        }
        field(13; "Substituted Member Name"; Text[80])
        {
            Caption = 'Substituted Member Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Substituted Member No.")));
        }
    }
    keys
    {
        key(PK; "Entry No.", "Member No.", "Application No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        TheLoanApplication: Record "Sky Guarantor Sub Applications";
        TheGuarantor: Record Members;
        TheLoanApplicant: Record Members;
        TheLoanProduct: Record "Product Factory";
        TheLoanGuarantorRequests: Record "Sky Guarantor Sub Requests";
        theSMS: Text;
    begin
        if "Status Date Time" = 0DT then begin
            "Status Date Time" := CurrentDateTime;
        end;

        TheLoanGuarantorRequests.Reset();
        TheLoanGuarantorRequests.SetRange("Member No.", "Member No.");
        TheLoanGuarantorRequests.SetRange("Application No.", "Application No.");
        TheLoanGuarantorRequests.SetFilter(Status, '=%1|%2', TheLoanGuarantorRequests.Status::Open, TheLoanGuarantorRequests.Status::Accepted);

        if TheLoanGuarantorRequests.FindFirst then begin
            Error('There is already an existing loan guarantor substitution request for this application at status %1', Format(TheLoanGuarantorRequests.Status));
        end;

        TheLoanApplication.Get("Application No.");

        Status := Status::Open;
        TheGuarantor.Get("Member No.");

        // Validations
        if GlobalFunctions.IsBusinessLoanProduct(TheLoanApplication."Loan Product Type") then begin
            // Check if guarantor has business deposits account
            if not GlobalFunctions.CheckMemberHasActiveBusinessDepositsAccount("Member No.") then begin
                Error('The new guarantor %1 does not have an active business deposits account.', TheGuarantor.Name)
            end;
        end else begin
            // Check if guarantor has bosa deposits account
            if not GlobalFunctions.CheckMemberHasActiveBosaDepositsAccount("Member No.") then begin
                Error('The new guarantor %1 does not have an active BOSA deposits account.', TheGuarantor.Name)
            end;
        end;

        TheLoanApplicant.Get(TheLoanApplication."Member No.");
        // Send SMS...
        theSMS := 'Dear ' + TheGuarantor."First Name" +
        ', you have been included as a guarantor for the loan guarantor substitution request of ' + TheLoanApplicant.Name +
        // '. For further information, log into the member portal or dial ' + TheUSSD + ' to accept or reject this request.';
        '. For further information, log into the member portal to accept or reject this request. Ref: ' + "Application No.";
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
            "Application No.",
            'CBS'
        );
    end;

    trigger OnModify()
    var
        thisApp: Record "Sky Guarantor Sub Requests";
        TheLoanApplication: Record "Sky Guarantor Sub Applications";
        TheGuarantor: Record Members;
        TheLoanApplicant: Record Members;
        theSMS: Text;
        TheGuarantorSavingsAccount: Record "Savings Accounts";
        TheLoanProduct: Record "Product Factory";
    begin
        thisApp.Get("Entry No.", "Member No.", "Application No.");

        if thisApp.Status <> Status then begin
            TheLoanApplication.Get("Application No.");
            TheGuarantor.Get("Member No.");
            TheLoanApplicant.Get(TheLoanApplication."Member No.");

            // SMS
            case Status of
                Status::Accepted:
                    begin
                        // New guarantor SMS
                        theSMS := 'Dear ' + TheGuarantor."First Name" +
            ', you have ' + Format(Status).ToUpper + ' the guarantor substitution request for the loan of ' + TheLoanApplicant.Name + '. Ref: ' + "Application No.";
                        ;
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
                            "Application No.",
                            'CBS'
                        );

                        // Applicant SMS
                        theSMS := 'Dear ' + TheLoanApplicant."First Name" + ', ' +
                        TheGuarantor.Name + ' has ' + Format(Status).ToUpper + ' your request for loan guarantorship.' + ' Ref: ' + "Application No.";
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
                            "Application No.",
                            'CBS'
                        );

                        Rec.Modify;

                        TheLoanApplication.Modify(true);
                    end;
                Status::Rejected:
                    begin
                        // Guarantor SMS
                        theSMS := 'Dear ' + TheGuarantor."First Name" +
            ', you have ' + Format(Status).ToUpper + ' the guarantor substitution request for the loan of ' + TheLoanApplicant.Name + '. Ref: ' + "Application No.";
                        ;
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
                            "Application No.",
                            'CBS'
                        );

                        // Applicant SMS
                        theSMS := 'Dear ' + TheLoanApplicant."First Name" + ', ' +
                        TheGuarantor.Name + ' has ' + Format(Status).ToUpper + ' your request for loan guarantorship' + '. ' +
                        // 'Log into the member portal or dial ' + TheUSSD + ' to substitute guarantors.';
                        'Log into the member portal to substitute guarantors.' + ' Ref: ' + "Application No.";

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
                            "Application No.",
                            'CBS'
                        );
                    end;
            end;

            "Status Date Time" := CurrentDateTime;
        end;
    end;

    var
        SkySMS: Codeunit SendSms;
        SMSSource: Enum "SMS Source";
        TheUSSD: Label '*882#';
        GlobalFunctions: Codeunit "Global Functions";
}
