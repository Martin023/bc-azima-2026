table 52186520 "Sky Guarantor Sub Applications"
{
    Caption = 'Sky Channels Guarantor Substitution Applications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Application No.';
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(3; "Loan No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Pending Approval","Approved","Rejected";
        }
        field(7; "Source Application"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "BC","Member Portal","Mbanking - APP","Mbanking - USSD";
        }
        field(8; "Loanee Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Member Name"; Text[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(11; "Loan Product Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = field("Loan Product Type")));
        }
        field(12; "Application Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        // field(10; "Eligible Amount"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(5; "Loan Purpose"; Code[200])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(6; Installments; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(9; "Requested Amount"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(12; "Main Sector"; Code[20])
        // {
        //     TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Main Sector"));
        // }
        // field(13; "Sub Sector Level1"; Code[20])
        // {
        //     TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 1"), "Parent Sector" = field("Main Sector"));
        // }

        // field(14; "Sub Sector Level2"; Code[20])
        // {
        //     TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 2"), "Parent Sector" = field("Sub Sector Level1"));
        // }
        // field(15; "Is Self Guarantee"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(16; "Loan Top Up"; Text[2048])
        // {
        //     DataClassification = ToBeClassified;
        // }



        // field(52; "Captured By"; Code[50])
        // {
        //     DataClassification = ToBeClassified;
        // }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        theSMS: Text;
        theApplicant: Record members;
        ExistingLoanApplications: Record "Sky Guarantor Sub Applications";
        ApplicantSavingsAccount: Record "Savings Accounts";
        GlobalFunctions: Codeunit "Global Functions";

        CreditNosSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        ExistingLoanApplications.Reset;
        ExistingLoanApplications.SetRange("Member No.", Rec."Member No.");
        ExistingLoanApplications.SetFilter(Status,
        '%1|%2',
        ExistingLoanApplications.Status::Open,
        ExistingLoanApplications.Status::"Pending Approval");
        if ExistingLoanApplications.FindFirst then begin
            Error('There is an ongoing loan guarantor substitution application at status = %1', ExistingLoanApplications.Status);
        end;


        if "No." = '' then begin
            CreditNosSeries.Get;
            CreditNosSeries.TestField(CreditNosSeries."Guarantors Substitution");
            NoSeriesMgt.InitSeries(CreditNosSeries."Guarantors Substitution", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Status := Status::Open;

        // APPLICATION VALIDATION
        RunApplicationValidation();

        if theApplicant.Get("Member No.") then begin
            // Send SMS...
            theSMS := 'Dear ' + theApplicant."First Name" + ', your loan guarantor substitution request for loan ' +
            "Loan Product Type" + ' - ' + "Loan No." +
            ' has been initiated successfully. Ref: ' + "No.";

            SkySMS.SendSms(
                SMSSource::LOAN_APPLICATION,
                theApplicant."Phone No.",
                theSMS,
                CreateGuid(),
                '',
                false,
                0,
                false,
                'CBS',
                "No.",
                'CBS'
            );
        end;
    end;

    trigger OnModify()
    var
        theApp: Record "Sky Guarantor Sub Applications";
        theSMS: Text;
        theApplicant: Record members;
    begin
        theApp.Get("No.");

        if theApp.Status <> Status then begin
            if theApplicant.Get("Member No.") then begin
                // Send SMS...
                theSMS := 'Dear ' + theApplicant."First Name" + ', your loan guarantor substitution request has been updated successfully. New status is ' + Format(Status) + '. Ref: ' + "No.";
                SkySMS.SendSms(
                    SMSSource::LOAN_APPLICATION,
                    theApplicant."Phone No.",
                    theSMS,
                    CreateGuid(),
                    '',
                    false,
                    0,
                    false,
                    'CBS',
                    "No.",
                    'CBS'
                );
            end;
        end;

        // Push the application...
        CreateApplication();
    end;

    local procedure CreateApplication()
    var
        TheLoanGuarantorshipRequest: Record "Sky Guarantor Sub Requests";
        LoaneeMember: Record Members;
        LoaneeLoan: Record Loans;
        LoanGuarantorSubstitution: Record "Guarantors Substitution";
        TheLoanGuarantorSubstitution: Record "Guarantors Substitution";
        LoanGuarantors: Record "Loan Guarantors Sub";
        NewLoanGuarantorSavingsAccount: Record "Savings Accounts";
        LGSec: Record "Loan Guarantors and Security";
        SubstitutedLoanGuarantor: Record "Loan Guarantors Sub"; 
    begin
        // Check for pending Open guarantorship requests
        TheLoanGuarantorshipRequest.Reset;
        TheLoanGuarantorshipRequest.SetRange("Application No.", "No.");
        TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::"Open");
        if TheLoanGuarantorshipRequest.FindFirst then begin
            exit;
        end;

        LoaneeLoan.Reset;
        LoaneeLoan.SetRange("Member No.", LoaneeMember."No.");
        LoaneeLoan.SetRange("Loan No.", Rec."Loan No.");
        LoaneeLoan.SetRange(Posted, true);

        IF LoaneeLoan.FindFirst then begin

            LoanGuarantorSubstitution.Init;

            LoanGuarantorSubstitution."No." := Rec."No.";
            LoanGuarantorSubstitution."No. Series" := Rec."No. Series";

            LoanGuarantorSubstitution."Loan No." := LoaneeLoan."Loan No.";
            LoanGuarantorSubstitution."Member No." := LoaneeLoan."Member No.";
            LoanGuarantorSubstitution.Validate("Loan No.");

            LoanGuarantorSubstitution."Loan Account No." := LoaneeLoan."Loan Account";
            LoanGuarantorSubstitution.Name := LoaneeLoan."Member Name";
            LoanGuarantorSubstitution.Status := LoanGuarantorSubstitution.Status::Open;
            LoanGuarantorSubstitution."Source Application" := LoanGuarantorSubstitution."Source Application"::"Member Portal";

            // Validate existing requests...
            TheLoanGuarantorSubstitution.Reset;
            TheLoanGuarantorSubstitution.SetRange("Loan No.", LoaneeLoan."Loan No.");
            TheLoanGuarantorSubstitution.SetFilter(
                Status,
                '=%1|%2',
                TheLoanGuarantorSubstitution.Status::Open,
                TheLoanGuarantorSubstitution.Status::Pending);
            TheLoanGuarantorSubstitution.SetFilter("No.", '<>%1', Rec."No.");

            if TheLoanGuarantorSubstitution.FindFirst then begin
                Error('There is an ongoing loan guarantor substitution request %1 at status %2',
                TheLoanGuarantorSubstitution."No.",
                TheLoanGuarantorSubstitution.Status)
            end;

            IF LoanGuarantorSubstitution.Insert(true) then begin
                LoanGuarantorSubstitution."Captured By" := 'Members Portal';
                LoanGuarantorSubstitution."CRM Application No." := LoanGuarantorSubstitution."No.";
                LoanGuarantorSubstitution."CRM No. Series" := 'Members Portal';
                LoanGuarantorSubstitution."CRM Created By" := 'Members Portal';

                LoanGuarantorSubstitution.Modify;


                TheLoanGuarantorshipRequest.Reset;
                TheLoanGuarantorshipRequest.SetRange("Application No.", "No.");
                TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::Accepted);
                if TheLoanGuarantorshipRequest.FindSet then begin
                    repeat begin

                        Clear(LoanGuarantors);
                        LoanGuarantors.Init;

                        LoanGuarantors."No." := Rec."No.";

                        NewLoanGuarantorSavingsAccount.SetRange("Member No.", TheLoanGuarantorshipRequest."Member No.");
                        NewLoanGuarantorSavingsAccount.SetRange("Can Guarantee Loan", true);

                        if LoaneeLoan."Source Unit" = LoaneeLoan."Source Unit"::"BUSINESS LOANS" then begin
                            NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"Business Deposits");
                        end else begin
                            NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
                        end;

                        IF NewLoanGuarantorSavingsAccount.FindFirst then begin
                            LoanGuarantors."Savings Account No." := NewLoanGuarantorSavingsAccount."No.";
                            LoanGuarantors.Validate("Savings Account No.");
                            LoanGuarantors."Member No" := NewLoanGuarantorSavingsAccount."Member No.";
                        end else begin
                            Error('Guarantor with member number %1 does NOT have a savings account', TheLoanGuarantorshipRequest."Member No.");
                        end;

                        LoanGuarantors."Loan No" := LoaneeLoan."Loan No.";

                        LoanGuarantors.Validate("Member No");

                        LGSec.Reset;
                        LGSec.SetRange("Loan No", LoaneeLoan."Loan No.");
                        LGSec.SetRange("Member No", TheLoanGuarantorshipRequest."Substituted Member No.");

                        if LGSec.FindFirst then begin
                            LoanGuarantors."Guarantor Type" := LoanGuarantors."Guarantor Type"::Guarantor;
                            LoanGuarantors."Member Substituted" := LGSec."Savings Account No./Member No.";
                            LoanGuarantors.Validate("Member Substituted");

                            SubstitutedLoanGuarantor.Reset;
                            SubstitutedLoanGuarantor.SetRange("Loan No", LoanGuarantors."Loan No");
                            SubstitutedLoanGuarantor.SetRange("Savings Account No.", LoanGuarantors."Member Substituted");

                            if SubstitutedLoanGuarantor.FindFirst then begin
                                SubstitutedLoanGuarantor.Substituted := true;
                                SubstitutedLoanGuarantor.Modify(false);
                            end;
                        end else begin

                            Error('Guarantor with member number %1 does NOT have a savings account', TheLoanGuarantorshipRequest."Substituted Member No.");

                        end;

                        LoanGuarantors.Substituted := false;
                        LoanGuarantors.Validate(Substituted);

                        LoanGuarantors."Amount Guaranteed" := TheLoanGuarantorshipRequest."Amount Guaranteed";
                        LoanGuarantors."SMS Sent" := false;

                        LoanGuarantors.Insert(true);

                    end until TheLoanGuarantorshipRequest.Next = 0;
                end;

                // Handle CRM branch assigmnent
                LoanGuarantorSubstitution."Global Dimension 1 Code" := LoaneeMember."Global Dimension 1 Code";
                LoanGuarantorSubstitution."Global Dimension 2 Code" := LoaneeMember."Global Dimension 2 Code";

                LoanGuarantorSubstitution.Modify;
                LoanGuarantorSubstitution.Reset;
                Status := Status::"Pending Approval";
            end;
        end;
    end;

    local procedure RunApplicationValidation()
    var
        TheLoanGuarantorshipRequest: Record "Sky Guarantor Sub Requests";
        LoaneeMember: Record Members;
        LoaneeLoan: Record Loans;
        LoanGuarantorSubstitution: Record "Guarantors Substitution";
        TheLoanGuarantorSubstitution: Record "Guarantors Substitution";
        LoanGuarantors: Record "Loan Guarantors Sub";
        NewLoanGuarantorSavingsAccount: Record "Savings Accounts";
        LGSec: Record "Loan Guarantors and Security";
        SubstitutedLoanGuarantor: Record "Loan Guarantors Sub";
    begin
        // Validate existing requests...
        TheLoanGuarantorSubstitution.Reset;
        TheLoanGuarantorSubstitution.SetRange("Loan No.", LoaneeLoan."Loan No.");
        TheLoanGuarantorSubstitution.SetFilter(
            Status,
            '=%1|%2',
            TheLoanGuarantorSubstitution.Status::Open,
            TheLoanGuarantorSubstitution.Status::Pending);
        TheLoanGuarantorSubstitution.SetFilter("No.", '<>%1', Rec."No.");

        if TheLoanGuarantorSubstitution.FindFirst then begin
            Error('There is an ongoing loan guarantor substitution request %1 at status %2',
            TheLoanGuarantorSubstitution."No.",
            TheLoanGuarantorSubstitution.Status)
        end;



        LoaneeLoan.Reset;
        LoaneeLoan.SetRange("Member No.", LoaneeMember."No.");
        LoaneeLoan.SetRange("Loan No.", Rec."Loan No.");
        LoaneeLoan.SetRange(Posted, true);

        IF LoaneeLoan.FindFirst then begin

            LoanGuarantorSubstitution.Init;

            LoanGuarantorSubstitution."No." := Rec."No.";
            LoanGuarantorSubstitution."No. Series" := Rec."No. Series";

            LoanGuarantorSubstitution."Loan No." := LoaneeLoan."Loan No.";
            LoanGuarantorSubstitution."Member No." := LoaneeLoan."Member No.";
            LoanGuarantorSubstitution.Validate("Loan No.");

            LoanGuarantorSubstitution."Loan Account No." := LoaneeLoan."Loan Account";
            LoanGuarantorSubstitution.Name := LoaneeLoan."Member Name";
            LoanGuarantorSubstitution.Status := LoanGuarantorSubstitution.Status::Open;
            LoanGuarantorSubstitution."Source Application" := LoanGuarantorSubstitution."Source Application"::"Member Portal";
        end;
    end;

    var
        SkySMS: Codeunit SendSms;
        SMSSource: Enum "SMS Source";
}
