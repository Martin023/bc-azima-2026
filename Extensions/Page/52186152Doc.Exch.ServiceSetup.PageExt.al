#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186152 pageextension52186152 extends "Doc. Exch. Service Setup"
{
    layout
    {
        modify("User Agent")
        {
            ApplicationArea = Basic;
        }
       
        modify(Enabled)
        {
            ApplicationArea = Basic;
        }
        modify("Sign-up URL")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Sign-up URL"(Control 4)".


            //Unsupported feature: Property Modification (Name) on ""Sign-up URL"(Control 4)".

        }
        modify("Service URL")
        {
            ApplicationArea = Basic;
        }
        modify("Sign-in URL")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Sign-in URL"(Control 6)".


            //Unsupported feature: Property Modification (Name) on ""Sign-in URL"(Control 6)".

        }
        

        //Unsupported feature: Property Deletion (ToolTipML) on ""User Agent"(Control 27)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""User Agent"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DocExchTenantID(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Enabled(Control 25)".

        // modify(ShowEnableWarning)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sign-up URL"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service URL"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sign-in URL"(Control 6)".

        modify("Log Web Requests")
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on "ConsumerKey(Control 17).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SavePassword("Consumer Key",ConsumerKey);
        IF ConsumerKey <> '' THEN
          CheckEncryption;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SavePassword("Consumer Key",ConsumerKey);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ConsumerKey(Control 17)".



        //Unsupported feature: Code Modification on "ConsumerSecret(Control 18).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SavePassword("Consumer Secret",ConsumerSecret);
        IF ConsumerSecret <> '' THEN
          CheckEncryption;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SavePassword("Consumer Secret",ConsumerSecret);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ConsumerSecret(Control 18)".



        //Unsupported feature: Code Modification on "TokenValue(Control 19).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SavePassword(Token,TokenValue);
        IF TokenValue <> '' THEN
          CheckEncryption;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SavePassword(Token,TokenValue);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "TokenValue(Control 19)".



        //Unsupported feature: Code Modification on "TokenSecret(Control 21).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SavePassword("Token Secret",TokenSecret);
        IF TokenSecret <> '' THEN
          CheckEncryption;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SavePassword("Token Secret",TokenSecret);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "TokenSecret(Control 21)".

       
    }
    actions
    {
        modify(SetURLsToDefault)
        {
            ApplicationArea = Basic;
        }
        modify(TestConnection)
        {
            ApplicationArea = Basic;
        }
        modify(JobQueueEntry)
        {
            ApplicationArea = Basic;
        }
        modify(EncryptionManagement)
        {
            ApplicationArea = Basic;
        }
        modify(ActivityLog)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SetURLsToDefault(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestConnection(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "JobQueueEntry(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EncryptionManagement(Action 8)".



        //Unsupported feature: Code Insertion (VariableCollection) on "ActivityLog(Action 23).OnAction".

        //trigger (Variable: DocExchServiceSetup)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "ActivityLog(Action 23).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ActivityLog.ShowEntries(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DocExchServiceSetup.GET;
        ActivityLog.ShowEntries(DocExchServiceSetup.RECORDID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 23)".

    }

    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";


    //Unsupported feature: Property Modification (TextConstString) on "DisableEnableQst(Variable 1007)".

    //var
    //>>>> ORIGINAL VALUE:
    //DisableEnableQst : ENU=Do you want to disable the document exchange service?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DisableEnableQst : ENU=Do you want to disable document exchange service?;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateBasedOnEnable;
    UpdateEncryptedField("Consumer Key",ConsumerKey);
    UpdateEncryptedField("Consumer Secret",ConsumerSecret);
    UpdateEncryptedField(Token,TokenValue);
    UpdateEncryptedField("Token Secret",TokenSecret);
    UpdateEncryptedField("Doc. Exch. Tenant ID",DocExchTenantID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateBasedOnEnable;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT(TRUE);
      SetURLsToDefault;
    END;
    UpdateBasedOnEnable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    ConsumerKey := '*************';
    ConsumerSecret := '*************';
    TokenValue := '*************';
    TokenSecret := '*************';
    DocExchTenantID := '*************';
    UpdateBasedOnEnable;
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
