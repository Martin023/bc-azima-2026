#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185675 "Loans Provisioning Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loans Provisioning Summary.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Loans Category-SASRA", "Outstanding Balance";
            //DataItemTableView = sorting("Loan No.") where(Posted = filter(Yes), "Outstanding Balance" = filter(<> 0), "Loan Product Type" = filter(<> 135 | 129 | 132 | 130));
            RequestFilterFields = "Loan No.", "Loan Product Type";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PROVLOSSBAL; PROVLOSSBAL)
            {
            }
            column(PROVLOSSBAL1; PROVLOSSBAL1)
            {
            }
            column(V100; 100)
            {
            }
            column(LOSSBAL; LOSSBAL)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(LOSSCOUNT; LOSSCOUNT)
            {
            }
            column(DOUBTBAL; DOUBTBAL)
            {
            }
            column(DOUBTCOUNT; DOUBTCOUNT)
            {
            }
            column(V50; 50)
            {
            }
            column(PROVDOUBTBAL; PROVDOUBTBAL)
            {
            }
            column(SUBBAL; SUBBAL)
            {
            }
            column(SUBCOUNT; SUBCOUNT)
            {
            }
            column(V25; 25)
            {
            }
            column(PROVSUBBAL; PROVSUBBAL)
            {
            }
            column(WATCHBAL; WATCHBAL)
            {
            }
            column(WATCHCOUNT; WATCHCOUNT)
            {
            }
            column(V5; 5)
            {
            }
            column(PROVWATCHBAL; PROVWATCHBAL)
            {
            }
            column(PERFOMBAL; PERFOMBAL)
            {
            }
            column(PERFOMCOUNT; PERFOMCOUNT)
            {
            }
            column(V1; 1)
            {
            }
            column(V1001; 100)
            {
            }
            column(LOSSBAL1; LOSSBAL1)
            {
            }
            column(LOSSCOUNT1; LOSSCOUNT1)
            {
            }
            column(DOUBTBAL1; DOUBTBAL1)
            {
            }
            column(DOUBTCOUNT1; DOUBTCOUNT1)
            {
            }
            column(V501; 50)
            {
            }
            column(PROVDOUBTBAL1; PROVDOUBTBAL1)
            {
            }
            column(SUBBAL1; SUBBAL1)
            {
            }
            column(SUBCOUNT1; SUBCOUNT1)
            {
            }
            column(V251; 25)
            {
            }
            column(PROVSUBBAL1; PROVSUBBAL1)
            {
            }
            column(WATCHBAL1; WATCHBAL1)
            {
            }
            column(WATCHCOUNT1; WATCHCOUNT1)
            {
            }
            column(V51; 5)
            {
            }
            column(PROVWATCHBAL1; PROVWATCHBAL1)
            {
            }
            column(PERFOMBAL1; PERFOMBAL1)
            {
            }
            column(PERFOMCOUNT1; PERFOMCOUNT1)
            {
            }
            column(V11; 1)
            {
            }
            column(PROVPERFOMBAL; PROVPERFOMBAL)
            {
            }
            column(PROVPERFOMBAL1; PROVPERFOMBAL1)
            {
            }
            column(RESCHEDULE; RESCHEDULE)
            {
            }
            column(V100_Control11027560491; 100)
            {
            }
            column(RESCHEDULE_Control1102756050; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756053; RESCHEDULE)
            {
            }
            column(V50_Control1102756054; 50)
            {
            }
            column(RESCHEDULE_Control1102756055; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756056; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756060; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756061; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756062; RESCHEDULE)
            {
            }
            column(V25_Control1102756063; 25)
            {
            }
            column(RESCHEDULE_Control1102756066; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756067; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756068; RESCHEDULE)
            {
            }
            column(V5_Control1102756069; 5)
            {
            }
            column(RESCHEDULE_Control1102756072; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756073; RESCHEDULE)
            {
            }
            column(RESCHEDULE_Control1102756074; RESCHEDULE)
            {
            }
            column(V0_Control1102756075; 1)
            {
            }
            column(RESCHEDULE_Control1102756086; RESCHEDULE)
            {
            }
            column(Tcount; Tcount)
            {
            }
            column(Portfolio; Portfolio)
            {
            }
            column(Tprovision; Tprovision)
            {
            }
            column(Tcount1; Tcount1)
            {
            }
            column(Portfolio1; Portfolio1)
            {
            }
            column(Tprovision1; Tprovision1)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaption; RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl)
            {
            }
            column(FORM_4Caption; FORM_4CaptionLbl)
            {
            }
            column(SASRA_2_004Caption; SASRA_2_004CaptionLbl)
            {
            }
            column(R__46_Caption; R__46_CaptionLbl)
            {
            }
            column(No__of_A_C_sCaption; No__of_A_C_sCaptionLbl)
            {
            }
            column(Outstanding_Loan_Portfolio__Kshs__Caption; Outstanding_Loan_Portfolio__Kshs__CaptionLbl)
            {
            }
            column(Required_Provision____Caption; Required_Provision____CaptionLbl)
            {
            }
            column(Required_Provision_Amount__Kshs__Caption; Required_Provision_Amount__Kshs__CaptionLbl)
            {
            }
            column(ClassificationCaption; ClassificationCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(ACaption; ACaptionLbl)
            {
            }
            column(BCaption; BCaptionLbl)
            {
            }
            column(CCaption; CCaptionLbl)
            {
            }
            column(DCaption; DCaptionLbl)
            {
            }
            column(PORTFOLIO_AGEING_REPORTCaption; PORTFOLIO_AGEING_REPORTCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(PerfomingCaption; PerfomingCaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(LossCaption_Control1102756051; LossCaption_Control1102756051Lbl)
            {
            }
            column(DoubtfulCaption_Control1102756052; DoubtfulCaption_Control1102756052Lbl)
            {
            }
            column(V4Caption_Control1102756057; V4Caption_Control1102756057Lbl)
            {
            }
            column(V5Caption_Control1102756058; V5Caption_Control1102756058Lbl)
            {
            }
            column(SubstandardCaption_Control1102756059; SubstandardCaption_Control1102756059Lbl)
            {
            }
            column(V3Caption_Control1102756064; V3Caption_Control1102756064Lbl)
            {
            }
            column(WatchCaption_Control1102756065; WatchCaption_Control1102756065Lbl)
            {
            }
            column(V2Caption_Control1102756070; V2Caption_Control1102756070Lbl)
            {
            }
            column(PerfomingCaption_Control1102756071; PerfomingCaption_Control1102756071Lbl)
            {
            }
            column(V1Caption_Control1102756076; V1Caption_Control1102756076Lbl)
            {
            }
            column(Rescheduled_Renegotiated_LoansCaption; Rescheduled_Renegotiated_LoansCaptionLbl)
            {
            }
            column(Sub_TotalCaption; Sub_TotalCaptionLbl)
            {
            }
            column(AUTHORIZATIONCaption; AUTHORIZATIONCaptionLbl)
            {
            }
            column(We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_Caption; We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl)
            {
            }
            column(Sign__________________________________________________Date_____________________________Caption; Sign__________________________________________________Date_____________________________CaptionLbl)
            {
            }
            column(Name_of_Authorizing_OfficerCaption; Name_of_Authorizing_OfficerCaptionLbl)
            {
            }
            column(Sign__________________________________________________Date_____________________________Caption_Control1102756084; Sign__________________________________________________Date_____________________________Caption_Control1102756084Lbl)
            {
            }
            column(Name_of_Counter_Signing_OfficerCaption; Name_of_Counter_Signing_OfficerCaptionLbl)
            {
            }
            column(Loans_Loan__No_; "Loan No.")
            {
            }
            column(TCount2; TCount2)
            {
            }
            column(Portfolio2; Portfolio2)
            {
            }
            column(Provision2; Provision2)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //ESSAGE('Category %1 Bal %2',Loans."Loans Category-SASRA",Loans."Outstanding Balance");

                //IF (Loans."Loan Rescheduled"=FALSE) {OR (Loans."Loan Rescheduled"<>FALSE)} THEN BEGIN

                //PERFOMING LOANS
                if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Perfoming then begin
                    PERFOMBAL := PERFOMBAL + Loans."Outstanding Balance";
                    PERFOMCOUNT := PERFOMCOUNT + 1;
                    PROVPERFOMBAL := PERFOMBAL * 0.01;
                end;

                //WATCH LOANS
                if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Watch then begin
                    WATCHBAL := WATCHBAL + Loans."Outstanding Balance";
                    WATCHCOUNT := WATCHCOUNT + 1;
                    PROVWATCHBAL := WATCHBAL * 0.05;
                end;

                //SUBSTANDARD LOANS
                if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Substandard then begin
                    SUBBAL := SUBBAL + Loans."Outstanding Balance";
                    SUBCOUNT := SUBCOUNT + 1;
                    PROVSUBBAL := SUBBAL * 0.25;
                end;



                //DOUBTFUL LOANS
                if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Doubtful then begin
                    DOUBTBAL := DOUBTBAL + Loans."Outstanding Balance";
                    DOUBTCOUNT := DOUBTCOUNT + 1;
                    PROVDOUBTBAL := DOUBTBAL * 0.5;
                end;

                // LOSS LOANS
                if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Loss then begin
                    LOSSBAL := LOSSBAL + Loans."Outstanding Balance";
                    LOSSCOUNT := LOSSCOUNT + 1;
                    PROVLOSSBAL := LOSSBAL * 1.0;
                end;

                Tcount := PERFOMCOUNT + WATCHCOUNT + SUBCOUNT + DOUBTCOUNT + LOSSCOUNT;
                Portfolio := PERFOMBAL + WATCHBAL + SUBBAL + DOUBTBAL + LOSSBAL;
                Tprovision := PROVPERFOMBAL + PROVWATCHBAL + PROVSUBBAL + PROVDOUBTBAL + PROVLOSSBAL;

                //END;
                /*ELSE BEGIN
                
                //RESHECDULED
                //ESSAGE('Category %1 Bal %2',Loans."Loans Category-SASRA",Loans."Outstanding Balance");
                IF Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Perfoming THEN BEGIN
                PERFOMBAL1:=PERFOMBAL1+Loans."Outstanding Balance";
                PERFOMCOUNT1:=PERFOMCOUNT1+1;
                PROVPERFOMBAL1:=PERFOMBAL1*0.01;
                END;
                
                //WATCH LOANS
                IF Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Watch THEN BEGIN
                WATCHBAL1:=WATCHBAL1+Loans."Outstanding Balance";
                WATCHCOUNT1:=WATCHCOUNT1+1;
                PROVWATCHBAL1:=WATCHBAL1*0.05;
                END;
                
                IF Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Substandard THEN BEGIN
                SUBBAL1:=SUBBAL1+Loans."Outstanding Balance";
                SUBCOUNT1:=SUBCOUNT1+1;
                PROVSUBBAL1:=SUBBAL1*0.25;
                END;
                
                
                
                //DOUBTFUL LOANS
                IF Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Doubtful THEN BEGIN
                DOUBTBAL1:=DOUBTBAL1+Loans."Outstanding Balance";
                DOUBTCOUNT1:=DOUBTCOUNT1+1;
                PROVDOUBTBAL1:=DOUBTBAL1*0.5;
                END;
                
                
                
                
                 // LOSS LOANS
                IF Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Loss THEN BEGIN
                LOSSBAL1:=LOSSBAL1+Loans."Outstanding Balance";
                LOSSCOUNT1:=LOSSCOUNT1+1;
                PROVLOSSBAL1:=LOSSBAL1*1.0;
                END;
                
                
                END;
                
                Portfolio1:=PERFOMBAL1+WATCHBAL1+SUBBAL1+DOUBTBAL1+LOSSBAL1;
                Tprovision1:=PROVPERFOMBAL1+PROVWATCHBAL1+PROVSUBBAL1+PROVDOUBTBAL1+PROVLOSSBAL1;
                Tcount1:=PERFOMCOUNT1+WATCHCOUNT1+SUBCOUNT1+DOUBTCOUNT1+LOSSCOUNT1;
                */
                TCount2 := PERFOMCOUNT + WATCHCOUNT + SUBCOUNT + DOUBTCOUNT + LOSSCOUNT + PERFOMCOUNT1 + WATCHCOUNT1 + SUBCOUNT1 + DOUBTCOUNT1 + LOSSCOUNT1;
                Portfolio2 := PERFOMBAL + WATCHBAL + SUBBAL + DOUBTBAL + LOSSBAL + PERFOMBAL1 + WATCHBAL1 + SUBBAL1 + DOUBTBAL1 + LOSSBAL1;
                Provision2 := PROVPERFOMBAL + PROVWATCHBAL + PROVSUBBAL + PROVDOUBTBAL + PROVLOSSBAL + PROVPERFOMBAL1 + PROVWATCHBAL1 + PROVSUBBAL1 + PROVDOUBTBAL1 + PROVLOSSBAL1;

            end;

            trigger OnPreDataItem()
            begin
                //datefilter:=Loans.GETRANGEMAX(Loans."Date filter");
                //maxdate:=format(datefilter);
                Tcount1 := 0;
                Portfolio1 := 0;
                Portfolio := 0;
                Tprovision1 := 0;
                TCount2 := 0;
                Portfolio2 := 0;
                Provision2 := 0;
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
        IntAmount: Decimal;
        RInst: Integer;
        "Net Repayment": Decimal;
        InCount: Integer;
        LoansT: Record EDMS;
        PERFOMBAL: Decimal;
        WATCHBAL: Decimal;
        SUBBAL: Decimal;
        DOUBTBAL: Decimal;
        LOSSBAL: Decimal;
        PERFOMCOUNT: Integer;
        WATCHCOUNT: Integer;
        SUBCOUNT: Integer;
        DOUBTCOUNT: Integer;
        LOSSCOUNT: Integer;
        PROVPERFOMBAL: Decimal;
        PROVWATCHBAL: Decimal;
        PROVSUBBAL: Decimal;
        PROVDOUBTBAL: Decimal;
        PROVLOSSBAL: Decimal;
        Tcount: Integer;
        Portfolio: Decimal;
        Tprovision: Decimal;
        RESCHEDULE: Decimal;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        No__of_A_C_sCaptionLbl: label 'No. of A/C''s';
        Outstanding_Loan_Portfolio__Kshs__CaptionLbl: label 'Outstanding Loan Portfolio (Kshs.)';
        Required_Provision____CaptionLbl: label 'Required Provision (%)';
        Required_Provision_Amount__Kshs__CaptionLbl: label 'Required Provision Amount (Kshs.)';
        ClassificationCaptionLbl: label 'Classification';
        No_CaptionLbl: label 'No.';
        ACaptionLbl: label 'A';
        BCaptionLbl: label 'B';
        CCaptionLbl: label 'C';
        DCaptionLbl: label 'D';
        PORTFOLIO_AGEING_REPORTCaptionLbl: label 'PORTFOLIO AGEING REPORT';
        LossCaptionLbl: label 'Loss';
        DoubtfulCaptionLbl: label 'Doubtful';
        SubstandardCaptionLbl: label 'Substandard';
        WatchCaptionLbl: label 'Watch';
        PerfomingCaptionLbl: label 'Perfoming';
        V1CaptionLbl: label '1';
        V2CaptionLbl: label '2';
        V3CaptionLbl: label '3';
        V4CaptionLbl: label '4';
        V5CaptionLbl: label '5';
        LossCaption_Control1102756051Lbl: label 'Loss';
        DoubtfulCaption_Control1102756052Lbl: label 'Doubtful';
        V4Caption_Control1102756057Lbl: label '4';
        V5Caption_Control1102756058Lbl: label '5';
        SubstandardCaption_Control1102756059Lbl: label 'Substandard';
        V3Caption_Control1102756064Lbl: label '3';
        WatchCaption_Control1102756065Lbl: label 'Watch';
        V2Caption_Control1102756070Lbl: label '2';
        PerfomingCaption_Control1102756071Lbl: label 'Perfoming';
        V1Caption_Control1102756076Lbl: label '1';
        Rescheduled_Renegotiated_LoansCaptionLbl: label 'Rescheduled/Renegotiated Loans';
        Sub_TotalCaptionLbl: label 'Sub-Total';
        AUTHORIZATIONCaptionLbl: label 'AUTHORIZATION';
        We_declare_that_this_return__to_the_best_of_our_knowledge_and_belief_is_correct_CaptionLbl: label 'We declare that this return, to the best of our knowledge and belief is correct.';
        Sign__________________________________________________Date_____________________________CaptionLbl: label '................................................Sign..................................................Date.............................';
        Name_of_Authorizing_OfficerCaptionLbl: label 'Name of Authorizing Officer';
        Sign__________________________________________________Date_____________________________Caption_Control1102756084Lbl: label '................................................Sign..................................................Date.............................';
        Name_of_Counter_Signing_OfficerCaptionLbl: label 'Name of Counter Signing Officer';
        datefilter: Date;
        maxdate: Text;
        PERFOMBAL1: Decimal;
        WATCHBAL1: Decimal;
        SUBBAL1: Decimal;
        DOUBTBAL1: Decimal;
        LOSSBAL1: Decimal;
        PERFOMCOUNT1: Integer;
        WATCHCOUNT1: Integer;
        SUBCOUNT1: Integer;
        DOUBTCOUNT1: Integer;
        LOSSCOUNT1: Integer;
        PROVPERFOMBAL1: Decimal;
        PROVWATCHBAL1: Decimal;
        PROVSUBBAL1: Decimal;
        PROVDOUBTBAL1: Decimal;
        PROVLOSSBAL1: Decimal;
        Tcount1: Decimal;
        Portfolio1: Decimal;
        Tprovision1: Decimal;
        TCount2: Decimal;
        Portfolio2: Decimal;
        Provision2: Decimal;
}
