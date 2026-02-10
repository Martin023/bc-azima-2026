namespace MNS.MNS;

report 52185872 "Rent Escalation"
{
    ApplicationArea = All;
    Caption = 'Rent Escalation';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = True;
    dataset
    {
        dataitem(Lease; Lease)
        //dataitem(LeaseLine; "Lease Line")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if (Lease."Lease Status" = Lease."Lease Status"::Expired) AND (Lease."Lease Status" = Lease."Lease Status"::Terminated) then
                    exit;
                //if (Lease."Escalation For Leases" = 0) then
                exit;
                //if (Lease."Lease Commence Date" = 0D) then
                //    exit
                //else begin
                //Rec.testfield("Lease Commence Date");
                //Rec.testfield("Billing Frequency");
                //rec.TestField(Status, rec.Status::Approved);
                if (Lease."Lease Status" = Lease."Lease Status"::Active) then begin

                    LeaseLine.Reset;
                    LeaseLine.SetRange(LeaseLine."Lease No.", Lease."No.");
                    if LeaseLine.Find('-') then begin
                        repeat
                            Charge.Reset();
                            Charge.SetRange(Code, LeaseLine."Charge No.");
                            Charge.SetRange(Charge."Is Rent", true);
                            if Charge.FindFirst() then begin
                                FValue := LeaseLine."Review Frequency Value";
                                EffectDate := 0D;
                                ReviewFrequency := LeaseLine."Review Frequency";
                                if LeaseLine."Review End Date" = 0D then
                                    LastReviewDate := LeaseLine."Review Start Date"
                                else
                                    LastReviewDate := LeaseLine."Review End Date";

                                //if not (LeaseLine."Review End Date" = Today) then begin
                                LR.Reset;
                                LR.SetRange(LR."Lease No.", Lease."No.");
                                LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                LR.Setrange("Effected Date", CalcDate(Format(LeaseLine."Review Frequency"), CalcDate((Format((LeaseLine."Review Frequency"))), Today)));
                                LR.SetRange("Effect Date", CalcDate(ReviewFrequency, LastReviewDate));
                                //LR.Setrange("Effected Date", CalcDate(Format(LeaseLine."Review Frequency"), CalcDate((Format((LeaseLine."Review Frequency"))), Today)));

                                LR.SetRange(LR.Effected, true);
                                if LR.FindFirst then begin
                                    Error('Lease already has already been escalated and Effected');
                                end

                                else begin
                                    LR.Reset;
                                    LR.SetRange(LR."Lease No.", LeaseLine."Lease No.");
                                    LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                    LR.Setrange("Effected Date", LeaseLine."Review Start Date", CalcDate(ReviewFrequency, LastReviewDate));
                                    LR.SetRange(LR.Effected, false);
                                    LR.DeleteAll;
                                end;

                                // if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Days then begin
                                //     FType := 'D';
                                // end
                                // else
                                //     if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Weeks then begin
                                //         FType := 'W';
                                //     end
                                //     else
                                //         if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Months then begin
                                //             FType := 'M';
                                //         end
                                //         else
                                //             if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Quarters then begin
                                //                 FType := 'Q';
                                //             end
                                //             else
                                //                 if LeaseLine."Review Frequency" = LeaseLine."Review Frequency"::Years then begin
                                //                     FType := 'Y';
                                //                 end;

                                FValue := LeaseLine."Review Frequency Value";
                                EffectDate := 0D;
                                ReviewFrequency := LeaseLine."Review Frequency";
                                if LeaseLine."Review End Date" = 0D then
                                    LastReviewDate := LeaseLine."Review Start Date"
                                else
                                    LastReviewDate := LeaseLine."Review End Date";
                                //OldAmount:=Total;

                                "OldAmount[Rate]" := LeaseLine."Amount Exclusive VAT";
                                if LeaseLine."Review Amount" = 0 then
                                    "OldAmount[Rate]" := LeaseLine."Amount Exclusive VAT" else
                                    "OldAmount[Rate]" := LeaseLine."Review Amount";
                                //repeat
                                //EffectDate := CalcDate(Format(FValue) + Format(FType), EffectDate);

                                EffectDate := CalcDate(ReviewFrequency, LastReviewDate);
                                Message('%1', EffectDate);
                                if Today >= EffectDate then begin
                                    //LeaseLine."Review Is Rate ?" := true;
                                    //LeaseLine."Review Is Amount" := true;
                                    //if LeaseLine."Review Is Rate ?" = true then begin
                                    "NewAmount[Rate]" := "OldAmount[Rate]" + (("OldAmount[Rate]" * LeaseLine."Review Rate") / 100);
                                    //"NewAmount[ReviewAmount]" := "OldAmount[ReviewAmount]" + LeaseLine."Review Amount";
                                    //end;
                                    LR.Reset;
                                    if LR.FindLast then begin
                                        IntC := LR."Line No.";
                                    end
                                    else begin
                                        IntC := 0;
                                    end;
                                    IntC := IntC + 1;

                                    //insert the values and display the same
                                    LR.Init;
                                    LR."Line No." := IntC;
                                    LR."Lease No." := LeaseLine."Lease No.";
                                    LR."Charge No." := LeaseLine."Charge No.";
                                    LR."Charge Name" := LeaseLine."Charge Name";

                                    LR."Old Amount[Rate]" := "OldAmount[Rate]";
                                    LR.Effected := true;
                                    //LR."Old Amount[Review Amount]" := "OldAmount[ReviewAmount]";
                                    LR."Effect Date" := EffectDate;
                                    //LR."New [Review Amount]" := "NewAmount[ReviewAmount]";
                                    LR."New [Rate Amount]" := "NewAmount[Rate]";
                                    LR.Insert;
                                    //set the old amount to be the same as the new amount
                                    // OldAmount:=NewAmount;
                                    "OldAmount[Rate]" := "NewAmount[Rate]";
                                    "OldAmount[ReviewAmount]" := "NewAmount[ReviewAmount]";
                                    //until EffectDate >= LeaseLine."Review End Date";
                                    LeaseLine."Review End Date" := EffectDate;
                                    LeaseLine."Review Amount" := "NewAmount[Rate]";
                                    LeaseLine.Review := true;
                                    LeaseLine.Modify;
                                end
                                else
                                    error('Review Date is not due yet');
                                //end;
                                //check if the review is rate based or a flat figure

                                LR.Reset;
                                LR.SetRange(LR."Lease No.", LeaseLine."Lease No.");
                                LR.SetRange(LR."Charge No.", LeaseLine."Charge No.");
                                PAGE.Run(PAGE::"Lease Charge Review View", LR);
                            end;
                        until LeaseLine.Next = 0;

                    end else
                        error('No lines exists for review');
                end;

            end;
            //end;
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
    var
        LR: Record "Lease Charge Review";
        IntC: Integer;
        EffectDate: Date;
        "NewAmount[Rate]": Decimal;
        FType: Text[30];
        FValue: Integer;
        "OldAmount[Rate]": Decimal;
        LeaseLine: Record "Lease Line";
        "NewAmount[ReviewAmount]": Decimal;
        "OldAmount[ReviewAmount]": Decimal;
        //Lease: Record Lease;
        PropertyCharges: Record "Unit Setup Charges";
        ReviewFrequency: Dateformula;
        LastReviewDate: Date;
        Charge: Record Charges;
}
