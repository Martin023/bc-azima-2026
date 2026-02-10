#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 52186448 "DO Payment Connection Setup"
{
    Caption = 'Microsoft Dynamics ERP Payment Services Setup';
    Permissions = TableData "DO Payment Connection Details" = rd;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; Active; Boolean)
        {
            Caption = 'Active';

            trigger OnValidate()
            var
                DOPaymentConnectionDetails: Record "DO Payment Connection Details";
            begin
                if Active then begin
                    if not DOPaymentConnectionDetails.Get then
                        Error(Text001);
                    DOPaymentConnectionDetails.CalcFields(UserName);
                    DOPaymentConnectionDetails.CalcFields(Password);
                    if (not DOPaymentConnectionDetails.UserName.Hasvalue) or (not DOPaymentConnectionDetails.Password.Hasvalue) then
                        Error(Text001);
                end;
            end;
        }
        field(4; "Run in Test Mode"; Boolean)
        {
            Caption = 'Run in Test Mode';
        }
        field(5; "Service ID"; Guid)
        {
            Caption = 'Service ID';

            trigger OnLookup()
            var
                DOPaymentIntegrationMgt: Codeunit "Purch. Post Invoice Events";
            begin
                //DOPaymentIntegrationMgt.SelectServiceId("Service ID");
            end;
        }
        field(6; Environment; Text[10])
        {
            Caption = 'Environment';
        }
        field(8; OrganizationId; Text[40])
        {
            Caption = 'OrganizationId';
        }
        field(9; ServiceGroupId; Text[40])
        {
            Caption = 'ServiceGroupId';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        DOPaymentConnectionDetails: Record "DO Payment Connection Details";
    begin
        DOPaymentConnectionDetails.DeleteAll;
    end;

    var
        Text001: label 'You must complete the sign-up process and associate your Microsoft Dynamics ERP Services account with Microsoft Dynamics NAV before you can enable this feature.';
        Text004: label 'http://go.microsoft.com/fwlink/?LinkId=106549&ServiceID=';


    procedure SignUp()
    var
        DOPaymentIntegrationMgt: Codeunit "Purch. Post Invoice Events";
    begin
        //DOPaymentIntegrationMgt.ServiceBoarding;
    end;


    procedure ManageAccount()
    begin
        Get;
        Hyperlink(Text004 + DelChr(DelChr(Format("Service ID"), '=', '{'), '=', '}'));
    end;


    procedure CreateDefaultSetup()
    begin
        if not Get then begin
            Init;
            Environment := 'PROD';
            Insert;
        end;
    end;


    procedure Disassociate()
    var
        DOPaymentIntegrationMgt: Codeunit "Purch. Post Invoice Events";
    begin
        // if Get then
        //   //DOPaymentIntegrationMgt.Disassociate
        // else
        //   Error(Text001);
    end;
}
