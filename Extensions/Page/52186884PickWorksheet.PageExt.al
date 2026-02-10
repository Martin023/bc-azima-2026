#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186884 pageextension52186884 extends "Pick Worksheet" 
{
    Caption = 'Pick Worksheet';
    layout
    {
        modify(CurrentWkshName)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentLocationCode)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentSortingMethod)
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Document Line No.")
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
        modify("To Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("To Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shelf No.")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Outstanding")
        {
            ApplicationArea = Basic;
        }
        modify(AvailableQtyToPickExcludingQCBins)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "AvailableQtyToPickExcludingQCBins(Control 52)".


            //Unsupported feature: Property Modification (Name) on "AvailableQtyToPickExcludingQCBins(Control 52)".

        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Advice")
        {
            ApplicationArea = Basic;
        }
        modify("Destination Type")
        {
            ApplicationArea = Basic;
        }
        modify("Destination No.")
        {
            ApplicationArea = Basic;
        }
        modify("Source Document")
        {
            ApplicationArea = Basic;
        }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify("Source Line No.")
        {
            ApplicationArea = Basic;
        }
        modify(QtyCrossDockedUOM)
        {
            ApplicationArea = Basic;
        }
        modify(QtyCrossDockedUOMBase)
        {
            ApplicationArea = Basic;
        }
        modify(QtyCrossDockedAllUOMBase)
        {
            ApplicationArea = Basic;
        }
        modify(ItemDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentWkshName(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentLocationCode(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSortingMethod(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document Type"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document No."(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document Line No."(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Zone Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""To Bin Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shelf No."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AvailableQtyToPickExcludingQCBins(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Advice"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination Type"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination No."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Line No."(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyCrossDockedUOM(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyCrossDockedUOMBase(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QtyCrossDockedAllUOMBase(Control 72)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ItemDescription(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control8(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Source &Document Line")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Source &Document Line"(Action 47)".

        }
        modify("Whse. Document Line")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Warehouse Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 31)".

        }
        modify("Bin Contents")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Bin Contents"(Action 44)".

        }
        modify("Get Warehouse Documents")
        {
            ApplicationArea = Basic;
        }
        modify("Autofill Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Delete Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify(CreatePick)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source &Document Line"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document Line"(Action 66)".


        //Unsupported feature: Property Deletion (Promoted) on ""Whse. Document Line"(Action 66)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Whse. Document Line"(Action 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 69)".


        //Unsupported feature: Property Deletion (Promoted) on ""Item &Tracking Lines"(Action 69)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Item &Tracking Lines"(Action 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Entries"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Warehouse Documents"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Autofill Qty. to Handle"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Qty. to Handle"(Action 6)".


        //Unsupported feature: Code Insertion (VariableCollection) on "CreatePick(Action 55).OnAction".

        //trigger (Variable: CreatePick)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "CreatePick(Action 55).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CODEUNIT.RUN(CODEUNIT::"Whse. Create Pick",Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CreatePick.RUN(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CreatePick(Action 55)".

        addafter("Get Warehouse Documents")
        {
            separator(Action3)
            {
            }
        }
        addafter("Delete Qty. to Handle")
        {
            separator(Action54)
            {
            }
        }
    }

    var
        CreatePick: Codeunit "Whse. Create Pick";


    //Unsupported feature: Property Modification (Length) on "ItemDescription(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemDescription : 50;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CrossDockMgt.CalcCrossDockedItems("Item No.","Variant Code","Unit of Measure Code","Location Code",
          QtyCrossDockedUOMBase,
          QtyCrossDockedAllUOMBase);
        QtyCrossDockedUOM := 0;
        IF  "Qty. per Unit of Measure" <> 0 THEN
          QtyCrossDockedUOM := ROUND(QtyCrossDockedUOMBase / "Qty. per Unit of Measure",UOMMgt.QtyRndPrecision);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
          QtyCrossDockedUOM := ROUND(QtyCrossDockedUOMBase / "Qty. per Unit of Measure",0.00001);
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
