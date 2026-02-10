page 52185918 "Bank Pay In Slip"
{
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Bank Slip";
    SourceTableView = WHERE(Status = CONST(New),
                            Posted = CONST(false),
                            Vaulted = CONST(false));

    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Slip No."; Rec."Bank Slip No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                label(Control1102758031)
                {
                    CaptionClass = Text19044997;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Source Dimension 1 Code"; Rec."Source Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec."Source Dimension 1 Name" := GetDimensionName(Rec."Source Dimension 1 Code", 1);
                    end;
                }
                field("Source Dimension 1 Name"; Rec."Source Dimension 1 Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Source Dimension 2 Code"; Rec."Source Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec."Source Dimension 2 Name" := GetDimensionName(Rec."Source Dimension 2 Code", 2);
                    end;
                }
                field("Source Dimension 2 Name"; Rec."Source Dimension 2 Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("From Bank Code"; Rec."From Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                label(Control1102758032)
                {
                    CaptionClass = Text19029207;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                }
                field("From Account Name"; Rec."From Account Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Dimension 1 Code"; Rec."Destination Dimension 1 Code")
                {

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        Rec."Destination Dimension 1 Name" := GetDimensionName(Rec."Destination Dimension 1 Code", 1);
                    end;
                }
                field("Destination Dimension 1 Name"; Rec."Destination Dimension 1 Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Dimension 2 Code"; Rec."Destination Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec."Destination Dimension 2 Name" := GetDimensionName(Rec."Destination Dimension 2 Code", 2);
                    end;
                }
                label(Control1102755003)
                {
                    CaptionClass = Text19080001;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                }
                field("Return Remarks"; Rec."Return Remarks")
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Destination Dimension 2 Name"; Rec."Destination Dimension 2 Name")
                {
                    Editable = false;

                    ApplicationArea = Basic, Suite;
                }
                field("To Bank Code"; Rec."To Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("To Account Name"; Rec."To Account Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1102758005; "Released Store Requisitions Li")
            {
                SubPageLink = "No." = FIELD(No);
                ApplicationArea = Basic, Suite;
            }
            label(Control1102758006)
            {
                CaptionClass = Text19005631;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Send for Confirmation")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Send for Confirmation';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Move Deposit details for Confirmation?', false) = false then begin exit end;
                    Rec.TestField(Date);
                    Rec.TestField("Source Dimension 1 Code");
                    Rec.TestField("Source Dimension 2 Code");
                    Rec.TestField("From Bank Code");
                    Rec.TestField("Destination Dimension 1 Code");
                    Rec.TestField("Destination Dimension 2 Code");
                    Rec.TestField("To Bank Code");
                    Rec.TestField(Amount);
                    //check if the accounts are the same
                    if Rec."From Bank Code" = Rec."To Bank Code" then begin
                        Error('Source and Receiving Account cannot be similar');
                    end;
                    //check that the summation of the lines must be equal to the sum inserted
                    BPL.Reset;
                    BPL.SetRange(BPL.No, Rec.No);

                    LineAmount := 0;

                    if BPL.FindFirst then begin
                        repeat
                            if BPL."Bank Slip No." = '' then begin
                                Error('Please ensure that all deposit lines have deposit slip numbers');
                            end;
                            if BPL.Type = BPL.Type::Cheque then begin
                                BPL.TestField(BPL."Cheque No");
                                BPL.TestField(BPL."Drawers Name");
                                BPL.TestField(BPL."Cheque Date");
                            end;
                            LineAmount := LineAmount + BPL.Amount;
                        until BPL.Next = 0;
                    end;

                    if LineAmount <> Rec.Amount then begin
                        Error('Line Amount and Total Amount deposited do not Tally');
                    end;

                    Rec.Status := Rec.Status::Confirmation;
                    Rec.Modify;
                    Message('Bank Deposit details move to Confirmation Level');
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec.Amount = 0 then begin
                        Error('Please ensure Amount to Transfer is entered');
                    end;

                    /*Check if the amount in the line is equal to the header amount*/
                    LineAmount := 0;
                    BPL.Reset;
                    BPL.SetRange(BPL.No, Rec.No);
                    if BPL.Find('-') then begin
                        repeat
                            LineAmount := LineAmount + BPL.Amount;
                        until BPL.Next = 0;
                    end;

                    if LineAmount <> Rec.Amount then begin
                        Error('Amount Must Be Equal to Deposit Details');
                    end;

                    CashierLinks.Reset;
                    CashierLinks.SetRange(CashierLinks.UserID, UserId);
                    Rec."Pay In Bank Template Name" := CashierLinks."Bank Pay In Journal Template";
                    Rec."Pay In Bank Journal Batch" := CashierLinks."Bank Pay In Journal Batch";
                    /*Check if the user's batch has any records within it*/
                    GenJnlLine.Reset;
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", Rec."Pay In Bank Template Name");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec."Pay In Bank Journal Batch");
                    GenJnlLine.DeleteAll;

                    LineNo := 1000;
                    BPL.Reset;
                    BPL.SetRange(BPL.No, Rec.No);
                    if BPL.Find('-') then begin
                        repeat
                            /*Insert the new lines to be updated*/
                            GenJnlLine.Init;
                            /*Insert the lines*/
                            GenJnlLine."Line No." := LineNo + 1;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Journal Template Name" := Rec."Pay In Bank Template Name";
                            GenJnlLine."Journal Batch Name" := Rec."Pay In Bank Journal Batch";
                            GenJnlLine."Posting Date" := Rec.Date;
                            GenJnlLine."Document No." := Rec.No;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine."Account No." := Rec."To Bank Code";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine.Description := Format(BPL.Type) + ':' + BPL."Cheque No" + ':' + Format(BPL."Cheque Date");
                            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Destination Dimension 1 Code";
                            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Destination Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            GenJnlLine.Amount := BPL.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            GenJnlLine.Insert;
                            LineNo := LineNo + 1;

                            GenJnlLine.Init;
                            /*Insert the lines*/
                            GenJnlLine."Line No." := LineNo + 1;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Journal Template Name" := Rec."Pay In Bank Template Name";
                            GenJnlLine."Journal Batch Name" := Rec."Pay In Bank Journal Batch";
                            GenJnlLine."Posting Date" := Rec.Date;
                            GenJnlLine."Document No." := Rec.No;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine."Account No." := Rec."From Bank Code";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine.Description := Format(BPL.Type) + ':' + BPL."Cheque No" + ':' + Format(BPL."Cheque Date");
                            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Source Dimension 1 Code";
                            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Source Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            GenJnlLine.Amount := -BPL.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            GenJnlLine.Insert;

                            LineNo := LineNo + 1;
                        until BPL.Next = 0;

                        CODEUNIT.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);
                        Rec.Posted := true;
                        Rec."Date Posted" := Today;
                        Rec."Time Posted" := Time;
                        Rec."Posted By" := UserId;
                        Rec.Modify;
                        //MESSAGE('The Journal Has Been Posted Successfully');
                    end;

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //check if the user has been setup as a cashier in relation to bank pay in slips
        CashierLinks.Reset;
        CashierLinks.SetRange(CashierLinks.UserID, UserId);
        if CashierLinks.Find('-') then begin
            if (CashierLinks."Bank Pay In Journal Template" = '') or (CashierLinks."Bank Pay In Journal Batch" = '') then begin
                Error('Sorry you have not been fully setup as a Pay In Bank Slip user. Contact the System Administrator');
            end;
        end
        else begin
            Error('Sorry you have not been setup as a Cash Office User');
        end;

        //***************************Ochieng***************************//
        Rec.SetRange("Created By", UserId);
        //***************************END ***************************//
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        RecPayTypes: Record "Receipts and Payment Types";
        LineNo: Integer;
        LineAmount: Decimal;
        BPL: Record "Bank Slip Line";
        Text19044997: Label 'Source Details';
        Text19029207: Label 'Receiving Details';
        Text19080001: Label 'Receiving Details';
        Text19005631: Label 'Enter Deposit Details Below';

    //[Scope('OnPrem')]
    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset;
        GLSetup.Get();

        DimVal.Reset;
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then begin
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
        end
        else
            if DimNo = 2 then begin
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
            end;
        if DimVal.Find('-') then begin
            Name := DimVal.Name;
        end;

    end;
}

