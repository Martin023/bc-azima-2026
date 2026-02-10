#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186587 pageextension52186587 extends "Inventory - G/L Reconciliation"
{
    layout
    {
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ItemFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LocationFilter)
        {
            ApplicationArea = Basic;
        }
        modify(Show)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemFilter(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LocationFilter(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Show(Control 4)".

    }
    actions
    {
        modify("&Show Matrix")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""&Show Matrix"(Action 19)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Show Matrix"(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""&Show Matrix"(Action 19)".

    }

    //Unsupported feature: Property Modification (Id) on ""MATRIX_CaptionSet"(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //"MATRIX_CaptionSet" : 1004;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"MATRIX_CaptionSet" : 1159;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1004)".

    //var
    //>>>> ORIGINAL VALUE:
    //"MATRIX_CaptionSet" : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"MATRIX_CaptionSet" : 1024;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on ""MATRIX_CurrentNoOfColumns"(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //"MATRIX_CurrentNoOfColumns" : 1003;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"MATRIX_CurrentNoOfColumns" : 1165;
    //Variable type has not been exported.

    var
        PeriodInitialized: Boolean;

    var
        Text006: label 'Expected Cost Setup';
        Text007: label 'Post Cost to G/L';
        Text008: label 'Compression';
        Text009: label 'Posting Group';
        Text010: label 'Direct Posting';
        Text011: label 'Posting Date';
        Text012: label 'Closed Fiscal Year';
        Text013: label 'Similar Accounts';
        Text014: label 'Deleted Accounts';
        CostPostingNotSelectedTxt: label 'Expected Cost Posting to G/L is not selected in the Inventory Setup window. Therefore, inventory interim G/L accounts are empty and this causes a difference between inventory and G/L totals.';
        CostAmountsNotPostedYetTxt: label 'Some of the cost amounts in the inventory ledger have not yet been posted to the general ledger. You must run the Post Inventory Cost to G/L batch job to reconcile the ledgers.';
        EntriesCompressedTxt: label 'Some inventory or G/L entries have been date compressed.';
        ReassigningAccountsTxt: label 'You may have restructured your chart of accounts by reassigning inventory related accounts in the General or Inventory Posting Setup.';
        PostedDirectlyToGLAccountTxt: label 'Some inventory costs have been posted directly to a G/L account, bypassing the inventory subledger.';
        Text021: label 'There is a discrepancy between the posting date of the value entry and the associated G/L entry within the reporting period.';
        PostedInClosedFiscalYearTxt: label 'Some of the cost amounts are posted in a closed fiscal year. Therefore, the inventory-related totals are different from their related G/L accounts in the income statement.';
        Text023: label 'You have possibly defined one G/L account for different inventory transactions.';
        DeletingAccountsTxt: label 'You may have restructured your chart of accounts by deleting one or more inventory related G/L accounts.';


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLSetup.GET;
    TestWarning;
    InvtReportHeader.SETFILTER("Item Filter",ItemFilter);
    #4..10
    END;
    InvtReportHeader."Line Option" := DimCodeToOption(LineDimCode);
    InvtReportHeader."Column Option" := DimCodeToOption(ColumnDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13

    PeriodInitialized := DateFilter <> '';
    */
    //end;

    local procedure MATRIX_GenerateColumnCaptions(Step: Option First,Previous,Same,Next)
    begin
    end;

    local procedure GetWarningText(TheField: Text[30]; ShowType: Option ReturnAsText,ShowAsMessage): Text[250]
    var
        InvtReportEntry: Record "Inventory Report Entry";

    begin
        with InvtReportEntry do begin
            if "Expected Cost Posting Warning" then
               // if TheField in [Rec.FieldCaption("Inventory (Interim)"),
               //                 Rec.FieldCaption("Invt. Accrual (Interim)"),
               //                 Rec.FieldCaption("COGS (Interim)"),
               //                 Rec.FieldCaption("Invt. Accrual (Interim)"),
               //                 Rec.FieldCaption("WIP Inventory")]
               begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text006);
                exit(CostPostingNotSelectedTxt);
            end;
            if "Cost is Posted to G/L Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text007);
                exit(CostAmountsNotPostedYetTxt);
            end;
            if "Compression Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text008);
                exit(EntriesCompressedTxt);
            end;
            if "Posting Group Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text009);
                exit(ReassigningAccountsTxt);
            end;
            if "Direct Postings Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text010);
                exit(PostedDirectlyToGLAccountTxt);
            end;
            if "Posting Date Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text011);
                exit(Text021);
            end;
            if "Closing Period Overlap Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text012);
                exit(PostedInClosedFiscalYearTxt);
            end;
            if "Similar Accounts Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text013);
                exit(Text023);
            end;
            if "Deleted G/L Accounts Warning" then begin
                if ShowType = Showtype::ReturnAsText then
                    exit(Text014);
                exit(DeletingAccountsTxt);
            end;
        end;
    end;

    local procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        SourceTableName: Text[100];
        LocationTableName: Text[100];
    begin
        //     SourceTableName := '';
        //     LocationTableName := '';
        //     if ItemFilter <> '' then
        //       SourceTableName := ObjTransl.TranslateObject(ObjTransl."object type"::Table,27);
        //     if LocationFilter <> '' then
        //       LocationTableName := ObjTransl.TranslateObject(ObjTransl."object type"::Table,14);

        //     exit(StrSubstNo('%1 %2 %3 %4',SourceTableName,ItemFilter,LocationTableName,LocationFilter));
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
