page 52186244 "Billed BHole Batch"
{
    PageType = Card;
    SourceTable = "Billed BHole Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("B/Hole No."; Rec."B/Hole No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Water Account"; Rec."Water Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Billing Description"; Rec."Billing Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Water Code"; Rec."Water Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control1102755013; "Bill Unit Meter Ratings")
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
                SubPageLink = "B/Hole water bill No." = FIELD("B/Hole No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Billing Description");

                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        GenJl.Reset;
                        GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
                        GenJl.SetRange(GenJl."Journal Batch Name", 'WATER');
                        GenJl.DeleteAll;

                        GenJl.Reset;
                        GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
                        GenJl.SetRange(GenJl."Journal Batch Name", 'WATER');
                        if GenJl.Find('+') then begin
                            LineNo := GenJl."Line No." + 1000;
                        end
                        else begin
                            LineNo := 1000;
                        end;
                        GenJl.DeleteAll;
                        GenJl.Reset;


                        if Rec.Posted = true then begin
                            Error('You cannot post more than Once.Water Bill Invoice had already been Posted.');
                        end;
                        BillUnit.Reset;
                        //BillUnit.SETRANGE(BillUnit."Property No","Property No.");
                        BillUnit.SetRange(BillUnit."B/Hole water bill No.", Rec."B/Hole No.");
                        if BillUnit.Find('-') then begin

                            repeat
                                L.Reset;
                                L.SetRange(L."Tenant No.", BillUnit."Tenant No.");
                                if L.Find('-') then begin
                                    GenJl.Reset;
                                    GenJl.Init;
                                    "LineNo." := "LineNo." + 1000;
                                    GenJl."Journal Template Name" := 'GENERAL';
                                    GenJl."Journal Batch Name" := 'WATER';
                                    GenJl."Line No." := "LineNo." + 1000;
                                    GenJl."Posting Date" := Rec."Posting Date";
                                    GenJl."Document No." := Rec."B/Hole No.";
                                    GenJl."Account Type" := GenJl."Account Type"::Customer;
                                    GenJl."Account No." := BillUnit."Tenant No.";
                                    GenJl.Validate(GenJl."Account No.");
                                    GenJl."External Document No." := BillUnit."Tenant No.";
                                    GenJl.Amount := BillUnit."Total Due";
                                    GenJl.Validate(GenJl.Amount);
                                    //GenJl."Transaction Type":=L."No.";
                                    // GenJl."Transaction Code" := Rec."Water Code";
                                    //GenJl."Transaction Name":="Billing Description";
                                    GenJl.Description := Rec."Billing Description";
                                    //GenJl."Entry Type":=GenJl."Entry Type"::"0";
                                    GenJl."Property Code" := Rec."Property No.";
                                    //GenJl."Property Name":=L."Property Name";
                                    GenJl."Tenant No" := BillUnit."Tenant No.";
                                    GenJl."Shortcut Dimension 1 Code" := BillUnit."Global Dimension 1 Code";
                                    GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
                                    GenJl."Shortcut Dimension 2 Code" := BillUnit."Global Dimension 2 Code";
                                    GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
                                    GenJl.Insert(true);
                                    /*
                                      //BALANCING FIGURES

                                       "LineNo.":="LineNo."+1000;
                                       GenJl.INIT;
                                       GenJl."Journal Template Name":='GENERAL';
                                       GenJl."Journal Batch Name":='WATER';
                                       GenJl."Line No.":="LineNo."+1000;
                                       GenJl."Posting Date":="Posting Date";
                                       GenJl."Document No.":="B/Hole No.";
                                       GenJl.VALIDATE(GenJl."Account No.");
                                       GenJl."External Document No.":=BillUnit."Tenant No.";
                                       GenJl."Account Type":=GenJl."Account Type"::Vendor;
                                       GenJl."Account No.":=L."Landlord No.";
                                       GenJl.Amount:=BillUnit."Total Due"*-1;
                                       GenJl.VALIDATE(GenJl.Amount);
                                       GenJl."Lease No":=L."No.";
                                       GenJl."Transaction Code":="Water Code";
                                       GenJl.Description:=L."Landlord Name";
                                       GenJl."Transaction Name":="Billing Description";
                                       GenJl."Entry Type":=GenJl."Entry Type"::" ";
                                       GenJl."Property Code":="Property No.";
                                       GenJl."Property Name":=L."Property Name";
                                       GenJl."LandLord No.":=L."Landlord No.";
                                       GenJl."Shortcut Dimension 1 Code":=BillUnit."Global Dimension 1 Code";
                                       GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
                                       GenJl."Shortcut Dimension 2 Code":=BillUnit."Global Dimension 2 Code";
                                       GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
                                       GenJl.INSERT(TRUE);



                                       GenJl.INIT;
                                       "LineNo.":="LineNo."+1000;
                                       GenJl."Journal Template Name":='GENERAL';
                                       GenJl."Journal Batch Name":='WATER';
                                       GenJl."Line No.":="LineNo."+1000;
                                       GenJl."Posting Date":="Posting Date";
                                       GenJl."Document No.":="B/Hole No.";
                                       GenJl."Account Type":=GenJl."Account Type"::Vendor;
                                       GenJl."Account No.":=L."Landlord No.";
                                       GenJl.VALIDATE(GenJl."Account No.");
                                       GenJl."External Document No.":=BillUnit."Tenant No.";
                                       GenJl.Amount:=BillUnit."Total Due";
                                       GenJl.VALIDATE(GenJl.Amount);
                                       GenJl."Lease No":=L."No.";
                                       GenJl."Transaction Code":="Water Code";
                                       GenJl."Transaction Name":="Billing Description";
                                       GenJl."Entry Type":=GenJl."Entry Type"::" ";
                                       GenJl."Property Code":="Property No.";
                                       GenJl."Property Name":=L."Property Name";
                                       GenJl."Tenant No":=BillUnit."Tenant No.";
                                       GenJl."Shortcut Dimension 1 Code":=BillUnit."Global Dimension 1 Code";
                                       GenJl.VALIDATE(GenJl."Shortcut Dimension 1 Code");
                                       GenJl."Shortcut Dimension 2 Code":=BillUnit."Global Dimension 2 Code";
                                       GenJl.VALIDATE(GenJl."Shortcut Dimension 2 Code");
                                       GenJl.INSERT(TRUE);
                                   */
                                    //BALANCING FIGURES

                                    "LineNo." := "LineNo." + 1000;
                                    GenJl.Init;
                                    GenJl."Journal Template Name" := 'GENERAL';
                                    GenJl."Journal Batch Name" := 'WATER';
                                    GenJl."Line No." := "LineNo." + 1000;
                                    GenJl."Posting Date" := Rec."Posting Date";
                                    GenJl."Document No." := Rec."B/Hole No.";
                                    GenJl.Validate(GenJl."Account No.");
                                    GenJl."External Document No." := BillUnit."Tenant No.";
                                    GenJl."Account Type" := GenJl."Account Type"::"G/L Account";
                                    GenJl."Account No." := Rec."Water Account";
                                    GenJl.Amount := BillUnit."Total Due" * -1;
                                    GenJl.Validate(GenJl.Amount);
                                    //GenJl."Transaction Type":=L."No.";
                                    // GenJl."Transaction Code" := Rec."Water Code";
                                    GenJl.Description := Rec."Billing Description";
                                    //GenJl."Transaction Name":="Billing Description";
                                    //GenJl."Entry Type":=GenJl."Entry Type"::"0";
                                    GenJl."Property Code" := Rec."Property No.";
                                    //GenJl."Property Name":=L."Property Name";
                                    //GenJl."LandLord No.":=L."Landlord No.";
                                    GenJl."Shortcut Dimension 1 Code" := BillUnit."Global Dimension 1 Code";
                                    GenJl.Validate(GenJl."Shortcut Dimension 1 Code");
                                    GenJl."Shortcut Dimension 2 Code" := BillUnit."Global Dimension 2 Code";
                                    GenJl.Validate(GenJl."Shortcut Dimension 2 Code");
                                    GenJl.Insert(true);
                                    Rec.Posted := true;
                                    BillUnit.Posted := true;
                                    Rec.Modify;

                                    // update Previous meter No.
                                    L.Reset;
                                    L.SetRange(L."Tenant No.", BillUnit."Tenant No.");
                                    if L.Find('-') then begin
                                        repeat
                                            //MESSAGE(FORMAT(L."No."));
                                            L."Previous Reading" := BillUnit."Previous Reading";
                                            L."Current Reading" := BillUnit."Current Reading";
                                            L.Modify;
                                        until L.Next = 0;
                                    end;


                                end;

                            until BillUnit.Next = 0;

                            // POST BATCH
                            GenJl.Reset;
                            GenJl.SetRange(GenJl."Journal Template Name", 'GENERAL');
                            GenJl.SetRange(GenJl."Journal Batch Name", 'WATER');
                            if GenJl.Find('-') then begin
                                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJl);
                            end;
                            Message('Batch Posted successfully');

                        end;

                    end;
                }
            }
        }
    }

    var
        NoSeries: Record "No. Series Line";
        LastNo: Code[20];
        SaleSetup: Record "Sales & Receivables Setup";
        LineNo: Integer;
        PostingDateReq: Date;
        Cust: Record Customer;
        RegNo: Integer;
        CompInfo: Record "Company Information";
        BillUnit: Record "Bill Units meter Ratings";
        GenJl: Record "Gen. Journal Line";
        L: Record Lease;
        "LineNo.": Integer;
}

