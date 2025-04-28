# Test Cases
1. ./mygrep.sh hello testfile.txt
![image](https://github.com/user-attachments/assets/09dbebb7-f161-47e5-9831-767efb96d68a)

2. ./mygrep.sh -n hello testfile.txt
![image](https://github.com/user-attachments/assets/d4a9a848-c2a7-4d70-8efc-420f22c03a1e)

3. ./mygrep.sh -vn hello testfile.txt
![image](https://github.com/user-attachments/assets/1c82d7f5-95a7-4014-8725-ea0c41c7490b)

4. ./mygrep.sh -v testfile.txt
![image](https://github.com/user-attachments/assets/dde893c2-aa8d-4c42-9fd5-0571aadc3ca0)

# Reflective Section
## How the script handles arguments and options
The script uses **getopts** to check for -n and -v options and sets flags based on them. After that, it shifts the arguments to get the search word and file indices right. It also checks for mistakes like missing files or wrong order of arguments before starting the search.

## If I added regex or -i/-c/-l options:
I would split the search function into smaller parts. Right now it just checks word by word, but for regex or counting matches, I'd need to match lines, track counts, and handle printing differently based on the option used.

## Hardest part:
The task was easy overall because the functionalities were simple for now. However, if there were more functionalities there will be a need for a more optimization. The hardest part was dealing with argument order and making sure the script didn’t break if options or files were missing or written in a weird way.

## References:
1. https://devhints.io/bash
2. https://kodekloud.com/blog/bash-getopts/
3. https://stackoverflow.com/questions/10929453/read-a-file-line-by-line-assigning-the-value-to-a-variable
4. GitHub Copilot (in debugging)
