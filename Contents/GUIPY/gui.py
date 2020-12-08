import tkinter as tk 
from tkinter import * 
import mysql.connector  


cursor = None # This executes scripts
db = None 
   
def logintodb(user, passw): 
    global db
    db = mysql.connector.connect(host ="localhost", 
                                 user = user, 
                                 password = passw, 
                                 db ="Stock_Exchange") 
    global cursor 
    cursor = db.cursor()

def runQuery(query, table):
    # A Table in the database       
    try: 
        cursor.execute(query) 
        print("Query Excecuted successfully") 
    except: 
        db.rollback() 
        print("Error occured")
    finally:
        # Update text
        cursor.execute(f"select * from {tableToName[table]};") 
        myresult = cursor.fetchall() 
        s = []
        for t in myresult:
            s.append(" ".join([str(tt) for tt in t]))
        texts[table].set("\n".join(s))
        labels[table].pack()

def runQueryQ(query, i):
    try: 
        print("Query Excecuted successfully") 
        cursor.execute(query) 
        myresult = cursor.fetchall() 
        s = []
        for t in myresult:
            s.append(" ".join([str(tt) for tt in t]))
        textsQ[i-1].set("\n".join(s))
        labelsQ[i-1].pack()
    except: 
        db.rollback() 
        print("Error occured")

def raiseTk(frame):
    frame.tkraise()

def getterToDB(qformat, getters, table):
    getters = tuple(g.get() for g in getters)
    qformat = qformat.format(*getters)
    runQuery(qformat, table)
   
# DB Setup
with open("dblogin.txt", "r") as file:
    name = file.readline()
    password = file.readline()
logintodb(name, password)

# Setup
root = tk.Tk() 
w = 1600
h = 900
root.geometry(f"{w}x{h}") 
root.title("Stock Market Database") 
canvas = Canvas(root, bg ="blue", height = 250, width = 300) 
lblfrstrow = tk.Label(root, text ="Stock Market Database") 
lblfrstrow.place(x = w/2, y = h/10) 


tables = ["mark", "inv", "bank" , "stock" , "company" , "ceo" , "secures" , "owns"]
names = ["Stock_Market", "Investor", "Bank" , "Stock" , "Company" , "CEO" , "Secures" , "Owns"]
tableToName = {t:n for t, n in zip(tables, names)}
tableToIndex= {t:i for t, i in zip(tables, range(10))}
attributeList = [["Market_Name", "Currency", "Market_Cap_in_trillion", "Number_Of_Stock_Symbols"],
                ["IBAN_number", "National_ID", "Sex", "NetWorth", "First_Name", "Middle_Name", "Last_Name"],
                ["Commercial_Registration_Number","Name","Number_Of_Branches"],
                ["Stock_Symbol" , "Number_Of_Public_Stocks_in_thousand" , "Stock_Price" , "Market_Name" , "Commercial_Registration_Number"],
                ["Commercial_Registration_Number" , "Number_Of_Directors" , "Company_Equity_in_thousand" , "Company_Name"],
                ["Name" , "Sex" , "Age" , "Commercial_Registration_Number"],
                ["Stock_Symbol" , "IBAN_number" , "Commercial_Registration_Number"],
                ["Stock_Symbol" , "IBAN_number" , "Number_Of_Shares"]]

primary = [["Market_Name"],
            ["IBAN_number"],
            ["Commercial_Registration_Number"],
            ["Stock_Symbol"],
            ["Commercial_Registration_Number" ],
            ["Name", "Commercial_Registration_Number"],
            ["Stock_Symbol" , "IBAN_number" , "Commercial_Registration_Number"],
            ["Stock_Symbol" , "IBAN_number"]]

commands = {}
texts = {}
labels = {}
for table in tables:
    commands[table] = {}
    texts[table] = StringVar()
