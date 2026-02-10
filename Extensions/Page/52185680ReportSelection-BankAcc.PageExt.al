#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185680 pageextension52185680 extends "Report Selection - Bank Acc." 
{
    Caption = 'Report Selection - Bank Acc.';
    layout
    {
        modify(ReportUsage2)
        {
            ApplicationArea = Basic;
        }
        modify(Sequence)
        {
            ApplicationArea = Basic;
        }
        modify("Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Report Caption")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ReportUsage2(Control 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SetUsageFilter(TRUE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SetUsageFilter;
            ReportUsage2OnAfterValidate;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ReportUsage2(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Sequence(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report ID"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Caption"(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetUsageFilter(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetUsageFilter;
        */
    //end;


    //Unsupported feature: Code Modification on "SetUsageFilter(PROCEDURE 1)".

    //procedure SetUsageFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ModifyRec THEN
          IF MODIFY THEN;
        FILTERGROUP(2);
        CASE ReportUsage2 OF
          ReportUsage2::Statement:
            SETRANGE(Usage,Usage::"B.Stmt");
          ReportUsage2::"Reconciliation - Test":
            SETRANGE(Usage,Usage::"B.Recon.Test");
          ReportUsage2::Check:
            SETRANGE(Usage,Usage::"B.Check");
        END;
        FILTERGROUP(0);
        CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        FILTERGROUP(2);
        SETRANGE(Usage,Usage::"B.Stmt" + ReportUsage2);
        FILTERGROUP(0);
        */
    //end;

    local procedure ReportUsage2OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "SetUsageFilter(PROCEDURE 1).ModifyRec(Parameter 1000)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
