namespace MNS.MNS;

page 52186494 "Contract Templates Header"
{
    Caption = 'Contract Templates';
    PageType = Card;
    SourceTable = "Contract Templates";
    PromotedActionCategories = 'Home, Lists, Process, Template,Report';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Template No."; Rec."Template No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template No. field.', Comment = '%';
                    Editable = false;
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Type field.', Comment = '%';
                }
                field("Template Description"; Rec."Template Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Description field.', Comment = '%';
                }
                field("Captured By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                    Editable = false;
                }
                field("Captured At"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.', Comment = '%';
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
                    Editable = false;
                }
                field("Responsibility"; Rec."Responsibility Centre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Centre field.', Comment = '%';
                    Editable = false;
                }
                // field("Template Content"; Rec."Template Content")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Template Content field.', Comment = '%';
                //     Editable = false;
                // }
            }

            group(Summary)
            {
                Caption = 'Template';

                field("Template Content"; RichText)
                {
                    Caption = 'Template';
                    //ToolTip = 'Specifies the value of the Perfection Summary field.';
                    Editable = true;
                    MultiLine = true;
                    ExtendedDataType = RichContent;
                    trigger OnValidate()
                    begin
                        Rec.SaveRichText(RichText);
                    end;
                }
            }
            part("Contract Template Lines"; "Contract Template Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Template No." = field("Template No.");
                Visible = false;
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Contract")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Document;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    ContractTemplatesHeader.Reset();
                    ContractTemplatesHeader.SetRange("Template No.", Rec."Template No.");
                    if ContractTemplatesHeader.Find('-') then begin
                        Report.Run(Report::"Contract Templates", true, false, ContractTemplatesHeader);
                    end;
                    // ContractTemplatesHeader.SetRange("Template No.", 'CT-' + FORMAT(ContractTemplatesHeader.COUNT + 1));
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        RichText := Rec.GetRichText(Rec);
        
    end;

    trigger OnAfterGetRecord()
    begin
        RichText := Rec.GetRichText(Rec);
    end;

    
    var
        ContractTemplatesHeader: Record "Contract Templates";
        RichText: Text;
}