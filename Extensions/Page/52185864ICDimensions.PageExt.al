#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185864 pageextension52185864 extends "IC Dimensions" 
{
    Caption = 'IC Dimensions';
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        // modify("Map-to Dimension Code")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Map-to Dimension Code"(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify("IC Dimension &Values")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Map to Dim. with Same Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(CopyFromDimensions)
        {

            //Unsupported feature: Property Modification (Name) on "CopyFromDimensions(Action 13)".

            ApplicationArea = Basic;
        }
        modify(Import)
        {
            ApplicationArea = Basic;
        }
        modify("E&xport")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Dimension &Values"(Action 16)".


        //Unsupported feature: Property Deletion (Promoted) on ""IC Dimension &Values"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""IC Dimension &Values"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""IC Dimension &Values"(Action 16)".


        //Unsupported feature: Code Modification on ""Map to Dim. with Same Code"(Action 17).OnAction".

        //trigger  with Same Code"(Action 17)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICDimension);
            IF ICDimension.FIND('-') AND ConfirmManagement.ConfirmProcess(Text000,TRUE) THEN
              REPEAT
                ICMapping.MapIncomingICDimensions(ICDimension);
              UNTIL ICDimension.NEXT = 0;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICDimension);
            IF ICDimension.FIND('-') AND CONFIRM(Text000) THEN
            #3..5
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Map to Dim. with Same Code"(Action 17)".


        //Unsupported feature: Property Deletion (Promoted) on ""Map to Dim. with Same Code"(Action 17)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Map to Dim. with Same Code"(Action 17)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Map to Dim. with Same Code"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyFromDimensions(Action 13)".


        //Unsupported feature: Property Deletion (Promoted) on "CopyFromDimensions(Action 13)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CopyFromDimensions(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CopyFromDimensions(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Import(Action 18)".


        //Unsupported feature: Property Deletion (Promoted) on "Import(Action 18)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Import(Action 18)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Import(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xport"(Action 19)".


        //Unsupported feature: Property Deletion (Promoted) on ""E&xport"(Action 19)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""E&xport"(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""E&xport"(Action 19)".

    }


    //Unsupported feature: Code Modification on "CopyFromDimensions(PROCEDURE 1)".

    //procedure CopyFromDimensions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT ConfirmManagement.ConfirmProcess(Text004,TRUE) THEN
          EXIT;

        ICDimVal.LOCKTABLE;
        #5..31
                  ICDimVal.Indentation := PrevIndentation;
                  ICDimVal.INSERT;
                END;
                PrevIndentation := ICDimVal.Indentation;
                IF DimVal."Dimension Value Type" = DimVal."Dimension Value Type"::"Begin-Total" THEN
                  PrevIndentation := PrevIndentation + 1;
              UNTIL DimVal.NEXT = 0;
          UNTIL Dim.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT CONFIRM(Text004,FALSE) THEN
        #2..34
                PrevIndentation := DimVal.Indentation;
        #36..39
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CopyFromDimensions(PROCEDURE 1).ConfirmManagement(Variable 1007)".


    //Unsupported feature: Property Modification (Id) on "ImportFromXML(PROCEDURE 2).ICDimIO(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "ImportFromXML(PROCEDURE 2).IFile(Variable 1001)".


    //Unsupported feature: Property Modification (Id) on "ImportFromXML(PROCEDURE 2).IStr(Variable 1000)".


    //Unsupported feature: Move on "ImportFromXML(PROCEDURE 2).FileName(Variable 1004)".


    //Unsupported feature: Move on "ExportToXML(PROCEDURE 3).FileName(Variable 1004)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