#Add Comaands
commands["mark"]["insert"] = """insert into Stock_Market(Market_Name,Currency,Market_Cap_in_trillion,Number_Of_Stock_Symbols) values ("{}", "{}",  {},  {});"""
commands["inv"]["insert"] = """insert into Investor(IBAN_number, National_ID, Sex, NetWorth, First_Name, Middle_Name, Last_Name) values ('{}','{}','{}',{},'{}','{}','{}');"""
commands["bank"]["insert"] = """insert into Bank(Commercial_Registration_Number, Name, Number_Of_Branches) values ('{}','{}', {});"""
commands["stock"]["insert"] = """insert into Stock(Stock_Symbol, Number_Of_Public_Stocks_in_thousand, Stock_Price, Market_Name, Commercial_Registration_Number) values ('{}','{}', {});"""
commands["company"]["insert"] = """insert into Company(Commercial_Registration_Number,Number_Of_Directors,Company_Equity_in_thousand,Company_Name) values ('{}','{}', {});"""
commands["ceo"]["insert"] = """insert into CEO(Name,Sex,Age,Commercial_Registration_Number) values ('{}','{}', {});"""
commands["secures"]["insert"] = """insert into Secures(Stock_Symbol,IBAN_number,Commercial_Registration_Number)  values ('{}','{}', {});"""
commands["owns"]["insert"] = """insert into Owns(Stock_Symbol,IBAN_number,Number_Of_Shares) values ('{}','{}', {});"""
#Delete commands
commands["mark"]["delete"] = """delete from Stock_Market where Market_Name='{}';"""
commands["inv"]["delete"] = """delete from Investor where IBAN_number='{}';"""
commands["bank"]["delete"] = """delete from Bank where Commercial_Registration_Number='{}';"""
commands["stock"]["delete"] = """delete from Stock where Stock_Symbol='{}';"""
commands["company"]["delete"] = """delete from Company where Commercial_Registration_Number='{}';"""
commands["ceo"]["delete"] = """delete from CEO where Name='{}' AND Commercial_Registration_Number='{}';"""
commands["secures"]["delete"] = """delete from Secures where Stock_Symbol='{}' AND IBAN_number='{}' AND Commercial_Registration_Number='{}';"""
commands["owns"]["delete"] = """delete from Owns where Stock_Symbol='{}' AND IBAN_number='{}';"""


# Setup Add and Delete
frames = {}
fields = {}
fieldsDelete = {}
for attributes, name, table in zip(attributeList, names, tables):
    frames[table] = (LabelFrame(root, text=name, padx=25, pady=25, bg="white"))
    frames[table].place(x=w/10, y=h/7, width=w/1.2, height=h/1.3)

    # Adding
    fields[table] = {}
    for name in attributes:
        fields[table][name] = Entry(frames[table], width=100)
        fields[table][name].insert(0, name)
        fields[table][name].pack()

    add = lambda q=commands[table]["insert"], vals=fields[table].values(), t=table: getterToDB(q, vals, t)
    Button(frames[table], text="Add", command=add).pack()

    # Deleting 
    fieldsDelete[table] = {}
    for name in attributes:
        if name in primary[tableToIndex[table]]:
            fieldsDelete[table][name] = Entry(frames[table], width=100)
            fieldsDelete[table][name].insert(0, name)
            fieldsDelete[table][name].pack()

    delete = lambda q=commands[table]["delete"], vals=fieldsDelete[table].values(), t=table: getterToDB(q, vals, t)
    Button(frames[table], text="Delete", command=delete).pack()

    # Text
    labels[table] = Label(frames[table], textvariable=texts[table])

coms = [
    "select * from Investor where NetWorth > 420000000;",
    "select * from Stock where Number_Of_Public_Stocks_in_thousand < 2000;",
    'select Last_Name from Investor where IBAN_number = "NL12RAB0813971873";',
    """select Investor.* from Secures natural join Investor where Secures.Commercial_Registration_Number=1110001116 group by Investor.IBAN_number;""",
    'select Investor.* from Owns natural join Investor where Owns.Stock_Symbol="4001";',
    'select Company.* from Company natural join Stock where Stock.Stock_Price > 103.5;',
    'select Stock.* from Stock natural join Company where Number_Of_Directors >= 3;,',
    'select Bank.* from Owns natural join Secures natural join Bank where Stock_Symbol="4161";',
    'select CEO.* from CEO natural join Company natural join Stock where Stock_Price < 200;',
    'select CEO.* from CEO natural join Company natural join Stock natural join Investor where NetWorth > 50000 and CEO.Sex="M" group by Name;',
]
def defaultQueries(num):
    runQueryQ(coms[num-1], num)
    
# Queries 10
framesQ = {}
buttonsQ = {}
textsQ = []
labelsQ = []
for i in range(10):
    framesQ[i] = (LabelFrame(root, text=f"Query {i+1}", padx=25, pady=25, bg="white"))
    framesQ[i].place(x=w/10, y=h/7, width=w/1.2, height=h/1.3)
    Button(framesQ[i], text="Show", command=lambda i=i:defaultQueries(i+1)).pack()
    textsQ.append(StringVar())
    labelsQ.append(Label(framesQ[i], textvariable=textsQ[i]))

    s = StringVar()
    s.set(coms[i])
    Label(framesQ[i], textvariable=s).pack()



menubar = Menu(root)
filemenu = Menu(menubar, tearoff=0)
queries = Menu(menubar, tearoff=0)

for name, table in zip(names, tables):
    filemenu.add_command(label=name, command=lambda table=table: frames[table].tkraise())

for i in range(10):
    queries.add_command(label=f"Query {i+1}", command=lambda i=i: framesQ[i].tkraise())    

filemenu.add_separator()
filemenu.add_command(label="Exit", command=root.quit)
menubar.add_cascade(label="Tables", menu=filemenu)
menubar.add_cascade(label="Queries", menu=queries)
root.config(menu=menubar)

frames["mark"].tkraise()
root.mainloop() 