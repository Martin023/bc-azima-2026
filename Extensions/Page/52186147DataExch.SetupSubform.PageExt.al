#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186147 pageextension52186147 extends "Data Exch. Setup Subform" 
{
    layout
    {
        modify(CaptionField)
        {
            ApplicationArea = Basic;
        }
        modify(SourceField)
        {
            ApplicationArea = Basic;
        }
        modify("Default Value")
        {
            ApplicationArea = Basic;
        }
        modify("Transformation Rule")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CaptionField(Control 4)".


        //Unsupported feature: Code Modification on "SourceField(Control 5).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SourceAssistEdit(TempXMLBuffer);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            SourceAssistEdit(TempXMLStructure);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SourceField(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Value"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transformation Rule"(Control 8)".

    }
    actions
    {
        modify(DataExchDef)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DataExchDef(Action 7)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "DataExchDef(Action 7)".

    }

    var
        TempXMLStructure: Record "XML Buffer" temporary;

    //Unsupported feature: Property Deletion (Attributes) on "UpdateData(PROCEDURE 11)".


    //Unsupported feature: Property Deletion (Attributes) on "SetDataExchDefCode(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSuggestedField(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Attributes) on "SetXMLDefinition(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetXMLDefinition(PROCEDURE 3)".

    //procedure SetXMLDefinition();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempXMLBuffer.RESET;
        TempXMLBuffer.DELETEALL;

        IF XMLBuffer.FINDSET THEN
          REPEAT
            TempXMLBuffer.COPY(XMLBuffer);
            TempXMLBuffer.INSERT;
          UNTIL XMLBuffer.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TempXMLStructure.RESET;
        TempXMLStructure.DELETEALL;

        IF XMLStructure.FINDSET THEN
          REPEAT
            TempXMLStructure.COPY(XMLStructure);
            TempXMLStructure.INSERT;
          UNTIL XMLStructure.NEXT = 0;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSourceToBeMandatory(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Name) on "SetXMLDefinition(PROCEDURE 3).XMLBuffer(Parameter 1000)".

}
