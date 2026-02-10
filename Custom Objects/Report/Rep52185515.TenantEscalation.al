report 52185515 "Tenant Escalation"
{
    ApplicationArea = All;
    Caption = 'Tenant Escalation ';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {

        dataitem(Lease; Lease)
        {
            //DataItemTableView = stat
            Column(Lease_Period; "Lease Period")
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if (lease."Escalation For Leases" = 0) or (lease."Escalation For Leases" < 0) then begin
                    message('Escalation For Leases is not set up for this record %1 will be Skipped', Lease."No.");
                    CurrReport.Skip();
                end;

                if lease."Last Bill Date" = 0D then
                    lease."Last Bill Date" := lease."Lease Commence Date";
                if CalcDate(format(lease."Escalation Frequency"), lease."Last Escalation Date") <= today() then begin
                    TenantEscalationBuffer.SETRANGE(LeaseNo, Lease."No.");
                    TenantEscalationBuffer.SETRANGE("Escalation Date", Today);
                    if TenantEscalationBuffer.FIND('-') then
                        TenantEscalationBuffer.DELETEALL;

                    Leaseline.RESET;
                    leaseLine.SETRANGE("Lease No.", Lease."No.");
                    if LeaseLine.find('-') then begin
                        TenantEscalationBuffer.RESET;
                        repeat
                            TenantEscalationBuffer.INIT;
                            TenantEscalationBuffer.LeaseNo := Lease."No.";
                            TenantEscalationBuffer."Escalation Date" := Today;
                            TenantEscalationBuffer."rent/fees" := LeaseLine.Amount;
                            TenantEscalationBuffer."Property No" := LeaseLine."Property No";
                            TenantEscalationBuffer."Charge No." := LeaseLine."Charge No.";

                            TenantEscalationBuffer.INSERT;
                            // Update Escalations
                            if LeaseLine."Review Amount" = 0 then
                                LeaseLine."Review Amount" := LeaseLine.Amount + (LeaseLine.Amount * ("Escalation For Leases" * 0.01))
                            else
                                LeaseLine."Review Amount" := LeaseLine."Review Amount" + (LeaseLine."Review Amount" * ("Escalation For Leases" * 0.01));

                            LeaseLine.Review := true;
                            LeaseLine.MODIFY;
                        until LeaseLine.NEXT = 0;
                    end;
                    Lease."Last Escalation Date" := Today;
                    Lease.MODIFY;
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
    Var
        EscalationForLeases: Decimal;
        EscalationFrequency: Decimal;
        StartDate: Date;
        EndDate: Date;
        RentRate: Decimal;
        Lease_Period: DateFormula;
        LeaseLine: Record "Lease Line";
        TenantEscalationBuffer: Record "Tenant Escalation Buffer";
}
