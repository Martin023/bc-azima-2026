#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185926 "Direct Debit Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Direct Debit Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Recovery Mode" = const("External STO"), "Total Balance" = filter(> 0));
            RequestFilterFields = "Disbursement Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(ClientBankCode; Loans."Client Bank Code")
            {
            }
            column(ClientBankName; Loans."Client Bank Name")
            {
            }
            column(ClientAccountNo; Loans."Client Account No")
            {
            }
            column(ExternalSTOAmount; Loans."External STO  Amount")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(CreditAccountNo; "Credit Account No")
            {
            }
            column(BankBranchCode; "Bank Branch Code")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_picture; CompanyInfo.Picture)
            {
            }
            column(STODueDate; "STO Due Date")
            {
            }
            column(FileNo; FileNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "STO Due Date" = "sto due date"::"02nd" then begin
                    "STO Due Date" := Loans."external sto effective date"::"03rd";
                end else
                    if "STO Due Date" = "sto due date"::"04th" then begin
                        "STO Due Date" := Loans."external sto effective date"::"05th";
                    end else
                        if "STO Due Date" = "sto due date"::"9th" then begin
                            "STO Due Date" := Loans."external sto effective date"::"10th";
                        end else
                            if "STO Due Date" = "sto due date"::"14th" then begin
                                "STO Due Date" := Loans."external sto effective date"::"15th";
                            end else
                                if "STO Due Date" = "sto due date"::"19th" then begin
                                    "STO Due Date" := Loans."external sto effective date"::"20th";
                                end else
                                    if "STO Due Date" = "sto due date"::"24th" then begin
                                        "STO Due Date" := Loans."external sto effective date"::"25th";
                                    end else
                                        if "STO Due Date" = "sto due date"::"27th" then begin
                                            "STO Due Date" := Loans."external sto effective date"::"28th";
                                        end;
                DDate := Format(Loans."External STO Effective Date");
                FileNo := '2261_' + DelChr(DDate, '=', 'A|B|C|d|E|E|F|G|h|I|J|K|L|M|N|O|P|Q|r|S|t|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_') + Format((Date2dmy(Today, 2))) + Format((Date2dmy(Today, 3))) + '_00';



                RLoans.Reset;
                RLoans.SetRange("Loan No.", Loans."Loan No.");
                RLoans.SetFilter("Recovery Mode", '%1', RLoans."recovery mode"::"External STO");
                RLoans.SetRange("External STO Effective Date", "STO Due Date");
                if not RLoans.FindFirst then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                if "STO Due Date" = "sto due date"::" " then Error('Kindly Select Due Date');
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
                field("STO Due Date"; "STO Due Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'STO Due Date';
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

    trigger OnPostReport()
    begin
        //
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        "Bank Branch Code": label '11011';
        "Credit Account No": label '01100040120709';
        CompanyInfo: Record "Company Information";
        "STO Due Date": Option " ","02nd","04th","9th","14th","19th","24th","27th";
        RLoans: Record Loans;
        FileNo: Text;
        DDate: Text;
}
