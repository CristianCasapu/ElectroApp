"""Generează logo-ul ElectroApp (PNG) — panou fotovoltaic, invertor, fișă cu bife, soare.

    python scripts/logo.py

Ieșiri (assets/logo/):
  logo_1024.png       — icon complet (fundal + simbol), pentru README / store
  foreground.png      — stratul adaptiv Android (simbolul, cu margine de siguranță)
  background.png      — stratul adaptiv Android (fundal)
Randare la 4× și reducere cu LANCZOS pentru antialiasing.
"""
from __future__ import annotations

import math
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

S = 4                       # supersampling
N = 1024 * S                # dimensiune de lucru
OUT = Path(__file__).resolve().parent.parent / "assets" / "logo"

# Paleta (din app_theme.dart)
BG_TOP = (18, 89, 195)      # #1259C3 primary
BG_BOT = (7, 40, 96)        # albastru închis
NAVY = (11, 31, 58)         # ramă panou
CELL = (30, 136, 229)       # celulă
CELL_HI = (100, 181, 246)   # reflex celulă
FRAME = (207, 216, 220)     # aluminiu
SUN = (255, 179, 0)
SUN_HI = (255, 213, 79)
CARD = (250, 250, 250)
CARD_LINE = (176, 190, 197)
GREEN = (52, 199, 89)
INV = (55, 71, 79)
INV_HI = (96, 125, 139)
WHITE = (255, 255, 255)


def px(v: float) -> int:
    return int(round(v * S))


def gradient_bg(size: int, radius: int | None) -> Image.Image:
    img = Image.new("RGBA", (size, size), BG_BOT + (255,))
    d = ImageDraw.Draw(img)
    for y in range(size):
        t = y / (size - 1)
        c = tuple(int(BG_TOP[i] * (1 - t) + BG_BOT[i] * t) for i in range(3))
        d.line([(0, y), (size, y)], fill=c + (255,))
    if radius:
        mask = Image.new("L", (size, size), 0)
        ImageDraw.Draw(mask).rounded_rectangle([0, 0, size - 1, size - 1], radius=radius, fill=255)
        img.putalpha(mask)
    return img


def rotated_layer(draw_fn, angle: float, size: int = N) -> Image.Image:
    layer = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw_fn(ImageDraw.Draw(layer))
    return layer.rotate(angle, resample=Image.BICUBIC, center=(size / 2, size / 2))


