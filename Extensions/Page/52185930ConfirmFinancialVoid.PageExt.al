#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185930 pageextension52185930 extends "Confirm Financial Void" 
{
    layout
    {
        modify(Control19)
        {
            ApplicationArea = Basic;
        }
        modify(VoidDate)
        {
            ApplicationArea = Basic;
        }
        modify(VoidType)
        {
            ApplicationArea = Basic;
        }
        modify("CheckLedgerEntry.""Bank Account No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CheckLedgerEntry.""Check No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CheckLedgerEntry.""Bal. Account No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CheckLedgerEntry.Amount")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "VoidDate(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VoidType(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CheckLedgerEntry.""Bank Account No."""(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CheckLedgerEntry.""Check No."""(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CheckLedgerEntry.Amount"(Control 10)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH CheckLedgerEntry DO BEGIN
          VoidDate := "Check Date";
          IF "Bal. Account Type" IN ["Bal. Account Type"::Vendor,"Bal. Account Type"::Customer,"Bal. Account Type"::Employee] THEN
            VoidType := VoidType::"Unapply and void check"
          ELSE
            VoidType := VoidType::"Void check only";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH CheckLedgerEntry DO BEGIN
          VoidDate := "Check Date";
          IF "Bal. Account Type" IN ["Bal. Account Type"::Vendor,"Bal. Account Type"::Customer] THEN
        #4..7
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetCheckLedgerEntry(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetVoidDate(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "GetVoidType(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "InitializeRequest(PROCEDURE 4)".

}
