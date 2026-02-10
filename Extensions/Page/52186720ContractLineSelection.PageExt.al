#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186720 pageextension52186720 extends "Contract Line Selection" 
{
    layout
    {
        modify(SelectionFilter)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Item No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SelectionFilter(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Item No."(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Card")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Card"(Action 33)".

    }
    var
        AllServItems: Boolean;

    //Unsupported feature: Parameter Insertion (Parameter: AllServItem) (ParameterCollection) on "SetSelection(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSelection(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetSelection(PROCEDURE 1)".

    //procedure SetSelection();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CustomerNo := CustNo;
        ShipToCode := ShipNo;
        ContractType := CtrType;
        ContractNo := CtrNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        AllServItems := AllServItem;
        #1..4
        */
    //end;


    //Unsupported feature: Code Modification on "CheckServContractLine(PROCEDURE 3)".

    //procedure CheckServContractLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempServItem := Rec;

        ServContractLine.RESET;
        #4..16
        ServContractLine.SETRANGE("Contract Type",ServContractLine."Contract Type"::Contract);
        ServContractLine.SETFILTER("Contract No.",'<>%1',ServContract."Contract No.");
        IF ServContractLine.FINDFIRST THEN BEGIN
          IF NOT ConfirmManagement.ConfirmProcess(
               STRSUBSTNO(Text001,TempServItem.TABLECAPTION,TempServItem."No."),TRUE)
          THEN
            EXIT;
        END ELSE BEGIN
          ServContractLine.RESET;
          ServContractLine.SETCURRENTKEY("Service Item No.");
          ServContractLine.SETRANGE("Service Item No.",TempServItem."No.");
          ServContractLine.SETRANGE("Contract Type",ServContractLine."Contract Type"::Quote);
          ServContractLine.SETFILTER("Contract No.",'<>%1',ServContract."Contract No.");
          IF ServContractLine.FINDFIRST THEN
            IF NOT ConfirmManagement.ConfirmProcess(
                 STRSUBSTNO(Text001,TempServItem.TABLECAPTION,TempServItem."No."),TRUE)
            THEN
              EXIT;
        END;

        IF TempServItem."Ship-to Code" <> ServContract."Ship-to Code" THEN
          IF NOT ConfirmManagement.ConfirmProcess(
               STRSUBSTNO(Text002,TempServItem.TABLECAPTION,TempServItem."No."),TRUE)
          THEN
            EXIT;

        TempServItem.INSERT;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..19
          IF NOT CONFIRM(Text001,TRUE,TempServItem.TABLECAPTION,TempServItem."No.") THEN
        #23..30
            IF NOT CONFIRM(Text001,TRUE,TempServItem.TABLECAPTION,TempServItem."No.") THEN
        #34..37
          IF NOT CONFIRM(Text002,FALSE,TempServItem.TABLECAPTION,TempServItem."No.") THEN
        #41..43
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSelectionFilter(PROCEDURE 5)".


    //Unsupported feature: Deletion (VariableCollection) on "CheckServContractLine(PROCEDURE 3).ConfirmManagement(Variable 1000)".

}
