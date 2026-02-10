#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186294 pageextension52186294 extends "Profile Question Details"
{
    layout
    {
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Multiple Answers")
        {
            ApplicationArea = Basic;
        }
        modify("Auto Contact Classification")
        {
            ApplicationArea = Basic;
        }
        modify("Customer Class. Field")
        {
            ApplicationArea = Basic;
            Editable = "Customer Class. FieldEditable";
        }
        modify("Vendor Class. Field")
        {
            ApplicationArea = Basic;
            Editable = "Vendor Class. FieldEditable";
        }
        modify("Contact Class. Field")
        {
            ApplicationArea = Basic;
            Editable = "Contact Class. FieldEditable";
        }
        modify("Min. % Questions Answered")
        {
            ApplicationArea = Basic;
            Editable = "Min%QuestionsAnsweredEditable";
            HideValue = "Min%QuestionsAnsweredHideValue";
        }
        modify("Starting Date Formula")
        {
            ApplicationArea = Basic;
            Editable = "Starting Date FormulaEditable";
        }
        modify("Ending Date Formula")
        {
            ApplicationArea = Basic;
            Editable = "Ending Date FormulaEditable";
        }
        modify("Classification Method")
        {
            ApplicationArea = Basic;
            Editable = "Classification MethodEditable";
        }
        modify("Sorting Method")
        {
            ApplicationArea = Basic;
            Editable = "Sorting MethodEditable";
        }
        modify("No. of Decimals")
        {
            ApplicationArea = Basic;
            Editable = "No. of DecimalsEditable";
            HideValue = "No. of DecimalsHideValue";
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Multiple Answers"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Auto Contact Classification"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer Class. Field"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Class. Field"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Class. Field"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Min. % Questions Answered"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date Formula"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date Formula"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Classification Method"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sorting Method"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Decimals"(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(AnswerValues)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AnswerValues(Action 26)".

    }
    var

        "No. of DecimalsHideValue": Boolean;

        "No. of DecimalsEditable": Boolean;

        "Min%QuestionsAnsweredHideValue": Boolean;

        "Customer Class. FieldEditable": Boolean;

        "Vendor Class. FieldEditable": Boolean;

        "Contact Class. FieldEditable": Boolean;

        "Min%QuestionsAnsweredEditable": Boolean;

        "Starting Date FormulaEditable": Boolean;

        "Classification MethodEditable": Boolean;

        "Ending Date FormulaEditable": Boolean;

        "Sorting MethodEditable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MinPctQuestionsAnsweredHideValue := FALSE;
    NoOfDecimalsHideValue := FALSE;
    SetEditable;
    NoofDecimalsOnFormat;
    Min37QuestionsAnsweredOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Min%QuestionsAnsweredHideValue" := FALSE;
    "No. of DecimalsHideValue" := FALSE;
    #3..5
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AnswerValuesEnable := TRUE;
    SortingMethodEditable := TRUE;
    NoOfDecimalsEditable := TRUE;
    EndingDateFormulaEditable := TRUE;
    ClassificationMethodEditable := TRUE;
    StartingDateFormulaEditable := TRUE;
    MinPctQuestionsAnsweredEditable := TRUE;
    ContactClassFieldEditable := TRUE;
    VendorClassFieldEditable := TRUE;
    CustomerClassFieldEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AnswerValuesEnable := TRUE;
    "Sorting MethodEditable" := TRUE;
    "No. of DecimalsEditable" := TRUE;
    "Ending Date FormulaEditable" := TRUE;
    "Classification MethodEditable" := TRUE;
    "Starting Date FormulaEditable" := TRUE;
    "Min%QuestionsAnsweredEditable" := TRUE;
    "Contact Class. FieldEditable" := TRUE;
    "Vendor Class. FieldEditable" := TRUE;
    "Customer Class. FieldEditable" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetEditable(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "SetEditable(PROCEDURE 6)".

    //procedure SetEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustomerClassFieldEditable :=
      "Auto Contact Classification" AND ("Vendor Class. Field" = "Vendor Class. Field"::" ") AND ("Contact Class. Field" =
                                                                                                  "Contact Class. Field"::" ");
    VendorClassFieldEditable :=
      "Auto Contact Classification" AND ("Customer Class. Field" = "Customer Class. Field"::" ") AND ("Contact Class. Field" =
                                                                                                      "Contact Class. Field"::" ");
    ContactClassFieldEditable :=
      "Auto Contact Classification" AND ("Customer Class. Field" = "Customer Class. Field"::" ") AND ("Vendor Class. Field" =
                                                                                                      "Vendor Class. Field"::" ");

    MinPctQuestionsAnsweredEditable := "Contact Class. Field" = "Contact Class. Field"::Rating;

    StartingDateFormulaEditable :=
      ("Customer Class. Field" <> "Customer Class. Field"::" ") OR
      ("Vendor Class. Field" <> "Vendor Class. Field"::" ") OR
      (("Contact Class. Field" <> "Contact Class. Field"::" ") AND ("Contact Class. Field" <> "Contact Class. Field"::Rating));

    EndingDateFormulaEditable := StartingDateFormulaEditable;

    ClassificationMethodEditable :=
      ("Customer Class. Field" <> "Customer Class. Field"::" ") OR
      ("Vendor Class. Field" <> "Vendor Class. Field"::" ") OR
      (("Contact Class. Field" <> "Contact Class. Field"::" ") AND ("Contact Class. Field" <> "Contact Class. Field"::Rating));

    SortingMethodEditable :=
      ("Classification Method" = "Classification Method"::"Percentage of Value") OR
      ("Classification Method" = "Classification Method"
       ::"Percentage of Contacts");

    NoOfDecimalsEditable := ClassificationMethodEditable;

    AnswerValuesEnable := ("Contact Class. Field" = "Contact Class. Field"::Rating);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Customer Class. FieldEditable" :=
      "Auto Contact Classification" AND ("Vendor Class. Field" = "Vendor Class. Field"::" ") AND ("Contact Class. Field" =
                                                                                                  "Contact Class. Field"::" ");
    "Vendor Class. FieldEditable" :=
      "Auto Contact Classification" AND ("Customer Class. Field" = "Customer Class. Field"::" ") AND ("Contact Class. Field" =
                                                                                                      "Contact Class. Field"::" ");
    "Contact Class. FieldEditable" :=
    #8..10
    "Min%QuestionsAnsweredEditable" := "Contact Class. Field" = "Contact Class. Field"::Rating;

    "Starting Date FormulaEditable" :=
    #14..17
    "Ending Date FormulaEditable" := "Starting Date FormulaEditable";

    "Classification MethodEditable" :=
    #21..24
    "Sorting MethodEditable" :=
    #26..29
    "No. of DecimalsEditable" := "Classification MethodEditable";

    AnswerValuesEnable := ("Contact Class. Field" = "Contact Class. Field"::Rating);
    */
    //end;


    //Unsupported feature: Code Modification on "NoofDecimalsOnFormat(PROCEDURE 19017973)".

    //procedure NoofDecimalsOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT NoOfDecimalsEditable THEN
      NoOfDecimalsHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT "No. of DecimalsEditable" THEN
      "No. of DecimalsHideValue" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "Min37QuestionsAnsweredOnFormat(PROCEDURE 19037905)".

    //procedure Min37QuestionsAnsweredOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Contact Class. Field" <> "Contact Class. Field"::Rating THEN
      MinPctQuestionsAnsweredHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Contact Class. Field" <> "Contact Class. Field"::Rating THEN
      "Min%QuestionsAnsweredHideValue" := TRUE;
    */
    //end;
}
