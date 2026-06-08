Page 52185466 "HR Department Targets List"
{
    Caption = 'HR Department Targets List';
    PageType = List;
    SourceTable = "HR Department Targets Header";
    CardPageID = "HR Department Targets Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Target No"; Rec."Target No")
                {
                    ApplicationArea = Basic;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Financial Targeted Score"; Rec."Financial Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field("Financial Achieved Score"; Rec."Financial Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Target Score"; Rec."Customer Target Score")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Achieved Score"; Rec."Customer Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field("Training Target Score"; Rec."Training Target Score")
                {
                    ApplicationArea = Basic;
                }
                field("Training Achieved Score"; Rec."Training Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field("Service Delivery Target Score"; Rec."Service Delivery Target Score")
                {
                    ApplicationArea = Basic;
                }
                field("Service Delivery Achieved"; Rec."Service Delivery Achieved")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}