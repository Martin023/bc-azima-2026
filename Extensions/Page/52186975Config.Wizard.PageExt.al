#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186975 pageextension52186975 extends "Config. Wizard" 
{
    Caption = 'Welcome to RapidStart Services for Microsoft Dynamics NAV';
    layout
    {
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
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify(City)
        {
            ApplicationArea = Basic;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Registration No.")
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
        modify(PackageFileNameRtc)
        {

            //Unsupported feature: Property Modification (Name) on "PackageFileNameRtc(Control 4)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "PackageFileNameRtc(Control 4)".

        }
        modify("Package Code")
        {
            ApplicationArea = Basic;
        }
        modify("Package Name")
        {
            ApplicationArea = Basic;
        }
        modify("Choose Apply Package action to load the data from the configuration to Business Central tables.")
        {
            Caption = 'Choose Apply Package action to load the data from the configuration to Microsoft Dynamics NAV tables.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Choose Apply Package action to load the data from the configuration to Business Central tables."(Control 19)".

        }
        modify("Choose Configuration Worksheet if you want to edit and modify applied data.")
        {
            ApplicationArea = Basic;
        }
        modify(ProfileText)
        {
            ApplicationArea = Basic;
        }
        // modify("Your Profile Code")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Your Profile Code"(Control 17)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Your Profile Code"(Control 17)".

        //     ShowCaption = false;
        // }
        modify(BeforeSetupCloseMessage)
        {

            //Unsupported feature: Property Modification (Name) on "BeforeSetupCloseMessage(Control 3)".

            Caption = 'If you still need to change setup data, do not change the profile. Choose the OK button to close the wizard, and then use the configuration worksheet to continue setting up Microsoft Dynamics NAV.';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Country/Region Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Registration No."(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Industrial Classification"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Picture(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No.2"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 43)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Home Page"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Name"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Branch No."(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Routing No."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Giro No."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SWIFT Code"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IBAN(Control 27)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Package File Name"(Control 4).OnAssistEdit".

        //trigger (Variable: FileMgt)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "PackageFileNameRtc(Control 4).OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ConfigVisible THEN
              ERROR(PackageIsAlreadyAppliedErr);

            "Package File Name" :=
              COPYSTR(
                FileManagement.OpenFileDialog(
                  Text004,'',ConfigXMLExchange.GetFileDialogFilter),1,MAXSTRLEN("Package File Name"));

            IF "Package File Name" <> '' THEN BEGIN
              VALIDATE("Package File Name");
              ApplyVisible := TRUE;
            END ELSE
              ApplyVisible := FALSE;
            PackageFileName := FileManagement.GetFileName("Package File Name");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ConfigVisible THEN
              ERROR(Text005);
            #3..5
                FileMgt.OpenFileDialog(
            #7..13
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "PackageFileNameRtc(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Package Code"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Package Name"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Choose Apply Package action to load the data from the configuration to Business Central tables."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Choose Configuration Worksheet if you want to edit and modify applied data."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfileText(Control 7)".

        modify("Your Profile Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (DrillDown) on ""Your Profile Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Your Profile Code"(Control 17)".


        //Unsupported feature: Property Deletion (Editable) on ""Your Profile Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BeforeSetupCloseMessage(Control 3)".

    }
    actions
    {
        modify("Apply Package")
        {
            ApplicationArea = Basic;
        }
        modify("Configuration Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify(Users)
        {
            ApplicationArea = Basic;
        }
        modify("Users Personalization")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Apply Package"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Configuration Worksheet"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Users(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Users Personalization"(Action 18)".

    }

    var
        FileMgt: Codeunit "File Management";

    var
        Text005: label 'A package has already been selected and applied.';


    //Unsupported feature: Code Modification on "OnClosePage".

    //trigger OnClosePage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SelectDefaultRoleCenter("Your Profile Code","Your Profile App ID","Your Profile Scope");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SelectDefaultRoleCenter("Your Profile Code");
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
        #4..7
          "Package Code" := '';
          MODIFY;
        END;
        YourProfileCode := "Your Profile Code";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        */
    //end;
}
