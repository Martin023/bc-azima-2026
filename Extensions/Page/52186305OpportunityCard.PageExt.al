#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186305 pageextension52186305 extends "Opportunity Card"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Opportunity Card"(Page 5124)".

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
        modify("Contact No.")
        {
            ApplicationArea = Basic;
            Editable = "Contact No.Editable";
        }
        modify("Contact Name")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company Name")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
            Editable = "Salesperson CodeEditable";
        }
        modify("Sales Document Type")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (ValuesAllowed) on ""Sales Document Type"(Control 40)".

            Editable = "Sales Document TypeEditable";
        }
        modify("Sales Document No.")
        {
            ApplicationArea = Basic;
            Editable = "Sales Document No.Editable";
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
            Editable = "Campaign No.Editable";
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Sales Cycle Code")
        {
            ApplicationArea = Basic;
            Editable = "Sales Cycle CodeEditable";
        }
        modify(Status)
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
        modify("Date Closed")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (Importance) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Code Modification on ""Contact No."(Control 8).OnValidate".

        //trigger "(Control 8)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Contact No." <> '' THEN
          IF Contact.GET("Contact No.") THEN
            Contact.CheckIfPrivacyBlockedGeneric;
        ContactNoOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ContactNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company Name"(Control 44)".


        //Unsupported feature: Property Deletion (Importance) on ""Contact Company Name"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Document Type"(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Sales Document Type"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Document No."(Control 30)".


        //Unsupported feature: Property Deletion (Importance) on ""Sales Document No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 12)".


        //Unsupported feature: Property Deletion (Importance) on ""Campaign No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on "Priority(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Closed(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on "Closed(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 14)".


        //Unsupported feature: Property Deletion (Importance) on ""Creation Date"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Closed"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Date Closed"(Control 22)".

        modify("Segment No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control25(Control 25)".


        //Unsupported feature: Property Deletion (PartType) on "Control25(Control 25)".

        modify(Control7)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 29)".

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

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 34)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Update)
        {
            ApplicationArea = Basic;
        }
        modify(CloseOpportunity)
        {

            //Unsupported feature: Property Modification (Name) on "CloseOpportunity(Action 32)".

            ApplicationArea = Basic;
        }
        modify(CreateSalesQuote)
        {

            //Unsupported feature: Property Modification (Name) on "CreateSalesQuote(Action 33)".

            Caption = 'Assign Sales &Quote';
            ApplicationArea = Basic;
        }
        modify("Print Details")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 49)".


        //Unsupported feature: Property Deletion (Promoted) on ""Interaction Log E&ntries"(Action 49)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Interaction Log E&ntries"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 50)".


        //Unsupported feature: Property Deletion (Promoted) on ""Postponed &Interactions"(Action 50)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Postponed &Interactions"(Action 50)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Postponed &Interactions"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 34)".


        //Unsupported feature: Property Deletion (Promoted) on ""T&asks"(Action 34)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""T&asks"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 37)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 37)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 37)".

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
        modify("Activate the First Stage")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Update(Action 31)".


        //Unsupported feature: Property Deletion (Promoted) on "Update(Action 31)".


        //Unsupported feature: Property Deletion (Visible) on "Update(Action 31)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Update(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CloseOpportunity(Action 32)".


        //Unsupported feature: Property Deletion (Promoted) on "CloseOpportunity(Action 32)".


        //Unsupported feature: Property Deletion (Visible) on "CloseOpportunity(Action 32)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CloseOpportunity(Action 32)".



        //Unsupported feature: Code Modification on "CreateSalesQuote(Action 33).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateSalesQuote(Action 33)".


        //Unsupported feature: Property Deletion (Promoted) on "CreateSalesQuote(Action 33)".


        //Unsupported feature: Property Deletion (Enabled) on "CreateSalesQuote(Action 33)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "CreateSalesQuote(Action 33)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateSalesQuote(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print Details"(Action 48)".

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
            //     var
            //         SalesHeader: Record "Sales Header";
            //     begin
            //         if (Rec."Sales Document Type" <> Rec."sales document type"::Quote) or
            //            (Rec."Sales Document No." = '')
            //         then
            //           Error(Text001);

            //         if SalesHeader.Get(SalesHeader."document type"::Quote,Rec."Sales Document No.") then
            //           Page.Run(Page::"Sales Quote",SalesHeader)
            //         else
            //           Error(Text002,Rec."Sales Document No.");
            //     end;
            // }
            separator(Action47)
            {
            }
        }
        addafter("F&unctions")
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

        "Sales Cycle CodeEditable": Boolean;

        "Sales Document No.Editable": Boolean;

        "Sales Document TypeEditable": Boolean;

        "Salesperson CodeEditable": Boolean;

        "Campaign No.Editable": Boolean;

    var

        "Contact No.Editable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Contact No." <> '' THEN
      IF Contact.GET("Contact No.") THEN
        Contact.CheckIfPrivacyBlockedGeneric;
    IF "Contact Company No." <> '' THEN
      IF Contact.GET("Contact Company No.") THEN
        Contact.CheckIfPrivacyBlockedGeneric;
    UpdateEditable;
    OppInProgress := Status = Status::"In Progress";
    OppNo := "No.";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateEditable;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ContactNoEditable := TRUE;
    PriorityEditable := TRUE;
    CampaignNoEditable := TRUE;
    SalespersonCodeEditable := TRUE;
    SalesDocumentTypeEditable := TRUE;
    SalesDocumentNoEditable := TRUE;
    SalesCycleCodeEditable := TRUE;
    Started := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Contact No.Editable" := TRUE;
    PriorityEditable := TRUE;
    "Campaign No.Editable" := TRUE;
    "Salesperson CodeEditable" := TRUE;
    "Sales Document TypeEditable" := TRUE;
    "Sales Document No.Editable" := TRUE;
    "Sales Cycle CodeEditable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateEditable(PROCEDURE 1)".

    //procedure UpdateEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Started := (Status <> Status::"Not Started");
    SalesCycleCodeEditable := Status = Status::"Not Started";
    SalespersonCodeEditable := Status < Status::Won;
    CampaignNoEditable := Status < Status::Won;
    PriorityEditable := Status < Status::Won;
    ContactNoEditable := Status < Status::Won;
    SalesDocumentNoEditable := Status = Status::"In Progress";
    SalesDocumentTypeEditable := Status = Status::"In Progress";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Sales Cycle CodeEditable" := Status = Status::"Not Started";
    "Salesperson CodeEditable" := Status < Status::Won;
    "Campaign No.Editable" := Status < Status::Won;
    PriorityEditable := Status < Status::Won;
    "Contact No.Editable" := Status < Status::Won;
    "Sales Document No.Editable" := Status = Status::"In Progress";
    "Sales Document TypeEditable" := Status = Status::"In Progress";
    */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
