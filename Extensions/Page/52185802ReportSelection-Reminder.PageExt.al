#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185802 pageextension52185802 extends "Report Selection - Reminder" 
{
    Caption = 'Report Selection - Reminder';
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

        modify("Use for Email Body")
        {
            Visible = false;
        }
        modify("Use for Email Attachment")
        {
            Visible = false;
        }
        modify("Email Body Layout Code")
        {
            Visible = false;
        }
        modify("Email Body Layout Description")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        InitUsageFilter;
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
          ReportUsage2::Reminder:
        #6..11
            SETRANGE(Usage,Usage::"F.C.Test");
        END;
        FILTERGROUP(0);
        CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..14
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
