#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185937 pageextension52185937 extends "VAT Report" 
{
    Caption = 'VAT Report';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        // modify("VAT Report Version")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""VAT Report Version"(Control 4)".


        //     //Unsupported feature: Property Modification (Name) on ""VAT Report Version"(Control 4)".

        // }
        // modify(Status)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Start Date")
        {

            //Unsupported feature: Property Modification (Level) on ""Start Date"(Control 8)".

            ApplicationArea = Basic;
        }
        modify("End Date")
        {

            //Unsupported feature: Property Modification (Level) on ""End Date"(Control 10)".

            ApplicationArea = Basic;
        }
        modify(ReturnPeriodDueDate)
        {

            //Unsupported feature: Property Modification (Name) on "ReturnPeriodDueDate(Control 6)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "ReturnPeriodDueDate(Control 6)".

        }

        //Unsupported feature: Property Modification (SubPageLink) on "VATReportLines(Control 13)".


        //Unsupported feature: Property Modification (PagePartID) on "VATReportLines(Control 13)".


        //Unsupported feature: Property Deletion (Editable) on "General(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".

        modify("VAT Report Version")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""VAT Report Version"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Report Version"(Control 4)".


        //Unsupported feature: Property Deletion (NotBlank) on ""VAT Report Version"(Control 4)".


        //Unsupported feature: Property Deletion (Editable) on ""VAT Report Version"(Control 4)".

        modify(Status)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 14)".


        //Unsupported feature: Property Deletion (Editable) on "Status(Control 14)".

        modify("Amounts in Add. Rep. Currency")
        {
            Visible = false;
        }
        modify("Additional Information")
        {
            Visible = false;
        }
        modify("Created Date-Time")
        {
            Visible = false;
        }
        modify(Control23)
        {
            Visible = false;
        }
        modify("Period Year")
        {
            Visible = false;
        }
        modify("Period Type")
        {
            Visible = false;
        }
        modify("Period No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Date"(Control 8)".


        //Unsupported feature: Property Deletion (Importance) on ""Start Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""End Date"(Control 10)".


        //Unsupported feature: Property Deletion (Importance) on ""End Date"(Control 10)".

        modify("Return Period")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on "ReturnPeriodDueDate(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReturnPeriodDueDate(Control 6)".

        modify(ReturnPeriodStatus)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on "VATReportLines(Control 13)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "VATReportLines(Control 13)".


        //Unsupported feature: Property Deletion (PartType) on "VATReportLines(Control 13)".

        modify(ErrorMessagesPart)
        {
            Visible = false;
        }
        addafter(ReturnPeriodDueDate)
        {
            field("Original Report No.";Rec."Original Report No.")
            {
                ApplicationArea = Basic;
            }
        }
        // moveafter("VAT Report Config. Code";ReturnPeriodDueDate)
        // moveafter("VAT Report Type";"Start Date")
    }
    actions
    {
        modify(SuggestLines)
        {
            Caption = '&Suggest Lines';
            ApplicationArea = Basic;
        }
        modify(Submit)
        {

            //Unsupported feature: Property Modification (Name) on "Submit(Action 27)".

            Caption = '&Export';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "Submit(Action 27)".

        }
        modify("Mark as Submitted")
        {

            //Unsupported feature: Property Modification (Name) on ""Mark as Submitted"(Action 19)".

            Caption = 'Mark as Su&bmitted';
            ApplicationArea = Basic;
        }
        modify(Reopen)
        {

            //Unsupported feature: Property Modification (Name) on "Reopen(Action 25)".

            Caption = 'Re&open';
            ApplicationArea = Basic;
        }
        modify(Print)
        {

            //Unsupported feature: Property Modification (Name) on "Print(Action 33)".

            Caption = '&Print';
            ApplicationArea = Basic;
        }
        modify("Open VAT Return Period Card")
        {

            //Unsupported feature: Property Modification (Level) on ""Open VAT Return Period Card"(Action 24)".


            //Unsupported feature: Property Modification (Name) on ""Open VAT Return Period Card"(Action 24)".

            Caption = '&Release';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Open VAT Return Period Card"(Action 24)".

            ShortCutKey = 'Ctrl+F9';

            //Unsupported feature: Property Insertion (Promoted) on ""Open VAT Return Period Card"(Action 24)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Open VAT Return Period Card"(Action 24)".

        }


        //Unsupported feature: Code Modification on "SuggestLines(Action 22).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VATReportMediator.GetLines(Rec);
            CurrPage.VATReportLines.PAGE.SelectFirst;
            CheckForErrors;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            VATReportMediator.GetLines(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SuggestLines(Action 22)".


        //Unsupported feature: Property Deletion (Enabled) on "SuggestLines(Action 22)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SuggestLines(Action 22)".

        modify(Release)
        {
            Visible = false;
        }
        modify(Generate)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "Submit(Action 27).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VATReportMediator.Export(Rec);
            IF NOT CheckForErrors THEN
              MESSAGE(ReportSubmittedMsg);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            VATReportMediator.Export(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Submit(Action 27)".


        //Unsupported feature: Property Deletion (Visible) on "Submit(Action 27)".


        //Unsupported feature: Property Deletion (Enabled) on "Submit(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Submit(Action 27)".

        modify("Receive Response")
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on ""Mark as Submitted"(Action 19).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VATReportMediator.Submit(Rec);
            IF NOT CheckForErrors THEN
              MESSAGE(MarkAsSubmittedMsg);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            VATReportMediator.Submit(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Mark as Submitted"(Action 19)".


        //Unsupported feature: Property Deletion (Enabled) on ""Mark as Submitted"(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Mark as Submitted"(Action 19)".

        modify("Cancel Submission")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 25)".


        //Unsupported feature: Property Deletion (Enabled) on "Reopen(Action 25)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reopen(Action 25)".

        modify("Download Submission Message")
        {
            Visible = false;
        }
        modify("Download Response Message")
        {
            Visible = false;
        }
        modify("Calc. and Post VAT Settlement")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 33)".


        //Unsupported feature: Property Deletion (Visible) on "Print(Action 33)".

        modify("Report Setup")
        {
            Visible = false;
        }
        // modify(ActionContainer18)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Modification on ""Open VAT Return Period Card"(Action 24).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            VATReportMgt.OpenVATPeriodCardFromVATReturn(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            VATReportMediator.Release(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Open VAT Return Period Card"(Action 24)".


        //Unsupported feature: Property Deletion (Visible) on ""Open VAT Return Period Card"(Action 24)".

        addafter(SuggestLines)
        {
            separator(Action23)
            {
            }
        }
        addafter(Reopen)
        {
            separator(Action26)
            {
            }
        }
        // moveafter(SuggestLines;"Open VAT Return Period Card")
        // moveafter("&Release";"Mark as Submitted")
    }

    //Unsupported feature: Property Deletion (LinksAllowed).


    //Unsupported feature: Property Deletion (DataCaptionExpr).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
