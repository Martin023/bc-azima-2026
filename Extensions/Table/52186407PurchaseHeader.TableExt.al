#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186407 tableextension52186407 extends "Purchase Header"
{
    fields
    {
        field(50000; Copied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50152; "P.O.Box Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50153; "Physical Address."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        // field(50154;"Quotation No.";Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Purchase Quote Header"."No.";

        //     trigger OnValidate()
        //     begin
        //         PurchaseQuoteHeader.Reset;
        //         PurchaseQuoteHeader.SetRange("No.",Rec."Quotation No.");
        //         if PurchaseQuoteHeader.FindFirst then begin
        //           Rec."Contract Ref No":=PurchaseQuoteHeader."Contract Ref No.";
        //           Rec."Quotation Date":=PurchaseQuoteHeader."Document Date";
        //         end;
        //     end;
        // }
        field(50155; "Quotation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50156; "Contract Ref No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005531; "Order Posting Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Frozen,UnFrozen;
        }
        field(39005532; "Frozen By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39005533; "UnFrozen By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39005536; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39005537; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005538; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39005539; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(39005540; "Procurement Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39005541; "Invoice Basis"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "PO Based","Direct Invoice";
        }
        field(39005559; "Contract No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contracts."Contract No" where("Contractor No" = field("Buy-from Vendor No."));



            trigger OnValidate()
            begin

                /*PurchLine.RESET;
                PurchLine.SETRANGE("Document Type","Document Type");
                PurchLine.SETRANGE("Document No.","No.");
                IF PurchLine.FINDSET THEN
                REPEAT
                  PurchLine."Contract No." := "Contract No.";
                  PurchLine.MODIFY;
                UNTIL PurchLine.NEXT = 0;
                */

            end;
        }
        field(39005560; "Case No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Legal."Case Number";
        }
        field(39005561; "Running Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39005562; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39005563; "Approval Time"; Time)
        {

        }
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                Comments: Record Comments;
            begin
                if Rec.Status = Rec.Status::Released then begin
                    if Rec."Document Type" = Rec."Document Type"::Invoice then begin
                        if (Rec.Status = Status::Released) or (Rec.Status = Status::Released) then begin
                            Comments.Reset();
                            Comments.SetRange("Commented By", UserId);
                            Comments.SetRange("Viewd By Somebody Else", false);
                            Comments.SetRange("Header No.", "No.");
                            if not Comments.FindFirst() then
                                Error('Please add a comment before performing this action');
                        end;
                    end;
                end;
            end;
        }

    }
    // trigger OnInsert()
    // beginOnValidate
    //     IF NOT SkipInitialization THEN
    //         InitInsert;

    // end;
    //    procedure SkipInitialization() : Boolean

    //         IF "No." = '' THEN
    //           EXIT(FALSE);

    //         IF "Buy-from Vendor No." = '' THEN
    //           EXIT(FALSE);

    //         IF xRec."Document Type" <> "Document Type" THEN
    //           EXIT(FALSE);

    //         IF GETFILTER("Buy-from Vendor No.") <> '' THEN
    //           IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
    //             IF "Buy-from Vendor No." = GETRANGEMIN("Buy-from Vendor No.") THEN
    //               EXIT(FALSE);

    //         EXIT(TRUE);


    var
    // PurchaseQuoteHeader: Record "Purchase Quote Header";
    trigger OnInsert()
    begin
        "Assigned User ID" := UserId;
        "User ID" := UserId;
        UserSetup.reset();
        UserSetup.SetRange("User ID", UserID);
        if UserSetup.FindFirst() then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";

        end;
    end;

    trigger OnModify()
    var
        Comments: Record Comments;
    begin
        if Rec.Status = Rec.Status::Released then begin
            if Rec."Document Type" = Rec."Document Type"::Invoice then begin
                //if (Rec.Status = Status::Released) then begin
                Comments.Reset();
                Comments.SetRange("Commented By", UserId);
                Comments.SetRange("Viewd By Somebody Else", false);
                Comments.SetRange("Header No.", "No.");
                if not Comments.FindFirst() then
                    Error('Please add a comment before performing this action');
                //end;
            end;
        end;
    end;

    var
        UserSetup: record "User Setup";
}
