#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186749 pageextension52186749 extends "Item Tracking Summary"
{
    layout
    {
        modify("Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Date")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
        }
        modify("Total Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Total Requested Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Current Pending Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Total Available Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Current Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Total Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Content")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Bin Content"(Control 34)".

        }
        modify("Selected Quantity")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Selected Quantity"(Control 2)".

            Editable = "Selected QuantityEditable";
        }
        modify(MaxQuantity1)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "MaxQuantity1(Control 27)".

        }
        modify(Selected1)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Selected1(Control 5)".

        }
        modify(Undefined1)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Undefined1(Control 6)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Date"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Quantity"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Requested Quantity"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Current Pending Quantity"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Available Quantity"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Current Reserved Quantity"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Reserved Quantity"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Content"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Selected Quantity"(Control 2)".


        //Unsupported feature: Property Deletion (Visible) on "Selectable(Control 1900545401)".


        //Unsupported feature: Property Deletion (GroupType) on "Selectable(Control 1900545401)".


        //Unsupported feature: Property Deletion (ToolTipML) on "MaxQuantity1(Control 27)".


        //Unsupported feature: Property Deletion (Visible) on "Selected(Control 1900724401)".


        //Unsupported feature: Property Deletion (GroupType) on "Selected(Control 1900724401)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Selected1(Control 5)".


        //Unsupported feature: Property Deletion (Visible) on "Undefined(Control 1900724101)".


        //Unsupported feature: Property Deletion (GroupType) on "Undefined(Control 1900724101)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Undefined1(Control 6)".

    }

    //Unsupported feature: Property Modification (Id) on "CurrItemTrackingCode(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //CurrItemTrackingCode : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CurrItemTrackingCode : 1006;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "xFilterRec(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //xFilterRec : 1006;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //xFilterRec : 1007;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "MaxQuantity1Visible(Variable 8075)".

    //var
    //>>>> ORIGINAL VALUE:
    //MaxQuantity1Visible : 8075;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MaxQuantity1Visible : 19054264;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Selected1Visible(Variable 5215)".

    //var
    //>>>> ORIGINAL VALUE:
    //Selected1Visible : 5215;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Selected1Visible : 19001414;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "Undefined1Visible(Variable 1540)".

    //var
    //>>>> ORIGINAL VALUE:
    //Undefined1Visible : 1540;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Undefined1Visible : 19007737;
    //Variable type has not been exported.

    var

        "Selected QuantityVisible": Boolean;

        "Bin ContentVisible": Boolean;

    var

        "Selected QuantityEditable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Undefined1Visible := TRUE;
    Selected1Visible := TRUE;
    MaxQuantity1Visible := TRUE;
    BinContentVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    "Bin ContentVisible" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateSelectedQuantity;

    BinContentVisible := CurrBinCode <> '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateSelectedQuantity;

    "Bin ContentVisible" := CurrBinCode <> '';

    IF "Selected QuantityVisible" THEN BEGIN
    END
    ELSE
      IF "Serial No." <> '' THEN;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSources(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSelectionMode(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetSelectionMode(PROCEDURE 2)".

    //procedure SetSelectionMode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SelectedQuantityVisible := SelectionMode;
    SelectedQuantityEditable := SelectionMode;
    MaxQuantity1Visible := SelectionMode;
    Selected1Visible := SelectionMode;
    Undefined1Visible := SelectionMode;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Selected QuantityVisible" := SelectionMode;
    "Selected QuantityEditable" := SelectionMode;
    #3..5
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetMaxQuantity(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentBinAndItemTrkgCode(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "SetCurrentBinAndItemTrkgCode(PROCEDURE 8)".

    //procedure SetCurrentBinAndItemTrkgCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTrackingDataCollection.SetCurrentBinAndItemTrkgCode(BinCode,ItemTrackingCode);
    BinContentVisible := BinCode <> '';
    CurrBinCode := BinCode;
    CurrItemTrackingCode := ItemTrackingCode;
    OnAfterSetCurrentBinAndItemTrkgCode(CurrBinCode,CurrItemTrackingCode,BinContentVisible,Rec,TempReservEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemTrackingDataCollection.SetCurrentBinAndItemTrkgCode(BinCode,ItemTrackingCode);
    "Bin ContentVisible" := BinCode <> '';
    CurrBinCode := BinCode;
    CurrItemTrackingCode := ItemTrackingCode;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateSelectedQuantity(PROCEDURE 4)".

    //procedure UpdateSelectedQuantity();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT SelectedQuantityVisible THEN
      EXIT;
    IF MODIFY THEN; // Ensure that changes to current rec are included in CALCSUMS
    xEntrySummary := Rec;
    CALCSUMS("Selected Quantity");
    SelectedQuantity := "Selected Quantity";
    Rec := xEntrySummary;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT "Selected QuantityVisible" THEN
    #2..7
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "GetSelected(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: BinContentForm) (VariableCollection) on "DrillDownBinContent(PROCEDURE 11)".



    //Unsupported feature: Code Modification on "DrillDownBinContent(PROCEDURE 11)".

    //procedure DrillDownBinContent();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF CurrBinCode = '' THEN
      EXIT;
    TempReservEntry.RESET;
    #4..18
    IF FieldNumber = FIELDNO("Bin Content") THEN
      BinContent.SETRANGE("Bin Code",CurrBinCode);

    PAGE.RUNMODAL(PAGE::"Bin Content",BinContent);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..21
    BinContentForm.SETTABLEVIEW(BinContent);
    BinContentForm.RUNMODAL;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (Local) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Name) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6)".

    //procedure OnAfterSetCurrentBinAndItemTrkgCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemTrackingDataCollection.AutoSelectLotSerialNo(Rec,MaxQuantity);
    */
    //end;

    local procedure SelectedQuantityOnAfterValidat()
    begin
        //UpdateSelectedQuantity;
        CurrPage.Update;
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6).CurrBinCode(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6).CurrItemTrackingCode(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6).BinContentVisible(Parameter 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6).EntrySummary(Parameter 1003)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterSetCurrentBinAndItemTrkgCode(PROCEDURE 6).ReservationEntry(Parameter 1004)".

}
