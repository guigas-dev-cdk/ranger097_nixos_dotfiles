import os
import subprocess

toggle_file = "/home/ranger/ranger097_nixos_dotfiles/Python/theme_switcher/toggle.txt"
wallpaper_directory = os.listdir("/home/ranger/ranger097_nixos_dotfiles/wallpapers/wallpapers")
num_of_wallpapers = len(wallpaper_directory)

with open(toggle_file, 'r') as f:
    x = int(f.readline().strip())
    
with open(toggle_file, 'w') as f:
    y = (x + 1) % (num_of_wallpapers + 1)
    full_file = f.write(str(y))

cat_string_file = "/home/ranger/ranger097_nixos_dotfiles/wallpapers/wallpapers/" + wallpaper_directory[x]
subprocess.run(["wal", "-i", cat_string_file])
subprocess.run([
"swww", "img", cat_string_file,
"--transition-type", "grow",
"--transition-step", "90",
"--transition-fps", "50"
])
subprocess.run(["cd", "~/ranger097_nixos_dotfiles"])
subprocess.run(["git", "add", ".", "&>", "/dev/null"])
subprocess.run(["sudo", "nixos-rebuild", "switch", "--flake", ".#jirachi"])
subprocess.run(["hyprctl","reload"])
subprocess.run(["pkill", "waybar"])
subprocess.run(["nohup", "waybar", "-c", "~/.config/waybar/top.jsonc", "-s", "~/.config/waybar/top.css", ">", "/dev/null", "2>&1", "&"])
subprocess.run(["nohup", "waybar", "-c", "~/.config/waybar/bottom.jsonc", "-s", "~/.config/waybar/bottom.css", ">", "/dev/null", "2>&1", "&"])
subprocess.run(["disallow", "&>", "/dev/null"])