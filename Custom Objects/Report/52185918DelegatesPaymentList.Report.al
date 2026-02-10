#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185918 "Delegates Payment  List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Delegates Payment  List.rdl';

    dataset
    {
        //dataitem(52186067;52186067)
        dataitem("Delegates Payment"; "Delegates Payment")
        {
            RequestFilterFields = "Code", "Electoral Zone", "Global Dimension 1 Code";
            column(ReportForNavId_10; 10)
            {
            }
            column(Snos; Sno)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(CompanyInfo__Address_2_; Company."Address 2")
            {
            }
            column(CompanyInfo_Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Code_DelegatesPayment; "Delegates Payment".Code)
            {
            }

            column(ElectoralZone_DelegatesPayment; "Delegates Payment"."Electoral Zone")
            {
            }
            column(ElectoralZoneName_DelegatesPayment; "Delegates Payment"."Electoral Zone Name")
            {
            }
            column(GlobalDimension1Code_DelegatesPayment; "Delegates Payment"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_DelegatesPayment; "Delegates Payment"."Global Dimension 2 Code")
            {
            }
            column(CreatedBy_DelegatesPayment; "Delegates Payment"."Created By")
            {
            }
            column(CreationDate_DelegatesPayment; "Delegates Payment"."Creation Date")
            {
            }
            column(County_DelegatesPayment; "Delegates Payment".County)
            {
            }
            column(SubCounty_DelegatesPayment; "Delegates Payment"."Sub-County")
            {
            }
            column(CountyName_DelegatesPayment; "Delegates Payment"."County Name")
            {
            }
            column(SubCountyName_DelegatesPayment; "Delegates Payment"."Sub-County Name")
            {
            }
            column(Status_DelegatesPayment; "Delegates Payment".Status)
            {
            }

            column(Posted_DelegatesPayment; "Delegates Payment".Posted)
            {
            }
            column(DatePosted_DelegatesPayment; "Delegates Payment"."Date Posted")
            {
            }
            column(PostedBy_DelegatesPayment; "Delegates Payment"."Posted By")
            {
            }

            column(TotalPayment_DelegatesPayment; "Delegates Payment"."Total Payment")
            {
            }
            column(TransactionType_DelegatesPayment; "Delegates Payment"."Transaction Type")
            {
            }

            dataitem("Delegate Payment Line"; "Delegate Payment Line")
            {
                DataItemLink = Code = field(Code);
                column(ReportForNavId_1; 1)
                {
                }
                column(Sno; Sno)
                {
                }
                column(Code_DelegatePaymentLine; "Delegate Payment Line".Code)
                {
                }
                column(DelegateMNO_DelegatePaymentLine; "Delegate Payment Line"."Delegate MNO.")
                {
                }
                column(DelegateName_DelegatePaymentLine; "Delegate Payment Line"."Delegate Name")
                {
                }
                column(Position_DelegatePaymentLine; "Delegate Payment Line".Position)
                {
                }
                column(AmountPayable_DelegatePaymentLine; "Delegate Payment Line"."Amount Payable")
                {
                }

                column(ElectoralZone_DelegatePaymentLine; "Delegate Payment Line"."Electoral Zone")
                {
                }
                column(ElectoralZoneName_DelegatePaymentLine; "Delegate Payment Line"."Electoral Zone Name")
                {
                }


                trigger OnAfterGetRecord()
                begin
                    Sno += 1;

                end;

                trigger OnPreDataItem()
                begin
                    if Company.Get() then
                        Company.CalcFields(Company.Picture);
                    GenSetUp.Get();
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Company: Record "Company Information";
        GenSetUp: Record "General Set-Up";
        Sno: Integer;
        Retited: Text;
}
