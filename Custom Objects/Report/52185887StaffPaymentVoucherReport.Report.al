#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185887 "Staff Payment Voucher Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Staff Payment Voucher Report.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");

            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Company Information".CalcFields("Company Information".Picture);
            end;
        }
        dataitem("Payments Header Board"; "Payments Header Board")
        {
            column(ReportForNavId_21; 21)
            {
            }
            dataitem("Payment Line Staff"; "Payment Line Staff")
            {
                DataItemLink = "Document No" = field("Transaction No.");
                DataItemTableView = sorting("Member No.");
                RequestFilterFields = "Member No.";
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(cOMPnAME; COMPANYNAME)
                {
                }
                column(DocNo; "Document No")
                {
                }
                column(PaymentType; "Payment Types")
                {
                }
                column(MName; "Member Name")
                {
                }
                column(Description; Description)
                {
                }
                column(AmountLines; Amount)
                {
                }
                column(WitholdingTaxAmount; "Payment Line Staff"."W/Tax Amount")
                {
                }
                column(Activity; "Shortcut Dimension 1 Code")
                {
                }
                column(Branch; "Shortcut Dimension 2 Code")
                {
                }
                column(EXTDOC; "External DOC No")
                {
                }
                column(Payee; Payee)
                {
                }
                column(net; Amount - Payee)
                {
                }
                column(MemberNo_PaymentLineBoard; "Payment Line Staff"."Member No.")
                {
                }
                column(StaffNo_PaymentLineBoard; MbrNo)
                {
                }
                column(PaymentTypes_PaymentLineBoard; "Payment Line Staff"."Payment Types")
                {
                }
                column(DailyRateAmount_PaymentLineBoard; "Payment Line Staff"."Daily Rate(Amount)")
                {
                }
                column(NoofDays_PaymentLineBoard; "Payment Line Staff"."No of Days")
                {
                }
                column(NetAmount_PaymentLineBoard; "Payment Line Staff"."Net Amount")
                {
                }
                column(LineNo_PaymentLineBoard; "Payment Line Staff"."Line No")
                {
                }
                column(PerDiemRate; PerDiemRate)
                {
                }
                column(PerDiemDays; PerDiemDays)
                {
                }
                column(PerDiemNet; PerDiemNet)
                {
                }
                column(Date; Date)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    PaymentsHeaderBoard.Reset;
                    PaymentsHeaderBoard.SetRange("Transaction No.", "Payment Line Staff"."Document No");
                    if PaymentsHeaderBoard.Find('-') then begin
                        Date := PaymentsHeaderBoard."Transaction Date";
                    end;


                    PerDiemDays := 0;
                    PerDiemNet := 0;
                    PerDiemRate := 0;
                    if ("Payment Line Staff"."Payment Types" = 'PER DIEM') then// OR ("Payment Line Board"."Payment Types" = 'PERDIEM')  THEN
                    begin
                        PerDiemDays := "Payment Line Staff"."No of Days";
                        PerDiemNet := "Payment Line Staff"."Net Amount";
                        PerDiemRate := "Payment Line Staff"."Daily Rate(Amount)";
                        "Net Amount" := 0;
                    end;
                    Members.Reset;
                    Members.SetRange("Payroll/Staff No.", "Payment Line Staff"."Staff No.");
                    if Members.Find('-') then begin
                        MbrNo := Members."No.";
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Payments Header Board".SetRange("Transaction Date", StartDate, EndDate);
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Payee: Decimal;
        PerDiemRate: Decimal;
        PerDiemDays: Integer;
        PerDiemNet: Decimal;
        Members: Record "Members";
        MbrNo: Code[50];
        Date: Date;
        PaymentsHeaderBoard: Record "Payments Header Board";
        StartDate: Date;
        EndDate: Date;
}
