#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186315 pageextension52186315 extends "Contact Duplicates" 
{
    Caption = 'Contact Duplicates';

    //Unsupported feature: Property Modification (PageType) on ""Contact Duplicates"(Page 5134)".

    layout
    {
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {
            ApplicationArea = Basic;
        }
        modify("Duplicate Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Duplicate Contact Name")
        {
            ApplicationArea = Basic;
        }
        modify("Separate Contacts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duplicate Contact No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duplicate Contact Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Separate Contacts"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Control1)
        {
            group(Control18)
            {
                fixed(Control1902205101)
                {
                    group(Address)
                    {
                        Caption = 'Address';
                        field("Cont.Address";Cont.Address)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contact';
                            Editable = false;
                        }
                        field("Cont2.Address";Cont2.Address)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Duplicate';
                            Editable = false;
                        }
                    }
                    group("Post Code")
                    {
                        Caption = 'Post Code';
                        field("Cont.""Post Code""";Cont."Post Code")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Post Code';
                            Editable = false;
                        }
                        field("Cont2.""Post Code""";Cont2."Post Code")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Post Code';
                            Editable = false;
                        }
                    }
                    group(City)
                    {
                        Caption = 'City';
                        field("Cont.City";Cont.City)
                        {
                            ApplicationArea = Basic;
                            Caption = 'City';
                            Editable = false;
                        }
                        field("Cont2.City";Cont2.City)
                        {
                            ApplicationArea = Basic;
                            Caption = 'City';
                            Editable = false;
                        }
                    }
                    group("Phone No.")
                    {
                        Caption = 'Phone No.';
                        field("Cont.""Phone No.""";Cont."Phone No.")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Phone No.';
                            Editable = false;
                        }
                        field("Cont2.""Phone No.""";Cont2."Phone No.")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Phone No.';
                            Editable = false;
                        }
                    }
                    group("VAT Registration No.")
                    {
                        Caption = 'VAT Registration No.';
                        field("Cont.""VAT Registration No.""";Cont."VAT Registration No.")
                        {
                            ApplicationArea = Basic;
                            Caption = 'VAT Registration No.';
                            Editable = false;
                        }
                        field("Cont2.""VAT Registration No.""";Cont2."VAT Registration No.")
                        {
                            ApplicationArea = Basic;
                            Caption = 'VAT Registration No.';
                            Editable = false;
                        }
                    }
                }
            }
        }
    }
    actions
    {
        // modify(ActionContainer3)
        // {
        //     Visible = false;
        // }
        modify(GenerateDuplicateSearchString)
        {
            Visible = false;
        }
        modify(ContactDuplicateDetails)
        {
            Visible = false;
        }
    }

    var
        Cont: Record Contact;
        Cont2: Record Contact;


    //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //begin
        /*
        Cont.GET("Contact No.");
        Cont2.GET("Duplicate Contact No.");
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
