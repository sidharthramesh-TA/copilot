# Exploring Github Copilot with DE examples

Copilot is a Large Language Model (LLM) which is fine tuned by Github to provide Code examples and developer support. Its interesting because Github being the developer friendly website has software development data from developers worldwide and that was used to fintetune Microsoft's LLM to give Github Copilot the wisdom of global software development to make a sort of ChatGPT for developers. As the audience here must have invariably interacted with ChatGPT if not directly with Copilot, we are plunging straight into Copilot without delving on how LLMs work or finetuning of LLMs. 


# Installation

To get started we would need 

1. Visual Studio Code Application
2. Github Copilot - This is a paid extension and will require you to put in pay information
3. Github Copilot Chat - This extension allows us to interact with Copilot like ChatGPT

Github Copilot offers a 30 day trial and after that is priced at 10$/month

# Prompts

With prompts **Context is King**. The more context user provides makes it easier for the LLM to get the right type of attention from the regressed data that it has got, allowing it to produce a wellformed in-context output

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

    Initial Prompt: "Write a function to check if a number is prime."
    Refined Prompt: "Write a Python function to check if a number is prime. The function should return 'True' for prime numbers and 'False' for non-prime numbers. Optimize it to handle large numbers efficiently."

Notice majority of prompting is context driven action oriented sentences, the more verbose instruction you give to CoPilot, the better its output. For Data Engineering use cases the context provided should include Data Formats, source and target table formats and steps involved for programming logic 






