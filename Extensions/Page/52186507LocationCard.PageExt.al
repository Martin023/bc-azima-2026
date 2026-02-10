#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186507 pageextension52186507 extends "Location Card"
{
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
        modify("Use As In-Transit")
        {
            ApplicationArea = Basic;
        }
        modify("Address & Contact")
        {
            Caption = 'Communication';

            //Unsupported feature: Property Modification (Name) on ""Address & Contact"(Control 1902768601)".

        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Level) on "Address(Control 6)".

            ApplicationArea = Basic;
        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Address 2"(Control 8)".

            ApplicationArea = Basic;
        }
        modify("Post Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Post Code"(Control 10)".

            ApplicationArea = Basic;
        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 35)".

            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Country/Region Code"(Control 14)".

            ApplicationArea = Basic;
        }
        modify(Contact)
        {

            //Unsupported feature: Property Modification (Level) on "Contact(Control 12)".

            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Phone No."(Control 18)".

            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Fax No."(Control 28)".

            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {

            //Unsupported feature: Property Modification (Level) on ""E-Mail"(Control 30)".

            ApplicationArea = Basic;
        }
        modify("Home Page")
        {

            //Unsupported feature: Property Modification (Level) on ""Home Page"(Control 26)".

            ApplicationArea = Basic;
        }
        modify("Require Receive")
        {
            ApplicationArea = Basic;
            Enabled = "Require ReceiveEnable";
        }
        modify("Require Shipment")
        {
            ApplicationArea = Basic;
            Enabled = "Require ShipmentEnable";
        }
        modify("Require Put-away")
        {
            ApplicationArea = Basic;
            Enabled = "Require Put-awayEnable";
        }
        modify("Use Put-away Worksheet")
        {
            ApplicationArea = Basic;
            Enabled = "Use Put-away WorksheetEnable";
        }
        modify("Require Pick")
        {
            ApplicationArea = Basic;
            Enabled = "Require PickEnable";
        }
        modify("Bin Mandatory")
        {
            ApplicationArea = Basic;
            Enabled = "Bin MandatoryEnable";
        }
        modify("Directed Put-away and Pick")
        {
            ApplicationArea = Basic;
        }
        modify("Use ADCS")
        {
            ApplicationArea = Basic;
            Enabled = "Use ADCSEnable";
        }
        modify("Default Bin Selection")
        {
            ApplicationArea = Basic;
            Enabled = "Default Bin SelectionEnable";
        }
        modify("Outbound Whse. Handling Time")
        {
            ApplicationArea = Basic;
        }
        modify("Inbound Whse. Handling Time")
        {
            ApplicationArea = Basic;
        }
        modify("Base Calendar Code")
        {
            ApplicationArea = Basic;
            Enabled = "Base Calendar CodeEnable";
        }
        modify("Customized Calendar")
        {
            ApplicationArea = Basic;
        }
        modify("Use Cross-Docking")
        {
            ApplicationArea = Basic;
            Enabled = "Use Cross-DockingEnable";
        }
        modify("Cross-Dock Due Date Calc.")
        {
            ApplicationArea = Basic;
        }
        modify("Receipt Bin Code")
        {
            ApplicationArea = Basic;
            Enabled = "Receipt Bin CodeEnable";
        }
        modify("Shipment Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Open Shop Floor Bin Code")
        {
            ApplicationArea = Basic;
            Enabled = "Open Shop Floor Bin CodeEnable";
        }
        modify("To-Production Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("From-Production Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Adjustment Bin Code")
        {
            ApplicationArea = Basic;
            Enabled = "Adjustment Bin CodeEnable";
        }
        modify("Cross-Dock Bin Code")
        {
            ApplicationArea = Basic;
            Enabled = "Cross-Dock Bin CodeEnable";
        }
        modify("To-Assembly Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("From-Assembly Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Asm.-to-Order Shpt. Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Special Equipment")
        {
            ApplicationArea = Basic;
            Enabled = "Special EquipmentEnable";
        }
        modify("Bin Capacity Policy")
        {
            ApplicationArea = Basic;
            Enabled = "Bin Capacity PolicyEnable";
        }
        modify("Allow Breakbulk")
        {
            ApplicationArea = Basic;
            Enabled = "Allow BreakbulkEnable";
        }
        modify("Put-away Template Code")
        {
            ApplicationArea = Basic;
            Enabled = "Put-away Template CodeEnable";
        }
        modify("Always Create Put-away Line")
        {
            ApplicationArea = Basic;
        }
        modify("Always Create Pick Line")
        {
            ApplicationArea = Basic;
            Enabled = "Always Create Pick LineEnable";
        }
        modify("Pick According to FEFO")
        {
            ApplicationArea = Basic;
            Enabled = "Pick According to FEFOEnable";
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use As In-Transit"(Control 24)".


        //Unsupported feature: Property Deletion (GroupType) on ""Address & Contact"(Control 1902768601)".

        modify(AddressDetails)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 14)".

        modify(ShowMap)
        {
            Visible = false;
        }
        modify(ContactDetails)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Contact(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 28)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Home Page"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Require Receive"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Require Shipment"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Require Put-away"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Put-away Worksheet"(Control 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Require Pick"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Mandatory"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Directed Put-away and Pick"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use ADCS"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Bin Selection"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Whse. Handling Time"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound Whse. Handling Time"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Calendar Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customized Calendar"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Cross-Docking"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Dock Due Date Calc."(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receipt Bin Code"(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Bin Code"(Control 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Open Shop Floor Bin Code"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To-Production Bin Code"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From-Production Bin Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjustment Bin Code"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Dock Bin Code"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To-Assembly Bin Code"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""From-Assembly Bin Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Asm.-to-Order Shpt. Bin Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Special Equipment"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Capacity Policy"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Breakbulk"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-away Template Code"(Control 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Always Create Put-away Line"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Always Create Pick Line"(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pick According to FEFO"(Control 95)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter(Name; Address)
    }
    actions
    {
        modify("&Resource Locations")
        {
            ApplicationArea = Basic;
        }
        modify("&Zones")
        {
            ApplicationArea = Basic;
        }
        modify("&Bins")
        {
            ApplicationArea = Basic;
        }
        modify("Online Map")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Resource Locations"(Action 32)".

        modify("Inventory Posting Setup")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Zones"(Action 7300)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Bins"(Action 7302)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Online Map"(Action 101)".


        //Unsupported feature: Property Deletion (Promoted) on ""Online Map"(Action 101)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Online Map"(Action 101)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Online Map"(Action 101)".

        addafter("&Resource Locations")
        {
            separator(Action7301)
            {
            }
        }
        addafter("&Bins")
        {
            separator(Action97)
            {
            }
        }
    }

    var

        "Base Calendar CodeEnable": Boolean;

        "Bin Capacity PolicyEnable": Boolean;

        "Special EquipmentEnable": Boolean;

        "Allow BreakbulkEnable": Boolean;

        "Put-away Template CodeEnable": Boolean;

        "Always Create Pick LineEnable": Boolean;

    var

        "Open Shop Floor Bin CodeEnable": Boolean;

    var

        "Receipt Bin CodeEnable": Boolean;

    var

        "Adjustment Bin CodeEnable": Boolean;

    var

        "Pick According to FEFOEnable": Boolean;

        "Cross-Dock Bin CodeEnable": Boolean;

    var

        "Use ADCSEnable": Boolean;

        "Default Bin SelectionEnable": Boolean;

        "Require PickEnable": Boolean;

        "Require Put-awayEnable": Boolean;

        "Require ReceiveEnable": Boolean;

        "Require ShipmentEnable": Boolean;

        "Bin MandatoryEnable": Boolean;

        "Use Put-away WorksheetEnable": Boolean;

        "Use Cross-DockingEnable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UseCrossDockingEnable := TRUE;
    UsePutAwayWorksheetEnable := TRUE;
    BinMandatoryEnable := TRUE;
    RequireShipmentEnable := TRUE;
    RequireReceiveEnable := TRUE;
    RequirePutAwayEnable := TRUE;
    RequirePickEnable := TRUE;
    DefaultBinSelectionEnable := TRUE;
    UseADCSEnable := TRUE;
    DirectedPutawayandPickEnable := TRUE;
    CrossDockBinCodeEnable := TRUE;
    PickAccordingToFEFOEnable := TRUE;
    AdjustmentBinCodeEnable := TRUE;
    ShipmentBinCodeEnable := TRUE;
    ReceiptBinCodeEnable := TRUE;
    FromProductionBinCodeEnable := TRUE;
    ToProductionBinCodeEnable := TRUE;
    OpenShopFloorBinCodeEnable := TRUE;
    ToAssemblyBinCodeEnable := TRUE;
    FromAssemblyBinCodeEnable := TRUE;
    AssemblyShipmentBinCodeEnable := TRUE;
    CrossDockDueDateCalcEnable := TRUE;
    AlwaysCreatePutawayLineEnable := TRUE;
    AlwaysCreatePickLineEnable := TRUE;
    PutAwayTemplateCodeEnable := TRUE;
    AllowBreakbulkEnable := TRUE;
    SpecialEquipmentEnable := TRUE;
    BinCapacityPolicyEnable := TRUE;
    BaseCalendarCodeEnable := TRUE;
    InboundWhseHandlingTimeEnable := TRUE;
    OutboundWhseHandlingTimeEnable := TRUE;
    EditInTransit := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Use Cross-DockingEnable" := TRUE;
    "Use Put-away WorksheetEnable" := TRUE;
    "Bin MandatoryEnable" := TRUE;
    "Require ShipmentEnable" := TRUE;
    "Require ReceiveEnable" := TRUE;
    "Require Put-awayEnable" := TRUE;
    "Require PickEnable" := TRUE;
    "Default Bin SelectionEnable" := TRUE;
    "Use ADCSEnable" := TRUE;
    DirectedPutawayandPickEnable := TRUE;
    "Cross-Dock Bin CodeEnable" := TRUE;
    "Pick According to FEFOEnable" := TRUE;
    "Adjustment Bin CodeEnable" := TRUE;
    ShipmentBinCodeEnable := TRUE;
    "Receipt Bin CodeEnable" := TRUE;
    FromProductionBinCodeEnable := TRUE;
    ToProductionBinCodeEnable := TRUE;
    "Open Shop Floor Bin CodeEnable" := TRUE;
    #19..23
    "Always Create Pick LineEnable" := TRUE;
    "Put-away Template CodeEnable" := TRUE;
    "Allow BreakbulkEnable" := TRUE;
    "Special EquipmentEnable" := TRUE;
    "Bin Capacity PolicyEnable" := TRUE;
    "Base Calendar CodeEnable" := TRUE;
    #30..32
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateEnabled(PROCEDURE 1)".

    //procedure UpdateEnabled();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RequirePickEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequirePutAwayEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequireReceiveEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequireShipmentEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    OutboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    InboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    BinMandatoryEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    DirectedPutawayandPickEnable := NOT "Use As In-Transit" AND "Bin Mandatory";
    BaseCalendarCodeEnable := NOT "Use As In-Transit";

    BinCapacityPolicyEnable := "Directed Put-away and Pick";
    SpecialEquipmentEnable := "Directed Put-away and Pick";
    AllowBreakbulkEnable := "Directed Put-away and Pick";
    PutAwayTemplateCodeEnable := "Directed Put-away and Pick";
    UsePutAwayWorksheetEnable :=
      "Directed Put-away and Pick" OR ("Require Put-away" AND "Require Receive" AND NOT "Use As In-Transit");
    AlwaysCreatePickLineEnable := "Directed Put-away and Pick";
    AlwaysCreatePutawayLineEnable := "Directed Put-away and Pick";

    UseCrossDockingEnable := NOT "Use As In-Transit" AND "Require Receive" AND "Require Shipment" AND "Require Put-away" AND
      "Require Pick";
    CrossDockDueDateCalcEnable := "Use Cross-Docking";

    OpenShopFloorBinCodeEnable := "Bin Mandatory";
    ToProductionBinCodeEnable := "Bin Mandatory";
    FromProductionBinCodeEnable := "Bin Mandatory";
    ReceiptBinCodeEnable := "Bin Mandatory" AND "Require Receive";
    ShipmentBinCodeEnable := "Bin Mandatory" AND "Require Shipment";
    AdjustmentBinCodeEnable := "Directed Put-away and Pick";
    CrossDockBinCodeEnable := "Bin Mandatory" AND "Use Cross-Docking";
    ToAssemblyBinCodeEnable := "Bin Mandatory";
    FromAssemblyBinCodeEnable := "Bin Mandatory";
    AssemblyShipmentBinCodeEnable := "Bin Mandatory" AND NOT ShipmentBinCodeEnable;
    DefaultBinSelectionEnable := "Bin Mandatory" AND NOT "Directed Put-away and Pick";
    UseADCSEnable := NOT "Use As In-Transit" AND "Directed Put-away and Pick";
    PickAccordingToFEFOEnable := "Require Pick" AND "Bin Mandatory";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Require PickEnable" := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    "Require Put-awayEnable" := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    "Require ReceiveEnable" := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    "Require ShipmentEnable" := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    OutboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    InboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    "Bin MandatoryEnable" := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    DirectedPutawayandPickEnable := NOT "Use As In-Transit" AND "Bin Mandatory";
    "Base Calendar CodeEnable" := NOT "Use As In-Transit";

    "Bin Capacity PolicyEnable" := "Directed Put-away and Pick";
    "Special EquipmentEnable" := "Directed Put-away and Pick";
    "Allow BreakbulkEnable" := "Directed Put-away and Pick";
    "Put-away Template CodeEnable" := "Directed Put-away and Pick";
    "Use Put-away WorksheetEnable" := "Directed Put-away and Pick" OR ("Require Put-away" AND "Require Receive" AND NOT
                                                                       "Use As In-Transit");
    "Always Create Pick LineEnable" := "Directed Put-away and Pick";
    AlwaysCreatePutawayLineEnable := "Directed Put-away and Pick";

    "Use Cross-DockingEnable" := NOT "Use As In-Transit" AND "Require Receive" AND "Require Shipment" AND "Require Put-away" AND
    #21..23
    "Open Shop Floor Bin CodeEnable" := "Bin Mandatory";
    ToProductionBinCodeEnable := "Bin Mandatory";
    FromProductionBinCodeEnable := "Bin Mandatory";
    "Receipt Bin CodeEnable" := "Bin Mandatory" AND "Require Receive";
    ShipmentBinCodeEnable := "Bin Mandatory" AND "Require Shipment";
    "Adjustment Bin CodeEnable" := "Directed Put-away and Pick";
    "Cross-Dock Bin CodeEnable" := "Bin Mandatory" AND "Use Cross-Docking";
    #31..33
    "Default Bin SelectionEnable" := "Bin Mandatory" AND NOT "Directed Put-away and Pick";
    "Use ADCSEnable" := NOT "Use As In-Transit" AND "Directed Put-away and Pick";
    "Pick According to FEFOEnable" := "Require Pick" AND "Bin Mandatory";
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
