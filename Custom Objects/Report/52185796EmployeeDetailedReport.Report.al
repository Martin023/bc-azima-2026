#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
Report 52185796 "Employee Detailed Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Employee Detailed Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Employee Detailed Report';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "No.", Status, "Department Code", Gender, "Job Title";
            
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyName; CompanyName) { }
            column(BuldingName; BuldingName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyEmail) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy; PrintedBy) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24,2>:<Minutes,2>')) { }

            column(Employee_No; "No.") { }
            column(First_Name; "First Name") { }
            column(Middle_Name; "Middle Name") { }
            column(Last_Name; "Last Name") { }
            column(Full_Name; "Full Name") { }
            column(Gender; Gender) { }
            column(Date_Of_Birth; Format("Date Of Birth", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Age; Age) { }
            column(ID_Number; "ID Number") { }
            column(PIN_Number; "PIN No.") { }
            column(NSSF_No; "NSSF No.") { }
            column(NHIF_No; "NHIF No.") { }
            column(Status; Status) { }
            column(Cellular_Phone_Number; "Cellular Phone Number") { }
            column(E_Mail; "E-Mail") { }
            column(Postal_Address; "Postal Address") { }
            column(City; City) { }
            column(County; County) { }
            column(Job_Title; "Job Title") { }
            column(Job_ID; "Job ID") { }
            column(Department_Code; "Department Code") { }
            column(Responsibility_Center; "Responsibility Center") { }
            column(Date_Of_Join; Format("Date Of Join", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Contract_End_Date; Format("Contract End Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Grade; Grade) { }
            column(Salary_Grade; "Salary Grade") { }
            column(Bank_Name; "Main Bank") { }
            column(Bank_Branch; "Branch Bank") { }
            column(Bank_Account_Number; "Bank Account Number") { }
            column(Marital_Status; "Marital Status") { }
            column(Ethnic_Origin; "Ethnic Origin") { }
            column(Religion; Religion) { }
            column(Supervisor_Code; "Supervisor Code") { }
            column(Supervisor_Name; "Supervisor Name") { }
            column(Employee_Group; "Employee Group") { }
            column(Terms_Of_Service; "Contract Type") { }
            column(Employee_Picture; Picture) { }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                CompanyName := CompanyInfo.Name;
                BuldingName := CompanyInfo."Building Name";
                CompanyAddress := CompanyInfo.Address + ' -Post Code: ' + CompanyInfo."Post Code" + ' -City:' + CompanyInfo.City + ' Region: ' + CompanyInfo."Country/Region Code";
                CompanyTelephone := CompanyInfo."Phone No." + ',' + CompanyInfo."Phone No. 2";
                CompanyEmail := CompanyInfo."E-Mail";
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        PrintingDate := Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
        PrintingTime := Format(Time, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
        PrintedBy := UserId;
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        CompanyName: Text;
        BuldingName: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;
}