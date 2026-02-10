#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185640 pageextension52185640 extends "Check Availability"
{
    InstructionalText = 'The quantity on inventory is not sufficient to cover the net change in inventory. Do you still want to record the quantity?';
    layout
    {
        modify(AvailableInventory)
        {
            Visible = false;
        }
        modify(InventoryShortage)
        {
            Visible = false;
        }
        modify(ItemAvailabilityCheckDet)
        {
            Visible = false;
        }
        addfirst(Content)
        {
            group(Details)
            {
                Caption = 'Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field(InventoryQty;InventoryQty)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Available Inventory';
                //     DecimalPlaces = 0:5;
                //     Editable = false;
                // }
                field(GrossReq; GrossReq)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gross Requirement';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(ReservedReq; ReservedReq)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reserved Requirement';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(SchedRcpt; SchedRcpt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Scheduled Receipt';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(ReservedRcpt; ReservedRcpt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reserved Receipt';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(CurrentQuantity; CurrentQuantity)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                field(CurrentReservedQty; CurrentReservedQty)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Reserved Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                }
                // field(TotalQuantity;TotalQuantity)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Total Quantity';
                //     DecimalPlaces = 0:5;
                //     Editable = false;
                // }
                field(EarliestAvailDate; EarliestAvailDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Earliest Availability Date';
                    // DecimalPlaces = 0:5;
                    Editable = false;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(UnitOfMeasureCode; UnitOfMeasureCode)
                {
                    ApplicationArea = Basic;
                    Caption = 'Unit of Measure Code';
                    Editable = false;
                    Lookup = false;
                }
            }
        }
    }


    //Unsupported feature: Property Modification (Id) on "TotalQuantity(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //TotalQuantity : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalQuantity : 1020;
    //Variable type has not been exported.

    var
        UnitOfMeasureCode: Code[10];

    var
        GrossReq: Decimal;
        SchedRcpt: Decimal;
        ReservedReq: Decimal;
        ReservedRcpt: Decimal;
        CurrentQuantity: Decimal;
        CurrentReservedQty: Decimal;

    var
        EarliestAvailDate: Date;


    //Unsupported feature: Code Modification on "SetValues(PROCEDURE 9)".

    //procedure SetValues();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GET(ItemNo);
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetUnitOfMeasureCode(UnitOfMeasureCode);
    InventoryQty := InventoryQty2;
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetGrossReq(GrossReq);
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetReservedReq(ReservedReq);
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetSchedRcpt(SchedRcpt);
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetReservedRcpt(ReservedRcpt);
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetCurrentQuantity(CurrentQuantity);
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetCurrentReservedQty(CurrentReservedQty);
    TotalQuantity := TotalQuantity2;
    CurrPage.ItemAvailabilityCheckDet.PAGE.SetEarliestAvailDate(EarliestAvailDate);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GET(ItemNo2);
    UnitOfMeasureCode := UnitOfMeasureCode2;
    InventoryQty := InventoryQty2;
    GrossReq := GrossReq2;
    ReservedReq := ReservedReq2;
    SchedRcpt := SchedRcpt2;
    ReservedRcpt := ReservedRcpt2;
    CurrentQuantity := CurrentQuantity2;
    CurrentReservedQty := CurrentReservedQty2;
    TotalQuantity := TotalQuantity2;
    EarliestAvailDate := EarliestAvailDate2;
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).ItemNo(Parameter 1009)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).UnitOfMeasureCode(Parameter 1007)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).GrossReq(Parameter 1004)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).ReservedReq(Parameter 1006)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).SchedRcpt(Parameter 1003)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).ReservedRcpt(Parameter 1010)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).CurrentQuantity(Parameter 1002)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).CurrentReservedQty(Parameter 1008)".


    //Unsupported feature: Property Modification (Name) on "SetValues(PROCEDURE 9).EarliestAvailDate(Parameter 1000)".

}
