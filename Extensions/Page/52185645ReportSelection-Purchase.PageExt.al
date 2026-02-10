#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185645 pageextension52185645 extends "Report Selection - Purchase" 
{
    layout
    {
        modify(ReportUsage2)
        {
            OptionCaption = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Receipt,Return Shipment,Purchase Document - Test,Prepayment Document - Test,P.Arch. Quote,P.Arch. Order,P. Arch. Return Order';
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


    //Unsupported feature: Property Modification (OptionString) on "ReportUsage2(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Return Order","Credit Memo",Receipt,"Return Shipment","Purchase Document - Test","Prepayment Document - Test","Archived Quote","Archived Order","Archived Return Order","Archived Blanket Order","Vendor Remittance","Vendor Remittance - Posted Entries";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Return Order","Credit Memo",Receipt,"Return Shipment","Purchase Document - Test","Prepayment Document - Test","P.Arch. Quote","P.Arch. Order","P. Arch. Return Order";
        //Variable type has not been exported.


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
          ReportUsage2::Quote:
            SETRANGE(Usage,Usage::"P.Quote");
          ReportUsage2::"Blanket Order":
            SETRANGE(Usage,Usage::"P.Blanket");
          ReportUsage2::Order:
            SETRANGE(Usage,Usage::"P.Order");
          ReportUsage2::Invoice:
            SETRANGE(Usage,Usage::"P.Invoice");
          ReportUsage2::"Return Order":
            SETRANGE(Usage,Usage::"P.Return");
          ReportUsage2::"Credit Memo":
            SETRANGE(Usage,Usage::"P.Cr.Memo");
          ReportUsage2::Receipt:
            SETRANGE(Usage,Usage::"P.Receipt");
          ReportUsage2::"Return Shipment":
            SETRANGE(Usage,Usage::"P.Ret.Shpt.");
          ReportUsage2::"Purchase Document - Test":
            SETRANGE(Usage,Usage::"P.Test");
          ReportUsage2::"Prepayment Document - Test":
            SETRANGE(Usage,Usage::"P.Test Prepmt.");
          ReportUsage2::"Archived Quote":
            SETRANGE(Usage,Usage::"P.Arch.Quote");
          ReportUsage2::"Archived Order":
            SETRANGE(Usage,Usage::"P.Arch.Order");
          ReportUsage2::"Archived Return Order":
            SETRANGE(Usage,Usage::"P.Arch.Return");
          ReportUsage2::"Archived Blanket Order":
            SETRANGE(Usage,Usage::"P.Arch.Blanket");
          ReportUsage2::"Vendor Remittance":
            SETRANGE(Usage,Usage::"V.Remittance");
          ReportUsage2::"Vendor Remittance - Posted Entries":
            SETRANGE(Usage,Usage::"P.V.Remit.");
        END;
        FILTERGROUP(0);
        CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..24
          ReportUsage2::"P.Arch. Quote":
            SETRANGE(Usage,Usage::"P.Arch. Quote");
          ReportUsage2::"P.Arch. Order":
            SETRANGE(Usage,Usage::"P.Arch. Order");
          ReportUsage2::"P. Arch. Return Order":
            SETRANGE(Usage,Usage::"P. Arch. Return Order");
        END;
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
