#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185478 pageextension52185478 extends "Job List"
{
    Caption = 'Job List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Person Responsible")
        {
            ApplicationArea = Basic;
        }
        modify("Next Invoice Date")
        {
            ApplicationArea = Basic;
        }
        modify("Job Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Search Description")
        {
            ApplicationArea = Basic;
        }
        modify("% of Overdue Planning Lines")
        {
            ApplicationArea = Basic;
        }
        modify("% Completed")
        {
            ApplicationArea = Basic;
        }
        modify("% Invoiced")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1905650007(Control 1905650007)".


        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Person Responsible"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Invoice Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Posting Group"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Description"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""% of Overdue Planning Lines"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""% Completed"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""% Invoiced"(Control 15)".

        modify("Project Manager")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907234507(Control 1907234507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905650007(Control 1905650007)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Job Task &Lines")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Job Task &Lines"(Action 37)".

        }
        modify("Dimensions-&Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify("&Statistics")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Statistics"(Action 33)".

        }
        modify(SalesInvoicesCreditMemos)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "SalesInvoicesCreditMemos(Action 14)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("&WIP Entries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageView) on ""&WIP Entries"(Action 153)".

        }
        modify("WIP &G/L Entries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageView) on ""WIP &G/L Entries"(Action 154)".

        }
        modify("&Resource")
        {
            ApplicationArea = Basic;
        }
        modify("&Item")
        {
            ApplicationArea = Basic;
        }
        modify("&G/L Account")
        {
            ApplicationArea = Basic;
        }
        modify("Resource &Allocated per Job")
        {
            ApplicationArea = Basic;
        }
        modify("Res. Group All&ocated per Job")
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageView) on ""Ledger E&ntries"(Action 32)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 32)".

        }
        modify(CopyJob)
        {
            ApplicationArea = Basic;
        }
        modify("Create Job &Sales Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Create Job &Sales Invoice"(Action 1903691404)".

        }
        modify("<Action151>")
        {
            ApplicationArea = Basic;
        }
        modify("<Action152>")
        {
            ApplicationArea = Basic;
        }
        // modify("Job Actual to Budget")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Job Analysis")
        {
            ApplicationArea = Basic;
        }
        modify("Job - Planning Lines")
        {
            ApplicationArea = Basic;
        }
        // modify("Job - Suggested Billing")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Jobs per Customer")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Items per Job")
        {
            ApplicationArea = Basic;
        }
        modify("Jobs per Item")
        {
            ApplicationArea = Basic;
        }
        modify("Job WIP to G/L")
        {
            ApplicationArea = Basic;
        }
        // modify("Jobs - Transaction Detail")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Job Register")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task &Lines"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Single"(Action 84)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-&Single"(Action 84)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-&Single"(Action 84)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Job);
        DefaultDimensionsMultiple.SetMultiRecord(Job,FIELDNO("No."));
        DefaultDimensionsMultiple.RUNMODAL;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Job);
        DefaultDimMultiple.SetMultiJob(Job);
        DefaultDimMultiple.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 12)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-&Multiple"(Action 12)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-&Multiple"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Statistics"(Action 33)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""&Statistics"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesInvoicesCreditMemos(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 34)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 34)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&WIP Entries"(Action 153)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WIP &G/L Entries"(Action 154)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Resource"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Item"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&G/L Account"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource &Allocated per Job"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Res. Group All&ocated per Job"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 32)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Ledger E&ntries"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyJob(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Job &Sales Invoice"(Action 1903691404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action151>"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action152>"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Actual to Budget"(Action 1903776506)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Analysis"(Action 1901542506)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job - Planning Lines"(Action 1902943106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job - Suggested Billing"(Action 1903186006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Jobs per Customer"(Action 1900510006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Items per Job"(Action 1905887906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Jobs per Item"(Action 1906922906)".

        modify("Report Job Quote")
        {
            Visible = false;
        }
        modify("Send Job Quote")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Job WIP to G/L"(Action 1907574906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Jobs - Transaction Detail"(Action 1905285006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Register"(Action 1901294206)".

    }

    var
        DefaultDimMultiple: Page "Default Dimensions-Multiple";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
