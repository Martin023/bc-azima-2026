#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185624 pageextension52185624 extends "Report Selection - Sales" 
{
    layout
    {
        modify(ReportUsage)
        {
            OptionCaption = 'Quote,Blanket Order,Order,Invoice,Work Order,Return Order,Credit Memo,Shipment,Return Receipt,Sales Document - Test,Prepayment Document - Test,S.Arch. Quote,S.Arch. Order,S. Arch. Return Order,Pick Instruction,Customer Statement';
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

        //Unsupported feature: Code Modification on "ReportUsage(Control 11).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "ReportUsage(Control 11)".


        //Unsupported feature: Property Deletion (FreezeColumnID) on "Control1(Control 1)".


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
        //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Work Order","Return Order","Credit Memo",Shipment,"Return Receipt","Sales Document - Test","Prepayment Document - Test","Archived Quote","Archived Order","Archived Return Order","Pick Instruction","Customer Statement","Draft Invoice","Pro Forma Invoice","Archived Blanket Order";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Work Order","Return Order","Credit Memo",Shipment,"Return Receipt","Sales Document - Test","Prepayment Document - Test","S.Arch. Quote","S.Arch. Order","S. Arch. Return Order","Pick Instruction","Customer Statement";
        //Variable type has not been exported.


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
          ReportUsage2::Quote:
            SETRANGE(Usage,Usage::"S.Quote");
          ReportUsage2::"Blanket Order":
            SETRANGE(Usage,Usage::"S.Blanket");
          ReportUsage2::Order:
            SETRANGE(Usage,Usage::"S.Order");
          ReportUsage2::"Work Order":
            SETRANGE(Usage,Usage::"S.Work Order");
          ReportUsage2::"Pick Instruction":
            SETRANGE(Usage,Usage::"S.Order Pick Instruction");
          ReportUsage2::Invoice:
            SETRANGE(Usage,Usage::"S.Invoice");
          ReportUsage2::"Draft Invoice":
            SETRANGE(Usage,Usage::"S.Invoice Draft");
          ReportUsage2::"Return Order":
            SETRANGE(Usage,Usage::"S.Return");
          ReportUsage2::"Credit Memo":
            SETRANGE(Usage,Usage::"S.Cr.Memo");
          ReportUsage2::Shipment:
            SETRANGE(Usage,Usage::"S.Shipment");
          ReportUsage2::"Return Receipt":
            SETRANGE(Usage,Usage::"S.Ret.Rcpt.");
          ReportUsage2::"Sales Document - Test":
            SETRANGE(Usage,Usage::"S.Test");
          ReportUsage2::"Prepayment Document - Test":
            SETRANGE(Usage,Usage::"S.Test Prepmt.");
          ReportUsage2::"Archived Quote":
            SETRANGE(Usage,Usage::"S.Arch.Quote");
          ReportUsage2::"Archived Order":
            SETRANGE(Usage,Usage::"S.Arch.Order");
          ReportUsage2::"Archived Return Order":
            SETRANGE(Usage,Usage::"S.Arch.Return");
          ReportUsage2::"Customer Statement":
            SETRANGE(Usage,Usage::"C.Statement");
          ReportUsage2::"Pro Forma Invoice":
            SETRANGE(Usage,Usage::"Pro Forma S. Invoice");
          ReportUsage2::"Archived Blanket Order":
            SETRANGE(Usage,Usage::"S.Arch.Blanket");
        END;
        FILTERGROUP(0);
        CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..16
        #19..30
          ReportUsage2::"S.Arch. Quote":
            SETRANGE(Usage,Usage::"S.Arch. Quote");
          ReportUsage2::"S.Arch. Order":
            SETRANGE(Usage,Usage::"S.Arch. Order");
          ReportUsage2::"S. Arch. Return Order":
            SETRANGE(Usage,Usage::"S. Arch. Return Order");
          ReportUsage2::"Customer Statement":
            SETRANGE(Usage,Usage::"C.Statement");
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
