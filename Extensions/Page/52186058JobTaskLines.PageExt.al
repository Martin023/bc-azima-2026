#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186058 pageextension52186058 extends "Job Task Lines" 
{
    layout
    {
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Task No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Job Task Type")
        {
            ApplicationArea = Basic;
        }
        modify(Totaling)
        {
            ApplicationArea = Basic;
        }
        modify("Job Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("WIP-Total")
        {
            ApplicationArea = Basic;
        }
        modify("WIP Method")
        {
            ApplicationArea = Basic;
        }
        modify("Start Date")
        {
            ApplicationArea = Basic;
        }
        modify("End Date")
        {
            ApplicationArea = Basic;
        }
        modify("Schedule (Total Cost)")
        {
            ApplicationArea = Basic;
        }
        modify("Schedule (Total Price)")
        {
            ApplicationArea = Basic;
        }
        modify("Usage (Total Cost)")
        {
            ApplicationArea = Basic;
        }
        modify("Usage (Total Price)")
        {
            ApplicationArea = Basic;
        }
        modify("Contract (Total Cost)")
        {
            ApplicationArea = Basic;
        }
        modify("Contract (Total Price)")
        {
            ApplicationArea = Basic;
        }
        modify("Contract (Invoiced Cost)")
        {
            ApplicationArea = Basic;
        }
        modify("Contract (Invoiced Price)")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining (Total Cost)")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining (Total Price)")
        {
            ApplicationArea = Basic;
        }
        modify("EAC (Total Cost)")
        {
            ApplicationArea = Basic;
        }
        modify("EAC (Total Price)")
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
        modify("Outstanding Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Amt. Rcd. Not Invoiced")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task Type"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Totaling(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Posting Group"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WIP-Total"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WIP Method"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Date"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""End Date"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Schedule (Total Cost)"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Schedule (Total Price)"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Usage (Total Cost)"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Usage (Total Price)"(Control 8)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Contract (Total Cost)"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract (Total Cost)"(Control 12)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Contract (Total Price)"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract (Total Price)"(Control 47)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Contract (Invoiced Cost)"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract (Invoiced Cost)"(Control 37)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Contract (Invoiced Price)"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract (Invoiced Price)"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining (Total Cost)"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining (Total Price)"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EAC (Total Cost)"(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EAC (Total Price)"(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 69)".


        //Unsupported feature: Code Modification on ""Outstanding Orders"(Control 1000).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SetPurchLineFilters(PurchLine,"Job No.","Job Task No.");
            PurchLine.SETFILTER("Outstanding Amt. Ex. VAT (LCY)",'<> 0');
            PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetPurchLineFilters(PurchLine);
            PurchLine.SETFILTER("Outstanding Amount (LCY)",'<> 0');
            PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Outstanding Orders"(Control 1000)".



        //Unsupported feature: Code Modification on ""Amt. Rcd. Not Invoiced"(Control 1002).OnDrillDown".

        //trigger  Rcd()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SetPurchLineFilters(PurchLine,"Job No.","Job Task No.");
            PurchLine.SETFILTER("Amt. Rcd. Not Invoiced (LCY)",'<> 0');
            PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetPurchLineFilters(PurchLine);
            PurchLine.SETFILTER("Amt. Rcd. Not Invoiced (LCY)",'<> 0');
            PAGE.RUNMODAL(PAGE::"Purchase Lines",PurchLine);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Amt. Rcd. Not Invoiced"(Control 1002)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(JobPlanningLines)
        {
            ApplicationArea = Basic;
        }
        modify(JobTaskStatistics)
        {
            ApplicationArea = Basic;
        }
        modify("Job &Task Card")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Invoices/Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("&WIP Entries")
        {
            ApplicationArea = Basic;
        }
        modify("WIP &G/L Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Job Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Create &Sales Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Create &Sales Invoice"(Action 15)".

        }
        modify("Split &Planning Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Change &Dates")
        {
            ApplicationArea = Basic;
        }
        modify("<Action7>")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Job Planning Lines &from...")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Job Planning Lines &to...")
        {
            ApplicationArea = Basic;
        }
        modify("<Action48>")
        {
            ApplicationArea = Basic;
        }
        modify("<Action49>")
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
        modify("Job - Suggested Billing")
        {
            ApplicationArea = Basic;
        }
        modify("Jobs - Transaction Detail")
        {
            ApplicationArea = Basic;
        }


        //Unsupported feature: Code Modification on "JobPlanningLines(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TESTFIELD("Job Task Type","Job Task Type"::Posting);
            TESTFIELD("Job No.");
            TESTFIELD("Job Task No.");
            JobPlanningLine.FILTERGROUP(2);
            JobPlanningLine.SETRANGE("Job No.","Job No.");
            JobPlanningLine.SETRANGE("Job Task No.","Job Task No.");
            JobPlanningLine.FILTERGROUP(0);
            JobPlanningLines.SetJobTaskNoVisible(FALSE);
            JobPlanningLines.SETTABLEVIEW(JobPlanningLine);
            JobPlanningLines.RUN;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            JobPlanningLine.SETRANGE("Job No.","Job No.");
            JobPlanningLine.SETRANGE("Job Task No.","Job Task No.");
            JobPlanningLines.SetJobNoVisible(FALSE);
            JobPlanningLines.SetJobTaskNoVisible(FALSE);
            JobPlanningLines.SetJobNo("Job No.");
            JobPlanningLines.SETTABLEVIEW(JobPlanningLine);
            JobPlanningLines.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "JobPlanningLines(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "JobTaskStatistics(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job &Task Card"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Single"(Action 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Invoices/Credit Memos"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&WIP Entries"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WIP &G/L Entries"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Ledger E&ntries"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Sales Invoice"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Split &Planning Lines"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change &Dates"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action7>"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Job Planning Lines &from..."(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Job Planning Lines &to..."(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action48>"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action49>"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Actual to Budget"(Action 1903776506)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Analysis"(Action 1901542506)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job - Planning Lines"(Action 1902943106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job - Suggested Billing"(Action 1903186006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Jobs - Transaction Detail"(Action 1905285006)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetPurchLineFilters(PROCEDURE 3)".


    //Unsupported feature: Property Insertion (Local) on "SetPurchLineFilters(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetPurchLineFilters(PROCEDURE 3)".

    //procedure SetPurchLineFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ApplyPurchaseLineFilters(PurchLine,JobNo,JobTaskNo);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PurchLine.SETCURRENTKEY("Document Type","Job No.","Job Task No.");
        PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Job No.","Job No.");
        IF "Job Task Type" IN ["Job Task Type"::Total,"Job Task Type"::"End-Total"] THEN
          PurchLine.SETFILTER("Job Task No.",Totaling)
        ELSE
          PurchLine.SETRANGE("Job Task No.","Job Task No.");
        */
    //end;

    //Unsupported feature: Deletion (ParameterCollection) on "SetPurchLineFilters(PROCEDURE 3).PurchLine(Parameter 1002)".


    //Unsupported feature: Property Modification (Name) on "SetPurchLineFilters(PROCEDURE 3).JobNo(Parameter 1000)".


    //Unsupported feature: Property Deletion (Length) on "SetPurchLineFilters(PROCEDURE 3).JobNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Data type) on "SetPurchLineFilters(PROCEDURE 3).JobNo(Parameter 1000)".


    //Unsupported feature: Property Insertion (AsVar) on "SetPurchLineFilters(PROCEDURE 3).JobNo(Parameter 1000)".


    //Unsupported feature: Property Insertion (Subtype) on "SetPurchLineFilters(PROCEDURE 3).JobNo(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "SetPurchLineFilters(PROCEDURE 3).JobTaskNo(Parameter 1001)".

}
