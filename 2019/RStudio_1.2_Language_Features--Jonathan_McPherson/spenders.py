import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Group by customer ID
grouped = r.spending.groupby(["CustomerId", "LastName"])
spenders = grouped.sum().reset_index()

# Create a list of the top spenders
top_spenders = grouped.sum().sort_values("Total", ascending = False).head(5)
top_spenders.reset_index(inplace = True)
print top_spenders

