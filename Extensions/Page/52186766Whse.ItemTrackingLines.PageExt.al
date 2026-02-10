#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186766 pageextension52186766 extends "Whse. Item Tracking Lines"
{
    layout
    {
        modify(TextCaption)
        {
            ApplicationArea = Basic;
        }
        modify("SourceQuantityArray[1]")
        {
            ApplicationArea = Basic;
        }
        modify(Handle1)
        {
            ApplicationArea = Basic;
        }
        modify(Text003)
        {
            ApplicationArea = Basic;
        }
        modify("TotalWhseItemTrackingLine.""Quantity (Base)""")
        {
            ApplicationArea = Basic;
        }
        modify(Handle2)
        {
            ApplicationArea = Basic;
        }
        modify(Control52)
        {
            ApplicationArea = Basic;
        }
        modify(Quantity3)
        {
            ApplicationArea = Basic;
        }
        modify(Handle3)
        {
            ApplicationArea = Basic;
        }
        modify("ItemTrackingCode.Code")
        {
            ApplicationArea = Basic;
        }
        modify("ItemTrackingCode.Description")
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("New Serial No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""New Serial No."(Control 10)".

            Editable = "New Serial No.Editable";
        }
        modify("Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("New Lot No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""New Lot No."(Control 46)".

            Editable = "New Lot No.Editable";
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
            Editable = "Expiration DateEditable";
        }
        modify("New Expiration Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""New Expiration Date"(Control 16)".

            Editable = "New Expiration DateEditable";
        }
        modify("Warranty Date")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle (Base)")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Qty. to Handle (Base)"(Control 14)".

            Editable = "Qty. to Handle (Base)Editable";
        }
        modify("Quantity Handled (Base)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ShowCaption) on "TextCaption(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SourceQuantityArray[1]"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Handle1(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalWhseItemTrackingLine.""Quantity (Base)"""(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Handle2(Control 36)".


        //Unsupported feature: Property Deletion (ShowCaption) on "Quantity3(Control 40)".


        //Unsupported feature: Property Deletion (ShowCaption) on "Handle3(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ItemTrackingCode.Code"(Control 503)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ItemTrackingCode.Description"(Control 505)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Serial No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Lot No."(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Expiration Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Date"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle (Base)"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Handled (Base)"(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Reclass_SerialNoInfoCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Reclass_SerialNoInfoCard"(Action 37)".

            ApplicationArea = Basic;
        }
        modify("Reclass_LotNoInfoCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Reclass_LotNoInfoCard"(Action 42)".

            ApplicationArea = Basic;
        }
        modify("New S&erial No. Information")
        {
            ApplicationArea = Basic;
        }
        modify("New L&ot No. Information")
        {
            ApplicationArea = Basic;
        }
        modify("Line_SerialNoInfoCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Line_SerialNoInfoCard"(Action 21)".

            ApplicationArea = Basic;
        }
        modify("Line_LotNoInforCard")
        {

            //Unsupported feature: Property Modification (Name) on ""Line_LotNoInforCard"(Action 33)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclass_SerialNoInfoCard"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reclass_LotNoInfoCard"(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New S&erial No. Information"(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New L&ot No. Information"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line_SerialNoInfoCard"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line_LotNoInforCard"(Action 33)".

    }

    //Unsupported feature: Property Modification (Id) on ""New L&ot No. Information"(Action 55).OnAction.LotNoInfoNew(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"New L&ot No. Information" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"New L&ot No. Information" : 1002;
    //Variable type has not been exported.

    var

        "Qty. to Handle (Base)Visible": Boolean;

        "New Serial No.Visible": Boolean;

        "New Lot No.Visible": Boolean;

        "New Expiration DateVisible": Boolean;

    var

        "Qty. to Handle (Base)Editable": Boolean;

        "New Serial No.Editable": Boolean;

        "New Lot No.Editable": Boolean;

        "New Expiration DateEditable": Boolean;

        "Expiration DateEditable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateExpDateEditable;
    CalculateSums;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateExpDateEditable;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ExpirationDateEditable := TRUE;
    NewExpirationDateEditable := TRUE;
    NewLotNoEditable := TRUE;
    NewSerialNoEditable := TRUE;
    QtyToHandleBaseEditable := TRUE;
    ButtonLineVisible := TRUE;
    QtyToHandleBaseVisible := TRUE;
    Handle3Visible := TRUE;
    Handle2Visible := TRUE;
    Handle1Visible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Expiration DateEditable" := TRUE;
    "New Expiration DateEditable" := TRUE;
    "New Lot No.Editable" := TRUE;
    "New Serial No.Editable" := TRUE;
    "Qty. to Handle (Base)Editable" := TRUE;
    ButtonLineVisible := TRUE;
    "Qty. to Handle (Base)Visible" := TRUE;
    #8..10
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Controls) (VariableCollection) on "SetSource(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSource(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetSource(PROCEDURE 3)".

    //procedure SetSource();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FormUpdated := FALSE;
    FormSourceType := SourceType;
    WhseWorksheetLine := WhseWrkshLine;
    GetItem(WhseWorksheetLine."Item No.");
    ItemTrackingMgt.CheckWhseItemTrkgSetup(
      WhseWorksheetLine."Item No.",WhseSNRequired,WhseLNRequired,TRUE);

    SetControlsAsHandle;
    Reclass := IsReclass(FormSourceType,WhseWorksheetLine."Worksheet Template Name");
    SetControlsAsReclass;

    SetFilters(Rec,FormSourceType);
    ItemTrackingMgt.UpdateQuantities(
      WhseWorksheetLine,TotalWhseItemTrackingLine,SourceQuantityArray,UndefinedQtyArray,FormSourceType);
    OnAfterSetSource(WhseWorksheetLine,WhseWrkshLine,SourceType);
    UpdateColorOfQty;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    IF SourceType = DATABASE::"Warehouse Journal Line" THEN
      SetControls(Controls::Handle,FALSE)
    ELSE
      SetControls(Controls::Handle,TRUE);

    Reclass := IsReclass(SourceType,WhseWorksheetLine."Worksheet Template Name");
    SetControls(Controls::Reclass,Reclass);

    SetFilters(Rec,FormSourceType);
    SourceQuantityArray[1] := ABS(WhseWorksheetLine."Qty. (Base)");
    SourceQuantityArray[2] := ABS(WhseWorksheetLine."Qty. to Handle (Base)");
    CalculateSums;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetFilters(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "UpdateExpDateEditable(PROCEDURE 42)".

    //procedure UpdateExpDateEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ExpirationDateEditable := NOT BlockExpDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Expiration DateEditable" := NOT BlockExpDate;
    */
    //end;


    //Unsupported feature: Code Modification on "CalculateSums(PROCEDURE 2)".

    //procedure CalculateSums();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTrackingMgt.CalculateSums(
      WhseWorksheetLine,TotalWhseItemTrackingLine,
      SourceQuantityArray,UndefinedQtyArray,FormSourceType);
    UpdateColorOfQty;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    WITH TotalWhseItemTrackingLine DO BEGIN
      SETCURRENTKEY(
        "Source ID","Source Type","Source Subtype","Source Batch Name",
        "Source Prod. Order Line","Source Ref. No.");
      SETRANGE("Source Type",FormSourceType);
      SETRANGE("Location Code",WhseWorksheetLine."Location Code");

      CASE FormSourceType OF
        DATABASE::"Posted Whse. Receipt Line",
        DATABASE::"Warehouse Shipment Line",
        DATABASE::"Whse. Internal Put-away Line",
        DATABASE::"Whse. Internal Pick Line",
        DATABASE::"Assembly Line",
        DATABASE::"Internal Movement Line":
          BEGIN
            SETRANGE("Source ID",WhseWorksheetLine."Whse. Document No.");
            SETRANGE("Source Ref. No.",WhseWorksheetLine."Whse. Document Line No.");
          END;
        DATABASE::"Prod. Order Component":
          BEGIN
            SETRANGE("Source Subtype",WhseWorksheetLine."Source Subtype");
            SETRANGE("Source ID",WhseWorksheetLine."Source No.");
            SETRANGE("Source Prod. Order Line",WhseWorksheetLine."Source Line No.");
            SETRANGE("Source Ref. No.",WhseWorksheetLine."Source Subline No.");
          END;
        DATABASE::"Whse. Worksheet Line",
        DATABASE::"Warehouse Journal Line":
          BEGIN
            SETRANGE("Source Batch Name",WhseWorksheetLine."Worksheet Template Name");
            SETRANGE("Source ID",WhseWorksheetLine.Name);
            SETRANGE("Source Ref. No.",WhseWorksheetLine."Line No.");
          END;
      END;
      CALCSUMS("Quantity (Base)","Qty. to Handle (Base)");
    END;

    UpdateUndefinedQty;
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: QtyIsValid) (ReturnValueCollection) on "UpdateUndefinedQty(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "UpdateUndefinedQty(PROCEDURE 5)".

    //procedure UpdateUndefinedQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    QtyIsValid := ItemTrackingMgt.UpdateUndefinedQty(TotalWhseItemTrackingLine,SourceQuantityArray,UndefinedQtyArray);
    UpdateColorOfQty;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UndefinedQtyArray[1] := SourceQuantityArray[1] - TotalWhseItemTrackingLine."Quantity (Base)";
    UndefinedQtyArray[2] := SourceQuantityArray[2] - TotalWhseItemTrackingLine."Qty. to Handle (Base)";

    IF ABS(SourceQuantityArray[1]) < ABS(TotalWhseItemTrackingLine."Quantity (Base)") THEN BEGIN
      ColorOfQuantityArray[1] := 255;
      QtyIsValid := FALSE;
    END ELSE BEGIN
      ColorOfQuantityArray[1] := 0;
      QtyIsValid := TRUE;
    END;

    IF ABS(SourceQuantityArray[2]) < ABS(TotalWhseItemTrackingLine."Qty. to Handle (Base)") THEN
      ColorOfQuantityArray[2] := 255
    ELSE
      ColorOfQuantityArray[2] := 0;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "InsertItemTrackingLine(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "InsertItemTrackingLine(PROCEDURE 8)".

    //procedure InsertItemTrackingLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateUndefinedQty;
    SaveItemTrkgLine(TempInitialTrkgLine);
    "Lot No." := LotNo;
    #4..15
      InitExpirationDate;
    IF WhseItemTrackingLine2.FINDLAST THEN;
    "Entry No." := WhseItemTrackingLine2."Entry No." + 1;
    OnBeforeItemTrackingLineInsert(Rec,WhseWrkshLine);
    INSERT;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    INSERT;
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: Controls) (ParameterCollection) on "SetControls(PROCEDURE 13)".


    //Unsupported feature: Property Deletion (Attributes) on "OnBeforeItemTrackingLineInsert(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeItemTrackingLineInsert(PROCEDURE 13)".



    //Unsupported feature: Code Modification on "OnBeforeItemTrackingLineInsert(PROCEDURE 13)".

    //procedure OnBeforeItemTrackingLineInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CASE Controls OF
      Controls::Handle:
        BEGIN
          Handle1Visible := SetAccess;
          Handle2Visible := SetAccess;
          Handle3Visible := SetAccess;
          "Qty. to Handle (Base)Visible" := SetAccess;
          "Qty. to Handle (Base)Editable" := SetAccess;
        END;
      Controls::Reclass:
        BEGIN
          "New Serial No.Visible" := SetAccess;
          "New Serial No.Editable" := SetAccess;
          "New Lot No.Visible" := SetAccess;
          "New Lot No.Editable" := SetAccess;
          "New Expiration DateVisible" := SetAccess;
          "New Expiration DateEditable" := SetAccess;
          ButtonLineReclassVisible := SetAccess;
          ButtonLineVisible := NOT SetAccess;
        END;
    END;
    */
    //end;

    //Unsupported feature: Deletion (ReturnValueCollection) on "UpdateUndefinedQty(PROCEDURE 5).QtyIsValid(ReturnValue)".


    //Unsupported feature: Property Modification (Length) on "InsertItemTrackingLine(PROCEDURE 8).SerialNo(Parameter 1000)".


    //Unsupported feature: Property Modification (Length) on "InsertItemTrackingLine(PROCEDURE 8).LotNo(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnBeforeItemTrackingLineInsert(PROCEDURE 13).WhseItemTrackingLine(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "OnBeforeItemTrackingLineInsert(PROCEDURE 13).WhseWorksheetLine(Parameter 1001)".


    //Unsupported feature: Property Deletion (Subtype) on "OnBeforeItemTrackingLineInsert(PROCEDURE 13).WhseWorksheetLine(Parameter 1001)".


    //Unsupported feature: Property Modification (Data type) on "OnBeforeItemTrackingLineInsert(PROCEDURE 13).WhseWorksheetLine(Parameter 1001)".

}
