import time
import os
import socket
import fcntl
import struct
import shutil
import busio
import board
import digitalio
import subprocess
import adafruit_debouncer

from luma.core.interface.serial import spi
from luma.core.render import canvas
from luma.oled.device import ssd1327
from PIL import ImageDraw, ImageFont
from subprocess import call
from adafruit_debouncer import Debouncer

shdnButton = digitalio.DigitalInOut(board.D16)
shdnButton.direction = digitalio.Direction.INPUT
shdnButton.pull = digitalio.Pull.UP
shdnSwitch = Debouncer(shdnButton, interval=0.05)

def getMode():
    return "... running"    

def getIP(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
            s.fileno(),
            0x8915, # SIOCGIFADDR
            struct.pack('256s', ifname[:15].encode('utf-8'))
    )[20:24])
    
def getDU(path):
    total, used, free = shutil.disk_usage(path)
    result = (used * 100.0) / total  
    #print("Total: %d GiB" % (total // (2**30)))
    #print("Used: %d GiB" % (used // (2**30)))
    #print("Free: %d GiB" % (free // (2**30)))
    #print ("used: " + format(result, '.2f') + " %")
    return (format(result, '.2f'))

def getTemperature():
    cpu_temp = os.popen("vcgencmd measure_temp").readline()
    #print(cpu_temp)
    return cpu_temp.replace("temp=", "")

def stats(oled):
    font = ImageFont.load_default()
    font2 = ImageFont.truetype('/usr/share/fonts/truetype/freefont/FreeSans.ttf', 14)
    fonta = ImageFont.truetype('/usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf', 14)
    with canvas(oled) as draw:
        draw.text((2,5), "IP: " + getIP("eth0"), font=font2, fill=255)
        draw.text((2,25), "\uf0a0", font=fonta, fill=255)
        draw.text((20,25), " 1 used: "  + getDU("/srv/dev-disk-by-uuid-9fcac6c9-3b8f-4ef5-b436-393cd4885f42") + " %", font=font2, fill=255)
        draw.text((2,40), "\uf0a0", font=fonta, fill=255)
        draw.text((20,40), " 2 used: "  + getDU("/srv/dev-disk-by-uuid-f28e04d7-f249-474b-9d82-7a51d1853785") + " %", font=font2, fill=255)
        draw.text((2,55), "\uf0a0", font=fonta, fill=255)
        draw.text((20,55), " 3 used: "  + ("--") + " %", font=font2, fill=255)
        draw.text((2,70), "\uf0a0", font=fonta, fill=255)
        draw.text((20,70), " 4 used: "  + ("--") + " %", font=font2, fill=255)
        draw.text((2,90), "\uf2c9", font=fonta, fill=255)
        draw.text((20,90), " " + getTemperature(), font=font2, fill=255)
        draw.text((70,90), "\uf110", font=fonta, fill=255)
        draw.text((85,90), " 50%", font=font2, fill=255)

        if shdnSwitch.value:
            draw.text((2,110), getMode(), font=font2, fill=255)      #Display tex$
        else:
            draw.text((2,110), "..shutting down", font=font2, fill=255)      #Display tex$
            setFan(0x00)
            Shutdown()

def Shutdown():
    print("Shutting Down")                         #Show text in terminal 
    #draw.text((2,110), "Shutting Down", font=font2, fill=255)      #Display text in LCD 
    time.sleep(3)                                  #Sleep 3 seconds
    os.system("sudo shutdown now")                 #Write command


def Reboot():
    print("Rebooting")
    #draw.text((2,110), "Rebooting", font=font2, fill=255)
    time.sleep(3)
    os.system("sudo reboot")


def setFan(percent):
    arg = str(percent)
    rc = call("set-fan.sh '%s'" % arg, shell=True)
def main():

# rev.1 users set port=0
# substitute spi(device=0, port=0) below if using that interface
# substitute bitbang_6800(RS=7, E=8, PINS=[25,24,23,27]) below if using that interface
#serial = i2c(port=1, address=0x3C)
    serial = spi(device=0, port=0)

# substitute ssd1331(...) or sh1106(...) below if using that device

    oled = ssd1327(serial)
    #draw.text((2,110), "Shutting Down", font=font2, fill=255)      #Display tex$

#    i2c = busio.I2C(board.D3, board.D2)
    setFan(0x80)
    shdnButtonState = False

    while True:
        shdnSwitch.update()
        stats(oled)

        #if shdnSwitch.value:
        #    print('not pressed');
        #else:
        #    print('pressed');
        #stats(oled)
        #print(button.value);
        time.sleep(0.5)

    

#IPAddress = os.popen('hostname -I').readlines()

#with canvas(device) as draw:
#    draw.rectangle(device.bounding_box, outline="white", fill="black")
#    #draw.text((20, 40), "Hello World", fill="white")
#    draw.text((3,40), "IP {0}".format(IPAddress), fill="white")
#    print("Ihre IP-Adresse lautet {0}.".format(IPAddress))
#    while (1):
#        time.sleep(10)

if __name__ == "__main__":
    main()
