#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185648 "Checkoff Advice - Products"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Checkoff Advice - Products.rdl';

    dataset
    {
        dataitem("Checkoff Header"; "Checkoff Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_2; 2)
            {
            }
            column(PeriodDate; PeriodDate)
            {
            }
            dataitem("Checkoff Advice Line"; "Checkoff Advice Line")
            {
                DataItemLink = "Advice Header No." = field("No.");
                RequestFilterFields = "Employer Code";
                column(ReportForNavId_1; 1)
                {
                }
                column(MemberNo; "Checkoff Advice Line"."Member No.")
                {
                }
                column(PayrollNo; "Checkoff Advice Line"."Payroll No")
                {
                }
                column(Name; Name)
                {
                }
                column(Amount; "Checkoff Advice Line"."Amount On")
                {
                }
                column(Interest; "Checkoff Advice Line".Interest)
                {
                }
                column(ProductFactory; "Checkoff Advice Line"."Product Search Code")
                {
                }
                column(CompanyName; Company.Name)
                {
                }
                column(CompanyAddress; Company.Address)
                {
                }
                column(ComapnyPicture; Company.Picture)
                {
                }
                // column(Period; "Checkoff Advice Header".Period)
                // {
                // }
                // column(EmployerName; "Checkoff Advice Header"."Employer Name")
                // {
                // }

                trigger OnAfterGetRecord()
                begin
                    if Members.Get("Checkoff Advice Line"."Member No.") then begin
                        CheckoffAdviceLine.Reset;
                        CheckoffAdviceLine.SetCurrentkey("Member No.");
                        //CheckoffAdviceLine.SetRange("Advice Header No.", "Checkoff Advice Header"."No.");
                        CheckoffAdviceLine.SetRange("Member No.", Members."No.");
                        if CheckoffAdviceLine.Find('-') then begin
                            repeat
                                MemberNo := CheckoffAdviceLine."Member No.";
                                Name := CheckoffAdviceLine.Names;
                            until CheckoffAdviceLine.Next = 0;
                        end;
                    end;
                    //IF Turn=2 THEN CurrReport.SKIP
                end;

                trigger OnPreDataItem()
                begin
                    i := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //PeriodDate := Format("Checkoff Advice Header"."Start Date") + '..' + Format("Checkoff Advice Header"."End Date");
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
        Company.Get;
        Company.CalcFields(Picture);
    end;

    var
        ProductFactory: Record "Product Factory";
        Loans: Record Loans;
        Members: Record "Members";
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
        Interest: Decimal;
        Amount: Decimal;
        CheckoffAdviceLine: Record "Checkoff Advice Line";
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        Company: Record "Company Information";
        i: Integer;
        PeriodDate: Text;
}
