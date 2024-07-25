# Exploring Github Copilot with DE examples

Copilot is an OpenAI Large Language Model (LLM) which is fine tuned by Github to provide Code examples and developer support. Its interesting because Github being the developer friendly website has software development data from developers worldwide and that was used to fintetune Microsoft's LLM to give Github Copilot the wisdom of global software development to make a sort of ChatGPT for developers. As the audience here must have invariably interacted with ChatGPT if not directly with Copilot, we are plunging straight into Copilot without delving on how LLMs work or finetuning of LLMs. 


# Installation

To get started we would need 

1. Visual Studio Code Application
2. Github Copilot - This is a paid extension and will require you to put in pay information
3. Github Copilot Chat - This extension allows us to interact with Copilot like ChatGPT

Github Copilot offers a 30 day trial and after that is priced at 10$/month

# Prompts

With prompts **Context is King**. The more the context user provides, the easier it is for the LLM to get the right type of attention from its memory, allowing it to produce a wellformed in-context output. For more methods on Prompting Refer [link](https://arxiv.org/pdf/2407.12994)

Two ways of using Copilot. 

First is inline VS Code, where you're typing youre code logic in VS Code and it suggests generic syntax, this can be seen as an extention of code-completion or intellisense. 

Second is to chat in the Copilot prompt and that generates logic in response to the context that was input. 

# Mechanics of Prompt

When writing prompts for GitHub Copilot, it's all about being clear and give enough context to guide the AI effectively. Here are the key mechanics for writing effective Copilot prompts:

### Be Specific

Provide detailed and specific instructions to help Copilot generate the desired code. Vague prompts can lead to generic or irrelevant suggestions.

Example:

    Vague: "Write a function."
    Specific: "Write a Python function that takes a list of numbers and returns a list of those numbers squared."

### Define Context

Explain the context in which the code will be used. This helps Copilot understand the purpose and scope of the code.

Example:

    "Write a Python script to parse a CSV file containing sales data and calculate the total sales for each product."

### Provide Examples

Giving examples of inputs and expected outputs can help Copilot understand what you want to achieve.

Example:

```
# Function to square numbers in a list
# Example input: [1, 2, 3, 4]
# Example output: [1, 4, 9, 16]
```

### Refine Prompt

Start with a basic prompt and refine it iteratively based on the initial output you get from Copilot. Adjust the prompt to correct or enhance the code generation.

Example:

    Initial Prompt: "Write a function to load file onto table"
    Refined Prompt: "Write a Python function to load data from a csv file onto a postgres table. 
    The function should take in parameterized values for Database connections and have input argument for specifying CSV file location. 
    Use Pandas and Pscycopg2 to prepare the dataframe and ingest it into Postgres"

Notice majority of prompting is context driven action oriented sentences, the more verbose instruction you give to CoPilot, the better its output. 

### For Data Engineering use cases the context provided should include 

1. Data Formats
2. source and target table formats
3. steps involved for programming logic Like
   
```
# Step 1: Load data from a CSV file into a Dataframe
# Step 2: Check for Null values
# Step 3: Create a new column that adds Col A + Col B and name it total sales
# Step 4: Write the processed dataframe into Postgres DB
```

The reason for placing such importance on formulating Prompts is that LLMs have a large base of parameters to draw from, furthermore Copilot is a **finetuned LLM** and by that what I mean is its trained on the specific task of providing output that are relatable to software development. Context that we provide as input helps Copilot to formulate attention which inturn allows it to draw from its knowledgebase that directly applies to the given input problem. 

# Extensions

Github copilot's functionality can be extended by adding extensions in VS Code. Some popular ones related to Databases are MSSQL extension and Postgres Extention. New VSCode Copilot Extensions can also be created with custom finetuning. Tools like Databricks and Snowflake already have integrated a conversational assistant into their environment and copilot extensions serve a similar purpose of extending to Databases where a native assistant might not be available yet. 

# Action Words

Copilot also has trigger words that invoke specific functionalities such as 

`@workspace` - Ask about your workspace

 `/explain` - Explain how the code in your active editor works

 `/tests` - Generate unit tests for the selected code
 
 `/fix` - Propose a fix for the problems in the selected code
 
 `/new` - Scaffold code for a new workspace
 
 `/newNotebook` - Create a new Jupyter Notebook

`@vscode` - Ask questions about VS Code

 `/search` - Generate query parameters for workspace search

`@terminal` - Ask how to do something in the terminal

 `/explain` - Explain something in the terminal

`@pg` - Let's have some fun with Postgres

 `/schema` - Helps you build out your database schema.

 `/conn` - Change the connection

 `/help` - How to use this extension
 
 `/out` - Set the output format
 
 `/show` - Shows all tables. Or, pass in a table name to see the columns
 
 `/fix` - Fixes the last error encountered

# Exercise 1 - ETL Code generation

To demonstrate Copilot's application in Data Engineering tasks we look at ETL Code generation. Consider the following pipeline where we have Data flowing from Landing, Staging, Dimension and Fact tables which ultimately feed Reporting Views for a ECommerce company. We will look at Customers, Products and Sales.  

```
Prompt 1

I am looking to develop a simple data flow for an ecommerce company that will take data
that is ingested in CSV and will ingest into Postgres Landing Table.
The data flow will go from Landing Table which will be of SCD type 1 to Staging Table
which will be of SCD type 2 to Dimension and Fact Tables.
Please generate data flow example for customers, products and orders

P2
Can you please create the code snippet needed to ingest Data from the CSV files into Postgres Landing tables
using Pandas library

P3
Can you please create the code snippet needed to ingest Data from the CSV files into Postgres Landing tables using Pyspark ?

P4
Can you please create a Reporting View that takes the data from the dimension and fact tables and joins them to
give a full picture of Customer, Product and Orders so that the reporting team can use the view for further analysis ?

P5
Can you please create a 10 row csv with fields input that satisfies the 3 landing tables - Customers
, products and orders so that the pandas code snippet can be used to ingest the csv into corresponding landing tables ?

```

By the above prompts we now have a relatively simple pipeline that loads Ecommerce Data into Postgres Database

![Blank diagram - Page 1 (19)](https://github.com/user-attachments/assets/23cc5adf-c855-468a-bdcc-4e10da466cdc)

# Exercise 2 - Code Refactoring

Since Copilot has the data reposited to it from global software development its not unfair to say that it has seen examples of optimized code written by experianced developers. This has given Copilot the ability to 

1. explain complex code
2. take patterns from prior examples and apply it to a given problem

This can be gainfully applied to refactoring SQL and Python code snippets that may be complex and badly written. Lets look at an example

### SQL

```
P 1
Explain this block of code

P 2
Can you please help refactor the above code snippet

```




```



SELECT c.CustomerID, c.CustFirstName, c.CustLastName
FROM Customers AS c
INNER JOIN
(SELECT DISTINCT Orders.CustomerID
FROM Orders AS o
INNER JOIN Order_Details AS od
ON o.OrderNumber = oc.OrderNumber
INNER JOIN Products AS p
ON p.ProductNumber = od.ProductNumber
WHERE p.ProductName = 'Skateboard') AS OSk
ON c.CustomerID = OSk.CustomerID
INNER JOIN
(SELECT DISTINCT Orders.CustomerID
FROM Orders AS o
INNER JOIN Order_Details AS od
ON o.OrderNumber = od.OrderNumber
INNER JOIN Products AS p
ON p.ProductNumber = od.ProductNumber
WHERE p.ProductName = 'Helmet') AS OHel
ON c.CustomerID = OHel.CustomerID
INNER JOIN
(SELECT DISTINCT Orders.CustomerID
FROM Orders AS o
INNER JOIN Order_Details AS od
ON o.OrderNumber = od.OrderNumber
INNER JOIN Products AS p
ON p.ProductNumber = od.ProductNumber
WHERE p.ProductName = 'Knee Pads') AS OKn
ON c.CustomerID = OKn.CustomerID
INNER JOIN
(SELECT DISTINCT Orders.CustomerID
FROM Orders AS o
INNER JOIN Order_Details AS od
ON o.OrderNumber = od.OrderNumber
INNER JOIN Products AS p
ON p.ProductNumber = od.ProductNumber
WHERE p.ProductName = 'Gloves') AS OGl
ON c.CustomerID = OGl.CustomerID;




SELECT Recipes.RecipeTitle
FROM Recipes
WHERE EXISTS (
SELECT NULL
FROM Ingredients
INNER JOIN Recipe_Ingredients
ON Ingredients.IngredientID =
Recipe_Ingredients.IngredientID
WHERE Ingredients.IngredientName = 'Beef'
AND Recipe_Ingredients.RecipeID = Recipes.RecipeID
) AND EXISTS (
SELECT NULL
FROM Ingredients
INNER JOIN Recipe_Ingredients
ON Ingredients.IngredientID =
Recipe_Ingredients.IngredientID
WHERE Ingredients.IngredientName = 'Garlic'
AND Recipe_Ingredients.RecipeID = Recipes.RecipeID
);





SELECT CustProd.CustomerID, CustProd.CustFirstName,
CustProd.CustLastName, CustProd.ProductNumber,
CustProd.ProductName,
(CASE WHEN OrdDet.OrderCount > 0
THEN 'You purchased this!'
ELSE ' '
END) AS ProductOrdered
FROM
(SELECT c.CustomerID, c.CustFirstName, c.CustLastName,
p.ProductNumber, p.ProductName, p.ProductDescription
FROM Customers AS c, Products AS p) AS CustProd
LEFT JOIN
(SELECT o.CustomerID, od.ProductNumber,
COUNT(*) AS OrderCount
FROM Orders AS o
INNER JOIN Order_Details AS od
ON o.OrderNumber = od.OrderNumber
GROUP BY o.CustomerID, od.ProductNumber) AS OrdDet
ON CustProd.CustomerID = OrdDet.CustomerID
AND CustProd.ProductNumber = OrdDet.ProductNumber
ORDER BY CustProd.CustomerID, CustProd.ProductName;




WITH CustPreferences AS (
SELECT c.CustomerID, c.CustFirstName, c.CustLastName,
MAX((CASE WHEN mp.PreferenceSeq = 1
THEN mp.StyleID
ELSE Null END)) AS FirstPreference,
MAX((CASE WHEN mp.PreferenceSeq = 2
THEN mp.StyleID
ELSE Null END)) AS SecondPreference,
MAX((CASE WHEN mp.PreferenceSeq = 3
THEN mp.StyleID
ELSE Null END)) AS ThirdPreference
FROM Musical_Preferences AS mp
INNER JOIN Customers AS c
ON mp.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustFirstName, c.CustLastName
),
EntStrengths AS (
SELECT e.EntertainerID, e.EntStageName,
MAX((CASE WHEN es.StyleStrength = 1
THEN es.StyleID
ELSE Null END)) AS FirstStrength,
MAX((CASE WHEN es.StyleStrength = 2
THEN es.StyleID
ELSE Null END)) AS SecondStrength,
MAX((CASE WHEN es.StyleStrength = 3
THEN es.StyleID
ELSE Null END)) AS ThirdStrength
FROM Entertainer_Styles AS es
INNER JOIN Entertainers AS e
ON es.EntertainerID = e.EntertainerID
GROUP BY e.EntertainerID, e.EntStageName
)S
ELECT CustomerID, CustFirstName, CustLastName,
EntertainerID, EntStageName
FROM CustPreferences
CROSS JOIN EntStrengths
WHERE (
FirstPreference = FirstStrength
AND SecondPreference = SecondStrength
) OR (
SecondPreference = FirstStrength
AND FirstPreference = SecondStrength
)
ORDER BY CustomerID;



select max(case dw when 2 then dm end) as Mo,
max(case dw when 3 then dm end) as Tu,
max(case dw when 4 then dm end) as We,
max(case dw when 5 then dm end) as Th,
max(case dw when 6 then dm end) as Fr,
max(case dw when 7 then dm end) as Sa,
max(case dw when 1 then dm end) as Su
from (
select *
 from (
 select cast(date_trunc('month',current_date) as date)+x.id,
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'iw') as wk,
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'dd') as dm,
 cast(
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'d') as integer) as dw,
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'mm') as curr_mth,
 to_char(current_date,'mm') as mth
from generate_series (0,31) x(id)
) x
where mth = curr_mth
) y
group by wk
order by wk


with x (tree,mgr,depth)
as (
select cast(ename as varchar(100)),
mgr, 0
from emp
where ename = 'MILLER'
union all
select cast(x.tree+'-->'+e.ename as varchar(100)),
e.mgr, x.depth+1
 from emp e, x
 where x.mgr = e.empno
 )
 select tree leaf___branch___root
 from x
 where depth = 2


```






