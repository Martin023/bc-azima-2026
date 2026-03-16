table 52187023 "DMU Case Forwarding Lines"
{
    Caption = 'DMU Case Forwarding Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Description = 'Entry no. as integer because each case will be tracked diffrently';
            AutoIncrement = true;
        }
        field(2; "Header No."; Code[30])
        {
            Editable = false;
        }
        field(3; "Loan Number"; Code[50])
        {
            Editable = true;
            TableRelation = Loans."Loan No.";
            trigger OnValidate()
            var
                Loans: Record Loans;
                CFLines: Record "DMU Case Forwarding Lines";
                LoansProcess: Codeunit "Loans Process";
                RunLoan: Boolean;
            begin
                CFLines.Reset();
                CFLines.SetRange("Header No.", Rec."Header No.");
                CFLines.SetFilter("Entry No", '<>%1', Rec."Entry No");
                CFLines.SetRange("Loan Number", "Loan Number");
                if CFLines.FindFirst() then
                    Error('This loan already exists on the lines');

                if Loans.Get("Loan Number") then begin
                    // "Amount In Arreas" := LoansProcess.CalculateAmountInArrears(Loans, Today, RunLoan);
                    LoansProcess.CalculateLoanArrears(Loans,"Amount In Arreas",Loans."Amount In Arreas SASRA",Today,True);
                    "Member Number" := Loans."Member No.";
                    Validate("Member Number");
                    "Unique Identifier" := Format("Entry No") + "Header No.";
                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Installments FallOff", "Days In Arrears", "Loans Category-SASRA");
                    "Principle Balance" := Loans."Outstanding Balance";
                    "Interest Balance" := Loans."Outstanding Interest";
                    "Total Balance" := "Principle Balance" + "Interest Balance";
                    "Days In Arrears" := Loans."Days In Arrears";
                    "Installments FallOff" := Loans."Installments FallOff";
                    "Loans Category-SASRA" := Loans."Loans Category-SASRA";

                    if CFHeader.Get("Header No.") then begin
                        if CFHeader."Case Intructions" = CFHeader."Case Intructions"::Reversals then begin
                            if Loans."Outstanding Balance" <> 0 then Error('This case %1 is not valid for reversal, since it does not have 0 balance', "Loan Number");
                        end;
                    end;
                end;


            end;
        }
        field(4; "Member Number"; Code[30])
        {
            Editable = true;
            TableRelation = Members."No.";
            trigger OnValidate()
            var
            begin
                CalcFields("Member Name");
            end;
        }

        field(5; "Principle Balance"; Decimal)
        {
            Editable = false;
        }
        field(6; "Interest Balance"; Decimal)
        {
            Editable = false;
        }
        field(7; "Member Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member Number")));
        }
        field(8; "Total Balance"; Decimal)
        {
            Editable = true;
        }
        field(9; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("Unique Identifier")));
        }
        field(10; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("Unique Identifier")));
        }
        field(11; "Unique Identifier"; Code[50])
        {
            Editable = false;
        }
        field(12; Closed; Boolean)
        {
            Editable = false;
        }
        field(13; "Viewed By Recepient"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("CF Tracker"."Viewed By Recepient" where("Header No." = field("Header No."), "Current Department" = const(true)));
        }
        field(14; "Days In Arrears"; Decimal)
        {
            Editable = false;
        }
        field(15; "Installments FallOff"; Integer)
        {
            Editable = false;
        }
        field(16; "Loans Category-SASRA"; Enum "Loan Sasra categories")
        {
            Editable = false;
        }

        field(18; Period; date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields("Period Name");
            end;
        }
        field(19; "Period Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Interest Due Period".Name where("Interest Due Date" = field(Period)));
        }
        field(17; "System Generated"; Boolean)
        {
            Editable = false;
        }
        field(20; "Ignore This Loan"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if UserSetup.Get(UserId) then begin
                    UserSetup.TestField("Responsibility Centre");
                    CurrentUsersDept := UserSetUp."Responsibility Centre";

                    CalcFields("Viewed By Recepient");
                    if CFHeader.Get("Header No.") then begin
                        if CFHeader."Case Intructions" = CFHeader."Case Intructions"::"Fall Off" then begin
                            if (CurrentUsersDept <> CFHeader."Originating Department") then
                                if "Viewed By Recepient" then Error('You can not edit this entry becasue it has already been viwed by the receipient');
                            if CFHeader."Originating Status" <> CFHeader."Originating Status"::Returned then
                                if "Viewed By Recepient" then Error('You can not edit this entry becasue it has already been viwed by the receipient');
                        end;
                        if CFHeader."Case Intructions" = CFHeader."Case Intructions"::Reversals then begin
                            if (CurrentUsersDept = CFHeader."Originating Department") and (CFHeader."Originating Status" <> CFHeader."Originating Status"::Returned) then
                                if "Viewed By Recepient" then Error('You can not edit this entry becasue it has already been viwed by the receipient');

                        end;
                    end;
                end else
                    Error('You must be set up in user setup');
            end;
        }
        field(21; "Amount In Arreas"; Decimal)
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No", "Header No.", "Unique Identifier")
        {
            Clustered = true;
        }

    }

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if "System Generated" then Error('You can not delete this entry becasue its system generated');
        CalcFields("Viewed By Recepient");

        CFHeader.Get("Header No.");
        if ("Viewed By Recepient") and (CFHeader."Originating Status" <> CFHeader."Originating Status"::Returned) then
            Error('You can not delete this entry becasue it has already been viwed by the receipient');

    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin

    end;

    procedure ValidateCaseLineActions(LoanNumber: Code[50]; Action: Option " ",Attachment,Reappotionment,Reversal,Notice)
    var
        Loans: Record Loans;
        RecoveryHeader: Record "Loan Recovery Header";
    begin
        if Action = Action::Attachment then begin

            if Loans.Get(LoanNumber) then begin
                if Loans."Recovered Loan" <> '' then begin
                    Error('This is a defaulter loan LNo. %1, the action %2 is not applicable.', LoanNumber, Action);
                end;
            end;

        end;
        if Action = Action::Reappotionment then begin

            if Loans.Get(LoanNumber) then begin
                if Loans."Recovered Loan" <> '' then begin
                    Error('This is a defaulter loan LNo. %1, the action %2 is not applicable.', LoanNumber, Action);

                end;
            end;

            RecoveryHeader.Reset();
            RecoveryHeader.SetRange("Loan No.", LoanNumber);
            RecoveryHeader.SetRange("Header Reversed", false);
            RecoveryHeader.SetRange(Action, RecoveryHeader.Action::Recovered);
            if not RecoveryHeader.FindFirst() then
                Error('There is no recovery header associated with this loan LNo. %1', LoanNumber);

        end;

    end;

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        Text001: Label 'You cannot use system table %1 in the package.';
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SystemEditsCodeunit: Codeunit "System Editss";
        CreditNoSeries: Record "Credit Nos. Series";
        CFHeader: Record "DMU Case Forwarding";
        UserSetup: Record "User Setup";
        CurrentUsersDept: Code[50];
}
