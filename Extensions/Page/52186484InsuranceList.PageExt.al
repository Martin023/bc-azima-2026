#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186484 pageextension52186484 extends "Insurance List" 
{
    Caption = 'Insurance List';
    layout
    {
        addafter("Description")
        {
            field("Asset Insurance";Rec."Asset Insurance")
            {
                ApplicationArea = Basic;
            }
            field("Fixed Asset No.";Rec."Fixed Asset No.")
            {
                ApplicationArea = Basic;
            }
            field(Insurer;Rec.Insurer)
            {
                ApplicationArea = Basic;
            }
            
            Field("Policy No.";Rec."Policy No.")
            {
                ApplicationArea = Basic;
            }
            field("Effective Date";Rec."Effective Date")
            {
                ApplicationArea = Basic;
            }
            field("Expiration Date";Rec."Expiration Date")
            {
                ApplicationArea = Basic;
            }
        
            // field("Insurer Name"; Rec."Insurer Name")
            // {
            //     ApplicationArea = Basic;
            // }
            field("Insurance Status"; Rec."Insurance Status")
            {
                ApplicationArea = Basic;
            }
            field("Status"; Rec.Status)
            {
                ApplicationArea = Basic;
            }
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
            Editable = false;
        }
        modify("Insurance Type")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Insurance Vendor No.")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("FA Class Code")
        {
            ApplicationArea = Basic;
        }
        modify("FA Subclass Code")
        {
            ApplicationArea = Basic;
        }
        modify("FA Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Search Description")
        {
            ApplicationArea = Basic;
            Visible= false;
        }
    


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance Type"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance Vendor No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Class Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Subclass Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Location Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Description"(Control 20)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Coverage Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
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
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Total Value Ins&ured per FA")
        {
            ApplicationArea = Basic;
        }
        modify(List)
        {
            ApplicationArea = Basic;
        }
        modify("Uninsured FAs")
        {
            ApplicationArea = Basic;
        }
        modify("Tot. Value Insured")
        {
            ApplicationArea = Basic;
        }
        modify("Coverage Details")
        {
            ApplicationArea = Basic;
        }
        modify(Register)
        {
            ApplicationArea = Basic;
        }
        modify(Analysis)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Coverage Ledger E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 84)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 17).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(Insurance);
            DefaultDimMultiple.SetMultiRecord(Insurance,FIELDNO("No."));
            DefaultDimMultiple.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(Insurance);
            DefaultDimMultiple.SetMultiInsurance(Insurance);
            DefaultDimMultiple.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Value Ins&ured per FA"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 1900084706)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Uninsured FAs"(Action 1901158106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Tot. Value Insured"(Action 1907944406)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Coverage Details"(Action 1904097106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Register(Action 1903807106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Analysis(Action 1901105406)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
