table 52186031 "Lease Line Invoices"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
        }
        field(2; "Lease No."; Code[20])
        {
            TableRelation = Lease."No.";
        }
        field(3; "Charge No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Charges.Code;

            trigger OnValidate()
            begin
                /*
                Charge.RESET;
                Charge.SETRANGE(Charge.Code,"Charge No.");
                IF Charge.FIND('-') THEN BEGIN
                "Charge Name":=Charge.Name;
                "Transaction Code":=Charge.Code;
                "Charge Once":=Charge."Charge Once";
                "IsService Charge":=Charge."IsService Charge";
                END
                */

            end;
        }
        field(4; "Charge Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Charge Once"; Boolean)
        {
        }
        field(7; Review; Boolean)
        {
        }
        field(8; "Review Start Date"; Date)
        {

            trigger OnValidate()
            begin
                /*  Lease.RESET;
                  Lease.SETRANGE(Lease."No.","Lease No.");
                  IF Lease.FIND('-')THEN
                  IF "Review Start Date">=Lease."Expiry Date" THEN
                   ERROR('The Review Start Date is Beyond the Lease Expiry Date');


                  Lease.RESET;
                  Lease.SETRANGE(Lease."No.","Lease No.");
                  IF Lease.FIND('-')THEN
                   IF Review=TRUE THEN
                   "Review End Date":=Lease."Expiry Date";
                */

            end;
        }
        field(9; "Review Frequency"; Option)
        {
            OptionCaption = 'Days,Weeks,Months,Quarters,Years';
            OptionMembers = Days,Weeks,Months,Quarters,Years;
        }
        field(10; "Review Frequency Value"; Integer)
        {
        }
        field(11; "Review End Date"; Date)
        {
        }
        field(12; "Review Rate"; Decimal)
        {
        }
        field(14; "Net Amount"; Decimal)
        {
        }
        field(15; GLAccount; Code[20])
        {
        }
        field(19; "Area Square ft"; Decimal)
        {
            CalcFormula = Lookup(Lease."Area square ft" WHERE("No." = FIELD("Lease No.")));
            FieldClass = FlowField;
        }
        field(20; "Current Monthly Rent"; Decimal)
        {
        }
        field(21; "Current Service Charge"; Decimal)
        {
        }
        field(22; "Amount Exclusive VAT"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                IF  CONFIRM('Are you sure you have entered the correct Charge?',FALSE)=FALSE THEN BEGIN ERROR('') END;
               Charge.RESET;
               Charge.SETRANGE(Charge.Code,"Charge No.");
               IF Charge.FIND('-') THEN BEGIN
               IF Charge.Vatable=TRUE THEN

               //charges based on quarterly,annually and monthly
                 Lease.RESET;
                 Lease.SETRANGE(Lease."No.","Lease No.");
                 IF Lease.FIND('-')THEN BEGIN

                 IF  (Lease."Billing Frequency"=Lease."Billing Frequency"::Quarterly) AND (Charge."Charge Once"=TRUE) THEN BEGIN
                 //charge once item for quarterly
                 Quantity:=1;
                 AExclVAT:="Amount Exclusive VAT"*Quantity;
                "VAT Amount":=((Charge."VAT Percentage(%)"/100)*AExclVAT);
                 VATAmount:="VAT Amount";
                 TOTAL:=VATAmount+AExclVAT;
                 "Amount Exclusive VAT":=AExclVAT;
                 "Total Amount Inclusive VAT":=TOTAL;
                END ELSE
                  IF  (Lease."Billing Frequency"=Lease."Billing Frequency"::Quarterly) AND (Charge."Charge Once"=FALSE) THEN BEGIN
                 Quantity:=3;
                 AExclVAT:="Amount Exclusive VAT"*Quantity;
                "VAT Amount":=((Charge."VAT Percentage(%)"/100)*AExclVAT);
                 VATAmount:="VAT Amount";
                 TOTAL:=VATAmount+AExclVAT;
                 "Amount Exclusive VAT":=AExclVAT;
                 "Total Amount Inclusive VAT":=TOTAL;
                 //end of quarterly
                 END;
                 //start of annually
                 IF  (Lease."Billing Frequency"=Lease."Billing Frequency"::Annually) AND (Charge."Charge Once"=TRUE) THEN BEGIN
                 //charge once item for quarterly
                 Quantity:=1;
                 AExclVAT:="Amount Exclusive VAT"*Quantity;
                "VAT Amount":=((Charge."VAT Percentage(%)"/100)*AExclVAT);
                 VATAmount:="VAT Amount";
                 TOTAL:=VATAmount+AExclVAT;
                 "Amount Exclusive VAT":=AExclVAT;
                 "Total Amount Inclusive VAT":=TOTAL;
                END ELSE
                IF  (Lease."Billing Frequency"=Lease."Billing Frequency"::Annually) AND (Charge."Charge Once"=FALSE) THEN BEGIN
                 Quantity:=12;
                 AExclVAT:="Amount Exclusive VAT"*Quantity;
                "VAT Amount":=((Charge."VAT Percentage(%)"/100)*AExclVAT);
                 VATAmount:="VAT Amount";
                 TOTAL:=VATAmount+AExclVAT;
                 "Amount Exclusive VAT":=AExclVAT;
                 "Total Amount Inclusive VAT":=TOTAL;
                 END;
               //end annually
                 //start of monthly
                 IF Lease."Billing Frequency"=Lease."Billing Frequency"::Monthly THEN BEGIN
                 Quantity:=1;
                 AExclVAT:="Amount Exclusive VAT"*Quantity;
                "VAT Amount":=((Charge."VAT Percentage(%)"/100)*AExclVAT);
                 VATAmount:="VAT Amount";
                 TOTAL:=VATAmount+AExclVAT;
                 "Amount Exclusive VAT":=AExclVAT;
                 "Total Amount Inclusive VAT":=TOTAL;

               END;
               END
               END
               ELSE
                 "Total Amount Inclusive VAT":="VAT Amount"+"Amount Exclusive VAT";
                */

            end;
        }
        field(23; "Rent/S.Charge Rate"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                /*Lease.RESET;
                Lease.SETRANGE(Lease."No.","Lease No.");
                IF Lease.FIND('-') THEN BEGIN
                IF (Lease."Property Type"='COMMERCIAL')THEN BEGIN
                RentalCharges.RESET;
                RentalCharges.SETRANGE(RentalCharges."Property Code",Lease."Property No.");
                RentalCharges.SETRANGE(RentalCharges."Floor No",Lease."Floor No.");
                RentalCharges.SETRANGE(RentalCharges."Unit Code",Lease."Unit Code");
                IF RentalCharges.FIND('-') THEN BEGIN
                Charge.RESET;
                Charge.SETRANGE(Charge.Code,"Charge No.");
                IF Charge.FIND('-') THEN BEGIN
                IF (Charge."Uses Rates"=TRUE) THEN BEGIN
                IF "Rent/S.Charge Rate">=RentalCharges."Rental Rate" THEN BEGIN
                "Current Monthly Rent":=("Area Square ft"*"Rent/S.Charge Rate");
                "Amount Exclusive VAT":="Current Monthly Rent"+"Current Service Charge";
                END ELSE BEGIN
                ERROR('The Rental Rate you have specified is below the set Unit Rental Charge');
                "Current Monthly Rent":=("Area Square ft"*"Rent/S.Charge Rate");
                "Amount Exclusive VAT":="Current Monthly Rent"+"Current Service Charge";
                
                
                END;
                END;
                END;
                END;
                 "Amount Exclusive VAT":=("Area Square ft"*"Rent/S.Charge Rate");
                END;
                END;
                VALIDATE("Amount Exclusive VAT");
                 */

            end;
        }
        field(24; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(25; "No."; Code[20])
        {
            CalcFormula = Lookup(Charges."Account No." WHERE(Code = FIELD("Charge No.")));
            Caption = 'No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Reference";
                PrepaymentMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(26; "Property No"; Code[20])
        {
            CalcFormula = Lookup(Lease."Property No." WHERE("No." = FIELD("Lease No.")));
            FieldClass = FlowField;
        }
        field(43; "Transaction Code"; Code[30])
        {
            TableRelation = Charges.Code;
        }
        field(44; "Review Amount"; Decimal)
        {
        }
        field(45; "Tenant No."; Code[20])
        {
            CalcFormula = Lookup(Lease."Tenant No." WHERE("No." = FIELD("Lease No.")));
            FieldClass = FlowField;
            TableRelation = Customer."No.";
        }
        field(46; "Review Is Rate ?"; Boolean)
        {
        }
        field(47; "Review Is Amount"; Boolean)
        {
        }
        field(48; Amount; Decimal)
        {
        }
        field(49; "VAT Amount"; Decimal)
        {
        }
        field(50; "VAT%"; Decimal)
        {
        }
        field(51; "Total Amount Inclusive VAT"; Decimal)
        {
        }
        field(55; "Charge Letting Fee"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                Lease.RESET;
                Lease.SETRANGE(Lease."No.","Lease No.");
                IF Lease.FIND('-')THEN BEGIN
                IF "Charge Letting Fee"=TRUE THEN
                Lease."Charge Letting Fee":=TRUE;
                END;
                 */

            end;
        }
        field(56; "Charge Reletting Fee"; Boolean)
        {
        }
        field(57; Quantity; Decimal)
        {
        }
        field(58; "IsService Charge"; Boolean)
        {
        }
        field(59; Charged; Boolean)
        {
        }
        field(60; "Charge once date"; Date)
        {
        }
        field(61; "Batch No"; Code[30])
        {
        }
        field(62; Once; Boolean)
        {
        }
        field(63; InvNo; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Charge No.", "Lease No.", "Batch No", "Line No", InvNo)
        {
            Clustered = true;
            SumIndexFields = "Total Amount Inclusive VAT", "VAT Amount", "Amount Exclusive VAT";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Type := Type::"G/L Account";
    end;

    var
        Charge: Record Charges;
        RentalCharges: Record "Unit Setup Charges";
        Lease: Record Lease;
        SalesHeader: Record "Sales Header";
        SalesLine2: Record "Sales Line";
        PropertyCharges: Record "Unit Setup Charges";
        ApprovalEntry: Record "Approval Entry";
        LeaseLine: Record "Lease Line";
        TOTAL: Decimal;
        AExclVAT: Decimal;
        VATAmount: Decimal;

    [Scope('OnPrem')]
    procedure GetLeaseLine()
    begin
    end;
}

