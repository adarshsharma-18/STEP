class Address:
    def _init_(self,line1,line2,city,state):
        self.line1=line1
        self.line2=line2
        self.city=city
        self.state=state
    
    def Setline1(self,line1):
        self.line1=line1
    def Getline1(self):
        return self.line1
    
    def Setline2(self,line2):
        self.line2=line2
    def Getline2(self):
        return self.line2
    
    def SetCity(self,city):
        self.city=city
    def GetCity(self):
        return self.city
    
    def SetState(self,state):
        self.state=state
    def GetState(self):
        return self.state
    
class Employee:
    def _init_(self,name,address,salary):
        self.name=name
        self.address=address
        self.salary=salary

    def SetName(self,name):
        self.name=name
    def GetName(self):
        return self.name
    
    def setAddress(self,address):
        self.address=address
    def get_Address(self):
        return self.address
    
    def set_salary(self,salary):
        self.salary=salary
    def get_salary(self):
        return self.salary
    
class Manager(Employee):
    def _init_(self,name,address,salary,dept):
        super()._init_(name,address,salary)
        self.dept=dept

    def Setdept(self,dept):
        self.dept=dept
    def Getdept(self):
        return self.dept
    
class Company:

    def _init_(self):
        self.employees=[]


    def add_emp(self,emp):
        self.employees.append(emp)

    def get_employees(self):
        f=Form()
        for emp in self.employees:
            f.getEmpdetails(emp)

class Salary:
    def _init_(self,basic,allowance):
        self.basic=basic
        self.allowance=allowance
    
    def set_basic(self,basic):
        self.basic=basic
    def get_basic(self):
        return self.basic
    
    def set_allowance(self,allowance):
        self.allowance=allowance
    def get_allowance(self):
        return self.allowance

class CalculatorService:
    def _init_(self,company):
        self.company=company

    def calcsal(self,company):
        totalval=0
        for emp in company.employees:
            totalval += (emp.salary.basic + emp.salary.allowance)

        return totalval

class Form:
    
    def getAddress(self,add):
        print(add.Getline1())
        print(add.Getline2())
        print(add.GetCity())
        print(add.GetState())

    def getSalary(self,salary):
        print(salary.get_basic())
        print(salary.get_allowance())
        print(salary.get_basic() + salary.get_allowance())

    def getEmpdetails(self,emp):
        print(emp.name)
        self.getSalary(emp.get_salary())
        self.getAddress(emp.get_Address()) 

    def get_manager_details(self,mgr):
        print(mgr.dept)
        self.getEmpdetails(mgr)
    

add1=Address("","","","")
add1.Setline1("Casa Grande")
add1.Setline2("Adyar")
add1.SetCity("Chennai")
add1.SetState("Tamil Nadu")


add2=Address("","","","")
add2.Setline1("Casa Grande")
add2.Setline2("Marthahali")
add2.SetCity("Banglore")
add2.SetState("Karnataka")

sal1=Salary(0,0)
sal1.set_allowance(500)
sal1.set_basic(5000)

sal2=Salary(0,0)
sal2.set_allowance(100)
sal2.set_basic(200)

mgr1=Manager("",add1,sal1,"")
mgr1.SetName("BOSS")
mgr1.Setdept("CSE")

emp1=Employee("Madhav",add2,sal2)
emp2=Employee("Rohaan",add2,sal2)


c1=Company()
c1.add_emp(mgr1)
c1.add_emp(emp1)
c1.add_emp(emp2)

c1.get_employees()

CalculatorServiceobj=CalculatorService(c1)
print(CalculatorServiceobj.calcsal(c1))


"""f1=Form()
f1.get_manager_details(mgr1)
print()"""