#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186224 pageextension52186224 extends "Outlook Mail Engine" 
{

    //Unsupported feature: Property Modification (SourceTable) on ""Outlook Mail Engine"(Page 1600)".


    //Unsupported feature: Property Modification (PageType) on ""Outlook Mail Engine"(Page 1600)".

    layout
    {
        modify(Email)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Email(Control 2)".


            //Unsupported feature: Property Modification (Name) on "Email(Control 2)".

        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Document Type"(Control 6)".


            //Unsupported feature: Property Modification (Name) on ""Document Type"(Control 6)".

        }

        //Unsupported feature: Property Deletion (ExtendedDatatype) on "Email(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Email(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 6)".

        modify("Document No.")
        {
            Visible = false;
        }
        moveafter(Group;"Document Type")
        //moveafter("No.";Name)
    }
    actions
    {
        addfirst(Processing)
        {
            action("Create Contact")
            {
                ApplicationArea = Basic;
                Caption = 'Create Contact';
                Promoted = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    Contact.Init;
                    Contact."E-Mail" := TempEmail;
                    //Page.RunModal(Page::"Contact Card",Contact,"E-Mail");
                end;
            }
        }
    }

    var
        Contact: Record Contact;
        Customer: Record Customer;
        Vendor: Record Vendor;
        TempEmail: Text[80];
        TempName: Text;
        NewContactQst: label '%1 does not exist in NAV. Would you like to add them as a contact now?', Comment='%1 = Name of contact';


    //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //begin
        /*
        RedirectContactToCompany("No.");
        */
    //end;


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //var
        //Contact: Record Contact;
    //begin
        /*
        IF TempEmail <> '' THEN
          IF COUNT = 1 THEN BEGIN
            FINDFIRST;
            IF Type = Type::Company THEN
              RedirectContactToCompany("No.")
            ELSE
              RedirectContactToCompany("Company No.");
          END ELSE BEGIN
            Contact.SETFILTER("No.",CreateFilterString);
            PAGE.RUN(PAGE::"Outlook Mail Engine",Contact);
          END;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF OfficeHost.IsAvailable THEN BEGIN
          OfficeHost := OfficeHost.Create;
          OfficeMgt.InitializeHost(OfficeHost,OfficeHost.HostType);
        END;

        GetDetailsFromFilters;
        IF Email = 'donotreply@contoso.com' THEN
          PAGE.RUN(PAGE::"Office Welcome Dlg")
        ELSE
          OfficeMgt.InitializeContext(Rec);

        CurrPage.CLOSE;
        OfficeMgt.CloseEnginePage;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT GetDetailsFromFilters THEN
          EXIT;

        IF COUNT = 0 THEN
          SetupNewContact;
        */
    //end;

    local procedure RedirectContactToCompany(ContactNo: Code[20])
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        MarketingSetup: Record "Marketing Setup";
    begin
        ContactBusinessRelation.SetRange("Contact No.",ContactNo);
        if not ContactBusinessRelation.FindFirst then
          Page.Run(Page::"Contact Card",Rec)
        else begin
          MarketingSetup.Get;
          if ContactBusinessRelation."Business Relation Code" = MarketingSetup."Bus. Rel. Code for Customers" then begin
            Customer.SetRange("No.",ContactBusinessRelation."No.");
            // if Customer.FindFirst then
            //   Page.Run(Page::"Mini Customer Card",Customer);
          end else
            if ContactBusinessRelation."Business Relation Code" = MarketingSetup."Bus. Rel. Code for Vendors" then begin
              Vendor.SetRange("No.",ContactBusinessRelation."No.");
              // if Vendor.FindFirst then
              //   Page.Run(Page::"Mini Vendor Card",Vendor)
            end
        end;
    end;

    local procedure GetDetailsFromFilters(): Boolean
    begin
        // if Rec.GetFilter("E-Mail") <> '' then
        //   TempEmail := Rec.GetRangeMin("E-Mail");

        if TempEmail = '' then
          exit(false);

        TempName := Rec.GetFilter(Rec.Name);
        if (StrLen(TempName) > 3) and (StrPos(TempName,'@*') = 1) then
          TempName := CopyStr(TempName,3,StrLen(TempName) - 3);
        if TempName = '' then
          TempName := TempEmail;

        Clear(Rec);
       // Rec.SetRange("E-Mail",TempEmail);
        exit(true);
    end;

    [TryFunction]
    local procedure SetupNewContact()
    begin
        if Confirm(StrSubstNo(NewContactQst,TempName)) then begin
          Contact.Init;
          Contact."E-Mail" := TempEmail;
          Contact.Name := CopyStr(TempName,1,50);
          Contact.Type := Contact.Type::Person;
          Contact."No." := '';
          Contact."Search Name" := UpperCase(TempName);
          Contact.Insert(true);
          Page.Run(Page::"Contact Card",Contact);
        end else
          CurrPage.Close;
    end;

    local procedure CreateFilterString() FilterString: Text
    begin
        FilterString := '';
        Rec.FindFirst;
        repeat
          // if FilterString = '' then
          //   FilterString := "Company No."
          // else
          //   FilterString := FilterString + '|' + "Company No.";
        until Rec.Next = 0;
    end;

    //Unsupported feature: Property Deletion (SourceTableTemporary).

}
