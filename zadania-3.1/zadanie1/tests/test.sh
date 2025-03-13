#!/bin/bash

echo "test dostepnosci strony"
if curl -s http://localhost:8080 | grep -q "this is nginx page."; then
    echo "test passed"
    exit 0
else
    echo "there goes an error"
    exit 1
fi
