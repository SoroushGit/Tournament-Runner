from os import system as Command
import time as Time
c = False
while c == False:
    M = str(input("Major? Y/N "))
    if M == "y" or M == "Y":
        Ms = int(input("Delay mins: ")) * 60
        Ss = int(input("Delay secs: "))
        Command("rcssmonitor --auto-reconnect-mode on --auto-reconnect-wait 2 &")
        total = Ms + Ss
        Time.sleep(total)
        print("Server will run with major setting")
        Command("./MajorTournament.sh")
        c = True
    if M == "n" or M == "N":
        print("Server will run with starter setting")
        Command("./StarterTournament.sh")
        c=True
    else:
        print("Wrong input")

