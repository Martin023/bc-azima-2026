namespace MNS.MNS;

report 52186156 "Contract Templates"
{
    ApplicationArea = All;
    Caption = 'Contract Templates';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;

    WordLayout = './bc-kenpipe-2024/Layout/Contract Templates.docx';
    dataset
    {
        dataitem(ContractTemplates; "Contract Templates")
        {
            column(TemplateNo; "Template No.")
            {
            }
            column(TemplateType; "Template Type")
            {
            }
            column(TemplateDescription; "Template Description")
            {
            }
            column(ClauseCount; ClauseCount)
            {
            }
            column(ContractBody; ContractBody)
            {
            }
            column(ConcatenatedContractBody; ConcatenatedContractBody)
            {
            }
            column(Template_Content; ContractTemplates."Template Content")
            {

            }
            column(HtmlText; HtmlText)
            {
            }
            // dataitem(ContractTemplatesLines; "Contract Templates Lines")
            // {
            //     DataItemLinkReference = ContractTemplates;
            //     DataItemLink = "Template No." = field("Template No.");
            //     column(LinesTemplateNo; "Template No.")
            //     {
            //     }
            //     column(Clause; "Clause")
            //     {
            //     }
            //     column(Body; "Body")
            //     {
            //     }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin



                begin
                    //HtmlText := '<p>This is <strong>bold</strong> and <em>italic</em> text.</p>';
                    HtmlText := Format(ContractTemplates."Template Content");
                    //CleanText := STRIPHTML(HtmlText);
                    Message(CleanText); // Outputs: "This is bold and italic text."
                end;

                // ContractTemplatesLines.RESET;
                // ContractTemplatesLines.SETRANGE("Template No.", ContractTemplates."Template No.");
                // ClauseCount := ContractTemplatesLines.COUNT;
                // if ContractTemplatesLines.Find('-') then begin
                //     ClauseCount := 1;
                //     repeat
                //         ContractBody := ContractTemplatesLines.Clause + NewLine() + ContractTemplatesLines.Body;
                //         if i = ClauseCount then
                //             ConcatenatedContractBody += ContractBody;
                //         i += 1;
                //     until ContractTemplatesLines.Next = 0;
                //     Message('Clause Count: %1', ClauseCount);
                //     Message('Contract Body: %1', ConcatenatedContractBody);
                // end;
            end;
            //}
        }
    }


    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
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

    local procedure NewLine() NewLine: Text
    var
        nL: Char;
    begin

        nL := 13;
        NewLine := Format(nL, 0, '<CHAR>');
    end;


    // PROCEDURE HtmlDecode(InText@1000 : Text): Text;
    // VAR
    //     SystemWebHttpUtility: DotNet "'System.Web, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.System.Web.HttpUtility";
    //     RegEx: DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.RegularExpressions.Regex";
    // BEGIN
    //     SystemWebHttpUtility := SystemWebHttpUtility.HttpUtility;
    //     EXIT(
    //       SystemWebHttpUtility.HtmlDecode(
    //         RegEx.Replace(InText, '<!--[\S\s]*?-->|<(?:"".*?""|''.*?''|[\S\s])*?>', '')));
    // END;

    var
        ContractTemplatesLines: Record "Contract Templates Lines";
        i: Integer;
        ClauseCount: Integer;
        ContractBody: Text;
        ConcatenatedContractBody: Text;
        HtmlText: Text;
        CleanText: Text;
}
