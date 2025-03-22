#!/bin/bash

VOLUME_NAME="nginx_data"
ARCHIVE_NAME="${VOLUME_NAME}.tar"
ENCRYPTED_ARCHIVE="${ARCHIVE_NAME}.gpg"
DECRYPTED_ARCHIVE="decrypted_${ARCHIVE_NAME}"
EXTRACT_DIR="./${VOLUME_NAME}_extracted"

echo "Tworzenie archiwum z wolumenu $VOLUME_NAME..."
docker run --rm -v ${VOLUME_NAME}:/volume -v $(pwd):/backup alpine \
  tar -cvf /backup/$ARCHIVE_NAME -C /volume .

echo "Szyfrowanie archiwum..."
gpg --symmetric --cipher-algo AES256 $ARCHIVE_NAME

rm -f $ARCHIVE_NAME
echo "Zaszyfrowano do pliku: $ENCRYPTED_ARCHIVE"

read -p "Czy chcesz odszyfrować plik? (t/n): " confirm
if [[ $confirm == "t" || $confirm == "T" ]]; then
  echo "Odszyfrowywanie archiwum..."
  gpg --output $DECRYPTED_ARCHIVE --decrypt $ENCRYPTED_ARCHIVE

  echo "Rozpakowywanie do katalogu: $EXTRACT_DIR"
  mkdir -p $EXTRACT_DIR
  tar -xvf $DECRYPTED_ARCHIVE -C $EXTRACT_DIR

  rm -f $DECRYPTED_ARCHIVE
fi
