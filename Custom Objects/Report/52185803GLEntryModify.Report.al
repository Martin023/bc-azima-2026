#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185803 "GL Entry Modify"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/GL Entry Modify.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*
                //phase 1 set gl entry
                "G/L Entry"."Old G/L Account No.":="G/L Entry"."G/L Account No.";
                MODIFY;
                */
                /*
                //Phase 2 set gl account
                "No 3" := "No.";
                MODIFY;
                */
                /*
                //import no. 2 xmlport
                //phase 3 set gl account
                GLAccounts.RESET;
                GLAccounts.SETFILTER(GLAccounts."No. 2",'<>%1','');
                GLAccounts.SETRANGE(GLAccounts."No. 2","G/L Account"."No. 2");
                IF GLAccounts.FINDSET THEN BEGIN
                  IF GLAccounts.COUNT>1 THEN
                     "Rename Status":="Rename Status"::Many
                  ELSE IF GLAccounts.COUNT=1 THEN
                   "Rename Status":="Rename Status"::One;
                MODIFY;
                END;
                */
                /*
                //phase 4 set gl account
                IF "No. 2" = '' THEN
                "G/L Account"."Rename Status":="G/L Account"."Rename Status"::Blank;
                MODIFY;
                */
                /*
                //do not run has no effect
                //phase 5 set gl account
                GLAccounts.RESET;
                GLAccounts.SETFILTER(GLAccounts."No. 2",'<>%1','');
                GLAccounts.SETRANGE(GLAccounts."No. 2","G/L Account"."No. 2");
                IF GLAccounts.FINDFIRST THEN BEGIN
                     //"Rename Status":="Rename Status"::Many;
                     GLAccounts."First Record":=TRUE;
                     MODIFY;
                END;
                */
                /*
                //phase 6 set analysis view entry
                "Old Account No.":="Account No.";
                MODIFY;
                */
                /*
                //phase 7 set Analysis View Budget Entry
                "Old g/l Account No.":="g/l Account No.";
                MODIFY;
                */
                /*
                
                //phase 8 mark coa without new codes as delete or dont delete
                GLLength:=STRLEN(FORMAT("No."));
                IF GLLength = 5 THEN
                BEGIN
                  GLEntry.RESET;
                  GLEntry.SETRANGE(GLEntry."G/L Account No.","No.");
                  IF GLEntry.FINDFIRST THEN
                  BEGIN
                    "Dont Delete":= TRUE;
                    MODIFY;
                  END
                  ELSE BEGIN
                    "Marked For Deletion":= TRUE;
                    MODIFY;
                  END
                END
                */
                "G/L Account".Totaling := '';
                "G/L Account".Modify;

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
        GLAccounts: Record "G/L Account";
        GLLength: Integer;
        GLEntry: Record "G/L Entry";
}
