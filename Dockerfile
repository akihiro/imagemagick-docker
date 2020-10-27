FROM buildpack-deps:curl
RUN curl -Lo /ImageMagick.AppImage https://github.com/ImageMagick/ImageMagick/releases/download/7.0.10-34/ImageMagick-c8fef4e-gcc-x86_64.AppImage
RUN chmod +x /ImageMagick.AppImage
RUN /ImageMagick.AppImage --appimage-extract

FROM ubuntu
RUN apt-get update && \
    apt-get install -y libfontconfig1 libx11-6 libharfbuzz0b libfribidi0 && \
    rm -rf -- /var/cache/apt
COPY --from=0 /squashfs-root/ /squashfs-root/
COPY magick /usr/local/bin/
RUN ln -s magick /usr/local/bin/compare \
 && ln -s magick /usr/local/bin/composite \
 && ln -s magick /usr/local/bin/conjure \
 && ln -s magick /usr/local/bin/convert \
 && ln -s magick /usr/local/bin/display \
 && ln -s magick /usr/local/bin/identify \
 && ln -s magick /usr/local/bin/import \
 && ln -s magick /usr/local/bin/magick-script \
 && ln -s magick /usr/local/bin/mogrify \
 && ln -s magick /usr/local/bin/montage \
 && ln -s magick /usr/local/bin/stream
