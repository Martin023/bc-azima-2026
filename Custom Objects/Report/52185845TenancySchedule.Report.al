#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185845 "Tenancy Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Tenancy Schedule.rdl';

    dataset
    {
        dataitem(Lease; Lease)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No_Lease; Lease."No.")
            {
            }
            column(TenantNo_Lease; Lease."Tenant No.")
            {
            }
            column(TenantName_Lease; Lease."Tenant Name")
            {
            }
            column(FloorName_Lease; Lease."Floor Name")
            {
            }
            column(UnitCode_Lease; Lease."Unit Code")
            {
            }
            column(LeaseCommenceDate_Lease; Lease."Lease Commence Date")
            {
            }
            column(ExpiryDate_Lease; Lease."Expiry Date")
            {
            }
            column(Areasquareft_Lease; Lease."Area square ft")
            {
            }
            column(Status_Lease; Lease.Status)
            {
            }
            column(Name; CompInfo.Name)
            {
            }
            column(Pic; CompInfo.Picture)
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
            column(HomePage; CompInfo."Home Page")
            {
            }
            column(FaxNo; CompInfo."Fax No.")
            {
            }
            column(PhoneNo; CompInfo."Phone No.")
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(Address2; CompInfo."Address 2")
            {
            }
            column(City; CompInfo.City)
            {
            }
            dataitem("Lease Line"; "Lease Line")
            {
                DataItemLink = "Property No" = field("Property No."), "Lease No." = field("No.");
                column(ReportForNavId_5; 5)
                {
                }
                column(RentAmount; RentAmount)
                {
                }
                column(Rent; Rent)
                {
                }
                column(Scharge; Scharge)
                {
                }
                column(RevFrq; RevFrq)
                {
                }
                column(RevFValue; RevFValue)
                {
                }
                column(Nos; Nos)
                {
                }
                column(Rate; Rate)
                {
                }
                column(SRate; SRate)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                Nos += 1;
                if Commenced = true then begin
                    Lease."Lease Status" := Lease."lease status"::Active;
                end else
                    Lease."Lease Status" := Lease."lease status"::Expired;
                Lease.SetFilter(Lease.Commenced, Format(true));
                Lease.SetFilter(Lease.Blocked, Format(false));

                Rent := 0;
                Signage := 0;
                Parking := 0;
                Scharge := 0;
                Rate := 0;
                SRate := 0;

                if Commenced = true then begin
                    Lease."Lease Status" := Lease."lease status"::Active;
                end else
                    Lease."Lease Status" := Lease."lease status"::Expired;

                Lease.SetFilter(Lease.Blocked, Format(false));

                "Lease Line".Reset;
                "Lease Line".SetRange("Lease Line"."Lease No.", "No.");
                if "Lease Line".Find('-') then begin
                    repeat
                        if "Billing Frequency" = "billing frequency"::Quarterly then begin
                            //rent
                            if ("Lease Line"."Charge No." = '100') or ("Lease Line"."Charge No." = '102') then begin
                                Rent := ("Lease Line"."Amount Exclusive VAT" / 3);
                                Rate := "Lease Line"."Rent/S.Charge Rate";
                                RevFrq := "Lease Line"."Review Frequency Value";
                                RevFValue := "Lease Line"."Review Frequency";

                            end;
                            //signage
                            if "Lease Line"."Charge No." = '109' then begin
                                Signage := ("Lease Line"."Amount Exclusive VAT" / 3);
                                RevFrq := "Lease Line"."Review Frequency Value";
                                RevFValue := "Lease Line"."Review Frequency";

                            end;
                            //parking
                            if ("Lease Line"."Charge No." = '104') or ("Lease Line"."Charge No." = '114') then begin
                                Parking := ("Lease Line"."Amount Exclusive VAT" / 3);
                                RevFrq := "Lease Line"."Review Frequency Value";
                                RevFValue := "Lease Line"."Review Frequency";

                            end;
                            //service charge
                            if ("Lease Line"."Charge No." = '103') then begin
                                Scharge := ("Lease Line"."Amount Exclusive VAT" / 3);
                                SRate := "Lease Line"."Rent/S.Charge Rate";
                                RevFrq := "Lease Line"."Review Frequency Value";
                                RevFValue := "Lease Line"."Review Frequency";

                            end;
                            //service charge
                            if ("Lease Line"."Charge No." = '101') then begin
                                Scharge := ("Lease Line"."Amount Exclusive VAT" / 3);
                                SRate := "Lease Line"."Rent/S.Charge Rate";
                                RevFrq := "Lease Line"."Review Frequency Value";
                                RevFValue := "Lease Line"."Review Frequency";

                            end;

                            "Lease Line".Modify;
                        end else
                            //FOR ANNUALY
                            if "Billing Frequency" = "billing frequency"::Annually then begin
                                //rent
                                if ("Lease Line"."Charge No." = '100') or ("Lease Line"."Charge No." = '102') then begin
                                    Rent := ("Lease Line"."Amount Exclusive VAT" / 12);
                                    Rate := "Lease Line"."Rent/S.Charge Rate";
                                    RevFrq := "Lease Line"."Review Frequency Value";
                                    RevFValue := "Lease Line"."Review Frequency";

                                end;
                                //signage
                                if "Lease Line"."Charge No." = '109' then begin
                                    Signage := ("Lease Line"."Amount Exclusive VAT" / 12);
                                    RevFrq := "Lease Line"."Review Frequency Value";
                                    RevFValue := "Lease Line"."Review Frequency";

                                end;
                                //parking
                                if ("Lease Line"."Charge No." = '104') or ("Lease Line"."Charge No." = '114') then begin
                                    Parking := ("Lease Line"."Amount Exclusive VAT" / 12);
                                    RevFrq := "Lease Line"."Review Frequency Value";
                                    RevFValue := "Lease Line"."Review Frequency";

                                end;
                                //service charge
                                if ("Lease Line"."Charge No." = '103') or ("Lease Line"."Charge No." = '101') then begin
                                    Scharge := ("Lease Line"."Amount Exclusive VAT" / 12);
                                    SRate := "Lease Line"."Rent/S.Charge Rate";
                                    RevFrq := "Lease Line"."Review Frequency Value";
                                    RevFValue := "Lease Line"."Review Frequency";

                                end;

                                "Lease Line".Modify;
                            end else
                                //FOR MONTH
                                if "Billing Frequency" = "billing frequency"::Monthly then begin
                                    //rent
                                    if ("Lease Line"."Charge No." = '100') or ("Lease Line"."Charge No." = '102') then begin
                                        Rent := "Lease Line"."Amount Exclusive VAT";
                                        Rate := "Lease Line"."Rent/S.Charge Rate";
                                        RevFrq := "Lease Line"."Review Frequency Value";
                                        RevFValue := "Lease Line"."Review Frequency";

                                    end;
                                    //signage
                                    if "Lease Line"."Charge No." = '109' then begin
                                        Signage := "Lease Line"."Amount Exclusive VAT";
                                        RevFrq := "Lease Line"."Review Frequency Value";
                                        RevFValue := "Lease Line"."Review Frequency";

                                    end;
                                    //parking
                                    if ("Lease Line"."Charge No." = '104') or ("Lease Line"."Charge No." = '114') then begin
                                        Parking := "Lease Line"."Amount Exclusive VAT";
                                        RevFrq := "Lease Line"."Review Frequency Value";
                                        RevFValue := "Lease Line"."Review Frequency";

                                    end;
                                    //service charge
                                    if ("Lease Line"."Charge No." = '103') or ("Lease Line"."Charge No." = '101') then begin
                                        Scharge := "Lease Line"."Amount Exclusive VAT";
                                        SRate := "Lease Line"."Rent/S.Charge Rate";
                                        RevFrq := "Lease Line"."Review Frequency Value";
                                        RevFValue := "Lease Line"."Review Frequency";

                                    end;

                                    "Lease Line".Modify;
                                end;
                        "Lease Line".Modify;
                    until "Lease Line".Next = 0;
                end;
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

    trigger OnPreReport()
    begin
        if CompInfo.Get then
            CompInfo.CalcFields(CompInfo.Picture);
        CompanyAddress := CompInfo.Address + ' -Post Code: ' + CompInfo."Post Code" + ' -CompInfoty:' + CompInfo.City + ' Region: ' + CompInfo."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompInfo."Phone No." + ' -Office Tel: ' + CompInfo."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompInfo."E-Mail" + '- Website: ' + CompInfo."Home Page";
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompInfo: Record "Company Information";
        LeaseL: Record "Lease Line";
        RentAmount: Decimal;
        Rent: Decimal;
        Scharge: Decimal;
        Parking: Decimal;
        Signage: Decimal;
        RevFrq: Integer;
        //RevFValue: Option Days,Weeks,Months,Quarters,Years;
        RevFValue: DateFormula;
        Nos: Integer;
        Rate: Decimal;
        SRate: Decimal;
}
