import pandas as pd

def check_data_types(df, expected_types):
    """
    Check if the DataFrame's column data types match the expected types.

    Parameters:
    - df: Pandas DataFrame to check.
    - expected_types: Dictionary with column names as keys and expected data types as values.

    Returns:
    - True if data types match, False otherwise.
    """
    for column, expected_type in expected_types.items():
        if column not in df.columns:
            print(f"Column {column} not found in DataFrame.")
            return False
        if not pd.api.types.is_dtype_equal(df[column].dtype, expected_type):
            print(f"Data type mismatch in column: {column}. Expected: {expected_type}, Found: {df[column].dtype}")
            return False
    return True

# Example usage
df = pd.read_csv('/home/sid/Desktop/copilot/data/customers.csv')

expected_types = {
    'customer_id': 'int64',
    'first_name': 'object',
    'last_name': 'object',
    'email': 'object',
}

if check_data_types(df, expected_types):
    print("Data types are as expected. Proceed with loading.")
else:
    print("Data type mismatch found. Abort loading.")