#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 52185448 "Item Import"
{
    Format = VariableText;
    schema
    {
        textelement(Name)
        {
            tableelement(Item; Item)
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'No';
                fieldelement(a; item."No.")
                {
                    FieldValidate = No;
                
                }
                fieldelement(b; Item.Description)
                {
                    FieldValidate = No;
                    
                }
                fieldelement(c; item."Base Unit of Measure")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(d; Item.Type)
                {
                    FieldValidate = no;
                    
                }
                fieldelement(e; Item."Inventory Posting Group")
                {
                    FieldValidate = no;
                    
                }
                fieldelement(f; Item."Unit Price")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(g; Item."Costing Method")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(h; Item."Unit Cost")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(i; Item."Reorder Point")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(j; Item."Maximum Inventory")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(k;Item."Reorder Quantity")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(l;Item."Gen. Prod. Posting Group")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(m; Item."Global Dimension 1 Code")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(n; Item."Global Dimension 2 Code")
                {
                    FieldValidate = No;
                    
                }
                fieldelement(o; Item."Item G/L Budget Account")
                {
                    FieldValidate = no;
                
                }
                fieldelement(p; Item.Status)
                {
                    FieldValidate = no;
                    
                }
                


            }
        }
    }

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin
        Message('Process completed successful');
    end;
}
