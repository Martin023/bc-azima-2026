#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185591 pageextension52185591 extends "General Journal Batches"
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
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
        modify("No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Posting No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Copy VAT Setup to Jnl. Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Allow VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Payment Export")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Statement Import Format")
        {
            ApplicationArea = Basic;
        }
        modify("Suggest Balancing Amount")
        {
            Visible = false;
        }
        addafter("Bank Statement Import Format")
        {
            field("User Id"; rec."User Id")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify(EditJournal)
        {
            ApplicationArea = Basic;
        }
        modify(TestReport)
        {

            //Unsupported feature: Property Modification (Name) on "TestReport(Action 16)".

            ApplicationArea = Basic;
        }
        modify("P&ost")
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }
        modify("Recurring General Journal")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Recurring General Journal"(Action 7)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Recurring General Journal"(Action 7)".

        }
        modify("G/L Register")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""G/L Register"(Action 9)".

        }
        modify("Detail Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Trial Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Trial Balance by Period")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Trial Balance by Period"(Action 12)".

        }
        modify(Action10)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "Action10(Action 10)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "Action10(Action 10)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "EditJournal(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestReport(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 18)".

        modify(MarkedOnOff)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring General Journal"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Register"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Detail Trial Balance"(Action 20)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Detail Trial Balance"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance"(Action 14)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Trial Balance"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trial Balance by Period"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action10(Action 10)".

        addfirst("P&osting")
        {
            action(Reconcile)
            {
                ApplicationArea = Basic;
                Caption = 'Reconcile';
                Image = Reconcile;
                ShortCutKey = 'Ctrl+F11';

                trigger OnAction()
                begin
                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", Rec.Name);
                    GLReconcile.SetGenJnlLine(GenJnlLine);
                    GLReconcile.Run;
                end;
            }
        }
        addafter("Recurring General Journal")
        {
            action("Close Income Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Close Income Statement';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Close Income Statement";
            }
        }
    }

    var
        GenJnlLine: Record "Gen. Journal Line";
        GLReconcile: Page Reconciliation;




    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GenJnlTemplateName <> '' THEN
      "Journal Template Name" := GenJnlTemplateName;
    SetupNewBatch;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetupNewBatch;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.OpenJnlBatch(Rec);
    ShowAllowPaymentExportForPaymentTemplate;
    // Doing this because if user is using web client then filters on REC are being removed
    // Since filter is removed we need to persist value for template
    // name and use it 'OnNewRecord'
    GenJnlTemplateName := "Journal Template Name";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GenJnlManagement.OpenJnlBatch(Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "DataCaption(PROCEDURE 1)".

    //procedure DataCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT CurrPage.LOOKUPMODE THEN
      IF GETFILTER("Journal Template Name") <> '' THEN BEGIN
        GenJnlTemplate.SETFILTER(Name,GETFILTER("Journal Template Name"));
        IF GenJnlTemplate.FINDSET THEN
          IF GenJnlTemplate.NEXT = 0 THEN
            EXIT(GenJnlTemplate.Name + ' ' + GenJnlTemplate.Description);
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT CurrPage.LOOKUPMODE THEN
      IF GETFILTER("Journal Template Name") <> '' THEN
        IF GETRANGEMIN("Journal Template Name") = GETRANGEMAX("Journal Template Name") THEN
          IF GenJnlTemplate.GET(GETRANGEMIN("Journal Template Name")) THEN
            EXIT(GenJnlTemplate.Name + ' ' + GenJnlTemplate.Description);
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
