# docker_cuda_temp  




## Guideline for Printing Jupyter Notebooks  

To ensure a clean and readable printout of a Jupyter Notebook, follow these steps:  

### **Step 1: Format the Notebook with Black**  
Before converting, format the notebook for consistency using `black`:  

```bash
black --line-length 96 <notebook_name>.ipynb
```

This ensures that code lines do not exceed 96 characters, making them easier to read when printed.  

### **Step 2: Convert the Notebook to HTML**  
Use `nbconvert` to export the notebook to an HTML file:  

```bash
python3 -m jupyter nbconvert --to html --template classic <notebook_name>.ipynb
```
or  
```bash
jupyter nbconvert --to html --template classic <notebook_name>.ipynb
```

### **Step 3: Open and Print the HTML File**  
1. Open the generated `.html` file in a web browser.  
2. Use the browser’s print function (`Ctrl + P` or `Cmd + P`) to print or save as a PDF.  

This process ensures well-formatted, easy-to-read outputs for documentation or submission.