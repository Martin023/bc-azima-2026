#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186613 pageextension52186613 extends "Service Item Groups" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Default Contract Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Default Serv. Price Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Default Response Time (Hours)")
        {
            ApplicationArea = Basic;
        }
        modify("Create Service Item")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Contract Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Serv. Price Group Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Response Time (Hours)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Service Item"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Resource Skills")
        {
            ApplicationArea = Basic;
        }
        modify("Skilled Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify("Trou&bleshooting Setup")
        {
            ApplicationArea = Basic;
        }
        modify("S&td. Serv. Item Gr. Codes")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Skills"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Skilled Resources"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 24)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 25).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ServiceItemGroup);
            DefaultDimMultiple.SetMultiRecord(ServiceItemGroup,FIELDNO(Code));
            DefaultDimMultiple.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ServiceItemGroup);
            DefaultDimMultiple.SetMultiServiceItemGroup(ServiceItemGroup);
            DefaultDimMultiple.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Trou&bleshooting Setup"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&td. Serv. Item Gr. Codes"(Action 23)".

        addafter(Dimensions)
        {
            separator(Action15)
            {
                Caption = '';
            }
        }
        addafter("Trou&bleshooting Setup")
        {
            separator(Action22)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
