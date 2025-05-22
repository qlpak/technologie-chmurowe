import platform

os_name = platform.system()

if os_name == "Windows":
    print("siema Windowsiaku")
elif os_name == "Linux":
    print("siema Linuxiarzu")
else:
    print(f"siema userze {os_name}!")