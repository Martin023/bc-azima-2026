#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185970 "FOSA PV Lines"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("FOSA Payment Line"; "FOSA Payment Line")
            {
                XmlName = 'FOSAPVLines';
                fieldattribute(lineno; "FOSA Payment Line"."Line No.")
                {
                }
                fieldattribute(no; "FOSA Payment Line".No)
                {
                }
                fieldattribute(Type; "FOSA Payment Line".Type)
                {
                }
                // fieldattribute(AccType; "FOSA Payment Line"."Account Type")
                // {
                // }
                fieldattribute(AccNo; "FOSA Payment Line"."Account No.")
                {
                }
                // fieldattribute(AccName; "FOSA Payment Line"."Account Name")
                // {
                // }
                fieldattribute(Description; "FOSA Payment Line".Description)
                {
                }
                fieldattribute(BranchCode; "FOSA Payment Line"."Global Dimension 1 Code")
                {
                }
                fieldattribute(ActivityCode; "FOSA Payment Line"."Shortcut Dimension 2 Code")
                {
                }
                fieldattribute(Amount; "FOSA Payment Line".Amount)
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
            area(content)
            {
                group("lineno|no|Type|AccNo|Description|BranchCode|ActivityCode|Amount")
                {
                    field(HeaderTemplate; HeaderTemplate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy this header';
                        Editable = false;
                        ToolTip = 'Copy this text and paste it into the first row of your Excel file.';
                    }
                }
            }
        }

        actions
        {
        }
    }
    trigger OninitXmlPort()
    begin
        HeaderTemplate := 'lineno|no|Type|AccNo|Description|BranchCode|ActivityCode|Amount';
    end;



    trigger OnPostXmlPort()
    begin
        Message('Uploaded Successfuly');
    end;

    var
        HeaderTemplate: Text[100];
}
