#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185972 pageextension52185972 extends "Online Map Address Selector" 
{
    layout
    {
        modify(LookupSelection)
        {
            ApplicationArea = Basic;
        }
        modify(LookupCode)
        {
            ApplicationArea = Basic;
        }
        modify(Distance)
        {
            ApplicationArea = Basic;
        }
        modify(Route)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "LookupCode(Control 1020001)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Distance(Control 1)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "GetTableNo(PROCEDURE 1020001)".


    //Unsupported feature: Property Deletion (Attributes) on "GetRecPosition(PROCEDURE 1020002)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTableNo(PROCEDURE 1020000)".


    //Unsupported feature: Code Modification on "SetTableNo(PROCEDURE 1020000)".

    //procedure SetTableNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE LookupSelection OF
          LookupSelection::" ":
            SelectedTableNo := 0;
        #4..20
            SelectedTableNo := DATABASE::"Ship-to Address";
          LookupSelection::"Order Address":
            SelectedTableNo := DATABASE::"Order Address";
          ELSE BEGIN
            IsHandled := FALSE;
            OnSetTableNoElseCase(LookupSelection,SelectedTableNo,IsHandled);
            IF NOT IsHandled THEN
              ERROR(Text001);
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..23
          ELSE
            ERROR(Text001);
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "LoadLocationLookup(PROCEDURE 1020012)".

    //procedure LoadLocationLookup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE LoadTableNo OF
          DATABASE::"Bank Account":
            EXIT(LoadBankAccount(LookupCode,Lookup));
        #4..18
            EXIT(LoadShipTo(LookupCode,Lookup));
          DATABASE::"Order Address":
            EXIT(LoadOrderAddress(LookupCode,Lookup));
          ELSE BEGIN
            OnLoadLocationLookupElseCase(LoadTableNo,LookupCode,Lookup,SelectedRecPosition,IsHandled);
            IF IsHandled THEN
              EXIT(SelectedRecPosition);

            ERROR(Text004,FORMAT(LoadTableNo));
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..21
          ELSE
            ERROR(STRSUBSTNO(Text004,FORMAT(LoadTableNo)));
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Getdefaults(PROCEDURE 1)".


    //Unsupported feature: Deletion (VariableCollection) on "SetTableNo(PROCEDURE 1020000).IsHandled(Variable 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "LoadLocationLookup(PROCEDURE 1020012).SelectedRecPosition(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "LoadLocationLookup(PROCEDURE 1020012).IsHandled(Variable 1000)".

}
