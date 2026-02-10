page 52186825 "HR Employee Appointment"
{
    //Caption = 'Employee Qualification Lines';
    PageType = List;
    SourceTable = "HR Employee Qualifications";
    
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
               field(Appointment;Rec.Appointment)
               {

               }
               field(Duties;Rec.Duties)
               {

               }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
              field("Assigned by";Rec."Assigned by")
              {

              }
            }
        }
    }

    
            }
   
