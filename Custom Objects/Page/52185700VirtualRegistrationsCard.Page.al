page 52185700 "Virtual Registrations Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Virtual Registrations";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("Virtual Registrations Card")
            {
                Caption = 'General';
                field("ID/Passport"; Rec."ID/Passport")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Msisdn; Rec.Msisdn)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full Names"; Rec."Full Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mpesa Names"; Rec."Mpesa Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IPRS Date Of Birth"; Rec."IPRS Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(MyPicture; Rec.MyPicture)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
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
            action("Send To Member Application")
            {
                ApplicationArea = Basic, Suite;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //VirtualApplication(Rec);

                    /*"G-FedhApp"(Rec);
                    "G-FedhAppDetails"(Rec);*/

                end;
            }
            action(Picture)
            {
                ApplicationArea = Basic, Suite;
                Image = Picture;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Loans List";
            }
        }
    }

    var
        VirtualRegistrations: Record "Delegate Groups Application";
        Grower: Record "Savings Account Application";
        "G-Fedha": Record "HR Job Requirements";
        "G-FedhaDetails": Record "HR Succession Job Rotation";

    local procedure VirtualApplication(VirtualRegistrations: Record "Delegate Groups Application")
    var
        MemberApplication: Record "Member Application";
    begin

        /*MemberApplication."No.":=VirtualRegistrations."Grower No";
        MemberApplication."ID No.":=VirtualRegistrations."ID/Passport";
        MemberApplication."Phone No.":=VirtualRegistrations.Msisdn;
        MemberApplication.Name:=VirtualRegistrations."Mpesa Names";
        
        CASE VirtualRegistrations.Gender OF
          VirtualRegistrations.Gender::"2":
          MemberApplication.Gender:=MemberApplication.Gender::Female;
        
          VirtualRegistrations.Gender::Female:
          MemberApplication.Gender:=MemberApplication.Gender::Male
          END;
        
        MemberApplication."Date of Birth":=VirtualRegistrations."Ussd Date Of Birth";
        MemberApplication."Date of Birth":=VirtualRegistrations."IPRS Date Of Birth";
        MemberApplication."Employer Code":=VirtualRegistrations.Occupation;
        CASE VirtualRegistrations."Marital Status" OF
        
              VirtualRegistrations."Marital Status":
              MemberApplication."Marital Status":=MemberApplication."Marital Status"::Devorced;
        
              VirtualRegistrations."Marital Status"::Married:
              MemberApplication."Marital Status":=MemberApplication."Marital Status"::Married;
        
              VirtualRegistrations."Marital Status"::Single:
              MemberApplication."Marital Status":=MemberApplication."Marital Status"::Single;
        
              VirtualRegistrations."Marital Status"::Widow:
              MemberApplication."Marital Status":=MemberApplication."Marital Status"::Widower;
        
              VirtualRegistrations."Marital Status"::Widower:
              MemberApplication."Marital Status":=MemberApplication."Marital Status"::Widower
        END;
        
        MemberApplication.Address:=VirtualRegistrations.Address;
        MemberApplication."E-Mail":=VirtualRegistrations.Email;
        MemberApplication."Employer Code":=VirtualRegistrations.Employer;
        MemberApplication."Registration Date":=VirtualRegistrations."Application Date";
        {
        CASE VirtualRegistrations."Application Source" OF
             VirtualRegistrations."Application Source"::App:
             //MemberApplication.Biometric:=MemberApplication.Biometric::"1";
        
             VirtualRegistrations."Application Source"::Agency:
             //MemberApplication.Biometric:=MemberApplication.Biometric::"3";
        
             VirtualRegistrations."Application Source"::USSD:
             //MemberApplication.Biometric:=MemberApplication.Biometric::"2";
        
        END;
        }
        MemberApplication.INSERT(TRUE);
        
        MESSAGE('Record Inserted To Member Application');
        */

    end;

    local procedure ValidateID()
    var
        MemApp: Record "ATM Linking  Statistics";
        Members: Record Customer;
        TextExists: Label 'Member with ID %1 already exists in %2 table';
    begin
        /*MemApp.RESET;
        MemApp.SETRANGE(MemApp."No.","Grower No");
        
        IF MemApp.FINDFIRST THEN
        IF CONFIRM (STRSUBSTNO(TextExists,Rec."Grower No",'G-Fedha Application',FALSE)) =FALSE THEN
        
        EXIT;*/
        /*
        Members.RESET;
        MemApp.SETRANGE(MemApp."No.","Grower No");
        IF Members.FINDFIRST THEN ERROR(STRSUBSTNO(TextExists,Rec."Grower No",'Member Application'));*/

    end;

    local procedure "G-FedhApp"(VirtualApplication: Record "Delegate Groups Application")
    var
        "G-FedhApp": Record "HR Job Requirements";
    begin
        /*
        "G-FedhApp".No:='';
        "G-FedhApp"."Customer ID No":=VirtualApplication."ID/Passport";
        "G-FedhApp"."G-FEDHA Mobile No" :=VirtualApplication.Msisdn;
        "G-FedhApp"."Customer Name":=VirtualApplication."Mpesa Names";
        "G-FedhApp"."Document Date":=VirtualApplication."Application Date";
        
        CASE VirtualApplication."Application Source" OF
        
              VirtualApplication."Application Source"::App:
             "G-FedhApp".Source:="G-FedhApp".Source::App;
        
              VirtualApplication."Application Source"::Agency:
             "G-FedhApp".Source:= "G-FedhApp".Source::Agency;
        
             VirtualApplication."Application Source"::USSD:
            "G-FedhApp".Source:="G-FedhApp".Source::USSD;
        
        END;
        
         "G-FedhApp".INSERT(TRUE);
        
        MESSAGE('Record Inserted To G-Fedha Application');*/

    end;

    local procedure "ValidateG-FedhApp"()
    var
        Texts: Label 'Member with ID %1 already exists in %2 table';
        "G-FedhApp": Record "HR Job Requirements";
    begin
        /*
        "G-FedhApp".RESET;
        "G-FedhApp".SETRANGE("G-FedhApp".No,"Grower No");

       IF  "G-FedhApp".FINDFIRST THEN ERROR(STRSUBSTNO(Texts,"Grower No",'G-Fedha Application'));*/

    end;

    local procedure "G-FedhAppDetails"(VirtualApplication: Record "Delegate Groups Application")
    var
        "G-FedhaDetails": Record "HR Succession Job Rotation";
    begin
        /*
        "G-Fedha".RESET;
        "G-Fedha".SETRANGE("G-Fedha".No,"G-FedhaDetails"."Application no");
        IF "G-Fedha".FIND('-') THEN    begin
         "G-FedhaDetails"."Application no":="G-Fedha".No;
        
        
        "G-FedhaDetails"."Member No":=VirtualRegistrations."Grower No";
        "G-FedhaDetails"."Member name":=VirtualRegistrations.GrowerName;
        "G-FedhaDetails"."Member name":=VirtualRegistrations."Full Names";
        "G-FedhaDetails"."Telephone No":=VirtualRegistrations.Msisdn;
        "G-FedhaDetails".IDNo:=VirtualRegistrations."ID/Passport";
        
        "G-FedhaDetails".INSERT(TRUE);
        end;
        MESSAGE('Record Inserted To G-Fedha application Details');
        */

    end;
}

