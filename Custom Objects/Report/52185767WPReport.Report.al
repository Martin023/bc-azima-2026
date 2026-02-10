#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185767 "W/P Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/WP Report.rdl';

    dataset
    {
        dataitem(Workplan; Workplan)
        {
            RequestFilterFields = "Workplan Code";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            // column(compinfo_Name; compinfo.Name)
            // {
            // }
            // column(compinfo_Address; compinfo.Address)
            // {
            // }
            // column(compinfo_Picture; compinfo.Picture)
            // {
            // }
            column(WorkplanCode_Workplan; Workplan."Workplan Code")
            {
            }
            column(WorkplanGlobalDimension1Code; Workplan."Global Dimension 1 Code")
            {
            }
            column(WorkplanGlobalDimension2Code; Workplan."Global Dimension 2 Code")
            {
            }
            column(WorkplanDescription_Workplan; Workplan."Workplan Description")
            {
            }
            dataitem("Workplan Activities"; "Workplan Activities")
            {
                DataItemLink = "Workplan Code" = field("Workplan Code");
                DataItemTableView = sorting("Activity Code") order(ascending);
                RequestFilterFields = "Global Dimension 1 Code", "Shortcut Dimension 2 Code";
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(ActivityCode_WorkplanActivities; "Workplan Activities"."Activity Code")
                {
                }
                column(ActivityDescription_WorkplanActivities; "Workplan Activities"."Activity Description")
                {
                }
                column(AccountType_WorkplanActivities; "Workplan Activities"."Account Type")
                {
                }
                column(AmounttoTransfer_WorkplanActivities; "Workplan Activities"."Amount to Transfer")
                {
                }
                column(UploadedtoProcurementWorkpl_WorkplanActivities; "Workplan Activities"."Uploaded to Procurement Workpl")
                {
                }
                column(DatetoTransfer_WorkplanActivities; "Workplan Activities"."Date to Transfer")
                {
                }
                column(Description_WorkplanActivities; "Workplan Activities".Description)
                {
                }
                column(ConvertedtoBudget_WorkplanActivities; "Workplan Activities"."Converted to Budget")
                {
                }
                column(ExpenseCode_WorkplanActivities; "Workplan Activities"."Expense Code")
                {
                }
                column(No_WorkplanActivities; "Workplan Activities"."No.")
                {
                }
                column(Type_WorkplanActivities; "Workplan Activities".Type)
                {
                }
                column(WorkplanActivitiesUnit; "Workplan Activities".Unit)
                {
                }
                column(ProcMethodNo; "Workplan Activities"."Proc. Method No.")
                {
                }
                column(WorkplanActivitiesSourceOfFunds; "Workplan Activities"."Source Of Funds")
                {
                }
                column(WorkplanActivitiescategory; "Workplan Activities".category)
                {
                }
                column(WorkplanActivitiesQuantity; "Workplan Activities".Quantity)
                {
                }
                column(UnitofCost; "Workplan Activities"."Unit of Cost")
                {
                }
                column(WorkplanActivitiesAmounttoTransfer; "Workplan Activities"."Amount to Transfer")
                {
                }
                column(WorkplanActivitiesGlobalDimension1Code; "Workplan Activities"."Global Dimension 1 Code")
                {
                }
                column(WorkplanActivitiesShortcutDimension2Code; "Workplan Activities"."Shortcut Dimension 2 Code")
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //TotalAmount:=0;
                    TotalAmount := TotalAmount + "Workplan Activities"."Amount to Transfer";
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        compinfo: Record "Company Information";
        TotalAmount: Decimal;
}
