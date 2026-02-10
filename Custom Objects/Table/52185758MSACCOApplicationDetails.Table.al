table 52185758 "M-SACCO Application Details"
{

    fields
    {
        field(1; "Application No"; Code[30])
        {
            NotBlank = true;
            TableRelation = "M-SACCO Applications";
        }
        field(2; "Account Type"; Option)
        {
            Caption = 'Account Type';
            NotBlank = true;
            OptionCaption = ',Creditor';
            OptionMembers = ,Creditor;
        }
        field(3; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            NotBlank = true;
            TableRelation = "Savings Accounts"."No." WHERE("Loan Disbursement Account" = CONST(true));

            trigger OnValidate()
            begin

                MpesaApplications.Reset;
                MpesaApplications.SetRange(MpesaApplications.No, "Application No");
                if MpesaApplications.Find('-') then begin

                    if MpesaApplications."Account No" <> "Account No." then begin

                        Error('Account Not For Selected Member');

                    end;

                end;

                // case "Account Type" of
                //     "Account Type"::"0":
                //         begin
                //             Cust.Get("Account No.");
                //             Description := Cust.Name;
                //         end;
                //     "Account Type"::Creditor:
                //         begin
                //             Cust.Get("Account No.");
                //             Description := Cust.Name;
                //         end;
                // end;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Application No", "Account Type", "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record "Savings Accounts";
        MpesaApplications: Record "M-SACCO Applications";
}

