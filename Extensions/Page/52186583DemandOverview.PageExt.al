#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186583 pageextension52186583 extends "Demand Overview"
{
    layout
    {
        modify(StartDate)
        {
            ApplicationArea = Basic;
        }
        modify(EndDate)
        {
            ApplicationArea = Basic;
        }
        modify(DemandType)
        {
            ApplicationArea = Basic;
        }
        modify(DemandNoCtrl)
        {
            ApplicationArea = Basic;
        }
        modify(IsCalculated)
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Matches Criteria")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify(SourceTypeText)
        {
            ApplicationArea = Basic;
        }
        modify("Source Order Status")
        {
            ApplicationArea = Basic;
        }
        modify("Source ID")
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
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(QuantityText)
        {
            ApplicationArea = Basic;
        }
        modify(ReservedQuantityText)
        {
            ApplicationArea = Basic;
        }
        modify("Running Total")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Running Total")
        {
            ApplicationArea = Basic;
        }
        modify("Supply Running Total")
        {
            ApplicationArea = Basic;
        }
        modify("Demand Running Total")
        {
            ApplicationArea = Basic;
        }
        modify(ItemFilter)
        {
            ApplicationArea = Basic;
        }
        modify(LocationFilter)
        {
            ApplicationArea = Basic;
        }
        modify(VariantFilter)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "StartDate(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndDate(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DemandType(Control 43)".


        //Unsupported feature: Code Modification on "DemandNoCtrl(Control 45).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE DemandType OF
          DemandType::Sales:
            BEGIN
        #4..36
            END;
          DemandType::Jobs:
            BEGIN
              Job.SETRANGE(Status,Job.Status::Open);
              JobList.SETTABLEVIEW(Job);
              JobList.LOOKUPMODE := TRUE;
              IF JobList.RUNMODAL = ACTION::LookupOK THEN BEGIN
        #44..59
              EXIT(FALSE);
            END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..39
              Job.SETRANGE(Status,Job.Status::Order);
        #41..62
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DemandNoCtrl(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IsCalculated(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Matches Criteria"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Order Status"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source ID"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QuantityText(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReservedQuantityText(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Running Total"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Running Total"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Supply Running Total"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Demand Running Total"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemFilter(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LocationFilter(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VariantFilter(Control 49)".

    }
    actions
    {
        modify(Calculate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Calculate(Action 65)".

    }


    //Unsupported feature: Property Modification (Id) on "DemandNoCtrlEnable(Variable 2080)".

    //var
    //>>>> ORIGINAL VALUE:
    //DemandNoCtrlEnable : 2080;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DemandNoCtrlEnable : 19038271;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemNoHideValue(Variable 1153)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoHideValue : 1153;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoHideValue : 19067338;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemNoEmphasize(Variable 8303)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoEmphasize : 8303;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoEmphasize : 19054492;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TypeEmphasize(Variable 6671)".

    //var
    //>>>> ORIGINAL VALUE:
    //TypeEmphasize : 6671;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TypeEmphasize : 19012868;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TypeIndent(Variable 9080)".

    //var
    //>>>> ORIGINAL VALUE:
    //TypeIndent : 9080;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TypeIndent : 19015277;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SourceTypeHideValue(Variable 1193)".

    //var
    //>>>> ORIGINAL VALUE:
    //SourceTypeHideValue : 1193;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceTypeHideValue : 19007390;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SourceTypeText(Variable 4593)".

    //var
    //>>>> ORIGINAL VALUE:
    //SourceTypeText : 4593;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceTypeText : 19060780;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SourceOrderStatusHideValue(Variable 6400)".

    //var
    //>>>> ORIGINAL VALUE:
    //SourceOrderStatusHideValue : 6400;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceOrderStatusHideValue : 19072585;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DescriptionEmphasize(Variable 4350)".

    //var
    //>>>> ORIGINAL VALUE:
    //DescriptionEmphasize : 4350;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DescriptionEmphasize : 19010547;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "QuantityText(Variable 1128)".

    //var
    //>>>> ORIGINAL VALUE:
    //QuantityText : 1128;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //QuantityText : 19076211;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ReservedQuantityText(Variable 8095)".

    //var
    //>>>> ORIGINAL VALUE:
    //ReservedQuantityText : 8095;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReservedQuantityText : 19044286;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RunningTotalHideValue(Variable 1102)".

    //var
    //>>>> ORIGINAL VALUE:
    //RunningTotalHideValue : 1102;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RunningTotalHideValue : 19007299;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "RunningTotalEmphasize(Variable 9683)".

    //var
    //>>>> ORIGINAL VALUE:
    //RunningTotalEmphasize : 9683;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RunningTotalEmphasize : 19035876;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "InventoryRunningTotalHideValue(Variable 9121)".

    //var
    //>>>> ORIGINAL VALUE:
    //InventoryRunningTotalHideValue : 9121;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InventoryRunningTotalHideValue : 19055310;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "InventoryRunningTotalEmphasize(Variable 4919)".

    //var
    //>>>> ORIGINAL VALUE:
    //InventoryRunningTotalEmphasize : 4919;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InventoryRunningTotalEmphasize : 19021114;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SupplyRunningTotalHideValue(Variable 1903)".

    //var
    //>>>> ORIGINAL VALUE:
    //SupplyRunningTotalHideValue : 1903;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SupplyRunningTotalHideValue : 19048092;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SupplyRunningTotalEmphasize(Variable 6245)".

    //var
    //>>>> ORIGINAL VALUE:
    //SupplyRunningTotalEmphasize : 6245;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SupplyRunningTotalEmphasize : 19042436;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DemandRunningTotalHideValue(Variable 9127)".

    //var
    //>>>> ORIGINAL VALUE:
    //DemandRunningTotalHideValue : 9127;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DemandRunningTotalHideValue : 19075312;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DemandRunningTotalEmphasize(Variable 6320)".

    //var
    //>>>> ORIGINAL VALUE:
    //DemandRunningTotalEmphasize : 6320;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DemandRunningTotalEmphasize : 19012517;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "ApplyUserFilters(PROCEDURE 6)".

    //procedure ApplyUserFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AvailCalcOverview.RESET;
    AvailCalcOverview.SETFILTER("Item No.",ItemFilter);
    IF (StartDate <> 0D) OR (EndDate <> 0D) THEN BEGIN
      IF EndDate <> 0D THEN
        AvailCalcOverview.SETRANGE(Date,StartDate,EndDate)
      ELSE
        AvailCalcOverview.SETRANGE(Date,StartDate,DMY2DATE(31,12,9999));
    END;
    IF LocationFilter <> '' THEN
      AvailCalcOverview.SETFILTER("Location Code",LocationFilter);
    IF VariantFilter <> '' THEN
      AvailCalcOverview.SETFILTER("Variant Code",VariantFilter);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
        AvailCalcOverview.SETRANGE(Date,StartDate,99991231D);
    #8..12
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "InitTempTable(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetRecFilters(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetCalculationParameter(PROCEDURE 7)".


    local procedure RefreshTempTable(var AvailCalcOverview2: Record "Availability Calc. Overview"; var AvailCalcOverview: Record "Availability Calc. Overview")
    begin
        AvailCalcOverview2.Copy(Rec);

        begin
            Rec.Reset;
            if Rec.Find('-') then
                repeat
                    AvailCalcOverview := Rec;
                    if not AvailCalcOverview.Find or
                       ((Rec.Level = 0) and ((AvailCalcOverview.Next = 0) or (AvailCalcOverview.Level = 0)))
                    then begin
                        if Rec.Level = 0 then begin
                            AvailCalcOverview := Rec;
                            AvailCalcOverview.Find;
                            AvailCalcOverview.Delete(true);
                        end;
                        Rec.Delete;
                    end;
                until Rec.Next = 0;
        end;

        Rec.Copy(AvailCalcOverview2);
    end;

    local procedure GetDirection(): Integer
    begin
        if Rec.Ascending then
            exit(1);
        exit(-1);
    end;

    local procedure SourceTypeTextOnFormat(var Text: Text[1024])
    begin
        SourceTypeHideValue := false;
        // case Rec."Source Type" of
        //   Database::"Sales Line":
        //     Text := Text001;
        //   Database::"Service Line":
        //     Text := Text005;
        //   Database::"Job Planning Line":
        //     Text := Text006;
        //   Database::"Prod. Order Line":
        //     Text := Text002;
        //   Database::"Prod. Order Component":
        //     Text := Text007;
        //   Database::"Purchase Line":
        //     Text := Text003;
        //   Database::"Item Ledger Entry":
        //     Text := Text004;
        //   Database::"Transfer Line":
        //     Text := Text008;
        //   Database::"Assembly Header",
        //   Database::"Assembly Line":
        //     Text := Text009;
        //else
        SourceTypeHideValue := true;
    end;


    //Unsupported feature: Property Deletion (AccessByPermission).


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
