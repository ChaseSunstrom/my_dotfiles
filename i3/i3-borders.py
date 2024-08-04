import i3ipc
import subprocess
import time
import colorsys


def create_border_window(geometry):
    return subprocess.Popen(
        ["xterm", "-class", "BorderWindow", "-into", "0x0", "-geometry", geometry]
    )


def update_border_color(color):
    subprocess.run(
        [
            "xprop",
            "-name",
            "BorderWindow",
            "-f",
            "_NET_WM_WINDOW_OPACITY",
            "32c",
            "-set",
            "_NET_WM_WINDOW_OPACITY",
            f"0x{int(0.5*255):x}",
        ]
    )
    subprocess.run(["xsetroot", "-solid", color])


def get_window_geometry(window):
    rect = window.rect
    return f"{rect.width + 10}x{rect.height + 10}+{rect.x - 5}+{rect.y - 5}"


def cycle_colors():
    hue = 0
    while True:
        rgb = colorsys.hsv_to_rgb(hue, 1.0, 1.0)
        color = "#{:02x}{:02x}{:02x}".format(
            int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255)
        )
        update_border_color(color)
        hue = (hue + 0.01) % 1.0
        time.sleep(0.05)


def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    if focused:
        geometry = get_window_geometry(focused)
        border_window.terminate()
        border_window = create_border_window(geometry)


i3 = i3ipc.Connection()
border_window = create_border_window("1x1+0+0")
i3.on("window::focus", on_window_focus)

import threading

color_thread = threading.Thread(target=cycle_colors)
color_thread.daemon = True
color_thread.start()

i3.main()
