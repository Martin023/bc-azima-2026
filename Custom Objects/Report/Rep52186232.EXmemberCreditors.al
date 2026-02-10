namespace KenpipeCBS.KenpipeCBS;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Account;

report 52186232 "EX member Creditors"
{
    ApplicationArea = All;
    Caption = 'EX member Creditors Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/EX member Creditors Report.rdl';
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            column(GLAccountNo; "G/L Account No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Description; Description)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(User_ID; "User ID") { }

            trigger OnPreDataItem()
            begin
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", glAccount);

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
                    field(glAccount; glAccount)
                    {
                        TableRelation = "G/L Account"."No.";
                        Caption = 'GL Account No.';

                    }
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
    trigger OnPreReport()
    begin
        if glAccount = '' then Error('Please select a GL Account');

    end;

    var
        glAccount: code[100];
}
