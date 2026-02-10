#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186239 pageextension52186239 extends "Contact List"
{
    Caption = 'Contact List';
    layout
    {

        //Unsupported feature: Property Insertion (IndentationColumnName) on "Control1(Control 1)".


        //Unsupported feature: Property Insertion (IndentationControls) on "Control1(Control 1)".

        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Company Name")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("Mobile Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Territory Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Language Code")
        {
            ApplicationArea = Basic;
        }
        modify("Search Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Company Name"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mobile Phone No."(Control 24)".

        modify("E-Mail")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Territory Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Language Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Name"(Control 22)".


        //Unsupported feature: Property Deletion (Visible) on ""Search Name"(Control 22)".

        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify(Minor)
        {
            Visible = false;
        }
        modify("Parental Consent Received")
        {
            Visible = false;
        }
        modify(Control128)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Business Relations")
        {
            ApplicationArea = Basic;
        }
        modify("Industry Groups")
        {
            ApplicationArea = Basic;
        }
        modify("Web Sources")
        {
            ApplicationArea = Basic;
        }
        modify("Job Responsibilities")
        {
            ApplicationArea = Basic;
        }
        modify("Pro&files")
        {
            ApplicationArea = Basic;
        }
        modify("&Picture")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Date Ranges")
        {
            ApplicationArea = Basic;
        }
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGotoContact)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM contact.';
            ApplicationArea = Basic;
        }
        modify(CRMSynchronizeNow)
        {
            Caption = 'Synchronize Now';
            ToolTip = 'Send or get updated data to or from Microsoft Dynamics CRM.';
            ApplicationArea = Basic;
        }
        modify(Coupling)
        {
            ToolTip = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
        }
        modify(ManageCRMCoupling)
        {
            ToolTip = 'Create or modify the coupling to a Microsoft Dynamics CRM contact.';
            ApplicationArea = Basic;
        }
        modify(DeleteCRMCoupling)
        {
            ToolTip = 'Delete the coupling to a Microsoft Dynamics CRM contact.';
            ApplicationArea = Basic;
        }
        modify(CreateInCRM)
        {
            Caption = 'Create Contact in Dynamics CRM';
            ApplicationArea = Basic;
        }
        modify(CreateFromCRM)
        {
            Caption = 'Create Contact in Dynamics NAV';
            ApplicationArea = Basic;
        }
        modify(ShowLog)
        {

            //Unsupported feature: Property Modification (ActionType) on "ShowLog(Action 52)".


            //Unsupported feature: Property Modification (Name) on "ShowLog(Action 52)".

            Caption = '';
        }
        modify("Relate&d Contacts")
        {
            ApplicationArea = Basic;
        }
        modify("Segmen&ts")
        {
            ApplicationArea = Basic;
        }
        modify("Mailing &Groups")
        {
            ApplicationArea = Basic;
        }

        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 50)".

        }
        modify("Open Oppo&rtunities")
        {
            Caption = 'Oppo&rtunities';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunPageLink) on ""Open Oppo&rtunities"(Action 3)".


            //Unsupported feature: Property Modification (Name) on ""Open Oppo&rtunities"(Action 3)".

        }
        modify("Postponed &Interactions")
        {
            ApplicationArea = Basic;
        }
        modify(ShowSalesQuotes)
        {

            //Unsupported feature: Property Modification (Name) on "ShowSalesQuotes(Action 68)".

            ApplicationArea = Basic;
        }
        modify("Interaction Log E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 42)".

        }
        modify(MakePhoneCall)
        {

            //Unsupported feature: Property Modification (Name) on "MakePhoneCall(Action 54)".

            ApplicationArea = Basic;
        }
        modify("Launch &Web Source")
        {
            ApplicationArea = Basic;
        }
        modify(Customer)
        {
            ApplicationArea = Basic;
        }
        modify(Vendor)
        {
            ApplicationArea = Basic;
        }
        modify(Bank)
        {
            ApplicationArea = Basic;
        }
        modify(Action63)
        {
            ApplicationArea = Basic;
        }
        modify(Action64)
        {
            ApplicationArea = Basic;
        }
        modify(Action65)
        {
            ApplicationArea = Basic;
        }
        modify("Export Contact")
        {

            //Unsupported feature: Property Modification (Level) on ""Export Contact"(Action 57)".


            //Unsupported feature: Property Modification (Name) on ""Export Contact"(Action 57)".

            Caption = 'Print Cover &Sheet';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Export Contact"(Action 57)".

        }
        modify("Create &Interaction")
        {
            Caption = 'Create &Interact';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Create &Interaction"(Action 31)".

        }
        // modify(NewSalesQuote)
        // {

        //     //Unsupported feature: Property Modification (Name) on "NewSalesQuote(Action 1900900305)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Image) on "NewSalesQuote(Action 1900900305)".


        //     //Unsupported feature: Property Insertion (RunObject) on "NewSalesQuote(Action 1900900305)".


        //     //Unsupported feature: Property Insertion (RunPageLink) on "NewSalesQuote(Action 1900900305)".


        //     //Unsupported feature: Property Insertion (RunPageMode) on "NewSalesQuote(Action 1900900305)".

        // }
        modify("Contact Labels")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Contact Labels"(Action 1904205506)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Contact Labels"(Action 1904205506)".

        }
        modify("Questionnaire Handout")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Questionnaire Handout"(Action 1905922906)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Questionnaire Handout"(Action 1905922906)".

        }
        modify("Sales Cycle Analysis")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on ""Sales Cycle Analysis"(Action 1900800206)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Sales Cycle Analysis"(Action 1900800206)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Business Relations"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Industry Groups"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Web Sources"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Responsibilities"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pro&files"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Picture"(Action 43)".


        //Unsupported feature: Property Deletion (Visible) on ""&Picture"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 44)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 44)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Ranges"(Action 47)".


        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CRMIntegrationManagement.DefineCoupling(RECORDID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CRMIntegrationManagement.CreateOrUpdateCoupling(RECORDID);
        */
        //end;


        //Unsupported feature: Code Modification on "CreateInCRM(Action 15).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Contact);
        CRMIntegrationManagement.CreateNewRecordsInCRM(Contact);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Contact);
        Contact.NEXT;

        IF Contact.COUNT = 1 THEN
          CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,FALSE)
        ELSE BEGIN
          ContactRecordRef.GETTABLE(Contact);
          CRMIntegrationManagement.CreateNewRecordsInCRM(ContactRecordRef);
        END
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateInCRM(Action 15)".



        //Unsupported feature: Code Modification on "CreateFromCRM(Action 13).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CRMIntegrationManagement.CreateNewContactFromCRM;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CRMIntegrationManagement.ManageCreateNewRecordFromCRM(DATABASE::Contact);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateFromCRM(Action 13)".

        // modify(ShowLog)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowLog(Action 52)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ShowLog(Action 52)".


        //Unsupported feature: Property Deletion (Image) on "ShowLog(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Relate&d Contacts"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Segmen&ts"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mailing &Groups"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer/Vendor/Bank Acc."(Action 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Open Oppo&rtunities"(Action 3)".


        //Unsupported feature: Property Deletion (Promoted) on ""Open Oppo&rtunities"(Action 3)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Open Oppo&rtunities"(Action 3)".


        //Unsupported feature: Property Deletion (Scope) on ""Open Oppo&rtunities"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowSalesQuotes(Action 68)".

        modify("Closed Oppo&rtunities")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 42)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 42)".



        //Unsupported feature: Code Modification on "MakePhoneCall(Action 54).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TAPIManagement.DialContCustVendBank(DATABASE::Contact,"No.",GetDefaultPhoneNo,'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TAPIManagement.DialContCustVendBank(DATABASE::Contact,"No.","Phone No.",'');
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "MakePhoneCall(Action 54)".


        //Unsupported feature: Property Deletion (Promoted) on "MakePhoneCall(Action 54)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "MakePhoneCall(Action 54)".


        //Unsupported feature: Property Deletion (Scope) on "MakePhoneCall(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Launch &Web Source"(Action 56)".


        //Unsupported feature: Property Deletion (Visible) on ""Launch &Web Source"(Action 56)".


        //Unsupported feature: Property Deletion (Visible) on ""Create as"(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customer(Action 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendor(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Bank(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action63(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action64(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action65(Action 65)".



        //Unsupported feature: Code Insertion on ""Print Cover &Sheet"(Action 57)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //var
        //Cont: Record Contact;
        //begin
        /*
        Cont := Rec;
        Cont.SETRECFILTER;
        REPORT.RUN(REPORT::"Contact - Cover Sheet",TRUE,FALSE,Cont);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Export Contact"(Action 57)".


        //Unsupported feature: Property Deletion (RunObject) on ""Export Contact"(Action 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Interaction"(Action 31)".

        modify("Create Opportunity")
        {
            Visible = false;
        }
        modify(SyncWithExchange)
        {
            Visible = false;
        }
        modify(FullSyncWithExchange)
        {
            Visible = false;
        }
        modify(NewSalesQuote)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "NewSalesQuote(Action 1900900305)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Labels"(Action 1904205506)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Questionnaire Handout"(Action 1905922906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Analysis"(Action 1900800206)".

        addafter("Alternati&ve Address")
        {
            separator(Action48)
            {
                Caption = '';
            }
        }
        addafter(ShowSalesQuotes)
        {
            separator(Action69)
            {
            }
        }
        addfirst(Reporting)
        {
            action("Contact Cover Sheet")
            {
                ApplicationArea = Basic;
                Caption = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Cont := Rec;
                    Cont.SetRecfilter;
                    Report.Run(Report::"Contact - Cover Sheet", true, false, Cont);
                end;
            }
            action("Contact Company Summary")
            {
                ApplicationArea = Basic;
                Caption = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Contact - Company Summary";
            }
        }
        moveafter(CreateFromCRM; "Related Information")
        //moveafter(Action52;Documents)
        moveafter("Launch &Web Source"; "Export Contact")
    }

    var
        ContactRecordRef: RecordRef;

    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";

    var
        Cont: Record Contact;

    var

        NameIndent: Integer;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

    //trigger (Variable: CRMCouplingManagement)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    StyleIsStrong := Type = Type::Company;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableFields;
    StyleIsStrong := Type = Type::Company;

    NameIndent := 0;
    IF Type <> Type::Company THEN BEGIN
      Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
      IF ("Company No." <> '') AND (NOT HASFILTER) AND (NOT MARKEDONLY) AND (CURRENTKEY = Cont.CURRENTKEY) THEN
        NameIndent := 1
    END;

    IF CRMIntegrationEnabled THEN
      CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
