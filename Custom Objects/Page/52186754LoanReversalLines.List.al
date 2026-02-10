page 52186754 "Loan Reversal Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Loan Reversal Lines";
    SourceTableView = sorting ("Refund Type") order(descending);


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Defaulter Member No."; Rec."Defaulter Member No.")
                {

                }
                field("Defaulter Loan No"; Rec."Defaulter Loan No")
                {

                }
                field("Refund Type"; Rec."Refund Type")
                {

                }
                field("Interest Attached Amount"; Rec."Interest Attached Amount")
                {

                }

                field("Principle Attached Amount"; Rec."Principle Attached Amount")
                {

                }

                field("Guarantor Member No."; Rec."Guarantor Member No.")
                {

                }

                field("Guarantor Name"; Rec."Guarantor Name")
                {

                }

                field("Guarantor Loan No"; Rec."Guarantor Loan No")
                {

                }

                field("Guarantor Interest Balance"; Rec."Guarantor Interest Balance")
                {
                    ToolTip = 'This money is to be posted to the main loan as principle balance//To balance with the main loan';

                }
                field("Guarantor Principal Balance"; Rec."Guarantor Principal Balance")
                {
                    ToolTip = 'This money is to be posted to the main loan as interest balance//To balance with the main loan';

                }
                field("Interests Accrued"; Rec."Interests Accrued")
                {

                }

                field("Interest Paid By Guarantor"; Rec."Interest Paid By Guarantor")
                {
                    ToolTip = 'This money is to be posted to the main loan as interest balance against guarantor FOSA//Can pass through the guarantor loan';

                }
                field("Principle Paid By Guarantor"; Rec."Principle Paid By Guarantor")
                {
                    ToolTip = 'This money is to be posted to the main loan as principle balance against guarantor FOSA//Can pass through the guarantor loan';

                }
                field("Interest Reappotionments"; Rec."Interest Reappotionments")
                {

                }
                field("Principle Reappotionments"; Rec."Principle Reappotionments")
                {

                }
                field("FOSA Reappotionments"; Rec."FOSA Reappotionments")
                {

                }
                field("FOSA Refund"; Rec."FOSA Refund")
                {

                }

                field("Total Int To Defaulter"; Rec."Total Int To Defaulter")
                {

                }

                field("Total Pr To Defaulter"; Rec."Total Pr To Defaulter")
                {

                }
                
                field("Total Loan To Defaulter"; Rec."Total Loan To Defaulter")
                {

                }

            }
        }
    }
}
