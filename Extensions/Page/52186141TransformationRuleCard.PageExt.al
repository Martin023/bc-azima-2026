#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186141 pageextension52186141 extends "Transformation Rule Card" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Transformation Type")
        {
            ApplicationArea = Basic;
        }
        modify("Find Value")
        {

            //Unsupported feature: Property Modification (Level) on ""Find Value"(Control 6)".

            ApplicationArea = Basic;
            Enabled = FindValueEnabledExpr;
        }
        modify("Replace Value")
        {

            //Unsupported feature: Property Modification (Level) on ""Replace Value"(Control 7)".

            ApplicationArea = Basic;
            Enabled = ReplaceValueEnabledExpr;
        }
        modify("Start Position")
        {

            //Unsupported feature: Property Modification (Level) on ""Start Position"(Control 8)".

            ApplicationArea = Basic;
            Enabled = StartPositionEnabledExpr;
        }
        modify(Length)
        {

            //Unsupported feature: Property Modification (Level) on "Length(Control 9)".

            ApplicationArea = Basic;
            Enabled = LengthEnabledExpr;
        }
        modify("Data Format")
        {

            //Unsupported feature: Property Modification (Level) on ""Data Format"(Control 10)".

            ApplicationArea = Basic;
            Enabled = DateFormatEnabledExpr;
        }
        modify("Data Formatting Culture")
        {

            //Unsupported feature: Property Modification (Level) on ""Data Formatting Culture"(Control 11)".

            ApplicationArea = Basic;
            Enabled = DataFormattingCultureEnabledExpr;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transformation Type"(Control 5)".

        modify("Next Transformation Rule")
        {
            Visible = false;
        }
        modify(Control19)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Find Value"(Control 6)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Find Value"(Control 6)".

        modify(Control20)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Replace Value"(Control 7)".

        modify(Control21)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Position"(Control 8)".

        modify("Starting Text")
        {
            Visible = false;
        }
        modify(Control22)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Length(Control 9)".

        modify("Ending Text")
        {
            Visible = false;
        }
        modify(Control23)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Format"(Control 10)".

        modify(Control24)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Formatting Culture"(Control 11)".

        modify(Test)
        {
            Visible = false;
        }
        modify(TestText)
        {
            Visible = false;
        }
        modify(Control18)
        {
            Visible = false;
        }
        modify(ResultText)
        {
            Visible = false;
        }
        modify(UpdateResultLbl)
        {
            Visible = false;
        }
    }
    var
        FindValueEnabledExpr: Boolean;
        ReplaceValueEnabledExpr: Boolean;
        StartPositionEnabledExpr: Boolean;
        LengthEnabledExpr: Boolean;
        DateFormatEnabledExpr: Boolean;
        DataFormattingCultureEnabledExpr: Boolean;


    //Unsupported feature: Code Modification on "UpdateEnabled(PROCEDURE 1)".

    //procedure UpdateEnabled();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        FindValueVisibleExpr :=
          "Transformation Type" IN ["Transformation Type"::Replace,"Transformation Type"::"Regular Expression - Replace",
                                    "Transformation Type"::"Regular Expression - Match"];
        ReplaceValueVisibleExpr :=
          "Transformation Type" IN ["Transformation Type"::"Regular Expression - Replace","Transformation Type"::Replace];
        StartPositionVisibleExpr :=
          "Transformation Type" IN ["Transformation Type"::Substring];
        LengthVisibleExpr :=
          "Transformation Type" IN ["Transformation Type"::Substring];
        DateFormatVisibleExpr :=
          "Transformation Type" IN ["Transformation Type"::"Date and Time Formatting","Transformation Type"::"Date Formatting",
                                    "Transformation Type"::"Decimal Formatting"];
        DataFormattingCultureVisibleExpr :=
          "Transformation Type" IN ["Transformation Type"::"Date and Time Formatting","Transformation Type"::"Date Formatting",
                                    "Transformation Type"::"Decimal Formatting"];
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        FindValueEnabledExpr :=
          "Transformation Type" IN ["Transformation Type"::Replace,"Transformation Type"::"Regular Expression"];
        ReplaceValueEnabledExpr :=
          "Transformation Type" IN ["Transformation Type"::"Regular Expression","Transformation Type"::Replace];
        StartPositionEnabledExpr :=
          "Transformation Type" IN ["Transformation Type"::Substring];
        LengthEnabledExpr :=
          "Transformation Type" IN ["Transformation Type"::Substring];
        DateFormatEnabledExpr :=
          "Transformation Type" IN ["Transformation Type"::"Date and Time Formatting","Transformation Type"::"Decimal Formatting"];
        DataFormattingCultureEnabledExpr :=
          "Transformation Type" IN ["Transformation Type"::"Date and Time Formatting","Transformation Type"::"Decimal Formatting"];
        */
    //end;
}
