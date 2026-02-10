#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185807 "OverTimeClaims Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/OverTimeClaims Voucher.rdl';

    dataset
    {
        dataitem("Overtime Claim Header"; "Overtime Claim Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            // column(StrCopyText; StrCopyText)
            // {
            // }
            column(ClaimNo_OvertimeClaimHeader; "Overtime Claim Header"."Claim No")
            {
            }
            column(Department_OvertimeClaimHeader; "Overtime Claim Header".Department)
            {
            }
            column(DateCreated_OvertimeClaimHeader; "Overtime Claim Header"."Date Created")
            {
            }
            column(CreatedBy_OvertimeClaimHeader; "Overtime Claim Header"."Created By")
            {
            }
            column(StaffNo_OvertimeClaimHeader; "Overtime Claim Header"."Staff No.")
            {
            }
            column(Name_OvertimeClaimHeader; "Overtime Claim Header".Name)
            {
            }
            column(Status_OvertimeClaimHeader; "Overtime Claim Header".Status)
            {
            }
            column(ResponsibilityCenter_OvertimeClaimHeader; "Overtime Claim Header"."Responsibility Center")
            {
            }
            column(CurrencyCode_OvertimeClaimHeader; "Overtime Claim Header"."Currency Code")
            {
            }
            column(Amount_OvertimeClaimHeader; "Overtime Claim Header".Amount)
            {
            }
            column(NoSeries_OvertimeClaimHeader; "Overtime Claim Header"."No. Series")
            {
            }
            column(NoPrinted_OvertimeClaimHeader; "Overtime Claim Header"."No. Printed")
            {
            }
            column(TotalOvertimeHrs_OvertimeClaimHeader; "Overtime Claim Header"."Total Overtime Hrs")
            {
            }
            column(TotalOvertimeWeekDays_OvertimeClaimHeader; "Overtime Claim Header"."Total Overtime Week Days")
            {
            }
            column(TotalOvertimeWeekendHolid_OvertimeClaimHeader; "Overtime Claim Header"."Total Overtime Weekend & Holid")
            {
            }
            // column(NumberText; NumberText[1])
            // {
            // }
            // column(SNo; SNo)
            // {
            // }
            dataitem("Overtime Claim Lines"; "Overtime Claim Lines")
            {
                column(ReportForNavId_2; 2)
                {
                }
                column(ClaimLineNo_OvertimeClaimLines; "Overtime Claim Lines"."Claim Line No")
                {
                }
                column(ClaimNo_OvertimeClaimLines; "Overtime Claim Lines"."Claim No")
                {
                }
                column(Date_OvertimeClaimLines; "Overtime Claim Lines".Date)
                {
                }
                column(WorkDescriptionReason_OvertimeClaimLines; "Overtime Claim Lines"."Work Description/Reason")
                {
                }
                column(NoofHours_OvertimeClaimLines; "Overtime Claim Lines"."No. of Hours")
                {
                }
                column(Amount_OvertimeClaimLines; "Overtime Claim Lines".Amount)
                {
                }
                column(OvertimeType_OvertimeClaimLines; "Overtime Claim Lines"."Overtime Type")
                {
                }
                column(TimeFrom_OvertimeClaimLines; "Overtime Claim Lines"."Time From")
                {
                }
                column(TimeTo_OvertimeClaimLines; "Overtime Claim Lines"."Time To")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    /*DimVal.RESET;
                    DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                    DimVal.SETRANGE(DimVal.Code,"Shortcut Dimension 2 Code");
                    DimValName:='';
                    IF DimVal.FINDFIRST THEN
                      BEGIN
                        DimValName:=DimVal.Name;
                      END;
                    
                    TTotal:=TTotal + "Payment Line".Amount ;
                    */

                end;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("Claim No");
                DataItemTableView = where("Document Type" = const(58));
                column(ReportForNavId_29; 29)
                {
                }
                column(DocumentNo_ApprovalEntry; "Approval Entry"."Document No.")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
            end;

            trigger OnPostDataItem()
            begin

                if CurrReport.Preview = false then begin
                    "No. Printed" := "No. Printed" + 1;
                    //UnknownTable52185936.Modify;
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
        SNo := 0;
    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[50];
        TTotal: Decimal;
        //CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        ApprovalEntries: Record "Approval Entry";
        ApproverName: Text[50];
        ApprovalDate: DateTime;
        SNo: Integer;
}
