#!/usr/bin/env python3
"""
Genera el codigo QR de una tienda y lo deja listo para compartir por WhatsApp.
Uso: qr_tienda.py <url> <archivo_salida.png> [etiqueta]
"""
import sys, os

def install():
    import subprocess
    subprocess.run(["/opt/oci/bin/pip", "install", "--quiet", "qrcode", "pillow"], check=False)

def main():
    url = sys.argv[1] if len(sys.argv) > 1 else "http://149.130.190.118/tienda.html"
    salida = sys.argv[2] if len(sys.argv) > 2 else "/tmp/qr.png"
    etiqueta = sys.argv[3] if len(sys.argv) > 3 else "MARKETATTACK"
    try:
        import qrcode
    except ImportError:
        install()
        import qrcode
    img = qrcode.make(url)
    # etiqueta abajo
    try:
        from PIL import Image, ImageDraw, ImageFont
        W, H = img.size
        canvas = Image.new("RGB", (W, H + 90), "white")
        canvas.paste(img, (0, 0))
        d = ImageDraw.Draw(canvas)
        try:
            fuente = ImageFont.truetype(
                "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 38)
        except Exception:
            fuente = ImageFont.load_default()
        d.text((W // 2, H + 45), etiqueta, fill="black", anchor="mm", font=fuente)
        canvas.save(salida)
    except Exception:
        img.save(salida)
    print(salida)

if __name__ == "__main__":
    main()
