#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186228 pageextension52186228 extends "Curr. Exch. Rate Service Card"
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
            Editable = EditableByNotEnabled;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
            Editable = EditableByNotEnabled;
        }
        modify(Enabled)
        {
            ApplicationArea = Basic;
        }
        modify(ServiceURL)
        {
            ApplicationArea = Basic;
            Editable = EditableByNotEnabled;
        }
        modify("Service Provider")
        {
            ApplicationArea = Basic;
            Editable = EditableByNotEnabled;
        }
        modify("Terms of Service")
        {
            ApplicationArea = Basic;
            Editable = EditableByNotEnabled;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 3)".


        //Unsupported feature: Code Modification on "Enabled(Control 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NotEnabledAndCurrPageEditable := NOT Enabled AND CurrPage.EDITABLE;
        EnabledAndCurrPageEditable := Enabled AND CurrPage.EDITABLE;
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        EditableByNotEnabled := NOT Enabled;
        CurrPage.UPDATE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Enabled(Control 7)".

        // modify(ShowEnableWarning)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceURL(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Provider"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Terms of Service"(Control 12)".

        modify("Log Web Requests")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "SimpleDataExchSetup(Control 6)".


        //Unsupported feature: Property Deletion (Editable) on "SimpleDataExchSetup(Control 6)".

        addafter(Description)
        {
            // field(ShowEnableWarning;ShowEnableWarning)
            // {
            //     ApplicationArea = Basic;
            //     Editable = false;

            //     trigger OnDrillDown()
            //     begin
            //         DrilldownCode;
            //     end;
            // }
        }
    }
    actions
    {
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify(JobQueueEntry)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "JobQueueEntry(Action 13)".

    }

    var
        TempXMLStructure: Record "XML Buffer" temporary;

    var
        EditableByNotEnabled: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WebServiceURL := GetWebServiceURL(ServiceURL);
    IF WebServiceURL <> '' THEN
      GenerateXMLStructure;

    UpdateSimpleMappingsPart;
    UpdateBasedOnEnable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetWebServiceURL(WebServiceURL);
    #2..6
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApplicationAreaMgmtFacade.CheckAppAreaOnlyBasic;

    UpdateBasedOnEnable;
    IsSoftwareAsService := PermissionManager.SoftwareAsAService;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateBasedOnEnable;
    */
    //end;


    //Unsupported feature: Code Modification on "GenerateXMLStructure(PROCEDURE 1)".

    //procedure GenerateXMLStructure();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempXMLBuffer.RESET;
    TempXMLBuffer.DELETEALL;
    GetWebServiceURL(ServiceURL);
    IF GetXMLStructure(TempXMLBuffer,ServiceURL) THEN BEGIN
      TempXMLBuffer.RESET;
      CurrPage.SimpleDataExchSetup.PAGE.SetXMLDefinition(TempXMLBuffer);
    END ELSE
      ShowHttpError;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TempXMLStructure.RESET;
    TempXMLStructure.DELETEALL;
    GetXMLStructure(TempXMLStructure,WebServiceURL);
    TempXMLStructure.RESET;
    CurrPage.SimpleDataExchSetup.PAGE.SetXMLDefinition(TempXMLStructure);
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateBasedOnEnable(PROCEDURE 4)".

    //procedure UpdateBasedOnEnable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NotEnabledAndCurrPageEditable := NOT Enabled AND CurrPage.EDITABLE;
    EnabledAndCurrPageEditable := Enabled AND CurrPage.EDITABLE;
    ShowEnableWarning := '';
    IF CurrPage.EDITABLE AND Enabled THEN
      ShowEnableWarning := EnabledWarningTok;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EditableByNotEnabled := NOT Enabled;
    #3..5
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "GenerateXMLStructure(PROCEDURE 1).ServiceURL(Variable 1000)".

}
