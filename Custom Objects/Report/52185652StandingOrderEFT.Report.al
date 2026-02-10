#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185652 "Standing Order RTGS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Standing Order EFT.rdl';

    dataset
    {
        dataitem("RTGS Transfer Header"; "RTGS Transfer Header")
        {
            RequestFilterFields = "Document No. Filter", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                STORegister.Reset;
                if "RTGS Transfer Header".GetFilter("RTGS Transfer Header"."Date Filter") <> '' then
                    STORegister.SetFilter(STORegister."Date Processed", "RTGS Transfer Header".GetFilter("RTGS Transfer Header"."Date Filter"));
                if "RTGS Transfer Header".GetFilter("RTGS Transfer Header"."Document No. Filter") <> '' then
                    STORegister.SetFilter(STORegister."Document No.", "RTGS Transfer Header".GetFilter("RTGS Transfer Header"."Document No. Filter"));
                STORegister.SetRange(STORegister.EFT, true);
                STORegister.SetRange(STORegister."Deduction Status", STORegister."deduction status"::Successful);
                STORegister.SetRange(STORegister."Transfered to EFT", false);
                if STORegister.Find('-') then begin
                    repeat

                        RTGSDetails.Init;
                        RTGSDetails.No := '';
                        RTGSDetails."Document No." := "RTGS Transfer Header"."No.";
                        RTGSDetails."Account Type" := RTGSDetails."account type"::Savings;
                        RTGSDetails."Account No." := STORegister."Source Account No.";
                        RTGSDetails.Amount := STORegister.Amount;//"Amount Deducted";

                        STOlines.Reset;
                        STOlines.SetRange(STOlines."Document No.", STORegister."Document No.");
                        if STOlines.Find('-') then begin
                            RTGSDetails."External Account No." := STOlines."Destination Account No.";
                            RTGSDetails."External Account No." := STOlines."Bank Account No.";
                            RTGSDetails."Bank Code" := STOlines."Bank Code";
                            RTGSDetails."External Account Name" := STOlines."Destination Account Name";
                        end;

                        RTGSDetails."Standing Order No" := STORegister."Document No.";//"Standing Order No.";
                        RTGSDetails."Standing Order Register No" := STORegister."No.";
                        if RTGSDetails.Amount > 0 then
                            RTGSDetails.Insert(true);


                        RTGSDetails.Reset;
                        RTGSDetails.SetRange(RTGSDetails."Document No.", "No.");
                        if RTGSDetails.Find('-') then begin
                            RTGSDetails.Validate(RTGSDetails."Account No.");
                            RTGSDetails.Validate(RTGSDetails."Bank Code");
                            RTGSDetails.Validate(RTGSDetails.Amount);
                            RTGSDetails.Modify;
                        end;


                    until STORegister.Next = 0
                end;

                "RTGS Transfer Header"."Standing Order RTGS Done" := true;
                // UnknownTable52185715.Modify;
            end;

            trigger OnPostDataItem()
            begin

                Message('The RTGS Batch has been Completed sucessfully');
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
        STORegister: Record "Standing Order Register";
        RTGSDetails: Record "RTGS Transfer Lines";
        STOlines: Record "Standing Order Lines";
}
