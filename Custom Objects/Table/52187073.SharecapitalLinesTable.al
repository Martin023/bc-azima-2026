table 52187073 "Share Capital Transfer Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(10; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Destination Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
            trigger OnValidate()
            var
                myInt: Integer;
                member: Record Members;
                ShareLines: Record "Share Capital Transfer Lines";
                shareheader: Record "Share Capital Transfer Buffer";
                savingacc: Record "Savings Accounts";
                ACCountToRec: Code[30];
                ProductCategory: enum "Product Categories";
                AccBa: Decimal;
                Transch: Record "Transaction Charges";
                ChargType: Record "Transaction Types";
                Sharecharge: Decimal;

            begin
                Rec."Application Date" := Today;
                savingacc.Reset();
                savingacc.SetRange(savingacc."Member No.", Rec."Destination Member No");
                savingacc.SetRange("Product Category", savingacc."Product Category"::"FOSA Account");
                if savingacc.FindFirst() then begin
                    AccBa := savingacc.GetAvailableBalance(savingacc."No.");
                end;
                shareheader.Reset();
                shareheader.SetRange(shareheader."Document No", "Document No.");
                shareheader.SetRange(shareheader."Source Member No", Rec."Destination Member No");
                if shareheader.FindFirst() then
                    Error('You cannot transfer shares to the same member');
                shareheader.Reset();
                shareheader.SetRange(shareheader."Document No", Rec."Document No.");
                if shareheader.FindFirst() then begin
                    ChargType.Reset();
                    ChargType.SetRange(ChargType.Code, shareheader."Transaction Type");
                    if ChargType.FindFirst() then begin
                        Transch.Reset();
                        Transch.SetRange(Transch."Transaction Type", ChargType.Code);
                        if Transch.FindFirst() then
                            Sharecharge := Transch."Charge Amount";
                    end;
                end;
                // if AccBa < Sharecharge then
                //     Error('The Member has insufficient funds in Fosa account to effect the charges');
                ShareLines.Reset();
                ShareLines.SetRange("Document No.", Rec."Document No.");
                ShareLines.SetRange("Destination Member No", Rec."Destination Member No");
                if ShareLines.FindFirst() then
                    Error('You cannot repeat the same Member in the same card');
                "Application Date" := Today;
                member.Reset();
                member.SetRange("No.", Rec."Destination Member No");
                if member.FindFirst() then begin
                    Rec."Destination Member Name" := member.Name;
                    Rec."Mobile No" := member."Phone No.";
                    Rec."ID No" := member."Primary Identification";
                    savingacc.Reset();
                    savingacc.SetRange("Member No.", member."No.");
                    savingacc.SetFilter("Product Category", Format(ProductCategory::"Share Capital"));
                    if savingacc.FindFirst() then begin
                        ACCountToRec := savingacc."No.";
                        Rec."Account No" := savingacc."No.";
                    end;
                    // it will be created
                    // else begin
                    //     Error('There is no transfer share capital account');
                    // end;
                end;
            end;
        }
        field(3; "Destination Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(4; "Allocation Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     shareheader: Record "Share Capital Transfer Buffer";
            //     ShareLines: Record "Share Capital Transfer Lines";
            //     allcAmt: Decimal;
            // begin
            //     shareheader.Reset();
            //     shareheader.SetRange("Document No", Rec."Document No.");
            //     if shareheader.FindFirst() then begin
            //         ShareLines.Reset();
            //         ShareLines.SetRange("Document No.", shareheader."Document No");
            //         if ShareLines.FindFirst() then begin
            //             repeat
            //                 allcAmt := allcAmt + ShareLines."Allocation Amount";
            //             until ShareLines.Next() = 0;
            //             if allcAmt < shareheader."Source Balance" then Message('partial transfer is not allowed kindly add amount or add member to buy');
            //             if allcAmt > shareheader."Source Balance" then
            //                 Error('You cannot transfer more than what the member has in the account');
            //         end;
            //     end;
            // end;
        }
        field(5; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Mobile No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "Document No.", "Destination Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        ShareHeader: Record "Share Capital Transfer Buffer";

    trigger OnInsert()
    begin



    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}