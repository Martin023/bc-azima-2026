report 52185661 "Escalation For Leases"
{
    ApplicationArea = All;
    Caption = 'Escalation For Leases';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Escalation For Leases.rdl';
    dataset
    {
        dataitem(Lease; Lease)
        {
            RequestFilterFields = "No.", "Tenant No.", "Property No.";
            column(No; "No.")
            {
            }
            column(TenantNo; "Tenant No.")
            {
            }
            column(TenantName; "Tenant Name")
            {
            }
            column(UnitCode; "Unit Code")
            {
            }
            column(UnitDescription; "Unit Description")
            {
            }
            column(Unit_Type; "Unit Type")
            {

            }
            column(Property_No_; "Property No.")
            {

            }
            column(Property_Name; "Property Name")
            {

            }
            column(Areasquareft; "Area square ft")
            {
            }
            column(DateRegistered; "Date Registered")
            {
            }
            column(EscalationForLeases; "Escalation For Leases")
            {
            }
            column(EscalationFrequency; "Escalation Frequency")
            {
            }
            column(Expired; Expired)
            {
            }
            column(Terminated; Terminated)
            {

            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(FloorNo; "Floor No.")
            {
            }
            column(FloorName; "Floor Name")
            {
            }
            column(LeasePeriod; "Lease Period")
            {
            }
            column(Lease_Commence_Date; "Lease Commence Date")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(ChargeName; ChargeName)
            {
            }
            column(EffectDate; EffectDate)
            {
            }
            column(OldAmountReviewAmount; OldAmountReviewAmount)
            {
            }
            column(NewReviewAmount; NewReviewAmount)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                MonthstoExpire := 0;
                ExpiryDate := Lease."Expiry Date";
                ChargeName := '';
                EffectDate := 0D;
                OldAmountReviewAmount := 0.00;
                NewReviewAmount := 0.00;

                LeaseChargeReview.RESET;
                LeaseChargeReview.SETRANGE(LeaseChargeReview."Lease No.", Lease."No.");
                //LeaseChargeReview.SETRANGE("Effect Date",'>='+Lease."Lease Commence Date");
                if LeaseChargeReview.Find('-') then begin
                    repeat
                        ChargeName := LeaseChargeReview."Charge Name";
                        EffectDate := LeaseChargeReview."Effect Date";
                        //OldAmountReviewAmount := LeaseChargeReview."Old Amount[Review Amount]";
                        OldAmountReviewAmount := LeaseChargeReview."Old Amount[Rate]";
                        //NewReviewAmount := LeaseChargeReview."New [Review Amount]";
                        NewReviewAmount := LeaseChargeReview."New [Rate Amount]";
                    until LeaseChargeReview.Next = 0;
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MonthstoExpire: Integer;
        ExpiryDate: DATE;
        LeaseChargeReview: Record "Lease Charge Review";
        ChargeName: Text;
        EffectDate: DATE;
        OldAmountReviewAmount: Decimal;
        NewReviewAmount: Decimal;
}
