import os

head ='''memory_initialization_radix = 16;
memory_initialization_vector =
'''
path_txt = "C:/Users/86152/Desktop/cpu/instr_txt/"
path_coe = "C:/Users/86152/Desktop/cpu/coe/"

files = os.listdir(path_txt)

for file in files:
    content = head
    filePath = path_txt + file
    with open(filePath, encoding='utf-8') as fp:
        content += fp.read()
        fp.close()

    fileName = path_coe + file + '.coe'
    with open(fileName, 'w', encoding='utf-8') as fp:
        fp.write(content)
        fp.close()
