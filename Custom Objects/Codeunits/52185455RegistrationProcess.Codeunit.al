#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

Codeunit 52185455 "Registration Process"
{

    trigger OnRun()
    begin
        AnySavingsAccountRegistration('0198837', '06');
    end;

    var
        EntrNo: Integer;
        DocumentType: Option;
        SingleMultiple: Option;
        SavingsAccounts: Record "Savings Accounts";
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: Enum "SMS Source";
        Text002: label 'You have been approved as a member at  ';
        Text003: label 'Your Member No. is  ';
        Text004: label 'Your application has been approved by  ';
        Text005: label 'Your Account No. is %1 ';
        Text006: label 'This application has not been approved.';
        Text007: label 'Are you sure you want to convert this application to membership?';
        Text008: label 'Member No. %1 created successfully.';
        Cust: Record Members;
        PeriodInteg: Integer;
        FOSAACC: Code[50];
        GeneralSetUp: Record "General Set-Up";
        Temp: Record "Banking User Template";
        TransactionCharges: Record "Transaction Charges";
        Jtemplate: Code[20];
        Jbatch: Code[10];
        LineN: Integer;
        Dim1: Code[10];
        Dim2: Code[10];
        Mgnt: Codeunit "Journal Posting";
        TransactionTypes: Record "Transaction Types";
        SavingsAcc: Record "Savings Accounts";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        FileTracker: Record "File Tracker";
        MemberClass: Record "Member Classes";
        Text0003: label 'You have been captured as principle member to';
        MsgT: Text;
        MsgTT: Text;
        TransType: Enum "Transaction Types";


    procedure MemberRegistration(MemberApplication: Record "Member Application"; DisplayConfirm: Boolean)
    var
        LineNo: Integer;
        Cust: Record Members;
        GroupMembers: Record Members;
        Accounts: Record Vendor;
        NextOfKinApp: Record "Next of KIN Application";
        NextOfKin: Record "Next of KIN";
        AccountSignApp: Record "Signatory Application";
        AccountSign: Record "Account Signatories";
        GenSetUp: Record "General Set-Up";
        ImageData: Record "Image Data";
        MemberFactBox: Record "Member FactBox";
        DefaultSavAccReg: Record "Savings Account Registration";
        SavingsAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        IDNumber: Code[20];
        CustMembrDocuments: Record "Application Documents";
        Suffix: Integer;
        SuffixText: Text;
        CustSocialListenSite: Record "Social Listening Sites App.";
        CompanyInformation: Record "Company Information";
        GeneralSetUp: Record "General Set-Up";
        Factory: Record "Product Factory";
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        Jtemplate: Code[30];
        JBatch: Code[30];
        UserSetup: Record "User Setup";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        AccountNo: Code[50];
        i: Integer;
        SavAcc: Record "Savings Accounts";
        GrAccounts: Record "Savings Accounts";
        VirtualRegistrations: Record "Virtual Registrations";
        AgentBiometricData: Record "Agent Biometric Data";
        CertificateManagement: Record "Certificate Management";
        CertificateMngt: Record "Certificate Management";
        LoanProcess: Codeunit "Loans Process";
        NameM: Text[250];
        SMSMsg: Text[250];
        Members: Record Members;
        FileName: Text;
        Employer: Record Customer;

        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
        RecRef: RecordRef;
        FileRecRef: RecordRef;
        W: Record "Workflow Response";
    begin
        // Validate if the member application has already created the member
        Members.Reset;
        Members.SetRange("Application No.", MemberApplication."No.");
        Members.SetLoadFields("No.");
        if Members.FindFirst then begin
            exit;
        end;

        if MemberApplication.Created = true then exit;

        if MemberApplication."Account Type" = MemberApplication."Account Type"::"Single Member Account" then
            if MemberApplication."Type of Application" = MemberApplication."Type of Application"::"New Registration" then begin
                Members.Reset();
                Members.SetRange("Primary Identification", MemberApplication."Primary Identification");
                if Members.FindFirst() then begin
                    if Members."Primary Identification" <> '' then
                        MemberApplication."Type of Application" := MemberApplication."Type of Application"::Readmission;
                end;
            end;

        // Validate existing IDs
        if MemberApplication."Type of Application" <> MemberApplication."Type of Application"::Readmission then begin
            if MemberApplication."Primary Identification" <> '' then begin
                Members.Reset;
                Members.SetRange("Primary Identification Type", MemberApplication."Primary Identification Type");
                Members.SetRange("Primary Identification", MemberApplication."Primary Identification");
                Members.SetLoadFields("No.");
                if not Members.FindFirst then begin
                    Members.Reset;
                    Members.SetRange("Secondary Identification Type", MemberApplication."Primary Identification Type");
                    Members.SetRange("Secondary Identification", MemberApplication."Primary Identification");
                    Members.SetLoadFields("No.");
                    if Members.FindFirst then begin
                        exit;
                    end;
                end else begin
                    exit;
                end;
            end;
        END;

                if MemberApplication."Secondary Identification" <> '' then begin
            if MemberApplication."Type of Application" <> MemberApplication."Type of Application"::Readmission then begin
                Members.Reset;
                Members.SetRange("Primary Identification Type", MemberApplication."Secondary Identification Type");
                Members.SetRange("Primary Identification", MemberApplication."Secondary Identification");
                Members.SetLoadFields("No.");
                if not Members.FindFirst then begin
                    Members.Reset;
                    Members.SetRange("Secondary Identification Type", MemberApplication."Secondary Identification Type");
                    Members.SetRange("Secondary Identification", MemberApplication."Secondary Identification");
                    Members.SetLoadFields("No.");
                    if Members.FindFirst then begin
                        exit;
                    end;
                end else begin
                    exit;
                end;
            end
            else begin
                if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then begin
                    Members.Reset;
                    Members.Setfilter("No.", '<>%1', MemberApplication."Principle Member");
                    Members.SetRange("Primary Identification Type", MemberApplication."Secondary Identification Type");
                    Members.SetRange("Primary Identification", MemberApplication."Secondary Identification");
                    Members.SetLoadFields("No.");
                    if not Members.FindFirst then begin
                        Members.Reset;
                        Members.Setfilter("No.", '<>%1', MemberApplication."Principle Member");
                        Members.SetRange("Secondary Identification Type", MemberApplication."Secondary Identification Type");
                        Members.SetRange("Secondary Identification", MemberApplication."Secondary Identification");
                        Members.SetLoadFields("No.");
                        if Members.FindFirst then begin
                            exit;
                        end
                    end
                    else begin
                        exit;
                    end;
                end;
            end;
        end;

        Members.Reset;
        if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then
            Cust.Get(MemberApplication."Principle Member");


        FOSAACC := '';
        if MemberApplication."Type of Application" <> MemberApplication."Type of Application"::Readmission then
            Cust."No." := '';

        Cust.Init();
        Cust.Name := UpperCase(MemberApplication.Name);
        Cust."First Name" := MemberApplication."First Name";
        Cust."Middle Name" := MemberApplication."Middle Name";
        Cust."Other Names" := MemberApplication."Other Names";

        if MemberApplication."First Name" <> '' then begin
            Cust.Name := MemberApplication."First Name";
        end;
        if MemberApplication."Other Names" <> '' then begin
            Cust.Name += ' ' + MemberApplication."Other Names";
        end;
        if MemberApplication."Middle Name" <> '' then begin
            Cust.Name += ' ' + MemberApplication."Middle Name";
        end;

        Cust.Name := Cust.Name.Trim();

        Cust."Current Address" := MemberApplication."Current Address";
        Cust."Home Address" := MemberApplication."Home Address";
        Cust."Phone No." := MemberApplication."Phone No.".Trim();
        Cust."Office Telephone No." := MemberApplication."Office Telephone No.";
        Cust."Global Dimension 1 Code" := MemberApplication."Global Dimension 1 Code";
        Cust."Global Dimension 2 Code" := MemberApplication."Global Dimension 2 Code";
        Cust."Recruited By" := MemberApplication."Recruited By";
        Cust."Registration Date" := Today;
        Cust."Registration Time" := Time;

        Cust.Status := Cust.Status::New; //Here
        Cust."Source Aplication" := Cust."Source Aplication"::BC;

        //NEED A SUBFLAG
        cust."E-Mail" := MemberApplication."E-Mail";
        Cust.Nationality := MemberApplication.Nationality;
        Cust.Religion := MemberApplication.Religion;
        Cust."Any Physical Disability" := MemberApplication.Disabled;
        Cust."Primary Identification Type" := MemberApplication."Primary Identification Type";
        Cust."Secondary Identification Type" := MemberApplication."Secondary Identification Type";
        Cust."Primary Identification" := MemberApplication."Primary Identification";
        Cust."Secondary Identification" := MemberApplication."Secondary Identification";
        Cust."Marital Status" := MemberApplication."Marital Status";
        Cust.Gender := MemberApplication.Gender;
        Cust."Post Code" := MemberApplication."Post Code";
        Cust."Responsibility Center" := MemberApplication."Responsibility Center";
        Cust."Bank Code" := MemberApplication."Bank Code";
        Cust."Branch Code" := MemberApplication."Branch Code";
        Cust."Recruited by Type" := MemberApplication."Recruited by Type";
        Cust."Recruited By" := MemberApplication."Recruited By";
        Cust."Recruited By Name" := MemberApplication."Recruited By Name";
        Cust."Member Segment" := MemberApplication."Member Segment";
        Cust."P.I.N Number" := MemberApplication."P.I.N Number";
        Cust."Group Account No." := MemberApplication."Group Account No.";
        //Cust."Created By" := UserId;
        Cust."Self Employed" := MemberApplication."Self Employed";
        Cust."Employer Code" := MemberApplication."Employer Code";
        Cust."Payroll/Staff No." := MemberApplication."Payroll/Staff No.";
        Cust."Terms of Employment" := MemberApplication."Terms of Employment";
        Cust."Country Of Operation" := MemberApplication."Country Of Operation";
        Cust.County := MemberApplication.County;
        Cust.City := MemberApplication.City;
        Cust."Work Station" := MemberApplication."Work Station";
        Cust."Country Of Operation" := MemberApplication."Country Of Operation";
        Cust."Employment Designation" := MemberApplication."Employment Designation";
        Cust."Member Class" := MemberApplication."Member Class";
        Cust."Date of Birth" := MemberApplication."Date of Birth";
        Cust."Principle Member" := MemberApplication."Principle Member";
        Cust."Type of Application" := MemberApplication."Type of Application";
        Cust."Old Member No." := MemberApplication."Old Member No.";
        Cust."Account Type" := MemberApplication."Account Type";
        Cust."From Another Sacco" := MemberApplication."From Another Sacco";
        Cust."Bank Account No." := MemberApplication."Bank Account No.";
        Cust."Delegates Zone" := MemberApplication."Delegates Zone";
        Cust."Electrol Zone Descr." := MemberApplication."Electrol Zone Descr.";
        Cust."CRM Application No." := MemberApplication."CRM Application No.";
        Cust.Salutation := MemberApplication.Salutation;
        Cust."Application No." := MemberApplication."No.";
        Cust."Account Profile" := MemberApplication."Account Profile";
        Cust."Company Registration No." := MemberApplication."Company Registration No.";
        Cust."Allocated Officer" := MemberApplication."Allocated Officer";
        Cust."Allocated Officer Name" := MemberApplication."Allocated Officer Name";
        Cust."Home Address" := MemberApplication."Home Address";
        Cust."Transactional Mobile Number" := MemberApplication."Transactional Mobile Number".Trim();
        Cust.Age := MemberApplication.Age;
        Cust."Office E-Mail" := MemberApplication."Office E-Mail";
        //Cust."Source Aplication" := MemberApplication."Source Aplication";
        Cust."Permanent Post Code" := MemberApplication."Permanent Post Code";
        Cust."Permanent City" := MemberApplication."Permanent City";
        Cust."Request for ATM" := MemberApplication."Request for ATM";
        Cust."Request Mobile Banking" := MemberApplication."Request Mobile Banking";
        // Cust."Request Kenpipe Smart" := MemberApplication."Request Kenpipe Smart";
        Cust."Witness ID No." := MemberApplication."Witness ID No.";
        Cust."Witness Name" := MemberApplication."Witness Name";
        Cust."2nd Witness ID No." := MemberApplication."2nd Witness ID No.";
        Cust."2nd Witness Name" := MemberApplication."2nd Witness Name";
        Cust."Contribution Mode" := MemberApplication."Contribution Mode";
        Cust."Contribution Effective Date" := MemberApplication."Contribution Effective Date";
        Cust."Contribution Start Date" := MemberApplication."Contribution Start Date";
        Cust."Sub Class" := MemberApplication."Sub Class";
        Cust."Is SACCO Account" := MemberApplication."Is SACCO Account";//Jul 20-2024
        Cust."Application Date" := MemberApplication."Application Date";
        Cust."Date Approved" := MemberApplication."Date Approved";

        Cust."Passport Expiry Date" := MemberApplication."Passport Expiry Date";

        Cust."CRM Lead Ref. No" := MemberApplication."CRM Lead Ref. No";
        Cust."IPRS Verified" := MemberApplication."IPRS Verified";

        if MemberApplication."Account Type" = MemberApplication."Account Type"::"Group Account" then
            Cust.Status := Cust.Status::Active;
        Cust."Marital Status" := MemberApplication."Marital Status";

        //Cust."Created By" := MemberApplication."CRM Created By";
        Cust."Created By" := MemberApplication."Created By";
        Cust."Approved By" := UserId;

        Cust."Branch Code" := MemberApplication."Branch Code";
        Cust."Contribution Effective Date" := MemberApplication."Contribution Effective Date";

        Cust."Account Type" := MemberApplication."Account Type";

        if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then begin
            Cust.Status := Cust.Status::New;
            Cust.Subflag := Cust.Subflag::Rejoined;
            Cust."Rejoinig Date" := Today;
            Cust."Rejoining Time" := Time;
        end else begin
            Cust.Subflag := Cust.Subflag::"First time";
            Cust.Insert(true);
        end;

        if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then
            Cust.Modify();

        MemberApplication.CalcFields(Signature, Picture, "ID Card Back", "ID Card Front");

        if MemberApplication."Type of Application" <> MemberApplication."Type of Application"::Readmission then begin
            if not MemberFactBox.Get(Cust."No.") then begin
                MemberFactBox.Init();
                MemberFactBox."Member No." := Cust."No.";
                MemberFactBox.Insert();
            end;

            ImageData.Reset();
            ImageData.SetRange("Member No", MemberApplication."Principle Member");
            if ImageData.FindFirst() then begin
                ImageData.Picture := MemberApplication.Picture;
                ImageData.Signature := MemberApplication.Signature;
                ImageData."ID Card Back" := MemberApplication."ID Card Back";
                ImageData."ID Card Front" := MemberApplication."ID Card Front";
                ImageData.Modify();
            end Else begin
                ImageData.Init();
                ImageData."ID Number" := IDNumber;
                ImageData.Picture := MemberApplication.Picture;
                ImageData.Signature := MemberApplication.Signature;
                ImageData."ID Card Back" := MemberApplication."ID Card Back";
                ImageData."ID Card Front" := MemberApplication."ID Card Front";
                ImageData."Member No" := Cust."No.";
                ImageData.Insert(true);
            end;
        end;

        // if MemberApplication.Picture.Hasvalue then begin
        //     Clear(MemberApplication.Picture);
        //     MemberApplication.Modify;
        // end;

        // if MemberApplication.Signature.Hasvalue then begin
        //     Clear(MemberApplication.Signature);
        //     MemberApplication.Modify;
        // end;

        CertificateManagement.Reset();
        CertificateManagement.SetRange("Record ID", MemberApplication."No.");
        if CertificateManagement.FindSet() then begin
            repeat
                CertificateMngt.Init();
                CertificateMngt."Record ID" := Cust."No.";
                CertificateMngt."Document Type" := CertificateManagement."Document Type";
                CertificateMngt.Description := CertificateManagement.Description;
                CertificateMngt."Start Date" := CertificateManagement."Start Date";
                CertificateMngt."End Date" := CertificateManagement."End Date";
                CertificateMngt.Insert();
            until CertificateManagement.Next() = 0;
        end;

        if MemberApplication."Type of Application" <> MemberApplication."Type of Application"::Readmission then begin
            NextOfKinApp.Reset;
            NextOfKinApp.SetRange(NextOfKinApp."Record ID", MemberApplication."No.");
            if NextOfKinApp.Find('-') then begin
                repeat
                    NextOfKin.Init;
                    NextOfKin."Record ID" := Cust."No.";
                    NextOfKin.Identification := NextOfKinApp.Identification;
                    NextOfKin."Identification Type" := NextOfKinApp."Identification Type";
                    NextOfKin.Name := UpperCase(NextOfKinApp.Name);
                    NextOfKin.Relationship := NextOfKinApp.Relationship;
                    NextOfKin."Is a Beneficiary" := NextOfKinApp."Is a Beneficiary";
                    NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                    NextOfKin.Address := NextOfKinApp.Address;
                    NextOfKin.Telephone := NextOfKinApp.Telephone;
                    NextOfKin."Date Captured" := NextOfKinApp."Date Captured";
                    NextOfKin.Email := NextOfKinApp.Email;
                    NextOfKin.Identification := NextOfKinApp.Identification;
                    NextOfKin.Allocation := NextOfKinApp.Allocation;
                    NextOfKin."Is a Beneficiary" := NextOfKinApp."Is a Beneficiary";
                    NextOfKin."Is Contact Person" := NextOfKinApp."Is Contact Person";
                    NextOfKin."Is Next of Kin" := NextOfKinApp."Is Next of Kin";
                    NextOfKin."Is Nominee" := NextOfKinApp."Is Nominee";
                    NextOfKin."Is A WitNess" := NextOfKinApp."Is A WitNess";
                    NextOfKin."System UID" := NextOfKinApp."System UID";
                    NextOfKin."Special Instructions" := NextOfKinApp."Special Instructions";
                    NextOfKin.Gender := NextOfKinApp.Gender;
                    NextOfKin.Insert;
                until NextOfKinApp.Next = 0;
            end;

            AccountSignApp.Reset();
            AccountSignApp.SetRange("Account No", MemberApplication."No.");
            if AccountSignApp.FindSet() then begin
                repeat
                    Clear(AccountSign);
                    AccountSign.Init();
                    AccountSign."Account No" := Cust."No.";
                    AccountSign.Names := AccountSignApp.Names;
                    AccountSign."Account Type" := AccountSignApp."Account Type";
                    AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                    AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                    AccountSign."ID Number" := AccountSignApp."ID Number";
                    AccountSign.Signatory := AccountSignApp.Signatory;
                    AccountSign."Must Sign" := AccountSignApp."Must Sign";
                    AccountSign."Must be Present" := AccountSignApp."Must be Present";
                    AccountSign."Member No." := AccountSignApp."Member No.";
                    AccountSign.Type := AccountSignApp.Type;
                    AccountSignApp.CalcFields(Picture, Signature);
                    AccountSign.Picture := AccountSignApp.Picture;
                    AccountSign.Signature := AccountSignApp.Signature;
                    AccountSign."PIN Number" := AccountSignApp."PIN Number";
                    AccountSign."Can Access Member Portal" := AccountSignApp."Can Access Member Portal";
                    AccountSign.Insert();

                    GroupMembers.Reset();
                    GroupMembers.SetRange("No.", AccountSign."Member No.");
                    if GroupMembers.FindFirst() then begin
                        GroupMembers."Group Account No." := Cust."No.";
                        GroupMembers.Modify();
                    end;
                    Clear(AccountSign);
                until AccountSignApp.Next() = 0;
            end;
            if (Cust."Account Type" = Cust."Account Type"::"Single Member Account") or (Cust."Account Type" = Cust."Account Type"::"Group Account") then begin
                DefaultSavAccReg.Reset;
                DefaultSavAccReg.SetRange(DefaultSavAccReg."No.", MemberApplication."No.");
                if DefaultSavAccReg.Find('-') then begin
                    repeat
                        AccountNo := '';
                        if ProductFactory.Get(DefaultSavAccReg."Product Type") then begin
                            AccountNo := CreateSavingsAccountNo(ProductFactory."Product ID", MemberApplication."Global Dimension 1 Code", Cust."No.");
                            SavingsAcc.Init;
                            SavingsAcc."No." := AccountNo;
                            SavingsAcc.Validate(SavingsAcc.Name, Cust.Name);
                            SavingsAcc."ID No." := MemberApplication."Primary Identification";
                            SavingsAcc."Passport No." := MemberApplication."Secondary Identification";
                            SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
                            SavingsAcc.County := MemberApplication.City;
                            SavingsAcc."Phone No." := MemberApplication."Phone No.";
                            SavingsAcc."Phone No." := MemberApplication."Phone No.";
                            SavingsAcc."Current Address" := MemberApplication."Current Address";
                            SavingsAcc."Post Code" := MemberApplication."Post Code";
                            SavingsAcc.City := MemberApplication.City;
                            SavingsAcc.Status := SavingsAcc.Status::New;
                            if MemberApplication."Account Type" = MemberApplication."Account Type"::"Group Account" then
                                SavingsAcc.Status := ProductFactory."Auto Openning Account Status";
                            SavingsAcc."Country/Region Code" := MemberApplication.Nationality;
                            SavingsAcc."Home Address" := MemberApplication."Home Address";
                            SavingsAcc."Registration Date" := Today;
                            SavingsAcc."Recruited by Type" := MemberApplication."Recruited by Type";
                            SavingsAcc."Relationship Manager" := MemberApplication."Allocated Officer";
                            SavingsAcc."Date of Birth" := MemberApplication."Date of Birth";
                            SavingsAcc."Payroll/Staff No." := MemberApplication."Payroll/Staff No.";
                            SavingsAcc."Recruited By" := MemberApplication."Recruited By";
                            SavingsAcc."Member Category" := MemberApplication."Member Class";
                            SavingsAcc."Marital Status" := MemberApplication."Marital Status";
                            SavingsAcc."Old Member No." := MemberApplication."Old Member No.";
                            SavingsAcc."Responsibility Center" := MemberApplication."Responsibility Center";
                            SavingsAcc."Company Registration No." := MemberApplication."Company Registration No.";
                            SavingsAcc."Employer Code" := MemberApplication."Employer Code";
                            SavingsAcc."Global Dimension 1 Code" := MemberApplication."Global Dimension 1 Code";
                            SavingsAcc."Global Dimension 2 Code" := ProductFactory."Global Dimension 2 Code";
                            if SavingsAcc."Global Dimension 2 Code" = '' then
                                SavingsAcc."Global Dimension 2 Code" := MemberApplication."Global Dimension 2 Code";
                            SavingsAcc."Group Account No" := MemberApplication."Group Account No.";
                            SavingsAcc."Created By" := MemberApplication."Created By";
                            SavingsAcc."Monthly Contribution" := DefaultSavAccReg."Monthly Contribution";
                            SavingsAcc."Loan Disbursement Account" := ProductFactory."Loan Disbursement Account";
                            if ProductFactory.Get(DefaultSavAccReg."Product Type") then begin
                                if not ProductFactory."Loan Disbursement Account" then
                                    SavingsAcc."Loan Disbursement Account" := false
                                else
                                    SavingsAcc."Loan Disbursement Account" := true;
                                if SavingsAcc."Loan Disbursement Account" = true then
                                    FOSAACC := SavingsAcc."No.";
                                SavingsAcc."Product Category" := ProductFactory."Product Category";
                            end;
                            SavingsAcc."Product Type" := DefaultSavAccReg."Product Type";
                            SavingsAcc."Product Name" := DefaultSavAccReg."Product Name";
                            SavingsAcc."Member No." := Cust."No.";
                            SavingsAcc.Status := ProductFactory."Auto Openning Account Status";
                            SavingsAcc.Insert;

                            if (SavingsAcc."Product Category" = SavingsAcc."Product Category"::"BOSA Deposits") or
                            (SavingsAcc."Product Category" = SavingsAcc."Product Category"::Risk) or
                            (SavingsAcc."Product Category" = SavingsAcc."Product Category"::"Benevolent (BBF)") then
                                LoanProcess.AdviceShares(SavingsAcc, DefaultSavAccReg."Monthly Contribution", Cust."No.");

                            //Advice
                            if MemberApplication."Member Segment" = 'CHECKOFF' then begin
                                if (SavingsAcc."Product Category" = SavingsAcc."Product Category"::"BOSA Deposits") or
                                (SavingsAcc."Product Category" = SavingsAcc."Product Category"::"Benevolent (BBF)") or
                                (SavingsAcc."Product Category" = SavingsAcc."product category"::"Entrance Fee") then begin
                                    AdviceSavings(SavingsAcc, SavingsAcc."Monthly Contribution", SavingsAcc."Monthly Contribution");
                                end;
                            end;

                            //Accrue Registration Fee
                            CompanyInformation.Get();
                            if CompanyInformation."Accrue Registration Fee" = true then begin
                                if ProductFactory."Product Category" = ProductFactory."product category"::"Entrance Fee" then begin
                                    GeneralSetUp.Get();
                                    Temp.Get(UserId);
                                    AccountNo := '';
                                    Jtemplate := Temp."Accrual. Fee.Journal Template";
                                    JBatch := Temp."Accrual. Fee. Journal Batch";

                                    if Jtemplate = '' then begin
                                        Error(Text0001);
                                    end;
                                    if JBatch = '' then begin
                                        Error(Text0002);
                                    end;


                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                                    GenJournalLine.DeleteAll;
                                    AccountNo := SavingsAcc."No.";
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := AccountNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := AccountNo;
                                    GenJournalLine."External Document No." := AccountNo;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Registration Fee' + AccountNo;
                                    GenJournalLine.Amount := GeneralSetUp."Registration Fee";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := ProductFactory."Accrual Fee Acc. (Income)";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := MemberApplication."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := MemberApplication."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    //Post
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                                    end;
                                end;    //Post
                            end;
                        end;
                    until DefaultSavAccReg.Next = 0;
                end;
            end;
        end;

        if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then begin
            SavingsAcc.Reset();
            SavingsAcc.SetRange("Member No.", MemberApplication."Principle Member");
            if SavingsAcc.FindFirst() then begin
                repeat
                    SavingsAcc.Blocked := SavingsAcc.Blocked::" ";
                    SavingsAcc.Status := SavingsAcc.Status::Active;
                    SavingsAcc.Modify();
                until SavingsAcc.Next() = 0;
            end;
            SavAcc.Reset();
            SavAcc.SetRange("Member No.",MemberApplication."Principle Member");
            SavAcc.SetRange("Product Category",SavAcc."Product Category"::"FOSA Account");
            SavAcc.SetRange("Loan Disbursement Account",true);
            IF SavAcc.FindFirst then
                FOSAACC := SavAcc."No.";
        end;

        if Cust."Account Type" = Cust."Account Type"::"Single Member Account" then begin
            Message(Text008, Cust."No.");
            if MemberApplication."Principle Member" <> '' then begin
                Cust.Reset;
                Cust.SetRange("No.", MemberApplication."Principle Member");
                if Cust.FindFirst then begin
                    SendSMS.SendSms(Source::NEW_MEMBER, Cust."Phone No.", Text0003, Format(MemberApplication."No."), '', true, 0, false, 'CBS', Cust."No.", 'CBS');
                end;
            end;
            CompanyInformation.GET();
            IF MemberApplication."First Name" = '' THEN
                NameM := MemberApplication.Name ELSE
                NameM := MemberApplication."First Name";
            if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then
                SMSMsg := 'Dear ' + NameM + ', You have been readmitted to ' + CompanyInformation.Name + '. ' +
                'Your Member Number is ' + Cust."No." + ', Account No is ' + FOSAACC + '. For queries call ' + CompanyInformation."Phone No." + '.' else
                SMSMsg := 'Dear ' + NameM + ', Your ' + CompanyInformation.Name + ' membership application has been processed. ' +
                'Your Member Number is ' + Cust."No." + ', Account No is ' + FOSAACC + '. For queries call ' + CompanyInformation."Phone No." + '.';
            SendSMS.SendSms(Source::NEW_MEMBER, MemberApplication."Phone No.", SMSMsg, MemberApplication."No.", '', true, 0, false, 'CBS', Cust."No.", 'CBS');
        end;
        MemberApplication.Created := true;
        MemberApplication."Member No." := Cust."No.";
        MemberApplication."Approved By" := UserId;
        MemberApplication."Date Approved" := today;
        MemberApplication.Modify(true);
        Commit();

        //Email Employer
        // if DisplayConfirm then begin
        //     //if Confirm('Do you want to send employee datasheet tothe employer?') then begin
        //     if (MemberApplication."Type of Application" <> MemberApplication."Type of Application"::Readmission) or
        //     (MemberApplication."Type of Application" <> MemberApplication."Type of Application"::"New Registration") then begin
        //         Members.Reset();
        //         Members.SetRange("No.", Cust."No.");
        //         if Members.FindFirst() then begin
        //             FileName := Cust."No." + '.xlsx';
        //             // Report.SaveAsPdf(52185779, FileName, Members);

        //             // FileRecRef.GetTable(Members);
        //             // Report.SaveAs(Report::"Employer Data Sheet", '', ReportFormat::Excel, BlobOutStream, FileRecRef);

        //             Employer.Reset();
        //             Employer.SetRange("No.", Cust."Employer Code");
        //             if Employer.FindFirst() then begin
        //                 RecRef.GetTable(Members);
        //                 TempBlob.CreateOutStream(OutStr);
        //                 Report.SaveAs(Report::Datasheet, '', ReportFormat::Excel, OutStr, RecRef);

        //                 TempBlob.CreateInStream(InStr);

        //                 // TxtRecipientsList.Add(emailadress);
        //                 EmailMsg.Create(Employer."E-Mail", 'DATASHEET', 'PFA Datasheet for employee ' + cust.Name);
        //                 EmailMsg.AddAttachment(FileName, 'xlsx', InStr);
        //                 Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
        //             end;

        //         end;
        //     end;
        //     //end;
        // end;

        // //Email Member
        // if DisplayConfirm then begin
        //     //if Confirm('Do you want to send employee datasheet to the member?') then begin
        //     if Members."E-Mail" <> '' then begin
        //         if (MemberApplication."Type of Application" <> MemberApplication."Type of Application"::Readmission) or
        //         (MemberApplication."Type of Application" <> MemberApplication."Type of Application"::"New Registration") then begin
        //             Members.Reset();
        //             Members.SetRange("No.", Cust."No.");
        //             if Members.FindFirst() then begin
        //                 FileName := Cust."No." + '.xlsx';
        //                 // Report.SaveAsPdf(52185779, FileName, Members);

        //                 RecRef.GetTable(Members);
        //                 TempBlob.CreateOutStream(OutStr);
        //                 Report.SaveAs(Report::Datasheet, '', ReportFormat::Excel, OutStr, RecRef);

        //                 TempBlob.CreateInStream(InStr);

        //                 // TxtRecipientsList.Add(emailadress);
        //                 EmailMsg.Create(Members."E-Mail", 'DATASHEET', 'PFA Datasheet for employee ' + cust.Name);
        //                 EmailMsg.AddAttachment(FileName, 'xlsx', InStr);
        //                 Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
        //             end;
        //         end;
        //     end else
        //         Message('Member does not have an email');
        //     //end;
        // end;
    end;


    procedure ImportMemberPictures(Type: Option "Picture","Signature")
    var
        FileManagement: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        EntryList: list of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        FileName: Text;
        FileExtension: Text;
        Instream: InStream;
        EntryOutStream: OutStream;
        EntryInstream: InStream;
        Length: Integer;
        SelectZIPFileMessg: Label 'Select ZIP File';
        FileCount: Integer;
        Members: Record Members;
        ImageData: Record "Image Data";
        ImportI: page "Import Item Pictures";
        cust: Record Customer;


        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;

    begin
        if not UploadIntoStream(SelectZIPFileMessg, '', 'Zip Files|*.zip', ZipFileName, Instream) then
            Error('');

        DataCompression.OpenZipArchive(Instream, false);
        DataCompression.GetEntryList(EntryList);

        FileCount := 0;

        intProgressTotal := EntryList.Count;

        intProgressI := 0;
        TimeProgress := TIME;
        NoOfRecsProgress := intProgressTotal DIV 100;
        NoOfProgressed := 0;

        diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);

        foreach EntryListKey in EntryList do begin

            intProgressI += 1;
            if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                NoOfProgressed := NoOfProgressed + intProgressI;
                diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                intProgressI := 0;
                TimeProgress := TIME;
            end;


            FileName := CopyStr(FileManagement.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));

            AppendZerosToString(FileName);

            FileExtension := CopyStr(FileManagement.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            // DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            Length := DataCompression.ExtractEntry(EntryListKey, EntryOutStream);
            TempBlob.CreateInStream(EntryInstream);

            if Members.Get(FileName) then begin
                ImageData.Reset();
                ImageData.SetRange("Member No", Members."No.");
                if ImageData.FindFirst() then begin
                    Clear(ImageData.Picture);
                    // if Type = Type::Picture then
                    //     ImageData.Picture.ImportStream(EntryInstream, FileName)
                    // else
                    //     ImageData.Signature.ImportStream(EntryInstream, FileName);

                    ImageData.Modify(true);
                end else begin
                    ImageData.Init();
                    ImageData."Member No" := Members."No.";
                    // if Type = Type::Picture then
                    //     ImageData.Picture.ImportStream(EntryInstream, FileName)
                    // else
                    //     ImageData.Signature.ImportStream(EntryInstream, FileName);
                    ImageData.Insert();
                end;

            end else
                Message('Member number % is not valid', FileName);
        end;

        diaProgress.CLOSE;

        DataCompression.CloseZipArchive();
    end;

    procedure AppendZerosToString(var MyString: Text)
    var
        ZerosToAdd: Integer;
        Zeros: Text;
    begin
        ZerosToAdd := 6 - STRLEN(MyString);

        // If the string length is less than 6, append leading zeros
        if ZerosToAdd > 0 then begin
            Zeros := '';
            // Append zeros to Zeros variable
            repeat
                Zeros := Zeros + '0';
                ZerosToAdd := ZerosToAdd - 1;
            until ZerosToAdd = 0;

            // Concatenate leading zeros with the original string
            MyString := Zeros + MyString;
        end;
    end;

    procedure BusinessLoanAccountRegistration(AccountApplication: Record "B/S Loan Account Application"): Text
    var
        SavingsAcc: Record "Savings Accounts";
        SavAcc: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        Members: Record Members;
        // SkyMbanking: Codeunit "Sky Mbanking";
        msg: Text;
        SendSMS: Codeunit SendSms;
    begin

        Members.Get(AccountApplication."Member No.");

        Members."BL Global Dimension 1 Code" := AccountApplication."Global Dimension 1 Code";
        Members."BL Global Dimension 2 Code" := AccountApplication."Global Dimension 2 Code";
        Members."BL Responsibility Center" := AccountApplication."Responsibility Center";
        Members."BL Created By" := AccountApplication."Created By";
        Members."BL Registration Date" := AccountApplication."Registration Date";
        Members."BL Type of Business" := AccountApplication."Type of Business";
        Members."BL Business Location" := AccountApplication."Business Location";
        Members."BL Relationship Manager" := AccountApplication."Relationship Manager";
        Members."BL Wholesale/Retail" := AccountApplication."Wholesale/Retail";
        Members."BL Current Capital" := AccountApplication."Current Capital";
        Members."BL No. of Employees" := AccountApplication."No. of Employees";
        Members."BL Annual Turnover" := AccountApplication."Annual Turnover";


        ProductFactory.Reset();
        ProductFactory.SetRange("Source Unit", ProductFactory."Source Unit"::"BUSINESS LOANS");
        ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Savings);
        if ProductFactory.FindSet() then begin
            repeat
                SavAcc.Reset();
                SavAcc.SetRange("Member No.", AccountApplication."Member No.");
                SavAcc.SetRange("Product Type", ProductFactory."Product ID");
                if not SavAcc.Find('-') then begin
                    SavingsAcc.Init;
                    SavingsAcc."No." := CreateSavingsAccountNo(ProductFactory."Product ID", Members."Global Dimension 1 Code", Members."No.");
                    SavingsAcc."Product Type" := ProductFactory."Product ID";
                    SavingsAcc."Product Name" := ProductFactory."Product Description";
                    SavingsAcc."Member No." := AccountApplication."Member No.";
                    SavingsAcc.Validate(SavingsAcc.Name, AccountApplication.Name);
                    SavingsAcc."ID No." := Members."Primary Identification";
                    SavingsAcc."Passport No." := Members."Secondary Identification";
                    SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
                    SavingsAcc.County := Members.County;
                    SavingsAcc."Phone No." := Members."Phone No.";
                    SavingsAcc."Mobile Phone No" := Members."Phone No.";
                    SavingsAcc."Current Address" := Members."Current Address";
                    SavingsAcc."Post Code" := Members."Post Code";
                    SavingsAcc.City := Members.City;
                    SavingsAcc."Member Category" := Members."Member Class";
                    SavingsAcc.Status := SavingsAcc.Status::Active;
                    SavingsAcc."Home Address" := Members."Home Address";
                    SavingsAcc."Registration Date" := Today;
                    SavingsAcc."Date of Birth" := Members."Date of Birth";
                    SavingsAcc."Payroll/Staff No." := Members."Payroll/Staff No.";
                    SavingsAcc."Recruited By" := Members."Recruited By";
                    SavingsAcc."Recruited by Type" := Members."Recruited by Type";
                    SavingsAcc."Relationship Manager" := Members."Allocated Officer";
                    SavingsAcc."Responsibility Center" := AccountApplication."Responsibility Center";
                    SavingsAcc."Company Registration No." := Members."Company Registration No.";
                    SavingsAcc."Employer Code" := Members."Employer Code";
                    SavingsAcc."Old Member No." := Members."Old Member No.";
                    SavingsAcc."Associated Member No." := Members."Principle Member";
                    SavingsAcc."Global Dimension 1 Code" := AccountApplication."Global Dimension 1 Code";
                    SavingsAcc."Global Dimension 2 Code" := AccountApplication."Global Dimension 2 Code";
                    SavingsAcc."Created By" := AccountApplication."Created By";
                    SavingsAcc."Product Category" := ProductFactory."Product Category";
                    SavingsAcc."Wholesale/Retail" := AccountApplication."Wholesale/Retail";
                    SavingsAcc."Business Location" := AccountApplication."Business Location";
                    SavingsAcc."Type of Business" := AccountApplication."Type of Business";
                    SavingsAcc."Relationship Manager" := AccountApplication."Relationship Manager";
                    SavingsAcc."Current Capital" := AccountApplication."Current Capital";
                    SavingsAcc."No. of Employees" := AccountApplication."No. of Employees";
                    SavingsAcc."Annual Turnover" := AccountApplication."Annual Turnover";
                    SavingsAcc."Can Guarantee Loan" := ProductFactory."Can Guarantee Loan";
                    SavingsAcc.Insert;
                end;
            until ProductFactory.Next() = 0;
            msg := 'Dear member, you have been successfully registered as a Business Loan Member';
            SendSMS.SendSms(Source::MBANKING, Members."Phone No.", msg, Format(AccountApplication."No."), '', true, 0, false, 'CBS', AccountApplication."No.", 'CBS');

            AccountApplication."Account Created" := true;
            AccountApplication.Modify;

            Members."Has Joined Business Loans" := true;
            Members.Modify();
            exit('Accounts have successfully been created and member joined BS Loan');
        end else
            exit('There is no product associated with business loans set up')
    end;



    procedure AccountRegistration(AccountApplication: Record "Savings Account Application")
    var
        SavingsAcc: Record "Savings Accounts";
        AccountSignApp: Record "Signatory Application";
        AccountSign: Record "Account Signatories";
        GenSetUp: Record "General Set-Up";
        ProductFactory: Record "Product Factory";
        Suffix: Integer;
        SuffixText: Text;
        PeriodicAcc: Codeunit "Periodic Activities";
        IDNumber: Code[20];
        ImageData: Record "Image Data";
        SavingsAccounts: Record "Savings Accounts";
        CustMembrDocuments: Record "Application Documents";
        Text001: label 'This application has not been approved.';
        Text002: label 'Are you sure you want to convert this application to Account?';
        Text003: label 'Account No. %1 created successfully.';
        Members: Record Members;
        SavAccApp: Record "Savings Account Application";
        smsmessage: Text;
        CompanyInformation: Record "Company Information";

    begin
        // if StrLen(AccountApplication."Transaction Mobile No") < 15 then begin
        //     AccountApplication."Transaction Mobile No" := '';
        //     AccountApplication.Modify;
        // end;

        ProductFactory.Get(AccountApplication."Product Type");
        ProductFactory.TestField("Global Dimension 2 Code");
        // IF ProductFactory."Account Creation Method" <> ProductFactory."Account Creation Method"::"Savings Collection" then
        //     Members.Get(AccountApplication."Member No.");

        // SavingsAcc.Reset;
        // SavingsAcc.SetRange(SavingsAcc."Member No.", AccountApplication."Member No.");
        // SavingsAcc.SetRange(SavingsAcc."Product Type", AccountApplication."Product Type");
        // Suffix := SavingsAcc.Count;

        SavingsAcc.Init;
        // IF ProductFactory."Account Creation Method" <> ProductFactory."Account Creation Method"::"Savings Collection" then
        //     //CreateSavingsAccountNo
        //     SavingsAcc."No." := CreateSubAccountNo(AccountApplication."Product Type", Members."Global Dimension 1 Code", Members."No.")
        // ELSE
        if ProductFactory."Account Creation Method" <> ProductFactory."Account Creation Method"::Manual then
            SavingsAcc."No." := CreateSavingsAccountNo(AccountApplication."Product Type", AccountApplication."Global Dimension 1 Code", AccountApplication."Member No.")
        else begin
            AccountApplication.testfield("Savings Account No.");
            SavingsAcc."No." := AccountApplication."Savings Account No.";
        end;

        SavingsAcc."Product Type" := AccountApplication."Product Type";
        SavingsAcc."Product Name" := ProductFactory."Product Description";
        SavingsAcc."Member No." := AccountApplication."Member No.";
        SavingsAcc.Validate(SavingsAcc.Name, AccountApplication.Name);
        SavingsAcc."ID No." := AccountApplication."ID No.";
        SavingsAcc."Passport No." := AccountApplication."Passport No.";
        SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
        SavingsAcc.County := AccountApplication.City;
        SavingsAcc."Monthly Contribution" := AccountApplication."Monthly Contribution";
        SavingsAcc.Validate(SavingsAcc."Monthly Contribution");
        SavingsAcc."Phone No." := AccountApplication."Phone No.";
        SavingsAcc."Mobile Phone No" := AccountApplication."Mobile Phone No";
        SavingsAcc."Current Address" := AccountApplication."Current Address";
        SavingsAcc."Post Code" := AccountApplication."Post Code";
        SavingsAcc.City := AccountApplication.City;
        SavingsAcc."Member Category" := AccountApplication."Member Category";
        SavingsAcc.Status := ProductFactory."Auto Openning Account Status";
        SavingsAcc."Parent Account No." := AccountApplication."Parent Account No.";
        SavingsAcc."Country/Region Code" := AccountApplication."Country/Region Code";
        SavingsAcc."Home Address" := AccountApplication."Home Address";
        SavingsAcc."Registration Date" := Today;
        SavingsAcc."Date of Birth" := AccountApplication."Date of Birth";
        SavingsAcc."Birth Certificate No." := AccountApplication."Birth Certificate No.";
        SavingsAcc."Payroll/Staff No." := AccountApplication."Payroll/Staff No.";
        SavingsAcc."Recruited By" := AccountApplication."Recruited By";
        SavingsAcc."Recruited by Type" := AccountApplication."Recruited by Type";
        SavingsAcc."Relationship Manager" := AccountApplication."Relationship Manager";
        SavingsAcc."Responsibility Center" := AccountApplication."Responsibility Center";
        SavingsAcc."Company Registration No." := AccountApplication."Company Registration No.";
        SavingsAcc."Employer Code" := AccountApplication."Employer Code";
        SavingsAcc."Old Member No." := AccountApplication."Old Member No.";
        SavingsAcc."Associated Member No." := AccountApplication."Associated Member No.";
        SavingsAcc."Global Dimension 1 Code" := AccountApplication."Global Dimension 1 Code";
        SavingsAcc."Global Dimension 2 Code" := ProductFactory."Global Dimension 2 Code";
        IF SavingsAcc."Global Dimension 2 Code" = '' then
            SavingsAcc."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
        SavingsAcc."Group Account No" := AccountApplication."Group Account No";
        SavingsAcc."Created By" := AccountApplication."Created By";
        SavingsAcc."Savings Account No." := AccountApplication."Savings Account No.";
        SavingsAcc."Fixed Deposit Type" := AccountApplication."Fixed Deposit Type";
        SavingsAcc."Product Category" := AccountApplication."Product Category";
        if SavingsAcc."Product Category" = SavingsAcc."product category"::"FOSA Account" then
            SavingsAcc."Loan Disbursement Account" := true;
        SavingsAcc."Salary Through FOSA" := true;
        if SavingsAcc."Product Category" = SavingsAcc."product category"::"Fixed Deposit" then
            SavingsAcc."Fixed Deposit Status" := AccountApplication."fixed deposit status"::Active;
        SavingsAcc."FD Maturity Date" := AccountApplication."FD Maturity Date";
        SavingsAcc."Neg. Interest Rate" := AccountApplication."Neg. Interest Rate";
        SavingsAcc."FD Duration" := AccountApplication."FD Duration";
        SavingsAcc."FD Maturity Instructions" := AccountApplication."FD Maturity Instructions";
        SavingsAcc."Fixed Deposit cert. no" := AccountApplication."Fixed Deposit cert. no";
        SavingsAcc."Fixed Deposit Amount" := AccountApplication."Fixed Deposit Amount";
        SavingsAcc."Signing Instructions" := AccountApplication."Signing Instructions";
        SavingsAcc."Can Guarantee Loan" := ProductFactory."Can Guarantee Loan";
        SavingsAcc.Insert;

        AccountSignApp.Reset();
        AccountSignApp.SetRange("Account No", AccountApplication."No.");
        if AccountSignApp.FindSet() then begin
            repeat
                AccountSign.Init();
                AccountSign."Account No" := SavingsAcc."No.";
                AccountSign.Names := AccountSignApp.Names;
                AccountSign."Account Type" := AccountSignApp."Account Type";
                AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                AccountSign."ID Number" := AccountSignApp."ID Number";
                AccountSign.Signatory := AccountSignApp.Signatory;
                AccountSign."Must Sign" := AccountSignApp."Must Sign";
                AccountSign."Must be Present" := AccountSignApp."Must be Present";
                AccountSign."Member No." := AccountSignApp."Member No.";
                AccountSign.Type := AccountSignApp.Type;
                AccountSignApp.CalcFields(Picture, Signature);
                AccountSign.Picture := AccountSignApp.Picture;
                AccountSign.Signature := AccountSignApp.Signature;
                AccountSign."PIN Number" := AccountSignApp."PIN Number";
                AccountSign.Insert();
            until AccountSignApp.Next() = 0;
        end;

        case AccountApplication."Product Category" of
        // AccountApplication."product category"::"Junior Savings":
        //     begin
        //         AccountApplication.CalcFields(AccountApplication.Picture, AccountApplication.Signature);
        //         if (AccountApplication."Birth Certificate No." = '') and (AccountApplication."Passport No." <> '') then
        //             IDNumber := AccountApplication."Passport No.";
        //         if (AccountApplication."Birth Certificate No." <> '') and (AccountApplication."Passport No." = '') then
        //             IDNumber := AccountApplication."Birth Certificate No.";
        //         if (AccountApplication."Birth Certificate No." <> '') and (AccountApplication."Passport No." <> '') then
        //             IDNumber := AccountApplication."Birth Certificate No.";

        //         AccountApplication.CalcFields(AccountApplication.Picture, AccountApplication.Signature);

        //         ImageData."ID Number" := IDNumber;
        //         ImageData.Picture := AccountApplication.Picture;
        //         ImageData.Signature := AccountApplication.Signature;
        //         ImageData."Member No" := SavingsAcc."No.";
        //         ImageData.Insert(true);

        //         if AccountApplication.Picture.Hasvalue then begin
        //             Clear(AccountApplication.Picture);
        //             AccountApplication.Modify;
        //         end;

        //         if AccountApplication.Signature.Hasvalue then begin
        //             Clear(AccountApplication.Signature);
        //             AccountApplication.Modify;
        //         end;

        //     end;
        end;

        CustMembrDocuments.Reset;
        CustMembrDocuments.SetRange(CustMembrDocuments."Reference No.", SavingsAcc."Member No.");
        if CustMembrDocuments.Find('-') then begin
            repeat
                EntrNo += 1;
                ApplicationDocuments(EntrNo, CustMembrDocuments."Document Type", CustMembrDocuments."Document No.", CustMembrDocuments.Description, CustMembrDocuments."Single Party/Multiple",
                                     SavingsAcc."Member No.", CustMembrDocuments."Product ID", CustMembrDocuments."Product Name", CustMembrDocuments.Provided);
            until CustMembrDocuments.Next = 0;
        end;


        //Advice
        if SavingsAccounts.Get(SavingsAcc."No.") then begin
            SavingsAccounts.Validate(SavingsAccounts."Monthly Contribution");
        end;
        //******

        PostRegistrationDeposit(SavingsAcc."Member No.", AccountApplication."Agent Document No", SavingsAcc."Product Type", 0);
        smsmessage := 'Dear ' + AccountApplication."Name" + ', Your ' + ProductFactory."Product Description" + ' account has been successfully created. Your account number is ' + SavingsAcc."No." + '. Thank you for choosing us.';
        SendSMS.SendSms(Source::NEW_ACCOUNT, SavingsAcc."Mobile Phone No", /*Text005*/ smsmessage, Format(SavingsAccounts."No."), '', true, 0, false, 'CBS', SavingsAccounts."No.", 'CBS');

        AccountApplication.Status := AccountApplication.Status::Created;
        AccountApplication.Modify;
        Message(Text003, SavingsAcc."No.");
    end;

    procedure AutoCreateSavingsAccount(AccountNo: Code[20]; MemberNo: code[20]; ProductID: code[20])
    var
        Membe: record Members;
        ProductFactory: Record "Product Factory";
    begin
        if membe.Get(MemberNo) then begin
            ProductFactory.get(ProductID);
            SavingsAcc."No." := AccountNo;
            SavingsAcc."Product Type" := ProductFactory."Product ID";
            SavingsAcc."Product Name" := ProductFactory."Product Description";
            SavingsAcc."Member No." := membe."No.";
            SavingsAcc.Validate(SavingsAcc.Name, membe.Name);
            SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
            SavingsAcc.County := membe.City;
            SavingsAcc."Monthly Contribution" := ProductFactory."Minimum Contribution";
            SavingsAcc."Product Category" := ProductFactory."Product Category";
            SavingsAcc.Validate(SavingsAcc."Monthly Contribution");
            SavingsAcc."Phone No." := membe."Phone No.";
            SavingsAcc."Current Address" := membe."Current Address";
            SavingsAcc."Post Code" := membe."Post Code";
            SavingsAcc.City := membe.City;
            SavingsAcc."Member Category" := membe."Member Class";
            SavingsAcc.Status := SavingsAcc.Status::New;
            SavingsAcc."Home Address" := membe."Home Address";
            SavingsAcc."Registration Date" := Today;
            SavingsAcc."Date of Birth" := membe."Date of Birth";
            SavingsAcc."Payroll/Staff No." := membe."Payroll/Staff No.";
            SavingsAcc.Gender := membe.Gender;
            SavingsAcc."Relationship Manager" := membe."Allocated Officer";
            SavingsAcc."Marital Status" := membe."Marital Status";
            SavingsAcc."Responsibility Center" := membe."Responsibility Center";
            SavingsAcc."Company Registration No." := Cust."Company Registration No.";
            SavingsAcc."Employer Code" := membe."Employer Code";
            SavingsAcc."Old Member No." := membe."Old Member No.";
            SavingsAcc."Associated Member No." := membe."Principle Member";
            SavingsAcc."Global Dimension 1 Code" := membe."Global Dimension 1 Code";
            SavingsAcc."Global Dimension 2 Code" := membe."Global Dimension 2 Code";
            SavingsAcc."Group Account No" := membe."Group Account No.";
            SavingsAcc."Created By" := UserId;
            SavingsAcc.Insert;
        end;
    end;

    procedure
    CreateSavingsAccountNo(ProductType: Code[30]; BranchCode: code[10]; MemberNo: code[10]) SavingsAccount: code[30]
    var
        ProductFactory: Record "Product Factory";
        SavingsAcc: Record "Savings Accounts";
        SuffixInt: Integer;
        SuffixText: Text[10];
    begin
        ProductFactory.Get(ProductType);
        // SavingsAcc.Reset();
        // SavingsAcc.SetRange("Member No.", MemberNo);
        // SavingsAcc.SetRange("Product Type", ProductType);
        // SuffixInt := SavingsAcc.Count;
        // SuffixText := ProductFactory."Account No. Suffix" + FORMAT(SuffixInt);
        // if (ProductFactory."Product Category" = ProductFactory."Product Category"::"FOSA Account") or
        //  (ProductFactory."Product Category" = ProductFactory."Product Category"::"Biashara Account") or
        //   (ProductFactory."Product Category" = ProductFactory."Product Category"::"Business Deposits")
        //  then
        //     SuffixText := ProductFactory."Account No. Suffix";

        // if ProductFactory."Account Creation Method" = ProductFactory."Account Creation Method"::"Use Branch Code" then begin
        //     SavingsAccount := BranchCode + MemberNo + SuffixText;// ProductFactory."Account No. Suffix";
        // end

        // else
        //     if ProductFactory."Account Creation Method" = ProductFactory."Account Creation Method"::"Savings Collection" then begin
        //         SavingsAccount := BranchCode + ProductFactory."Account No. Serries" + SuffixText;// ProductFactory."Account No. Suffix";
        //         ProductFactory."Account No. Serries" := IncStr(ProductFactory."Account No. Serries");
        //         ProductFactory.Modify();
        //     end else begin
        SavingsAccount := ProductFactory."Account No. Prefix" + MemberNo + ProductFactory."Account No. Suffix";
        // end;
    end;

    procedure CreateSubAccountNo(ProductType: Code[30]; BranchCode: code[10]; MemberNo: code[20]) SavingsAccount: code[20]
    var
        ProductFactory: Record "Product Factory";
        SavingsAcc: Record "Savings Accounts";
        SuffixInt: Integer;
        SuffixText: Text[10];
    begin
        ProductFactory.Get(ProductType);
        SavingsAcc.Reset();
        SavingsAcc.SetRange("Member No.", MemberNo);
        SavingsAcc.SetRange("Product Type", ProductType);
        SuffixInt := SavingsAcc.Count;
        SuffixText := ProductFactory."Account No. Suffix" + FORMAT(SuffixInt);

        if ProductFactory."Account Creation Method" = ProductFactory."Account Creation Method"::"Use Branch Code" then begin
            SavingsAccount := BranchCode + MemberNo + SuffixText;// ProductFactory."Account No. Suffix";
        end

        else
            if ProductFactory."Account Creation Method" = ProductFactory."Account Creation Method"::"Savings Collection" then begin
                SavingsAccount := BranchCode + ProductFactory."Account No. Serries" + SuffixText;// ProductFactory."Account No. Suffix";
                ProductFactory."Account No. Serries" := IncStr(ProductFactory."Account No. Serries");
                ProductFactory.Modify();
            end else begin
                SavingsAccount := ProductFactory."Product ID" + MemberNo + ProductFactory."Account No. Suffix";
            end;
    end;

    procedure ApplicationDocuments(EntrNo: Integer; DocumentType: Option; DocumentNo: Code[20]; Description: Text; SingleMultiple: Option; ReferenceNo: Code[20]; ProductID: Code[20]; ProductName: Text; DocProvided: Option " ",No,Yes)
    var
        MemberDocuments: Record "Member Documents";
    begin
        //MemberDocuments.SETCURRENTKEY("Entry No.");
        //MemberDocuments.FINDLAST;//ckigen
        //EntrNo:=MemberDocuments."Entry No."+1;
        MemberDocuments.Init;
        //MemberDocuments."Entry No."+=EntrNo;
        MemberDocuments."Document Type" := DocumentType;
        MemberDocuments."Document No." := DocumentNo;
        MemberDocuments.Description := Description;
        MemberDocuments."Single Party/Multiple" := SingleMultiple;
        MemberDocuments."Reference No." := ReferenceNo;
        MemberDocuments."Product ID" := ProductID;
        MemberDocuments."Product Name" := ProductName;
        MemberDocuments.Provided := DocProvided;
        //MemberDocuments.INSERT;
    end;


    procedure DormancyP(PeriodFilter: Date; SavingsAccounts: Record "Savings Accounts")
    var
        ProductFactory: Record "Product Factory";
        DormancyPeriod: DateFormula;

    // SavAcc: Record "Savings Accounts";
    begin
        if PeriodFilter = 0D then
            PeriodFilter := Today;

        begin
            SavingsAccounts.SetFilter(Status, '%1', Savingsaccounts.Status::Active);
            SavingsAccounts.SetFilter(Blocked, '%1', Savingsaccounts.Blocked::" ");
            SavingsAccounts.CalcFields("Last Transaction Date");

            if SavingsAccounts."Last Transaction Date" <> 0D then begin
                ProductFactory.Reset;
                ProductFactory.SetFilter(ProductFactory."Dormancy Period", '<>%1', DormancyPeriod);
                if ProductFactory.Find('-') then begin
                    if CalcDate(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date") < PeriodFilter then begin
                        SavingsAccounts.Status := SavingsAccounts.Status::Dormant;
                        SavingsAccounts."Status Change Reason" := 'Dormant Account Has Not Transacted For 3 Months';
                        SavingsAccounts."Last Date Modified" := Today;
                        SavingsAccounts.Modify;

                        LogDormancy(SavingsAccounts."No.", Format(SavingsAccounts.Status), Format(SavingsAccounts.Status));
                    end;
                end;
            end;
        end;
        // IF SavingsAccounts."Last Transaction Date" <> 0D THEN BEGIN
        //     ProductFactory.RESET;
        //     ProductFactory.SETFILTER(ProductFactory."Dormancy Period", '<>%1', DormancyPeriod);
        //     IF ProductFactory.FIND('-') THEN BEGIN
        //         IF CALCDATE(ProductFactory."Dormancy Period", SavingsAccounts."Last Transaction Date") <
        //                     PeriodFilter THEN
        //             SavingsAccounts."Status Change Reason" := 'Dormant Account Has Not Transacted For 3 Months';
        //         SavingsAccounts."Last Date Modified" := TODAY;
        //         SavingsAccounts.MODIFY;
        //     END;
        // END;

    end;

    procedure LogDormancy(AccountNo: Code[100]; Status: text; SubStatus: Text)
    var
        DormancyLog: Record "Dormancy Log";
    begin
        Clear(DormancyLog);
        DormancyLog.Init();
        DormancyLog."Account No" := AccountNo;
        DormancyLog."Entry Date" := Today;
        DormancyLog."Entry Time" := Time;
        DormancyLog."Entered By" := UserId;
        DormancyLog.Status := Status;
        DormancyLog."Sub Status" := SubStatus;
        DormancyLog.Insert(true);
    end;


    procedure SocialSiteListening(EntrN: Integer; AccountNo: Code[20]; AccountAddr: Text)
    var
        SocialListeningSites: Record "Social Listening Sites";
    begin
        SocialListeningSites.Init;
        SocialListeningSites."Entry No." := EntrN;
        SocialListeningSites."Account No." := AccountNo;
        SocialListeningSites.Address := AccountAddr;
        SocialListeningSites.Insert;
    end;


    procedure CreateProduct(ProductFactoryApplication: Record "Product Factory Application")
    var
        ProductFactory: Record "Product Factory";
        RelatedProductApplication: Record "Related Product Application";
        RelatedProduct: Record "Related Product";
        LoanProductChargeAppl: Record "Loan Product Charge Appl.";
        LoanProductCharge: Record "Loan Product Charges";
        DCSParameterMatrixAppl: Record "DCS Parameter Matrix Appl.";
        DCSParameterMatrix: Record "DCS Parameter Matrix";
        ProductApplicationDocuments: Record "Product Application Documents";
        ProductDocuments: Record "Product Documents";
    begin
        ProductFactory.Init;
        ProductFactory."Product ID" := ProductFactoryApplication."Product ID";
        ProductFactory."Product Description" := ProductFactoryApplication."Product Description";
        ProductFactory."Product Class Type" := ProductFactoryApplication."Product Class Type";
        ProductFactory."Min. Customer Age" := ProductFactoryApplication."Min. Customer Age";
        ProductFactory."Max. Member Age" := ProductFactoryApplication."Max.Customer Age";
        ProductFactory."Interest Rate (Min.)" := ProductFactoryApplication."Interest Rate (Min.)";
        ProductFactory."Interest Rate (Max.)" := ProductFactoryApplication."Interest Rate (Max.)";
        ProductFactory."Dormancy Period" := ProductFactoryApplication."Dormancy Period";
        ProductFactory."Dormancy Alert Period" := ProductFactoryApplication."Dormancy Alert Period";
        ProductFactory."Customer Segment" := ProductFactoryApplication."Customer Segment";
        ProductFactory."Closure Fee" := ProductFactoryApplication."Closure Fee";
        ProductFactory."Account No. Prefix" := ProductFactoryApplication."Account No. Prefix";
        ProductFactory."Account No. Suffix" := ProductFactoryApplication."Account No. Suffix";

        ProductFactory.Currency := ProductFactoryApplication.Currency;
        ProductFactory."Product Posting Group" := ProductFactoryApplication."Product Posting Group";
        ProductFactory."Loan  Account [G/L]" := ProductFactoryApplication."Loan  Account [G/L]";
        ProductFactory."Loan Receivable Account[G/L]" := ProductFactoryApplication."Loan Receivable Account[G/L]";
        ProductFactory."Loan Interest Account [G/L]" := ProductFactoryApplication."Loan Interest Account [G/L]";
        ProductFactory."Bill Account" := ProductFactoryApplication."Bill Account";
        ProductFactory."Billed Account" := ProductFactoryApplication."Billed Account";
        ProductFactory."Penalty Paid Account" := ProductFactoryApplication."Penalty Paid Account";
        ProductFactory."Withholding Tax Account" := ProductFactoryApplication."Withholding Tax Account";
        ProductFactory."Over Draft Interest Account" := ProductFactoryApplication."Over Draft Interest Account";
        ProductFactory."Interest Calc Min Balance" := ProductFactoryApplication."Interest Calc Min Balance";
        ProductFactory."Interest Expense Account" := ProductFactoryApplication."Interest Expense Account";
        ProductFactory."Interest Payable Account" := ProductFactoryApplication."Interest Payable Account";
        ProductFactory."Suspend Interest Account [G/L]" := ProductFactoryApplication."Suspend Interest Account [G/L]";

        ProductFactory."Loan Disbursement Account" := ProductFactoryApplication."Loan Disbursement Account";
        ProductFactory."Product Category" := ProductFactoryApplication."Product Category";
        ProductFactory."Auto Open Account" := ProductFactoryApplication."Auto Open Account";
        ProductFactory."Loan Security Inclination" := ProductFactoryApplication."Loan Security Inclination";
        ProductFactory."Allow Multiple Accounts" := ProductFactoryApplication."Allow Multiple Accounts";
        ProductFactory."Minimum Contribution" := ProductFactoryApplication."Minimum Contribution";
        ProductFactory."Minimum Balance" := ProductFactoryApplication."Minimum Balance";
        ProductFactory.Notice := ProductFactoryApplication.Notice;
        ProductFactory."Maximum Deposit Contribution" := ProductFactoryApplication."Minimum Deposit Contribution";
        ProductFactory."Minimum Dep. Contribution %" := ProductFactoryApplication."Minimum Dep. Contribution %";
        ProductFactory."Withdrawal Interval" := ProductFactoryApplication."Withdrawal Interval";
        ProductFactory."Maximum No. of Withdrawal" := ProductFactoryApplication."Maximum No. of Withdrawal";
        ProductFactory."Earns Interest" := ProductFactoryApplication."Earns Interest";
        ProductFactory."WithHolding Tax" := ProductFactoryApplication."WithHolding Tax";
        ProductFactory."Allow Over Draft" := ProductFactoryApplication."Allow Over Draft";
        ProductFactory."Credit Limit(Overdraft)" := ProductFactoryApplication."Credit Limit(Overdraft)";
        ProductFactory."Allow Multiple Over Draft" := ProductFactoryApplication."Allow Multiple Over Draft";
        ProductFactory."Over Draft Interest %" := ProductFactoryApplication."Over Draft Interest %";

        ProductFactory."Minimum Guarantors" := ProductFactoryApplication."Minimum Guarantors";
        ProductFactory."Maximum Guarantors" := ProductFactoryApplication."Maximum Guarantors";
        ProductFactory."Interest Calculation Method" := ProductFactoryApplication."Interest Calculation Method";
        ProductFactory."Min. Re-application Period" := ProductFactoryApplication."Min. Re-application Period";
        ProductFactory."Minimum Loan Amount" := ProductFactoryApplication."Minimum Loan Amount";
        ProductFactory."Maximum Loan Amount" := ProductFactoryApplication."Maximum Loan Amount";
        ProductFactory."Prefferential Default installm" := ProductFactoryApplication."Prefferential Default installm";
        ProductFactory."Ordinary Default Intallments" := ProductFactoryApplication."Ordinary Default Intallments";
        ProductFactory."Repay Mode" := ProductFactoryApplication."Repay Mode";
        ProductFactory."Use Cycle" := ProductFactoryApplication."Use Cycle";
        ProductFactory."Grace Period - Principle" := ProductFactoryApplication."Grace Period - Principle";
        ProductFactory."Grace Period - Interest" := ProductFactoryApplication."Grace Period - Interest";
        ProductFactory."Installment Repayment Interval" := ProductFactoryApplication."Installment Repayment Interval";
        ProductFactory."Compute Interest Due on Postin" := ProductFactoryApplication."Compute Interest Due on Postin";
        ProductFactory."Fixed Loan Term" := ProductFactoryApplication."Fixed Loan Term";
        ProductFactory."Preferential Dep. Multiplier" := ProductFactoryApplication."Preferential Share Multiplier";
        ProductFactory."Ordinary Deposits Multiplier" := ProductFactoryApplication."Ordinary Share Multiplier";
        ProductFactory."Loan Span" := ProductFactoryApplication."Loan Span";
        ProductFactory."Recovery Priority" := ProductFactoryApplication."Recovery Priority";
        ProductFactory."Source of Funds" := ProductFactoryApplication."Source of Funds";
        ProductFactory."Source Of Funds No." := ProductFactoryApplication."Source Of Funds No.";
        ProductFactory."Salary Period" := ProductFactoryApplication."Salary Period";
        ProductFactory."No. of Salary Times" := ProductFactoryApplication."No. of Salary Times";
        //ProductFactory."Search Code":=ProductFactoryApplication.."Search Code";
        //ProductFactory."Nature of Loan Type":=ProductFactoryApplication."Nature of Loan Type";
        //ProductFactory."Type of Discounting":=ProductFactoryApplication.."Type of Discounting";
        ProductFactory."Computation %" := ProductFactoryApplication."Computation %";
        ProductFactory.Insert;


        RelatedProductApplication.Reset;
        RelatedProductApplication.SetRange(RelatedProductApplication."Document No.", ProductFactoryApplication."No.");
        if RelatedProductApplication.Find('-') then begin
            repeat
                RelatedProduct.Init;
                RelatedProduct."Product Code" := ProductFactoryApplication."Product ID";
                RelatedProduct."Related Product Code" := RelatedProductApplication."Related Product Code";
                RelatedProduct."Related Product Desc" := RelatedProductApplication."Related Product Desc";
                RelatedProduct.Insert;
            until RelatedProductApplication.Next = 0;
        end;

        LoanProductChargeAppl.Reset;
        LoanProductChargeAppl.SetRange(LoanProductChargeAppl."Document No.", ProductFactoryApplication."No.");
        if LoanProductChargeAppl.Find('-') then begin
            repeat
                LoanProductCharge.Init;
                LoanProductCharge."Charge Code" := LoanProductChargeAppl."Charge Code";
                LoanProductCharge."Charge Description" := LoanProductChargeAppl."Charge Description";
                LoanProductCharge."Charge Amount" := LoanProductChargeAppl."Charge Amount";
                LoanProductCharge."Use Percentage" := LoanProductChargeAppl."Use Percentage";
                LoanProductCharge.Percentage := LoanProductChargeAppl.Percentage;
                LoanProductCharge."Charge Type" := LoanProductChargeAppl."Charge Type";
                LoanProductCharge."Charging Option" := LoanProductChargeAppl."Charging Option";
                LoanProductCharge."Product Code" := ProductFactoryApplication."Product ID";
                LoanProductCharge."Charges G_L Account" := LoanProductChargeAppl."Charges G_L Account";
                LoanProductCharge.Minimum := LoanProductChargeAppl.Minimum;
                LoanProductCharge.Maximum := LoanProductChargeAppl.Maximum;
                LoanProductCharge."Additional Charge %" := LoanProductChargeAppl."Additional Conditional Charge";
                LoanProductCharge.Insert;
            until LoanProductChargeAppl.Next = 0;
        end;

        DCSParameterMatrixAppl.Reset;
        DCSParameterMatrixAppl.SetRange(DCSParameterMatrixAppl."Document No.", ProductFactoryApplication."No.");
        if DCSParameterMatrixAppl.Find('-') then begin
            repeat
                DCSParameterMatrix.Init;
                DCSParameterMatrix."Loan Product Code" := ProductFactoryApplication."Product ID";
                DCSParameterMatrix."Parameter Code" := DCSParameterMatrixAppl."Parameter Code";
                DCSParameterMatrix."Parameter Desc" := DCSParameterMatrixAppl."Parameter Desc";
                DCSParameterMatrix.Factor := DCSParameterMatrixAppl.Factor;
                DCSParameterMatrix."Contributes To Score As" := DCSParameterMatrixAppl."Contributes To Score As";
                DCSParameterMatrix."Parameter Base" := DCSParameterMatrixAppl."Parameter Base";
                DCSParameterMatrix."Application Priority" := DCSParameterMatrixAppl."Application Priority";
                DCSParameterMatrix.Formula := DCSParameterMatrixAppl.Formula;
                DCSParameterMatrix."Parameter Base Unit" := DCSParameterMatrixAppl."Parameter Base Unit";
                DCSParameterMatrix."Success Default Value" := DCSParameterMatrixAppl."Success Default Value";
                DCSParameterMatrix."Parameter Scope" := DCSParameterMatrixAppl."Parameter Scope";
                DCSParameterMatrix."Failure Response" := DCSParameterMatrixAppl."Failure Response";
                DCSParameterMatrix."Date Formula" := DCSParameterMatrixAppl."Date Formula";
                DCSParameterMatrix."Data Source" := DCSParameterMatrixAppl."Data Source";
                DCSParameterMatrix."Computation Method" := DCSParameterMatrixAppl."Computation Method";
                DCSParameterMatrix."Fall Back Parameter" := DCSParameterMatrixAppl."Fall Back Parameter";
                DCSParameterMatrix.Insert;
            until DCSParameterMatrixAppl.Next = 0;
        end;

        ProductApplicationDocuments.Reset;
        ProductApplicationDocuments.SetRange(ProductApplicationDocuments."Document No.", ProductFactoryApplication."No.");
        if ProductApplicationDocuments.Find('-') then begin
            repeat
                ProductDocuments.Init;
                ProductDocuments."Entry No." := ProductApplicationDocuments."Entry No.";
                ProductDocuments."Document Type" := ProductApplicationDocuments."Document Type";
                ProductDocuments."Document No." := ProductApplicationDocuments."Document No.";
                ProductDocuments.Description := ProductApplicationDocuments.Description;
                ProductDocuments."Single Party/Multiple" := ProductApplicationDocuments."Single Party/Multiple";
                ProductDocuments."Product ID" := ProductFactoryApplication."Product ID";
                ProductDocuments."Product Name" := ProductFactoryApplication."Product Description";
                ProductDocuments.Insert;
            until ProductApplicationDocuments.Next = 0;
        end;
    end;


    procedure SendSMS1(FieldSupplied: Text; CodeUsed: Text; FormatedText: Text; SavingsAccounts: Record "Savings Accounts")
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        MessageBody: Text[130];
        ComposedMessage: Text[160];
        SendSms: Codeunit SendSms;
        SMSSetup: Record "SMS Setup";
        Charged: Boolean;
        SMSSeries: Record "SMS Series";
        SmsSource: Code[10];
        RecRef: RecordRef;
        Variant: Variant;
        TableName: Text;
        SavingsAccountApplication: Record "Savings Account Application";
    begin
        begin
            SMSSetup.Get;

            if SavingsAccounts.FieldName("No.") = FieldSupplied then begin
                // MessageBody := PeriodicActivities.Token(FormatedText, '[');
                ComposedMessage := MessageBody + SavingsAccounts."No.";
                Message(ComposedMessage);

                SavingsAccounts.TestField(SavingsAccounts."Phone No.");
                if SMSSetup."Subscription Type" = SMSSetup."subscription type"::Push then
                    Charged := false
                else
                    Charged := true;

                SMSSetup.TestField(SMSSetup."Member Creation");
                if SMSSeries.Get(SMSSetup."Member Creation") then
                    SmsSource := SMSSeries.Code;

                //Send SMS
                // SendSms.SendSms(Source, SavingsAccounts."Phone No.", ComposedMessage, SavingsAccounts."No.", SavingsAccounts."No.", Charged)
            end;

        end;
    end;



    procedure ApplyATMandMSACCO(MemberApplication: Record "Member Application"; FOSAACC: Code[50])
    var
        ATMApplications: Record "ATM Applications";
        ATMCardTypes: Record "ATM Card Types";
    begin
        begin
            // if MemberApplication."Auto Apply ATM" = true then begin
            //     ATMApplications.Init;
            //     ATMApplications."No." := '';
            //     ATMApplications."Account Type" := ATMApplications."account type"::Savings;
            //     ATMApplications."Account No" := FOSAACC;
            //     ATMApplications."Form No" := MemberApplication."No.";
            //     ATMApplications."Request Type" := ATMApplications."request type"::New;
            //     ATMApplications."Application Date" := Today;
            //     ATMApplications."Capture Date" := Today;
            //     ATMApplications."Captured By" := UserId;
            //     ATMApplications."Shortcut Dimension 1 Code" := MemberApplication."Global Dimension 1 Code";
            //     ATMApplications."Shortcut Dimension 2 Code" := MemberApplication."Global Dimension 2 Code";
            //     ATMApplications."Phone No." := MemberApplication."Phone No.";
            //     ATMApplications.Address := MemberApplication."Current Address";
            //     ATMApplications."Customer ID" := MemberApplication."Primary Identification";
            //     ATMCardTypes.Reset;
            //     if ATMCardTypes.Find('-') then
            //         ATMApplications."Card Type" := ATMCardTypes.Code;
            //     ATMApplications."Auto Applied" := true;
            //     ATMApplications.Validate(ATMApplications."Auto Applied");
            //     ATMApplications.Insert(true);
            // end;
        end;
    end;



    procedure PostRegistrationDeposit(MemberNo: Code[30]; AgentDocNo: Code[20]; ProductType: Code[10]; Source: Option MemberReg,AccountOpen)
    var
        JTemplate: Code[20];
        JBatch: Code[20];
        Agentcomm: Decimal;
        SaccoComm: Decimal;
        Vendorcomm: Decimal;
        Totalcomm: Decimal;
        AgentAccount: Code[20];
        SaccoCommAcc: Code[20];
        VendorCommAcc: Code[20];
        GlobalDim1: Text;
        GlobalDim2: Text[49];
        JournalPosting: Codeunit "Journal Posting";
        AgentCommAcc: Code[20];
        ExciseDutyAcc: Code[20];
        OptionsAccounts: Enum "Gen. Journal Account Type";
        ExciseDutyPercentage: Decimal;
        AgentTransactionDescription: Text[50];
        LoanTransactionType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills;
        ChargeExciseDuty: Boolean;
        ChargeFromExternalAmount: Boolean;
        ProductFactory: Record "Product Factory";
        AgentTrans: Record "Agent Transactions";
        LineNo: Integer;
        Sav: Record "Savings Accounts";
        Text101: label 'New Account Deposit via %1';
        GeneralSetUp: Record "General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        AccNo: Code[20];
        AgentApp: Record "Agent Applications";
    begin
        AgentTrans.Reset;
        AgentTrans.SetRange("Document No.", AgentDocNo);
        if AgentTrans.FindFirst then begin
            //IF AgentTrans.GET(AgentDocNo) THEN BEGIN
            if AgentTrans.Amount <= 0 then exit;

            Sav.Reset;
            Sav.SetRange("Member No.", MemberNo);
            Sav.SetRange("Product Type", ProductType);
            if not Sav.FindFirst then exit;

            GeneralSetUp.Get;
            GeneralSetUp.TestField("Agency Control Account");
            GeneralSetUp.TestField("Agency Posting Template");
            GeneralSetUp.TestField("Agency Posting Batch");

            JBatch := GeneralSetUp."Agency Posting Batch";
            JTemplate := GeneralSetUp."Agency Posting Template";
            JournalPosting.ClearJournalLines(JTemplate, JBatch);

            OptionsAccounts := Optionsaccounts::"G/L Account";
            AccNo := GeneralSetUp."Agency Control Account";
            if Source = Source::AccountOpen then begin
                AgentApp.Get(AgentTrans."Agent Code");
                OptionsAccounts := Optionsaccounts::Savings;
                AccNo := AgentApp.Account;
            end;

            LineNo += 1000;
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, OptionsAccounts, AgentTrans."Document No.", StrSubstNo(Text101, AgentTrans."Agent Code"), AgentTrans.Amount
               , AccNo, Today, Optionsaccounts::"G/L Account", '', AgentTrans."Document No.", Sav."Global Dimension 1 Code", Sav."Global Dimension 2 Code", TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            LineNo += 1000;
            JournalPosting.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, AgentTrans."Document No.", StrSubstNo(Text101, AgentTrans."Agent Code"), -AgentTrans.Amount
               , Sav."No.", Today, Optionsaccounts::"G/L Account", '', AgentTrans."Document No.", Sav."Global Dimension 1 Code", Sav."Global Dimension 2 Code", TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.FindFirst then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);


        end;
    end;


    procedure AccountRegistrationAuto(AccountApplication: Record "Savings Account Application") Acc: Code[20]
    var
        SavingsAcc: Record "Savings Accounts";
        AccountSignApp: Record "Signatory Application";
        AccountSign: Record "Account Signatories";
        GenSetUp: Record "General Set-Up";
        ProductFactory: Record "Product Factory";
        Suffix: Integer;
        SuffixText: Text;
        PeriodicAcc: Codeunit "Periodic Activities";
        IDNumber: Code[20];
        ImageData: Record "Image Data";
        SavingsAccounts: Record "Savings Accounts";
        CustMembrDocuments: Record "Application Documents";
        Text001: label 'This application has not been approved.';
        Text002: label 'Are you sure you want to convert this application to Account?';
        Text003: label 'Account No. %1 created successfully.';
        smsmessage: Text[160];
    begin
        if StrLen(AccountApplication."Transaction Mobile No") < 15 then begin
            AccountApplication."Transaction Mobile No" := '';
            AccountApplication.Modify;
        end;

        //IF NOT CONFIRM(Text002) =TRUE THEN EXIT;

        //check if member has same type of product account and add a suffix if the product factory allows multiple accounts
        SavingsAcc.Reset;
        SavingsAcc.SetRange(SavingsAcc."Member No.", AccountApplication."Member No.");
        SavingsAcc.SetRange(SavingsAcc."Product Type", AccountApplication."Product Type");
        Suffix := SavingsAcc.Count;

        SavingsAcc.Init;
        if ProductFactory.Get(AccountApplication."Product Type") then
            SuffixText := ProductFactory."Account No. Suffix" + Format(Suffix);
        if StrLen(SuffixText) = 3 then
            SuffixText := CopyStr(SuffixText, 2);
        if StrLen(SuffixText) = 4 then
            SuffixText := CopyStr(SuffixText, 3);
        if StrLen(SuffixText) = 5 then
            SuffixText := CopyStr(SuffixText, 4);
        SavingsAcc."No." := ProductFactory."Account No. Prefix" + AccountApplication."Member No." + '0' + SuffixText;
        SavingsAcc."Product Type" := AccountApplication."Product Type";
        SavingsAcc."Product Name" := ProductFactory."Product Description";
        SavingsAcc."Member No." := AccountApplication."Member No.";
        SavingsAcc.Validate(SavingsAcc.Name, AccountApplication.Name);
        SavingsAcc."ID No." := AccountApplication."ID No.";
        SavingsAcc."Passport No." := AccountApplication."Passport No.";
        SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
        SavingsAcc.County := AccountApplication.City;
        SavingsAcc."Monthly Contribution" := AccountApplication."Monthly Contribution";
        SavingsAcc.Validate(SavingsAcc."Monthly Contribution");
        SavingsAcc."Phone No." := AccountApplication."Phone No.";
        if AccountApplication."Transaction Mobile No" <> '' then
            SavingsAcc."Transactional Mobile No" := AccountApplication."Transaction Mobile No"
        else
            SavingsAcc."Transactional Mobile No" := AccountApplication."Phone No.";

        if AccountApplication."Mobile Phone No" <> '' then
            SavingsAcc."Mobile Phone No" := AccountApplication."Mobile Phone No"
        else
            SavingsAcc."Mobile Phone No" := AccountApplication."Phone No.";

        SavingsAcc."Current Address" := AccountApplication."Current Address";
        SavingsAcc."Post Code" := AccountApplication."Post Code";
        SavingsAcc.City := AccountApplication.City;
        SavingsAcc."Member Category" := AccountApplication."Member Category";
        SavingsAcc.Status := SavingsAcc.Status::New;
        SavingsAcc."Parent Account No." := AccountApplication."Parent Account No.";
        SavingsAcc."Country/Region Code" := AccountApplication."Country/Region Code";
        SavingsAcc."Home Address" := AccountApplication."Home Address";
        SavingsAcc."Registration Date" := Today;
        SavingsAcc."Date of Birth" := AccountApplication."Date of Birth";
        SavingsAcc."Birth Certificate No." := AccountApplication."Birth Certificate No.";
        SavingsAcc."Payroll/Staff No." := AccountApplication."Payroll/Staff No.";
        SavingsAcc."Recruited By" := AccountApplication."Recruited By";
        SavingsAcc."Recruited by Type" := AccountApplication."Recruited by Type";
        SavingsAcc."Relationship Manager" := AccountApplication."Relationship Manager";
        SavingsAcc."Responsibility Center" := AccountApplication."Responsibility Center";
        SavingsAcc."Company Registration No." := AccountApplication."Company Registration No.";
        SavingsAcc."Employer Code" := AccountApplication."Employer Code";
        SavingsAcc."Old Member No." := AccountApplication."Old Member No.";
        SavingsAcc."Associated Member No." := AccountApplication."Associated Member No.";
        SavingsAcc."Global Dimension 1 Code" := AccountApplication."Global Dimension 1 Code";
        SavingsAcc."Global Dimension 2 Code" := AccountApplication."Global Dimension 2 Code";
        SavingsAcc."Group Account No" := AccountApplication."Group Account No";
        SavingsAcc."Created By" := AccountApplication."Created By";
        SavingsAcc."Savings Account No." := AccountApplication."Savings Account No.";
        SavingsAcc."Fixed Deposit Type" := AccountApplication."Fixed Deposit Type";
        SavingsAcc."Product Category" := AccountApplication."Product Category";
        if SavingsAcc."Product Category" = SavingsAcc."product category"::"Fixed Deposit" then
            SavingsAcc."Fixed Deposit Status" := AccountApplication."fixed deposit status"::Active;
        SavingsAcc."FD Maturity Date" := AccountApplication."FD Maturity Date";
        SavingsAcc."Neg. Interest Rate" := AccountApplication."Neg. Interest Rate";
        SavingsAcc."FD Duration" := AccountApplication."FD Duration";
        SavingsAcc."FD Maturity Instructions" := AccountApplication."FD Maturity Instructions";
        SavingsAcc."Fixed Deposit cert. no" := AccountApplication."Fixed Deposit cert. no";
        SavingsAcc."Fixed Deposit Amount" := AccountApplication."Fixed Deposit Amount";
        SavingsAcc."Signing Instructions" := AccountApplication."Signing Instructions";
        SavingsAcc.Insert;

        case AccountApplication."Product Category" of
        // AccountApplication."product category"::"Junior Savings":
        //     begin
        //         AccountApplication.CalcFields(AccountApplication.Picture, AccountApplication.Signature);
        //         if (AccountApplication."Birth Certificate No." = '') and (AccountApplication."Passport No." <> '') then
        //             IDNumber := AccountApplication."Passport No.";
        //         if (AccountApplication."Birth Certificate No." <> '') and (AccountApplication."Passport No." = '') then
        //             IDNumber := AccountApplication."Birth Certificate No.";
        //         if (AccountApplication."Birth Certificate No." <> '') and (AccountApplication."Passport No." <> '') then
        //             IDNumber := AccountApplication."Birth Certificate No.";

        //         AccountApplication.CalcFields(AccountApplication.Picture, AccountApplication.Signature);

        //         ImageData."ID Number" := IDNumber;
        //         ImageData.Picture := AccountApplication.Picture;
        //         ImageData.Signature := AccountApplication.Signature;
        //         ImageData."Member No" := SavingsAcc."No.";
        //         ImageData.Insert(true);

        //         if AccountApplication.Picture.Hasvalue then begin
        //             Clear(AccountApplication.Picture);
        //             AccountApplication.Modify;
        //         end;

        //         if AccountApplication.Signature.Hasvalue then begin
        //             Clear(AccountApplication.Signature);
        //             AccountApplication.Modify;
        //         end;

        //     end;
        end;

        CustMembrDocuments.Reset;
        CustMembrDocuments.SetRange(CustMembrDocuments."Reference No.", SavingsAcc."Member No.");
        if CustMembrDocuments.Find('-') then begin
            repeat
                EntrNo += 1;
                ApplicationDocuments(EntrNo, CustMembrDocuments."Document Type", CustMembrDocuments."Document No.", CustMembrDocuments.Description, CustMembrDocuments."Single Party/Multiple",
                                     SavingsAcc."Member No.", CustMembrDocuments."Product ID", CustMembrDocuments."Product Name", CustMembrDocuments.Provided);
            until CustMembrDocuments.Next = 0;
        end;


        //Advice
        if SavingsAccounts.Get(SavingsAcc."No.") then begin
            SavingsAccounts.Validate(SavingsAccounts."Monthly Contribution");
        end;
        //******

        PostRegistrationDeposit(SavingsAcc."Member No.", AccountApplication."Agent Document No", SavingsAcc."Product Type", 0);

        smsmessage := 'Dear Member ' + SavingsAcc.Name + '' + SavingsAcc."Member No." + ', Your account has been successfully created. Your account number is ' + SavingsAcc."No." + '. Thank you for choosing us.';
        SendSMS.SendSms(Source::NEW_ACCOUNT, SavingsAcc."Mobile Phone No", smsmessage, Format(SavingsAcc."Mobile Phone No"), '', true, 0, false, 'CBS', SavingsAcc."Mobile Phone No", 'CBS');

        AccountApplication.Status := AccountApplication.Status::Created;
        AccountApplication.Modify;
        Acc := SavingsAcc."No.";
    end;


    procedure AnySavingsAccountRegistration(MemNo: Code[10]; ProductCode: Code[10])
    var
        SavingsAcc: Record "Savings Accounts";
        AccountSignApp: Record "Signatory Application";
        AccountSign: Record "Account Signatories";
        GenSetUp: Record "General Set-Up";
        ProductFactory: Record "Product Factory";
        Suffix: Integer;
        SuffixText: Text;
        PeriodicAcc: Codeunit "Periodic Activities";
        IDNumber: Code[20];
        ImageData: Record "Image Data";
        SavingsAccounts: Record "Savings Accounts";
        CustMembrDocuments: Record "Application Documents";
        Text001: label 'This application has not been approved.';
        Text002: label 'Are you sure you want to convert this application to Account?';
        Text003: label 'Account No. %1 created successfully.';
    begin
        //check if member has same type of product account and add a suffix if the product factory allows multiple accounts
        SavingsAcc.Reset;
        SavingsAcc.SetRange(SavingsAcc."Member No.", MemNo);
        SavingsAcc.SetRange(SavingsAcc."Product Type", ProductCode);
        Suffix := SavingsAcc.Count;
        Cust.Get(MemNo);

        SavingsAcc.Init;
        if ProductFactory.Get(ProductCode) then
            SuffixText := ProductFactory."Account No. Suffix" + Format(Suffix);
        if StrLen(SuffixText) = 3 then
            SuffixText := CopyStr(SuffixText, 2);
        if StrLen(SuffixText) = 4 then
            SuffixText := CopyStr(SuffixText, 3);
        if StrLen(SuffixText) = 5 then
            SuffixText := CopyStr(SuffixText, 4);
        SavingsAcc."No." := ProductFactory."Account No. Prefix" + MemNo + '0' + SuffixText;
        SavingsAcc."Product Type" := ProductFactory."Product ID";
        SavingsAcc."Product Name" := ProductFactory."Product Description";
        SavingsAcc."Member No." := MemNo;
        SavingsAcc.Validate(SavingsAcc.Name, Cust.Name);
        SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
        SavingsAcc.County := Cust.City;
        SavingsAcc."Monthly Contribution" := ProductFactory."Minimum Contribution";
        SavingsAcc.Validate(SavingsAcc."Monthly Contribution");
        SavingsAcc."Phone No." := Cust."Phone No.";
        SavingsAcc."Current Address" := Cust."Current Address";
        SavingsAcc."Post Code" := Cust."Post Code";
        SavingsAcc.City := Cust.City;
        SavingsAcc."Member Category" := Cust."Member Class";
        SavingsAcc.Status := SavingsAcc.Status::New;
        //SavingsAcc."Parent Account No.":=AccountApplication."Parent Account No.";
        //SavingsAcc."Country/Region Code" :=;
        SavingsAcc."Home Address" := Cust."Home Address";
        SavingsAcc."Registration Date" := Today;
        SavingsAcc."Date of Birth" := Cust."Date of Birth";
        //SavingsAcc."Birth Certificate No.":=AccountApplication."Birth Certificate No.";
        SavingsAcc."Payroll/Staff No." := Cust."Payroll/Staff No.";
        //SavingsAcc."Recruited By":=USERID;
        SavingsAcc.Gender := Cust.Gender;
        //SavingsAcc."Recruited by Type":=AccountApplication."Recruited by Type";
        SavingsAcc."Relationship Manager" := Cust."Allocated Officer";
        SavingsAcc."Marital Status" := Cust."Marital Status";
        SavingsAcc."Responsibility Center" := Cust."Responsibility Center";
        SavingsAcc."Company Registration No." := Cust."Company Registration No.";
        SavingsAcc."Employer Code" := Cust."Employer Code";
        SavingsAcc."Old Member No." := Cust."Old Member No.";
        SavingsAcc."Associated Member No." := Cust."Principle Member";
        SavingsAcc."Global Dimension 1 Code" := Cust."Global Dimension 1 Code";
        SavingsAcc."Global Dimension 2 Code" := Cust."Global Dimension 2 Code";
        SavingsAcc."Group Account No" := Cust."Group Account No.";
        SavingsAcc."Created By" := UserId;
        //SavingsAcc."Savings Account No." := AccountApplication."Savings Account No.";
        //SavingsAcc."Fixed Deposit Type" :=ProductFacto;
        SavingsAcc."Product Category" := ProductFactory."Product Category";
        SavingsAcc."Can Guarantee Loan" := ProductFactory."Can Guarantee Loan";
        if SavingsAcc."Product Category" = SavingsAcc."product category"::"Fixed Deposit" then
            SavingsAcc."Fixed Deposit Status" := SavingsAcc."fixed deposit status"::Active;
        //SavingsAcc."FD Maturity Date" := ;
        //SavingsAcc."Neg. Interest Rate" := AccountApplication."Neg. Interest Rate";
        //SavingsAcc."FD Duration" := AccountApplication."FD Duration";
        //SavingsAcc."FD Maturity Instructions" := AccountApplication."FD Maturity Instructions";
        //SavingsAcc."Fixed Deposit cert. no" := AccountApplication."Fixed Deposit cert. no";
        //SavingsAcc."Fixed Deposit Amount" := AccountApplication."Fixed Deposit Amount";
        //SavingsAcc."Signing Instructions":=AccountApplication."Signing Instructions";
        SavingsAcc.Insert;

        /*CASE ProductFactory."Product Category" OF
         ProductFactory."Product Category"::"Junior Savings" :
          BEGIN
           AccountApplication.CALCFIELDS(AccountApplication.Picture,AccountApplication.Signature);
           IF (AccountApplication."Birth Certificate No." = '') AND (AccountApplication."Passport No." <> '') THEN
            IDNumber:= AccountApplication."Passport No.";
           IF (AccountApplication."Birth Certificate No." <> '') AND (AccountApplication."Passport No." = '') THEN
            IDNumber:= AccountApplication."Birth Certificate No.";
           IF (AccountApplication."Birth Certificate No." <> '') AND (AccountApplication."Passport No." <> '') THEN
            IDNumber:= AccountApplication."Birth Certificate No.";

           AccountApplication.CALCFIELDS(AccountApplication.Picture,AccountApplication.Signature);

           ImageData."ID Number":=IDNumber;
           ImageData.Picture:=AccountApplication.Picture;
           ImageData.Signature:=AccountApplication.Signature;
           ImageData."Member No":=SavingsAcc."No.";
           ImageData.INSERT(TRUE);

           IF AccountApplication.Picture.HASVALUE THEN BEGIN
           CLEAR(AccountApplication.Picture);
           AccountApplication.MODIFY;
           END;

           IF AccountApplication.Signature.HASVALUE THEN BEGIN
           CLEAR(AccountApplication.Signature);
           AccountApplication.MODIFY;
           END;

          END;
        END;

      CustMembrDocuments.RESET;
      CustMembrDocuments.SETRANGE(CustMembrDocuments."Reference No.",SavingsAcc."Member No.");
      IF CustMembrDocuments.FIND('-') THEN BEGIN
        REPEAT
        EntrNo+=1;
        ApplicationDocuments(EntrNo,CustMembrDocuments."Document Type",CustMembrDocuments."Document No.",CustMembrDocuments.Description,CustMembrDocuments."Single Party/Multiple",
                             SavingsAcc."Member No.",CustMembrDocuments."Product ID",CustMembrDocuments."Product Name",CustMembrDocuments.Provided);
          UNTIL CustMembrDocuments.NEXT=0;
      END;


        //Advice
        IF SavingsAccounts.GET(SavingsAcc."No.") THEN BEGIN
          SavingsAccounts.VALIDATE(SavingsAccounts."Monthly Contribution");
          END;
        //******

      PostRegistrationDeposit(SavingsAcc."Member No.",AccountApplication."Agent Document No",SavingsAcc."Product Type",0);


       SendSMS.SendSms(SourceType::"New Account",SavingsAcc."Mobile Phone No",Text004 +
                      COMPANYNAME +', '+Text005 + SavingsAccounts."No.",SavingsAcc."No.",SavingsAccounts."No.",FALSE);*/

        //AccountApplication.Status:=AccountApplication.Status::Created; AccountApplication.MODIFY;
        //MESSAGE(Text003,SavingsAcc ."No.");

    end;


    procedure AdviceSavings(SavingsAccounts: Record "Savings Accounts"; OldAmount: Decimal; NewAmount: Decimal)
    var
        CheckoffAdvice: Record "Checkoff Advice Line";
        iEntryNo: Integer;
        SavingsAccount: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
        ProductFactory: Record "Product Factory";
        Members: Record Members;
    begin
        //Advice Deposits Changes
        begin
            SavingsAccounts.CalcFields("Balance (LCY)");
            iEntryNo := 0;
            CheckoffAdvice.Reset;
            if CheckoffAdvice.Find('+') then
                iEntryNo := CheckoffAdvice."Entry No" + 1;
            if Members.Get(SavingsAccounts."Member No.") then begin
                if MemberClass.Get(Members."Member Class") then begin
                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then
                        //NewAmount:=MemberClass."Default BOSA Deposit";
                        if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Benevolent (BBF)" then begin
                            // if ProductFactory.Get("Product Type") then begin
                            //     //NewAmount:=ProductFactory."Minimum Contribution";
                            // end;
                        end;
                end;

            end;

            if (SavingsAccounts.Status = SavingsAccounts.Status::Closed) or (SavingsAccounts.Status = SavingsAccounts.Status::New) then
                OldAmount := 0;

            CheckoffAdvice.Init;
            CheckoffAdvice."Entry No" := iEntryNo;
            CheckoffAdvice."Account No." := SavingsAccounts."No.";
            CheckoffAdvice."Member No." := SavingsAccounts."Member No.";
            CheckoffAdvice."Payroll No" := SavingsAccounts."Payroll/Staff No.";
            CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
            CheckoffAdvice."Amount On" := NewAmount;
            CheckoffAdvice."Amount Off" := 0;
            CheckoffAdvice.Type := CheckoffAdvice.Type::Savings;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", SavingsAccounts."No.");
            if SavingsAccount.Find('-') then begin
                SavingsAccount.CalcFields("Balance (LCY)");
                CheckoffAdvice."Balance On" := SavingsAccount."Balance (LCY)";

                if SavingsAccount."Employer Account No" <> '' then
                    CheckoffAdvice."Employer Account No." := SavingsAccount."Employer Account No"
                else
                    CheckoffAdvice."Employer Account No." := SavingsAccount."No.";
            end;

            if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                SavingsAccount.Reset;
                SavingsAccount.SetRange("Member No.", SavingsAccounts."Member No.");
                SavingsAccount.SetFilter(Status, '<>%1', SavingsAccount.Status::Closed);
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"BOSA Deposits");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    if SavingsAccount."Employer Balance" = 0 then
                        CheckoffAdvice."Balance On" := /*CheckoffAdvice."Balance On"+*/SavingsAccount."Balance (LCY)"//Commented to prevent doubling of balance on
                    else
                        CheckoffAdvice."Balance On" := NewAmount + SavingsAccount."Employer Balance";
                end;
            end;

            CheckoffAdvice."Advice Method" := CheckoffAdvice."advice method"::Changes;
            CheckoffAdvice."Advice Date" := Today;
            CheckoffAdvice."ID No." := SavingsAccounts."ID No.";
            CheckoffAdvice."Employer Code" := SavingsAccounts."Employer Code";
            CheckoffAdvice.Names := SavingsAccounts.Name;
            CheckoffAdvice."Product Type" := SavingsAccounts."Product Type";
            if NewAmount = OldAmount then
                CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Adjustment
            else
                CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Variations;
            // if NewAmount = 0 then begin
            //     CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Stoppage;
            //     CheckoffAdvice."Balance Off" := SavingsAccount."Monthly Contribution";
            // end else
            //     if "Balance (LCY)" = 0 then
            //         CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::New;
            //**CheckoffAdvice.VALIDATE(CheckoffAdvice."Account No.");
            CheckoffAdvice.Validate(CheckoffAdvice."Product Type");
            if (CheckoffAdvice."Amount On" <> 0) or (CheckoffAdvice."Amount Off" <> 0) or (CheckoffAdvice."Balance On" <> 0) or (CheckoffAdvice."Advice Type" = CheckoffAdvice."advice type"::Stoppage) then
                CheckoffAdvice.Insert(true);
        end;

    end;

    local procedure HasProrataContractualDep(MemberNo: Code[20]) HasProrataContractualDep: Boolean
    var
        MemberProrataContractualDep: Record "Member Prorata_Contractual Dep";
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        ProrataAmt: Decimal;
    begin
        // MemberProrataContractualDep.Reset();
        // MemberProrataContractualDep.SetRange("Member No", MemberNo);
        // HasProrataContractualDep := MemberProrataContractualDep.FindFirst();


        ProrataAmt := CustomCuesCodeunit.Prorata(MemberNo, '1');
        if ProrataAmt > 0 then
            HasProrataContractualDep := true else
            HasProrataContractualDep := false;
    end;


    local procedure GetMemberProrataAmount(MemberNo: Code[20]; StartDate: Date; EndDate: Date) ProrataAmount: Decimal
    var
        MemberProrataContractualDep: Record "Member Prorata_Contractual Dep";
        InitialProrataAmount: Decimal;
        CurrentProrataAmount: Decimal;
        SavingsAccounts: Record "Savings Accounts";
    begin
        SavingsAccounts.Reset();
        SavingsAccounts.SetRange("Member No.", MemberNo);
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.FindFirst() then
            CurrentProrataAmount := SavingsAccounts."Monthly Contribution";

        MemberProrataContractualDep.Reset();
        MemberProrataContractualDep.SetRange("Member No", MemberNo);
        MemberProrataContractualDep.SetFilter("Effective Date", '<%1', StartDate - 1);
        If MemberProrataContractualDep.FindLast() then
            InitialProrataAmount := MemberProrataContractualDep.Amount;

        if InitialProrataAmount <> 0 then
            CurrentProrataAmount := InitialProrataAmount;

        MemberProrataContractualDep.Reset();
        MemberProrataContractualDep.SetRange("Member No", MemberNo);
        MemberProrataContractualDep.SetRange("Effective Date", StartDate, EndDate);
        if MemberProrataContractualDep.FindSet() then
            repeat
                CurrentProrataAmount := MemberProrataContractualDep.Amount;

            until MemberProrataContractualDep.Next() = 0;

        ProrataAmount := CurrentProrataAmount;

    end;

    local procedure GetSavingsArrears(MemberNo: Code[20]; ProductType: Code[10]; StartDate: Date; EndDate: Date; IsProrata: Boolean) SavingsProductArrears: Decimal
    var
        SavingsAccounts: Record "Savings Accounts";
        NoOfMonths: Integer;
        NoOfDays: Integer;
        AmountContributed: Decimal;
        AmountExpected: Decimal;
        SavProd: Record "Product Factory";
    begin
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", MemberNo);
        SavingsAccounts.SetRange("Product Type", ProductType);
        SavingsAccounts.SetRange("Date Filter", StartDate, EndDate);
        SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
        If SavingsAccounts.FindFirst() then begin
            SavProd.Get(ProductType);
            NoOfDays := EndDate - StartDate;
            NoOfMonths := Round(NoOfDays / 30, 1, '=');
            if SavingsAccounts."Monthly Contribution" < SavProd."Minimum Contribution" then
                SavingsAccounts."Monthly Contribution" := SavProd."Minimum Contribution";

            AmountExpected := SavingsAccounts."Monthly Contribution" * NoOfMonths;

            //
            if IsProrata then begin
                AmountExpected := GetMemberProrataAmount(MemberNo, StartDate, EndDate) * NoOfMonths;
                AmountContributed := SavingsAccounts."Balance (LCY)";
                SavingsProductArrears := AmountExpected - AmountContributed;
            end
            else begin
                SavingsProductArrears := SavProd.GetRiskBBfArrears(SavingsAccounts."No.");
            end;

            if SavingsProductArrears < 0 then
                SavingsProductArrears := 0;
        end;
    end;

    local procedure GetSavingsProrataArrears(MemberNo: Code[20]; ProductType: Code[10]; StartDate: Date; EndDate: Date) SavingsProrataArrears: Decimal
    var
        MemberProrataContractualDep: Record "Member Prorata_Contractual Dep";
        FirstProrataDate: Date;
    begin
        FirstProrataDate := StartDate;
        repeat

            SavingsProrataArrears += GetSavingsArrears(MemberNo, ProductType, FirstProrataDate, CalcDate('1M', FirstProrataDate), true);
            FirstProrataDate := CalcDate('1M', FirstProrataDate);
        until FirstProrataDate >= EndDate;
    end;

    procedure CalculateSavingArrears(MemberNo: Code[20]; ProductType: Code[10]; Period: DateFormula; AsAt: Date) SavingsProductArrears: Decimal
    var
        MemberProrataContractualDep: Record "Member Prorata_Contractual Dep";
        StartDate: Date;
        SavingsAccounts: Record "Savings Accounts";
        AmountContributed: Decimal;
        AmountExpected: Decimal;
        SavingsProduct: Record "Product Factory";

    begin
        StartDate := CalcDate('-' + FORMAT(Period), AsAt);
        SavingsProductArrears := 0;
        if SavingsProduct.Get(ProductType) then begin
            if (SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"BOSA Deposits") or (not HasProrataContractualDep(MemberNo))
            then begin
                SavingsProductArrears := GetSavingsArrears(MemberNo, ProductType, StartDate, AsAt, false);
            end else begin
                SavingsProductArrears := GetSavingsProrataArrears(MemberNo, ProductType, StartDate, AsAt);
            end;
        end;
    end;

}
