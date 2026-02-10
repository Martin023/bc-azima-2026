#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185815 "Item Availability Notification"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchases & Payables Setup"; "Purchases & Payables Setup")
        {
            DataItemTableView = sorting("Primary Key");
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Item.Reset;
                Item.CalcFields("Net Change");
                Item.SetFilter(Item."Reorder Point", '<>%1', 0);
                // if Item.FindSet then begin
                //     Clear(Smtp);
                //     CompanyInfo.Get;
                //     Smtp.CreateMessage(COMPANYNAME, CompanyInfo."E-Mail", "Purchases & Payables Setup"."Item Reorder Notific Email"
                //     , 'Dynamics NAV Reorder Items: ' + Format(Today), 'Find attached the list of items for reorder:', true);
                //     Smtp.AppendBody('<br>');
                //     repeat
                //         Item.CalcFields("Net Change");
                //         if (Item."Net Change" <= Item."Reorder Point") then begin
                //             Smtp.AppendBody('&nbsp' + Item."No." + '&nbsp&nbsp' + Item.Description + ';  Current Quantity - ' + Format(Item."Net Change") + '  Reorder Point - ' + Format(Item."Reorder Point"));
                //             Smtp.AppendBody('<br>');
                //             Smtp.AppendBody('<br>');
                //         end;
                //     until Item.Next = 0;
                //     Smtp.Send;
                // end;
                /*
                Item.RESET;
                Item.SETFILTER(Item."Reorder Point",'<>%1',0);
                IF Item.FINDSET THEN
                repeat
                MESSAGE('%1 %2 %3',Item."No.",Item."Net Change",Item."Reorder Point");
                UNTIL Item.next= 0;
                */

            end;
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
        Item: Record Item;
        //Smtp: Codeunit 400;
        CompanyInfo: Record "Company Information";
}
