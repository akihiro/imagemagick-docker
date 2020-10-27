FROM alpine
RUN wget https://github.com/ImageMagick/ImageMagick/releases/download/7.0.10-34/ImageMagick-c8fef4e-gcc-x86_64.AppImage
RUN chmod +x /ImageMagick-c8fef4e-gcc-x86_64.AppImage

FROM ubuntu
COPY --from=0 /ImageMagick-c8fef4e-gcc-x86_64.AppImage /ImageMagick-c8fef4e-gcc-x86_64.AppImage
RUN /ImageMagick-c8fef4e-gcc-x86_64.AppImage --appimage-extract

RUN apt-get update && \
    apt-get install -y libfontconfig1 libx11-6 libharfbuzz0b libfribidi0 && \
    rm -rf -- /var/cache/apt

ENTRYPOINT /squashfs-root/AppRun