def shadow(layer: Image.Image, offset: int, blur: int, alpha: int = 110) -> Image.Image:
    a = layer.getchannel("A").point(lambda v: v * alpha // 255)
    sh = Image.new("RGBA", layer.size, (0, 0, 0, 0))
    sh.putalpha(a)
    sh = sh.filter(ImageFilter.GaussianBlur(blur))
    moved = Image.new("RGBA", layer.size, (0, 0, 0, 0))
    moved.paste(sh, (offset, offset))
    return moved


def draw_symbol(scale: float = 1.0, center: tuple[float, float] = (512, 512)) -> Image.Image:
    """Simbolul (fără fundal) pe un canvas transparent N×N, în coordonate 1024."""
    cx, cy = center
    canvas = Image.new("RGBA", (N, N), (0, 0, 0, 0))

    def P(x: float, y: float) -> tuple[int, int]:
        return px(cx + (x - 512) * scale), px(cy + (y - 512) * scale)

    def R(x0, y0, x1, y1):
        return [P(x0, y0), P(x1, y1)]

    # ── Soare (dreapta sus) ──────────────────────────────────────────────────
    sun = Image.new("RGBA", (N, N), (0, 0, 0, 0))
    sd = ImageDraw.Draw(sun)
    sx, sy, sr = 790, 235, 88
    for k in range(12):
        a = k * math.pi / 6
        r0, r1 = sr + 28, sr + 70 if k % 2 == 0 else sr + 52
        sd.line(
            [P(sx + r0 * math.cos(a), sy + r0 * math.sin(a)), P(sx + r1 * math.cos(a), sy + r1 * math.sin(a))],
            fill=SUN + (255,), width=px(16 * scale),
        )
    sd.ellipse(R(sx - sr, sy - sr, sx + sr, sy + sr), fill=SUN + (255,))
    sd.ellipse(R(sx - sr + 22, sy - sr + 22, sx + sr - 34, sy + sr - 34), fill=SUN_HI + (255,))
    canvas.alpha_composite(sun)

    # ── Fișa de lucrare (stânga, în spate) ───────────────────────────────────
    def card(d: ImageDraw.ImageDraw):
        x0, y0, x1, y1 = 150, 250, 470, 700
        d.rounded_rectangle(R(x0, y0, x1, y1), radius=px(28 * scale), fill=CARD + (255,))
        d.rounded_rectangle(R(x0 + 95, y0 - 28, x1 - 95, y0 + 40), radius=px(18 * scale), fill=INV + (255,))
        for i, ok in enumerate([True, True, False]):
            yy = y0 + 120 + i * 120
            bx0, by0 = x0 + 45, yy - 32
            d.rounded_rectangle(R(bx0, by0, bx0 + 64, by0 + 64), radius=px(14 * scale),
                                outline=(GREEN if ok else CARD_LINE) + (255,), width=px(9 * scale),
                                fill=(GREEN if ok else CARD) + (255,))
            if ok:
                d.line([P(bx0 + 14, by0 + 34), P(bx0 + 27, by0 + 48), P(bx0 + 51, by0 + 17)],
                       fill=WHITE + (255,), width=px(9 * scale), joint="curve")
            d.rounded_rectangle(R(bx0 + 92, yy - 12, x1 - 45, yy + 12), radius=px(12 * scale),
                                fill=CARD_LINE + (255,))

    card_layer = rotated_layer(card, 7)
    canvas.alpha_composite(shadow(card_layer, px(10), px(18)))
    canvas.alpha_composite(card_layer)

    # ── Panoul fotovoltaic (centru, în față) ─────────────────────────────────
    def panel(d: ImageDraw.ImageDraw):
        x0, y0, x1, y1 = 300, 330, 760, 790
        d.rounded_rectangle(R(x0, y0, x1, y1), radius=px(30 * scale), fill=FRAME + (255,))
        m = 22
        d.rounded_rectangle(R(x0 + m, y0 + m, x1 - m, y1 - m), radius=px(16 * scale), fill=NAVY + (255,))
        cols, rows, gap = 3, 3, 14
        ix0, iy0, ix1, iy1 = x0 + m + 20, y0 + m + 20, x1 - m - 20, y1 - m - 20
        cw = (ix1 - ix0 - gap * (cols - 1)) / cols
        ch = (iy1 - iy0 - gap * (rows - 1)) / rows
        for r in range(rows):
            for c in range(cols):
                cx0 = ix0 + c * (cw + gap)
                cy0 = iy0 + r * (ch + gap)
                d.rounded_rectangle(R(cx0, cy0, cx0 + cw, cy0 + ch), radius=px(10 * scale), fill=CELL + (255,))
                d.polygon([P(cx0, cy0), P(cx0 + cw * 0.55, cy0), P(cx0, cy0 + ch * 0.55)], fill=CELL_HI + (150,))

    panel_layer = rotated_layer(panel, -6)
    canvas.alpha_composite(shadow(panel_layer, px(14), px(26), 140))
    canvas.alpha_composite(panel_layer)

    # ── Invertorul (dreapta jos) ─────────────────────────────────────────────
    inv = Image.new("RGBA", (N, N), (0, 0, 0, 0))
    d = ImageDraw.Draw(inv)
    x0, y0, x1, y1 = 640, 640, 880, 880
    d.rounded_rectangle(R(x0, y0, x1, y1), radius=px(34 * scale), fill=INV + (255,))
    d.rounded_rectangle(R(x0 + 26, y0 + 26, x1 - 26, y0 + 120), radius=px(18 * scale), fill=INV_HI + (255,))
    d.ellipse(R(x1 - 78, y0 + 50, x1 - 42, y0 + 86), fill=GREEN + (255,))
    for i in range(4):
        d.rounded_rectangle(R(x0 + 36, y0 + 150 + i * 22, x1 - 36, y0 + 158 + i * 22), radius=px(4 * scale),
                            fill=INV_HI + (255,))
    bolt = [(760, 590), (712, 690), (752, 690), (728, 770), (808, 660), (764, 660), (790, 590)]
    d.polygon([P(*p) for p in bolt], fill=SUN_HI + (255,))
    canvas.alpha_composite(shadow(inv, px(10), px(18)))
    canvas.alpha_composite(inv)
    return canvas


def down(img: Image.Image, size: int = 1024) -> Image.Image:
    return img.resize((size, size), Image.LANCZOS)


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)

    # Icon complet (cu colțuri rotunjite) — README, Play, favicon.
    full = gradient_bg(N, radius=px(180))
    full.alpha_composite(draw_symbol(scale=0.92))
    down(full).save(OUT / "logo_1024.png")
    down(full, 512).save(OUT / "logo_512.png")

    # Straturi adaptive Android: simbolul ocupă zona sigură (~66 % din centru).
    fg = draw_symbol(scale=0.66)
    down(fg).save(OUT / "foreground.png")
    down(gradient_bg(N, radius=None)).save(OUT / "background.png")
    print("scris:", *sorted(p.name for p in OUT.iterdir()))


if __name__ == "__main__":
    main()
