#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186304 pageextension52186304 extends "Opportunity List"
{
    Caption = 'Opportunity List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Closed)
        {
            ApplicationArea = Basic;
        }
        modify("Creation Date")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company No.")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Sales Cycle Code")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Description")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Estimated Closing Date")
        {
            ApplicationArea = Basic;
        }
        modify("Estimated Value (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Calcd. Current Value (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Closed(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company No."(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Code"(Control 18)".

        modify(CurrSalesCycleStage)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Description"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Document Type"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Document No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Estimated Closing Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Estimated Value (LCY)"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calcd. Current Value (LCY)"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company Name"(Control 50)".

        modify(Control5)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Sales Cycle Code")
        {
            field("Current Sales Cycle Stage"; Rec."Current Sales Cycle Stage")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Log E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Postponed &Interactions")
        {
            ApplicationArea = Basic;
        }
        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 37)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Update)
        {
            ApplicationArea = Basic;
        }
        modify(Close)
        {
            ApplicationArea = Basic;
        }
        modify(CreateSalesQuote)
        {

            //Unsupported feature: Property Modification (Name) on "CreateSalesQuote(Action 34)".

            Caption = 'Assign Sales &Quote';
            ApplicationArea = Basic;
        }
        modify("Print Details")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 58)".


        //Unsupported feature: Property Deletion (Promoted) on ""Postponed &Interactions"(Action 58)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Postponed &Interactions"(Action 58)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Postponed &Interactions"(Action 58)".


        //Unsupported feature: Property Deletion (Scope) on ""Postponed &Interactions"(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 42)".

        // modify("Show Sales Quote")
        // {
        //     Visible = false;
        // }
        modify(ActionGroupCRM)
        {
            Visible = false;
        }
        modify(CRMGotoOpportunity)
        {
            Visible = false;
        }
        modify(CRMSynchronizeNow)
        {
            Visible = false;
        }
        modify(Coupling)
        {
            Visible = false;
        }
        modify(ManageCRMCoupling)
        {
            Visible = false;
        }
        modify(DeleteCRMCoupling)
        {
            Visible = false;
        }
        modify(ShowLog)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Update(Action 32)".


        //Unsupported feature: Property Deletion (Promoted) on "Update(Action 32)".


        //Unsupported feature: Property Deletion (Enabled) on "Update(Action 32)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Update(Action 32)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Update(Action 32)".


        //Unsupported feature: Property Deletion (Scope) on "Update(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Close(Action 33)".


        //Unsupported feature: Property Deletion (Promoted) on "Close(Action 33)".


        //Unsupported feature: Property Deletion (Enabled) on "Close(Action 33)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Close(Action 33)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Close(Action 33)".


        //Unsupported feature: Property Deletion (Scope) on "Close(Action 33)".

        modify("Activate First Stage")
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "CreateSalesQuote(Action 34).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateQuote;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        AssignQuote;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateSalesQuote(Action 34)".


        //Unsupported feature: Property Deletion (Promoted) on "CreateSalesQuote(Action 34)".


        //Unsupported feature: Property Deletion (Enabled) on "CreateSalesQuote(Action 34)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "CreateSalesQuote(Action 34)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateSalesQuote(Action 34)".


        //Unsupported feature: Property Deletion (Scope) on "CreateSalesQuote(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print Details"(Action 57)".

        modify("Create &Interaction")
        {
            Visible = false;
        }
        addafter(CreateSalesQuote)
        {
            // action("Show Sales Quote")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Show Sales Quote';
            //     Image = Quote;

            //     trigger OnAction()
            //     begin
            //         Rec.ShowSalesQuoteWithCheck;
            //     end;
            // }
            separator(Action56)
            {
            }
        }
        addafter(Functions)
        {
            action("&Create Opportunity")
            {
                ApplicationArea = Basic;
                Caption = '&Create Opportunity';
                Image = NewOpportunity;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TempOpp: Record Opportunity temporary;
                begin
                    TempOpp.CreateOppFromOpp(Rec);
                end;
            }
        }
    }

    var
        Cont: Record Contact;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        Campaign: Record Campaign;
        SegHeader: Record "Segment Header";

    var

        OpportunityEnable: Boolean;

        FunctionsEnable: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CALCFIELDS("Contact Name","Contact Company Name");
    OppNotStarted := Status = Status::"Not Started";
    OppInProgress := Status = Status::"In Progress";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CALCFIELDS("Contact Name","Contact Company Name");
    */
    //end;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    EXIT(RecordsFound);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    OpportunityEnable := RecordsFound;
    FunctionsEnable := RecordsFound;
    EXIT(RecordsFound);
    */
    //end;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    FunctionsEnable := TRUE;
    OpportunityEnable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.EDITABLE := TRUE;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.EDITABLE := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "Caption(PROCEDURE 1)".

    //procedure Caption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE TRUE OF
      BuildCaptionContact(CaptionStr,GETFILTER("Contact Company No.")),
      BuildCaptionContact(CaptionStr,GETFILTER("Contact No.")),
      BuildCaptionSalespersonPurchaser(CaptionStr,GETFILTER("Salesperson Code")),
      BuildCaptionCampaign(CaptionStr,GETFILTER("Campaign No.")),
      BuildCaptionSegmentHeader(CaptionStr,GETFILTER("Segment No.")):
        EXIT(CaptionStr)
    END;

    EXIT(Text001);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Cont.GET(GETFILTER("Contact Company No.")) THEN
      CaptionStr := COPYSTR(Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    IF Cont.GET(GETFILTER("Contact No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + SalesPurchPerson.Code + ' ' + SalesPurchPerson.Name,1,MAXSTRLEN(CaptionStr));
    IF Campaign.GET(GETFILTER("Campaign No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Campaign."No." + ' ' + Campaign.Description,1,MAXSTRLEN(CaptionStr));
    IF SegHeader.GET(GETFILTER("Segment No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + SegHeader."No." + ' ' + SegHeader.Description,1,MAXSTRLEN(CaptionStr));
    IF CaptionStr = '' THEN
      CaptionStr := Text001;

    EXIT(CaptionStr);
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
