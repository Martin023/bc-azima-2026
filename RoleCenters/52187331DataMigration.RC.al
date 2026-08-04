page 52187331 "Data Migration"
{
    Caption = 'Records Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
        }
    }


    actions
    {
        area(Sections)
        {
            group("Group")
            {
                Caption = 'Data loading Ports';
                group("XML Ports")
                {

                    Caption = 'Data migration Ports';
                    action("Chart Of Account Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Chart Of Accounts";
                    }
                    action("Members Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport Member;
                    }

                    action("Savings Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'savings Upload';
                        RunObject = xmlport "Savings Account";
                    }
                    action("Loans Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Loans migration";
                    }
                    action("Collateral & Securities Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Securities register";
                    }
                    action("Guarantors Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport guarantors;
                    }
                    action("Credit accounts Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Creditaccount";
                    }
                    action("Nominee and BBF Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport " Next of Kin";
                    }
                    action("Account Signatories")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Group Account Sig";
                    }

                    action("Standing order Header")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "standing order";
                    }
                    action("Standing order lines")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "standingorderlines";
                    }
                    action("Posted Salary Lines")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport Postedsalary;
                    }
                    action("Fixed Deposit contract")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport FDcontract;
                    }
                    action("HR Employees")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Employee Upload";
                    }
                    action("Employee Earning and Deductions")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport earningsdeductions;
                    }
                    action("Fixed Assets Register Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Fixed Asset";
                    }
                    action("Fixed Assets depbook")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Fixed Asset Dpr Book";
                    }
                    action("PREmployee Transactions Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport PRTrans;
                    }


                    action("General batches")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport Genbatches;
                    }

                    action("Dividend Instruction")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport Dividend;
                    }

                    action("Attachement Header")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Attachement Header";
                    }
                    action("Attachement lines")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Attachement lines";
                    }
                    action("Daily Interest")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Loans Daily Interest";
                    }
                    action("Delegate Officials")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Delegate Officials";
                    }
                    action("Item Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Item Import";
                    }
                    action("Flags and Comment Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Account Flags";
                    }
                    action("Lien Transaction Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "lien Placed";
                    }
                    action("Investment Header Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Investment Header";
                    }
                    action("Investment Lines Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Investment Lines";
                    }
                    action("Journals Import")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport JOURNAL;
                    }
                    action("FA Journals Import")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "FA Journals";
                    }
                    action("Update NOK names")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport " Next of Kinup";
                    }
                    action("Loans Update")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "LoansUp migration";
                    }
                    action("Dividend Progression")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Dividend Progression";
                    }
                    action("Customers")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "CustomerImport";
                    }

                    action("Vendors")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "VendorImport";
                    }

                    action("Banks")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "BankImport";
                    }

                    action("Delegates")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "DelegatesImports";
                    }

                    action("Files")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "FilesTableImport";
                    }

                    action("Company Vehicles")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "CompanyVehiclesImport";
                    }

                    action("Fixed Deposit Interest Buffer")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "FDInterestBUfferImport";
                    }
                    action(AutocreateProducts)
                    {
                        ApplicationArea = All;
                        runobject = report AutocreateProducts;
                        Caption = 'Create Default products';
                    }
                    // action(MpesaManualUpload)
                    // {
                    //     ApplicationArea = All;
                    //     runobject = xmlport "M-PESA Manul Upload";
                    //     Caption = 'M-PESA Manual Upload';
                    // }
                }

            }

        }
    }
}


profile "Data Migration"
{
    Caption = 'Data Migration Role Center';
    RoleCenter = "Data Migration";
    ProfileDescription = 'Data Migration Role Center';
}
