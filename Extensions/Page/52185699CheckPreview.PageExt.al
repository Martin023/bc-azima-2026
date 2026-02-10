#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185699 pageextension52185699 extends "Check Preview"
{
    layout
    {
        modify("CompanyAddr[1]")
        {
            ApplicationArea = Basic;
        }
        modify("CompanyAddr[2]")
        {
            ApplicationArea = Basic;
        }
        modify("CompanyAddr[3]")
        {
            ApplicationArea = Basic;
        }
        modify("CompanyAddr[4]")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(CheckStatusText)
        {
            ApplicationArea = Basic;
        }
        modify(AmountText)
        {
            ApplicationArea = Basic;
        }
        modify("Amount Text 2")
        {
            ApplicationArea = Basic;
        }
        modify("CheckToAddr[1]")
        {
            ApplicationArea = Basic;
        }
        // modify("CheckToAddr[2]")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("CheckToAddr[3]")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("CheckToAddr[4]")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Posting Date")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Text002)
        {
            ApplicationArea = Basic;
        }
        // modify(Control26)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control28)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(CheckAmount)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control25)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control27)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control29)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""CompanyAddr[1]"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CompanyAddr[2]"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CompanyAddr[3]"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CompanyAddr[4]"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CheckStatusText(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountText(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Text 2"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CheckToAddr[1]"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CheckToAddr[2]"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CheckToAddr[3]"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CheckToAddr[4]"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CheckAmount(Control 7)".


        //Unsupported feature: Property Deletion (ShowCaption) on "CheckAmount(Control 7)".

    }

    //Unsupported feature: Property Modification (Length) on "CheckToAddr(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //CheckToAddr : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CheckToAddr : 50;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "CompanyAddr(Variable 1010)".

    //var
    //>>>> ORIGINAL VALUE:
    //CompanyAddr : 100;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CompanyAddr : 50;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "CalcCheck(PROCEDURE 1)".

    //procedure CalcCheck();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Check Printed" THEN BEGIN
      GenJnlLine.RESET;
      GenJnlLine.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
    #4..63
        END;
      GenJnlLine."Account Type"::"Fixed Asset":
        GenJnlLine.FIELDERROR("Account Type");
      GenJnlLine."Account Type"::Employee:
        BEGIN
          Employee.GET(GenJnlLine."Account No.");
          FormatAddr.Employee(CheckToAddr,Employee);
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..66
    END;
    */
    //end;
}
