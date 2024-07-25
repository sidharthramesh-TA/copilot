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

P 3
Can you please explain recursive WITH clause used in this sql

```

### Python

```

SELECT wp4.postID
, wp4.creationDate
, wp4.numLinkedPosts
FROM (SELECT wp3.*
, dbo.getnumLinkedPosts(wp3.postID) AS numLinkedPosts
FROM (SELECT wp2.postID
, wp2.AcceptedAnswerId
, wp2.AnswerCount
, wp2.Body
, wp2.ClosedDate
, wp2.CommentCount
, wp2.CommunityOwnedDate
, wp2.CreationDate
, wp2.FavoriteCount
, wp2.LastActivityDate
, wp2.LastEditDate
, wp2.LastEditorDisplayName
, wp2.LastEditorUserId
, wp2.OwnerUserId
, wp2.ParentId
, wp2.PostTypeId
, wp2.Score
, wp2.Tags
, wp2.Title
, wp2.ViewCount
, wp2.AboutMe
, wp2.Age
, wp2.UserCreationDate
, wp2.DisplayName
, wp2.DownVotes
, wp2.EmailHash
, wp2.LastAccessDate
, wp2.[Location]
, wp2.Reputation
, wp2.UpVotes
, wp2.[Views]
, wp2.WebsiteUrl
, wp2.AccountId
, wp2.PostType
, wp2.voteType
, wp2.numVotes
, commentUnpivot.commentID
, commentUnpivot.commentCreationDate
, commentUnpivot.commentScore
, commentUnpivot.commentText
, commentUnpivot.commentUserID
FROM (SELECT wp1.postID
, wp1.AcceptedAnswerId
, wp1.AnswerCount
, wp1.Body
, wp1.ClosedDate
, wp1.CommentCount
, wp1.CommunityOwnedDate
, wp1.CreationDate
, wp1.FavoriteCount
, wp1.LastActivityDate
, wp1.LastEditDate
, wp1.LastEditorDisplayName
, wp1.LastEditorUserId
, wp1.OwnerUserId
, wp1.ParentId
, wp1.PostTypeId
, wp1.Score
, wp1.Tags
, wp1.Title
, wp1.ViewCount
, wp1.AboutMe
, wp1.Age
, wp1.UserCreationDate
, wp1.DisplayName
, wp1.DownVotes
, wp1.EmailHash
, wp1.LastAccessDate
, wp1.[Location]
, wp1.Reputation
, wp1.UpVotes
, wp1.[Views]
, wp1.WebsiteUrl
, wp1.AccountId
, wp1.CommentId1
, wp1.CommentCreationDate1
, wp1.CommentScore1
, wp1.CommentText1
, wp1.CommentUserId1
, wp1.CommentId2
, wp1.CommentCreationDate2
, wp1.CommentScore2
, wp1.CommentText2
, wp1.CommentUserId2
, wp1.CommentId3
, wp1.CommentCreationDate3
, wp1.CommentScore3
, wp1.CommentText3
, wp1.CommentUserId3
, wp1.CommentId4
, wp1.CommentCreationDate4
, wp1.CommentScore4
, wp1.CommentText4
, wp1.CommentUserId4
, wp1.CommentId5
, wp1.CommentCreationDate5
, wp1.CommentScore5
, wp1.CommentText5
, wp1.CommentUserId5
, wp1.PostType
, vty.[name] AS VoteType
, COUNT(wp1.voteUser) AS numVotes
FROM (SELECT wp.*
, pt.Type AS PostType
, vt.Userid AS voteUser
FROM (SELECT
p.Id AS postID
, p.AcceptedAnswerId
, p.AnswerCount
, p.Body
, p.ClosedDate
, p.CommentCount
, p.CommunityOwnedDate
, p.CreationDate
, p.FavoriteCount
, p.LastActivityDate
, p.LastEditDate
, p.LastEditorDisplayName
, p.LastEditorUserId
, p.OwnerUserId
, p.ParentId
, p.PostTypeId
, p.Score
, p.Tags
, p.Title
, p.ViewCount
, u.AboutMe
, u.Age
, u.CreationDate AS UserCreationDate
, u.DisplayName
, u.DownVotes
, u.EmailHash
, u.LastAccessDate
, u.Location
, u.Reputation
, u.UpVotes
, u.Views
, u.WebsiteUrl
, u.AccountId
, c.CommentId1
, c.CommentCreationDate1
, c.CommentScore1
, c.CommentText1
, c.CommentUserId1
, c.CommentId2
, c.CommentCreationDate2
, c.CommentScore2
, c.CommentText2
, c.CommentUserId2
, c.CommentCreationDate3
, c.CommentScore3
, c.CommentText3
, c.CommentUserId3
, c.CommentId4
, c.CommentCreationDate4
, c.CommentScore4
, c.CommentText4
, c.CommentUserId4
, c.CommentId5
, c.CommentCreationDate5
, c.CommentScore5
, c.CommentText5
, c.CommentUserId5
FROM dbo.Posts p
INNER JOIN dbo.Users u ON p.OwnerUserId = u.Id
OUTER APPLY (SELECT coms.PostId
, MAX(CASE WHEN theRowNum = 1 THEN coms.Id ELSE NULL END) AS
CommentId1
, MAX(CASE WHEN theRowNum = 1 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate1
, MAX(CASE WHEN theRowNum = 1 THEN coms.Score ELSE NULL END) AS
CommentScore1
, MAX(CASE WHEN theRowNum = 1 THEN coms.[Text] ELSE NULL END)
AS CommentText1
, MAX(CASE WHEN theRowNum = 1 THEN coms.UserId ELSE NULL END)
AS CommentUserID1
, MAX(CASE WHEN theRowNum = 2 THEN coms.Id ELSE NULL END) AS
CommentId2
, MAX(CASE WHEN theRowNum = 2 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate2
, MAX(CASE WHEN theRowNum = 2 THEN coms.Score ELSE NULL END) AS
CommentScore2
, MAX(CASE WHEN theRowNum = 2 THEN coms.[Text] ELSE NULL END)
AS CommentText2
, MAX(CASE WHEN theRowNum = 2 THEN coms.UserId ELSE NULL END)
AS CommentUserID2
, MAX(CASE WHEN theRowNum = 3 THEN coms.Id ELSE NULL END) AS
CommentId3
, MAX(CASE WHEN theRowNum = 3 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate3
, MAX(CASE WHEN theRowNum = 3 THEN coms.Score ELSE NULL END) AS
CommentScore3
, MAX(CASE WHEN theRowNum = 3 THEN coms.[Text] ELSE NULL END)
AS CommentText3
, MAX(CASE WHEN theRowNum = 3 THEN coms.UserId ELSE NULL END)
AS CommentUserID3
, MAX(CASE WHEN theRowNum = 4 THEN coms.Id ELSE NULL END) AS
CommentId4
, MAX(CASE WHEN theRowNum = 4 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate4
, MAX(CASE WHEN theRowNum = 4 THEN coms.Score ELSE NULL END) AS
CommentScore4
, MAX(CASE WHEN theRowNum = 4 THEN coms.[Text] ELSE NULL END)
AS CommentText4
, MAX(CASE WHEN theRowNum = 4 THEN coms.UserId ELSE NULL END)
AS CommentUserID4
, MAX(CASE WHEN theRowNum = 5 THEN coms.Id ELSE NULL END) AS
CommentId5
, MAX(CASE WHEN theRowNum = 5 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate5
, MAX(CASE WHEN theRowNum = 5 THEN coms.Score ELSE NULL END) AS
CommentScore5
, MAX(CASE WHEN theRowNum = 5 THEN coms.[Text] ELSE NULL END)
AS CommentText5
, MAX(CASE WHEN theRowNum = 5 THEN coms.UserId ELSE NULL END)
AS CommentUserID5
FROM (SELECT Id
, CreationDate
, Score
, [Text]
, UserId
, PostId
, ROW_NUMBER() OVER (PARTITION BY PostId ORDER BY
CreationDate) AS theRowNum
FROM dbo.comments com
WHERE com.postID = p.Id) coms
WHERE coms.theRowNum <= 5
GROUP BY coms.PostId) c
) wp --WidePostsCh4
INNER JOIN dbo.PostTypes pt ON wp.PostTypeID = pt.Id
INNER JOIN dbo.Votes vt ON vt.PostId = wp.PostID) wp1
INNER JOIN dbo.Votes vt ON vt.PostId = wp1.PostID
INNER JOIN dbo.VoteTypes vty ON vt.VoteTypeId = vty.Id
WHERE wp1.voteUser = vt.UserId
GROUP BY wp1.postID
, wp1.AcceptedAnswerId
, wp1.AnswerCount
, wp1.Body
, wp1.ClosedDate
, wp1.CommentCount
, wp1.CommunityOwnedDate
, wp1.CreationDate
, wp1.FavoriteCount
, wp1.LastActivityDate
, wp1.LastEditDate
, wp1.LastEditorDisplayName
, wp1.LastEditorUserId
, wp1.OwnerUserId
, wp1.ParentId
, wp1.PostTypeId
, wp1.Score
, wp1.Tags
, wp1.Title
, wp1.ViewCount
, wp1.AboutMe
, wp1.Age
, wp1.UserCreationDate
, wp1.DisplayName
, wp1.DownVotes
, wp1.EmailHash
, wp1.LastAccessDate
, wp1.[Location]
, wp1.Reputation
, wp1.UpVotes
, wp1.[Views]
, wp1.WebsiteUrl
, wp1.AccountId
, wp1.CommentId1
, wp1.CommentCreationDate1
, wp1.CommentScore1
, wp1.CommentText1
, wp1.CommentUserId1
, wp1.CommentId2
, wp1.CommentCreationDate2
, wp1.CommentScore2
, wp1.CommentText2
, wp1.CommentUserId2
, wp1.CommentId3
, wp1.CommentCreationDate3
, wp1.CommentScore3
, wp1.CommentText3
, wp1.CommentUserId3
, wp1.CommentId4
, wp1.CommentCreationDate4
, wp1.CommentScore4
, wp1.CommentText4
, wp1.CommentUserId4
, wp1.CommentId5
, wp1.CommentCreationDate5
, wp1.CommentScore5
, wp1.CommentText5
, wp1.CommentUserId5
, wp1.PostType
, vt.VoteTypeID
, vty.[Name]
) wp2 --WidePostsPlusTwo
INNER JOIN (SELECT CommentID1 AS commentID
, CommentCreationDate1 AS commentCreationDate
, CommentScore1 AS commentScore
, CommentText1 AS commentText
, CommentUserID1 AS commentUserID
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID2
, CommentCreationDate2
, CommentScore2
, CommentText2
, CommentUserID2
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID3
, CommentCreationDate3
, CommentScore3
, CommentText3
, CommentUserID3
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID4
, CommentCreationDate4
, CommentScore4
, CommentText4
, CommentUserID4
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID5
, CommentCreationDate5
, CommentScore5
, CommentText5
, CommentUserID5
, PostID
FROM dbo.WidePostsPlusTwo) commentUnpivot
ON wp2.postID = commentUnpivot.postID
) wp3 --WidePostsPlusThree
WHERE wp3.commentID IS NOT NULL
) wp4 --WidePostsPlusFour
WHERE wp4.creationDate >='20120801'
AND wp4.creationDate < '20180901';

```





