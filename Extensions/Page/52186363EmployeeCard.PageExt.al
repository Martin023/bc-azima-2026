#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186363 pageextension52186363 extends "Employee Card"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on ""No."(Control 2)".

        }
        modify("First Name")
        {
            ApplicationArea = Basic;
        }
        modify("Middle Name")
        {
            ApplicationArea = Basic;
            Caption = 'Middle Name/Initials';
        }
        modify("Last Name")
        {
            ApplicationArea = Basic;
        }
        modify("Job Title")
        {
            ApplicationArea = Basic;
        }
        modify(Initials)
        {
            ApplicationArea = Basic;
        }
        modify("Search Name")
        {
            ApplicationArea = Basic;
        }
        modify(Gender)
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.2")
        {
            ApplicationArea = Basic;
        }
        modify("Company E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Importance) on ""Last Date Modified"(Control 38)".

        }
        modify("Address & Contact")
        {
            Caption = 'Communication';

            //Unsupported feature: Property Modification (Name) on ""Address & Contact"(Control 1902768601)".

        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Level) on "Address(Control 14)".

            ApplicationArea = Basic;
        }
        modify("Address 2")
        {

            //Unsupported feature: Property Modification (Level) on ""Address 2"(Control 16)".

            ApplicationArea = Basic;
        }
        modify(City)
        {

            //Unsupported feature: Property Modification (Level) on "City(Control 18)".

            ApplicationArea = Basic;
        }
        modify(County)
        {

            //Unsupported feature: Property Modification (Level) on "County(Control 20)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "County(Control 20)".


            //Unsupported feature: Property Modification (Name) on "County(Control 20)".

        }
        // modify("Country/Region Code")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Country/Region Code"(Control 82)".

        //     ApplicationArea = Basic;
        // }
        modify("Mobile Phone No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Mobile Phone No."(Control 26)".

            ApplicationArea = Basic;
        }
        modify(Pager)
        {

            //Unsupported feature: Property Modification (Level) on "Pager(Control 93)".

            ApplicationArea = Basic;
        }
        modify(Extension)
        {

            //Unsupported feature: Property Modification (Level) on "Extension(Control 72)".

            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {

            //Unsupported feature: Property Modification (Level) on ""Phone No."(Control 24)".

            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {

            //Unsupported feature: Property Modification (Level) on ""E-Mail"(Control 28)".

            ApplicationArea = Basic;
        }
        modify("Alt. Address Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Alt. Address Code"(Control 32)".

            ApplicationArea = Basic;
        }
        modify("Alt. Address Start Date")
        {

            //Unsupported feature: Property Modification (Level) on ""Alt. Address Start Date"(Control 34)".

            ApplicationArea = Basic;
        }
        modify("Alt. Address End Date")
        {

            //Unsupported feature: Property Modification (Level) on ""Alt. Address End Date"(Control 36)".

            ApplicationArea = Basic;
        }
        modify("Employment Date")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Inactive Date")
        {
            ApplicationArea = Basic;
        }
        modify("Cause of Inactivity Code")
        {
            ApplicationArea = Basic;
        }
        modify("Termination Date")
        {
            ApplicationArea = Basic;
        }
        modify("Grounds for Term. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Emplymt. Contract Code")
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
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Birth Date")
        {
            ApplicationArea = Basic;
        }
        modify("Social Security No.")
        {
            ApplicationArea = Basic;
        }
        modify("Union Code")
        {
            ApplicationArea = Basic;
        }
        modify("Union Membership No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""No."(Control 2).OnAssistEdit".

        //trigger "(Control 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AssistEdit;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF AssistEdit(xRec) THEN
          CurrPage.UPDATE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""First Name"(Control 4)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""First Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Middle Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Name"(Control 8)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Last Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Title"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Initials(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Search Name"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Gender(Control 11)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Phone No.2"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No.2"(Control 74)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""Company E-Mail"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Company E-Mail"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 38)".

        modify("Privacy Blocked")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (GroupType) on ""Address & Contact"(Control 1902768601)".

        modify(Control13)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 18)".

        modify(Control31)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "County(Control 20)".

        modify("Post Code")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 82)".

        modify(ShowMap)
        {
            Visible = false;
        }
        modify(Control7)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Mobile Phone No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mobile Phone No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Pager(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Extension(Control 72)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Phone No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 24)".


        //Unsupported feature: Property Deletion (CaptionML) on ""E-Mail"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Alt. Address Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Alt. Address Start Date"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Alt. Address End Date"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Employment Date"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inactive Date"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cause of Inactivity Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Termination Date"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Grounds for Term. Code"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Emplymt. Contract Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Statistics Group Code"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource No."(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Birth Date"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Social Security No."(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Union Code"(Control 89)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Union Membership No."(Control 91)".

        modify(Payments)
        {
            Visible = false;
        }
        modify("Employee Posting Group")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify("Bank Branch No.")
        {
            Visible = false;
        }
        modify("Bank Account No.")
        {
            Visible = false;
        }
        modify(Iban)
        {
            Visible = false;
        }
        modify("SWIFT Code")
        {
            Visible = false;
        }
        modify(Control3)
        {
            Visible = false;
        }
        modify("Attached Documents")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("No."; "Job Title")
        moveafter("First Name"; "Last Name")
        moveafter(Initials; Address)
        moveafter("Address 2"; County)
        moveafter("Post Code"; City)
        moveafter(City; "Country/Region Code")
        moveafter("Country/Region Code"; "Phone No.")
        moveafter(Gender; "Last Date Modified")
        //  moveafter(Communication;Extension)
        moveafter(Extension; "Mobile Phone No.")
        moveafter("Phone No.2"; "E-Mail")
    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (RunObject) on "Dimensions(Action 184)".

        }
        modify("&Picture")
        {
            ApplicationArea = Basic;
        }
        modify(AlternativeAddresses)
        {

            //Unsupported feature: Property Modification (Name) on "AlternativeAddresses(Action 75)".

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
        modify("&Confidential Information")
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
        modify("Co&nfidential Info. Overview")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 81)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 81)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (RunPageLink) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Picture"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AlternativeAddresses(Action 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Relatives"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Mi&sc. Article Information"(Action 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Confidential Information"(Action 88)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Confidential Information"(Action 88)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""&Confidential Information"(Action 88)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Confidential Information"(Action 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (Promoted) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Q&ualifications"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""A&bsences"(Action 87)".


        //Unsupported feature: Property Deletion (Promoted) on ""A&bsences"(Action 87)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""A&bsences"(Action 87)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""A&bsences"(Action 87)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Absences by Ca&tegories"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Misc. Articles &Overview"(Action 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&nfidential Info. Overview"(Action 71)".

        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify(Attachments)
        {
            Visible = false;
        }
        modify(PayEmployee)
        {
            Visible = false;
        }
        addafter(Action61)
        {
            action("Online Map")
            {
                ApplicationArea = Basic;
                Caption = 'Online Map';
                Image = Map;

                trigger OnAction()
                begin
                    Rec.DisplayMap;
                end;
            }
        }
    }

    var
        MapMgt: Codeunit "Online Map Management";

    var

        MapPointVisible: Boolean;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    MapPointVisible := TRUE;
    */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: MapMgt)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetNoFieldVisible;
    IsCountyVisible := FormatAddress.UseCounty("Country/Region Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT MapMgt.TestSetup THEN
      MapPointVisible := FALSE;
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
