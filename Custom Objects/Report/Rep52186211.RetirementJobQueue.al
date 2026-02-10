report 52186211 "Retirement Job Queue"
{
    ApplicationArea = All;
    Caption = 'Retirement Job Queue';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(Retired = const(False));
            column(No; "No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Customer: Record Customer;
                MembersTable: Record Members;
            begin
                if CalcDate(GenSetup."Max. Member Age", Members."Date of Birth") = Today then begin

                    Customer.Reset;
                    Customer.Setrange("Retiree Employer", True);
                    if Customer.Find('-') then begin
                        Members."Employer Code" := Customer."No.";
                        Members.Modify();
                    end;

                    Members.Retired := true;
                    Members.Modify();

                    //msg := 'Dear, ' + Members."Name" + ', We wish to inform you that you have officially reached your retirement date. We thank you for your dedication and membership over the years. Kindly visit the Sacco office at your earliest convenience to finalize your pension and retirement benefits and related processes. Warm regards ' + CompanyInfo.;
                    msg := GenSetup."Retirement Message";
                    SendSMS.SendSms(Source::MEMBER_CHANGES, Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', Members."No.", 'CBS', Today);
                end
                else
                    exit
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    Var
        GenSetup: Record "General Set-Up";
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: enum "SMS Source";

}
