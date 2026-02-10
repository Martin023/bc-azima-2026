#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186077 pageextension52186077 extends "Job Invoices" 
{
    layout
    {
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Transferred")
        {
            ApplicationArea = Basic;
        }
        modify("Transferred Date")
        {
            ApplicationArea = Basic;
        }
        modify("Invoiced Date")
        {
            ApplicationArea = Basic;
        }
        modify("Invoiced Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Invoiced Cost Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Job Ledger Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Transferred"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transferred Date"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoiced Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoiced Amount (LCY)"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoiced Cost Amount (LCY)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Ledger Entry No."(Control 11)".

    }
    actions
    {
        modify(OpenSalesInvoiceCreditMemo)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "OpenSalesInvoiceCreditMemo(Action 14)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetPrJob(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "SetPrJob(PROCEDURE 1)".

    //procedure SetPrJob();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DetailLevel := DetailLevel::"Per Job";
        JobNo := Job."No.";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DetailLevel := DetailLevel::"Per Job";
        JobNo := Job."No.";
        ShowDetails := FALSE;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetPrJobTask(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetPrJobTask(PROCEDURE 2)".

    //procedure SetPrJobTask();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DetailLevel := DetailLevel::"Per Job Task";
        JobNo := JobTask."Job No.";
        JobTaskNo := JobTask."Job Task No.";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        ShowDetails := FALSE;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetPrJobPlanningLine(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetPrJobPlanningLine(PROCEDURE 3)".

    //procedure SetPrJobPlanningLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DetailLevel := DetailLevel::"Per Job Planning Line";
        JobNo := JobPlanningLine."Job No.";
        JobTaskNo := JobPlanningLine."Job Task No.";
        JobPlanningLineNo := JobPlanningLine."Line No.";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        ShowDetails := FALSE;
        */
    //end;
}
