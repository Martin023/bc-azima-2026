#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185619 pageextension52185619 extends "Ship-to Address"
{
    layout
    {
        modify("Code")
        {

            //Unsupported feature: Property Modification (Level) on "Code(Control 2)".

            ApplicationArea = Basic;
        }
        modify(Name)
        {

            //Unsupported feature: Property Modification (Level) on "Name(Control 4)".

            ApplicationArea = Basic;
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

            //Unsupported feature: Property Modification (Level) on ""Post Code"(Control 11)".

            ApplicationArea = Basic;
        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 10)".

            ApplicationArea = Basic;
        }
        // modify("Country/Region Code")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Country/Region Code"(Control 28)".

        //     ApplicationArea = Basic;
        // }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify(Contact)
        {
            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Home Page")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Service Code")
        {
            ApplicationArea = Basic;
        }
        modify("Service Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Control3)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".

        modify(GLN)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 8)".

        modify(Control13)
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 10)".

        // modify("Country/Region Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 28)".

        modify(ShowMap)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 12)".


        //Unsupported feature: Property Deletion (Importance) on ""Phone No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contact(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 34)".


        //Unsupported feature: Property Deletion (Importance) on ""Fax No."(Control 34)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on ""E-Mail"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Home Page"(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Home Page"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on ""Shipment Method Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""Shipping Agent Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Service Code"(Control 46)".


        //Unsupported feature: Property Deletion (Importance) on ""Shipping Agent Service Code"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Zone Code"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on ""Last Date Modified"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 55)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(General)
        {
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        moveafter(Contact; "Location Code")
    }
    actions
    {
        addfirst("&Address")
        {
            separator(Action49)
            {
            }
            action("Online Map")
            {
                ApplicationArea = Basic;
                Caption = 'Online Map';
                Image = Map;

                trigger OnAction()
                begin
                    Rec.DisplayMap;
                end;
            }
        }
    }

    var
        MapMgt: Codeunit "Online Map Management";

    var

        MapPointVisible: Boolean;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    MapPointVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: MapMgt)()
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
    IsCountyVisible := FormatAddress.UseCounty("Country/Region Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT MapMgt.TestSetup THEN
      MapPointVisible := FALSE;
    */
    //end;
}
