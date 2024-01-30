import pandas  as pd
import numpy as np
from sqlalchemy import create_engine
# read the file Configuration_File_Validation_Task_Data.xlsx
file = 'D:\Configuration_File_Validation_Task_Data.xlsx'
#reading the file and choose the sheet
df = pd.read_excel(file,sheet_name='Sheet')

#preprocessing the dataset
df.info()
print(df)

print(df['payment_channel'].unique())
print(df['payment_channel'].nunique())
print(df['payment_channel'].value_counts())

print(df['tier_amount_start'].unique())
print(df['tier_amount_start'].nunique())
print(df['tier_amount_start'].value_counts())

print(df['tier_amount_end'].unique())
print(df['tier_amount_end'].nunique())
print(df['tier_amount_end'].value_counts())

print(df['tier_fixed_fee_amount'].unique())
print(df['tier_fixed_fee_amount'].nunique())
print(df['tier_fixed_fee_amount'].value_counts())

print(df['tier_min_commission'].unique())
print(df['tier_min_commission'].nunique())
print(df['tier_min_commission'].value_counts())

print(df['tier_max_commission'].unique())
print(df['tier_max_commission'].nunique())
print(df['tier_max_commission'].value_counts())

print(df['tier_percentage_fee'].unique())
print(df['tier_percentage_fee'].nunique())
print(df['tier_percentage_fee'].value_counts())



print(df.isna().sum())
print(df.duplicated().sum())

#make an output file to put the results
outputfile='output.xlsx'

#open an engine to be able to run queries
engine=create_engine('sqlite://',echo=False)

#make a temporary db to can use the queries
df.to_sql('config',engine,if_exists='replace',index=False)

# the queries that anser the questions
#-----------------------------------------------------------

query1 = engine.execute("select distinct * from config group by Tier_Amount_Start ")
query2=engine.execute("select distinct * from config group by Tier_Amount_end")
query3=engine.execute("select * from config where Tier_Amount_Start <=(select LAG(Tier_Amount_end) over (order by Tier_Amount_end) as pervious_Tier_Amount_end from config)")
query4=engine.execute("select * from config where Tier_Amount_Start >=(select LAG(Tier_Amount_end) over (order by Tier_Amount_end) as pervious_Tier_Amount_end from config)")
query5=engine.execute("select * from config where Tier_Amount_Start=Tier_Amount_end and Tier_Percentage_Fee>0")
query6=engine.execute("select * from config where Tier_Min_commission>100")
query7=engine.execute("select * from config where Tier_Min_commission>Tier_Max_commission")
query8=engine.execute("select * from config where (Tier_Percentage_Fee>0 || Tier_Fixed_Fee_Amount>0) and tier_max_commission=0")

#-------------------------------------------------------------
# to put the queries into the running process
#--------------------------------------------------------------
final = pd.DataFrame(query1,columns=df.columns)
final = pd.DataFrame(query2,columns=df.columns)
final = pd.DataFrame(query3,columns=df.columns)
final = pd.DataFrame(query4,columns=df.columns)
final = pd.DataFrame(query5,columns=df.columns)
final = pd.DataFrame(query6,columns=df.columns)
final = pd.DataFrame(query7,columns=df.columns)
final = pd.DataFrame(query8,columns=df.columns)
#---------------------------------------------------------------
#puting the result to the excel file

final.to_excel(outputfile,index=False)


















