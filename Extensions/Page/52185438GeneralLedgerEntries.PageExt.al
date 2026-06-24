#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185438 GeneralLedgerEntriesEXT extends "General Ledger Entries"
{

    //Unsupported feature: Property Modification (DeleteAllowed) on ""General Ledger Entries"(Page 20)".
    Editable = false;
    layout
    {
        movebefore("Posting Date"; "G/L Account No.")
        moveafter(Description; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; RunningBalance)

        moveafter("Credit Amount"; "Amount")

        // moveafter("Posting Date"; "Document No.")
        moveafter("Document No."; "External Document No.")
        // moveafter("External Document No."; Description)
        // moveafter(Description; "G/L Account No.")
        // moveafter("G/L Account No."; "G/L Account Name")
        // movebefore("Entry No."; "User ID")
        // // moveafter("User ID"; "Global Dimension 1 Code")
        // moveafter("Global Dimension 1 Code"; "Global Dimension 2 Code")
        // // moveafter("Global Dimension 2 Code"; "Debit Amount")
        // //moveafter("Debit Amount"; "Credit Amount")
        // //moveafter("Credit Amount"; Amount)
        // //moveafter(Amount; "Bal. Account Type")
        // moveafter("Bal. Account Type"; "Bal. Account No.")
        // moveafter("Bal. Account No."; "Source Type")
        // moveafter("Entry No."; "Document Type")
        // moveafter("Document Type"; "Gen. Posting Type")
        // moveafter("Gen. Posting Type"; "Gen. Bus. Posting Group")
        // moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")



        // addafter("Debit Amount")
        // {
        //     field("Credit Amount";Rec."Credit Amount")
        //     {

        //     }
        // }
        // addbefore("Bal. Account No.")
        // {
        //     field("Amount."; Rec."Amount")
        //     {

        //     }
        // }
        addafter("Posting Date")
        {
            field("Transaction DateTime"; Rec."Last Modified DateTime")
            {

            }
        }
        addafter("Bal. Account No.")
        {
            field("Source Type."; Rec."Source Type") { }

            field("Source No"; Rec."Source No.") { }
        }
        //   moveafter("Global Dimension 2 Code"; "Debit Amount")

        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account Name")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Code")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
            visible = false;
        }

        modify("Additional-Currency Amount")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
            Visible = true;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify(Reversed)
        {
            ApplicationArea = Basic;
        }
        modify("Reversed by Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Reversed Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("FA Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }




        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify(RunningBalance)
        {
            Visible = true;
        }



        modify("Dimension Set ID")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = true;
        }



        moveafter(Amount; "Additional-Currency Amount")
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(GLDimensionOverview)
        {
            ApplicationArea = Basic;
        }
        modify("Value Entries")
        {
            ApplicationArea = Basic;
        }
        modify(ReverseTransaction)
        {
            ApplicationArea = Basic;
            //Visible = false;
            Enabled = AllowReversals;
        }
        modify(IncomingDocCard)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(SelectIncomingDoc)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify(IncomingDocAttachFile)
        {
            ToolTip = '';
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 24)".

        }
        modify(DocsWithoutIC)
        {
            ApplicationArea = Basic;
        }



        modify(SetDimensionFilter)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "GLDimensionOverview(Action 50).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISTEMPORARY THEN BEGIN
          GLEntriesDimensionOverview.SetTempGLEntry(Rec);
          GLEntriesDimensionOverview.RUN;
        END ELSE
          PAGE.RUN(PAGE::"G/L Entries Dimension Overview",Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PAGE.RUN(PAGE::"G/L Entries Dimension Overview",Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GLDimensionOverview(Action 50)".


        //Unsupported feature: Property Deletion (Promoted) on "GLDimensionOverview(Action 50)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "GLDimensionOverview(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Value Entries"(Action 65)".


        //Unsupported feature: Property Deletion (Promoted) on ""Value Entries"(Action 65)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Value Entries"(Action 65)".



        //Unsupported feature: Code Modification on "ReverseTransaction(Action 63).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(ReversalEntry);
        IF Reversed THEN
          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");
        IF "Journal Batch Name" = '' THEN
          ReversalEntry.TestFieldError;
        TESTFIELD("Transaction No.");
        ReversalEntry.ReverseTransaction("Transaction No.")
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        // IF USERID="User ID" THEN
        //   ERROR(Err001);
        CLEAR(ReversalEntry);

        #2..7
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ReverseTransaction(Action 63)".


        //Unsupported feature: Property Deletion (Promoted) on "ReverseTransaction(Action 63)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ReverseTransaction(Action 63)".



        //Unsupported feature: Code Modification on "SelectIncomingDoc(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IncomingDocument.SelectIncomingDocumentForPostedDocument("Document No.","Posting Date",RECORDID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IncomingDocument.SelectIncomingDocumentForPostedDocument("Document No.","Posting Date");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocsWithoutIC(Action 11)".


    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if UserSetup."Post Reversals" = true then
            AllowReversals := true;
        if Rec."Posting Date" <> Today then
            AllowReversals := false;

    end;

    var
        Err001: label 'You cannot reverse a transaction you posted';
        UserSetup: Record "User Setup";
        AllowReversals: Boolean;

    //Unsupported feature: Property Deletion (Permissions).


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
