#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186237 pageextension52186237 extends "Contact Card"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        // modify("Company No.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Company No."(Control 44)".


        //     //Unsupported feature: Property Modification (Name) on ""Company No."(Control 44)".

        // }
        modify("Company Name")
        {
            ApplicationArea = Basic;
            Enabled = "Company NameEnable";
        }
        modify(IntegrationCustomerNo)
        {
            ApplicationArea = Basic;
        }
        modify("Search Name")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Salutation Code")
        {
            ApplicationArea = Basic;
        }
        // modify("Organizational Level Code")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Organizational Level Code"(Control 22)".


        //     //Unsupported feature: Property Modification (Name) on ""Organizational Level Code"(Control 22)".

        // }
        // modify("Last Date Modified")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Last Date Modified"(Control 26)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Last Date Modified"(Control 26)".

        // }
        modify("Date of Last Interaction")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Attempted")
        {
            ApplicationArea = Basic;
        }
        modify("Next Task Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Next Task Date"(Control 32)".


            //Unsupported feature: Property Modification (Name) on ""Next Task Date"(Control 32)".

        }
        // modify("Exclude from Segment")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Exclude from Segment"(Control 40)".


        //     //Unsupported feature: Property Modification (Name) on ""Exclude from Segment"(Control 40)".

        // }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Level) on "Address(Control 34)".


            //Unsupported feature: Property Modification (Name) on "Address(Control 34)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Address(Control 34)".

        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Address 2"(Control 16)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Address 2"(Control 16)".


            //Unsupported feature: Property Modification (Name) on ""Address 2"(Control 16)".

        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Country/Region Code"(Control 12)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Country/Region Code"(Control 12)".


            //Unsupported feature: Property Modification (Name) on ""Country/Region Code"(Control 12)".

        }
        modify("Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Post Code"(Control 18)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Post Code"(Control 18)".


            //Unsupported feature: Property Modification (Name) on ""Post Code"(Control 18)".

        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 14)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "City(Control 14)".


            //Unsupported feature: Property Modification (Name) on "City(Control 14)".

        }
        modify("Phone No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Phone No."(Control 35)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Phone No."(Control 35)".

        }
        modify("Mobile Phone No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Mobile Phone No."(Control 36)".

            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {

            //Unsupported feature: Property Modification (Level) on ""E-Mail"(Control 46)".

            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Fax No."(Control 38)".

            ApplicationArea = Basic;
        }
        modify("Home Page")
        {

            //Unsupported feature: Property Modification (Level) on ""Home Page"(Control 48)".

            ApplicationArea = Basic;
        }
        modify("Correspondence Type")
        {

            //Unsupported feature: Property Modification (Level) on ""Correspondence Type"(Control 126)".

            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
            Enabled = "Currency CodeEnable";
        }
        modify("Territory Code")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Registration No.")
        {
            ApplicationArea = Basic;
            Enabled = "VAT Registration No.Enable";
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (Importance) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 2)".


        //Unsupported feature: Code Modification on "Name(Control 10).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        COMMIT;

        Contact := Rec;
        Contact.SETRECFILTER;
        IF Contact.Type = Contact.Type::Person THEN BEGIN
          CLEAR(NameDetails);
          NameDetails.SETTABLEVIEW(Contact);
          NameDetails.SETRECORD(Contact);
          NameDetails.RUNMODAL;
        END ELSE BEGIN
          CLEAR(CompanyDetails);
          CompanyDetails.SETTABLEVIEW(Contact);
          CompanyDetails.SETRECORD(Contact);
          CompanyDetails.RUNMODAL;
        END;
        Rec := Contact;
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        MODIFY;
        COMMIT;
        Cont.SETRANGE("No.","No.");
        IF Type = Type::Person THEN BEGIN
          CLEAR(NameDetails);
          NameDetails.SETTABLEVIEW(Cont);
          NameDetails.SETRECORD(Cont);
        #10..12
          CompanyDetails.SETTABLEVIEW(Cont);
          CompanyDetails.SETRECORD(Cont);
          CompanyDetails.RUNMODAL;
        END;
        GET("No.");
        CurrPage.UPDATE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 10)".


        //Unsupported feature: Property Deletion (Importance) on "Name(Control 10)".


        //Unsupported feature: Property Deletion (ShowMandatory) on "Name(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Company No."(Control 44)".


        //Unsupported feature: Property Deletion (Importance) on ""Company No."(Control 44)".



        //Unsupported feature: Code Modification on ""Company Name"(Control 8).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        COMMIT;
        LookupCompany;
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Cont.SETRANGE("No.","Company No.");
        CLEAR(CompanyDetails);
        CompanyDetails.SETTABLEVIEW(Cont);
        CompanyDetails.SETRECORD(Cont);
        IF Type = Type::Person THEN
          CompanyDetails.EDITABLE := FALSE;
        CompanyDetails.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Company Name"(Control 8)".


        //Unsupported feature: Property Deletion (Importance) on ""Company Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IntegrationCustomerNo(Control 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Name"(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on ""Search Name"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 24)".


        //Unsupported feature: Property Deletion (Importance) on ""Salesperson Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salutation Code"(Control 117)".


        //Unsupported feature: Property Deletion (Importance) on ""Salutation Code"(Control 117)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Organizational Level Code"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Organizational Level Code"(Control 22)".


        //Unsupported feature: Property Deletion (Enabled) on ""Organizational Level Code"(Control 22)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Last Date Modified"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 26)".


        //Unsupported feature: Property Deletion (Importance) on ""Last Date Modified"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date of Last Interaction"(Control 28)".


        //Unsupported feature: Property Deletion (Importance) on ""Date of Last Interaction"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Attempted"(Control 30)".


        //Unsupported feature: Property Deletion (Importance) on ""Last Date Attempted"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Task Date"(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""Next Task Date"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude from Segment"(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Exclude from Segment"(Control 40)".

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
        modify(Control37)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on ""Post Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 14)".

        modify(ShowMap)
        {
            Visible = false;
        }
        modify(ContactDetails)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mobile Phone No."(Control 36)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 46)".


        //Unsupported feature: Property Deletion (Importance) on ""E-Mail"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on ""Fax No."(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Home Page"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Correspondence Type"(Control 126)".


        //Unsupported feature: Property Deletion (Importance) on ""Correspondence Type"(Control 126)".

        // modify("Language Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 64)".


        //Unsupported feature: Property Deletion (Importance) on ""Currency Code"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Territory Code"(Control 68)".


        //Unsupported feature: Property Deletion (Importance) on ""Territory Code"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Registration No."(Control 66)".


        //Unsupported feature: Property Deletion (Importance) on ""VAT Registration No."(Control 66)".


        //Unsupported feature: Property Deletion (CaptionML) on "Control72(Control 72)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control72(Control 72)".


        //Unsupported feature: Property Deletion (PartType) on "Control72(Control 72)".

        modify(Control41)
        {
            Visible = false;
        }
        modify(Control31)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Type)
        {
            // field("Company No."; Rec."Company No.")
            // {
            //     ApplicationArea = Basic;
            //     Enabled = "Company No.Enable";
            // }
        }
        // addafter("Exclude from Segment")
        // {
        //     field(Pager; Rec.Pager)
        //     {
        //         ApplicationArea = Basic;
        //     }
        // }
        addafter("Company No.")
        {
            // field("Language Code"; Rec."Language Code")
            // {
            //     ApplicationArea = Basic;
            // }
            field("Salutation Code2"; Rec."Salutation Code")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Company No.")
        {
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field(Surname; Rec.Surname)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            group(Segmentation)
            {
                Caption = 'Segmentation';
                field("No. of Mailing Groups"; Rec."No. of Mailing Groups")
                {
                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    var
                        ContMailingGrp: Record "Contact Mailing Group";
                    begin
                        CurrPage.SaveRecord;
                        Commit;
                        ContMailingGrp.SetRange("Contact No.", Rec."No.");
                        Page.RunModal(Page::"Contact Mailing Groups", ContMailingGrp);
                        CurrPage.Update(false);
                    end;
                }
                field("No. of Business Relations"; Rec."No. of Business Relations")
                {
                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    var
                        ContBusRel: Record "Contact Business Relation";
                    begin
                        CurrPage.SaveRecord;
                        Commit;
                        ContBusRel.SetRange("Contact No.", Rec."Company No.");
                        Page.RunModal(Page::"Contact Business Relations", ContBusRel);
                        CurrPage.Update(false);
                    end;
                }
                field("No. of Industry Groups"; Rec."No. of Industry Groups")
                {
                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    var
                        ContIndustGrp: Record "Contact Industry Group";
                    begin
                        CurrPage.SaveRecord;
                        Commit;
                        ContIndustGrp.SetRange("Contact No.", Rec."Company No.");
                        Page.RunModal(Page::"Contact Industry Groups", ContIndustGrp);
                        CurrPage.Update(false);
                    end;
                }
                field("No. of Job Responsibilities"; Rec."No. of Job Responsibilities")
                {
                    ApplicationArea = Basic;
                    Enabled = NoofJobResponsibilitiesEnable;

                    trigger OnDrillDown()
                    var
                        ContJobResp: Record "Contact Job Responsibility";
                    begin
                        CurrPage.SaveRecord;
                        Commit;
                        ContJobResp.SetRange("Contact No.", Rec."No.");
                        Page.RunModal(Page::"Contact Job Responsibilities", ContJobResp);
                        CurrPage.Update(false);
                    end;
                }
                // field("Organizational Level Code"; Rec."Organizational Level Code")
                // {
                //     ApplicationArea = Basic;
                //     Enabled = OrganizationalLevelCodeEnable;
                // }
                // field("Exclude from Segment"; Rec."Exclude from Segment")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
        moveafter("No."; Type)
        moveafter(Type; "Company Name")
        moveafter(Name; "Country/Region Code")
        moveafter(Address; City)
        // moveafter("Address 2"; "Address 2")
        moveafter("Post Code"; Address)
        moveafter(City; "Post Code")
        moveafter("Country/Region Code"; "Search Name")
        //moveafter("Search Name"; "Organizational Level Code")
        moveafter("Phone No."; "Salesperson Code")
        //moveafter("Salutation Code"; "Last Date Modified")
        // moveafter("Next To-do Date"; Control72)
        //moveafter(Control72; Communication)
        moveafter(Communication; "Phone No.")
        moveafter("Mobile Phone No."; "Fax No.")
        // moveafter("Fax No."; "Exclude from Segment")
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

        modify("Online Map")
        {
            ApplicationArea = Basic;
        }
        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 96)".

        }
        modify("Oppo&rtunities")
        {
            ApplicationArea = Basic;
        }
        modify(SalesQuotes)
        {

            //Unsupported feature: Property Modification (Name) on "SalesQuotes(Action 116)".

            ApplicationArea = Basic;
        }
        modify("Interaction Log E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Launch &Web Source")
        {
            ApplicationArea = Basic;
        }
        modify("Print Cover &Sheet")
        {
            ApplicationArea = Basic;
        }
        modify(CreateCustomer)
        {

            //Unsupported feature: Property Modification (Name) on "CreateCustomer(Action 106)".

            ApplicationArea = Basic;
        }
        modify(CreateVendor)
        {

            //Unsupported feature: Property Modification (Name) on "CreateVendor(Action 107)".

            ApplicationArea = Basic;
        }
        modify(CreateBank)
        {

            //Unsupported feature: Property Modification (Name) on "CreateBank(Action 108)".

            ApplicationArea = Basic;
        }
        modify(Customer)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on "Customer(Action 110)".

        }
        modify(Vendor)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on "Vendor(Action 111)".

        }
        modify(Bank)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on "Bank(Action 112)".

        }
        modify("Apply Template")
        {
            ApplicationArea = Basic;
        }
        modify("Create &Interaction")
        {
            Caption = 'Create &Interact';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Create &Interaction"(Action 77)".

        }
        modify(ContactCoverSheet)
        {

            //Unsupported feature: Property Modification (Name) on "ContactCoverSheet(Action 1907415106)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Business Relations"(Action 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Industry Groups"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Web Sources"(Action 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Responsibilities"(Action 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pro&files"(Action 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Picture"(Action 89)".


        //Unsupported feature: Property Deletion (Visible) on ""&Picture"(Action 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Ranges"(Action 93)".



        //Unsupported feature: Code Modification on "ManageCRMCoupling(Action 25).OnAction".

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
        modify(ShowLog)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Relate&d Contacts"(Action 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Segmen&ts"(Action 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mailing &Groups"(Action 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer/Vendor/Bank Acc."(Action 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Online Map"(Action 63)".

        modify("Office Customer/Vendor")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Oppo&rtunities"(Action 3)".

        // modify("Postponed &Interactions")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "SalesQuotes(Action 116)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Launch &Web Source"(Action 102)".


        //Unsupported feature: Property Deletion (Visible) on ""Launch &Web Source"(Action 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print Cover &Sheet"(Action 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateCustomer(Action 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateVendor(Action 107)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateBank(Action 108)".


        //Unsupported feature: Property Deletion (Visible) on ""Link with existing"(Action 109)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Customer(Action 110)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendor(Action 111)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Bank(Action 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Apply Template"(Action 153)".

        modify(MergeDuplicate)
        {
            Visible = false;
        }
        modify(CreateAsCustomer)
        {
            Visible = false;
        }
        modify(CreateAsVendor)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Interaction"(Action 77)".

        modify("Create Opportunity")
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "ContactCoverSheet(Action 1907415106).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Contact := Rec;
        Contact.SETRECFILTER;
        ContactCoverSheetReportID := REPORT::"Contact Cover Sheet";
        OnBeforePrintContactCoverSheet(ContactCoverSheetReportID);
        REPORT.RUN(ContactCoverSheetReportID,TRUE,FALSE,Contact);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Cont := Rec;
        Cont.SETRECFILTER;
        REPORT.RUN(REPORT::"Contact - Cover Sheet",TRUE,FALSE,Cont);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ContactCoverSheet(Action 1907415106)".

        addafter("Alternati&ve Address")
        {
            separator(Action94)
            {
                Caption = '';
            }
        }
        addafter("Online Map")
        {
            separator(Action62)
            {
            }
        }
        addafter("Oppo&rtunities")
        {
            separator(Action98)
            {
                Caption = '';
            }
        }
        addafter(SalesQuotes)
        {
            separator(Action119)
            {
            }
        }
        addfirst(History)
        {
            // action("Postponed &Interactions")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Postponed &Interactions';
            //     Image = PostponedInteractions;
            //     RunObject = Page "Postponed Interactions";
            //     RunPageLink = "Contact Company No." = field("Company No."),
            //                   "Contact No." = filter(<> ''),
            //                   "Contact No." = field(filter("Lookup Contact No."));
            //     RunPageView = sorting("Contact Company No.", Date, "Contact No.", Canceled, "Initiated By", "Attempt Failed");
            // }
        }
        addafter("Link with existing")
        {
            separator(Action152)
            {
            }
        }
    }

    var
        MapMgt: Codeunit "Online Map Management";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";

    var
        Cont: Record Contact;

    var

        MapPointVisible: Boolean;

        "Currency CodeEnable": Boolean;

        "VAT Registration No.Enable": Boolean;

        "Company No.Enable": Boolean;

        "Company NameEnable": Boolean;

    var

        NoofJobResponsibilitiesEnable: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CRMIntegrationEnabled THEN BEGIN
      CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
      IF "No." <> xRec."No." THEN
        CRMIntegrationManagement.SendResultNotification(Rec);
    END;

    xRec := Rec;
    EnableFields;

    IF Type = Type::Person THEN
      IntegrationFindCustomerNo
    ELSE
      IntegrationCustomerNo := '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #7..13

    IF CRMIntegrationEnabled THEN
      CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OrganizationalLevelCodeEnable := TRUE;
    CompanyNameEnable := TRUE;
    VATRegistrationNoEnable := TRUE;
    CurrencyCodeEnable := TRUE;
    ActionVisible := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Windows;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NoofJobResponsibilitiesEnable := TRUE;
    OrganizationalLevelCodeEnable := TRUE;
    "Company NameEnable" := TRUE;
    "Company No.Enable" := TRUE;
    "VAT Registration No.Enable" := TRUE;
    "Currency CodeEnable" := TRUE;
    MapPointVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Company No.") <> '' THEN BEGIN
      "Company No." := GETRANGEMAX("Company No.");
      Type := Type::Person;
      Contact.GET("Company No.");
      InheritCompanyToPersonData(Contact);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      InheritCompanyToPersonData(Contact,TRUE)
    END;
    */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: MapMgt)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsOfficeAddin := OfficeManagement.IsAvailable;
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    SetNoFieldVisible;
    SetParentalConsentReceivedEnable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT MapMgt.TestSetup THEN
      MapPointVisible := FALSE;

    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    */
    //end;


    //Unsupported feature: Code Modification on "EnableFields(PROCEDURE 1)".

    //procedure EnableFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CompanyGroupEnabled := Type = Type::Company;
    PersonGroupEnabled := Type = Type::Person;
    CurrencyCodeEnable := Type = Type::Company;
    VATRegistrationNoEnable := Type = Type::Company;
    CompanyNameEnable := Type = Type::Person;
    OrganizationalLevelCodeEnable := Type = Type::Person;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyGroupEnabled := Type = Type::Company;
    PersonGroupEnabled := Type = Type::Person;
    "Currency CodeEnable" := Type = Type::Company;
    "VAT Registration No.Enable" := Type = Type::Company;
    "Company No.Enable" := Type = Type::Person;
    "Company NameEnable" := Type = Type::Person;
    OrganizationalLevelCodeEnable := Type = Type::Person;
    NoofJobResponsibilitiesEnable := Type = Type::Person;
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
