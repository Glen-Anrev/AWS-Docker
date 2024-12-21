# Function to create formulas
def number_to_letter(number):
    """
    Convert a number to its corresponding letter in the alphabet.
    
    Args:
    number (int): The number to convert. 1 maps to 'A', 2 maps to 'B', etc.
    
    Returns:
    str: The corresponding letter. If the number is out of range (1-26), return an error message.
    """
    if 1 <= number <= 26:
        return chr(64 + number)
        
def column_index_to_name(index):
    """
    Function to convert a column index (1-based) to an Excel column name.
    
    Parameters:
    index (int): Column index (1-based)
    
    Returns:
    str: Corresponding Excel column name
    """   
    column_name = ""
    while index > 0:
        index -= 1
        column_name = chr(index % 26 + 65) + column_name
        index //= 26
    return column_name

def get_column_index(df, column_name):
    """
    Function to get the index of a column in a DataFrame by its name.
    
    Parameters:
    df (pd.DataFrame): The DataFrame
    column_name (str): The name of the column
    
    Returns:
    int: Index of the column
    """
    try:
        column_index = df.columns.get_loc(column_name)
        #print (f"{column_name} index is {column_index}")
        return column_index + 1
    except KeyError:
        return f"Column '{column_name}' does not exist in the DataFrame"
    
# Sorting function
def custom_sort_key(main_list, order_list):
    """
    to sort items in a list
    """
    # Separate items that are in the order list
    ordered_items = [item for item in main_list if item in order_list]
    # Separate items that are not in the order list
    unordered_items = sorted([item for item in main_list if item not in order_list])
    
    # Sort ordered_items based on the order_list
    ordered_items.sort(key=lambda x: order_list.index(x))
    
    # Combine the ordered items and unordered items
    return ordered_items + unordered_items