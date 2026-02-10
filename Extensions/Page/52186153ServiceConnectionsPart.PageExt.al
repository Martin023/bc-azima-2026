#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186153 pageextension52186153 extends "Service Connections Part" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Name(Control 3)".


            //Unsupported feature: Property Modification (Name) on "Name(Control 3)".

        }
        modify("Host Name")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Insertion on "Description(Control 3)".

        //trigger OnDrillDown()
        //begin
            /*
            CallSetup;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Host Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 10)".

        addafter(Status)
        {
            field(TestVar;TestVar)
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify(Setup)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "Setup(Action 5)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "Setup(Action 5)".

        }

        //Unsupported feature: Property Deletion (ShortCutKey) on "Setup(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Setup(Action 5)".

    }

    var
        TestVar: Code[10];

    //Unsupported feature: Property Deletion (LinksAllowed).

}
