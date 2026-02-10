page 52185711 "Product Factory List"
{
    CardPageID = "Product Factory";
    Caption = 'Product Setups List';
    DataCaptionFields = "Product ID", "Product Description";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Product Factory";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Posting Group"; Rec."Product Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Rate (Min.)"; Rec."Interest Rate (Min.)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Rate (Max.)"; Rec."Interest Rate (Max.)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Ordinary Default Intallments"; Rec."Ordinary Default Intallments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product SLA"; Rec."Product SLA")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Interest Account [G/L]"; Rec."Loan Interest Account [G/L]")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Guarantors"; Rec."Minimum Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Loan Amount"; Rec."Maximum Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Loan Amount"; Rec."Minimum Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Nature of Loan Type"; Rec."Nature of Loan Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Class Type"; Rec."Product Class Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Span"; Rec."Loan Span")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sort Order"; Rec."Sort Order")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Updated By"; Rec."Last Updated By")
                {
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;

                }
            }
        }

        area(factboxes)
        {
            systempart(Control7; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control8; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control9; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        ProductFactory: Record "Product Factory";
    //Testing: codeunit hrdates
    begin
        // OnAccesRestrictView();
    end;

    //[Scope('OnPrem')]
    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance.';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Edit Setup", true);
        ChangePermission.SetRange("Product Setup", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::"Ict Group");
        if not ChangePermission.Find('-') then begin
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end;
    end;

}

