#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185897 "Sink Fund Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sink Fund Report.rdl';

    dataset
    {
        dataitem("BBF Requisation Header"; "BBF Requisation Header")
        {
            DataItemTableView = where(Status = filter(Approved));

            column(CName; Company.Name)
            {
            }
            column(CAdress; Company.Address)
            {
            }
            column(CPicture; Company.Picture)
            {
            }
            column(No; "BBF Requisation Header".No)
            {
            }
            column(Date; "BBF Requisation Header".Date)
            {
            }
            column(MemberNo; MemberNo)
            {
            }
            column(Name; Name)
            {
            }
            dataitem("BBF Requisation Lines"; "BBF Requisation Lines")
            {
                DataItemLink = "Header No" = field(No);
                column(ReportForNavId_6; 6)
                {
                }
                column(AccountNo; "BBF Requisation Lines"."Account No.")
                {
                }
                column(NextofKin; "BBF Requisation Lines"."Next of Kin")
                {
                }
                column(Amount; "BBF Requisation Lines"."BBF Entitlement")
                {
                }
                column(HNo; "BBF Requisation Lines"."Header No")
                {
                }
                column(LoanNo; "BBF Requisation Lines"."Loan No.")
                {
                }
                column(Transaction; "BBF Requisation Lines"."Transaction Type")
                {
                }
                column(AmountPaid; AmountPaid)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // BBFClaimLines.Reset;
                    // BBFClaimLines.SetRange("Requisation No.", "BBF Requisation Lines"."Header No");
                    // BBFClaimLines.SetRange("Account No", "BBF Requisation Lines"."Account No.");
                    // if BBFClaimLines.Find('-') then begin
                    //     AmountPaid := BBFClaimLines."BBF Entitlement Paid";
                    // end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Name := "BBF Requisation Header"."Account Name";
                MemberNo := "BBF Requisation Header"."Member No";
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
        BBFClaimLines: Record "BBF Claim Lines";
        AmountPaid: Decimal;
        Company: Record "Company Information";
        Name: Text;
        MemberNo: Code[20];
}
