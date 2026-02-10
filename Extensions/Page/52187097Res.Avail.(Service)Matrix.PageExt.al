#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187097 pageextension52187097 extends "Res. Avail. (Service) Matrix"
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Skills)
        {
            ApplicationArea = Basic;
        }
        modify(SelectedDay)
        {
            ApplicationArea = Basic;
        }
        modify(Qtytoallocate)
        {
            ApplicationArea = Basic;
        }
        modify("Preferred Resource")
        {
            ApplicationArea = Basic;
        }
        modify(Skilled)
        {
            ApplicationArea = Basic;
        }
        modify("In Customer Zone")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""In Customer Zone"(Control 28)".

        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name2)
        {
            ApplicationArea = Basic;
        }
        modify(Field1)
        {
            ApplicationArea = Basic;
        }
        modify(Field2)
        {
            ApplicationArea = Basic;
        }
        modify(Field3)
        {
            ApplicationArea = Basic;
        }
        modify(Field4)
        {
            ApplicationArea = Basic;
        }
        modify(Field5)
        {
            ApplicationArea = Basic;
        }
        modify(Field6)
        {
            ApplicationArea = Basic;
        }
        modify(Field7)
        {
            ApplicationArea = Basic;
        }
        modify(Field8)
        {
            ApplicationArea = Basic;
        }
        modify(Field9)
        {
            ApplicationArea = Basic;
        }
        modify(Field10)
        {
            ApplicationArea = Basic;
        }
        modify(Field11)
        {
            ApplicationArea = Basic;
        }
        modify(Field12)
        {
            ApplicationArea = Basic;
        }
        modify(Field13)
        {
            ApplicationArea = Basic;
        }
        modify(Field14)
        {
            ApplicationArea = Basic;
        }
        modify(Field15)
        {
            ApplicationArea = Basic;
        }
        modify(Field16)
        {
            ApplicationArea = Basic;
        }
        modify(Field17)
        {
            ApplicationArea = Basic;
        }
        modify(Field18)
        {
            ApplicationArea = Basic;
        }
        modify(Field19)
        {
            ApplicationArea = Basic;
        }
        modify(Field20)
        {
            ApplicationArea = Basic;
        }
        modify(Field21)
        {
            ApplicationArea = Basic;
        }
        modify(Field22)
        {
            ApplicationArea = Basic;
        }
        modify(Field23)
        {
            ApplicationArea = Basic;
        }
        modify(Field24)
        {
            ApplicationArea = Basic;
        }
        modify(Field25)
        {
            ApplicationArea = Basic;
        }
        modify(Field26)
        {
            ApplicationArea = Basic;
        }
        modify(Field27)
        {
            ApplicationArea = Basic;
        }
        modify(Field28)
        {
            ApplicationArea = Basic;
        }
        modify(Field29)
        {
            ApplicationArea = Basic;
        }
        modify(Field30)
        {
            ApplicationArea = Basic;
        }
        modify(Field31)
        {
            ApplicationArea = Basic;
        }
        modify(Field32)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Skills(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SelectedDay(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Qtytoallocate(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Preferred Resource"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Skilled(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In Customer Zone"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name2(Control 6)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("&Allocate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Allocate"(Action 29)".

    }
    var

        "In Customer ZoneVisible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    QtytoallocateEnable := TRUE;
    SelectedDayEnable := TRUE;
    Field32Visible := TRUE;
    #4..31
    Field3Visible := TRUE;
    Field2Visible := TRUE;
    Field1Visible := TRUE;
    InCustomerZoneVisible := TRUE;
    SkilledVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..34
    "In Customer ZoneVisible" := TRUE;
    SkilledVisible := TRUE;
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: Periods) (ParameterCollection) on "SetData(PROCEDURE 1109)".


    //Unsupported feature: Property Deletion (Attributes) on "SetData(PROCEDURE 1109)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSkills(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "SetSkills(PROCEDURE 6)".

    //procedure SetSkills();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ServMgtSetup."Resource Skills Option" = ServMgtSetup."Resource Skills Option"::"Not Used" THEN
      SkilledVisible := FALSE
    ELSE
      SkilledVisible := TRUE;
    IF ServMgtSetup."Service Zones Option" = ServMgtSetup."Service Zones Option"::"Not Used" THEN
      InCustomerZoneVisible := FALSE
    ELSE
      InCustomerZoneVisible := TRUE;
    CLEAR(QtytoAllocate);

    ServHeader.GET(CurrentDocumentType,CurrentDocumentNo);

    UpdateFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
      "In Customer ZoneVisible" := FALSE
    ELSE
      "In Customer ZoneVisible" := TRUE;
    #9..13
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 8)".

}
