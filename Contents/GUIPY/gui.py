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

def raiseTk(frame):
    frame.tkraise()

def getterToDB(qformat, getters, table):
    getters = tuple(g.get() for g in getters)
    qformat = qformat.format(*getters)
    runQuery(qformat, table)
   
# DB Setup
name = "root" # FILL ME
password = # FILL ME
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


tables = ["mark", "inv", "bank"]
names = ["Stock_Market", "Investor", "Bank"]
tableToName = {t:n for t, n in zip(tables, names)}
attributeList = [["Market_Name", "Currency", "Market_Cap_in_trillion", "Number_Of_Stock_Symbols"],
                ["IBAN_number", "National_ID", "Sex", "NetWorth", "First_Name", "Middle_Name", "Last_Name"],
                ["Commercial_Registration_Number","Name","Number_Of_Branches"]]

commands = {}
texts = {}
labels = {}
for table in tables:
    commands[table] = {}
    texts[table] = StringVar()
commands["mark"]["insert"] = """insert into Stock_Market(Market_Name,Currency,Market_Cap_in_trillion,Number_Of_Stock_Symbols) values ("{}", "{}",  {},  {});"""
commands["inv"]["insert"] = """insert into Investor(IBAN_number, National_ID, Sex, NetWorth, First_Name, Middle_Name, Last_Name) values ('{}','{}','{}',{},'{}','{}','{}');"""
commands["bank"]["insert"] = """insert into Bank(Commercial_Registration_Number, Name, Number_Of_Branches) values ('{}','{}', {});"""

# Setup Add and Delete
frames = {}
fields = {}
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
    # delete = lambda q=commands[table]["delete"], vals=fields[table].values(), t=table: getterToDB(q, vals, t)
    # Button(frames[table], text="Delete", command=delete).pack()

    # Text
    labels[table] = Label(frames[table], textvariable=texts[table])

    


menubar = Menu(root)
filemenu = Menu(menubar, tearoff=0)

for name, table in zip(names, tables):
    filemenu.add_command(label=name, command=lambda table=table: frames[table].tkraise())

filemenu.add_separator()
filemenu.add_command(label="Exit", command=root.quit)
menubar.add_cascade(label="Tables", menu=filemenu)
root.config(menu=menubar)


root.mainloop() 