table 52187421 "Product Variations"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "Variation Type" = Rec."Variation Type"::Loan then begin
                    if "No." <> xRec."No." then begin
                        NoSetup.Get();
                        noSetup.TestField(NoSetup."Variations");
                        NoSeriesMgt.TestManual(NoSetup."Variations");
                        // NoSeriesCU.TestManual(NoSetup."Variations");
                        "No. Series" := '';
                    end;
                end;
                if "Variation Type" = Rec."Variation Type"::Savings then begin
                    if "No." <> xRec."No." then begin
                        NoSetup.Get();
                        NoSetup.TestField(NoSetup."Savings Variations");
                        NoSeriesMgt.TestManual(NoSetup."Savings Variations");
                        // NoSeriesCU.TestManual(NoSetup."Variations");
                        "No. Series" := '';
                    end;
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members."No." where(Status = filter(<> Deceased & <> Closed));
            trigger OnValidate()
            var
                Productva: Record "Product Variations";
                ProCo: Integer;
            begin
                members.Reset();
                members.SetRange("No.", Rec."Member No.");
                members.SetFilter(Status, '%1|%2', members.Status::Deceased, members.Status::Closed);
                if members.FindFirst() then
                    Error('Member with status %1 is NOT allowed to do variations', members.Status);
                if members.Get("Member No.") then begin
                    "Member Name" := members.Name;
                    "Payroll No" := members."Payroll/Staff No.";

                end;
                Productva.Reset();
                Productva.SetRange(Productva."Member No.", Rec."Member No.");
                Productva.SetFilter(Status, '%1|%2', Productva.Status::Open, Productva.Status::"Pending");
                Productva.SetRange("Variation Type", Rec."Variation Type");
                if Productva.FindFirst() then begin
                    if Productva."No." <> Rec."No." then begin
                        Error('Member has existing %2 variation application of No. %1 at status %3', Productva."No.", Productva."Variation Type", Productva.Status);
                    end;
                end;

                // if "Variation Type" = "Variation Type"::Loan then begin
                //     GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Loan Variations");
                // end;

                // if "Variation Type" = "Variation Type"::Savings then begin
                //     GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Savings Variations");
                // end;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
            Editable = false;
        }

        field(18; "Payroll No"; Text[50])
        {
            Editable = false;
        }

        field(19; "Reference"; Text[50])
        {

        }
        field(71; "Effective Months"; Date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date";
        }
        field(22; "Product Name"; text[50])
        {

        }
        field(24; "Actual Amount"; decimal)
        {

        }
        field(25; Status; Enum "Workflow Status Main Flags") //Option)

        {
            // OptionMembers = Open,"Pending Approval",Approved,Rejected,Cancelled;
            Editable = False;
            // trigger OnValidate() begin
            //     if Status=Status::Approved then begin
            //         Loans.Reset();
            //         Loans.setrange("Member No.","Member No.");
            //         if loans.Get("Member No.") then
            //          Loans."Variated Amount":= rec."Actual Amount";
            //         Loans.Modify;

            //     end;
            // end;
        }

        field(23; "Variation Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Loan,Savings';
            OptionMembers = " ",Loan,Savings;
            // TableRelation= "Product Factory"."Product Class Type";


            trigger OnValidate()
            begin

                //     "Account No":='';
                //     "Amount On":=0;
                //     "Amount Off":=0;
                //     Difference:=0;
                //   IF ProductFactory.get("Variation Type") then begin
                //      TestField("Member No.");

            end;

            // end;

        }
        field(21; "Product Type"; code[40])
        {


            Description = 'LookUp into Product Factory Table';
            TableRelation = IF ("Variation Type" = FILTER(Savings)) "Product Factory"."Product ID" WHERE("Product Class Type" = FIELD("Variation Type"), "Variation Allowed" = const(true))
            ELSE
            IF ("Variation Type" = FILTER(Loan)) "Product Factory"."Product ID" WHERE("Product Class Type" = FIELD("Variation Type"));
            trigger OnValidate()
            begin
                TestField("Variation Type");


                ProductFactory.reset();
                ProductFactory.setrange("Product ID", "Product Type");
                if ProductFactory.Find('-') then begin
                    "Product Name" := ProductFactory."Product Description";

                end;
            end;

        }
        field(20; "Account No"; Code[50])

        {
            TableRelation = IF ("Variation Type" = FILTER(Savings)) "Savings Accounts"."No." WHERE("Member No." = FIELD("Member No."))
            ELSE
            IF ("Variation Type" = FILTER(Loan)) Loans."Loan No." WHERE("Member No." = FIELD("Member No."), "Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            var
                Checkoffline: Record "Checkoff Advice Line";
                LoansRec: Record Loans;
                SavingsSav: Record "Savings Accounts";
            begin
                Balance := 0;
                if ("Account No" <> '') and ("Variation Type" = rec."Variation Type"::Savings) then begin
                    SavingsSav.Reset();
                    SavingsSav.SetRange(SavingsSav."No.", Rec."Account No");
                    if SavingsSav.FindFirst() then begin
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Product ID", SavingsSav."Product Type");
                        if ProductFactory.FindFirst() then
                            if ProductFactory."Variation Allowed" = false then
                                Error('Product is not allowed for variation') ELSE begin
                                Rec."Product Type" := ProductFactory."Product ID";
                                Rec."Product Name" := ProductFactory."Product Description";
                                prorata.reset();
                                prorata.SetRange("Member No", "Member No.");
                                if prorata.find('-') then begin
                                    members.Reset();
                                    if members.Get(rec."Member No.") then
                                        "Amount off" := prorata.Amount
                                end else begin
                                    SavingsAccount.Reset();
                                    SavingsAccount.SetRange("No.", "Account No");
                                    if SavingsAccount.Find('-') then begin
                                        SavingsAccount.CalcFields("Balance (LCY)");
                                        Balance := SavingsAccount."Balance (LCY)";
                                        Members.Reset;
                                        if members.get(rec."Member No.") then
                                            "Amount off" := SavingsAccount."Monthly Contribution";
                                    end;
                                end;
                            end else begin
                            SavingsAccount.Reset();
                            SavingsAccount.SetRange("No.", "Account No");
                            if SavingsAccount.Find('-') then begin
                                "Amount Off" := SavingsAccount."Monthly Contribution";
                            end;
                        end;
                    end;
                END;
                if "Variation Type" = Rec."Variation Type"::Loan then begin
                    LoansRec.Reset();
                    LoansRec.SetRange(LoansRec."Loan No.", Rec."Account No");
                    if LoansRec.FindFirst() then begin
                        Rec."Product Type" := LoansRec."Loan Product Type";
                        Rec."Product Name" := LoansRec."Loan Product Type Name";

                        Rec."Amount Off" := LoansRec.Repayment;

                        if Rec."Initial Repayment" = 0 then begin
                            Rec."Initial Repayment" := LoansRec.Repayment;
                        end;
                        LoansRec.CalcFields("Total Loan Balance", "Daily Interest");
                        Rec.Balance := LoansRec."Total Loan Balance" + LoansRec."Daily Interest";
                        Rec."Minimum Variated Amount" := LoansRec.Repayment;

                        Checkoffline.Reset();
                        Checkoffline.SetRange("Loan No.", Rec."Account No");
                        if Checkoffline.FindLast() then begin
                            Rec."Amount Off" := Checkoffline."Amount On";
                            if rec."Initial Repayment" = 0 then begin
                                Rec."Initial Repayment" := Checkoffline."Amount On";
                            end;

                            if rec."Amount Off" = 0 then begin
                                Rec."Amount Off" := LoansRec.Repayment;
                            end;
                            if rec."Initial Repayment" = 0 then begin
                                Rec."Initial Repayment" := LoansRec.Repayment;
                            end;
                        end;
                        // LoansRec.Reset();
                        // LoansRec.SetRange("Member No.", Rec."Member No.");
                        // LoansRec.SetRange("Loan No.", Rec."Account No");
                        // LoansRec.SetFilter("Outstanding Balance", '>%1', 0);
                        // if LoansRec.FindFirst() then begin
                        //     LoansRec.CalcFields("Total Balance", "Daily Interest");
                        //     Balance := LoansRec."Total Balance" + LoansRec."Daily Interest";

                        // end;
                    end;
                end;
            end;



        }
        field(26; "CRM Application No."; text[20])
        {
            Editable = false;
        }

        field(126; "CRM No. Series"; Code[10])
        {

        }
        field(36; "CRM Notes"; text[50])
        {
            Editable = false;
        }
        field(37; "CRM Originating Branch"; text[20])
        {
            Editable = false;
        }
        field(38; "CRM Created By"; Code[100])
        {
            Editable = false;
        }
        field(27; "Effective Month"; Date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date";
        }



        field(17; "No. Series"; Code[10])
        {
        }
        field(8; "Amount On"; decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
                ProductFa: Record "Product Factory";
                LoansRec: Record Loans;
                chekoflines: Record "Checkoff Advice Line";
                AmountVar: Decimal;
                MaxVaria: Decimal;
                MemberClasses: Record "Member Classes";
                Memba: Record Members;
                SavingsAccounts: Record "Savings Accounts";
                CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                ProrataAmt: Decimal;
                ErrAmtOn: Label 'Amount On cannot be less than the default BOSA deposit of %1 for Member Class %2';
            begin
                TestField("Variation Type");
                TestField("Member No.");
                Memba.Get("Member No.");


                if Rec."Amount Off" = Rec."Amount On" then
                    Error('You cannot variate the same amount');

                if "Amount On" <> 0 then
                    if Rec."Variation Type" = Rec."Variation Type"::Loan then begin
                        LoansRec.Reset();
                        LoansRec.SetRange(LoansRec."Member No.", Rec."Member No.");
                        LoansRec.SetRange(LoansRec."Loan No.", Rec."Account No");
                        LoansRec.SetFilter("Outstanding Balance", '>%1', 0);
                        if LoansRec.findfirst() then begin
                            // if Rec."Amount On" < LoansRec.Repayment then
                            if LoansRec."Interest Calculation Method" = LoansRec."Interest Calculation Method"::Amortised then begin
                                if Rec."Amount On" < Rec."Initial Repayment" then
                                    Error('You cannot variate below the loan repayment amount');
                            end
                            else begin
                                if Rec."Amount On" < LoansRec."Loan Principle Repayment" then Error('The variated repayment cannot be less than Loan Principle Repayment.');
                            end;
                        end;
                        Message('Kindly note For Armotized loans we are varying Repayment and Reducing balance we are varying loan Principal repayment.');
                    end;
                if Rec."Variation Type" = Rec."Variation Type"::Savings then begin
                    SavingsAccounts.Reset();
                    SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.Find('-') then begin
                        ProrataAmt := CustomCuesCodeunit.Prorata(SavingsAccounts."Member No.", SavingsAccounts."Product Type");
                        if Rec."Amount On" <= ProrataAmt then
                            Error('Cannot variate below the prorata amount');
                    end;
                    SavingsAccounts.Get("Account No");
                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then
                        if MemberClasses.Get(Memba."Member Class") then begin
                            if MemberClasses."Default BOSA Deposit" > "Amount On" then
                                Error(ErrAmtOn, MemberClasses."Default BOSA Deposit", MemberClasses."No.");
                        end;

                    if "Amount On" <> 0 then begin
                        LoansRec.Reset();
                        LoansRec.SetRange("Member No.", Rec."Member No.");
                        LoansRec.SetRange("Loan No.", Rec."Account No");
                        LoansRec.SetFilter("Outstanding Balance", '>%1', 0);
                        if LoansRec.FindFirst() then begin
                            chekoflines.Reset();
                            chekoflines.SetRange("Member No.", Rec."Member No.");
                            chekoflines.SetRange(Type, chekoflines.Type::Savings);
                            if chekoflines.FindLast() then
                                AmountVar := chekoflines."Amount On";
                            if Rec."Amount On" < AmountVar then
                                Error('You cannot variate below the set limit until loan balance is Zero');
                        end;
                        ProductFactory.Reset();
                        ProductFactory.SetRange("Product ID", rec."Product Type");
                        if ProductFactory.FindFirst() then begin
                            MaxVaria := ProductFactory."Minimum Contribution";
                            if Rec."Amount On" < MaxVaria then
                                Error('You cannot variate below the product limit');
                        end;
                    end;
                end;
            end;

        }
        field(9; "Amount Off"; Decimal)
        {
        }
        field(11; "Prorata"; Decimal)
        {
        }

        field(10; "Difference"; Decimal)
        {
        }
        field(12; "Application Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin

                if "Application Date" > Today then
                    Error('Application date can not be in the future.');

            end;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
            trigger OnValidate()
            begin

            end;
        }

        field(15; "Captured By"; Code[50])
        {
            Editable = false;
        }
        field(16; "Responsibility Centre"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility Center";
            Editable = false;
        }
        field(30; posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(31; "Minimum Variated Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Sent Back to CRM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34; "Variation Action"; Option)
        {
            OptionMembers = "Feed/Recover",Stoppage,"Vary Rate Upwards","Vary Rate Downwards","Adjust Balance","Vary Rate & Adjust Balance";
            DataClassification = ToBeClassified;

        }

        field(800; "Member Status"; Enum "Member Status")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Status where("No." = Field("Member No.")));
        }
        field(801; "Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(802; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(803; "Employer Code"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Employer Code" where("No." = Field("Member No.")));
        }
        field(804; "Member ID No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification" where("No." = Field("Member No.")));
        }
        field(805; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(806; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(809; "Application Time"; DateTime)
        {

        }
        field(810; "Posting Date"; date)
        {

        }
        field(811; "Posting Time"; Time)
        {

        }
        field(90; "Recruited by Type"; enum "Recruited By")
        {

        }
        field(320; "Recruited By Name"; Text[100])
        {
            Editable = false;
        }
        field(730; "Recruited By"; Code[10])
        {
            Caption = 'Salesperson Code';

            TableRelation = IF ("Recruited by Type" = FILTER(Staff)) "HR Employees"."Member No."
            ELSE
            IF ("Recruited by Type" = CONST(Others)) Members."No." WHERE(Status = FILTER(<> Deceased & <> Closed), "Account Type" = filter("Single Member Account"))
            ELSE
            IF ("Recruited by Type" = CONST(spouse)) Members."No." WHERE(Status = FILTER(<> Deceased & <> Closed), "Account Type" = filter("Single Member Account"))
            else
            IF ("Recruited by Type" = CONST(parent)) Members."No." WHERE(Status = FILTER(<> Deceased & <> Closed), "Account Type" = filter("Single Member Account"))
            else
            IF ("Recruited by Type" = CONST(Delegates)) "Delegate Officials"."Member Number"
            else
            IF ("Recruited by Type" = CONST("Board Member")) "Delegate Officials"."Member Number"
            else
            IF ("Recruited by Type" = CONST("Sales Representative")) "HR Employees"."No." where("Staff Category" = const("Sales Representatives"));
            trigger OnValidate()
            var
                Members: Record Members;
                HREmployees: Record "HR Employees";
            begin
                if "Recruited by Type" <> "Recruited by Type"::Staff then begin
                    if Members.Get("Recruited By") then
                        "Recruited By Name" := Members.Name;
                end else begin
                    HREmployees.Reset;
                    HREmployees.SetRange("Member No.", "Recruited By");
                    if HREmployees.Find('-') then begin
                        "Recruited By Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name"
                    end;
                end;
            end;
        }
        field(731; Digit; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("User Tasks".Digit where("Record ID" = field("No.")));
        }

        field(360; "Employer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = FIELD("Employer Code")));
            editable = false;
        }
        field(361; Balance; Decimal)
        { }
        field(362; "Initial Repayment"; Decimal)
        {
        }
        field(1000; "Source Application"; Option)
        {
            OptionMembers = "BC",CRM,"Mwalimu Smart","Member Portal","Mobile Banking";
            Editable = false;
        }

    }


    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        SkySMS: CodeUnit SendSms;
        SMSSource: enum "SMS Source";
        Productva: Record "Product Variations";
        ProCo: Decimal;
        LoansRec: Record Loans;
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";

    trigger OnInsert()
    var
        theSMS: Text;
        theMember: Record Members;
    begin
        if rec."Variation Type" = Rec."Variation Type"::Loan then begin
            if "No." = '' then begin
                NoSetup.Get();
                NoSetup.TestField(NoSetup."Variations");
                "No." := NoSeriesMgt.GetNextNo(NoSetup."Variations");
                // NoSeriesMgt.InitSeries(NoSetup."Variations", NoSetup."Variations", 0D, "No.", "No. Series");
                // "No." := NoSeriesCU.GetNextNo(NoSetup."Variations");

            end;
        end;
        if "Variation Type" = Rec."Variation Type"::Savings then begin
            if "No." = '' then begin
                NoSetup.Get();
                NoSetup.TestField(NoSetup."Savings Variations");
                // NoSeriesMgt.InitSeries(NoSetup."Savings Variations", NoSetup."Savings Variations", 0D, "No.", "No. Series");
                // "No." := NoSeriesCU.GetNextNo(NoSetup."Savings Variations");
            end;
        end;
        "Application Date" := Today;
        "Application Time" := CurrentDateTime;

        "Captured By" := UpperCase(UserId);
        if Rec."Member No." <> '' then begin
            // if Rec."Variation Type" = Rec."Variation Type"::Loan then begin
            //     GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Loan Variations");
            // end;
            // if Rec."Variation Type" = Rec."Variation Type"::Savings then begin
            //     GlobalFunctions.AssignDigitCustodianTask(Rec."No.", Rec."Member No.", "Sub Module"::"Savings Variations");
            // end;
        end;

        if UserSetup.Get(UpperCase(UserId)) then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Centre" := UserSetup."Responsibility Centre";

        end;

        if Rec."Variation Type" = Rec."Variation Type"::Loan then begin
            LoansRec.Reset();
            LoansRec.SetRange(LoansRec."Member No.", Rec."Member No.");
            LoansRec.SetRange(LoansRec."Loan No.", LoansRec."Loan No.");
            LoansRec.SetFilter("Outstanding Balance", '>%1', 0);
            if LoansRec.FindFirst() then begin
                if Rec."Amount On" < LoansRec.Repayment then
                    Error('You cannot variate below the loan repayment amount');
            end;
        end;

        if "CRM Application No." <> '' then begin
            // CRM API
            // CRMIntegration.CRMVariationRequestUpdate(
            //     "CRM Application No.",
            //     Format(Status),
            //     ''
            // );
        end;

        // SMS to applicant
        theMember.Reset;
        theMember.SetRange("No.", Rec."Member No.");

        if theMember.FindFirst then begin
            case Rec."Variation Type" of
                Rec."Variation Type"::Loan:
                    theSMS := 'Dear member, your loan variation request has been received successfully and is being processed. REF ' + "No.";
                Rec."Variation Type"::Savings:
                    begin
                        if ProductFactory.get(rec."Product Type") then begin
                            theSMS := 'Dear member, your ' + ProductFactory."Product Description" + ' request has been received successfully and is being processed. REF ' + "No.";
                        end;
                    end;
            end;

            if theSMS <> '' then begin
                SkySMS.SendSms(
                    SMSSource::CRM,
                    theMember."Phone No.",
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

                // EMAIL 
                if Rec."Variation Type" = Rec."Variation Type"::Loan then begin
                    SkySendEmail.QueueOutgoingEmail(
                    theMember."E-Mail",
                    'Loan Variation',
                    theSMS,
                    'TEXT',
                    'LV APPLICATION',
                    'CRM'
                );
                end;
                if Rec."Variation Type" = Rec."Variation Type"::Savings then begin
                    SkySendEmail.QueueOutgoingEmail(
                    theMember."E-Mail",
                    'Deposit Variation',
                    theSMS,
                    'TEXT',
                    'DV APPLICATION',
                    'CRM'
                );
                end;
            end;
        end;
    end;

    trigger OnModify()
    var
        thisApp: Record "Product Variations";
        theSMS: Text;
        theMember: Record Members;
    begin
        if rec."No." = '' then begin
            if rec."Variation Type" = Rec."Variation Type"::Loan then begin
                if "No." = '' then begin
                    NoSetup.Get();
                    NoSetup.TestField(NoSetup."Variations");
                    "No." := NoSeriesMgt.GetNextNo(NoSetup."Variations");
                    // NoSeriesMgt.InitSeries(NoSetup."Variations", NoSetup."Variations", 0D, "No.", "No. Series");
                    // "No." := NoSeriesCU.GetNextNo(NoSetup."Variations");
                end;
            end;
            if "Variation Type" = Rec."Variation Type"::Savings then begin
                if "No." = '' then begin
                    NoSetup.Get();
                    NoSetup.TestField(NoSetup."Savings Variations");
                    "No." := NoSeriesMgt.GetNextNo(NoSetup."Savings Variations");
                    // NoSeriesMgt.InitSeries(NoSetup."Savings Variations", NoSetup."Savings Variations", 0D, "No.", "No. Series");
                    // "No." := NoSeriesCU.GetNextNo(NoSetup."Savings Variations");
                end;
            end;
        end;

        thisApp.Reset();

        thisApp.SetFilter("No.", "No.");

        if thisApp.FindFirst() then begin
            // Track Status changes
            if NOT (thisApp.Status = Status) then begin
                if "CRM Application No." <> '' then begin
                    // CRM API update
                    // CRMIntegration.CRMVariationRequestUpdate(
                    //     "CRM Application No.",
                    //     Format(Status),
                    //     ''
                    // );
                end;

                if Status = Status::Approved then begin
                    "Approved By" := UserId;
                    "Approval Date" := Today;
                end;

                // SMS to applicant
                // case Status of
                //     Status::Approved:
                //         begin
                //             case Rec."Variation Type" of
                //                 Rec."Variation Type"::Loan:
                //                     theSMS := 'Dear member, your loan variation request has been approved. REF ' + "No.";
                //                 Rec."Variation Type"::Savings:
                //                     theSMS := 'Dear member, your deposit variation request has been approved. REF ' + "No.";
                //             end;
                //         end;
                //     Status::Rejected:
                //         begin
                //             case Rec."Variation Type" of
                //                 Rec."Variation Type"::Loan:
                //                     theSMS := 'Dear member, your loan variation request has been rejected. REF ' + "No.";
                //                 Rec."Variation Type"::Savings:
                //                     theSMS := 'Dear member, your deposit variation request has been rejected. REF ' + "No.";
                //             end;
                //         end;
                // end;

                theMember.Reset;
                theMember.SetRange("No.", Rec."Member No.");

                if theMember.FindFirst then begin
                    if theSMS <> '' then begin
                        SkySMS.SendSms(
                            SMSSource::CRM,
                            theMember."Phone No.",
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

                        // EMAIL 
                        if Rec."Variation Type" = Rec."Variation Type"::Loan then begin
                            SkySendEmail.QueueOutgoingEmail(
                            theMember."E-Mail",
                            'Loan Variation',
                            theSMS,
                            'TEXT',
                            'LV APPLICATION',
                            'CRM'
                        );
                        end;
                        if Rec."Variation Type" = Rec."Variation Type"::Savings then begin
                            SkySendEmail.QueueOutgoingEmail(
                            theMember."E-Mail",
                            'Deposit Variation',
                            theSMS,
                            'TEXT',
                            'DV APPLICATION',
                            'CRM'
                        );
                        end;
                    end;
                end;
            end;
        end;

    end;

    var
        NoSetup: Record "Credit Nos. Series";
        SkySendEmail: Codeunit "Sky Send Email";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        members: Record Members;
        ProductFactory: Record "Product Factory";
        Loans: Record Loans;
        SavingsAccount: Record "Savings Accounts";
        SavLedEntries: Record "Savings Ledger Entry";
        CredLedEntries: Record "Credit Ledger Entry";
        prorata: Record "Member Prorata_Contractual Dep";
        Text01: Label 'New Amount must be more than old amount';
        CRMIntegration: Codeunit "CRM Integration";
        UserSetup: Record "User Setup";
        DepartMent: Enum "Responsibility Center Enum";
        NoSeriesCU: Codeunit "No. Series";


}

