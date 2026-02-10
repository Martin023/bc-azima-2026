#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185621 pageextension52185621 extends "Customer Entry Statistics" 
{
    layout
    {
        modify("CustLedgEntry[1].""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[2].""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[3].""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[5].""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[4].""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[6].""Posting Date""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[1].""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[2].""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[3].""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[5].""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[4].""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[6].""Document No.""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[1].""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[2].""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[3].""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[5].""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[4].""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[6].""Currency Code""")
        {
            ApplicationArea = Basic;
        }
        modify("-CustLedgEntry[1].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[2].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("-CustLedgEntry[3].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[5].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[4].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[6].Amount")
        {
            ApplicationArea = Basic;
        }
        modify("-CustLedgEntry[1].""Remaining Amount""")
        {
            ApplicationArea = Basic;
        }
        modify(RemainingAmount)
        {
            ApplicationArea = Basic;
        }
        modify("-CustLedgEntry[3].""Remaining Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[5].""Remaining Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[4].""Remaining Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("CustLedgEntry[6].""Remaining Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("CustDateName[1]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[1][1]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[1][2]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[1][3]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[1][5]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[1][4]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[1][6]")
        {
            ApplicationArea = Basic;
        }
        modify("AvgCollectionPeriodDays_ThisPeriod")
        {
            ApplicationArea = Basic;
        }
        modify("HighestBalanceLCY[1]")
        {
            ApplicationArea = Basic;
        }
        modify(Text000)
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[2][1]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[2][2]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[2][3]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[2][5]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[2][4]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[2][6]")
        {
            ApplicationArea = Basic;
        }
        modify("AvgCollectionPeriodDays_ThisYear")
        {
            ApplicationArea = Basic;
        }
        modify("HighestBalanceLCY[2]")
        {
            ApplicationArea = Basic;
        }
        // modify(Control87)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("NoOfDoc[3][1]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[3][2]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[3][3]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[3][5]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[3][4]")
        {
            ApplicationArea = Basic;
        }
        modify("NoOfDoc[3][6]")
        {
            ApplicationArea = Basic;
        }
        modify("AvgCollectionPeriodDays_LastYear")
        {
            ApplicationArea = Basic;
        }
        modify("HighestBalanceLCY[3]")
        {
            ApplicationArea = Basic;
        }
        // modify(Control93)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("-TotalRemainAmountLCY[1]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalRemainAmountLCY[2]")
        {
            ApplicationArea = Basic;
        }
        modify("-TotalRemainAmountLCY[3]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalRemainAmountLCY[5]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalRemainAmountLCY[4]")
        {
            ApplicationArea = Basic;
        }
        modify("TotalRemainAmountLCY[6]")
        {
            ApplicationArea = Basic;
        }
        // modify(Control89)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Control90)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[1].""Posting Date"""(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[2].""Posting Date"""(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[3].""Posting Date"""(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[5].""Posting Date"""(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[4].""Posting Date"""(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[6].""Posting Date"""(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[1].""Document No."""(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[2].""Document No."""(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[3].""Document No."""(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[5].""Document No."""(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[4].""Document No."""(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[6].""Document No."""(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[1].""Currency Code"""(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[2].""Currency Code"""(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[3].""Currency Code"""(Control 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[5].""Currency Code"""(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[4].""Currency Code"""(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[6].""Currency Code"""(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""-CustLedgEntry[1].Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[2].Amount"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""-CustLedgEntry[3].Amount"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[5].Amount"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[4].Amount"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[6].Amount"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""-CustLedgEntry[1].""Remaining Amount"""(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemainingAmount(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""-CustLedgEntry[3].""Remaining Amount"""(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[5].""Remaining Amount"""(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[4].""Remaining Amount"""(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""CustLedgEntry[6].""Remaining Amount"""(Control 78)".


        //Unsupported feature: Property Deletion (ShowCaption) on ""CustDateName[1]"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[1][1]"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[1][2]"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[1][3]"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[1][5]"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[1][4]"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[1][6]"(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AvgCollectionPeriodDays_ThisPeriod"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""HighestBalanceLCY[1]"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[2][1]"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[2][2]"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[2][3]"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[2][5]"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[2][4]"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[2][6]"(Control 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AvgCollectionPeriodDays_ThisYear"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""HighestBalanceLCY[2]"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[3][1]"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[3][2]"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[3][3]"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[3][5]"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[3][4]"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfDoc[3][6]"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""AvgCollectionPeriodDays_LastYear"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""HighestBalanceLCY[3]"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""-TotalRemainAmountLCY[1]"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalRemainAmountLCY[2]"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""-TotalRemainAmountLCY[3]"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalRemainAmountLCY[5]"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalRemainAmountLCY[4]"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""TotalRemainAmountLCY[6]"(Control 85)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEARALL;

        FOR j := 1 TO 6 DO BEGIN
          CustLedgEntry[j].SETCURRENTKEY("Document Type","Customer No.","Posting Date");
          CustLedgEntry[j].SETRANGE("Document Type",j); // Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund
          CustLedgEntry[j].SETRANGE("Customer No.","No.");
          IF CustLedgEntry[j].FINDLAST THEN
            CustLedgEntry[j].CALCFIELDS(Amount,"Remaining Amount");
        END;

        #11..64
                  END ELSE BEGIN
                    CustLedgEntry3.SETCURRENTKEY("Closed by Entry No.");
                    CustLedgEntry3.SETRANGE("Closed by Entry No.",CustLedgEntry2."Entry No.");
                    IF CustLedgEntry3.FINDLAST THEN
                      UpdateDaysToPay(CustLedgEntry3."Posting Date" - CustLedgEntry2."Posting Date");
                  END;
            UNTIL CustLedgEntry2.NEXT(-1) = 0;
          IF NoOfInv <> 0 THEN
            AvgDaysToPay[i] := DaysToPay / NoOfInv;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
          IF CustLedgEntry[j].FIND('+') THEN
        #8..67
                    IF CustLedgEntry3.FIND('+') THEN
        #69..74
        */
    //end;
}
