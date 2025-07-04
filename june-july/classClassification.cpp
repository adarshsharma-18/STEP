#include <iostream>
#include <vector>
#include <string>
using namespace std;

// Address class
class Address {
private:
    string line1, line2, city, pincode;

public:
    Address() = default;
    Address(const string& l1, const string& l2, const string& c, const string& pin)
        : line1(l1), line2(l2), city(c), pincode(pin) {}

    string getLine1() const { return line1; }
    string getLine2() const { return line2; }
    string getCity() const { return city; }
    string getPincode() const { return pincode; }

    void setLine1(const string& l1) { line1 = l1; }
    void setLine2(const string& l2) { line2 = l2; }
    void setCity(const string& c) { city = c; }
    void setPincode(const string& pin) { pincode = pin; }
};

// Salary class
class Salary {
private:
    double basic = 0.0;
    double allowance = 0.0;

public:
    Salary() = default;
    Salary(double b, double a) : basic(b), allowance(a) {}

    double getBasic() const { return basic; }
    double getAllowance() const { return allowance; }

    void setBasic(double b) { basic = b; }
    void setAllowance(double a) { allowance = a; }
};

// Employee class
class Employee {
private:
    string name;
    Address address;
    Salary salary;

public:
    Employee() = default;
    Employee(const string& n, const Address& a, const Salary& s)
        : name(n), address(a), salary(s) {}

    string getName() const { return name; }
    Address getAddress() const { return address; }
    Salary getSalary() const { return salary; }

    void setName(const string& n) { name = n; }
    void setAddress(const Address& a) { address = a; }
    void setSalary(const Salary& s) { salary = s; }
    string getType() const { return "Employee"; }
};

// Manager class (inherits Employee)
class Manager : public Employee {
private:
    string department;

public:
    Manager() = default;
    Manager(const string& n, const Address& a, const Salary& s, const string& d)
        : Employee(n, a, s), department(d) {}

    string getDept() const { return department; }
    void setDept(const string& d) { department = d; }
    string getType() const { return "Manager"; }
};

// Form class (handles display logic)
class Form {
public:
    void display(const Address& addr) const {
        cout << "Address Line1: " << addr.getLine1() << '\n';
        cout << "Address Line2: " << addr.getLine2() << '\n';
        cout << "City: " << addr.getCity() << '\n';
        cout << "Pincode: " << addr.getPincode() << '\n';
    }

    void display(const Salary& sal) const {
        cout << "Basic: " << sal.getBasic() << '\n';
        cout << "Allowance: " << sal.getAllowance() << '\n';
    }

    void display(const Employee& emp) const {
        cout << "Employee Name: " << emp.getName() << '\n';
        display(emp.getAddress());
        cout << "Total Salary: " << emp.getSalary().getBasic() + emp.getSalary().getAllowance() << '\n';
    }

    void display(const Manager& mgr) const {
        cout << "Department: " << mgr.getDept() << '\n';
        display(static_cast<const Employee&>(mgr));
    }

    void display(const vector<Employee>& employees) const {
        for (const auto& emp : employees) {
            display(emp);
        }
    }
};

// Company class
class Company {
private:
    vector<Employee> employees;

public:
    void add(const Employee& emp) {
        employees.push_back(emp);
    }

    const vector<Employee>& getEmployees() const {
        return employees;
    }
    int getManagerCount(){
        int count=0;
        for (const auto& e : employees) {
            if (e.getType() == "Manager") {
                count++;
            }
        }
        return count;
    }

};

// CalculatorService class
class CalculatorService {
public:
    double getTotalSalary(const Company& company) const {
        double total = 0.0;
        for (const auto& emp : company.getEmployees()) {
            total += emp.getSalary().getBasic() + emp.getSalary().getAllowance();
        }
        return total;
    }
};

// Main function
int main() {
    
    Form form;
    
    Address address1("SRM", "Tech Park 2", "Chennai", "603203");
    Address address2("Anna Nagar", "Block A", "Chennai", "600040");
    Address address3("MG Road", "Suite 101", "Bangalore", "560001");
    Address address4("Sector 15", "Near Metro", "Delhi", "110075");
    Address address5("Baner", "Opp. IT Park", "Pune", "411045");
    Address address6("Salt Lake", "Tower 3", "Kolkata", "700091");
    Address address7("Gachibowli", "Info City", "Hyderabad", "500032");
    Address address8("Sector 62", "Noida Campus", "Noida", "201301");
    Address address9("Vyttila", "Phase II", "Kochi", "682019");
    Address address10("Thillai Nagar", "Block C", "Tiruchirapalli", "620018");

    Salary sal1(25000, 48000);
    Salary sal2(30000, 52000);
    Salary sal3(28000, 50000);
    Salary sal4(32000, 56000);
    Salary sal5(27000, 49000);
    Salary sal6(35000, 60000);
    Salary sal7(26000, 47000);
    Salary sal8(33000, 58000);
    Salary sal9(31000, 54000);
    Salary sal10(29000, 51000);

    
    Employee emp1("Sarath", address1, sal1);
    Employee emp2("Ravi", address2, sal2);
    Employee emp3("Anita", address3, sal3);
    Employee emp4("Vikram", address4, sal4);
    Employee emp5("Meena", address5, sal5);
    Employee emp6("Suresh", address6, sal6);
    Employee emp7("Priya", address7, sal7);
    
    Manager mgr1("Karthik", address8, sal8, "CSE");
    Manager mgr2("Divya", address9, sal9, "Software");
    Manager mgr3("Arun", address10, sal10, "ChatGPT");

    
    Company comp;
    comp.add(emp1);
    comp.add(emp2);
    comp.add(emp3);
    comp.add(emp4);
    comp.add(emp5);
    comp.add(emp6);
    comp.add(emp7);
    comp.add(mgr1);
    comp.add(mgr2);
    comp.add(mgr3);
    
    
    vector<Employee> vec = comp.getEmployees();
    form.display(vec);
    
    CalculatorService calService;
    cout <<"Total Salary : " << calService.getTotalSalary(comp) << endl;
    int countmanager = comp.getManagerCount();
    cout<< "number of classes:"<< countmanager <<endl;
    return 0;
}