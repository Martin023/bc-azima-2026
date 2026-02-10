#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185837 "Contract Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Contract Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Contracts; Contracts)
        {
            RequestFilterFields = "End Date", Status, "Contract No", "Amount Paid";
            column(ReportForNavId_1; 1)
            {
            }
            column(ContractNo_Contracts; Contracts."Contract No")
            {
            }
            column(Type_Contracts; Contracts."Contractor Type")
            {
            }
            column(ContractorNo_Contracts; Contracts."Contractor No")
            {
            }
            column(Name_Contracts; Contracts."Contractor Name")
            {
            }
            column(Address_Contracts; Contracts.Address)
            {
            }
            column(TelNo_Contracts; Contracts."Tel No.")
            {
            }
            // column(ContactPerson_Contracts;Contracts."Contact Person")
            // {
            // }
            // column(StartDate_Contracts;Contracts."Start Date")
            // {
            // }
            // column(EndDate_Contracts;Contracts."End Date")
            // {
            // }
            // column(Status_Contracts;Contracts.Status)
            // {
            // }
            // column(Duration_Contracts;Contracts."Contract Duration")
            // {
            // }
            // column(ContractType_Contracts;Contracts."Contract Type")
            // {
            // }
            // column(ContractLine_Contracts;Contracts."Contract Line")
            // {
            // }
            // column(ContractValue_Contracts;Contracts."Contract Amount")
            // {
            // }
            // column(Balance_Contracts;Contracts.Balance)
            // {
            // }
            // column(AssetServiceNo_Contracts;Contracts."Asset/Service No")
            // {
            // }
            // column(NoSeries_Contracts;Contracts."No. Series")
            // {
            // }
            // column(ContractCycle_Contracts;Contracts."Contract Cycle")
            // {
            // }
            // column(RenewalNo_Contracts;Contracts."Renewal No")
            // {
            // }
            // column(LineType_Contracts;Contracts."Line Type")
            // {
            // }
            // column(ReviewDate_Contracts;Contracts."Review Date")
            // {
            // }
            // column(ContractLineType_Contracts;Contracts."Contract Line Type")
            // {
            // }
            // column(PaymentTerms_Contracts;Contracts."Payment Terms")
            // {
            // }
            // column(AssignedTo_Contracts;Contracts."Responsible Employee")
            // {
            // }
            // column(AmountPaid_Contracts;Contracts."Amount Paid")
            // {
            // }
            // column(AmountSales_Contracts;Contracts."Responsible Employee Name")
            // {
            // }
            // column(Remarks_Contracts;Contracts.Remarks)
            // {
            // }
            // column(Reasons_Contracts;Contracts."Reasons On End Date Variation")
            // {
            // }
            // column(Advocates_Contracts;Contracts.Advocates)
            // {
            // }
            // column(QuantumofClaim_Contracts;Contracts."Quantum of Claim")
            // {
            // }
            column(NextReviewDate_Contracts; Contracts."Type Of Service")
            {
            }
            column(AdvocateName_Contracts; Contracts."Advocate Name")
            {
            }
            column(LastReviewDate_Contracts; Contracts."Nature Of Service")
            {
            }
            column(Comment_Contracts; Contracts.Comment)
            {
            }
            column(ShortcutDimension2Code_Contracts; Contracts."Shortcut Dimension 2 Code")
            {
            }
            column(ShortcutDimension1Code_Contracts; Contracts."Shortcut Dimension 1 Code")
            {
            }
            dataitem(Milestones; Milestones)
            {
                DataItemLink = "Contract No" = field("Contract No");
                column(ReportForNavId_2; 2)
                {
                }
                column(OpportunityNo_ContractMilestoneEntry; Milestones."Contract No")
                {
                }
                // column(SalesCycleCode_ContractMilestoneEntry;Milestones."Sales Cycle Code")
                // {
                // }
                column(SalesCycleStage_ContractMilestoneEntry; Milestones."Milestone Stage")
                {
                }
                column(ContactNo_ContractMilestoneEntry; Milestones."Start Date")
                {
                }
                column(ContactCompanyNo_ContractMilestoneEntry; Milestones."End Date")
                {
                }
                column(SalespersonCode_ContractMilestoneEntry; Milestones."Completed %")
                {
                }
                // column(CampaignNo_ContractMilestoneEntry;Milestones."Campaign No.")
                // {
                // }
                column(DateofChange_ContractMilestoneEntry; Milestones."Stage Description")
                {
                }
                column(Active_ContractMilestoneEntry; Milestones."Committee Remarks")
                {
                }
                // column(DateClosed_ContractMilestoneEntry;Milestones."Date Closed")
                // {
                // }
                // column(DaysOpen_ContractMilestoneEntry;Milestones."Milestone Status")
                // {
                // }
                // column(ActionTaken_ContractMilestoneEntry;Milestones."Line No")
                // {
                // }
                // column(EstimatedValueLCY_ContractMilestoneEntry;Milestones."Estimated Value (LCY)")
                // {
                // }
                // column(CalcdCurrentValueLCY_ContractMilestoneEntry;Milestones."Calcd. Current Value (LCY)")
                // {
                // }
                // column(Completed_ContractMilestoneEntry;Milestones."Completed %")
                // {
                // }
                // column(ChancesofSuccess_ContractMilestoneEntry;Milestones."Chances of Success %")
                // {
                // }
                // column(Probability_ContractMilestoneEntry;Milestones."Probability %")
                // {
                // }
                // column(CloseOpportunityCode_ContractMilestoneEntry;Milestones."Close Opportunity Code")
                // {
                // }
                // column(PreviousSalesCycleStage_ContractMilestoneEntry;Milestones."Previous Sales Cycle Stage")
                // {
                // }
                // column(EstimatedCloseDate_ContractMilestoneEntry;Milestones."Estimated Close Date")
                // {
                // }
                column(StageDescription_ContractMilestoneEntry; Milestones."Stage Description")
                {
                }
                column(CompanyInformationName; CompanyInformation.Name)
                {
                }
                column(CompanyInformationName2; CompanyInformation."Name 2")
                {
                }
                column(CompanyInformationAddress; CompanyInformation.Address)
                {
                }
                column(CompanyInformationAddress2; CompanyInformation."Address 2")
                {
                }
                column(CompanyInformationPicture; CompanyInformation.Picture)
                {
                }
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
        CompanyInformation: Record "Company Information";
}
