# Data-Analysis-by-Python-and-SQL
# Data Analysis tasks :

1-Python and SQL: Prepare a shell/python script and SQL analytical functions to read and validate the file data of “Configuration_File_Validation_Task_Data.xlsx” to get validate the data correctness Sample issues to be validated:

    Duplicated Configuration Record with the same Tier_Amount_Start Found.
    Duplicated Configuration Record with the same Tier_Amount_end Found.
    Tier_Amount_Start less than or equal to the previous tier Tier_Amount_end.
    Tier_Amount_Start Greater than or Equal to the next tier Tier_Amount_Start.
    Tier_Amount_Start Equal the Tier_Amount_end where Tier_Percentage_Fee>0.
    The Commission is high (Tier_Min_commission>100EGP)
    Tier_Min_commission Amount Greater than Tier_Max_commission Amount.
    Tier_Percentage_Fee>0 or Tier_Fixed_Fee_Amount>0 but tier_max_commission=0

2-Data Analytics Task using SQL: 
All Merchants have daily actions/events in the system to track their balance and record all actions done on their accounts. The merchant is in a red zone when the balance is below the balance <500 EGP, and in a brown zone when his balance is between 500 and 1000. Else will be in a green zone when balance >1000 Use the attached data “Merchants_Actions _Task_Data.xlsx” to get the Merchants zone start time and end time across the whole sample data.

3- It's a dataset for Coviddeath and CovidVac and doing analysis for it by using SQL skills such as Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types and the tasks are:
--looking for Total cases vs total death and know the percentage of it --looking at countries with highest infection cases rate it compare to population -- looking at countries with highest Death count per population -- select the continents with hightest covid death -- select the continents with hightest covid cases --total death vs vaccination vs population --looking at the sum of the new vaccination per day and location --use CTE to take the percentage of the people that are vaccinations from population and replace the null with isnull function to 0. --temporary table for percentage POP vaccination -- make a view to be able to put my analysis in it
