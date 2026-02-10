#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185424 pageextension52185424 extends "Company Information"
// {
//     layout
//     {
//         addafter("Phone No.2")
//         {
//             field("Phone No. 2"; Rec."Phone No. 2")
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }
// }             

{
    layout
    {
        addafter("Name")
        {
            field("Building Name"; Rec."Building Name")
            {
                ApplicationArea = Basic;
            }
        }

        addafter("Picture")
        {
            field("Demo Company"; Rec."Demo Company")
            {
                ApplicationArea = Basic;
                Visible = true;
                Editable = true;
            }
            field("CEO Name"; Rec."CEO")
            {
                ApplicationArea = Basic;
            }
            field("CEO Signature"; Rec."CEO Signature")
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field("Director Name"; Rec."Director")
            {
                ApplicationArea = Basic;
            }
            field("Director Signature"; Rec."Director Signature")
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field("Chairman Name"; Rec."Chairman")
            {
                ApplicationArea = Basic;
            }
            field(ChairmanSignature; Rec."Chairman Signature")
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field(Secretary; Rec.Secretary)
            {
                ApplicationArea = Basic;
            }
            field("Secretary Signature"; Rec."Secretary Signature")
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field("Treasurer Name"; Rec."Treasurer")
            {
                ApplicationArea = Basic;
            }
            field("Treasurer Signature"; Rec."Treasurer Signature")
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }

            field("Business Loans Officer"; Rec."Business Loans Officer")
            {
                ApplicationArea = Basic;
                Caption = 'Credit Manager';
            }
            field("Legal Manager Name"; Rec."Legal Manager Name")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            FIELD("Legal Manager Title"; Rec."Legal Manager Title")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Legal Manager Signature"; Rec."Legal Manager Signature")
            {
                ApplicationArea = Basic;
                Visible = false;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field("Officer Name"; Rec."Legal Officer Name")
            {
                Caption = 'Officer Name';
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Designation"; Rec."Legal Officer Title")
            {
                Caption = 'Designation';
                ApplicationArea = Basic;
            }
            field("Legal Officer Signature"; Rec."Legal Officer Signature")
            {
                ApplicationArea = Basic;
                Visible = false;
                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            Field("Bank"; Rec."Bank 1")
            {
                ApplicationArea = Basic;
            }
            field("Bank Branch"; Rec."Bank Branch")
            {
                ApplicationArea = Basic;
            }
            field("Bank A/C No."; Rec."Bank A/C No.")
            {
                ApplicationArea = Basic;
            }
            Field("Bank 2"; Rec."Bank 2")
            {
                ApplicationArea = Basic;
            }
            field("Bank Branch 2"; Rec."Bank Branch 2")
            {
                ApplicationArea = Basic;
            }
            field("Bank A/C No. 2"; Rec."Bank A/C No. 2")
            {
                ApplicationArea = Basic;
            }
            field("ISO Certification"; Rec."ISO Certification")
            {
                ApplicationArea = Basic;
            }
            field("Website"; Rec."Website")
            {
                ApplicationArea = Basic;
            }
            field("Members Portal Link"; rec."Members Portal Link")
            {
                ApplicationArea = Basic;
            }
            field("Customer Management Portal Url"; rec."Customer Management Portal Url")
            {
                ApplicationArea = Basic;
            }

            field("SACCO Physical Address/STREET"; Rec."Address 2")
            {
                ApplicationArea = Basic;
            }
            // field("Mwalimu Seal"; Rec."Mwalimu Seal")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Mwalimu Seal - 2"; Rec."Mwalimu Seal - 2")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Address)
        {
            ApplicationArea = Basic;
        }
        modify("Address 2")
        {
            ApplicationArea = Basic;
        }
        modify(City)
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
        }
        modify("VAT Registration No.")
        {
            ApplicationArea = Basic;
        }
        modify(GLN)
        {
            ApplicationArea = Basic;
        }
        modify("Industrial Classification")
        {
            ApplicationArea = Basic;
        }
        modify(Picture)
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.2")
        {
            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }
        modify("Home Page")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Blank Payment Info.")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Name")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Branch No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Routing No.")
        {
            ApplicationArea = Basic;
        }
        modify("Giro No.")
        {
            ApplicationArea = Basic;
        }
        modify("SWIFT Code")
        {
            ApplicationArea = Basic;
        }
        modify(Iban)
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Address")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Address 2")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to City")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Responsibility Center")
        {
            ApplicationArea = Basic;
        }
        modify("Check-Avail. Period Calc.")
        {
            ApplicationArea = Basic;
        }
        modify("Check-Avail. Time Bucket")
        {
            ApplicationArea = Basic;
        }
        modify("Base Calendar Code")
        {
            ApplicationArea = Basic;
        }
        modify("Customized Calendar")
        {
            ApplicationArea = Basic;
        }
        modify("Cal. Convergence Time Frame")
        {
            ApplicationArea = Basic;
        }
        // modify(Control100)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("System Indicator Style")
        {
            ApplicationArea = Basic;
        }
        modify("System Indicator Text")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 8)".

        modify(County)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 42)".

        modify("Contact Person")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Registration No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GLN(Control 7)".

        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Industrial Classification"(Control 76)".


        //Unsupported feature: Property Deletion (Importance) on ""Industrial Classification"(Control 76)".

        // modify(Picture)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Picture(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No.2"(Control 50)".


        //Unsupported feature: Property Deletion (Importance) on ""Phone No.2"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 54)".


        //Unsupported feature: Property Deletion (Importance) on ""Fax No."(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Home Page"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 78)".


        //Unsupported feature: Property Deletion (Importance) on ""IC Partner Code"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Inbox Type"(Control 80)".


        //Unsupported feature: Property Deletion (Importance) on ""IC Inbox Type"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Inbox Details"(Control 82)".


        //Unsupported feature: Property Deletion (Importance) on ""IC Inbox Details"(Control 82)".

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Blank Payment Info."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Name"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Branch No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Routing No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Giro No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SWIFT Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IBAN(Control 74)".

        modify(BankAccountPostingGroup)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 49)".

        modify("Ship-to County")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Country/Region Code"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Check-Avail. Period Calc."(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Check-Avail. Time Bucket"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Calendar Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customized Calendar"(Control 69)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cal. Convergence Time Frame"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control100(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""System Indicator Style"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""System Indicator Text"(Control 102)".

        modify("User Experience")
        {
            Visible = false;
        }
        modify(Experience)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter(Picture)
        {
            // field("Company Watermark 2";"Company Watermark2")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Use Sales Agent s";"Use Sales Agents")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Accrue Registration Fe e";"Accrue Registration Fee")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Sacco Cod e";"Sacco Code")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("ED Cod e";"ED Code")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter("Phone No.2")
        {
            field("Phone No. 2"; Rec."Phone No. 2")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Address 2"; "Post Code")
        moveafter("Ship-to Address 2"; "Ship-to Post Code")
        addafter("shipping")
        {
            group(statutory)
            {
                Caption = 'Statutory Bodies';
                field("KRA PIN"; Rec."KRA PIN")
                {

                }
                field(NHIF; Rec.NHIF)
                {

                }
                field(NSSF; Rec.NSSF)
                {

                }
                field(HELB; Rec.HELB)
                {

                }
            }
        }
    }
    actions
    {
        modify("Responsibility Centers")
        {

            //Unsupported feature: Property Modification (Level) on ""Responsibility Centers"(Action 70)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Centers"(Action 70)".

        modify("Report Layouts")
        {
            Visible = false;
        }
        modify("Application Settings")
        {
            Visible = false;
        }
        modify(Setup)
        {
            Visible = false;
        }
        modify("General Ledger Setup")
        {
            Visible = false;
        }
        modify("Sales & Receivables Setup")
        {
            Visible = false;
        }
        modify("Purchases & Payables Setup")
        {
            Visible = false;
        }
        modify("Inventory Setup")
        {
            Visible = false;
        }
        modify("Fixed Assets Setup")
        {
            Visible = false;
        }
        modify("Human Resources Setup")
        {
            Visible = false;
        }
        modify("Jobs Setup")
        {
            Visible = false;
        }
        modify("No. Series")
        {
            Visible = false;
        }
        modify("System Settings")
        {
            Visible = false;
        }
        modify(Users)
        {
            Visible = false;
        }
        modify("Permission Sets")
        {
            Visible = false;
        }
        // modify("SMTP Mail Setup")
        // {
        //     Visible = false;
        // }
        modify(Currencies)
        {
            Visible = false;
        }
        modify(Action27)
        {
            Visible = false;
        }
        modify("Regional Settings")
        {
            Visible = false;
        }
        modify("Countries/Regions")
        {
            Visible = false;
        }
        modify("Post Codes")
        {
            Visible = false;
        }
        modify("Online Map Setup")
        {
            Visible = false;
        }
        modify(Languages)
        {
            Visible = false;
        }
        modify(Codes)
        {
            Visible = false;
        }
        modify("Source Codes")
        {
            Visible = false;
        }
        modify("Reason Codes")
        {
            Visible = false;
        }
        addfirst(Navigation)
        {
            group("&Company")
            {
                Caption = '&Company';
                Image = Company;
            }
        }

        // addfirst("Responsibility Center")
        // {
        //     separator(Action91)
        //     {
        //     }
        //     action("Online Map")
        //     {
        //         ApplicationArea = Basic;
        //         Caption = 'Online Map';
        //         Image = Map;

        //         trigger OnAction()
        //         begin
        //             Rec.DisplayMap;
        //         end;
        //     }
        // }
    }


    var
        MapMgt: Codeunit "Online Map Management";

    var

        MapPointVisible: Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetShowMandatoryConditions;
    IsSaaS := PermissionManager.SoftwareAsAService AND NOT ApplicationAreaMgmtFacade.IsInvoicingOnlyEnabled;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    MapPointVisible := TRUE;
    SetShowMandatoryConditions;
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
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    END;

    CountyVisible := FormatAddress.UseCounty("Country/Region Code");

    ApplicationAreaMgmtFacade.GetExperienceTierCurrentCompany(Experience);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    IF NOT MapMgt.TestSetup THEN
      MapPointVisible := FALSE;
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
