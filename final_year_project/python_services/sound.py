import pygame.mixer
from time import sleep
import random as r
def sound():
    pygame.mixer.init()
    sounds=["./sounds/hackscream_boost.mp3","./sounds/10khzsine.mp3","./sounds/hackscream_boost.mp3","./sounds/10khzsine.mp3"]
    s=r.choice(sounds)
    print(s)
    pygame.mixer.music.load(open(s,"rb"))
    print("")
    pygame.mixer.music.play()
    while pygame.mixer.music.get_busy():
        sleep(1)
    print("\n\t\t\tSound done\n")
