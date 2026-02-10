page 52186399 "DCS Admin"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Home)
            {
                part(Control1; "DCS Product Parameter Matrix")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Parameter List")
            {
                Caption = 'Parameter List';
                Image = "Report";
                RunObject = Page "DCS Parameter List";
            }
            action("DCS Member Transaction")
            {
                RunObject = Page "DCS Member Transaction List";
            }
            action("DCS Loan Summary")
            {
                RunObject = Page "DCS Loan Summary List";
            }
            action("DCS Parameter")
            {
                RunObject = Page "DCS Product Parameter Matrix";
            }
        }
    }
}

