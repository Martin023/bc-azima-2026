table 52185826 "Member withdrawal Notice"
{
    DrillDownPageID = "Open withdrawal Notice";
    LookupPageID = "Open withdrawal Notice";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members;

            trigger OnValidate()
            begin
                "Staff No." := '';
                Name := '';
                "Early Withdrawal" := false;
                "Amount To Refund" := 0;
                "Notice Type" := "Notice Type"::" ";
                "Closure Charges" := 0;
                "Loans Outstanding Balance" := 0;
                "Loans Outstanding Interest" := 0;
                "Member Deposit" := 0;
                "Total Assets" := 0;



                MemberwithdrawalNotice.Reset;
                MemberwithdrawalNotice.SetRange("Member No.", "Member No.");
                MemberwithdrawalNotice.setfilter("No.", '<>%1', rec."No.");
                MemberwithdrawalNotice.SetFilter(Status, '<>%1&<>%2', MemberwithdrawalNotice.Status::Rejected, MemberwithdrawalNotice.Status::Cancelled);
                //MemberwithdrawalNotice.SetRange("Notice Type", rec."Notice Type");
                MemberwithdrawalNotice.SetRange("Sent Back to CRM", false);
                if MemberwithdrawalNotice.Find('-') then begin

                    Membershipclosure.Reset;
                    //Membershipclosure.FilterGroup := -1;
                    Membershipclosure.SetRange("Member No.", MemberwithdrawalNotice."Member No.");
                    Membershipclosure.SetRange("Notice Number", MemberwithdrawalNotice."No.");
                    Membershipclosure.SetRange(Posted, true);
                    // Membershipclosure.Setrange(Status, Membershipclosure.Status::Cancelled);
                    if not Membershipclosure.Find('-') then begin
                        if (Membershipclosure.Status <> Membershipclosure.Status::Cancelled) or (Membershipclosure.Status <> Membershipclosure.Status::Rejected) then
                            Error('Member has an existing application- No.%1 that is yet to be completed', MemberwithdrawalNotice."No.");
                    end;
                end;

                if Members.Get("Member No.") then begin
                    if Members.Subflag = Members.Subflag::Defaulter then
                        Message('Error: This member is a defaulter');

                    Name := Members.Name;
                    "Staff No." := Members."Payroll/Staff No.";
                    "Global Dimension 1 Code" := Members."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Members."Global Dimension 2 Code";

                    //  if Members.Subflag = Members.Subflag::Defaulter then Error('Member status is %1. Kindly clear your liabilities.', Members.Subflag);
                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
                    if SavingsAccounts.Find('-') then begin
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        MemberDeposit := SavingsAccounts."Balance (LCY)";
                        //"Member Deposit":=SavingsAccounts."Balance (LCY)";
                    end else
                        MemberDeposit := 0;

                    Validate("Member Deposit", MemberDeposit);
                    //Validate("Amount Refundable", MemberDeposit);
                    //"Member Deposit":=0;
                    if MemberDeposit <= 0 then Message('Member has no Deposit');

                    /*Loans.RESET;
                    Loans.SETRANGE("Member No.","Member No.");
                    Loans.SETFILTER("Outstanding Balance",'>0');
                    IF Loans.FIND('-') THEN BEGIN
                      REPEAT
                        Loans.CALCFIELDS("Outstanding Balance","Outstanding Interest");
                        "Loans Outstanding Balance"+=Loans."Outstanding Balance";
                        "Loans Outstanding Interest"+=Loans."Outstanding Interest";
                        UNTIL Loans.NEXT=0;
                      END;*/
                    //  Loans.CalcFields("Total Loan Balance");

                    Loans.Reset;
                    Loans.SetRange("Member No.", "Member No.");
                    Loans.SetRange(Posted, true);
                    Loans.SetFilter("Total Loan Balance", '>0');
                    Loans.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    if Loans.Find('-') then begin
                        repeat
                            OutstandingBalance += Loans."Outstanding Balance";
                            OutstandingInterest += (Loans."Outstanding Interest" + Loans."Daily Interest");
                        until Loans.Next = 0;
                    end;

                    Validate("Loans Outstanding Balance", OutstandingBalance);
                    Validate("Loans Outstanding Interest", OutstandingInterest);

                    LoanGuar.Reset;
                    LoanGuar.SetRange("Member No", "Member No.");
                    LoanGuar.SetRange(Substituted, false);
                    LoanGuar.SetRange("Self Guarantee", false);
                    if LoanGuar.Find('-') then begin
                        repeat
                            if Loans.Get(LoanGuar."Loan No") then begin
                                if Members.Get(Loans."Member No.") then begin
                                    if Members.Status <> Members.Status::Deceased then begin
                                        Loans.CalcFields("Outstanding Balance");
                                        if Loans."Member No." <> "Member No." then begin
                                            if Loans."Outstanding Balance" > 0 then begin
                                                Error(Err001, Loans."Loan No.");
                                                NoLoanGua := NoLoanGua + '-' + Format(Loans."Loan No.");
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until LoanGuar.Next = 0;
                    end;

                    /*IF LoanGuar.COUNT>1 THEN
                      ERROR(Err003)*/

                    // IF NoLoanGua<>'' THEN BEGIN
                    //  Remarks:='Member has guranteed'+NoLoanGua;
                    //  "Member No." := '';
                    //  MODIFY;
                    //  COMMIT;
                    //  ERROR(Remarks);
                    // END;

                end;


                //IF ("Loans Outstanding Balance"+"Loans Outstanding Interest")>"Member Deposit" THEN ERROR(
                if (OutstandingBalance + OutstandingInterest) > MemberDeposit then
                    Error('Total Loans of %1 exceeds the member deposits of %2', (OutstandingBalance + OutstandingInterest), MemberDeposit);
            end;
        }
        field(3; "Reason for withdrawal"; Text[250])
        {
            TableRelation = "Withdrawal Reason".Description;
        }
        field(4; "Withdrawal Notice Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Withdrawal Notice Date" <> Today then begin
                    Error(ErrMsg);
                    //Rec."Withdrawal Notice Date" := Today;
                end;
                if rec."Notice Type" = rec."Notice Type"::"Withdrawal - Normal" then begin
                    GeneralSetUp.Get;
                    GeneralSetUp.TestField(GeneralSetUp."Withdrawal Notice period");
                    "Maturity Date" := CalcDate(Format(GeneralSetUp."Withdrawal Notice period"), "Withdrawal Notice Date");
                    rec.Validate("No. of Days Remaining");
                end
                else begin
                    "Maturity Date" := rec."Withdrawal Notice Date";
                    rec.Validate("No. of Days Remaining");
                    //rec.Modify;
                end;
            end;
        }
        field(5; "Maturity Date"; Date)
        {

        }
        field(6; "Entered By"; Code[50])
        {
        }
        field(7; "Date Entered"; Date)
        {
            Editable = true;
        }
        field(8; "Time Entered"; Time)
        {
        }
        field(9; Status; Enum "Workflow Status Main Flags")
        {
            trigger OnValidate()
            var
                Comments: record comments;
            begin
                if (Rec.Status = Status::Cancelled) then begin
                    Comments.Reset();
                    Comments.SetRange("Commented By", UserId);
                    Comments.SetRange("Viewd By Somebody Else", false);
                    Comments.SetRange("Header No.", "No.");
                    if not Comments.FindFirst() then
                        Error('Please add a comment before performing this action');
                end;
            end;
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; Name; Text[50])
        {
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(14; "Loans Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(15; "Loans Outstanding Interest"; Decimal)
        {
            Editable = false;
        }
        field(16; "Member Deposit"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            var
                MembershipClosure: Record "Membership Closure";
            begin
                MembershipClosure.Reset();
                MembershipClosure.SetRange("Member No.", Rec."Member No.");
                MembershipClosure.SetRange(Posted, true);
                MembershipClosure.SetRange("Closure Type", MembershipClosure."Closure Type"::"Withdrawal - 1st Partial");
                if MembershipClosure.FindFirst then begin
                    "Deposit At First Withdrwal" := "Member Deposit";
                end;
                if rec."Notice Type" = rec."Notice Type"::"Withdrawal - 1st Partial" then begin
                    rec."Deposit At First Withdrwal" := "Member Deposit";
                end;
            end;

        }
        field(17; "Notice Type"; Option)
        {
            OptionMembers = " ","Withdrawal - Normal","Withdrawal - 1st Partial","Withdrawal - 2nd Partial";
            OptionCaption = ' ,Full-Withdrawal,Withdrawal - 1st Partial,Withdrawal - 2nd Partial';

            trigger OnValidate()
            var
                MembershipClosure: Record "Membership Closure";
                PostedFirstPartialRequired: Label 'A posted 1st partial withdrawal has be present for a 2nd partial withdrawal to be initiated';
                Members: Record members;
                Customers: record Customer;
                Gensetup: record "General Set-Up";
                withdrawalNot: record "Member withdrawal Notice";
            begin
                Gensetup.Get();
                Gensetup.TestField("Max 1st Partial Withdrawal %");

                // rec.Validate("Amount To Refund");
                rec.validate("Withdrawal Notice Date", Today);
                if ("Notice Type" = "Notice Type"::"Withdrawal - 1st Partial") then begin

                    // if Percentage > GenSetup."Max 1st Partial Withdrawal %" then
                    //     Error(ErrRefunds, GenSetup."Max 1st Partial Withdrawal %");
                    rec."Amount Refundable" :=
                                 (GenSetup."Max 1st Partial Withdrawal %" / 100) *
                                 ((rec."Total Assets") - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));
                end
                else
                    if ("Notice Type" = "Notice Type"::"Withdrawal - 2nd Partial") then begin
                        MembershipClosure.Reset();
                        MembershipClosure.SetRange("Member No.", Rec."Member No.");
                        MembershipClosure.SetRange(Posted, true);
                        MembershipClosure.SetRange("Closure Type", MembershipClosure."Closure Type"::"Withdrawal - 1st Partial");
                        if MembershipClosure.IsEmpty then
                            Error(PostedFirstPartialRequired);

                        withdrawalNot.reset;
                        withdrawalNot.SetRange("Member No.", rec."Member No.");
                        withdrawalNot.SetRange("Notice Type", "Notice Type"::"Withdrawal - 1st Partial");
                        if withdrawalNot.FindFirst() then begin
                            MembershipClosure.Reset();
                            MembershipClosure.SetRange("Member No.", withdrawalNot."Member No.");
                            MembershipClosure.SetRange(Posted, true);
                            MembershipClosure.setrange("Notice Number", withdrawalNot."No.");
                            if MembershipClosure.FindFirst() then begin
                                rec."Deposit At First Withdrwal" := withdrawalNot."Total Assets";
                                rec.CalcFields("Total Partial Withdrawn Amount");
                                rec."Amount Refundable" := withdrawalNot."Amount Refundable" - "Total Partial Withdrawn Amount";
                                //rec."Amount Refundable":= 
                            end
                            else
                                rec."Amount Refundable" :=
                                    (GenSetup."Max 1st Partial Withdrawal %" / 100) *
                                    ((rec."Total Assets") - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));
                        end;

                    end
                    else begin
                        rec."Amount Refundable" :=

                                       ((rec."Total Assets") - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));
                        //rec."Amount To Refund" := rec."Amount Refundable";

                        if rec."Early Withdrawal" then
                            rec."Amount To Refund" := rec."Amount Refundable" - rec."Closure Charges"
                        else
                            rec."Amount To Refund" := "Amount Refundable";
                    end;

                // Add retiree to only have the closure type of Partial withdrawal
                if ("Notice Type" = "Notice Type"::"Withdrawal - 2nd Partial") or (Rec."Notice Type" = "Notice Type"::"Withdrawal - 1st Partial") then begin
                    rec.validate("Early Withdrawal", false);

                    // if rec."Amount Refundable" <> 0 then
                    //     rec."Amount Refundable" := 0;
                    rec."Amount To Refund" := 0;

                    if Members.Get(Rec."Member No.") then begin
                        if Members."Employer Code" <> '' then begin
                            if Customers.get(Members."Employer Code") then
                                if not Customers."Retiree Employer" then
                                    Error('Only retirees are allowed to do partial withdrawals');
                        end
                        else
                            Error('Member Employer must be present');
                    end
                    else
                        Error('Member does not exist');
                end
                else begin
                    rec.Validate(Percentage, 100);
                    rec.Validate("Early Withdrawal", false);
                    rec.validate("Amount To Refund", rec."Total Assets" - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));
                    rec."Closure Charges" := 0;
                end;
                if rec."Notice Type" = rec."Notice Type"::" "
                then begin
                    rec."Amount To Refund" := 0;
                    rec.validate("Amount Refundable", rec."Total Assets" - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));
                    rec."Closure Charges" := 0
                end;
            end;
        }
        field(18; Remarks; Text[250])
        {
        }
        field(19; "Date Modified"; Date)
        {
        }
        field(20; "Rejection Remarks"; Text[250])
        {
        }
        field(21; "Staff No."; Code[15])
        {
            Editable = false;
        }
        field(22; "Early Withdrawal"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Early Withdrawal" then begin
                    rec.validate("Maturity Date", "Withdrawal Notice Date");
                    Rec.modify;
                    UpdateClosureCharges();
                    rec.Validate(percentage);
                end
                else begin
                    rec.validate("Withdrawal Notice Date");
                    rec."Closure Charges" := 0;
                end;

            end;
        }

        field(23; "CRM Application No."; Text[50])
        {
            Editable = false;
        }
        field(123; "CRM No. Series"; Code[10])
        {

        }

        field(24; "CRM Created By"; Code[100])
        {
            Editable = false;
        }

        field(25; "CRM Originating Branch"; Code[50])
        {
            Editable = false;
        }

        field(26; "CRM Notes"; text[1000])
        {
            Editable = false;
        }

        field(27; "Notice Finalized"; Boolean)
        {
            Editable = false;
        }
        field(28; "DateTime Finalized"; DateTime)
        {
            Editable = false;
        }
        field(29; "Finalized By"; Code[50])
        {
            Editable = false;
        }
        field(30; "Sent Back to CRM"; Boolean)
        {
            Editable = False;
        }
        field(31; "Percentage"; Decimal)
        {
            // Editable = False;
            // trigger OnValidate()
            // begin
            //     //     if "Notice Type" = "Notice Type"::"Withdrawal - Normal" then begin
            //     //         Percentage := 100.00;
            //     //     end;


            // end;


            trigger OnValidate()
            var
                ErrRefunds: Label 'The maximum % of refunds cannot exceed %1';
                ErrApplicationType: Label 'This option is only applicable to partial Withdrawal!';
                IsPartialWithDrawal: Boolean;
                GenSetup: Record "General Set-Up";
                withdrawalNot: Record "Member withdrawal Notice";
                memClosure: record "Membership Closure";
            begin

                IsPartialWithDrawal := ("Notice Type" = "Notice Type"::"Withdrawal - 1st Partial")
                        or ("Notice Type" = "Notice Type"::"Withdrawal - 2nd Partial");
                // GenSetup.Get();
                // GenSetup.TestField("Max 1st Partial Withdrawal %");

                // if ("Notice Type" = "Notice Type"::"Withdrawal - 1st Partial") then begin

                //     // if Percentage > GenSetup."Max 1st Partial Withdrawal %" then
                //     //     Error(ErrRefunds, GenSetup."Max 1st Partial Withdrawal %");
                //     rec."Amount Refundable" :=
                //                  (GenSetup."Max 1st Partial Withdrawal %" / 100) *
                //                  ((rec."Total Assets") - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));
                // end
                // else
                //     if ("Notice Type" = "Notice Type"::"Withdrawal - 2nd Partial") then begin
                //         withdrawalNot.reset;
                //         withdrawalNot.SetRange("Member No.", rec."Member No.");
                //         withdrawalNot.SetRange("Notice Type", "Notice Type"::"Withdrawal - 1st Partial");
                //         memClosure.Reset();
                //         memClosure.SetRange("Member No.", rec."Member No.");
                //         memClosure.SetRange(Posted, true);
                //         memClosure.setrange("Notice Number", rec."No.");
                //         if memClosure.FindFirst() then begin
                //             if memClosure."Member Savings" <> 0 then begin
                //                 withdrawalNot.CalcFields("Total Partial Withdrawn Amount");
                //                 rec."Amount Refundable" := memClosure."Member Savings" - withdrawalNot."Total Partial Withdrawn Amount";
                //             end;
                //         end
                //         else
                //             rec."Amount Refundable" :=
                //                 (GenSetup."Max 1st Partial Withdrawal %" / 100) *
                //                 ((rec."Total Assets") - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));

                //     end
                //     else begin
                //         rec."Amount Refundable" :=
                //                        (rec.Percentage / 100) *
                //                        ((rec."Total Assets") - ("Loans Outstanding Balance" + "Loans Outstanding Interest"));

                //         if rec."Early Withdrawal" then
                //             rec."Amount To Refund" := rec."Amount Refundable" - rec."Closure Charges"
                //         else
                //             rec."Amount To Refund" := "Amount Refundable";
                //     end;
                // if (rec.Percentage < 0) OR (rec.Percentage > 100) then begin
                //     Error('Partial withdrawal percentage value must be between 0 and 100');
                // end;


            end;
        }
        field(32; "Employer Liability"; Decimal)
        {
            Caption = 'Other Liability';
        }
        field(800; "Member Status"; Enum "Member Status")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Status where("No." = Field("Member No.")));
        }
        field(801; "Delegate Zone"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Electrol Zone Descr." where("No." = Field("Member No.")));
        }
        field(802; Employer; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Employer Code" where("No." = Field("Member No.")));
        }
        field(803; "No. of Days Remaining"; Integer)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "No. of Days Remaining" := "Maturity Date" - Today;
            end;
        }
        field(804; "ID No."; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification" where("No." = Field("Member No.")));
        }

        field(900; "Total Assets"; Decimal)
        {
            Editable = False;
        }
        field(901; "withdrawal time"; time)
        {
            editable = false;
        }
        field(902; "maturity time"; time)
        {
            editable = false;
        }
        field(903; SLA; Duration)
        {
            editable = false;
        }
        field(904; "Clossure Created"; Boolean)
        {
            Editable = false;
        }

        field(1000; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(1001; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        // field(82; Digit; Integer)
        // {
        //     FieldClass = FlowField;
        //     Editable = false;
        //     CalcFormula = lookup("User Tasks".Digit where("Record ID" = field("No.")));
        // }
        field(310; "Closure Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(1003; "Amount Refundable"; Decimal)
        {
            Editable = false;
            Caption = 'Maximum Refundable';
        }
        field(1004; "Amount To Refund"; Decimal)
        {
            //Editable = false;
            trigger OnValidate()
            begin
                if "Amount To Refund" > "Amount Refundable" then begin
                    Error('Amount to refund cannot be greater than the maximum refundable amount of %1', "Amount Refundable");
                end;
                if "Amount To Refund" < 0 then begin
                    Error('Amount to refund cannot be less than 0');
                end;

                if "Amount To Refund" > 0 then
                    //rec.Percentage := ;
                rec.Percentage := ("Amount To Refund" / (("Total Assets" - ("Loans Outstanding Balance" + "Loans Outstanding Interest")))) * 100;
                //rec.Modify()

                if (rec."Notice Type" = rec."Notice Type"::"Withdrawal - 2nd Partial") then begin
                    if GeneralSetUp.get() then
                        if GeneralSetUp."Max 1st Partial Withdrawal %" <> 0 then begin
                            rec.CalcFields("Total Partial Withdrawn Amount");
                            if "Deposit At First Withdrwal" <> 0 then
                                if (("Amount To Refund" + "Total Partial Withdrawn Amount") / "Deposit At First Withdrwal") > GeneralSetUp."Max 1st Partial Withdrawal %" then
                                    Error('The maximum % of refunds cannot exceed %1', GeneralSetUp."Max 1st Partial Withdrawal %");
                        end;
                end;
            end;
        }
        field(1005; "Deposit At First Withdrwal"; Decimal)
        {
            Editable = false;
        }
        field(1006; "Total Partial Withdrawn Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Membership Closure"."Partial Deposit Refundable" where("Member No." = field("Member No."), posted = const(true)));
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
        fieldgroup(DropDown; "No.", "Member No.", Name, "Notice Type", "Maturity Date") { }
    }

    trigger OnDelete()
    begin
        if Status = Status::Approved then
            Error(Txt00001);
    end;

    trigger OnInsert()
    var
        theSMS: Text;
        theMember: Record Members;
        GFunc: Codeunit "Global Functions";
        SubModule: Enum "Sub Module";

        DepartMent: Enum "Responsibility Center Enum";

        theApps: record "Member withdrawal Notice";
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Withdrawal Notice");
            if NoSeriesMgt.AreRelated(NoSetup."Withdrawal Notice", xRec."No. Series") then
                "No. Series" := xRec."No. Series" else
                "No. Series" := NoSetup."Withdrawal Notice";
            Rec."No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate);
        end;

        // Validation
        theApps.Reset;
        theApps.SetRange("Notice Type", Rec."Notice Type");
        theApps.SetRange("Member No.", Rec."Member No.");
        theApps.Setfilter(Status, '<>%1&<>%2&<>%3', Status::Rejected, Status::Cancelled, Status::Approved);
        if theApps.FindFirst then begin
            Error(
                'Member already has a member withdrawal application %1 of type %2 at status %3',
                 theApps."No.",
                 theApps."Notice Type",
                 theApps.Status
            );
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        "Date Modified" := Today;
        "withdrawal time" := Time;

        // SMS to applicant
        theMember.Reset;
        theMember.SetRange("No.", Rec."Member No.");

        // if theMember.FindFirst then begin
        //     theSMS := 'Dear member, your withdrawal request has been received successfully and is being processed. REF ' + "No.";

        //     SkySMS.SendSms(
        //         SMSSource::MEMBER_CHANGES,
        //         theMember."Phone No.",
        //         theSMS,
        //         CreateGuid(),
        //         '',
        //         false,
        //         0,
        //         false,
        //         'CBS',
        //         "No.",
        //         'CBS'
        //     );

        // EMAIL 
        // SkySendEmail.QueueOutgoingEmail(
        //     theMember."E-Mail",
        //     'Member Withdrawal Application',
        //     theSMS,
        //     'TEXT',
        //     'WITHDRAWAL APPLICATION',
        //     'CRM'
        // );

        // Assignment of users
        // if (Rec."Global Dimension 2 Code" = 'BOSA') or (Rec."Global Dimension 2 Code" = 'FINANCE') then begin
        //     // AssignDigitCustodianTask assignment
        //     GFunc.AssignDigitCustodianTask(Rec."No.", theMember."No.", SubModule::"Member Closure");
        // end else begin
        //     GFunc.AssignUserTasks(DepartMent::BOSA, SubModule::"Member Closure", Rec."No.");
        // end;
        // end;

        UpdateNetAmounts(Rec);
    end;

    trigger OnModify()
    var
        thisApp: Record "Member withdrawal Notice";
        theSMS: Text;
        theMember: Record Members;
    begin
        "Date Modified" := Today;

        thisApp.Reset();
        thisApp.SetFilter("No.", "No.");

        if thisApp.FindFirst then begin
            if not (thisApp.Status = Status) then begin
                // SMS to applicant
                case Status of
                    Status::Approved:
                        begin
                            theSMS := 'Dear member, your withdrawal request has been approved. REF ' + "No.";
                        end;
                    Status::Rejected:
                        begin
                            //theSMS := 'Dear member, your withdrawal request has been rejected. REF ' + "No.";
                        end;
                end;

                if Status = Status::Approved then begin
                    "Finalized By" := UserId;
                    "DateTime Finalized" := CurrentDateTime;
                    "maturity time" := Time;
                end;

                // theMember.Reset;
                // theMember.SetRange("No.", Rec."Member No.");

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

                        //         // EMAIL 
                        //         SkySendEmail.QueueOutgoingEmail(
                        //             theMember."E-Mail",
                        //             'Member Withdrawal Application',
                        //             theSMS,
                        //             'TEXT',
                        //             'WITHDRAWAL APPLICATION',
                        //             'CRM'
                        //         );
                    end;
                end;
            end;
        end;

        UpdateNetAmounts(Rec);
    end;

    procedure UpdateNetAmounts(var theRec: Record "Member withdrawal Notice")
    var
        TotalAssets: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        ProdFac: record "Product Factory";
    begin
        SavingsAccounts.Reset;
        SavingsAccounts.SetRange("Member No.", theRec."Member No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");

        if SavingsAccounts.FindSet then begin
            repeat begin
                if ProdFac.get(SavingsAccounts."Product Type") then begin
                    if not ProdFac."Exclude From Closure" then begin
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        TotalAssets += SavingsAccounts."Balance (LCY)";
                    end;
                end;
            end until SavingsAccounts.Next = 0;
        end;

        theRec."Total Assets" := TotalAssets;
    end;

    var
        SkySMS: CodeUnit SendSms;
        SkySendEmail: Codeunit "Sky Send Email";
        SMSSource: enum "SMS Source";
        NoSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Members: Record Members;
        GeneralSetUp: Record "General Set-Up";
        Txt00001: Label 'You cannot delete approved record';
        ErrMsg: Label 'You cannot base Withdrawa Noticel Date in the past of future';
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        LoanGuar: Record "Loan Guarantors and Security";
        Err001: Label 'This member has guranteed loan %1';
        Err002: Label 'Outstanding Balance is greater than members deposits';
        UserSetup: Record "User Setup";
        Err003: Label 'This member has guranteed loan';
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
        NoLoanGua: Text;
        NextofKIN: Record "Next of KIN";
        Err0006: Label 'Member does not have next of kin details';
        OutstandingBalance: Decimal;
        OutstandingInterest: Decimal;
        MemberDeposit: Decimal;
        Membershipclosure: Record "Membership closure";

    procedure UpdateClosureCharges(): Decimal;
    var
        GeneralSetUp: Record "General Set-Up";
        TransactionCharge: Decimal;
    begin
        GeneralSetUp.Get();
        "Closure Charges" := 0;
        // if "Closure Type" <> "Closure Type"::" " then
        //     "Closure Charges" := GeneralSetUp."Withdrawal Fee" + (GeneralSetUp."Withdrawal Fee" * 0.01 * GeneralSetUp."Excise Duty (%)");

        if rec."Early Withdrawal" then begin
            GeneralSetUp.TestField(GeneralSetUp."Early Withdrawal Fee");
            TransactionCharge := GetTransactionCharge(GeneralSetUp."Early Withdrawal Fee", "Amount Refundable");

            "Closure Charges" := TransactionCharge;
            //+ (TransactionCharge * GeneralSetUp."Excise Duty (%)" * 0.01);
            //rec.MODIFY;
            "Amount To Refund" := "Amount Refundable" - "Closure Charges";
        end;

    end;

    procedure GetTransactionCharge(TransactionCode: Code[20]; TotalAmount: Decimal): Decimal
    var
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        GenSetup: Record "General Set-Up";
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
    begin

        GenSetup.Get();

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionCode);
        if TransactionCharges.Find('-') then begin
            repeat

                ChargeAmount := 0;
                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::Normal) or
                (TransactionCharges."Transaction Charge Category" = TransactionCharges."Transaction Charge Category"::"Stamp Duty") then begin

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = true then
                        ChargeAmount := (TotalAmount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if (TotalAmount >= TariffDetails."Lower Limit") and (TotalAmount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := TotalAmount * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;


                    TChargeAmount := TChargeAmount + ChargeAmount;

                    if TransactionCharges."Recover Excise Duty" then
                        TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;

                    /*if TransactionCharges."Transaction Charge Category" <> TransactionCharges."Transaction Charge Category"::"Stamp Duty" then begin

                         TChargeAmount := TChargeAmount + (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;

                     end;*/
                end;
            until TransactionCharges.Next = 0;
        end;
        exit(TChargeAmount);
    end;

    [Scope('OnPrem')]
    procedure StopAdvice(MemberwithdrawalNotice: Record "Member withdrawal Notice")
    var
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        PeriodicAcc: Codeunit "Periodic Activities";
        LoansProcess: Codeunit "Loans Process";
    begin
        Loans.Reset;
        Loans.SetRange("Member No.", "Member No.");
        Loans.SetRange("Recovery Mode", Loans."Recovery Mode"::Checkoff);
        Loans.SetFilter("Outstanding Balance", '>0');
        if Loans.Find('-') then begin
            repeat
                LoansProcess.AdviceLoan(Loans."Loan No.", true, Rec."No.");
            until Loans.Next = 0;
        end;

        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."Member No.", "Member No.");
        if SavingsAccounts.Find('-') then begin
            repeat
                if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"BOSA Deposits" then begin
                    // PeriodicAcc.StopEmplyerSavingAdvice(SavingsAccounts, SavingsAccounts."Monthly Contribution", SavingsAccounts."Employer Balance");
                end else
                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Benevolent (BBF)" then begin
                        // PeriodicAcc.StopEmplyerSavingAdvice(SavingsAccounts, SavingsAccounts."Monthly Contribution", SavingsAccounts."Employer Balance");
                    end;
                if SavingsAccounts."Product Category" <> SavingsAccounts."Product Category"::"Share Capital" then begin
                    if SavingsAccounts."Loan Disbursement Account" = false then begin
                        SavingsAccounts.Status := SavingsAccounts.Status::Closed;
                        SavingsAccounts.Blocked := SavingsAccounts.Blocked::All;
                        ///  SavingsAccounts.MODIFY;
                    end;
                end;
            until SavingsAccounts.Next = 0;
        end;
    end;
}
