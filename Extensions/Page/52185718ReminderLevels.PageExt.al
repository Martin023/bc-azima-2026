#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185718 pageextension52185718 extends "Reminder Levels"
{
    layout
    {
        modify("Reminder Terms Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Reminder Terms Code"(Control 18)".

        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Grace Period")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date Calculation")
        {
            ApplicationArea = Basic;
        }
        modify("Calculate Interest")
        {
            ApplicationArea = Basic;
        }
        modify("Additional Fee (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Add. Fee per Line Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Add. Fee Calculation Type")
        {
            ApplicationArea = Basic;
        }
        modify("Add. Fee per Line Description")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reminder Terms Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Grace Period"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date Calculation"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculate Interest"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Fee (LCY)"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Add. Fee per Line Amount (LCY)"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Add. Fee Calculation Type"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Add. Fee per Line Description"(Control 22)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(BeginningText)
        {

            //Unsupported feature: Property Modification (Name) on "BeginningText(Action 2)".

            ApplicationArea = Basic;
        }
        modify(EndingText)
        {

            //Unsupported feature: Property Modification (Name) on "EndingText(Action 3)".

            ApplicationArea = Basic;
        }
        modify(Currencies)
        {
            ApplicationArea = Basic;
        }
        modify("Additional Fee")
        {
            ApplicationArea = Basic;
        }
        modify("Additional Fee per Line")
        {
            ApplicationArea = Basic;
        }
        modify("View Additional Fee Chart")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "BeginningText(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndingText(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Currencies(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Fee"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Fee per Line"(Action 25)".


        //Unsupported feature: Code Modification on ""View Additional Fee Chart"(Action 1001).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF FileMgt.IsWebClient THEN
          ERROR(ChartNotAvailableInWebErr,PRODUCTNAME.SHORT);

        AddFeeChart.SetViewMode(Rec,FALSE,TRUE);
        AddFeeChart.RUNMODAL;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF FileMgt.IsWebClient THEN
          ERROR(ChartNotAvailableInWebErr);
        #3..5
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""View Additional Fee Chart"(Action 1001)".


        //Unsupported feature: Property Deletion (Visible) on ""View Additional Fee Chart"(Action 1001)".

    }


    //Unsupported feature: Property Modification (TextConstString) on "ChartNotAvailableInWebErr(Variable 1007)".

    //var
    //>>>> ORIGINAL VALUE:
    //ChartNotAvailableInWebErr : @@@=%1 - product name;ENU=The chart cannot be shown in the %1 Web client. To see the chart, use the %1 Windows client.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChartNotAvailableInWebErr : ENU=The chart cannot be shown in the Web Client. Please use the Windows Client to see the chart.;
    //Variable type has not been exported.

    var

        "Reminder Terms CodeVisible": Boolean;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReminderTerms.SETFILTER(Code,GETFILTER("Reminder Terms Code"));
    ShowColumn := TRUE;
    IF ReminderTerms.FINDFIRST THEN BEGIN
      ReminderTerms.SETRECFILTER;
      IF ReminderTerms.GETFILTER(Code) = GETFILTER("Reminder Terms Code") THEN
        ShowColumn := FALSE;
    END;
    ReminderTermsCodeVisible := ShowColumn;
    IsSaaS := PermissionManager.SoftwareAsAService;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    "Reminder Terms CodeVisible" := ShowColumn;
    */
    //end;
}
