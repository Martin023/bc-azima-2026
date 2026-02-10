table 52186509 "Sky Channels Loan Applications"
{
    Caption = 'Sky Channels Loan Applications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No."; Code[50])
        {
            Caption = 'Application No.';
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(3; "Application Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Purpose"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Installments; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Member Name"; Text[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(8; "Loan Product Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = field("Loan Product Type")));
        }
        field(9; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Eligible Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Pending Approval","Approved","Rejected","Posted","Deferred","Archived";
        }

        field(12; "Main Sector"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Main Sector"));
        }
        field(13; "Sub Sector Level1"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 1"), "Parent Sector" = field("Main Sector"));
        }

        field(14; "Sub Sector Level2"; Code[20])
        {
            TableRelation = "Sectoral Classification"."Sector Code" where("Sector Level" = const("Sub Sector Level 2"), "Parent Sector" = field("Sub Sector Level1"));
        }
        field(15; "Is Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loan Top Up"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }


        field(51; "Source Application"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "BC","Member Portal","Mbanking - APP","Mbanking - USSD";
        }
        field(52; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Source Unit"; Option)
        {
            OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(55; "No. Series"; Code[20])
        {
        }
    }
    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        theSMS: Text;
        theApplicant: Record members;
        ExistingLoanApplications: Record "Sky Channels Loan Applications";
        ApplicantSavingsAccount: Record "Savings Accounts";
        GlobalFunctions: Codeunit "Global Functions";

        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanProduct: Record "Product Factory";
    begin
        ExistingLoanApplications.Reset;
        ExistingLoanApplications.SetRange("Member No.", Rec."Member No.");
        ExistingLoanApplications.SetFilter(Status,
        '%1|%2',
        ExistingLoanApplications.Status::Open,
        ExistingLoanApplications.Status::"Pending Approval");
        if ExistingLoanApplications.FindFirst then begin
            Error('There is an ongoing loan application %2 at status = %1', ExistingLoanApplications.Status, ExistingLoanApplications."Application No.");
        end;

        // Product Source Unit
        LoanProduct.Reset;
        LoanProduct.SetRange("Product ID", "Loan Product Type");
        if LoanProduct.FindFirst then begin
            "Source Unit" := LoanProduct."Source Unit";
        end;

        // No Series assignment
        if "Application No." = '' then begin
            MembNoSeries.Get;
            if "Source Unit" = "Source Unit"::FOSA then begin
                MembNoSeries.TestField(MembNoSeries."FOSA Loan Nos.");
                NoSeriesMgt.InitSeries(MembNoSeries."FOSA Loan Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
            end else
                if "Source Unit" = "Source Unit"::"BUSINESS LOANS" then begin
                    MembNoSeries.TestField(MembNoSeries."Business Loan Nos.");
                    NoSeriesMgt.InitSeries(MembNoSeries."Business Loan Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
                end else
                    if "Source Unit" = "Source Unit"::"HR LOANS" then begin
                        MembNoSeries.TestField(MembNoSeries."HR Loan Nos.");
                        NoSeriesMgt.InitSeries(MembNoSeries."HR Loan Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
                    end else begin
                        MembNoSeries.TestField(MembNoSeries."Loan Nos.");
                        NoSeriesMgt.InitSeries(MembNoSeries."Loan Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
                    end;
        end;

        "Application Date Time" := CurrentDateTime;
        "Captured By" := UserId;
        Status := Status::Open;

        // LOAN APPLICATION VALIDATION
        RunLoanApplicationValidation();

        // Self guarantorship
        if "Is Self Guarantee" then begin
            // Update eligible amount
            ApplicantSavingsAccount.Reset;

            ApplicantSavingsAccount.SetRange("Member No.", Rec."Member No.");
            if GlobalFunctions.IsBusinessLoanProduct(Rec."Loan Product Type") then begin
                ApplicantSavingsAccount.SetRange("Product Category", ApplicantSavingsAccount."Product Category"::"Business Deposits");
            end else begin
                ApplicantSavingsAccount.SetRange("Product Category", ApplicantSavingsAccount."Product Category"::"BOSA Deposits");
            end;

            if ApplicantSavingsAccount.FindFirst then begin
                "Eligible Amount" += GlobalFunctions.GetSavingsAccountAvailableGuarantorshipBalance(ApplicantSavingsAccount, true);
            end;
        end;

        if theApplicant.Get("Member No.") then begin
            // Send SMS...
            theSMS := 'Dear ' + theApplicant."First Name" + ', your loan application request has been initiated successfully. Ref: ' + "Application No.";
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
                "Application No.",
                'CBS'
            );
        end;

        // FOSA Self Guarantee
        if "Source Unit" <> "Source Unit"::BOSA then begin
            if "Is Self Guarantee" then begin
                "Eligible Amount" := "Requested Amount";

                CreateLoanApplication(false);
            end;
        end;
    end;

    trigger OnModify()
    var
        theApp: Record "Sky Channels Loan Applications";
        theSMS: Text;
        theApplicant: Record members;
    begin
        theApp.Get("Application No.");

        if theApp."Requested Amount" <> "Requested Amount" then begin
            if "Requested Amount" > theApp."Requested Amount" then begin
                Error('You may only update the requested amount to be lower that the current amount.');
            end;

            if theApplicant.Get("Member No.") then begin
                // Send SMS...
                theSMS := 'Dear ' + theApplicant."First Name" + ', your loan application request has been updated successfully. New requested amount is KES ' + Format("Requested Amount") + '. Ref : ' + "Application No.";
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
                    "Application No.",
                    'CBS'
                );
            end;

            if "Eligible Amount" >= "Requested Amount" then begin
                // Push the loan application...
                CreateLoanApplication(false);
            end;
        end;

        if theApp.Status <> Status then begin
            if theApplicant.Get("Member No.") then begin
                // to be uncommnted user claims the sms are many
                // Send SMS...
                //theSMS := 'Dear ' + theApplicant."First Name" + ', your loan application request has been updated successfully. New status is ' + Format(Status) + '. Ref : ' + "Application No.";
                // theSMS := 'Dear ' + theApplicant."First Name" + ', your loan application request has been disbursed successfully. Ref : ' + "Application No.";
                // SkySMS.SendSms(
                //     SMSSource::LOAN_APPLICATION,
                //     theApplicant."Phone No.",
                //     theSMS,
                //     CreateGuid(),
                //     '',
                //     false,
                //     0,
                //     false,
                //     'CBS',
                //     "Application No.",
                //     'CBS'
                // );
            end;
        end;

        if theApp."Eligible Amount" <> "Eligible Amount" then begin
            if "Eligible Amount" >= "Requested Amount" then begin
                // Push the loan application...
                CreateLoanApplication(false);
            end;
        end;
    end;

    local procedure RunLoanApplicationValidation()
    var
        LoanApplication: Record Loans;
        LoanProduct: Record "Product Factory";
        LoanPurposes: Record "Loan Purpose";
        LoanApplicant: Record Members;
    begin
        LoanApplication.Init;

        LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Member Portal";

        LoanApplication."Member No." := "Member No.";
        LoanApplication.Validate("Member No.");

        LoanApplication."Application Date" := DT2Date("Application Date Time");
        LoanApplication.Validate("Application Date");

        LoanApplication."Loan Product Type" := "Loan Product Type";
        LoanProduct.Reset;
        LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");

        if LoanProduct.FindFirst then begin
            LoanApplication."Source Unit" := LoanProduct."Source Unit";
            LoanApplication."Loan Product Type Name" := LoanProduct."Product Description";
        end else begin
            LoanApplication."Source Unit" := LoanApplication."Source Unit"::BOSA;
            LoanApplication."Loan Product Type Name" := '';
        end;

        LoanApplication."Source" := LoanApplication.Source::CREDIT;
        LoanApplication.Validate("Loan Product Type");

        LoanApplication.Status := LoanApplication.Status::Open;

        case LoanApplication."Source Unit" of
            LoanApplication."Source Unit"::BOSA:
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
                end;
            LoanApplication."Source Unit"::FOSA:
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA);
                end;
            LoanApplication."Source Unit"::"BUSINESS LOANS":
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);
                end;
            LoanApplication."Source Unit"::"HR LOANS":
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::HR);
                end;
            else
                LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
        end;

        LoanApplication."Purpose of Loan" := "Loan Purpose";

        LoanApplication.Installments := Installments;
        LoanApplication.Validate(Installments);

        if LoanPurposes.Get("Loan Purpose") then begin
            LoanApplication."Main Sector" := "Main Sector";
            LoanApplication.Validate("Main Sector");
            LoanApplication."Sub Sector Level1" := "Sub Sector Level1";
            LoanApplication.Validate("Sub Sector Level1");
            LoanApplication."Sub Sector Level2" := "Sub Sector Level2";
            LoanApplication.Validate("Sub Sector Level2");
        end;

        CalcFields("Member Name");
        LoanApplication."Member Name" := "Member Name";
        LoanApplication.Validate("Member No.");

        LoanApplication."Captured By" := Format("Source Application");

        case "Source Application" of
            "Source Application"::"Member Portal":
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Member Portal";
            "Source Application"::"Mbanking - APP":
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Mbanking - APP";
            "Source Application"::"Mbanking - USSD":
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Mbanking - USSD";
            else
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::BC;
        end;

        LoanApplication."Requested Amount" := "Requested Amount";
        LoanApplication.Validate("Requested Amount");

        LoanProduct.Reset;
        LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");
        if LoanProduct.FindFirst then begin
            LoanApplication."Global Dimension 2 Code" := LoanProduct."Global Dimension 2 Code";
        end else begin
            LoanApplication."Global Dimension 2 Code" := LoanApplication."Responsibility Center";
        end;

        LoanApplicant.SetLoadFields("No.", "Global Dimension 1 Code");
        LoanApplicant.Get(LoanApplication."Member No.");
        LoanApplication."Global Dimension 1 Code" := LoanApplicant."Global Dimension 1 Code";
    end;

    procedure CreateLoanApplication(ModifyRec: boolean)
    var
        LoanApplication: Record Loans;
        LoanProduct: Record "Product Factory";
        LoanPurposes: Record "Loan Purpose";
        LoanApplicant: Record Members;
        TheLoanGuarantorshipRequest: Record "Sky Loan Guarantor Requests";
        GuarantorsApplication: Record "Loan Guarantors and Security";
        GuarantorSavingsAccount: Record "Savings Accounts";
        KeyExists: Boolean;

        LoanTopUpParser: JsonArray;
        loan_to_be_cleared: JsonToken;
        LoansToBeCleared: Record "Loans Top up";

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        LoanApplicationCard: Page "Loan Application Card";
        TheLoanApplicationDocuments: Record "Channel Application Documents";
        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";
        InStr: InStream;
        OutStr: OutStream;
        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;
        XmlDoc: XmlDocument;
        ReportParameters: Text;

        GFunc: Codeunit "Global Functions";
        LoanApp: Record Loans;
        Posting: Codeunit "Loans Process";
        LoansTopup: Record "Loans Top up";
        LoanGuar: Record "Loan Guarantors and Security";
        Members: Record Members;
        msg: Text;
        SendSMS: Codeunit SendSMS;
        Source: enum "SMS Source";
        Loans2: record Loans;
        ProductType: Text;
        AppAmount: Decimal;
        SkyMbankingTransactions: Codeunit "Sky M-Banking Transactions";
        // templates - receipts and loans
        JTemplate: Text;
        JBatch: Text;
        LoanTemp: Text;
        LoanBatch: Text;
        BankingUserSetup: Record "Banking User Template";

    begin
        // Check for pending Open guarantorships
        TheLoanGuarantorshipRequest.Reset;
        TheLoanGuarantorshipRequest.SetRange("Loan Application No.", "Application No.");
        TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::"Open");
        if TheLoanGuarantorshipRequest.FindFirst then begin
            exit;
        end;

        // FOSA product validation
        if GFunc.IsFOSALoanProduct("Loan Product Type") then begin
            TheLoanGuarantorshipRequest.Reset;
            TheLoanGuarantorshipRequest.SetRange("Loan Application No.", "Application No.");
            TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::Accepted);
            if TheLoanGuarantorshipRequest.FindSet then begin
                LoanProduct.Reset;
                LoanProduct.SetRange("Product ID", "Loan Product Type");
                if TheLoanGuarantorshipRequest.Count < LoanProduct."Minimum Guarantors" then begin
                    exit;
                end;
            end;
        end;

        if not BankingUserSetup.get(UserId) then begin
            Error('User ID = %1  not setup in BankingUserSetup', UserId);
        end;

        JTemplate := BankingUserSetup."Cashier Journal Template";
        JBatch := BankingUserSetup."Cashier Journal Batch";
        LoanTemp := BankingUserSetup."Loans Template";
        LoanBatch := BankingUserSetup."Loans Batch";

        if (JTemplate = '') or (JBatch = '') then
            error('Cashier Journal Template and Batch must be set in the Banking User Setup');
        if (LoanTemp = '') or (LoanBatch = '') then
            error('Loans Template and Batch must be set in the Banking User Setup');

        LoanApplication.Reset;
        LoanApplication.SetRange("Loan No.", Rec."Application No.");
        if LoanApplication.FindFirst then begin
            LoanApplication.Delete;

            // Clear any loan guarantors
            GuarantorsApplication.Reset();
            GuarantorsApplication.SetRange("Loan No", Rec."Application No.");
            GuarantorsApplication.DeleteAll();

            // Clear any loan top ups
            if "Loan Top Up" <> '' then begin
                // Clear any top ups for that loan application
                LoansToBeCleared.Reset;
                LoansToBeCleared.SetRange("Loan No.", Rec."Application No.");
                LoansToBeCleared.SetRange("Client Code", Rec."Member No.");
                LoansToBeCleared.DeleteAll();
            end;
        end;

        LoanApplication.Reset;
        LoanApplication.Init;

        LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Member Portal";

        LoanApplication."Loan No." := Rec."Application No.";
        LoanApplication."No. Series" := Rec."No. Series";

        LoanApplication."Member No." := "Member No.";
        LoanApplication.Validate("Member No.");

        LoanApplication."Application Date" := DT2Date("Application Date Time");
        LoanApplication.Validate("Application Date");

        LoanApplication."Loan Product Type" := "Loan Product Type";
        LoanProduct.Reset;
        LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");

        if LoanProduct.FindFirst then begin
            LoanApplication."Source Unit" := LoanProduct."Source Unit";
            LoanApplication."Loan Product Type Name" := LoanProduct."Product Description";
        end else begin
            LoanApplication."Source Unit" := LoanApplication."Source Unit"::BOSA;
            LoanApplication."Loan Product Type Name" := '';
        end;

        LoanApplication."Source" := LoanApplication.Source::CREDIT;
        LoanApplication.Validate("Loan Product Type");

        LoanApplication.Status := LoanApplication.Status::Open;

        case LoanApplication."Source Unit" of
            LoanApplication."Source Unit"::BOSA:
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
                end;
            LoanApplication."Source Unit"::FOSA:
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA);
                end;
            LoanApplication."Source Unit"::"BUSINESS LOANS":
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);
                end;
            LoanApplication."Source Unit"::"HR LOANS":
                begin
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::HR);
                end;
            else
                LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
        end;

        LoanApplication."Purpose of Loan" := "Loan Purpose";

        LoanApplication.Installments := Installments;
        LoanApplication.Validate(Installments);

        if LoanPurposes.Get("Loan Purpose") then begin
            LoanApplication."Main Sector" := "Main Sector";
            LoanApplication.Validate("Main Sector");
            LoanApplication."Sub Sector Level1" := "Sub Sector Level1";
            LoanApplication.Validate("Sub Sector Level1");
            LoanApplication."Sub Sector Level2" := "Sub Sector Level2";
            LoanApplication.Validate("Sub Sector Level2");
        end;

        CalcFields("Member Name");
        LoanApplication."Member Name" := "Member Name";
        LoanApplication.Validate("Member No.");

        LoanApplication."Captured By" := Format("Source Application");

        case "Source Application" of
            "Source Application"::"Member Portal":
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Member Portal";
            "Source Application"::"Mbanking - APP":
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Mbanking - APP";
            "Source Application"::"Mbanking - USSD":
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Mbanking - USSD";
            else
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::BC;
        end;

        LoanApplication."Requested Amount" := "Requested Amount";
        LoanApplication.Validate("Requested Amount");

        LoanApplication."Self Guarantee" := Rec."Is Self Guarantee";

        if LoanApplication.Insert(true) then begin
            LoanApplication."CRM Application No." := LoanApplication."Loan No.";
            LoanApplication."CRM No. Series" := LoanApplication."No. Series";

            LoanProduct.Reset;
            LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");
            if LoanProduct.FindFirst then begin
                LoanApplication."Global Dimension 2 Code" := LoanProduct."Global Dimension 2 Code";
            end else begin
                LoanApplication."Global Dimension 2 Code" := LoanApplication."Responsibility Center";
            end;

            LoanApplicant.SetLoadFields("No.", "Global Dimension 1 Code");
            LoanApplicant.Get(LoanApplication."Member No.");
            LoanApplication."Global Dimension 1 Code" := LoanApplicant."Global Dimension 1 Code";

            LoanApplication.Modify();

            // Guarantors
            // 1. Self
            if LoanApplication."Self Guarantee" then begin
                GuarantorsApplication.Init();

                GuarantorsApplication."Source Application" := GuarantorsApplication."Source Application"::"Member Portal";

                GuarantorSavingsAccount.Reset;
                GuarantorSavingsAccount.SetRange("Member No.", LoanApplication."Member No.");
                GuarantorSavingsAccount.SetFilter("Product Category", '=%1', GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

                IF GuarantorSavingsAccount.FindFirst then begin
                    GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

                    GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Guarantor;
                    GuarantorsApplication.Validate("Guarantor Type");

                    GuarantorsApplication."Staff/Payroll No." := GuarantorSavingsAccount."Payroll/Staff No.";
                    // GuarantorsApplication.Validate("Staff/Payroll No.");

                    GuarantorsApplication.Name := GuarantorSavingsAccount.Name;
                    GuarantorsApplication.Date := DT2Date(CurrentDateTime);
                    GuarantorsApplication."Member No" := GuarantorSavingsAccount."Member No.";

                    GuarantorsApplication."Savings Account No./Member No." := GuarantorSavingsAccount."No.";
                    GuarantorsApplication.Validate("Savings Account No./Member No.");

                    // if LoanApplication."Source Unit" = LoanApplication."Source Unit"::FOSA then begin
                    //     // GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;
                    //     // GuarantorsApplication.Validate("Amount Guaranteed");
                    // end;

                    KeyExists := GuarantorsApplication.Insert();
                end;

                GuarantorsApplication.Reset();
            end;
            // 2. Others
            TheLoanGuarantorshipRequest.Reset;
            TheLoanGuarantorshipRequest.SetRange("Loan Application No.", "Application No.");
            TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::Accepted);

            if TheLoanGuarantorshipRequest.FindSet then begin
                repeat begin
                    // Skip self guarantee
                    if TheLoanGuarantorshipRequest."Member No." <> LoanApplication."Member No." then begin
                        GuarantorsApplication.Init();

                        GuarantorsApplication."Source Application" := GuarantorsApplication."Source Application"::"Member Portal";

                        GuarantorSavingsAccount.Reset;
                        GuarantorSavingsAccount.SetRange("Member No.", TheLoanGuarantorshipRequest."Member No.");
                        GuarantorSavingsAccount.SetFilter("Product Category", '=%1', GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

                        IF GuarantorSavingsAccount.FindFirst then begin
                            GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

                            GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Guarantor;
                            GuarantorsApplication.Validate("Guarantor Type");

                            GuarantorsApplication."Staff/Payroll No." := GuarantorSavingsAccount."Payroll/Staff No.";
                            // GuarantorsApplication.Validate("Staff/Payroll No.");

                            GuarantorsApplication.Name := GuarantorSavingsAccount.Name;
                            GuarantorsApplication.Date := DT2Date(CurrentDateTime);
                            GuarantorsApplication."Member No" := GuarantorSavingsAccount."Member No.";

                            GuarantorsApplication."Savings Account No./Member No." := GuarantorSavingsAccount."No.";
                            GuarantorsApplication.Validate("Savings Account No./Member No.");

                            // if LoanApplication."Source Unit" = LoanApplication."Source Unit"::FOSA then begin
                            //     // GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;
                            //     // GuarantorsApplication.Validate("Amount Guaranteed");
                            // end;

                            KeyExists := GuarantorsApplication.Insert();
                        end;

                        GuarantorsApplication.Reset();
                    end;
                end until TheLoanGuarantorshipRequest.Next = 0;
            end;

            // Loan Top Up
            if "Loan Top Up" <> '' then begin
                LoanTopUpParser.ReadFrom("Loan Top Up");

                foreach loan_to_be_cleared in LoanTopUpParser do begin
                    LoansToBeCleared.Reset;

                    LoansToBeCleared.SetRange("Loan No.", LoanApplication."Loan No.");
                    LoansToBeCleared.SetRange("Client Code", LoanApplication."Member No.");
                    LoansToBeCleared.SetRange("Loan Top Up", loan_to_be_cleared.AsValue.AsText);

                    if not LoansToBeCleared.FindFirst() then begin

                        LoansToBeCleared.Init;

                        LoansToBeCleared."Loan No." := LoanApplication."Loan No.";
                        LoansToBeCleared."Client Code" := LoanApplication."Member No.";
                        LoansToBeCleared."Loan Top Up" := loan_to_be_cleared.AsValue.AsText;

                        LoansToBeCleared.Validate("Loan Top Up");
                        LoansToBeCleared.Validate("Principle Top Up");
                        LoansToBeCleared.Validate("Interest Top Up");

                        LoansToBeCleared.Insert;

                    end;
                end;
            end;

            Clear(TempBlob);
            Clear(OutStr);
            Clear(Base64Convert);
            Clear(StoreRecRef);
            Clear(StoreImageRef);

            // EDMS
            LoanApp.Reset;
            LoanApp.SetRange("Loan No.", Rec."Application No.");
            if LoanApp.FindFirst then begin
                XmlDocument.ReadFrom(
                    StrSubstNo(
                        '<ReportParameters name="Loan Application Report" id="%1"><DataItems><DataItem name="Loans">VERSION(1) SORTING(Field1) WHERE(Field1=1(%2))</DataItem><DataItem name="LoanGuarantors">VERSION(1) SORTING(Field1,Field2,Field26,Field27)</DataItem><DataItem name="Loans Top up">VERSION(1) SORTING(Field1,Field3,Field2)</DataItem></DataItems></ReportParameters>',
                        Report::"Loan Application Report",
                        Rec."Application No."
                    ),
                    XmlDoc
                );
                XmlDoc.WriteTo(ReportParameters);

                TheLoanApplicationDocuments.Reset;
                Clear(TheLoanApplicationDocuments);
                TheLoanApplicationDocuments.Init;

                TheLoanApplicationDocuments."Application Type" := TheLoanApplicationDocuments."Application Type"::"Loan Application";
                TheLoanApplicationDocuments."Application No." := "Application No.";
                TheLoanApplicationDocuments."Document Name" := StrSubstNo('%1-LoanApplicationForm.pdf', Rec."Application No.");

                // Blob
                TempBlob.CreateOutStream(OutStr);
                Clear(TheLoanApplicationDocuments.Document);
                StoreRecRef.Open(52186564);
                StoreImageRef := StoreRecRef.Field(TheLoanApplicationDocuments.FieldNo(Document));
                RecRef.GetTable(LoanApp);
                Report.SaveAs(Report::"Loan Application Report", ReportParameters, ReportFormat::Pdf, OutStr, RecRef);
                TempBlob.ToFieldRef(StoreImageRef);
                StoreImageRef.TestField();

                TheLoanApplicationDocuments.Document := StoreImageRef.Value;
                TheLoanApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(TheLoanApplicationDocuments."Document Name");

                TheLoanApplicationDocuments.Insert(true);

                Clear(TempBlob);
                Clear(OutStr);
                Clear(Base64Convert);
                Clear(StoreRecRef);
                Clear(StoreImageRef);
                Clear(RecRef);
            end;

            // Update loan application status
            Status := Status::"Pending Approval";

            if ModifyRec then begin
                Rec.Modify;
            end;

            // Autopost for Vuka and Steppa
            LoanProduct.Reset;

            LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");
            if LoanProduct.FindFirst then begin
                if LoanProduct."Portal Autoposting Allowed" then begin
                    LoanApplication.Status := LoanApplication.Status::Approved;

                    //Commit();
                    LoanApplication.Modify;
                    Commit;
                    LoanApplication.Reset;
                    Clear(LoanApplication);

                    Posting.PostLoanNormal(Rec."Application No.");

                    LoanApplication.Get(Rec."Application No.");

                    LoanApplication."disbursement time" := Time;
                    LoanApplication."Disbursement Date" := Today;
                    LoanApplication."Loan Appraised By" := UserId;
                    LoanApplication.Modify;

                    LoanApplication.Reset;
                    Clear(LoanApplication);

                    LoansTopup.Reset;
                    LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Application No.");
                    if LoansTopup.FindFirst then begin
                        repeat
                            LoanGuar.Reset;
                            LoanGuar.SetRange("Loan No", LoansTopup."Loan Top Up");
                            LoanGuar.SetRange("Self Guarantee", false);
                            if LoanGuar.FindFirst then begin
                                repeat
                                    if Loans2.Get(LoanGuar."Loan No") then begin
                                        ProductType := Loans2."Loan Product Type Name";
                                        AppAmount := Loans2."Approved Amount";
                                    end;
                                //TICKET:#608 STOP SMS TO GUARANTORS ON CLEARED LOANS
                                // if Members.Get(LoanGuar."Member No") then begin
                                //     msg := 'Dear ' + LoanGuar.Name + ', The ' + ProductType + ' of Ksh. ' + Format(AppAmount) + ', you had guaranteed ' + LoanGuar."Loanee Name" + ' is now fully repaid.';
                                //     SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loans2."Disbursement Account No"), '', true, 0, false, 'CBS', Loans2."Disbursement Account No", 'CBS');
                                // end;

                                until LoanGuar.Next = 0;
                            end;
                        until LoansTopup.Next = 0;
                    end;
                end;
            end;
        end;
    end;

    procedure ProcessSelfGuarantorship()
    var
        TheLoanGuarantorshipRequest: Record "Sky Loan Guarantor Requests";
        prodFac: Record "Product Factory";
    begin
        TheLoanGuarantorshipRequest.Reset;
        TheLoanGuarantorshipRequest.SetRange("Loan Application No.", "Application No.");
        if TheLoanGuarantorshipRequest.Count = 0 then begin
            if prodFac.get("Loan Product Type") then begin
                if prodFac."Source Unit" = prodFac."Source Unit"::BOSA then begin
                    if "Eligible Amount" >= "Requested Amount" then begin
                        // Push the loan application...
                        CreateLoanApplication(true);
                    end;
                end else begin
                    // Push the loan application...
                    CreateLoanApplication(true);
                end;
            end;
        end;
    end;

    procedure ShouldAddMoreGuarantors(): Boolean
    var
        GFunc: Codeunit "Global Functions";
        ProdFac: Record "Product Factory";
        GuarantorRequests: Record "Sky Loan Guarantor Requests";
    begin
        if GFunc.IsFOSALoanProduct("Loan Product Type") then begin
            ProdFac.SetLoadFields("Minimum Guarantors", "Product ID");

            if ProdFac.Get("Loan Product Type") then begin

                GuarantorRequests.Reset;
                GuarantorRequests.SetRange("Loan Application No.", "Application No.");
                if GuarantorRequests.FindSet then begin
                    if GuarantorRequests.Count < ProdFac."Minimum Guarantors" then begin
                        exit(true);
                    end;
                end;

                GuarantorRequests.Reset;
                GuarantorRequests.SetRange("Loan Application No.", "Application No.");
                GuarantorRequests.SetRange(Status, GuarantorRequests.Status::Accepted);
                if GuarantorRequests.FindSet then begin
                    if GuarantorRequests.Count < ProdFac."Minimum Guarantors" then begin

                        GuarantorRequests.Reset;
                        GuarantorRequests.SetRange("Loan Application No.", "Application No.");
                        GuarantorRequests.SetRange(Status, GuarantorRequests.Status::Open);
                        if GuarantorRequests.FindSet then begin
                            exit(false);
                        end else begin
                            exit(true);
                        end;

                    end else begin
                        exit(false);
                    end;
                end;

                GuarantorRequests.Reset;
                GuarantorRequests.SetRange("Loan Application No.", "Application No.");
                GuarantorRequests.SetFilter(Status, '<>%1', GuarantorRequests.Status::Open);
                if GuarantorRequests.FindSet then begin
                    if GuarantorRequests.Count = 0 then begin
                        exit(true);
                    end;
                    exit(false);
                end else begin
                    GuarantorRequests.Reset;
                    GuarantorRequests.SetRange("Loan Application No.", "Application No.");
                    GuarantorRequests.SetFilter(Status, '=%1', GuarantorRequests.Status::Open);
                    if GuarantorRequests.FindSet then begin
                        exit(false);
                    end;
                end;

            end else begin
                exit(false);
            end;
        end;

        if GFunc.IsBOSALoanProduct("Loan Product Type") then begin
            if "Eligible Amount" < "Requested Amount" then begin
                GuarantorRequests.Reset;
                GuarantorRequests.SetRange("Loan Application No.", "Application No.");
                GuarantorRequests.SetFilter(Status, '<>%1', GuarantorRequests.Status::Open);
                if GuarantorRequests.FindSet then begin
                    if GuarantorRequests.Count = 0 then begin
                        exit(true);
                    end else begin
                        exit(false);
                    end;
                end else begin
                    exit(true);
                end;
            end else begin
                exit(false);
            end;
        end;

        exit(true);
    end;

    var
        SkySMS: Codeunit SendSms;
        SMSSource: Enum "SMS Source";
}
