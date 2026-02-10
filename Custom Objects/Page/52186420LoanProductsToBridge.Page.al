page 52186420 "Loan Products To Bridge"
{
    PageType = List;
    SourceTable = "Loan Products to Bridge";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product To Bridge"; Rec."Product To Bridge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Briidge All")
            {
                Visible = true;
                ApplicationArea = Basic, Suite;
                Image = ReturnCustomerBill;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    RelatedProduct.RESET;
                    RelatedProduct.SETRANGE(RelatedProduct."Product Code", Rec."Product Code");
                    IF RelatedProduct.FIND('-') THEN BEGIN
                        REPEAT
                            RelatedProduct.DELETE;
                        UNTIL RelatedProduct.NEXT = 0;
                    END;

                    ProductFactory.RESET;
                    ProductFactory.SETRANGE(ProductFactory."Product Class Type", ProductFactory."Product Class Type"::Loan);
                    IF ProductFactory.FIND('-') THEN BEGIN
                        REPEAT
                            RelatedProduct.INIT;
                            RelatedProduct."Product Code" := Rec."Product Code";
                            RelatedProduct."Product To Bridge" := ProductFactory."Product ID";
                            RelatedProduct.VALIDATE("Product To Bridge");
                            RelatedProduct.INSERT;
                        UNTIL ProductFactory.NEXT = 0;
                    END;
                end;
            }
        }

    }
    var
        RelatedProduct: Record "Loan Products to Bridge";
        ProductFactory: Record "Product Factory";
}

