table 52185450 "Online Transactionss"
{

    fields
    {
        field(1; "Document No."; Integer)
        {
            AutoIncrement = true;

            trigger OnValidate()
            begin
                /*IF "Document No." <> xRec."Document No." THEN BEGIN
                  SalesSetup.GET;
                  NoSeriesMgt.TestManual(SalesSetup."Customer Nos.");
                  "No. Series" := '';
                END;
                */

            end;
        }
        field(2; "Transaction Date"; DateTime)
        {
        }
        field(3; "Account No."; Code[50])
        {
        }
        field(4; Description; Text[220])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Transaction Type"; Option)
        {
            OptionCaption = ',Online Transfer,Utility Payments,Mpesa Transfer,Loan Repayment,Dividends Allocation';
            OptionMembers = ,"Online Transfer","Utility Payments","Mpesa Transfer","Loan Repayment","Dividends Allocation";
        }
        field(8; "Transaction Time"; Date)
        {
        }
        field(10; "Document Date"; DateTime)
        {
        }
        field(11; "Date Posted"; DateTime)
        {
        }
        field(12; "Time Posted"; Time)
        {
        }
        field(13; "Account Status"; Text[30])
        {
        }
        field(14; Messages; Text[200])
        {
        }
        field(15; "Needs Change"; Boolean)
        {
        }
        field(16; "Change Transaction No"; Code[20])
        {
        }
        field(17; "Old Account No"; Code[50])
        {
        }
        field(18; Changed; Boolean)
        {
        }
        field(19; "Date Changed"; Date)
        {
        }
        field(20; "Time Changed"; Time)
        {
        }
        field(21; "Changed By"; Code[30])
        {
        }
        field(22; "Approved By"; Code[30])
        {
        }
        field(25; "Key Word"; Text[30])
        {
        }
        field(27; CorporateNo; Text[30])
        {
        }
        field(28; "Telephone No"; Text[30])
        {
        }
        field(29; "Mpesa Names"; Text[30])
        {
        }
        field(30; "Utility Type"; Text[200])
        {
        }
        field(31; "Account To"; Text[200])
        {
        }
        field(32; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(33; "Member No"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "Document No." = '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD("Customer Nos.");
          NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",xRec."No. Series",0D,"Document No.","No. Series");
        END;*/

    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
}

