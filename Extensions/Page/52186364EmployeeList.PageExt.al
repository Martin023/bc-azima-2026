#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186364 pageextension52186364 extends "Employee List" 
{
    Caption = 'Employee List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(FullName)
        {
            ApplicationArea = Basic;
        }
        modify("First Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""First Name"(Control 4)".

        }
        modify("Middle Name")
        {
            ApplicationArea = Basic;
        }
        modify("Last Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Last Name"(Control 8)".

        }
        modify(Initials)
        {
            ApplicationArea = Basic;
        }
        modify("Job Title")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Phone No."(Control 26)".

        }
        modify(Extension)
        {
            ApplicationArea = Basic;
        }
        modify("Mobile Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Statistics Group Code")
        {
            ApplicationArea = Basic;
        }
        modify("Resource No.")
        {
            ApplicationArea = Basic;
        }
        modify("Search Name")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FullName(Control 17)".


        //Unsupported feature: Property Deletion (Visible) on "FullName(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""First Name"(Control 4)".


        //Unsupported feature: Property Deletion (NotBlank) on ""First Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Middle Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Name"(Control 8)".


        //Unsupported feature: Property Deletion (NotBlank) on ""Last Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Initials(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Title"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 84)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Phone No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Extension(Control 80)".


        //Unsupported feature: Property Deletion (Visible) on "Extension(Control 80)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Mobile Phone No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mobile Phone No."(Control 28)".


        //Unsupported feature: Property Deletion (CaptionML) on ""E-Mail"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Statistics Group Code"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource No."(Control 72)".

        modify("Privacy Blocked")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Name"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 16)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Country/Region Code";Extension)
    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-Single")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on ""Dimensions-Single"(Action 184)".

        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Dimensions-&Multiple"(Action 19)".

        }
        modify("&Picture")
        {
            ApplicationArea = Basic;
        }
        modify(AlternativeAddresses)
        {

            //Unsupported feature: Property Modification (Name) on "AlternativeAddresses(Action 45)".

            Caption = '&Alternative Addresses';
            ApplicationArea = Basic;
        }
        modify("&Relatives")
        {
            ApplicationArea = Basic;
        }
        modify("Mi&sc. Article Information")
        {
            ApplicationArea = Basic;
        }
        modify("Co&nfidential Information")
        {
            ApplicationArea = Basic;
        }
        modify("Q&ualifications")
        {
            ApplicationArea = Basic;
        }
        modify("A&bsences")
        {
            ApplicationArea = Basic;
        }
        modify("Absences by Ca&tegories")
        {
            ApplicationArea = Basic;
        }
        modify("Misc. Articles &Overview")
        {
            ApplicationArea = Basic;
        }
        modify("Con&fidential Info. Overview")
        {
            ApplicationArea = Basic;
        }
        modify("Absence Registration")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 184)".


        //Unsupported feature: Property Deletion (RunPageLink) on ""Dimensions-Single"(Action 184)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 19).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(Employee);
            DefaultDimMultiple.SetMultiRecord(Employee,FIELDNO("No."));
            DefaultDimMultiple.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(Employee);
            DefaultDimMultiple.SetMultiEmployee(Employee);
            DefaultDimMultiple.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Picture"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AlternativeAddresses(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Relatives"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mi&sc. Article Information"(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&nfidential Information"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Q&ualifications"(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""A&bsences"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Absences by Ca&tegories"(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Misc. Articles &Overview"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Con&fidential Info. Overview"(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Absence Registration"(Action 58)".

        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify(PayEmployee)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
