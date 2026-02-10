page 52186741 "Alerts Loan Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Alerts Loan Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {

                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    Editable = false;
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    Editable = false;
                }
                field("Principle Balance"; Rec."Principle Balance")
                {
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Amount in Arrears"; Rec."Amount in Arrears")
                {
                    Editable = false;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    Editable = false;
                }
                field("Installments FallOff"; Rec."Installments FallOff")
                {
                    Editable = false;
                }
                field(Period; Rec.Period)
                {
                    Editable = false;
                }
                field("Period Name"; Rec."Period Name")
                {

                }
                field("Process Case"; Rec."Process Case")
                {

                }
                field("System Generated"; Rec."System Generated")
                {
                    Editable = false;
                }
                field("Mark For Attachment"; Rec."Mark For Attachment")
                {
                    Editable = false;
                }
                field("Create Attachment Header"; Rec."Create Attachment Header")
                {

                }
                field("Mark CRB Listing"; Rec."Mark CRB Listing")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }
}
