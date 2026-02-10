#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187094 pageextension52187094 extends "Item Statistics Matrix" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 30)".

    }

    //Unsupported feature: Property Modification (Id) on "MatrixRecords(Variable 1003)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecords : 1003;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecords : 1106;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "ItemFilter(Variable 1091)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "VariantFilter(Variable 1092)".

    //var
        //>>>> ORIGINAL VALUE:
        //VariantFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //VariantFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "LocationFilter(Variable 1093)".

    //var
        //>>>> ORIGINAL VALUE:
        //LocationFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //LocationFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Data type) on "ItemChargesFilter(Variable 1094)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemChargesFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemChargesFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1109)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "DrillDown(PROCEDURE 1139)".

    //procedure DrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH ItemBuffer DO BEGIN
          ValueEntry.SETCURRENTKEY(
            "Item No.","Posting Date","Item Ledger Entry Type","Entry Type","Variance Type",
        #4..6
          IF GETFILTER("Date Filter") <> '' THEN
            COPYFILTER("Date Filter",ValueEntry."Posting Date")
          ELSE
            ValueEntry.SETRANGE("Posting Date",0D,DMY2DATE(31,12,9999));
          IF GETFILTER("Entry Type Filter") <> '' THEN
            COPYFILTER("Entry Type Filter",ValueEntry."Entry Type");
          IF GETFILTER("Item Ledger Entry Type Filter") <> '' THEN
        #14..29
              PAGE.RUN(0,ValueEntry,ValueEntry."Cost Amount (Actual)");
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
            ValueEntry.SETRANGE("Posting Date",0D,99991231D);
        #11..32
        */
    //end;


    //Unsupported feature: Code Modification on "SetFilters(PROCEDURE 1142)".

    //procedure SetFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF LineOrColumn = LineOrColumn::Line THEN BEGIN
          DimCodeBuf := Rec;
          DimOption := ItemBuffer."Line Option";
        #4..72
                SETRANGE("Item Ledger Entry Type Filter","Item Ledger Entry Type Filter"::Sale);
                SETRANGE("Item Charge No. Filter",DimCodeBuf.Code);
              END;
            ELSE
              OnSetFiltersElseCase(ItemBuffer,DimCodeBuf);
          END;
          IF GETFILTER("Item Ledger Entry Type Filter") = '' THEN
            SETFILTER(
              "Item Ledger Entry Type Filter",'<>%1',
              "Item Ledger Entry Type Filter"::" ")
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..75
        #78..83
        */
    //end;


    //Unsupported feature: Code Modification on "CalcCostAmountNonInvnt(PROCEDURE 1150)".

    //procedure CalcCostAmountNonInvnt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetCommonFilters(ItemBuffer);
        SetFilters(ItemBuffer,0);
        IF SetColumnFilter THEN
          SetFilters(ItemBuffer,1);
        ItemBuffer.SETRANGE("Item Ledger Entry Type Filter");

        CopyValueEntryFilters(ValueEntry);
        IF ValueEntry.FINDSET THEN
          REPEAT
            CASE ValueEntry."Document Type" OF
        #11..17
          UNTIL ValueEntry.NEXT = 0;

        EXIT(TotalCostAmountNonInvnt);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        COPYValueEntryFILTERS(ValueEntry);
        #8..20
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetItem(PROCEDURE 1152)".


    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1154)".


    //Unsupported feature: Property Modification (Name) on "CopyValueEntryFilters(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Id) on "SetFilters(PROCEDURE 1142).DimCodeBuf(Variable 1002)".


    //Unsupported feature: Move on "SetFilters(PROCEDURE 1142).DimOption(Variable 1143)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 1154)."_DateFilter"(Parameter 1013)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1154)."_DateFilter"(Parameter 1013)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 1154)."_ItemFilter"(Parameter 1014)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1154)."_ItemFilter"(Parameter 1014)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 1154)."_LocationFilter"(Parameter 1015)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1154)."_LocationFilter"(Parameter 1015)".


    //Unsupported feature: Property Modification (Data type) on "Load(PROCEDURE 1154)."_VariantFilter"(Parameter 1016)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1154)."_VariantFilter"(Parameter 1016)".

}
