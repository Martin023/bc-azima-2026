#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186231 pageextension52186231 extends "Deferral Schedule" 
{
    layout
    {
        modify("Amount to Defer")
        {
            ApplicationArea = Basic;
        }
        modify("Calc. Method")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Periods")
        {
            ApplicationArea = Basic;
        }
        modify("Start Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount to Defer"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. Method"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Periods"(Control 6)".

        modify(PostingDate)
        {
            Visible = false;
        }
        modify(StartDateCalcMethod)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Date"(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "DeferralSheduleSubform(Control 7)".

        moveafter("Calc. Method";"Start Date")
    }
    actions
    {
        modify(CalculateSchedule)
        {

            //Unsupported feature: Property Modification (Name) on "CalculateSchedule(Action 10)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CalculateSchedule(Action 10)".

    }

    //Unsupported feature: Property Modification (TextConstString) on "PostingDateErr(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //PostingDateErr : ENU=You cannot specify a posting date that is not equal to the start date.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PostingDateErr : ENU=The earliest Posting Date of the deferral schedule must equal the Start Date.;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        // Prevent closing of the window if the sum of the periods does not equal the Amount to Defer
        IF DeferralHeader.GET("Deferral Doc. Type",
             "Gen. Jnl. Template Name",
        #4..15
        DeferralLine.SETRANGE("Document Type","Document Type");
        DeferralLine.SETRANGE("Document No.","Document No.");
        DeferralLine.SETRANGE("Line No.","Line No.");

        RecCount := DeferralLine.COUNT;
        ExpectedCount := DeferralUtilities.CalcDeferralNoOfPeriods("Calc. Method","No. of Periods","Start Date");
        IF ExpectedCount <> RecCount THEN
          FIELDERROR("No. of Periods");

        DeferralLine.SETFILTER("Posting Date",'>%1',0D);
        IF DeferralLine.FINDFIRST THEN BEGIN
          EarliestPostingDate := DeferralLine."Posting Date";
          IF EarliestPostingDate <> DeferralHeader."Start Date" THEN
            ERROR(PostingDateErr);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        #25..30
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetParameter(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "InitForm(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "InitForm(PROCEDURE 3)".

    //procedure InitForm();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GET(DisplayDeferralDocType,DisplayGenJnlTemplateName,DisplayGenJnlBatchName,DisplayDocumentType,DisplayDocumentNo,DisplayLineNo);

        DeferralTemplate.GET("Deferral Code");
        StartDateCalcMethod := FORMAT(DeferralTemplate."Start Date");
        CASE DisplayDeferralDocType OF
          "Deferral Doc. Type"::"G/L":
            BEGIN
              GenJournalLine.GET(DisplayGenJnlTemplateName,DisplayGenJnlBatchName,DisplayLineNo);
              PostingDate := GenJournalLine."Posting Date";
            END;
          "Deferral Doc. Type"::Sales:
            BEGIN
              SalesHeader.GET(DisplayDocumentType,DisplayDocumentNo);
              PostingDate := SalesHeader."Posting Date";
            END;
          "Deferral Doc. Type"::Purchase:
            BEGIN
              PurchaseHeader.GET(DisplayDocumentType,DisplayDocumentNo);
              PostingDate := PurchaseHeader."Posting Date";
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GET(DisplayDeferralDocType,DisplayGenJnlTemplateName,DisplayGenJnlBatchName,DisplayDocumentType,DisplayDocumentNo,DisplayLineNo);
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "InitForm(PROCEDURE 3).DeferralTemplate(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "InitForm(PROCEDURE 3).GenJournalLine(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "InitForm(PROCEDURE 3).PurchaseHeader(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "InitForm(PROCEDURE 3).SalesHeader(Variable 1003)".

}
