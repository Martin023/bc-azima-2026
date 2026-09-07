page 52186592 "HR Overtime List1"
{
    // CardPageID = "HR Overtime Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Overtime Header";
    SourceTableView = WHERE(Converted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("Staff Name"; Rec."Staff Name")
                {
                }
                field("Total Overtime Hours"; Rec."Total Overtime Hours")
                {
                }
              field(Status;Rec.Status)
              {
                
              }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //SETFILTER(Status,'<>%1',Status::Approved);
    end;
}

