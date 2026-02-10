#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186179 pageextension52186179 extends "Dimensions Template List" 
{

    //Unsupported feature: Property Modification (Name) on ""Dimensions Template List"(Page 1343)".

    layout
    {
        modify("Dimension Code")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension Value Code")
        {
            ApplicationArea = Basic;
        }
        modify("<Dimension Value Code>")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Value Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Dimension Value Code>"(Control 5)".

    }
    var
        TempMiniDimensionsTemplate: Record "Dimensions Template" temporary;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: TempMiniDimensionsTemplate)()
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
        MasterRecordCodeFilter := GETFILTER("Master Record Template Code");
        TableFilterId := GETFILTER("Table Id");

        #4..6
        MasterRecordCodeWithRightLenght := COPYSTR(MasterRecordCodeFilter,1,10);
        EVALUATE(TableID,TableFilterId);

        TempDimensionsTemplate.InitializeTemplatesFromMasterRecordTemplate(MasterRecordCodeWithRightLenght,Rec,TableID);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        TempMiniDimensionsTemplate.InitializeTemplatesFromMasterRecordTemplate(MasterRecordCodeWithRightLenght,Rec,TableID);
        */
    //end;
}
